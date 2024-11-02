# Ceyx - AWS Infrastructure Modules

A collection of Terraform modules for AWS infrastructure provisioning, following security best practices and industry standards.

## Overview

This repository contains reusable Terraform modules for AWS infrastructure deployment, with a focus on:
- Security by default
- Modular design
- Comprehensive documentation
- Infrastructure as Code best practices

## Repository Structure

```
.
├── modules/           # Reusable Terraform modules
├── examples/          # Example implementations
├── docs/             # Documentation and SOPs
├── tests/            # Test configurations
└── versions/         # Version constraints
```

## Prerequisites

- Terraform >= 1.5.0
- AWS Provider >= 5.0.0
- Go >= 1.22.0 (for development)
- Python 3.x (for development)

## Available Modules

### Compute
- [EC2](/modules/compute/ec2)
  - Submodules:
    - [Autoscaling Group](/modules/compute/ec2/submodules/autoscaling_group)
    - [EC2 Instance](/modules/compute/ec2/submodules/ec2_instance)
    - [Elastic IP](/modules/compute/ec2/submodules/elastic_ip)
    - [Launch Template](/modules/compute/ec2/submodules/launch_template)
    - [Security Group](/modules/compute/ec2/submodules/security_group)
    - [Spot Instance](/modules/compute/ec2/submodules/spot_instance)

### Storage
- [S3](/modules/storage/s3)
  - Submodules:
    - [Bucket](/modules/storage/s3/submodules/bucket)
    - [Encryption](/modules/storage/s3/submodules/encryption)
    - [Lifecycle](/modules/storage/s3/submodules/lifecycle)
    - [Logging](/modules/storage/s3/submodules/logging)
    - [Replication](/modules/storage/s3/submodules/replication)

## Usage

Each module includes its own README with specific usage instructions. See the `examples/` directory for implementation examples.

## Development

Please see our [Contributing Guide](CONTRIBUTING.md) for development guidelines and setup instructions.

## Documentation

- [Environment Setup](docs/development/environment-setup.md)
- [Module Development SOP](docs/SOP_Module_Development.md)
- [Design Standards](docs/SOP_Design_Standards.md)

## License

Apache 2.0 - See [LICENSE](LICENSE) for more details.
