variable "depends_any" {
    type=any
}

variable "namespace" {
    type = string

    default = "redis"
}

variable "operator_namespace" {
    type = string

    default = "redis-operator"
}

variable "cluster_enabled" {
    type = bool

    default = false
}
variable "node_selectors" {
    type =  list(object({
        key = string,
        value = string
    }))

    default = [
    ]
}