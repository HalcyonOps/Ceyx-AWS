# Development Environment Setup

## Prerequisites
- Python 3.x
- Git
- Terraform 1.5.x or higher
- Go 1.22.x or higher (for terraform-docs)

## Initial Setup

1. Clone the repository and navigate to the project directory:
```bash
git clone <repository-url>
cd <repository-name>
```

2. Create and activate a Python virtual environment:
```bash
python3 -m venv .venv
source .venv/bin/activate  # for Linux/WSL
```

3. Update pip and install pre-commit:
```bash
python -m pip install --upgrade pip
pip install pre-commit
```

4. Install Go and terraform-docs:

---
  - a. For Linux/WSL:
```bash
# Remove old Go installation if present
sudo rm -rf /usr/local/go

# Download and install latest Go
wget https://go.dev/dl/go1.22.0.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.22.0.linux-amd64.tar.gz
```
  - b. Add the following to your shell configuration file (`.bashrc` or `.zshrc`):
```bash
# Add Go binary path if directory exists
if [ -d "/usr/local/go/bin" ]; then
    export PATH=$PATH:/usr/local/go/bin
fi

if [ -d "$HOME/go/bin" ]; then
    export PATH=$PATH:$HOME/go/bin
fi
```

  - c. Reload your shell configuration:
```bash
source ~/.bashrc  # or source ~/.zshrc
```

  - d. Install terraform-docs:
```bash
go install github.com/terraform-docs/terraform-docs@v0.19.0
```
---

5. Install the git hooks:
```bash
pre-commit install
```

## Verification

1. Verify Go installation:
```bash
go version
```

2. Verify terraform-docs installation:
```bash
terraform-docs --version
```

3. Check that pre-commit is installed correctly:
```bash
pre-commit run --all-files
```

4. Verify the hooks are in place:
```bash
ls -la .git/hooks/pre-commit
```

## Configuration Files

The repository uses several configuration files:

1. `.pre-commit-config.yaml` - Defines the pre-commit hooks for code validation
2. `versions/stable.tf` - Specifies the minimum required versions for Terraform and providers
3. `.gitignore` - Excludes unnecessary files from version control

## Important Notes

- The virtual environment (`.venv/`) is excluded from version control
- Each developer needs to set up their own virtual environment
- Pre-commit hooks will run automatically before each commit
- The hooks will validate:
  - Terraform formatting
  - Version constraints
  - YAML syntax
  - File formatting
  - Large file additions
  - Terraform documentation generation

## Troubleshooting

### Pre-commit Hook Issues
If pre-commit hooks fail:
1. Run `pre-commit run --all-files` to check all files
2. Address any formatting or validation issues
3. Stage the changes and try committing again

### Version Issues
- For Terraform version issues, ensure your version matches requirements in `versions/stable.tf`
- For Go version issues, ensure you're using Go 1.22.x or higher
- For terraform-docs issues, ensure the binary is in your PATH by running `which terraform-docs`

### PATH Issues
If commands are not found after installation:
1. Verify your PATH includes Go directories:
```bash
echo $PATH | grep go
```
2. Ensure shell configuration is loaded:
```bash
source ~/.bashrc  # or source ~/.zshrc
```
