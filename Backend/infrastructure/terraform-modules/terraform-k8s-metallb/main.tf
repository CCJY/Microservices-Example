resource "kubernetes_namespace" "metallb" {

  metadata {
    annotations = {
      name = var.namespace
    }
    name = var.namespace
  }
}



resource "helm_release" "metallb" {
  namespace = kubernetes_namespace.metallb.metadata[0].name

  name       = "metallb"
  repository = "https://metallb.github.io/metallb"
  chart      = "metallb"
  version    = var.chart_version
  wait = true

  dynamic "set" {
    for_each = var.controller_node_selector
    content {
        name  = "controller.nodeSelector.${set.key}"
        value = set.value
    }
  }

  dynamic "set" {
    for_each = var.speaker_node_selector
    content {
        name  = "speaker.nodeSelector.${set.key}"
        value = set.value
    }
  }

  depends_on = [kubernetes_namespace.metallb]
}

resource "time_sleep" "wait_metallb" {
  create_duration = "60s"

  depends_on = [
    helm_release.metallb
  ]
}

resource "kubectl_manifest" "metallb_config" {
    count = length(var.configs)

    validate_schema = false

    yaml_body = data.template_file.metallb_config[count.index].rendered

    depends_on = [
      kubernetes_namespace.metallb,
      time_sleep.wait_metallb
    ]
  
}