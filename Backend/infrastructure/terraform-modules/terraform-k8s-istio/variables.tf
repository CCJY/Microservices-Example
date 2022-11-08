variable "depends_any" {
    type = any
}
variable "istio_operator_namespace" {
  type = string

  default = "istio-operator"
}

variable "istio_operator_version" {
  type = string

  default = "2.5.3"
}

variable "istio_namespace" {
  type = string

  default = "istio-system"
}

variable "istio_profile" {
  type = string

  default = "minimal"
}

variable "istio_autoinject" {
  type = string

  default = "disabled"
}

variable "istio_pilot_enabled" {
  type = bool
  default = true
}

variable "istio_pilot" {
  type = object({
    enabled = bool,
    requests_cpu = string,
    requests_memory = string
  })

  default = {
    enabled = true
    requests_cpu = "200M"
    requests_memory = "256Mi"
  }
}

variable "ingress_gateways" {
  type = list(object({
    name=string,
    enabled = bool,
    labels = list(object({
      label_key = string,
      label_value = string
    })),
    nodeSelectors = list(object({
      node_key = string,
      node_value = string
    })),
    requests_cpu = string,
    requests_memory = string,
    service_type = string # LoadBalancer, ClusterIP
    ports = list(object({
      port = number,
      name = string,
      targetPort = number,
      protocol = string
    }))
  }))

  default = [ {
    enabled = true
    labels = [ ]
    name = "istio-ingressgateway"
    nodeSelectors = [ {
      node_key = "node-role.kubernetes.io/master"
      node_value = "true"
    } ]
    ports = [ ]
    requests_cpu = "200m"
    requests_memory = "256Mi"
    service_type = "LoadBalancer"
  } ]
  
}

