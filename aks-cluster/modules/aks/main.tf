resource "azurerm_kubernetes_cluster" "this" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix
  node_resource_group = "${var.resource_group_name}-nodes"
  kubernetes_version  = var.kubernetes_version
  sku_tier            = var.sku_tier

  default_node_pool {
    name            = "systempool"
    node_count      = 1
    vm_size         = var.system_node_vm_size
    os_disk_size_gb = var.system_node_disk_size
    vnet_subnet_id  = var.vnet_subnet_id
  }


  identity {
    type = "SystemAssigned"
  }

network_profile {
  network_plugin  = var.network_plugin
  service_cidr    = "10.2.0.0/16"  # Changed from 10.0.0.0/16
  dns_service_ip  = "10.2.0.10"    # Must be within service_cidr
}

  tags = var.tags
}

resource "azurerm_kubernetes_cluster_node_pool" "worker" {
  name                  = "workernode"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.this.id
  vm_size               = var.worker_node_vm_size
  node_count            = 1
  os_disk_size_gb       = var.worker_node_disk_size
  vnet_subnet_id        = var.vnet_subnet_id
  mode                  = "User"
  orchestrator_version  = var.kubernetes_version

  tags = var.tags
}