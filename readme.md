# Terraform Azure K8S Clusters
[![CircleCI](https://circleci.com/gh/kube-champ/terraform-azure-k8s-clusters/tree/master.svg?style=shield)](https://circleci.com/gh/kube-champ/terraform-azure-k8s-clusters/tree/master) [![MIT License](https://img.shields.io/apm/l/atomic-design-ui.svg?)](https://github.com/tterb/atomic-design-ui/blob/master/LICENSEs) [![GitHub Release](https://img.shields.io/github/release/kube-champ/terraform-azure-k8s-clusters.svg?style=flat)]() [![PR's Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat)](http://makeapullrequest.com)

This is a terraform module to create Kubernetes clusters on top of Azure AKS

## Module Infos
Check the module documentation [here](https://registry.terraform.io/modules/kube-champ/aks/azure/latest)

The naming convention of the resources are based on the [Azure Naming Convention](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/naming-and-tagging)

## Usage

```terraform
module "aks" {
  source  = "kube-champ/aks/azure"
  ...
}
```

## Contributing
See contributing docs [here](./docs/CONTRIBUTING.md)## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| azuread | n/a |
| azurerm | n/a |
| tls | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| additional\_node\_pools | Additional node pools configuration | <pre>map(object({<br>    subnet_id : string<br>    node_count : number<br>    vm_size : string<br>    os_type : string<br>    os_disk_size_gb : number<br>    auto_scaling_enabled : bool<br>    min_count : number<br>    max_count : number<br>    availability_zones : list(number)<br>  }))</pre> | `{}` | no |
| az\_location | The azure location on which resources are deployed | `string` | `"westeurope"` | no |
| azure\_ad | Azure AD integration config | `object({ rbac_enabled : bool, admins_object_ids : list(string) })` | <pre>{<br>  "admins_object_ids": [],<br>  "rbac_enabled": false<br>}</pre> | no |
| client\_id | Service principal's client ID for AKS service principal configuration | `string` | n/a | yes |
| client\_secret | Service principal's client secret for AKS service principal configuration | `string` | n/a | yes |
| cluster\_network | Advanced networking configuration for AKS | <pre>object({<br>    network_plugin : string<br>    network_policy : string<br>    service_cidr : string<br>    docker_bridge_cidr : string<br>    dns_service_ip : string<br>    load_balancer_sku : string<br>  })</pre> | <pre>{<br>  "dns_service_ip": "10.100.0.10",<br>  "docker_bridge_cidr": "172.17.0.1/16",<br>  "load_balancer_sku": "Standard",<br>  "network_plugin": "azure",<br>  "network_policy": "calico",<br>  "service_cidr": "10.100.0.0/16"<br>}</pre> | no |
| cluster\_version | The kubernetes version | `string` | `"1.18.10"` | no |
| default\_node\_pool | The default node pool configuration | <pre>object({<br>    name : string<br>    node_count : number<br>    vm_size : string<br>    os_disk_size_gb : number<br>    type : string<br>    enable_auto_scaling : bool<br>    min_count : number<br>    max_count : number<br>    availability_zones : list(number)<br>  })</pre> | <pre>{<br>  "availability_zones": [<br>    "1"<br>  ],<br>  "enable_auto_scaling": true,<br>  "max_count": 4,<br>  "min_count": 1,<br>  "name": "d4v3",<br>  "node_count": 2,<br>  "os_disk_size_gb": 30,<br>  "type": "VirtualMachineScaleSets",<br>  "vm_size": "Standard_D4_v3"<br>}</pre> | no |
| environment | The environment name (dev, staging, prod, etc...) | `string` | `"dev"` | no |
| kube\_dashboard\_enabled | A flag to enable/disable kubernetes dashboard | `bool` | `false` | no |
| name | The cluster name | `string` | n/a | yes |
| private\_cluster\_enabled | A flag to enable/disable private clusters | `bool` | `false` | no |
| subnet\_id | The subnet id where the AKS cluster should be attached to | `string` | n/a | yes |
| tags | Additional tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| client\_certificate | n/a |
| client\_key | n/a |
| cluster\_ca\_certificate | n/a |
| fqdn | n/a |
| host | n/a |
| id | n/a |
| name | n/a |
| node\_resource\_group\_name | n/a |
| private\_ssh\_key | n/a |
| public\_ssh\_key | n/a |
| resource\_group\_name | n/a |

