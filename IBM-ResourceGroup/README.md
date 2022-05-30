# IBM resource-management Terraform Module

This template is being used to provision a resource group or to read an existing resource group on IBM Cloud Platform:

* resource-group

## Compatibility

This module is meant for use with Terraform version >= 0.13.

## Usage

```hcl
provider "ibm" {
}

module "resource_group" {
  
  source = "terraform-ibm-modules/resource-management/ibm//modules/resource-group"

  provision = var.provision
  name      = var.name
}

```

## NOTE:

If we want to make use of a particular version of module, then set the argument "version" to respective module version.

## Requirements

### Terraform plugins

- [Terraform](https://www.terraform.io/downloads.html) >= 0.13
- [terraform-provider-ibm](https://github.com/IBM-Cloud/terraform-provider-ibm)


### Terraform

Be sure you have the correct Terraform version (>= 0.13), you can choose the binary here:
- https://releases.hashicorp.com/terraform/

### Terraform plugins

Be sure you have the compiled plugins on $HOME/.terraform.d/plugins/

- [terraform-provider-ibm](https://github.com/IBM-Cloud/terraform-provider-ibm)

### Pre-commit Hooks

Run the following command to execute the pre-commit hooks defined in `.pre-commit-config.yaml` file

  `pre-commit run -a`

We can install pre-coomit tool using

  `pip install pre-commit`

## Input

| Input parameter                    | Description                                          |               | Default Value |
|------------------------------------|------------------------------------------------------|---------------|---------------|
| name  | Name of the resource group                          | mandatory     |               |
| provision  | Set this to true to provision new resource group          | mandatory     |        true       |


## Outputs


| Output parameter     | Description                                                                       |
|----------------------|-----------------------------------------------------------------------------------|
| resource_group_id    | ID of the resource group                                                          |
| resource_group_name  | Name of the resource group                                                        |
| provision            | Flag indicating whether new resource group is provisioned or existing one is read |

## How to input varaible values through a file

To review the plan for the configuration defined (no resources actually provisioned)

`terraform plan -var-file=./input.tfvars`

To execute and start building the configuration defined in the plan (provisions resources)

`terraform apply -var-file=./input.tfvars`

To destroy the VPC and all related resources

`terraform destroy -var-file=./input.tfvars`

To run the test cases

`go test -v -timeout 15m -run <TestFunctinName>`

All optional parameters by default will be set to null in respective example's varaible.tf file. If user wants to configure any optional paramter he has overwrite the default value.

## Note

All optional fields should be given value `null` in respective resource varaible.tf file. User can configure the same by overwriting with appropriate values.