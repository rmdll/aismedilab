# ============================ #
# VMware vSphere configuration #
# ============================ #

# VMware vCenter IP/FQDN
vsphere-vcenter = "vcenter.bali.local"

# VMware vSphere username used to deploy the infrastructure
vsphere-user = "administrator@vsphere.local"

# VMware vSphere password used to deploy the infrastructure
vsphere-password = "Bali@2023"

# Skip the verification of the vCenter SSL certificate (true/false)
vsphere-unverified-ssl = true

# vSphere datacenter name where the infrastructure will be deployed
vsphere-datacenter = "BALI"

# vSphere cluster
vsphere-cluster = "BALI-CLUSTER-1"

# vSphere VM Folder
vsphere-web-cluster-folder = "WEB-CLUSTER-EXTEND"

# vSphere Linux template to clone
vm-template-name = "Rocky-9.3"

# vSphere Linux template folder
vsphere-template-folder = "Templates"

# Define VM name
vm-name = "BALI-WEB"

# Define VM network
vm-network = "WEB"

# Define number of VMs to create
vm-count = 1

# Define VM datastore
vm-datastore = "Data2"

# Define VM Network params
vm-network-ipv4-netmask = "24"
vm-network-ipv4-gateway = "172.16.18.253"
vm-network-ipv4 = "172.16.18."

#Define VM domain
vm-domain = "bali.local"
