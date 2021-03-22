resource "aws_iam_role" "kiam_server" {
  name = "kiam_server"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Version": "2012-10-17",
        "Statement": [
          {
            "Effect": "Allow",
            "Action": [
              "sts:AssumeRole"
            ],
            "Resource": "*"
          }
        ]
      }
    ]
  })

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

resource "helm_release" "kiam" {
  name = "kiam"
  repository = "https://uswitch.github.io/kiam-helm-charts/charts/"
  chart = "kiam"
  version = var.kiam_version

  set {
    name  = "server.roleBaseArn"
    value = aws_iam_role.kiam_server.arn
  }

  set {
    name  = "host.interface"
    value = var.interface_type
  }

  set {
    name  = "server.useHostNetwork"
    value = var.host_network_enable
  }

  set {
    name  = "agent.host.iptables"
    value = var.host_network_iptables
  }

  set {
    name  = "agent.extraArgs.whitelist-route-regexp"
    value = "meta-data"
  }
}

