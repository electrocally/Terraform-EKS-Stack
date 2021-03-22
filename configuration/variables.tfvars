region = "eu-west-1"

network = {
    vpc_name  = "main"
    base_cidr = "10.0.0.0/16"

    public_subnets_count    = 3
    private_subnets_count   = 3
    public_subnets_newbits  = 8
    private_subnets_newbits = 8
}

eks = {
    cluster_name = "primary"

    compute = {
        nodes          = 2
        nodes_min      = 2
        nodes_max      = 4
        instance_size  = "t3.medium"
        eks_version    = 1.19
    }
    
    networking = {
        public_access  = false
        private_access = true

        public_access_cidrs = ""
        public_access_cidrs = ""
    }
}

modules = {
    ambassador_api_gateway = { // https://www.getambassador.io/products/edge-stack/api-gateway/
        enabled = false
        version = "6.6.0"
    }

    cert_manager = { // https://cert-manager.io
        enabled = false
        version = "v1.2.0"
    }

    cilium = { // https://cilium.io
        enabled = false
        version = "1.9.5"
        hubble_enabled    = true
        hubble_ui_enabled = true
    }

    consul = { //https://consul.io
        enabled = false
        version = "0.20.1"
    } 


    kiam = { // https://github.com/uswitch/kiam
        enabled = true
        version = "6.0.0"
        // https://docs.cilium.io/en/v1.9/gettingstarted/local-redirect-policy/#kiam-redirect-on-eks
    }
}