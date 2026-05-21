# VPC Setup (Terraform)

This directory contains a minimal Terraform configuration to create an AWS VPC with public subnets and an internet gateway.

Quick start:

1. Initialize Terraform:

```bash
terraform init
```

2. See the planned resources:

```bash
terraform plan -var="region=us-east-1"
```

3. Apply (creates resources):

```bash
terraform apply -var="region=us-east-1"
```

Defaults can be changed via `variables.tf` or by passing `-var` arguments or a `terraform.tfvars` file.
