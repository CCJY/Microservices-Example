terraform {
  required_providers {
    time = {
      source = "hashicorp/time"
      version = "0.7.2"
    }
    kubectl = {
      source = "gavinbunney/kubectl"
      version = ">=1.14.0"
    }
  }
}

provider "time" {
  # Configuration options
}

provider "kubectl" {
  # Configuration options
  load_config_file = true
}