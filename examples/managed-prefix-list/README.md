# Managed Prefix List Example

This module builds two managed prefix lists in the `US-East-2` region of AWS.

## Usage

To provision the environment in this example, the following commands will need to be executed:

```hcl
terraform init
terraform apply
```

When resources are no longer being used, run the following command to destroy them:

```hcl
terraform destroy
```

_NOTE: Resources in this example may cost money, so it is important to understand AWS pricing prior to provisioning._

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.8 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vpc_endpoints"></a> [vpc\_endpoints](#module\_vpc\_endpoints) | ../../modules/managed-prefix-list | n/a |

## Resources

No resources.

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_managed_prefix_list_all"></a> [managed\_prefix\_list\_all](#output\_managed\_prefix\_list\_all) | All the attributes for the provisioned managed prefix lists. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
