data "template_file" "virtual_services" {
	template = templatefile("${path.module}/templates/virtual-service.yaml.tftpl", 
	{
		vs = var.virtual_services[count.index]
	}
	)

	count = length(var.virtual_services)
}

data "template_file" "gateways" {
	template = templatefile("${path.module}/templates/gateway.yaml.tftpl", {
		gw = var.gateways[count.index]
	})

	count = length(var.gateways)
}

