variable "name" {
  description = "Name of resource group."
  type        = string
}

variable "provision" {
  type        = bool
  description = "Flag indicating whether new resource group is provisioned or existing one is read"
  default     = true
}