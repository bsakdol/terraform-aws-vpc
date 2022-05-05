data "aws_vpc_endpoint_service" "this" {
  for_each = { for k, v in var.endpoints : k => v if length(var.endpoints) > 0 }

  service      = try(each.value.service, each.key, null)
  service_name = try(each.value.service_name, null)

  filter {
    name   = "service-type"
    values = [try(each.value.vpc_endpoint_type, "Interface")]
  }
}

################################################################################
## VPC ENDPOINTS                                                              ##
################################################################################
resource "aws_vpc_endpoint" "this" {
  for_each = { for k, v in var.endpoints : k => v if length(var.endpoints) > 0 }

  service_name = data.aws_vpc_endpoint_service.this[each.key].service_name
  vpc_id       = var.vpc_id

  auto_accept         = try(each.value.auto_accept, null)
  policy              = try(each.value.policy, var.endpoint_defaults.policy, null)
  private_dns_enabled = try(each.value.vpc_endpoint_type, "Interface") == "Interface" ? try(each.value.private_dns_enabled, var.endpoint_defaults.private_dns_enabled, null) : null
  route_table_ids     = try(each.value.vpc_endpoint_type, "Interface") == "Gateway" ? try(each.value.route_table_ids, var.endpoint_defaults.route_table_ids, null) : null
  security_group_ids  = try(each.value.vpc_endpoint_type, "Interface") == "Interface" ? try(each.value.security_group_ids, var.endpoint_defaults.security_group_ids, []) : null
  subnet_ids          = try(each.value.vpc_endpoint_type, "Interface") == "Interface" ? try(each.value.subnet_ids, var.endpoint_defaults.subnet_ids, []) : null
  vpc_endpoint_type   = try(each.value.vpc_endpoint_type, "Interface")


  tags = merge(
    var.tags,
    {
      "Name" = "${data.aws_vpc_endpoint_service.this[each.key].service}-vpc-endpoint"
    },
    try(each.value.tags, {})
  )

  timeouts {
    create = try(each.value.create, var.endpoint_defaults.timeouts.create, null)
    delete = try(each.value.delete, var.endpoint_defaults.timeouts.delete, null)
    update = try(each.value.update, var.endpoint_defaults.timeouts.update, null)
  }
}
