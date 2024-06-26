# =============================== #
# Deploying VMware WEB VM Cluster #
# =============================== #

# Connect to VMware vSphere vCenter
provider "vsphere" {
  user           = var.vsphere-user
  password       = var.vsphere-password
  vsphere_server = var.vsphere-vcenter

  # If you have a self-signed cert
  allow_unverified_ssl = var.vsphere-unverified-ssl
}

# Define VMware vSphere
data "vsphere_datacenter" "dc" {
  name = var.vsphere-datacenter
}

data "vsphere_datastore" "datastore" {
  name          = var.vm-datastore
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_compute_cluster" "cluster" {
  name          = var.vsphere-cluster
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name          = var.vm-network
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "template" {
  name          = "/${var.vsphere-datacenter}/vm/${var.vsphere-template-folder}/${var.vm-template-name}"
  datacenter_id = data.vsphere_datacenter.dc.id
}


resource "vsphere_folder" "parent" {
  path          = var.vsphere-web-cluster-folder
  type          = "vm"
  datacenter_id = data.vsphere_datacenter.dc.id
#  depends_on = [vsphere_virtual_machine.vm]
}



# Create VMs
resource "vsphere_virtual_machine" "vm" {
  count = var.vm-count 

  name             = "${var.vm-name}-${count.index + 4}"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus = var.vm-cpu
  memory   = var.vm-ram
  guest_id = var.vm-guest-id
  folder   = var.vsphere-web-cluster-folder

  network_interface {
    network_id = data.vsphere_network.network.id
  }

  disk {
    label            = "${var.vm-name}-${count.index + 4}-disk"
    thin_provisioned = true
    eagerly_scrub    = false
    size             = 20
  }

 disk {
   label            = "${var.vm-name}-${count.index + 4}-disk-addon"
   thin_provisioned = true
   eagerly_scrub    = false
   size             = 3
  unit_number = 1
 }
  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
    customize {
      linux_options {
        host_name = "${var.vm-name}-${count.index + 4}"
        domain    = var.vm-domain
      }
      network_interface {
        ipv4_address = "${var.vm-network-ipv4}${count.index + 4}"
        ipv4_netmask = var.vm-network-ipv4-netmask
	dns_server_list = var.vm-network-ipv4-dns
      }
      ipv4_gateway = var.vm-network-ipv4-gateway
      timeout = 30
    }
  }
  connection {
    type = "ssh"
    user = "${var.ssh_user}"
    private_key = "${file(var.ssh_key_private)}"
    host = "bali-ansible-1.bali.local"
  }
  provisioner "remote-exec" {
	inline = [ 
		"sudo -u root bash -c \"pushd /etc/ansible/playbooks/scripts && ./deploy_webserver $(echo ${var.vm-name}-${count.index + 4} |tr [:upper:] [:lower:]) ${var.vm-network-ipv4}${count.index + 4} && popd \""
	]
  }
	depends_on = [vsphere_folder.parent]
}
