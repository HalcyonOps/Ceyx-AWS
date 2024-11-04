![Build Status](https://github.com/HalcyonWorks/Ceyx-AWS/actions/workflows/main.yml/badge.svg)
![License](https://img.shields.io/badge/license-Apache%202.0-blue.svg)
![Terraform](https://img.shields.io/badge/Terraform-1.5.0-blue)

# Ceyx AWS Infrastructure as Code

Welcome to **Ceyx**, your comprehensive solution for managing AWS infrastructure using Terraform. This repository contains well-structured Terraform modules, patterns, and templates designed to streamline your infrastructure deployment, ensuring security, scalability, and maintainability.

## Table of Contents

1. [Introduction](#1-introduction)
2. [Features](#2-features)
3. [Prerequisites](#3-prerequisites)
4. [Environment Setup](#4-environment-setup)
5. [Usage](#5-usage)
6. [Resource Tagging Guidelines](#6-resource-tagging-guidelines)
7. [Contributing](#7-contributing)
8. [Testing](#8-testing)
9. [Documentation](#9-documentation)
10. [License](#10-license)
11. [Code of Conduct](#11-code-of-conduct)
12. [References](#12-references)

---

## **1. Introduction**

Ceyx is engineered to provide a robust framework for deploying and managing AWS resources using Terraform. By adhering to best practices and standardized configurations, Ceyx ensures that your infrastructure is secure, efficient, and easy to maintain.

## **2. Features**

- **Modular Architecture:** Reusable Terraform modules for various AWS services.
- **Secure by Default:** Implements security best practices to safeguard your infrastructure.
- **Comprehensive Tagging:** Facilitates resource management and cost tracking through standardized tagging.
- **Automated Documentation:** Generates up-to-date documentation using `terraform-docs`.
- **Pre-commit Hooks:** Ensures code quality and compliance before commits.
- **Automated Testing:** Integrates testing frameworks to validate infrastructure configurations.

## **3. Prerequisites**

Before getting started, ensure you have the following tools installed:

- [Git](https://git-scm.com/)
- [Terraform](https://www.terraform.io/downloads) (version 1.5.x or higher)
- [Go](https://golang.org/dl/) (version 1.22.x or higher)
- [Python](https://www.python.org/downloads/) (version 3.x)
- [pip](https://pip.pypa.io/en/stable/installation/)
- [Pre-commit](https://pre-commit.com/) (installed via `pip`)

## **4. Environment Setup**

Set up your development environment by following the [Environment Setup Guide](ENVIRONMENT.md). This includes installing necessary tools such as `terraform-docs`, `Checkov`, and `Trivy`, as well as configuring pre-commit hooks to enforce code quality and compliance.

## **5. Usage**

### **5.1. Initialize Terraform**

Navigate to your desired module directory and initialize Terraform:

```bash
terraform init
```

### **5.2. Plan Infrastructure Changes**

Generate and review an execution plan:

```bash
terraform plan
```

### **5.3. Apply Changes**

Apply the planned changes to your AWS environment:

```bash
terraform apply
```

### **5.4. Example Module Usage**

Here's how to use the EC2 module with required and optional parameters:

```hcl
module "ec2_instance" {
  source               = "./modules/compute/ec2"
  ami_id               = "ami-0abcdef1234567890"
  instance_type        = "t3.micro"
  subnet_id            = "subnet-0abc1234def567890"
  allow_public_access  = false
  associate_public_ip_address = false

  tags = merge(
    local.resource_tags,
    {
      Project      = local.project_prefix
      Environment  = var.environment
      Owner        = var.owner
      CostCenter   = var.cost_center
      Application  = var.application
    }
  )
}
```

## **6. Resource Tagging Guidelines**

Consistent and comprehensive tagging is crucial for managing, auditing, and optimizing AWS resources. Adhere to the [Resource Tagging Standards](STANDARDS.md#224-testing-and-validation) outlined in our standards document.

### **6.1 Mandatory Tags**

- **`Project`**: Identifies the project name.
  - *Example:* `Project = "terraform-xyz"`
- **`Environment`**: Specifies the deployment environment.
  - *Values:* `dev`, `staging`, `prod`
  - *Example:* `Environment = "production"`
- **`Owner`**: Indicates the team or individual responsible for the resource.
  - *Example:* `Owner = "backend-team"`
- **`CostCenter`**: Associates the resource with a specific cost center.
  - *Example:* `CostCenter = "FIN-001"`

### **6.2 Optional Tags**

- **`Application`**: Names the application using the resource.
  - *Example:* `Application = "user-service"`
- **`Version`**: Denotes the version of the resource or application.
  - *Example:* `Version = "v1.2.3"`
- **`Department`**: Specifies the department owning the resource.
  - *Example:* `Department = "Engineering"`

For detailed guidelines and implementation examples, refer to the [STANDARDS.md](STANDARDS.md).

## **7. Contributing**

We welcome contributions! Please refer to our [Contributing Guide](CONTRIBUTING.md) for detailed instructions on how to get started.

## **8. Testing**

Ensure the integrity of your infrastructure configurations by following our testing protocols:

1. **Static Code Analysis:** Run `terraform fmt`, `terraform validate`, and `tflint`.
2. **Automated Testing:** Utilize Terratest for comprehensive testing and Terraform unit tests for individual modules.
3. **Pre-commit Hooks:** Ensure all pre-commit hooks pass before committing changes.

For more information, see the [Testing and Validation](STANDARDS.md#4-testing-and-validation) section in our standards document.

## **9. Documentation**

Maintain up-to-date documentation to facilitate ease of use and onboarding:

- **Module Documentation:** Each module contains a `README.md` with usage instructions and examples.
- **Automated Documentation Generation:** Use `terraform-docs` to keep documentation current.
- **Environment Setup Guide:** Refer to [ENVIRONMENT.md](ENVIRONMENT.md) for setting up your local environment.
- **Deployment Guides:** Utilize workflow templates located in `.github/workflows/templates/` for deploying infrastructure.
- **Security Scanning Workflows:** Refer to `.github/workflows/security-scan.yml` for integrating security scans into CI.

## **10. License**

This project is licensed under the [Apache License 2.0](LICENSE).

## **11. Code of Conduct**

Please adhere to our [Code of Conduct](CODE_OF_CONDUCT.md) to ensure a welcoming and respectful environment for all contributors.

## **12. References**

- [Terraform Module Best Practices](https://www.terraform.io/language/modules/develop/best-practices)
- [Terraform Variable Validation](https://www.terraform.io/language/values/variables#validation-blocks)
- [AWS Well-Architected Framework – Security Pillar](https://docs.aws.amazon.com/wellarchitected/latest/security-pillar/welcome.html)
- [AWS Security Best Practices](https://docs.aws.amazon.com/securityhub/latest/userguide/securityhub-standards-cis.html)
- [Terraform Automation Best Practices](https://www.terraform.io/language/modules/develop/best-practices#automation)
- [Conventional Commits Specification](https://www.conventionalcommits.org/en/v1.0.0/)
- [Pre-commit Hooks Documentation](https://pre-commit.com/)
- [Terraform-docs Documentation Generation](https://terraform-docs.io/)
- [Checkov](https://www.checkov.io/)
- [Terratest Documentation](https://terratest.gruntwork.io/)
- [Trivy](https://aquasecurity.github.io/trivy/)

---
