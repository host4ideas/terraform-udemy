variable "rsg_name" {
  type        = string
  description = "Resource Group name"
}

variable "rsg_location" {
  type        = string
  description = "Storage Account location"
}

variable "sg_account_name" {
  type        = string
  description = "Storage Account name"
}

variable "container_name" {
  type        = string
  description = "Storage Container to save the state file"
}
