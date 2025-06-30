output "cluster_name" {
  description = "Name of the AKS cluster"
  value       = module.aks.cluster_name
}

output "kube_config" {
  description = "Kubernetes config file"
  value       = module.aks.kube_config
  sensitive   = true
}

output "cluster_fqdn" {
  description = "Cluster FQDN"
  value       = module.aks.cluster_fqdn
}

output "node_resource_group" {
  description = "Resource group containing cluster nodes"
  value       = module.aks.node_resource_group
}