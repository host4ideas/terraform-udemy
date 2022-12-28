# terraform-course

Course available on Udemy: <https://www.udemy.com/course/deploy-infra-in-the-cloud-using-terraform/>

## Notes

### Provider version constraints

- Allow only patch releases within a specific minor release: `version = "~> 3.33.0"`
- Allow new versions: `version = ">= 3.33.0"`

### Variables

#### Default variables: `variables.tf`

This file is used to declare variables. Example:
`variable "resource_group_name" {
  type        = string
  description = "RG name in Azure"
}`

#### Override variables: `terraform.trvars`

Override default variables (useful for environments). Example:
`resource_group_name     = "example-resources"`

#### Resource creation outputs: `outputs.tf`

Here we can retreive Attributes exported when a resoruce is deployed. Example:
`output "web_app_url" {
  value = azurerm_linux_web_app.example.default_hostname
}`

### Terraform flow

1. `main.tf` ➡ compares with ➡ `.tfstate`
2. `main.tf` ➡ creates changes ➡ `tfplan`
3. `tfplan` ➡ deploys ➡ public cloud
4. `tfplan` ➡ updates ➡ `.tfstate`

#### Working with multiple devs

When more than one person have access to the resources the .tfstate must be stored centrally and locked while someone is making changes.

(04_TF_State)

 1. Create a `backend.tf` with the following:

    ```txt
      terraform {
        backend "azurerm" {
          resource_group_name  = "rsg-tfstate"
          storage_account_name = "tfstate28122022"
          container_name       = "tfstate"
          key                  = "terraform.tfstate"
        }
      }
    ```

 2. Then run terraform init. It will create a file named: `terraform.tfstate` with the current state.

#### Working in multiple environments

Approches:

1. Workspaces
2. Modules
3. Folders (22_environments)
