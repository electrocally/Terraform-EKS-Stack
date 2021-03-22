resource "helm_release" "cilium" {
  name       = "cilium"
  repository = "https://helm.cilium.io/"
  chart      = "cilium"
  version    = var.cilium_version
  namespace  = "kube-system"

  set {
    name  = "nodeinit.enabled"
    value = true
  }

  set {
    name  = "kubeProxyReplacement"
    value = "partial"
  }

  set {
    name  = "hostServices.enabled"
    value = false
  }

  set {
    name  = "externalIPs.enabled"
    value = true
  }

  set {
    name  = "nodePort.enabled"
    value  = true
  }

  set {
    name  = "hostPort.enabled"
    value = true
  }

  set {
    name  = "bpf.masquerade"
    value = false
  }

  set {
    name  = "image.pullPolicy"
    value = "IfNotPresent"
  }

  set {
    name  = "ipam.mode"
    value = "kubernetes"
  }

  set {
    name  = "hubble.listenAddress"
    value = ":4244"
  }

  set {
    name  = "hubble.relay.enabled"
    value = var.hubble_enabled
  }

  set {
    name  = "hubble.ui.enabled"
    value = var.hubble_ui_enabled
  }
}

