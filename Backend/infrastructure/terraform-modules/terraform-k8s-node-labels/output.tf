output "completed_id" {
    value = null_resource.node_labels.id
}

output "node_key" {
    value = var.label_key
}
output "node_value" {
    value = var.label_value
}