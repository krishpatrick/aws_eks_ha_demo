resource "kubernetes_namespace" "staging" {
metadata {
    annotations = {
    name = "staging"
    }

    labels = {
    application = "sample-nginx-application"
    }

    name = "staging"
}
}
