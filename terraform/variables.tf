variable "enable_telemetry" {
  type        = bool
  description = "Enable telemetry for the module"
  default     = false
}

variable "cidr_addr" {
  description = "CIDR address space for the virtual network"
  type        = string
  default     = "10.16.0.0/21"
}

variable "address_prefixes_ordered" {
  type        = map(number)
  description = "The size of the subnets"
  default = {
    "a" = 28
    "b" = 28
    "c" = 27
    "d" = 25
    "e" = 27
    "f" = 28
    "g" = 27
    "h" = 27
    "i" = 26
    "j" = 26
    "k" = 27
  }
}

variable "subscription_mode" {
  type    = string
  default = "Existing"
}

# variable "subscription_name" {
#   type        = string
#   description = "Name of the subscription (from pipeline parameter)"
#   default     = "default-bootstrap"
# }

variable "subscription_display_name" {
  type        = string
  default     = null
  description = <<DESCRIPTION
    The display name of the subscription alias.

    The string must be comprised of a-z, A-Z, 0-9, -, _ and space.
    The maximum length is 63 characters.

    You may also supply an empty string if you do not want to create a new subscription alias.
    In this scenario, `subscription_enabled` should be set to `false` and `subscription_id` must be supplied.
    DESCRIPTION
}

variable "subscription_billing_scope" {
  type        = string
  default     = null
  description = "Optional override of the billing scope."
}

variable "billing_account" {
  type    = string
  default = "9693e1a4-58e7-5163-d8c7-4b88207ed652:c65fd7bc-6b30-4b94-b990-00162d46489e_2019-05-31"
}

variable "billing_profile" {
  type    = string
  default = "ZWDT-LA47-BG7-PGB"
}

variable "invoice_section" {
  type    = string
  default = "IWOS-VL4C-PJA-PGB"
}
