terraform {
  required_providers {
    minikube = {
      source = "scott-the-programmer/minikube"
      version = "99.99.99"
    }
  }
}

provider "minikube" {
  kubernetes_version = "v1.26.1"
}

resource "minikube_cluster" "docker" {
  driver       = "docker"
  cluster_name = "terraform-provider-minikube-acc-docker"
  addons = [
    "default-storageclass",
  ]
}

provider "kubernetes" {
  host = minikube_cluster.docker.host

  client_certificate     = minikube_cluster.docker.client_certificate
  client_key             = minikube_cluster.docker.client_key
  cluster_ca_certificate = minikube_cluster.docker.cluster_ca_certificate
}
resource "kubernetes_deployment" "medicure" {
  metadata {
    name = "medicure-example"
    labels = {
      test = "medicure-app"
    }
   
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        test = "medicure-app"
      }
    }

    template {
      metadata {
        labels = {
          test = "medicure-app"
        }
      }

      spec {
        container {
          image = "staragiledevops/medicure:1.0"
          name  = "medicure"
          
      port {
        container_port = 8083
      }

}
}
}
}
}
