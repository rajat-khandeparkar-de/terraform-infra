# Terraform Architecture

## What is Terraform?

1. **Terraform** is an open-source **Infrastructure as Code (IaC)** tool created by **HashiCorp**.
2. It is used to provision and manage services like servers, databases, IAM roles, policies, networking, storage, and more.
3. Terraform uses a high-level declarative configuration language called **HashiCorp Configuration Language (HCL)**.

---

## Core Components of Terraform Architecture

### 1. Terraform CLI (Command Line Interface)
- The primary tool for interacting with Terraform.
- Performs key operations: `init`, `plan`, `apply`, and `destroy`.
- Reads configuration files written in HCL.

### 2. Configuration Files (`.tf`)
- Define the **desired state** of infrastructure using HCL.
- Common elements include:
  - **Providers** (e.g., AWS, Azure, GCP)
  - **Resources** (e.g., `aws_instance`, `aws_s3_bucket`)
  - **Modules** (Reusable infrastructure code blocks)
  - **Variables**, **Outputs**, **Locals**, **Data Sources**

### 3. Terraform Providers
- Act as plugins to interact with APIs of various cloud platforms and services.
- Example: `hashicorp/aws`

### 4. Terraform State
- Maintains the **terraform.tfstate** file which maps your configuration to the real infrastructure.
- Critical for tracking changes and generating execution plans.

### 5. Terraform Backend
- Defines **where and how** Terraform state is stored.
- Examples:
  - **Local backend** (default)
  - **Remote backends** like AWS S3, Azure Blob Storage, GCP GCS
- Often used with **DynamoDB** (for state locking in AWS).

### 6. Terraform Modules
- Reusable blocks of Terraform code.
- Promote **DRY** (Don't Repeat Yourself) principles and help standardize infrastructure across environments.

---

