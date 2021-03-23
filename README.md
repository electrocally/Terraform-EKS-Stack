# EKS - AWS Kubernetes Stack
## Overview
The concept of this project is to be able to have an easily configurable AWS EKS stack complete with:

* Simple single-config setup, with dynamic subnetting, and the ability to run entirely private cluster access,
* Secure, scaleable, eBPF-based networking, with enhanced observability and service-discovery, thanks to [HashiCorp Consul](_https://consul.io_) and / or [Cilium CNI](_https://cilium.io_),
* Per-pod authentication with AWS IAM roles, avoiding ServiceAccount dependencies, thanks to [Uswitch KIAM](_https://github.com/uswitch/kiam_),
* Envoy-based ingress-controlling, full end-to-end encryption (client to pod), traffic management, and a lot more thanks to [Ambassador API Gateway](_https://www.getambassador.io/products/edge-stack/api-gateway/_).

All of which can be easily enabled or disabled from one config file.
This is built using only official Terraform modules & resources, and official Helm charts. 

---

## Warning: This is an untested work in progress. 
### Do not use this for critical or production systems!
### I will not accept any responsibility if everything breaks.
### EKS can be very expensive to run depending on node configuration. 

---

##  Getting Started
This project is built using [HashiCorp Terraform](https://terraform.io) which can be downloaded from [here](https://www.terraform.io/downloads.html). 
There is an assumed base knowledge of Terraform to use this, while it isn’t required, this is not an entry-level introduction to it.

### Configuration

Begin by modifying `configuration/config.tfvars`. This config uses a AWS S3 bucket to store the state Terraform’s changes remotely. I’d recommend keeping it this way.

```json 
region         = "eu-west-1" # AWS Region for the S3 bucket. e.g. eu-west-1.
bucket         = "cd-terraform-states" # The name of your bucket to store this state. This needs to be a unique name, maybe your ClubPenguin username + "-terraform-states" ?
key            = "state/terraform.tfstate" # A directory to where in the bucket you store this state.
encrypt        = true # Encrypt the Terraform state bucket.
```

Next, read over and, if you want to customise this install, modify `configuration/variables.tfvars` This file should be the only thing you need to modify for most setups. It covers stuff such as how many compute nodes you want, how many subnets, what kind of access to the EKS cluster there will be, and a small selection of Kubernetes tools you might want to install after the cluster comes up (a few of my favourites).

---
 
### Planning Out Your New Infrastructure 

To proceed with this step, you’ll need to have an AWS account and be authenticated on the CLI. Not sure how to do that? [How to log in over AWS CLI.](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html)

Now that you’re ready to go, lets initialise this directory using the config file you set up earlier

`terraform init -backend-config configuration/config.tfvars`

Once that’s finished, you can now run 

`terraform plan -var-file configuration/variables.tfvars`

Terraform’s output should detail all that it plans to build for your new environment. If you are happy with this, Proceed to the next step 

---

### Building and Connecting To Your New Infrastructure 

If you’ve gone through the previous step and want to proceed with what Terraform plans to build, execute

`terraform apply -var-file configuration/variables.tfvars`

Entering `yes`  at the prompt.

This process will take anywhere from 15-25 minutes average, depending on configuration. Just take this time to grab a coffee and let the machine do its thing ☕️.

Once complete, to log into your new environment, just run

`aws eks —region {region} update-kubeconfig —name {cluster_name}`