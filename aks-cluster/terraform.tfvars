resource_group_name = "aks-rg"
location           = "eastus"

tags = {
  Environment = "Production"
  Project     = "AKS-Cluster"
}

vnet_name       = "aks-vnet"
address_space   = ["10.0.0.0/16"]
subnet_names    = ["aks-subnet"]
subnet_prefixes = ["10.0.1.0/24"]

cluster_name = "prod-aks-cluster"
dns_prefix   = "prod-aks"

node_pools = [
  {
    name                = "systempool"
    vm_size             = "Standard_DS2_v2"
    node_count          = 2
    enable_auto_scaling = true
    min_count           = 2
    max_count           = 5
    os_disk_size_gb     = 128
    max_pods            = 30
  },
  {
    name                = "userpool"
    vm_size             = "Standard_DS3_v2"
    node_count          = 3
    enable_auto_scaling = true
    min_count           = 3
    max_count           = 10
    os_disk_size_gb     = 128
  }
]