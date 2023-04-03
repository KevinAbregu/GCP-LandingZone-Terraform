terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }
  backend "gcs" {
    bucket = "[XXX]"
    prefix = "terraform/state"
    impersonate_service_account = "[XXX]"

  }
}

provider "google" {
  impersonate_service_account = "[XXX]"
}
provider "google-beta" {
  impersonate_service_account = "[XXX]"
}


