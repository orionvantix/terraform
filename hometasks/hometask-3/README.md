# Hometask 3 – VPC Network Architecture

## Objective

Implement the following VPC network architecture in Terraform:

- One dedicated VPC for the workload.
- Three Availability Zones, each with:
  - One public subnet.
  - One private subnet.
- Centralized egress from private subnets via a single NAT Gateway in a public subnet.
- Internet access for public subnets via an Internet Gateway.
- Separate public and private route tables with correct associations.

---

## Architecture Summary

**VPC**

- CIDR: `10.0.0.0/16`
- DNS support enabled.
- DNS hostnames enabled.

**Subnets (per AZ)**

- 3 × **public** subnets (one per AZ)  
  Example CIDRs:
  - `10.0.1.0/24`
  - `10.0.2.0/24`
  - `10.0.3.0/24`

- 3 × **private** subnets (one per AZ)  
  Example CIDRs:
  - `10.0.10.0/24`
  - `10.0.11.0/24`
  - `10.0.12.0/24`

Each public subnet is mapped to a public IP on launch (for instances, if needed).  
Private subnets have no direct public IP assignment.

**Internet Connectivity**

- **Internet Gateway (IGW)**
  - Attached to the VPC.
  - Used as the default route target for all public subnets.

- **NAT Gateway**
  - Placed in one of the public subnets.
  - Allocated with an Elastic IP.
  - Used as the default route target for all private subnets to reach the internet.

---

## Route Tables

### Public Route Table

- Associated with **all public subnets**.
- Routes:
  - `10.0.0.0/16` → `local` (default VPC route)
  - `0.0.0.0/0`   → `igw-id` (Internet Gateway)

### Private Route Table

- Associated with **all private subnets**.
- Routes:
  - `10.0.0.0/16` → `local`
  - `0.0.0.0/0`   → `nat-igw-id` (NAT Gateway in public subnet)

---

## Terraform Responsibilities

The Terraform configuration for this homework must:

1. Create the VPC and enable DNS features.
2. Create 3 public and 3 private subnets across 3 Availability Zones.
3. Create and attach an Internet Gateway.
4. Create an Elastic IP and a NAT Gateway in one public subnet.
5. Create:
   - One public route table and associate it with all public subnets.
   - One private route table and associate it with all private subnets.
6. Configure the routes as specified above.

(Optional but recommended for later homeworks):

- Add outputs:
  - `vpc_id`
  - `public_subnet_ids`
  - `private_subnet_ids`
  so other Terraform configurations (e.g. Homework 5) can consume this VPC via `terraform_remote_state`.

# Optimize VPC code by applying count, count.index
# Include outputs.tf file to output vpc_id, public_subnet_ids, private_subnet_ids
