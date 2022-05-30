provider "ibm" {
}

module "resource_group" {
  
  source = "terraform-ibm-modules/resource-management/ibm//modules/resource-group"

  provision = var.provision
  name      = var.name
}