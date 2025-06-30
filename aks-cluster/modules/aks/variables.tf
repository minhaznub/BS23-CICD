variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "cluster_name" {
  description = "AKS cluster name"
  type        = string
}

variable "dns_prefix" {
  description = "DNS prefix for cluster API"
  type        = string
}

variable "vnet_subnet_id" {
  description = "Subnet ID for nodes"
  type        = string
}

# System node (master) configuration
variable "system_node_vm_size" {
  description = "VM size for system node"
  type        = string
  default     = "Standard_B2s"  # Cheaper option for dev/test
}

variable "system_node_disk_size" {
  description = "OS disk size (GB) for system node"
  type        = number
  default     = 30
}

# Worker node configuration
variable "worker_node_vm_size" {
  description = "VM size for worker node"
  type        = string
  default     = "Standard_B2s"
}

variable "worker_node_disk_size" {
  description = "OS disk size (GB) for worker node"
  type        = number
  default     = 64
}

# Cluster settings
variable "kubernetes_version" {
  description = "Kubernetes version"
  type        = string
  default     = null  # Let Azure choose latest stable
}

variable "network_plugin" {
  description = "Network plugin (azure/kubenet)"
  type        = string
  default     = "kubenet"  # Simpler for small clusters
}

variable "service_cidr" {
  description = "The Network Range used by the Kubernetes service"
  type        = string
  default     = "10.2.0.0/16"  # Must not overlap with VNet subnets
}

variable "dns_service_ip" {
  description = "IP address within the Kubernetes service address range"
  type        = string
  default     = "10.2.0.10"    # Must be within service_cidr
}
variable "tags" {
  description = "Resource tags"
  type        = map(string)
  default     = {}
}

variable "sku_tier" {
  description = "AKS tier (Free/Paid)"
  type        = string
  default     = "Free"
}

# variable "worker_node_vm_size" {
#   default = "Standard_DS2_v2"
# }

# variable "worker_node_disk_size" {
#   default = 30
# }
