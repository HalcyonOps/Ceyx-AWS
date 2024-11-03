# Contributing to Ceyx

Thank you for your interest in contributing to Ceyx! This guide will help you get started with contributing to our AWS Infrastructure as Code project.

## Code of Conduct

Please read our [Code of Conduct](CODE_OF_CONDUCT.md) before contributing. We are committed to providing a welcoming and inclusive environment for all contributors.

## Getting Started

1. Fork the repository
2. Clone your fork:
```bash
git clone https://github.com/HalcyonWorks/Ceyx-AWS.git
cd ceyx
```

3. Set up your development environment:
   - Install required tools (see [environment setup guide](docs/development/environment-setup.md))
   - Install pre-commit hooks:
```bash
pre-commit install
```

## Development Workflow

1. Create a feature branch:
```bash
git checkout -b feature/your-feature-name
```

2. Make your changes following our standards:
   - Use 2 spaces for indentation
   - Follow [Terraform style conventions](https://www.terraform.io/docs/language/syntax/style.html)
   - Add comments for complex logic
   - Include tests for new features
   - Update documentation as needed

3. Run pre-commit checks:
```bash
pre-commit run --all-files
```

4. Commit your changes using [Conventional Commits](https://www.conventionalcommits.org/):
```bash
git commit -m "feat: add support for custom KMS keys"
```

## Pull Request Process

1. Update documentation:
   - Module README.md files
   - Example configurations
   - Main README.md if needed

2. Ensure all checks pass:
   - Pre-commit hooks
   - Terraform format
   - Terraform validation
   - Documentation generation

3. Submit your PR:
   - Fill out the PR template
   - Link related issues
   - Request review from maintainers

## Module Development

When developing new modules:

1. Follow our module structure:
```
modules/
└── your-module-name/
    ├── README.md
    ├── main.tf
    ├── variables.tf
    ├── outputs.tf
    ├── versions.tf
    └── submodules/
```

2. Include:
   - Clear documentation
   - Example configurations
   - Secure defaults
   - Input validation
   - Proper tagging
   - Resource encryption

## Testing

1. Add examples under `examples/`
2. Include both basic and advanced configurations
3. Test with different AWS provider versions
4. Verify backward compatibility

## Documentation

1. Update module documentation:
   - Description and purpose
   - Usage examples
   - Input/output variables
   - Requirements
   - License information

2. Generate documentation:
```bash
terraform-docs markdown table . > README.md
```

## Questions and Support

- Open an issue for bugs or feature requests
- Join our community discussions
- Contact maintainers for security issues

## License

By contributing, you agree that your contributions will be licensed under the [Apache License 2.0](LICENSE).
