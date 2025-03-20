variable "resource_group_name" {
  type    = string
  default = "vm_rg"
}

variable "location" {
  type    = string
  default = "West Europe"
}

variable "subscription_id" {
  type      = string
  sensitive = true
}

variable "admin_password" {
  type      = string
  sensitive = true
}