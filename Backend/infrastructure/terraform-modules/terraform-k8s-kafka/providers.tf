terraform {
  required_providers {
    time = {
      source = "hashicorp/time"
      version = "0.7.2"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = ">=2.10.0"
    }
    kubectl = {
      source = "gavinbunney/kubectl"
      version = ">=1.14.0"
    }
    helm = {
      source = "hashicorp/helm"
      version = ">=2.5.1"
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

provider "kubectl" {
  load_config_file = true
}

provider "time" {
  # Configuration options
}

