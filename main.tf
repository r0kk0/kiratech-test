resource "local_file" hostvar {
  for_each = var.virtual_machines
  content = templatefile("templates/hostvar.tpl",
  {
    ip_address = each.value.system_ipv4_address,
    username = each.value.username
  }
  )
  filename = "playbook/host_vars/${each.value.vm_name}.yml"
}

resource "local_file" ansibleinventory {
  content = templatefile("templates/inventory.tpl",
  {
    vms = var.virtual_machines
  }
  )
  filename = "playbook/inventory"
}

resource "local_file" haproxycfg {
  content = templatefile("templates/haproxy.tpl",
  {
    vms = var.virtual_machines
  }
  )
  filename = "playbook/roles/haproxy/files/etc/haproxy/haproxy.cfg"
}


resource "vsphere_virtual_machine" "server" {
  for_each = var.virtual_machines

  name             = each.value.vm_name
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id
  guest_id         = "ubuntu64Guest"
  num_cpus               = each.value.system_cores
  num_cores_per_socket   = each.value.system_cores_per_socket
  cpu_hot_add_enabled    = true
  cpu_hot_remove_enabled = true
  memory                 = each.value.system_memory
  memory_hot_add_enabled = true
  enable_disk_uuid = true

  cdrom {
    client_device = true
  }
  
  vapp {
    properties = {
      "instance-id" = each.value.vm_name
      "hostname"    = each.value.vm_name
      "user-data"   = data.template_cloudinit_config.configurazione[each.key].rendered
    }
  }

  network_interface {
    network_id   = data.vsphere_network.network.id
  }

  disk {
    label            = "disk0"
    unit_number      = 0
    size             = 80
    thin_provisioned = true
  }

  clone {
      template_uuid = data.vsphere_virtual_machine.kubetemplate.id
      customize {
          linux_options {
              host_name = each.key
              domain = "r0kk0.casa"
          }
          network_interface {
              ipv4_address = each.value.system_ipv4_address
              ipv4_netmask = each.value.system_ipv4_netmask
          }
          ipv4_gateway = each.value.system_ipv4_gateway
          dns_server_list = ["172.25.0.10"]
          dns_suffix_list = ["r0kk0.casa"]
      }
  }
}

resource "null_resource" ansible {

  provisioner "local-exec" {
    command = "ansible-playbook -i playbook/inventory playbook/k8s-bootstrap.yml" 
  }

  depends_on = [
    vsphere_virtual_machine.server
  ]
}


resource "null_resource" kiratechtest {

  provisioner "local-exec" {
    command = "KUBECONFIG=./playbook/admin.conf kubectl create namespace kiratech-test"
  }

  depends_on = [
    null_resource.ansible
  ]
}

resource "null_resource" labels {

  provisioner "local-exec" {
    command = "KUBECONFIG=./playbook/admin.conf kubectl label node node1 node-role.kubernetes.io/worker=worker"
  }

  provisioner "local-exec" {
    command = "KUBECONFIG=./playbook/admin.conf kubectl label node node2 node-role.kubernetes.io/worker=worker"
  }

  depends_on = [
    null_resource.ansible
  ]
}

resource "null_resource" kubebench {

  provisioner "local-exec" {
    command = "KUBECONFIG=./playbook/admin.conf kubectl apply -f kube-bench.yml"
  }

  depends_on = [
    null_resource.ansible
  ]
}
