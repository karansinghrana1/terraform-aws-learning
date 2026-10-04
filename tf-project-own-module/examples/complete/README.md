# Terraform VPC Module

## Overview

This Terraform project creates an AWS VPC with **public and private subnets**.

It also provides internet connectivity for the public subnets using an **Internet Gateway and Route Table**.

---

## What Does It Do?

### 1. Creates a VPC

Creates a private network in AWS.

```hcl
resource "aws_vpc" "main" {
  cidr_block = var.vpc_config.cidr_block
}
```

Example:

```text
VPC: 10.0.0.0/16
```

---

### 2. Creates Subnets

Creates multiple subnets inside the VPC.

```hcl
resource "aws_subnet" "main" {
  for_each = var.subnet_config

  cidr_block        = each.value.cidr_block
  availability_zone = each.value.az
}
```

Example:

```text
Public Subnet  → 10.0.1.0/24
Private Subnet → 10.0.2.0/24
```

---

### 3. Separates Public and Private Subnets

The configuration identifies which subnets should be public or private.

```hcl
public = true
```

means the subnet is public.

```hcl
public = false
```

means the subnet is private.

Example:

```hcl
subnet_config = {
  public-subnet = {
    cidr_block = "10.0.1.0/24"
    az         = "us-east-1a"
    public     = true
  }

  private-subnet = {
    cidr_block = "10.0.2.0/24"
    az         = "us-east-1a"
    public     = false
  }
}
```

---

### 4. Creates an Internet Gateway

If there is at least one public subnet, an Internet Gateway is created.

```hcl
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
}
```

The Internet Gateway provides a connection between the VPC and the internet.

```text
Internet
   |
Internet Gateway
   |
   VPC
```

---

### 5. Creates a Route Table

A route table is created for the public subnets.

```hcl
route {
  cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.main[0].id
}
```

This means:

```text
Any internet traffic
       ↓
Internet Gateway
```

---

### 6. Connects Public Subnets to the Route Table

The public subnets are connected to the public route table.

```hcl
resource "aws_route_table_association" "main" {
  for_each = local.public_subnet

  subnet_id      = aws_subnet.main[each.key].id
  route_table_id = aws_route_table.main[0].id
}
```

For example:

```text
Public Subnet 1 ──┐
                  ├── Public Route Table ── Internet Gateway
Public Subnet 2 ──┘
```

---

## Example Architecture

```text
                         Internet
                            |
                            |
                    Internet Gateway
                            |
                     Public Route Table
                       /           \
                      /             \
             Public Subnet       Public Subnet
                10.0.1.0/24       10.0.2.0/24
                    |                  |
                   EC2                Web App


                       VPC
                   10.0.0.0/16
                       |
              -------------------
              |
        Private Subnets
         /           \
    Database       Internal App
```

## Usage

This module can be used as a basic network setup for AWS applications.

For example:

- **Public subnet:** EC2 web server
- **Private subnet:** Database
- **Internet Gateway:** Internet connectivity for public resources
- **VPC:** Overall private AWS network

In simple terms, this project creates the **network structure required to run applications inside AWS**.