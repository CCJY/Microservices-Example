resource "kubernetes_namespace" "redis_operator" {
  metadata {
    annotations = {
      name = var.operator_namespace
    }

    name = var.operator_namespace
  }
}

resource "time_sleep" "wait_depends_id" {
  create_duration = "60s"

  depends_on=[
    var.depends_any
  ]
  
}
resource "helm_release" "redis_operator" {
  name = "redis-operator"
  repository = "https://ot-container-kit.github.io/helm-charts/"
  chart = "redis-operator"
  namespace = kubernetes_namespace.redis_operator.metadata[0].name
  wait = true

  depends_on = [
    time_sleep.wait_depends_id
  ]
}
resource "time_sleep" "wait_redis_operator" {
  create_duration = "60s"

  depends_on=[
    helm_release.redis_operator
  ]
}
