resource "null_resource" "node_labels" {
    provisioner "local-exec" {
        command = "kubectl label nodes ${var.node_name} ${var.label_key}=${var.label_value} --overwrite"
    }
}

resource "null_resource" "node_labels_cleanup" {
    triggers = {
        node_name=var.node_name
        label_key=var.label_key
    }

    provisioner "local-exec" {
        when = destroy
        on_failure = continue
        command = "kubectl label nodes ${self.triggers.node_name} ${self.triggers.label_key}-"
    }
  
}