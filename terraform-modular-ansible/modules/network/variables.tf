variable "resource_group_name" {
  type    = string
  default = "vm_rg"
}

variable "location" {
  type    = string
  default = "West Europe"
}

variable "vnet_name"{
  type = string
  default = "vm_vnet"
}

variable "subnet_name"{
  type = string
  default = "vm_subnet"
}