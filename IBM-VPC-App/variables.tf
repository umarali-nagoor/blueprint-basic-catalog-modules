

# variable "TF_VERSION" {
#   default     = "0.13"
#   description = "terraform engine version to be used in schematics"
# }

##############################################################################
# Account Variables
##############################################################################

# variable "ibmcloud_api_key" {
#   description = "The IBM Cloud platform API key needed to deploy IAM enabled resources"
#   type        = string
# }

# variable "vpc_region" {
#   description = "IBM Cloud region where all resources will be deployed"
#   type        = string
#   default     = "us-south"
# }

variable "unique_id" {
  description = "Name of the VSI"
  type        = string
  default     = "blueprint-app"
}


##############################################################################


##############################################################################
# VSI Variables
##############################################################################

variable "image" {
  description = "Image name used for VSI. Run 'ibmcloud is images' to find available images in a region"
  type        = string
  default     = "ibm-ubuntu-18-04-1-minimal-amd64-1"
}

variable "vsi_per_subnet" {
    description = "Number of VSI instances for each subnet. All VSI will be connected by a single load balancer"
    type        = number
    default     = 2
}

variable "ssh_public_key" {
  description = "ssh public key to use for vsi"
  type        = string
}

variable "machine_type" {
  description = "VSI machine type. Run 'ibmcloud is instance-profiles' to get a list of regional profiles. For Gen 1 use bc1-2x8, for Gen 2 use bx2-2x8"
  type        =  string
  default     = "bx2-2x8"
}


variable "enable_fip" {
  description = "Enable floating IP. Can be true or false"
  type        = bool
  default     = true
}

variable "volumes" {
  description = "A list of maps describng the volumes for each of the VSI"
  /*
  type         = list(object({
      name           = string   
      profile        = string
      iops           = number       # Optional
      capacity       = number       # Optional
      encryption_key = string       # Optional
      tags           = list(string) # Optional
  }))
  */
  default     = [
    {
      name     = "one"
      profile  = "10iops-tier"
      capacity = 25
    }
  ]
}


##############################################################################



##############################################################################
# Account Variables
##############################################################################

variable "resource_group_id" {
  description = "ID of resource group to create VPC"
  type        = string
}

##############################################################################
