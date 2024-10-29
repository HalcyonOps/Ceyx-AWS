# **Standard Operating Procedure (SOP) for Developing Terraform Modules**

---

**Table of Contents**

1. [Introduction](#1-introduction)
2. [Module Structure](#2-module-structure)
3. [Project Structure](#3-project-structure)
4. [Coding Standards](#4-coding-standards)
5. [Variable Definitions](#5-variable-definitions)
6. [Variable Validations](#6-variable-validations)
7. [Resource Configuration](#7-resource-configuration)
8. [Submodules](#8-submodules)
9. [Outputs](#9-outputs)
10. [Documentation](#10-documentation)
11. [Examples](#11-examples)
12. [Testing and Validation](#12-testing-and-validation)
13. [Versioning and Release Management](#13-versioning-and-release-management)
14. [Best Practices](#14-best-practices)
15. [Final Notes](#15-final-notes)


---

## **1. Introduction**

This Standard Operating Procedure (SOP) provides guidelines and best practices for developing Terraform modules within the project. It aims to ensure consistency, maintainability, and usability across modules and projects, aligning with the existing project structure and standards.

---

## **2. Module Structure**

Modules should be organized under a top-level `modules/` directory, with each module containing its own resources and submodules.

### **Module Directory Layout**

```
modules/
└── your-module-name/
    ├── README.md
    ├── main.tf
    ├── variables.tf
    ├── outputs.tf
    ├── versions.tf
    └── submodules/
        └── submodule-name/
            ├── main.tf
            ├── variables.tf
            └── outputs.tf
```

### **File Descriptions**

- **README.md**: Documentation explaining the module's purpose, usage, inputs, outputs, and examples.
- **main.tf**: Contains the primary resource definitions.
- **variables.tf**: Defines input variables with descriptions and defaults.
- **outputs.tf**: Specifies the outputs that the module will return.
- **versions.tf**: Specifies the required Terraform and provider versions.
- **submodules/**: Contains any submodules for modularization.
  - **submodule-name/**: Directory for a submodule.
    - **main.tf**: Submodule resource definitions.
    - **variables.tf**: Submodule input variables.
    - **outputs.tf**: Submodule outputs.

---

## **3. Project Structure**

The overall project structure should be organized to enhance clarity and maintainability.

### **Project Directory Layout**

```
.
├── LICENSE
├── README.md
├── backend/
├── docs/
├── examples/
├── modules/
├── patterns/
├── templates/
├── tests/
└── versions/
```

### **Components**

- **LICENSE**: Project licensing information.
- **README.md**: Project overview and instructions.
- **backend/**: Backend configurations (e.g., DynamoDB, S3 for state locking).
- **docs/**: Documentation, including architecture decisions, diagrams, and module documentation.
- **examples/**: Sample configurations demonstrating module usage.
- **modules/**: Terraform modules categorized by functionality (e.g., compute, network, storage).
- **patterns/**: Infrastructure patterns (e.g., microservices, three-tier architectures).
- **templates/**: Terraform templates for different setups (e.g., basic, enterprise).
- **tests/**: Testing code, including fixtures, integration, and unit tests.
- **versions/**: Terraform version constraints and configurations.

### **Example Project Tree**

```
.
├── LICENSE
├── README.md
├── backend/
│   ├── s3.tf
│   └── dynamodb.tf
├── docs/
│   ├── architecture/
│   │   ├── decisions/
│   │   └── diagrams/
│   └── modules/
├── examples/
│   ├── example-1/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   ├── versions.tf
│   │   └── terraform.tfvars.example
│   └── example-2/
│       ├── main.tf
│       ├── variables.tf
│       ├── outputs.tf
│       ├── versions.tf
│       └── terraform.tfvars.example
├── modules/
│   ├── compute/
│   │   ├── module-a/
│   │   └── module-b/
│   ├── network/
│   │   ├── module-a/
│   │   └── module-b/
│   └── storage/
│       ├── module-a/
│       └── module-b/
├── patterns/
│   ├── pattern-a/
│   └── pattern-b/
├── templates/
│   ├── basic/
│   └── enterprise/
├── tests/
│   ├── fixtures/
│   │   └── module/
│   ├── integration/
│   └── unit/
└── versions/
    ├── experimental.tf
    └── stable.tf
```

---

## **4. Coding Standards**

Maintaining a consistent coding style improves readability and collaboration.

### **Naming Conventions**

- **Variables and Outputs**: Use `snake_case`.
- **Resources and Data Sources**: Use `snake_case`.
- **Modules and Directories**: Use `kebab-case` for directories and `snake_case` for files.

### **Formatting**

- **Indentation**: Use 2 spaces per indentation level.
- **Line Length**: Limit lines to 80 characters when possible.
- **Quotes**: Use double quotes `"` for strings.
- **Comments**: Use `#` for inline comments.

### **Resource Organization**

- Group related resources together within the file.
- Use comments to separate logical sections.

---

## **5. Variable Definitions**

Define all input variables in `variables.tf` with clear descriptions, types, and default values where appropriate.

### **Variable Declaration Format**

```hcl
variable "variable_name" {
  description = "A brief description of the variable."
  type        = <type>
  default     = <default_value> (if applicable)

  validation {
    condition     = <condition_expression>
    error_message = "Error message displayed if validation fails."
  }
}
```

### **Variable Types**

- Use explicit types:
  - `string`
  - `number`
  - `bool`
  - `list(<type>)`
  - `map(<type>)`
  - `object({ <attribute_name> = <type>, ... })`
- Use `optional` attributes for object properties when necessary.

### 5.1 Core Principles

1. **Organization**: Variables should be logically grouped and ordered by importance
2. **Documentation**: Every variable requires clear descriptions and examples
3. **Validation**: Include comprehensive validation rules for critical inputs
4. **Defaults**: Provide sensible defaults for optional variables

### 5.2 Variable Groups and Order

1. **Core Configuration** (Always First)
   - Creation flags (`create`, `enabled`)
   - Resource naming
   - Environment settings
   Example:
   ```hcl
   # Core Configuration
   variable "name" {
     description = "Name to be used on all resources"
     type        = string
   }

   variable "enabled" {
     description = "Whether to create the resources"
     type        = bool
     default     = true
   }
   ```

2. **Primary Resource Configuration**
   - Main resource settings
   - Core behavior flags
   - Resource type options

3. **Network Configuration**
   - VPC settings
   - Subnet configurations
   - IP addressing options

4. **Security Configuration**
   - Security groups
   - IAM roles
   - Access controls

5. **Storage Configuration**
   - Volume settings
   - Additional storage options
   - Backup configurations

6. **Feature Configuration**
   - Optional features
   - Feature-specific settings
   - Integration options

7. **Monitoring and Management**
   - CloudWatch settings
   - Metrics configuration
   - Maintenance options

8. **Tags and Labels** (Always Last)
   - Resource tags
   - Additional labels

### 5.3 Variable Types and Validation

1. **Simple Types**
   - `string`
   - `number`
   - `bool`

2. **Complex Types**
   - `list(<type>)`
   - `map(<type>)`
   - `object({ <attribute_name> = <type>, ... })`
   - Use `optional()` for optional object properties

3. **Validation Patterns**

   a. **Format Validation**
   ```hcl
   variable "bucket_name" {
     description = "The name of the S3 bucket"
     type        = string
     validation {
       condition     = can(regex("^[a-z0-9.-]+$", var.bucket_name))
       error_message = "Bucket name must contain only lowercase letters, numbers, dots, and hyphens."
     }
   }
   ```

   b. **Dependent Variable Validation**
   ```hcl
   variable "logging_target_bucket" {
     description = "S3 bucket for storing logs when logging is enabled"
     type        = string
     default     = null
     validation {
       condition     = var.enable_logging == false || (var.enable_logging == true && var.logging_target_bucket != null)
       error_message = "When logging is enabled, logging_target_bucket must be specified."
     }
   }
   ```

   c. **Complex Type Validation**
   ```hcl
   variable "additional_ebs_volumes" {
     description = "List of additional EBS volumes to attach"
     type = list(object({
       size = number
       type = string
       iops = optional(number)
     }))
     validation {
       condition = alltrue([
         for volume in var.additional_ebs_volumes :
         contains(["standard", "gp2", "gp3", "io1", "io2", "sc1", "st1"], volume.type)
       ])
       error_message = "EBS volume type must be one of: standard, gp2, gp3, io1, io2, sc1, st1."
     }
   }
   ```

### 5.4 Documentation Requirements

1. **Variable Descriptions**
   - Purpose of the variable
   - Expected format/values
   - Dependencies on other variables
   - Default behavior when optional

2. **Example Values**
   - Include example values in comments
   - Show multiple examples for complex types
   - Document valid ranges or constraints

3. **Default Values**
   - Document reasoning behind defaults
   - Consider environment-specific defaults
   - Use `null` for optional variables without logical defaults

4. **Validation Rules**
   - Document validation constraints
   - Explain error messages
   - Note any AWS-specific requirements

---

## **6. Variable Validations**

Implement variable validations to catch errors early and provide clear feedback to users.

### **Validation Guidelines**

- Use `validation` blocks within variable declarations.
- Ensure that validations cover:
  - Value ranges (e.g., length, numerical ranges).
  - Format checks using regular expressions.
  - Dependency checks (e.g., if one variable is set, another must also be set).

### **Example Validation**

```hcl
variable "ami_id" {
  description = "ID of AMI to use for the instance."
  type        = string

  validation {
    condition     = can(regex("^ami-[a-f0-9]{8,17}$", var.ami_id))
    error_message = "AMI ID must be in the format 'ami-xxxxxxxx' or 'ami-xxxxxxxxxxxxxxxxx'."
  }
}
```

---

## **7. Resource Configuration**

Define resources in `main.tf`, using variables and locals to parameterize configurations.

### **Resource Naming**

- Use descriptive resource names.
- Reference variables and locals for dynamic values.

### **Conditional Resource Creation**

- Use `count` or `for_each` to conditionally create resources based on input variables.
- Example:

```hcl
resource "aws_instance" "this" {
  count = var.enable_autoscaling ? 0 : 1

  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  # Additional configuration...
}
```

### **Dynamic Blocks**

- Use `dynamic` blocks to handle variable nested configurations.
- Example:

```hcl
dynamic "ebs_block_device" {
  for_each = var.additional_ebs_volumes
  content {
    device_name = ebs_block_device.value.device_name
    volume_size = ebs_block_device.value.volume_size
    # Additional configuration...
  }
}
```

---

## **8. Submodules**

Break down complex modules into submodules to promote modularity and reuse.

### **When to Use Submodules**

- When a feature can be optional or has its own set of resources.
- To organize code logically and keep the main module manageable.

### **Submodule Structure**

Each submodule should have its own:

- `main.tf`
- `variables.tf`
- `outputs.tf` (if needed)
- `README.md` (optional but recommended)

### **Including Submodules**

Reference submodules in the main module using `module` blocks.

```hcl
module "logging" {
  source        = "./submodules/logging"
  enabled       = var.enable_logging
  bucket_id     = aws_s3_bucket.this.id
  target_bucket = var.logging_target_bucket
  target_prefix = var.logging_target_prefix
}
```

---

## **9. Outputs**

Define outputs in `outputs.tf` to expose values from the module.

### **Output Declaration Format**

```hcl
output "output_name" {
  description = "A brief description of the output."
  value       = <expression>
}
```

### **Best Practices**

- Provide descriptions for all outputs.
- Only output values that are necessary for users.
- Consider sensitive data and avoid outputting secrets.

## **9.1 Output Organization**

Outputs should be organized into logical groups with clear comments separating each section:
### **Standard Output Groups**

1. **Resource Identifiers**
   - Primary IDs (instance_id, volume_id)
   - ARNs
   - Resource names
   - Creation timestamps

2. **Network Information**
   - IP addresses (public, private)
   - Network interface IDs
   - DNS names
   - VPC/subnet information

3. **Security Information**
   - Security group IDs
   - IAM role ARNs
   - Access-related outputs
   - Encryption details

4. **Configuration Details**
   - Resource types/sizes
   - Resource-specific settings
   - Feature flags
   - Operating parameters

5. **Status Information**
   - Resource states
   - Health checks
   - Availability information
   - Lifecycle states

### **Output Best Practices**

1. **Error Handling**
   ```hcl
   output "example" {
     value = try(resource.id, "")
   }
   ```
   - Use `try()` for nullable values
   - Provide sensible defaults
   - Handle list/map scenarios appropriately

2. **Documentation**
   - Clear descriptions explaining the purpose
   - Note any dependencies between outputs
   - Document any transformations applied
   - Include example values where helpful

3. **Naming Conventions**
   - Use snake_case consistently
   - Group related outputs with common prefixes
   - Be specific but concise
   - Follow AWS naming patterns where applicable

4. **Value Processing**
   - Convert CamelCase to snake_case for consistency
   - Handle empty/null values gracefully
   - Format complex types appropriately
   - Maintain type consistency

---

### **Module Testing Checklist**

Before considering a module complete, verify:

1. Variable Organization
   - Variables are grouped logically
   - All groups have clear comments
   - Validation rules are in place
   - Default values are appropriate

2. Output Organization
   - Outputs are grouped logically
   - Error handling is in place
   - Sensitive outputs are marked
   - Descriptions are clear

3. Example Implementation
   - Basic example exists
   - Complex example exists
   - All variables are demonstrated
   - All outputs are utilized

---

## **10. Documentation**

Provide clear and comprehensive documentation in `README.md`.

### **README Structure**

1. **Title**: Name of the module.
2. **Description**: Brief overview of the module's purpose.
3. **Usage**: Code examples showing how to use the module.
4. **Inputs**: Table listing all input variables with descriptions and defaults.
5. **Outputs**: Table listing all outputs with descriptions.
6. **Requirements**: Terraform and provider version requirements.
7. **Providers**: List of required providers.
8. **Modules**: List of included submodules.
9. **Resources**: List of resources created by the module.
10. **Authors**: Module authors.
11. **License**: Licensing information.

### **Example Input Variables Table**

| Name                | Description                         | Type     | Default   | Required |
|---------------------|-------------------------------------|----------|-----------|----------|
| `bucket_name`       | The name of the S3 bucket.          | `string` | n/a       | yes      |
| `acl`               | The canned ACL to apply.            | `string` | `"private"` | no     |
| `enable_versioning` | Enable versioning for the bucket.   | `bool`   | `false`   | no       |

---

## **11. Examples**

Include example configurations under the `examples/` directory to demonstrate module usage.

### **Example Directory Structure**

```
examples/
└── example-name/
    ├── main.tf
    ├── variables.tf
    ├── outputs.tf
    ├── versions.tf
    └── terraform.tfvars.example
```

### **Best Practices**

- Provide examples for different use cases.
- Include `README.md` files in example directories explaining the scenario.
- Ensure examples are kept up-to-date with the module.

---

## **12. Testing and Validation**

Ensure modules work as intended and adhere to standards.

### **Static Code Analysis**

- Run `terraform fmt` to format code.
- Use `terraform validate` to check for errors.
- Utilize tools like `tflint` for linting.

### **Automated Testing**

- Write tests using Terratest or similar frameworks.
- Organize tests under the `tests/` directory.
- Include both unit and integration tests where applicable.

### **Testing Directory Structure**

```
tests/
├── fixtures/
│   └── module-fixture/
├── integration/
│   └── module_test.go
└── unit/
    └── module_unit_test.go
```

---

## **13. Versioning and Release Management**

Manage changes to modules systematically.

### **Semantic Versioning**

- Use semantic versioning (MAJOR.MINOR.PATCH).
  - **MAJOR**: Incompatible API changes.
  - **MINOR**: Add functionality in a backward-compatible manner.
  - **PATCH**: Backward-compatible bug fixes.

### **Changelog**

- Maintain a `CHANGELOG.md` documenting changes for each release.

---

## **14. Best Practices**

- **Security**: Implement secure defaults (e.g., block public access to S3 buckets).
- **Simplicity**: Keep modules simple; avoid unnecessary complexity.
- **Flexibility**: Allow customization through variables but provide sensible defaults.
- **Reusability**: Design modules to be reusable across different projects.
- **Compatibility**: Specify and test with supported Terraform and provider versions.
- **Documentation**: Keep documentation up-to-date and clear.
- **Consistency**: Follow coding standards and conventions consistently across all modules.
- **Automation**: Leverage CI/CD pipelines for automated testing and deployment.

---

## **15. Final Notes**

Adhering to this SOP ensures that Terraform modules are developed consistently, are maintainable, and provide a positive experience for users and contributors. Regularly reviewing and updating this SOP can help incorporate evolving best practices and organizational needs.

---

**End of SOP**