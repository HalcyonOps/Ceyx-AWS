# EC2 Module

A Terraform module to provision AWS EC2 instances following security best practices and organizational standards.

## Overview

This module creates an EC2 instance with configurable options, ensuring security by default and adherence to best practices.

## Features

- **Secure Defaults**: Instances are launched with encryption, restricted public access, and necessary validations.
- **Modularity**: Easily reusable across different projects and environments.
- **Comprehensive Documentation**: Clear instructions and examples for seamless integration.

## Requirements

- Terraform >= 1.5.0
- AWS Provider >= 5.0.0

## Inputs

| Name                          | Description                                                     | Type             | Default        | Required |
|-------------------------------|-----------------------------------------------------------------|------------------|----------------|----------|
| `create`                      | Whether to create an EC2 instance.                              | `bool`           | `true`         | no       |
| `name`                        | Base name for all resources within the EC2 module.              | `string`         | n/a            | yes      |
| `environment`                 | Deployment environment (e.g., dev, staging, prod).              | `string`         | n/a            | yes      |
| `project`                     | Project name associated with the EC2 resources.                 | `string`         | n/a            | yes      |
| `owner`                       | The owner of the EC2 instance.                                  | `string`         | n/a            | no       |
| `vpc_id`                      | The ID of the VPC where resources will be deployed.             | `string`         | n/a            | yes      |
| `subnet_id`                   | The ID of the subnet within the VPC for deploying EC2 instances.| `string`         | n/a            | yes      |
| ...                           | ...                                                             | ...              | ...            | ...      |

*Refer to `variables.tf` for detailed variable descriptions and validations.*

## Outputs

| Name             | Description                           |
|------------------|---------------------------------------|
| `instance_id`    | The ID of the EC2 instance.           |
| `public_ip`      | The public IP address of the instance.|
| `private_ip`     | The private IP address of the instance.|
| `security_group_ids` | The security groups assigned to the instance.|

## Usage

```terraform
module "ec2" {
    source = "./modules/compute/ec2"
    create = true
    name = "my-ec2-instance"
    environment = "prod"
    project = "Ceyx"
    owner = "DevOps Team"
    vpc_id = "vpc-12345678"
    subnet_id = "subnet-12345678"
    instance_type = "t3.medium"
    ami_id = "ami-0abcdef1234567890"
    associate_public_ip_address = false
    tags = {
        Department = "Engineering"
        CostCenter = "12345"
    }
}
```

## Example

Check out the [examples](../../examples/) directory for practical implementation examples.

## Testing

Ensure all tests pass by running:

```bash
terraform init -backend=false
terraform validate
```

## License

This module is licensed under the [Apache License 2.0](../../LICENSE).

## Contributing

Please refer to our [Contributing Guide](../../CONTRIBUTING.md) for details on how to contribute to this module.
