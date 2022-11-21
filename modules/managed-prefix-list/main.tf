################################################################################
## MANAGED PREFIX LIST                                                        ##
################################################################################
resource "aws_ec2_managed_prefix_list" "this" {
  for_each = { for x in var.managed_prefix_lists : x.name => x }

  address_family = try(each.value["address_family"], "IPv4")
  max_entries    = each.value["max_entries"]
  name           = each.key

  tags = merge(
    var.tags,
    var.managed_prefix_list_tags,
    each.value["tags"]
  )
}

################################################################################
## MANAGED PREFIX LIST ENTRIES                                                ##
################################################################################
resource "aws_ec2_managed_prefix_list_entry" "this" {
  for_each = merge([
    for x in var.managed_prefix_lists : {
      for y in x["cidr_blocks"] : format("%v-%v", x["name"], y) => {
        "name"        = x["name"]
        "cidr"        = y
        "description" = try(x["description"], "Terraform managed prefix list entry")
      }
    }
  ]...)

  cidr           = each.value["cidr"]
  prefix_list_id = aws_ec2_managed_prefix_list.this[each.value["name"]].id

  description = try(each.value["description"], null)
}

# TODO: Run tests, finish it off
