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

#### Access AzureRM provider configuration

```console
  data "azurerm_client_config" "current" {
    # client_id is set to the Azure Client ID (Application Object ID).
    # tenant_id is set to the Azure Tenant ID.
    # subscription_id is set to the Azure Subscription ID.
    # object_id is set to the Azure Object ID.
  }
```

Eg.:

```console
  output "account_id" {
    value = data.azurerm_client_config.current.client_id
  }
```

### Terraform flow

1. `main.tf` ➡ compares with ➡ `.tfstate`
2. `main.tf` ➡ creates changes ➡ `tfplan`
3. `tfplan` ➡ deploys ➡ public cloud
4. `tfplan` ➡ updates ➡ `.tfstate`

To properly see the plan file: `terraform show -json tfplan >> tfplan.json`

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

 2. Then run terraform init. It will create a file named: `terraform.tfstate` with the current state in Azure.

#### Working in multiple environments

Approches:

1. Workspaces (23_workspaces)
   - Create a workspace:

   ```console
   terraform workspace new <workspace_name>
   ```

   - Select a workspace:

    ```console
    terraform workspace select <workspace_name>
    ```

    - Delete a workspace:

    ```console
    terraform workspace delete <workspace_name>
    ```

    - List a workspace:

    ```console
    terraform workspace list
    ```

   - Resources created in a workspace are bounded to that workspace
   - You can't modify or apply a plan created on a different workspace

2. Modules
3. Folders (22_environments)
