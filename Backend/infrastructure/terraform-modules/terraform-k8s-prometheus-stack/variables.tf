variable "namespace" {
  type = string

  default = "monitoring"
}

variable "depends_any" {
    type= any
}

variable "chart_version" {
  type = string
}

variable "prometheus_spec" {
    type = object({
        node_selector =map(string)
    })
}

variable "stack_deploy_enable" {
    type = object({
        alertmanager = bool
        grafana = bool
        prometheus = bool
    })

    default = {
      alertmanager = false
      grafana = true
      prometheus = true
    }
  
}