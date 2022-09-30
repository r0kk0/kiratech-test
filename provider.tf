provider "vsphere" {
    vsphere_server = var.vsphere_server
    user           = var.vsphere_user
    password       = var.vsphere_password

    allow_unverified_ssl = true
}

provider "kubernetes" {
  config_path    = "playbook/admin.conf"
  config_context = "kubernetes-admin@kubernetes"
  insecure = true
}
