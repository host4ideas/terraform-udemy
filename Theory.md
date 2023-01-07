# IaC

## Declarative

Uses scripting languages (JSON, YAML, XML...).
WYSIWYG, zero chance of mis-configuration (Explicit)

Eg.: ARM Templates, Azure Blueprints, CloudFormation, Terraform, etc

## Imperative

You say what you want. Can lead to mis-configuration as lets you configure as you want (Implicit).
Does more than Declarative.
Uses programming languages (JS, Python, Ruby, etc)

Eg.: AWS Cloud Development, Pulumi, etc

## Terraform

Imperative: YAML, JSON, XML
Declarative, Ruby, JS, Python

| Imperative     |      Both      |  Declarative  |
|:----------:|:-------------:|:------:|
| YAML   | Terraform language |   Ruby  |
| JSON   |                    |  JS   |
| XML    |                    |  Python   |

Makes our Infraestructure Lifecycle changes:

- Reliability: idempotent (no matther how many times you run the IaC, you'll always end up with the same state as expected), consistent, repeatable and predictable.
- Manageability: enable mutation via code, revised with minimal changes.
- Sensibility: Allows infraestructure reliability.

### Provisioning vs deployment vs orchestation

1. Provisioning:
    - Launch a cloud service and  configure it.
    - Providers: Puppet, Ansible, Chef, Bash Scripts, PowerShell, Cloud-Init, etc.

2. Deployment:
    - Delivering a version of your application.
    - Providers: AWS CodePipeline, Harness, Jenkins, GitHub Actions, CircleCI, Azure DevOps, etc.

3. Orchestration:
   - The act of coordinating multiple ssytems or services.
   - Providers: Kubernets, Salt, Fabric, etc.

## Configuration Drift

An unexpected configuration change.

1. Detection
    - A compliance tool.
    - Built-in support eg.: AWS CloudFormstion Drift Protection
    - Storing the state (Terraform states

2. How to correct
    - Terraform (refresh and plan)
    - Redeploy the infraestructure
    - A compliance tool

3. How to prevent:
    - Immutable infraestructure, always create, never reuse (Blue/Green deployment)
    - GitOps PR changes

## GitOps

Link your IaC to use a git repository to introduce a formal process to review and accept changes to infraestrucutre code.

## HashiCorps products

1. Boundary: secure remote acess to systems based on trusted identity
2. Consul: service discovery platform. Provides a full-feature sevice mesh and distributed key-value storage for application configuration.
3. Nomad: scheduling and deployment of tasks across worker nodes in a cluster
4. Packer: tool for building VM images for deployment
5. Terraform: IaC 
6. Terraform Cloud: a place to store and manage IaC
7. Vagrant: building and maintenance of reproducible software-development environments
8. Vault: secrets management, encryption and auditing of secrets
9. Waypoint: modern workflow to build, deploy and release across platforms
