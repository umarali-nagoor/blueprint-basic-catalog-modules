output "resource_group_id" {
  description = "The ID of the resource group"
  value       = module.resource_group.resource_group_id
}
output "resource_group_name" {
  description = "The Name of the resource group"
  value       = var.name
}

output "provision" {
  description = "Flag indicating whether new resource group is provisioned or existing one is read"
  value       = module.resource_group.provision
}