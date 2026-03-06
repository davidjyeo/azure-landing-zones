module "avm-ptn-alz-sub-vending" {
  # version                                          = "0.1.1"
  source                       = "Azure/avm-ptn-alz-sub-vending/azure"
  location                     = module.regions.regions[0].name
  disable_telemetry            = true
  subscription_id              = "df120b9e-5521-4670-8c15-62ebf9c214dd" # AZ-DJY-Connectivity
  subscription_update_existing = true
  subscription_display_name    = "AZ-DJY-Connectivity"

  subscription_tags = {
    managed_by = "avm-ptn-alz-sub-vending"
  }

  enable_telemetry = var.enable_telemetry

  // resource enablement
  budget_enabled                                   = false
  network_security_group_enabled                   = true
  resource_group_creation_enabled                  = true
  role_assignment_enabled                          = false
  route_table_enabled                              = true
  subscription_register_resource_providers_enabled = true
  umi_enabled                                      = false
  virtual_network_enabled                          = true

  resource_groups = {
    rg1 = {
      name     = "${module.naming.resource_group.name}-01"
      location = "uksouth"
    }
    rg2 = {
      name     = "${module.naming.resource_group.name}-palo"
      location = "uksouth"
    }
    rg3 = {
      name     = "${module.naming.resource_group.name}-privatednszones"
      location = "uksouth"
    }
    rg4 = {
      name     = "${module.naming.resource_group.name}-publicdnszones"
      location = "uksouth"
    }

  }

  subscription_register_resource_providers_and_features = {
    "Microsoft.Automation"          = []
    "Microsoft.AzureTerraform"      = []
    "Microsoft.Compute"             = []
    "Microsoft.ContainerService"    = []
    "Microsoft.ContainerRegistry"   = []
    "Microsoft.KeyVault"            = []
    "Microsoft.Network"             = []
    "Microsoft.OperationalInsights" = []
    "Microsoft.Sql"                 = []
    "Microsoft.Storage"             = []
    "Microsoft.Web"                 = []
  }

  virtual_networks = {
    hub = {
      name                = "${module.naming.virtual_network.name}-hub-01"
      address_space       = ["${var.cidr_addr}"]
      location            = module.regions.regions[0].name
      resource_group_key  = "rg1"
      hub_peering_enabled = false
      # hub_network_resource_id  = "/subscriptions/dd1f20ca-1bd3-4649-8fb9-d6c7e79b4a7a/resourceGroups/plat-conn-prod-uks-rg/providers/Microsoft.Network/virtualNetworks/plat-conn-prod-uks-vnet-hub-01"
      # hub_peering_name_tohub   = "${module.naming.virtual_network.name}-01-to-plat-conn-prod-uks-vnet-hub-01"
      # hub_peering_name_fromhub = "plat-conn-prod-uks-vnet-hub-01-to-${module.naming.virtual_network.name}-01"
      # hub_peering_options_tohub = {
      #   use_remote_gateways = false
      # }

      subnets = {
        trust = {
          name             = "${module.naming.subnet.name}-hub-trust-01"
          address_prefixes = [module.avm-utl-network-ip-addresses.address_prefixes["a"]]
          network_security_group = {
            key_reference = "trust"
          }
          route_table = {
            key_reference = "trust"
          }
        }
        untrust = {
          name             = "${module.naming.subnet.name}-hub-untrust-01"
          address_prefixes = [module.avm-utl-network-ip-addresses.address_prefixes["b"]]
          network_security_group = {
            key_reference = "untrust"
          }
          route_table = {
            key_reference = "untrust"
          }
        }
        ha2fw = {
          name             = "${module.naming.subnet.name}-hub-ha2fw-01"
          address_prefixes = [module.avm-utl-network-ip-addresses.address_prefixes["c"]]
          network_security_group = {
            key_reference = "ha2fw"
          }
          route_table = {
            key_reference = "ha2fw"
          }
        }
        appgw = {
          name             = "${module.naming.subnet.name}-hub-appgw-01"
          address_prefixes = [module.avm-utl-network-ip-addresses.address_prefixes["d"]]
          network_security_group = {
            key_reference = "appgw"
          }
          route_table = {
            key_reference = "appgw"
          }
        }
        /*
        spare001 = {
          name             = "spare001"
          address_prefixes = [module.avm-utl-network-ip-addresses.address_prefixes["e"]]
        }
        */
        mgmtfw = {
          name             = "${module.naming.subnet.name}-hub-mgmtfw-01"
          address_prefixes = [module.avm-utl-network-ip-addresses.address_prefixes["f"]]
          network_security_group = {
            key_reference = "mgmtfw"
          }
          route_table = {
            key_reference = "mgmtfw"
          }
        }
        vzen = {
          name             = "${module.naming.subnet.name}-hub-vzen-01"
          address_prefixes = [module.avm-utl-network-ip-addresses.address_prefixes["g"]]
          network_security_group = {
            key_reference = "vzen"
          }
          route_table = {
            key_reference = "vzen"
          }
        }
        wlanctrl = {
          name             = "${module.naming.subnet.name}-hub-wlanctrl-01"
          address_prefixes = [module.avm-utl-network-ip-addresses.address_prefixes["h"]]
          network_security_group = {
            key_reference = "wlanctrl"
          }
          route_table = {
            key_reference = "wlanctrl"
          }
        }
        ampls = {
          name             = "${module.naming.subnet.name}-hub-ampls-01"
          address_prefixes = [module.avm-utl-network-ip-addresses.address_prefixes["i"]]
          network_security_group = {
            key_reference = "ampls"
          }
          route_table = {
            key_reference = "ampls"
          }
        }
        /*
        spare002 = {
          name             = "spare002"
          address_prefixes = [module.avm-utl-network-ip-addresses.address_prefixes["j"]]
        }
        */
        dns = {
          name             = "${module.naming.subnet.name}-hub-dns-01"
          address_prefixes = [module.avm-utl-network-ip-addresses.address_prefixes["k"]]
          network_security_group = {
            key_reference = "dns"
          }
          route_table = {
            key_reference = "dns"
          }
        }
      }
    }
  }

  network_security_groups = {
    trust = {
      name               = "${module.naming.network_security_group.name}-trust-01"
      resource_group_key = "rg1"
    }
    untrust = {
      name               = "${module.naming.network_security_group.name}-untrust-01"
      resource_group_key = "rg1"
    }
    ha2fw = {
      name               = "${module.naming.network_security_group.name}-ha2fw-01"
      resource_group_key = "rg1"
    }
    appgw = {
      name               = "${module.naming.network_security_group.name}-appgw-01"
      resource_group_key = "rg1"
    }
    mgmtfw = {
      name               = "${module.naming.network_security_group.name}-mgmtfw-01"
      resource_group_key = "rg1"
    }
    vzen = {
      name               = "${module.naming.network_security_group.name}-vzen-01"
      resource_group_key = "rg1"
    }
    wlanctrl = {
      name               = "${module.naming.network_security_group.name}-wlanctrl-01"
      resource_group_key = "rg1"
    }
    ampls = {
      name               = "${module.naming.network_security_group.name}-ampls-01"
      resource_group_key = "rg1"
    }
    dns = {
      name               = "${module.naming.network_security_group.name}-dns-01"
      resource_group_key = "rg1"
    }
  }

  route_tables = {
    trust = {
      name               = "${module.naming.route_table.name}-trust-01"
      location           = module.regions.regions[0].name
      resource_group_key = "rg1"
    }
    untrust = {
      name               = "${module.naming.route_table.name}-untrust-01"
      location           = module.regions.regions[0].name
      resource_group_key = "rg1"
    }
    ha2fw = {
      name               = "${module.naming.route_table.name}-ha2fw-01"
      location           = module.regions.regions[0].name
      resource_group_key = "rg1"
    }
    appgw = {
      name               = "${module.naming.route_table.name}-appgw-01"
      location           = module.regions.regions[0].name
      resource_group_key = "rg1"
    }
    mgmtfw = {
      name               = "${module.naming.route_table.name}-mgmtfw-01"
      location           = module.regions.regions[0].name
      resource_group_key = "rg1"
    }
    vzen = {
      name               = "${module.naming.route_table.name}-vzen-01"
      location           = module.regions.regions[0].name
      resource_group_key = "rg1"
    }
    wlanctrl = {
      name               = "${module.naming.route_table.name}-wlanctrl-01"
      location           = module.regions.regions[0].name
      resource_group_key = "rg1"
    }
    ampls = {
      name               = "${module.naming.route_table.name}-ampls-01"
      location           = module.regions.regions[0].name
      resource_group_key = "rg1"
    }
    dns = {
      name               = "${module.naming.route_table.name}-dns-01"
      location           = module.regions.regions[0].name
      resource_group_key = "rg1"
    }

  }

  # user_managed_identities = {
  #   "default" = {
  #     name                         = "umi-0${random_string.suffix.result}"
  #     resource_group_name_existing = "rg-${random_string.suffix.result}"
  #     role_assignments = {
  #       "blob" = {
  #         definition     = "Storage Blob Data Contributor"
  #         relative_scope = "/resourceGroups/rg-${random_string.suffix.result}"
  #       }
  #     }
  #   }
  # }

}
