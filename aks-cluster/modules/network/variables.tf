variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
}

variable "address_space" {
  description = "Address space for the virtual network"
  type        = list(string)
}

variable "subnet_names" {
  description = "Names of the subnets"
  type        = list(string)
}

variable "subnet_prefixes" {
  description = "Address prefixes for the subnets"
  type        = list(string)
}

variable "tags" {
  description = "Tags for the network resources"
  type        = map(string)
  default     = {}
}