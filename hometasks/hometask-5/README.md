# Hometask 5 – ALB + ASG Deployment Using Remote State

## Objective

Deploy an Application Load Balancer (ALB) and an Auto Scaling Group (ASG) using AWS resources in Terraform, while consuming the VPC and subnet outputs created in **Hometask 3** via `terraform_remote_state`.

---

## Remote State Integration

This Hometask does **not** create networking resources.  
Instead, it imports the following outputs from Hometask 3:

- `vpc_id`
- `public_subnet_ids`
- `private_subnet_ids`

These values are passed via `terraform_remote_state` and are used for:

- ALB placement in **public** subnets.
- ASG instance placement in **private** subnets.
- Security group rules referencing VPC.

---

## Application Components

### Application Load Balancer (ALB)

- Deployed in **public subnets**.
- Listeners:
  - HTTP → port `80`
  - HTTPS → port `443` (optional)
- Targets: registered ASG instances.
- Health checks configured for HTTP.

### Security Groups

| Component | Ingress Rules | Egress Rules | Notes |
|---|---|---|---|
| ALB | 80/443 open to world | All outbound | Public facing |
| Web/ASG Instances | 80 only from ALB SG | All outbound | Private only |

Security groups enforce least-privilege:
- Instances never receive inbound traffic directly from the internet.
- Only ALB can reach ASG on port 80.

---

## Auto Scaling Group (ASG)

- Instance count: `min=1`, `desired=2`, `max=3`
- Instance type: `t3.micro`
- AMI: Amazon Linux 2023
- Subnets: **private subnets from Hometask 3**
- Launch template containing:
  - User data bootstrapping web server (HTTPD)
  - Tag specifications for EC2 resources
- Propagate tags on instance launch.

---

## User Data

Instances are bootstrapped on launch via user-data script which:

1. Installs Apache HTTPD.
2. Enables and starts service.
3. Writes a basic HTML page showing hostname.

This allows health checks and ALB integration.

---

## Requirements Met

✔ Uses `terraform_remote_state` to consume VPC resources  
✔ Deploys ALB in public subnets  
✔ Deploys ASG in private subnets  
✔ Configures security groups properly  
✔ Uses Launch Template + instance user-data  
✔ Tags and naming applied across resources  
✔ Architecture matches a real-world public LB → private ASG pattern  

---

## Final Result

After deployment:

- Internet clients hit ALB.
- ALB passes traffic to private ASG instances.
- Instances serve HTTP web page.
- No direct inbound traffic to instances.
- Outbound traffic from private subnets routed via NAT Gateway (created in Hometask 3).
