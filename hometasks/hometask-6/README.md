# Homework 6 – HTTPS ALB with ACM & Route 53

## Goal

Provision an HTTPS Application Load Balancer in front of an Auto Scaling Group
of EC2 instances. TLS is terminated at the ALB with an ACM certificate, and a
Route 53 alias record exposes the app via a custom domain.

## Architecture

- VPC and subnets are **imported** from Homework 3 via `terraform_remote_state`.
- Internet-facing ALB in public subnets.
- Target group with EC2 instances in private subnets.
- Auto Scaling Group (min 1, max 3) using a launch template.
- Security groups:
  - `alb` – allows 80/443 from the internet.
  - `web` – allows 80 **only** from the ALB SG.
- User data installs `httpd` and serves a simple “Hello World” page.
- ACM certificate for `n8n-create.com` validated via Route 53 DNS.
- Route 53 public hosted zone and `A` alias record for `n8n-create.com`.
- HTTP (80) listener redirects to HTTPS (443); HTTPS uses ACM cert.

## Files

- `01-versions.tf` – Terraform and AWS provider versions
- `02-providers.tf` – AWS provider (region)
- `03-backend.tf` – S3 backend for this stack
- `04-remote_state.tf` – import VPC / subnets from hometasks-3
- `99-variables.tf` – `env`, base `tags`, `instance_type`
- `05-locals.tf` – naming and tagging (`name_prefix`, `common_tags`, `alb_tags`, `web_tags`)
- `06-data_source.tf` – Amazon Linux 2023 AMI data source
- `07-sg_alb.tf` – ALB security group + ingress/egress rules
- `08-sg_instance.tf` – web/EC2 security group + rules
- `09-launch_template.tf` – EC2 launch template + user data page
- `10-alb.tf` – ALB, target group, HTTP→HTTPS redirect, HTTPS listener
- `11-asg.tf` – Auto Scaling Group and tag propagation
- `aws_acm_certificate.tf` – ACM certificate for `n8n-create.com`
- `domain_validation_options.tf` – Route 53 records for ACM validation
- `aws_route53_zone.tf` – Hosted zone `n8n-create.com`
- `aws_route53_record.tf` – `A` alias record pointing to the ALB

## Prerequisites

- Network stack from Homework 3 applied, with state stored in:
  `s3://terraform-hw-3-bucket/hometasks-3/terraform.tfstate`
- S3 bucket for this stack’s backend exists:
  `terraform-hw-3-bucket`
- A registered domain (here: `n8n-create.com`).
- Registrar nameservers configured to use the NS records from the
  Route 53 hosted zone for `n8n-create.com`.

## Usage

```bash
# initialize backend and providers
terraform init

# inspect changes
terraform plan

# apply infrastructure
terraform apply
