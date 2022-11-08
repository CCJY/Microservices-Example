resource "kubernetes_namespace" "redis" {
  metadata {
    annotations = {
      name = var.namespace
    }
    name = var.namespace 
  }
}

resource "kubectl_manifest" "redis_standalone" {
    count = var.cluster_enabled ? 0 : 1
    validate_schema = false

    yaml_body = data.template_file.redis_standalone.rendered

    depends_on = [
       kubernetes_namespace.redis,
       time_sleep.wait_redis_operator
    ]
}

resource "time_sleep" "wait_redis" {
  create_duration = "60s"

  depends_on=[
    kubectl_manifest.redis_standalone
  ]
  
}
