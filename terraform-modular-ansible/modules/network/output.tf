output "vnet_name" {
  value = azurerm_virtual_network.vm_vnet.name
}

output "subnet_id" {
  value = azurerm_subnet.vm_subnet.id
}