data "template_file" "istio_ops" {
	template = templatefile("${path.module}/templates/istio-ops.yaml.tftpl", {
		istioNamespace = var.istio_namespace
		profile = var.istio_profile
		autoInject = var.istio_autoinject
		pilotEnabled = var.istio_pilot.enabled
		pilotRequestsCpu = var.istio_pilot.requests_cpu
		pilotRequestsMemory = var.istio_pilot.requests_memory
		ingressGateways = var.ingress_gateways
	})
}

data "template_file" "istio_prometheus" {
	template = file("${path.module}/templates/prometheus-operator.yaml")
}