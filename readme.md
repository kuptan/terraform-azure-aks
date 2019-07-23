# Terraform Azure K8S Clusters
This is a terraform module to create Kubernetes clusters on top of Azure AKS

## Module Info
Check the module documentation [here](https://registry.terraform.io/modules/kube-champ/k8s-clusters/azure/latest)

The naming convention of the resources are based on the [Azure Naming Convention](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/naming-and-tagging)

## Usage

```terraform
module "k8s-clusters" {
  source  = "kube-champ/k8s-clusters/azure"
  version = "0.0.2"
  # insert the 5 required variables here
}
```

## Contributing
See contributing docs [here](./docs/CONTRIBUTING.md)