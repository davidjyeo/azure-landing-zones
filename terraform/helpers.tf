module "naming" {
  # version = "0.4.2"
  source = "Azure/naming/azurerm"
  prefix = [
    "plat-conn-prd-uks"
  ]
}

module "regions" {
  # version          = "0.9.2"
  source           = "Azure/avm-utl-regions/azurerm"
  geography_filter = "United Kingdom"
  enable_telemetry = var.enable_telemetry
}

module "avm-utl-network-ip-addresses" {
  # version                       = "0.1.0"
  source                        = "Azure/avm-utl-network-ip-addresses/azurerm"
  address_space                 = var.cidr_addr
  address_prefixes              = var.address_prefixes_ordered
  enable_telemetry              = var.enable_telemetry
  address_prefix_efficient_mode = false
}
