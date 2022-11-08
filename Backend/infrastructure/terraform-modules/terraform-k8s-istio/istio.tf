resource "kubernetes_namespace" "istio" {
  metadata {
    name = var.istio_namespace 
  }
}

resource "kubectl_manifest" "istio" {
  validate_schema = false

  yaml_body = data.template_file.istio_ops.rendered

  depends_on = [
    kubernetes_namespace.istio,
    time_sleep.wait_istio_operator
  ]
}

resource "time_sleep" "wait_istio" {
  create_duration = "60s"

  depends_on = [
    kubectl_manifest.istio,
  ]

}
# resource "time_sleep" "wait_prometheus" {
#   create_duration = "60s"

#   depends_on = [
#     var.depends_any
#   ]
# }

# resource "kubectl_manifest" "istio_prometheus" {
#   validate_schema = false

#   yaml_body = data.template_file.istio_prometheus.rendered

#   depends_on = [
#     kubernetes_namespace.istio,
#     time_sleep.wait_istio,
#     time_sleep.wait_prometheus
#   ]
# }

# resource "time_sleep" "wait_istio_prometheus" {
#   create_duration = "60s"

#   depends_on = [
#     kubectl_manifest.istio_prometheus,
#   ]
# }

