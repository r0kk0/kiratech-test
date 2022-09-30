vsphere_server     = "vcenter.r0kk0.casa"

virtual_machines = {
  master1 = {
    system_cores            = 4
    system_cores_per_socket = 1
    system_memory           = 4096
    system_ipv4_address     = "172.25.0.245"
    system_ipv4_gateway     = "172.25.0.1"
    system_ipv4_netmask     = 24
    username                = "daniele"
  }
  node1 = {
    system_cores            = 4
    system_cores_per_socket = 1
    system_memory           = 4096
    system_ipv4_address     = "172.25.0.246"
    system_ipv4_gateway     = "172.25.0.1"
    system_ipv4_netmask     = 24
    username                = "daniele"
  }
  node2 = {
    system_cores            = 4
    system_cores_per_socket = 1
    system_memory           = 4096
    system_ipv4_address     = "172.25.0.247"
    system_ipv4_gateway     = "172.25.0.1"
    system_ipv4_netmask     = 24
    username                = "daniele"
  }
}
