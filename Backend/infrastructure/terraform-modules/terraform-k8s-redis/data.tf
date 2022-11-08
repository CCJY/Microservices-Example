data "template_file" "redis_standalone" {
	template = templatefile("${path.module}/templates/redis-standalone.yaml.tftpl", {
        namespace = var.namespace
        nodeSelectors = var.node_selectors
	})
}