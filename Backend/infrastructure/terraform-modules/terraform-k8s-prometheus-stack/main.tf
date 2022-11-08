resource "kubernetes_namespace" "monitoring" {
  metadata {
    annotations = {
      name = var.namespace
    }
    name = var.namespace
  }
}

resource "helm_release" "kube_prometheus_stack" {
  namespace = kubernetes_namespace.monitoring.metadata[0].name

  name       = "kube-prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  version    = var.chart_version 
  wait       = true

  dynamic "set" {
    for_each = var.prometheus_spec.node_selector
    content {
        name  = "prometheus.prometheusSpec.nodeSelector.${set.key}"
        value = set.value
    }
  }

  dynamic "set" {
    for_each = var.prometheus_spec.node_selector
    content {
        name  = "prometheusOperator.nodeSelector.${set.key}"
        value = set.value
    }
  }
  dynamic "set" {
    for_each = var.prometheus_spec.node_selector
    content {
        name  = "prometheusOperator.admissionWebhooks.patch.nodeSelector.${set.key}"
        value = set.value
    }
  }
  set {
    name = "alertmanager.enabled"
    value="${var.stack_deploy_enable.alertmanager}"
  }
 set {
    name = "grafana.enabled"
    value="${var.stack_deploy_enable.grafana}"
  }
 set {
    name = "prometheus.enabled"
    value="${var.stack_deploy_enable.prometheus}"
  }


  depends_on = [
    kubernetes_namespace.monitoring,
    var.depends_any
  ]
}

# resource "null_resource" "kube-prometheus-stack-cleanup" {
#   provisioner "local-exec" {
#     when       = destroy
#     on_failure = continue
#     command    = <<EOT
#     kubectl delete crd alertmanagerconfigs.monitoring.coreos.com
#     kubectl delete crd alertmanagers.monitoring.coreos.com
#     kubectl delete crd podmonitors.monitoring.coreos.com
#     kubectl delete crd probes.monitoring.coreos.com
#     kubectl delete crd prometheuses.monitoring.coreos.com
#     kubectl delete crd prometheusrules.monitoring.coreos.com
#     kubectl delete crd servicemonitors.monitoring.coreos.com
#     kubectl delete crd thanosrulers.monitoring.coreos.com
#     EOT
#   }

# }


