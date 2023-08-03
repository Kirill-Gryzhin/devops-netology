# name

variable "vm_web_compute_image" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "image"
}

variable "vm_web_compute_instance" {
  type        = string
  default     = "netology-develop-platform-web"
  description = "name"
}
variable "vm_db_compute_image" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "image"
}
variable "vm_db_compute_instance" {
  type        = string
  default     = "netology-develop-platform-db"
  description = "name"
}

# resorces
variable "resources_db" {
type = map
default = {
cpu = 2
ram = 1
core_fraction = 20
}
}
variable "resources_web" {
type = map
default = {
cpu = 2
ram = 1
core_fraction = 5
}
}