# This file was autogenerated by the 'packer hcl2_upgrade' command. We
# recommend double checking that everything is correct before going forward. We
# also recommend treating this file as disposable. The HCL2 blocks in this
# file can be moved to other files. For example, the variable blocks could be
# moved to their own 'variables.pkr.hcl' file, etc. Those files need to be
# suffixed with '.pkr.hcl' to be visible to Packer. To use multiple files at
# once they also need to be in the same folder. 'packer inspect folder/'
# will describe to you what is in that folder.

# Avoid mixing go templating calls ( for example ```{{ upper(`string`) }}``` )
# and HCL2 calls (for example '${ var.string_value_example }' ). They won't be
# executed together and the outcome will be unknown.

# See https://www.packer.io/docs/templates/hcl_templates/blocks/packer for more info
packer {
  required_plugins {
    vsphere = {
      source  = "github.com/hashicorp/vsphere"
      version = "~> 1"
    }
    ansible = {
      version = ">= 1.1.1"
      source  = "github.com/hashicorp/ansible"
    }
  }
}

# source blocks are generated from your builders; a source can be referenced in
# build blocks. A build block runs provisioner and post-processors on a
# source. Read the documentation for source blocks here:
# https://www.packer.io/docs/templates/hcl_templates/blocks/source
source "vsphere-iso" "autogenerated_1" {
  CPUs                 = "2"
  RAM                  = "4096"
  RAM_reserve_all      = "false"
  boot_command         = ["<esc><wait>", "text inst.ks=http://172.16.32.1:9000/ks.cfg ip=dhcp <enter><wait>"]
  boot_order           = "disk,cdrom"
  boot_wait            = "10s"
  cluster              = "BALI-CLUSTER-1"
  convert_to_template  = "true"
  datacenter           = "BALI"
  datastore            = "Data1"
  disk_controller_type = ["pvscsi"]
  firmware             = "bios"
  folder               = "Templates"
  guest_os_type        = "centos64Guest"
  insecure_connection  = "true"
  iso_paths            = ["[Data1] ISO/Rocky-9.3-x86_64-minimal.iso"]
  network_adapters {
    network = "CLIENT"
  }
  password     = "Bali@2023"
  ssh_password = "rockyTerraform"
  ssh_username = "terraform_user"
  storage {
    disk_size             = "20480"
    disk_thin_provisioned = "true"
  }
  username       = "administrator@vsphere.local"
  vcenter_server = "vcenter.bali.local"
  vm_name        = "Rocky-9.3"
}

# a build block invokes sources and runs provisioning steps on them. The
# documentation for build blocks can be found here:
# https://www.packer.io/docs/templates/hcl_templates/blocks/build
build {
  sources = ["source.vsphere-iso.autogenerated_1"]
#  provisioner "ansible" {
#	  playbook_file="/etc/ansible/playbooks/deploy_cloudinit.yaml"
#}
}