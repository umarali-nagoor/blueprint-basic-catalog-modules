###################################################################
# Common parameters
###################################################################
# variable "ic_api_key" {
#   description = "IBM cloud apiKey"
#   type        = string
# }


variable "resource_group_id" {
  description = "ID of the resource group."
  type        = string
}


variable "create_timeout" {
  type        = string
  description = "Timeout duration for create."
  default     = "10m"
}

variable "update_timeout" {
  type        = string
  description = "Timeout duration for update."
  default     = "10m"
}

variable "delete_timeout" {
  type        = string
  description = "Timeout duration for delete."
  default     = "10m"
}

variable "key_tags" {
  type        = list(string)
  description = "Tags that should be applied to the key"
  default     = null
}

variable "key_name" {
  description = "Name of the instance key"
  type        = string
  default     = null
}

################# logDNA start ##############


variable "logdna_name" {
  description = "LogDNA STS: Name of the STS instance"
  type        = string
  default     = "logdna_workitem"
}

variable "logdna_plan" {
  description = "LogDNA STS: plan type (14-day, 30-day, 7-day, hipaa-30-day and lite)"
  type        = string
  default     = "14-day"
}

variable "logdna_region" {
  description = "LogDNA STS: Region"
  type        = string
  default     = "ca-tor"
}

variable "enable_platform_logs" {
  description = "Enable / Disable platform logs"
  type        = bool
  default     = true
}

variable "service_endpoints" {
  description = "Types of the service endpoints. Possible values are 'public', 'private', 'public-and-private'."
  type        = string
  default     = "public-and-private"
}


output "logdna_crn" {
  description = "The ID of the logging STS instance"
  value       = module.logging_instance.id
}

output "logdna_id" {
  description = "ID of IBM Log STS instance"
  value       = concat(module.logging_instance.*.guid, [""])[0]
}


# Remove AT to avoid AT provisioning failures as only one AT instance allowed per region. 
# ################# AT start ##############

# variable "at_name" {
#   type        = string
#   description = "Enter The name for the service"
#    default     = "at_workitem"
# }

# variable "at_plan" {
#   type        = string
#   description = "The type of plan the service instance should run under (lite, 7-day, 14-day, or 30-day)"
#   default     = "7-day"
# }



# variable "at_region" {
#   type        = string
#   description = "Geographic location of the resource (e.g. us-south, us-east)"
#   default     = "ca-tor"
# }



# output "at_crn" {
#   description = "The ID of the logging STS instance"
#   value       = module.activity_tracker_instance.id
# }

# output "at_id" {
#   description = "ID of IBM Log STS instance"
#   value       = concat(module.activity_tracker_instance.*.guid, [""])[0]
# }

# ################# AT end ##############
