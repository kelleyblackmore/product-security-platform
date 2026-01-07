# security-group

Terraform module for creating AWS security groups with ingress/egress rules.

## Usage

```hcl
module "app_sg" {
  source      = "../../modules/security-group"
  name        = "app-sg"
  description = "Security group for application tier"
  vpc_id      = var.vpc_id
  
  ingress = [
    {
      cidr      = "10.0.0.0/8"
      from_port = 443
      to_port   = 443
      protocol  = "tcp"
    }
  ]
  
  tags = {
    Environment = "production"
  }
}
```
