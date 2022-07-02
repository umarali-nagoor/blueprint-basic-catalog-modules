
variable "resource_group_id" {
  description = "ID of the resource group."
  type        = string
}


variable "cos_instance_name" {
  description = "Name of the COS instane."
  type        = string
  default     = "demo-cos-workitem"
}

variable "cos_storage_class" {
  type        = string
  description = "storage_class"
  default     = "smart"
}

variable "cos_storage_plan" {
  type        = string
  description = "COS plan"
  default     = "standard"
}


variable "cos_single_site_loc" {
  type    = string
  default = "sjc04"
}

variable "cos_bucket_name" {
  type    = string
  default = "demo-cos-buck"
}

resource "random_id" "name" {
  byte_length = 5
}


output "cos_id" {
  description = "ID of IBM COS instance"
  value       = ibm_resource_instance.cos_instance.*.guid[0]
}

output "cos_crn" {
  description = "CRN OF COS instance"
  value       = ibm_resource_instance.cos_instance.*.crn[0]
}


resource "ibm_resource_instance" "cos_instance" {
  name              = var.cos_instance_name
  service           = "cloud-object-storage"
  plan              = var.cos_storage_plan
  location          = "global"
  resource_group_id = var.resource_group_id
  tags              = ["t1", "t2"]

}


resource "ibm_cos_bucket" "standard-ams03" {
  bucket_name          = "${var.cos_bucket_name}-${random_id.name.hex}"
  resource_instance_id = ibm_resource_instance.cos_instance.id
  single_site_location = var.cos_single_site_loc
  storage_class        = var.cos_storage_class
}

