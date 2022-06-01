# provider "ibm" {
#   ibmcloud_api_key = var.ic_api_key
# }


module "logging_instance" {

  source               = "terraform-ibm-modules/observability/ibm//modules/logging-instance"
  provision            = true
  is_sts_instance      = false
  bind_key             = false
  name                 = var.logdna_name
  resource_group_id    = var.resource_group_id
  plan                 = var.logdna_plan
  region               = var.logdna_region
  service_endpoints    = var.service_endpoints
  enable_platform_logs = var.enable_platform_logs
  tags                 = ["logDNA_tags"]
  create_timeout       = var.create_timeout
  update_timeout       = var.update_timeout
  delete_timeout       = var.delete_timeout
  key_name             = var.key_name
  key_tags             = var.key_tags
}
################# logDNA end ##############




# Remove AT to eliminate errors caused by only single AT instance allowed per region
# module "activity_tracker_instance" {

#   source                = "terraform-ibm-modules/observability/ibm//modules/activity-tracker-instance"
#   provision             = true
#   is_ats_instance       = false
#   name                  = var.at_name
#   plan                  = var.at_plan
#   region                = var.at_region
#   bind_key              = false
#   key_name              = var.key_name
#   key_tags              = var.key_tags
#   resource_group_id     = var.resource_group_id
#   tags                  = ["AT_tags"]
#   make_default_receiver = false
#   create_timeout        = var.create_timeout
#   update_timeout        = var.update_timeout
#   delete_timeout        = var.delete_timeout
# }

# ################# AT end ##############



