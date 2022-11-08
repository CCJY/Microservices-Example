variable "depends_any" {
    type = any
}

variable "virtual_services" {
	type = list(object({
		name = string,
		namespace = string,
		hosts = list(string),
		gateways = list(string)
		routes = list(object({
			tcp = bool,
			dest_port = number,
			dest_host = string,
            match = bool,
            match_port = number
		}))
	}))

	default = [ {
	  gateways = [ "kiali-gateway" ]
	  hosts = [ ]
	  name = "kiali"
	  namespace = "istio-system"
	  routes = [ {
		dest_host = "kiali.istio-system.svc.cluster.local"
		dest_port = 20001
		tcp = true,
        match = false,
        match_port = null
	  } ]
	} ]
}

variable "gateways" {
	type = list(object({
		name = string,
		namespace = string,
		selector = string,
		servers = list(object({
			number = number,
			name = string,
			protocol = string,
			tls_enabled = bool,
			tls_credential_name = string,
			hosts = list(string)
		}))
	}))

	default = [
	{
		name = "kiali-gateway"
		namespace = "istio-system"
		selector = "cluster-svc-gateway",
		servers = [ {
		hosts = [ ]
		name = "kiali"
		number = 20001
		protocol = "TCP"
		tls_enabled = false
		tls_credential_name = "kiali-gw-cert"
		},
	]},
	{
		name = "graphql-gateway"
		namespace = "istio-system"
		selector = "cluster-svc-graphql-gateway",
		servers = [ {
		hosts = [ ]
		name = "graphql"
		number = 8080
		protocol = "TCP"
		tls_enabled = true
		tls_credential_name = "graphql-gw-cert"
		},
	]}
	
	]
}