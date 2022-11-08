variable "namespace" {
    type = string
}

variable "chart_version" {
    type = string
}

variable "configs" {
    type = list(object({
        name=string,
        addresses=list(string)
    }))
}

variable "depends_any" {
    type = any
  
}

variable "controller_node_selector" {
    type = map(string)

}

variable "speaker_node_selector" {
    type = map(string)
}