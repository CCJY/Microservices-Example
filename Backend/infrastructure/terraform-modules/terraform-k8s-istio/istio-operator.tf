# module "istio-git" {
#   source = "git::https://github.com/istio/istio.git//manifests/charts/istio-operator?ref=v1.13.3"
# }

resource "kubernetes_namespace" "istio_operator" {
  metadata {
    annotations = {
      name = var.istio_operator_namespace
    }

    name = var.istio_operator_namespace
  }
}

resource "helm_release" "istio_operator" {
  name = "istio-operator"
  repository = "https://stevehipwell.github.io/helm-charts"
  chart = "istio-operator"
  namespace = kubernetes_namespace.istio_operator.metadata[0].name
  version = var.istio_operator_version
  wait = true

#   set {
#     name  = "hub"
#     value = "docker.io/istio"
#   }
#   set {
#     name  = "tag"
#     value = var.istio_version
#   }
#   set {
#     name  = "watchedNamespaces"
#     value = var.istio_namespace
#   }
}
resource "time_sleep" "wait_istio_operator" {
  create_duration = "60s"

  depends_on=[
    helm_release.istio_operator
  ]
}
