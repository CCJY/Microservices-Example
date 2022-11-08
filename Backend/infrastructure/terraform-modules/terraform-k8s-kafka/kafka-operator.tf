resource "kubernetes_namespace" "kafka_operator" {
  metadata {
    annotations = {
      name = var.operator_namespace
    }
    name = var.operator_namespace 
  }
}

resource "time_sleep" "wait_depends" {
    create_duration = "60s"

    depends_on=[
        var.depends_any
    ]
}

resource "helm_release" "kafka_operator" {
  name       = "kafka-operator"
  repository = "https://strimzi.io/charts/"
  chart      = "strimzi-kafka-operator"
  version    = var.chart_version
  
  namespace = kubernetes_namespace.kafka_operator.metadata[0].name

  values = [
    file(var.helm_chart_values_path)
  ]


  depends_on = [
    kubernetes_namespace.kafka_operator,
    time_sleep.wait_depends
  ]
}

resource "time_sleep" "wait_helm_kafka_operator" {
  create_duration = "60s"

  depends_on=[
    helm_release.kafka_operator
  ]
}

