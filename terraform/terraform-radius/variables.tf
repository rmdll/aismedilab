#===========================#
# VMware vCenter connection #
#===========================#

variable "vsphere-user" {
  type        = string
  description = "administrator@vsphere.local"
  default = "administrator@vsphere.local"
}

variable "vsphere-password" {
  type        = string
  description = "Mot de passe"
  default = "P@ssword"
}

variable "vsphere-vcenter" {
  type        = string
  description = "VCenter URL"
  default = "vcenter.bali.local"
}

variable "vsphere-unverified-ssl" {
  type        = string
  default = "true"
}

variable "vsphere-datacenter" {
  type        = string
  default = "BALI"
}

variable "vsphere-cluster" {
  type        = string
  description = "BALI-CLUSTER-1"
  default     = "BALI-CLUSTER-1"
}

variable "vsphere-template-folder" {
  type        = string
  description = "Template folder"
  default = "Templates"
}

variable "vsphere-web-cluster-folder" {
  type        = string
  description = "Template folder"
  default = "Default"
}
#================================#
# VMware vSphere virtual machine #
#================================#

variable "vm-count" {
  description = "Number of VM"
  default     = 3 
}

variable "vm-name-prefix" {
  type        = string
  description = "Name of VM prefix"
  default     =  "myvmm"
}

variable "vm-datastore" {
  type        = string
  description = "Datastore used for the vSphere virtual machines"
  default     = "Data1"
}

variable "vm-network" {
  type        = string
  description = "Network used for the vSphere virtual machines"
  default     = "VM Network"
}

variable "vm-network-ipv4" {
  type	= string
  description = "Static IPv4 to assign to the VM"
  default = "172.16.18.5"
}

variable "vm-network-ipv4-vlanid" {
  type	= string
  description = "VLAN ID of the network"
  default = "172.16.18.5"
}

variable "vm-network-ipv4-netmask" {
  type	= string
  description = "Netmask of the network"
  default = "24"
}

variable "vm-network-ipv4-gateway" {
  type	= string
  description = "Gateway of the network"
  default = "172.16.18.253"
}

variable "vm-network-ipv4-dns" {
  type	= list(string) 
  description = "Dns server to assign"
  default = ["172.16.11.1"]
}

variable "vm-network-ipv4-dns-str" {
  type	= string 
  description = "Dns server to assign"
  default = "172.16.11.1"
}

variable "vm-linked-clone" {
  type        = string
  description = "Use linked clone to create the vSphere virtual machine from the template (true/false). If you would like to use the linked clone feature, your template need to have one and only one snapshot"
  default     = "false"
}

variable "vm-cpu" {
  type        = string
  description = "Number of vCPU for the vSphere virtual machines"
  default     = "1"
}

variable "vm-ram" {
  type        = string
  description = "Amount of RAM for the vSphere virtual machines (example: 2048)"
  default     = "1024"
}

variable "vm-name" {
  type        = string
  description = "The name of the vSphere virtual machines and the hostname of the machine"
  default     = "BALI-WEB"
}

variable "vm-guest-id" {
  type        = string
  description = "The ID of virtual machines operating system"
  default     = "centos64Guest"
}

variable "vm-template-name" {
  type        = string
  description = "The template to clone to create the VM"
  default     = "CentOStest-7.X"
}

variable "vm-domain" {
  type        = string
  description = "Linux virtual machine domain name for the machine. This, along with host_name, make up the FQDN of the virtual machine"
  default     = ""
}

variable "ssh_key_private" {
  type        = string
  description = "SSH private key for ansible connection"
  default     = "/root/.ssh/id_rsa"
}

variable "ssh_user" {
  type        = string
  description = "SSH user for ansible connection"
  default     = "root"
}
