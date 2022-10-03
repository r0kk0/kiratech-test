vsphere_server     = "vcenter.r0kk0.casa"

virtual_machines = {
  master1 = {
    is_master               = true
    is_proxy                = false
    vm_name                 = "master1"
    system_cores            = 4
    system_cores_per_socket = 1
    system_memory           = 2048
    system_ipv4_address     = "172.25.0.245"
    system_ipv4_gateway     = "172.25.0.1"
    system_ipv4_netmask     = 24
    username                = "daniele"
  }
  master2 = {
    is_master               = true
    is_proxy                = false
    vm_name                 = "master2"
    system_cores            = 4
    system_cores_per_socket = 1
    system_memory           = 2048
    system_ipv4_address     = "172.25.0.248"
    system_ipv4_gateway     = "172.25.0.1"
    system_ipv4_netmask     = 24
    username                = "daniele"
  }
  node1 = {
    is_master               = false
    is_proxy                = false
    vm_name                 = "node1"
    system_cores            = 4
    system_cores_per_socket = 1
    system_memory           = 4096
    system_ipv4_address     = "172.25.0.246"
    system_ipv4_gateway     = "172.25.0.1"
    system_ipv4_netmask     = 24
    username                = "daniele"
  }
  node2 = {
    is_master               = false
    is_proxy                = false
    vm_name                 = "node2"
    system_cores            = 4
    system_cores_per_socket = 1
    system_memory           = 4096
    system_ipv4_address     = "172.25.0.247"
    system_ipv4_gateway     = "172.25.0.1"
    system_ipv4_netmask     = 24
    username                = "daniele"
  }
  haproxy1 = {
    is_master               = false
    is_proxy                = true
    vm_name                 = "haproxy1"
    system_cores            = 2
    system_cores_per_socket = 1
    system_memory           = 1024
    system_ipv4_address     = "172.25.0.249"
    system_ipv4_gateway     = "172.25.0.1"
    system_ipv4_netmask     = 24
    username                = "daniele"
  }
}
