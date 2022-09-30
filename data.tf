data "vsphere_datacenter" "dc" {
    name = "Casa"
}

data "vsphere_compute_cluster" "cluster" {
    name          = "Cluster_Casa"
    datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_datastore" "datastore" {
    name          = "datastore1"
    datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
    name          = "DPortGroup"
    datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "kubetemplate" {
    name          = "ubuntu-jammy-template"
    datacenter_id = data.vsphere_datacenter.dc.id
}

data "template_cloudinit_config" "configurazione" {
  for_each = var.virtual_machines
  gzip = false
  base64_encode = true
  part {
    content_type = "text/cloud-config"
    content = <<-EOF
      #cloud-config
      users:
        - name: ${each.value.username}
          password: ${var.sshpassword}
          sudo: ALL=(ALL) NOPASSWD:ALL
          shell: /bin/bash
          lock_passwd: false
          ssh-authorized-keys:
            - ${var.sshkey}
      disable_root: true
      chpasswd:
        list: |
          ${each.value.username}:${var.sshpassword}
        expire: False
      system_info:
        default_user:
        name: ${each.value.username}
        sudo: ALL=(ALL) NOPASSWD:ALL
     EOF
  }
}
