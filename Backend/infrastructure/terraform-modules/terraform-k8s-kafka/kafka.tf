resource "kubernetes_namespace" "kafka" {
  metadata {
    annotations = {
      name = var.kafka_namespace
    }
    name = var.kafka_namespace 
  }
}
resource "null_resource" "kafka" {
  triggers = {
    "file_path" = var.kafka_yaml_path 
  }
  depends_on = [
    kubernetes_namespace.kafka,
    time_sleep.wait_helm_kafka_operator
  ]
  provisioner "local-exec" {
    command = "kubectl apply -f ${self.triggers.file_path}"
  }
  provisioner "local-exec" {
    when       = destroy
    on_failure = continue
    command    = "kubectl delete -f ${self.triggers.file_path}"
  }

}

resource "time_sleep" "wait_kafka" {
  create_duration = "60s"

  depends_on=[
    null_resource.kafka
  ]
}
