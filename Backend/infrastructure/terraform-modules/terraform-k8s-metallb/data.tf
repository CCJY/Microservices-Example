data "template_file" "metallb_config" {
    count = length(var.configs)

    template = templatefile("${path.module}/templates/metallb-configmap.yaml.tftpl", {
        namespace = var.namespace
        config = var.configs[count.index]
    })
}