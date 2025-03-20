variable "resource_group_name"{
    type = string
    default = "vm_rg"
}

variable "location"{
    type = string
    default = "West Europe"
}

variable "subnet_name"{
    type = string
    default = "vm_subnet"
}

variable "subnet_id"{
    type = string
}

variable "admin_password"{
    type = string
    sensitive = true
}

variable "nic_name"{
    type = string
    default = "vm_nic"
}

variable "vm_name"{
    type = string
    default = "vm"
}

variable "nsg_name"{
    type = string
    default = "vm_nsg"
}

variable "nic_nsg_name"{
    type = string
    default = "vm_nic_nsg"

}

variable "public_ip_name"{
    type = string
    default = "vm_public_ip"
}