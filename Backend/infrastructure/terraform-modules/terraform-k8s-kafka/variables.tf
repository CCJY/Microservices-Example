variable "depends_any" {
    type=any
}

variable "operator_namespace" {
    type = string

    default = "kafka-operator"
}

variable "kafka_namespace" {
    type = string

    default = "kafka"
}

variable "chart_version" {
    type = string

    default = "0.28.0"
}


variable "helm_chart_values_path" {
  type = string
  default = null
}

variable "kafka_yaml_path" {
  type = string
  default = null
}
