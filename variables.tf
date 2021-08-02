# Do not edit this file, unless you want to, who am I to tell you what to do.
# This file just defines the default variables, all the overrides come from ../configuration/variables.tfvars

# AWS Networking
variable "region" {
  type = string
}

variable "network" {
  type = object({
    vpc_name                = string,
    base_cidr               = string,
    public_subnets_count    = number,
    private_subnets_count   = number,
    public_subnets_newbits  = number,
    private_subnets_newbits = number
  })

  default = {
    vpc_name  = "main"
    base_cidr = "10.0.0.0/16"

    public_subnets_count    = 3
    private_subnets_count   = 3
    public_subnets_newbits  = 8
    private_subnets_newbits = 8
  }
}

# EKS Variables
variable "eks" {
  type = object({
    cluster_name = string,
    compute = object({
      nodes         = number,
      nodes_min     = number,
      nodes_max     = number,
      instance_size = string,
      eks_version   = number,

    })
    networking = object({
      public_access       = bool,
      private_access      = bool,
      public_access_cidrs = any,
      public_access_cidrs = any,
    })
  })

  default = {
    cluster_name = "primary"

    compute = {
      nodes         = 2
      nodes_min     = 2
      nodes_max     = 4
      instance_size = "t3.medium"
      eks_version   = 1.19
    }

    networking = {
      public_access       = true
      private_access      = false
      public_access_cidrs = "0.0.0.0/0"
      public_access_cidrs = "0.0.0.0/0"

    }

  }
}

variable "modules" {
  type = object({
    ambassador_api_gateway = object({
      enabled = bool
      version = string
    })
    cert_manager = object({
      enabled = bool
      version = string
    })
    cilium = object({
      enabled           = bool
      version           = string
      hubble_enabled    = bool
      hubble_ui_enabled = bool
    })
    consul = object({
      enabled = bool
      version = string
    })
    kiam = object({
      enabled = bool
      version = string
    })
  })

  default = {
    ambassador_api_gateway = {
      enabled = true
      version = "6.6.0"
    }
    cert_manager = {
      enabled = true
      version = "v1.2.0"
    }
    cilium = {
      enabled           = true
      version           = "1.9.5"
      hubble_enabled    = false
      hubble_ui_enabled = false
    }
    consul = {
      enabled = true
      version = "0.20.1"
    }
    kiam = {
      enabled = true
      version = "6.0.0"
    }
  }
}
