# AWS VPC Managed Prefix List Terraform Sub-Module

Terraform sub-module for managing AWS VPC managed prefix lists.

## Usage

**IMPORTANT NOTE:** The `main` branch is used as the module source for the usage examples, in place of the version. It is important to pin the release tag (e.g. `?ref=tags/x.y.z`) for the module to the source, when using any portion of this module to provision resources. The `main` branch may contain undocumented breaking changes.

```hcl
module "vpc" {
  source = "https://github.com/bsakdol/terraform-aws-vpc//modules/managed-prefix-list?ref=main"

  managed_prefix_lists = [
    {
      "name"           = "rfc-1918-1"
      "address_family" = "IPv4"
      "max_entries"    = 2
      "cidr_blocks"    = ["10.0.0.0/8", "172.16.0.0/12"]
    },
    {
      "name"           = "rfc-1918-2"
      "address_family" = "IPv4"
      "max_entries"    = 1
      "cidr_blocks"    = ["192.168.0.0/16"]
    },
  ]

  tags = {
    Environment = "development"
    Owner       = "bsakdol"
  }
}
```

## Examples

- [Complete](../../examples/managed-prefix-list/)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.8 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.8 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ec2_managed_prefix_list.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_managed_prefix_list) | resource |
| [aws_ec2_managed_prefix_list_entry.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_managed_prefix_list_entry) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_managed_prefix_list_tags"></a> [managed\_prefix\_list\_tags](#input\_managed\_prefix\_list\_tags) | A map of tags to assign to the managed prefix list resource. Resource<br>specific tags will override less specific tags. | `map(string)` | `{}` | no |
| <a name="input_managed_prefix_lists"></a> [managed\_prefix\_lists](#input\_managed\_prefix\_lists) | The managed prefix lists to be configured for the region. This map contains<br>all the attributes necessary for provisioning. For additional details about<br>the individual attributes, see the Terraform documentation for the<br>`aws_ec2_managed_prefix_list` and `aws_ec2_managed_prefix_list_entry` resources. | <pre>list(object({<br>    address_family = optional(string)<br>    cidr_blocks    = list(string)<br>    description    = optional(string)<br>    max_entries    = number<br>    name           = string<br>    tags           = optional(map(string))<br>  }))</pre> | <pre>[<br>  {<br>    "address_family": "IPv4",<br>    "cidr_blocks": [],<br>    "description": null,<br>    "max_entries": null,<br>    "name": null,<br>    "tags": {}<br>  }<br>]</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the resource. If configured with a provider<br>`default_tags` configuration block present, tags with matching keys will<br>overwrite those defined at the provider-level. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_managed_prefix_list_all"></a> [managed\_prefix\_list\_all](#output\_managed\_prefix\_list\_all) | All the attributes for the provisioned managed prefix lists. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
