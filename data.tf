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
    name          = "kubernetes-template"
    datacenter_id = data.vsphere_datacenter.dc.id
}
