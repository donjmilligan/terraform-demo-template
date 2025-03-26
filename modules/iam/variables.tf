variable "project_id" {
  description = "Google Project ID that you want the resources deployed into"
  type        = string
}

variable "demo_sa" {
  description = "Custom virtual machine service account"
  type        = string
  default     = "demo-machines"
}