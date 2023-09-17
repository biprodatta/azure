provider "azurerm" {
   features {}
}

locals {
  common_name    = join("-", compact([var.appid, var.appname, var.environment]))
  tags = {
    env     = var.environment
    appid     = var.appid
    appname = var.appname
  }
  settings_linux = {
    script   = base64encode(file("${path.module}/automation-linux.sh"))
  }
}
#######DATA RESOURCES######

data "azurerm_virtual_network" "vnet" {
  name                = var.vnet
  resource_group_name = var.resource_group
}

data "azurerm_subnet" "subnet" {
  name                 = var.subnet
  resource_group_name  = var.resource_group
  virtual_network_name = data.azurerm_virtual_network.vnet.name
}

/* data "azurerm_image" "ubuntu20" {
  name                = "Ubuntu Server 20.04 LTS"
  resource_group_name = var.resource_group
} */

#######RESOURCES######


resource "azurerm_public_ip" "public_ip" {
  count = var.machine_count
  name                = "minikube_${format("%02d",count.index+1)}-pub_ip"
  resource_group_name = var.resource_group
  location            = var.location
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "nic" {
  name                            = "${local.common_name}-${format("%02d",count.index+1)}-nic"
  location                        = var.location
  resource_group_name             = var.resource_group
  tags                            = local.tags
  ip_configuration {
    name                          = "${local.common_name}-${format("%02d",count.index+1)}-ip"
    subnet_id                     = data.azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"

    public_ip_address_id = count.index != 0 ? azurerm_public_ip.public_ip[count.index].id : null
  }

  count                           = var.machine_count
}


resource "azurerm_linux_virtual_machine" "linux_vm" {
  name                = "${local.common_name}-${format("%02d",count.index+1)}-vm"
  location            = var.location
  resource_group_name = var.resource_group
  
  count               = var.machine_count

  admin_username      = "datta"
  admin_password      = var.admin_password
  disable_password_authentication = false

  source_image_reference {
    publisher = "canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }
  
  network_interface_ids      = [element(azurerm_network_interface.nic.*.id, count.index)]
  size                       = var.vm_size

  allow_extension_operations = true
  custom_data                = base64encode("${var.vnet}")
  tags                       = local.tags

  os_disk {
    name                   = "${local.common_name}-${format("%02d",count.index+1)}-os-disk"
    caching                = "ReadWrite"
    storage_account_type   = "StandardSSD_LRS"
    disk_size_gb           = "30"
  }
}


resource "azurerm_virtual_machine_extension" "vmextensionbase" {
  name                 = "${local.common_name}-${format("%02d",count.index+1)}-command"
  virtual_machine_id   = azurerm_linux_virtual_machine.linux_vm[count.index].id
  publisher            = "Microsoft.CPlat.Core"
  type                 = "RunCommandLinux"
  type_handler_version = "1.0"
  protected_settings   = jsonencode(local.settings_linux)

  count                = var.machine_count
}

