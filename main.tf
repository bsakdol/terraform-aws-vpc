locals {
  # Determine whether or not Elastic IPs should be created for the NAT Gateways.
  # TODO: Expand the module to allow EIPs to be reused with NAT Gateways
  create_nat_eips = var.manage_vpc && length(var.private_subnets) > 0 && length(var.public_subnets) > 0

  # Shorten some of the resource conditionals by converting them to locals
  manage_internal_subnets = var.manage_vpc && length(var.internal_subnets) > 0
  manage_private_subnets  = var.manage_vpc && length(var.private_subnets) > 0
  manage_public_subnets   = var.manage_vpc && length(var.public_subnets) > 0

  # One NAT Gateway will be created for each availability zone. This is also
  # used to determine how many route tables to create in order to achive HA.
  nat_gw_azs = distinct([for k, v in var.private_subnets : v.availability_zone])

  # Use `local.vpc_id`, instead of `aws_vpc.this[0].id` to ensure the subnets
  # associated with the secondary CIDR blocks are deleted prior to Terraform
  # attempting to delete the secondary CIDR block.
  vpc_id = try(
    element(aws_vpc_ipv4_cidr_block_association.this.*.vpc_id, 0),
    element(aws_vpc.this.*.id, 0),
    null
  )
}

################################################################################
## VPC                                                                        ##
################################################################################
resource "aws_vpc" "this" {
  count = var.manage_vpc ? 1 : 0

  cidr_block                     = var.cidr_block
  enable_classiclink             = var.enable_classiclink
  enable_classiclink_dns_support = var.enable_classiclink_dns_support
  enable_dns_hostnames           = var.enable_dns_hostnames
  enable_dns_support             = var.enable_dns_support
  instance_tenancy               = var.instance_tenancy

  tags = merge(
    var.tags,
    {
      "Name" = var.name
    },
    var.vpc_tags
  )
}

################################################################################
## SECONDARY CIDR BLOCK ASSOCIATIONS                                          ##
################################################################################
resource "aws_vpc_ipv4_cidr_block_association" "this" {
  for_each = var.manage_vpc && length(var.vpc_ipv4_cidr_block_associations) > 0 ? var.vpc_ipv4_cidr_block_associations : {}

  # This should not be `local.vpc_id` to avoid a circular reference
  vpc_id = element(aws_vpc.this.*.id, 0)

  cidr_block          = try(each.value.ipv4_cidr_block, null)
  ipv4_ipam_pool_id   = try(each.value.ipv4_ipam_pool_id, null)
  ipv4_netmask_length = try(each.value.ipv4_netmask_length, null)

  timeouts {
    create = try(each.value.timeouts.create, null)
    delete = try(each.value.timeouts.delete, null)
  }
}

################################################################################
## DHCP OPTIONS SET                                                           ##
################################################################################
resource "aws_vpc_dhcp_options" "this" {
  count = var.manage_vpc && length(var.dhcp_options) > 0 ? 1 : 0

  domain_name          = lookup(var.dhcp_options, "domain_name", null)
  domain_name_servers  = lookup(var.dhcp_options, "domain_name_servers", null)
  netbios_name_servers = lookup(var.dhcp_options, "netbios_name_servers", null)
  netbios_node_type    = lookup(var.dhcp_options, "netbios_node_type", null)
  ntp_servers          = lookup(var.dhcp_options, "ntp_servers", null)

  tags = merge(
    var.tags,
    {
      "Name" = var.name
    },
    var.dhcp_options_tags
  )
}

resource "aws_vpc_dhcp_options_association" "this" {
  count = var.manage_vpc && length(var.dhcp_options) > 0 ? 1 : 0

  dhcp_options_id = element(aws_vpc_dhcp_options.this.*.id, 0)
  vpc_id          = local.vpc_id
}

################################################################################
## INTERNET GATEWAY                                                           ##
################################################################################
resource "aws_internet_gateway" "this" {
  count = var.manage_vpc && length(var.public_subnets) > 0 ? 1 : 0

  tags = merge(
    var.tags,
    {
      "Name" = var.name
    },
    var.igw_tags
  )
}

resource "aws_internet_gateway_attachment" "this" {
  count = var.manage_vpc && length(var.public_subnets) > 0 ? 1 : 0

  internet_gateway_id = element(aws_internet_gateway.this.*.id, 0)
  vpc_id              = local.vpc_id

}

resource "aws_route" "public_igw" {
  count = local.manage_public_subnets ? 1 : 0

  route_table_id = element(aws_route_table.public.*.id, 0)

  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = element(aws_internet_gateway.this.*.id, 0)
}

################################################################################
## SUBNETS                                                                    ##
################################################################################
resource "aws_subnet" "internal" {
  for_each = local.manage_internal_subnets ? var.internal_subnets : {}

  vpc_id = local.vpc_id

  availability_zone = each.value.availability_zone
  cidr_block        = each.key

  tags = merge(
    var.tags,
    {
      "Name" = "${var.name}-${lower(replace(each.value.availability_zone, "-", ""))}-internal"
    },
    var.internal_subnets_tags
  )
}

resource "aws_subnet" "private" {
  for_each = local.manage_private_subnets ? var.private_subnets : {}

  vpc_id = local.vpc_id

  availability_zone = each.value.availability_zone
  cidr_block        = each.key

  tags = merge(
    var.tags,
    {
      "Name" = "${var.name}-${lower(replace(each.value.availability_zone, "-", ""))}-private"
    },
    var.private_subnets_tags
  )
}

resource "aws_subnet" "public" {
  for_each = local.manage_public_subnets ? var.public_subnets : {}

  vpc_id = local.vpc_id

  availability_zone       = each.value.availability_zone
  cidr_block              = each.key
  map_public_ip_on_launch = true

  tags = merge(
    var.tags,
    {
      "Name" = "${var.name}-${lower(replace(each.value.availability_zone, "-", ""))}-public"
    },
    var.public_subnets_tags
  )
}

################################################################################
## ROUTE TABLES                                                               ##
################################################################################
resource "aws_route_table" "internal" {
  count = local.manage_internal_subnets ? 1 : 0

  vpc_id = local.vpc_id

  tags = merge(
    var.tags,
    {
      "Name" = "${var.name}-internal"
    },
    var.internal_route_table_tags
  )
}

resource "aws_route_table" "private" {
  for_each = local.manage_private_subnets ? toset(local.nat_gw_azs) : []

  vpc_id = local.vpc_id

  tags = merge(
    var.tags,
    {
      "Name" = "${var.name}-${lower(replace(each.key, "-", ""))}-private"
    },
    var.private_route_table_tags
  )
}

resource "aws_route_table" "public" {
  count = local.manage_public_subnets ? 1 : 0

  vpc_id = local.vpc_id

  tags = merge(
    var.tags,
    {
      "Name" = "${var.name}-public"
    },
    var.public_route_table_tags
  )
}

################################################################################
## ROUTE TABLE ASSOCIATIONS                                                   ##
################################################################################
resource "aws_route_table_association" "internal" {
  for_each = local.manage_internal_subnets ? var.internal_subnets : {}

  route_table_id = element(aws_route_table.internal.*.id, 0)

  subnet_id = aws_subnet.internal[each.key].id
}

resource "aws_route_table_association" "private" {
  for_each = local.manage_private_subnets ? var.private_subnets : {}

  route_table_id = aws_route_table.private[each.value.availability_zone].id

  subnet_id = aws_subnet.private[each.key].id
}

resource "aws_route_table_association" "public" {
  for_each = local.manage_public_subnets ? var.public_subnets : {}

  route_table_id = element(aws_route_table.public.*.id, 0)

  subnet_id = aws_subnet.public[each.key].id
}

################################################################################
## NAT GATEWAY                                                                ##
## Create one per unique availability zone for high availability              ##
################################################################################
resource "aws_eip" "nat" {
  for_each = local.create_nat_eips ? toset(local.nat_gw_azs) : []

  vpc = true

  tags = merge(
    var.tags,
    {
      "Name" = "${var.name}-${each.key}-nat"
    },
    var.eip_nat_tags
  )

  depends_on = [aws_internet_gateway.this]
}

resource "aws_nat_gateway" "this" {
  for_each = { for k, v in var.public_subnets : k => v if local.manage_private_subnets && local.manage_public_subnets && v.create_nat_gateway == true }

  subnet_id = aws_subnet.public[each.key].id

  allocation_id = aws_eip.nat[each.value.availability_zone].id

  tags = merge(
    var.tags,
    {
      "Name" = "${var.name}-${each.value.availability_zone}"
    },
    var.nat_gateway_tags
  )

  depends_on = [aws_internet_gateway.this]
}

resource "aws_route" "private_nat_gw" {
  for_each = { for k, v in var.public_subnets : k => v if local.manage_private_subnets && local.manage_public_subnets && v.create_nat_gateway == true }

  route_table_id = aws_route_table.private[each.value.availability_zone].id

  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.this[each.key].id
}

################################################################################
## NETWORK ACLs                                                               ##
################################################################################
resource "aws_network_acl" "internal" {
  count = local.manage_internal_subnets ? 1 : 0

  vpc_id = local.vpc_id

  subnet_ids = [for k, v in var.internal_subnets : aws_subnet.internal[k].id]

  tags = merge(
    var.tags,
    {
      "Name" = "${var.name}-internal"
    },
    var.network_acl_internal_tags
  )
}

resource "aws_network_acl" "private" {
  count = local.manage_private_subnets ? 1 : 0

  vpc_id = local.vpc_id

  subnet_ids = [for k, v in var.private_subnets : aws_subnet.private[k].id]

  tags = merge(
    var.tags,
    {
      "Name" = "${var.name}-private"
    },
    var.network_acl_private_tags
  )
}

resource "aws_network_acl" "public" {
  count = local.manage_public_subnets ? 1 : 0

  vpc_id = local.vpc_id

  subnet_ids = [for k, v in var.public_subnets : aws_subnet.public[k].id]

  tags = merge(
    var.tags,
    {
      "Name" = "${var.name}-public"
    },
    var.network_acl_public_tags
  )
}

################################################################################
## NETWORK ACL RULES                                                          ##
################################################################################
resource "aws_network_acl_rule" "internal_ingress" {
  for_each = { for k, v in var.network_acl_internal_ingress : k => v if local.manage_internal_subnets }

  network_acl_id = element(aws_network_acl.internal.*.id, 0)
  protocol       = each.value.protocol
  rule_action    = each.value.rule_action
  rule_number    = each.key

  cidr_block = try(each.value.cidr_block, null)
  egress     = false
  from_port  = try(each.value.from_port, null)
  icmp_code  = try(each.value.icmp_code, null)
  icmp_type  = try(each.value.icmp_type, null)
  to_port    = try(each.value.to_port, null)
}

resource "aws_network_acl_rule" "internal_egress" {
  for_each = { for k, v in var.network_acl_internal_egress : k => v if local.manage_internal_subnets }

  network_acl_id = element(aws_network_acl.internal.*.id, 0)
  protocol       = each.value.protocol
  rule_action    = each.value.rule_action
  rule_number    = each.key

  cidr_block = try(each.value.cidr_block, null)
  egress     = true
  from_port  = try(each.value.from_port, null)
  icmp_code  = try(each.value.icmp_code, null)
  icmp_type  = try(each.value.icmp_type, null)
  to_port    = try(each.value.to_port, null)
}

resource "aws_network_acl_rule" "private_ingress" {
  for_each = { for k, v in var.network_acl_private_ingress : k => v if local.manage_private_subnets }

  network_acl_id = element(aws_network_acl.private.*.id, 0)
  protocol       = each.value.protocol
  rule_action    = each.value.rule_action
  rule_number    = each.key

  cidr_block = try(each.value.cidr_block, null)
  egress     = false
  from_port  = try(each.value.from_port, null)
  icmp_code  = try(each.value.icmp_code, null)
  icmp_type  = try(each.value.icmp_type, null)
  to_port    = try(each.value.to_port, null)
}

resource "aws_network_acl_rule" "private_egress" {
  for_each = { for k, v in var.network_acl_private_egress : k => v if local.manage_private_subnets }

  network_acl_id = element(aws_network_acl.private.*.id, 0)
  protocol       = each.value.protocol
  rule_action    = each.value.rule_action
  rule_number    = each.key

  cidr_block = try(each.value.cidr_block, null)
  egress     = true
  from_port  = try(each.value.from_port, null)
  icmp_code  = try(each.value.icmp_code, null)
  icmp_type  = try(each.value.icmp_type, null)
  to_port    = try(each.value.to_port, null)
}

resource "aws_network_acl_rule" "public_ingress" {
  for_each = { for k, v in var.network_acl_public_ingress : k => v if local.manage_public_subnets }

  network_acl_id = element(aws_network_acl.public.*.id, 0)
  protocol       = each.value.protocol
  rule_action    = each.value.rule_action
  rule_number    = each.key

  cidr_block = try(each.value.cidr_block, null)
  egress     = false
  from_port  = try(each.value.from_port, null)
  icmp_code  = try(each.value.icmp_code, null)
  icmp_type  = try(each.value.icmp_type, null)
  to_port    = try(each.value.to_port, null)
}

resource "aws_network_acl_rule" "public_egress" {
  for_each = { for k, v in var.network_acl_public_egress : k => v if local.manage_public_subnets }

  network_acl_id = element(aws_network_acl.public.*.id, 0)
  protocol       = each.value.protocol
  rule_action    = each.value.rule_action
  rule_number    = each.key

  cidr_block = try(each.value.cidr_block, null)
  egress     = true
  from_port  = try(each.value.from_port, null)
  icmp_code  = try(each.value.icmp_code, null)
  icmp_type  = try(each.value.icmp_type, null)
  to_port    = try(each.value.to_port, null)
}
