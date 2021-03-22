module "ambassador_api_gateway" {
  source = "./modules/ambassador_api_gateway"
  count  = var.modules.ambassador_api_gateway.enabled == true ? 1 : 0
}

module "cert_manager" {
  source = "./modules/cert_manager"
  count  = var.modules.cert_manager.enabled == true ? 1 : 0

  cert_manager_version = var.modules.cert_manager.version
}

module "cilium" {
  source = "./modules/cilium"
  count  = var.modules.cilium.enabled == true ? 1 : 0

  cilium_version    = var.modules.cilium.version
  hubble_enabled    = var.modules.cilium.hubble_enabled
  hubble_ui_enabled = var.modules.cilium.hubble_ui_enabled
}

module "consul" {
  source = "./modules/consul"
  count  = var.modules.consul.enabled == true ? 1 : 0
}

module "kiam" {
  source = "./modules/kiam"
  count  = var.modules.kiam.enabled == true ? 1 : 0

  kiam_version        = var.modules.kiam.version
  interface_type      = var.modules.cilium.enabled == true ? "lcx+" : "!eth0"
  host_network_enable = var.modules.cilium.enabled == true ? true : false
  host_network_iptables = var.modules.cilium.enabled == true ? false : true
}

