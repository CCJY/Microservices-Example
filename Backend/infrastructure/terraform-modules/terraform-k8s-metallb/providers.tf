terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = ">=2.10.0"
    }
    helm = {
      source = "hashicorp/helm"
      version = ">=2.5.1"
    }
    kubectl = {
      source = "gavinbunney/kubectl"
      version = ">=1.14.0"
    }
  }
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}
provider "time" {
  # Configuration options
}

provider "kubectl" {
  load_config_file = true
}