#set of VM variables to authenticate to the vCenter
variable "vsphere_server" {
  description = "vSphere server"
  type        = string
}

variable "vsphere_user" {
  description = "vSphere username"
  type        = string
  sensitive   = true
}

variable "vsphere_password" {
  description = "vSphere password"
  type        = string
  sensitive   = true
}


variable "virtual_machines" {
  type = map(object({
    system_cores            = number
    system_cores_per_socket = number
    system_memory           = number
    system_ipv4_address     = string
    system_ipv4_gateway     = string
    system_ipv4_netmask     = number
  }))
}
