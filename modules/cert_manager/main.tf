resource "helm_release" "cert_manager" {
  name       = "cert_manager"
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  version    = var.cert_manager_version
  namespace  = "cert-manager"

  set {
    name  = "installCRDs"
    value = true
  }
}
