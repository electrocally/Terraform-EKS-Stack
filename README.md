 EKS - AWS Kubernetes Stack
## Overview
The concept of this project is to be able to have an easily configurable AWS EKS stack complete with:

* Simple single-config setup, with dynamic subnetting, and the ability to run entirely private cluster access,
* Secure, scaleable, eBPF-based networking, with enhanced observability and service-discovery, thanks to [HashiCorp Consul](https://consul.io) and [Cilium CNI](https://cilium.io),
* Per-pod authentication with AWS IAM roles, avoiding ServiceAccount dependencies, thanks to [Uswitch KIAM](https://github.com/uswitch/kiam),
* Envoy-based ingress-controlling, full end-to-end encryption (client to pod), traffic management, and a lot more thanks to [Ambassador API Gateway](https://www.getambassador.io/products/edge-stack/api-gateway/).

All of which can be easily enabled or disabled from one config file.

---

## Warning: This is an untested work in progress. 
### Do not use this for critical or production systems!
### I will not accept any responsibility if everything breaks.
### EKS can be very expensive to run depending on node configuration. 
---

##  Getting Started
This project is built fully on [HashiCorp Terraform](https://terraform.io) , 

---
