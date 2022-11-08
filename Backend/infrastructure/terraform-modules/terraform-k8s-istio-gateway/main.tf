# resource "local_file" "virtual_services" {
#     count = length(var.virtual_services)
#     content  = "${data.template_file.virtual_services[count.index].rendered}"
#     filename = "${count.index}-virtual-service.yaml"
# }

# resource "local_file" "gateways" {
#     count = length(var.gateways)
#     content  = "${data.template_file.gateways[count.index].rendered}"
#     filename = "${count.index}-gateway.yaml"
# }

resource "time_sleep" "wait_depends_id" {
    create_duration = "60s"

    depends_on=[
        var.depends_any
    ]
}

resource "kubectl_manifest" "gateways" {
    validate_schema = false

	count = length(var.gateways)

	yaml_body = data.template_file.gateways[count.index].rendered

	depends_on = [
		time_sleep.wait_depends_id,
	]
}

resource "time_sleep" "wait_gateways" {
    create_duration = "60s"

    depends_on=[
        kubectl_manifest.gateways
    ]
}

resource "kubectl_manifest" "virtual_services" {
    validate_schema = false

	count = length(var.virtual_services)

	yaml_body = data.template_file.virtual_services[count.index].rendered

	depends_on = [
		time_sleep.wait_gateways,
	]
}

resource "time_sleep" "wait_virtual_services" {
    create_duration = "60s"

    depends_on=[
        kubectl_manifest.virtual_services
    ]
}
