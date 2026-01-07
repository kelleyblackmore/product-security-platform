# Sandbox Environment

Example Terraform environment wiring the account baseline module.

## Prerequisites

- S3 buckets for CloudTrail and Config
- IAM role for Config recorder

## Usage

```bash
cd infra/terraform/envs/sandbox
terraform init
terraform plan -var-file=terraform.tfvars
terraform apply
```

## Required Variables

Create a `terraform.tfvars`:

```hcl
cloudtrail_bucket = "my-org-cloudtrail-bucket"
config_bucket     = "my-org-config-bucket"
config_role_arn   = "arn:aws:iam::123456789012:role/config-role"
```
