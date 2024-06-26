// output "ipv4" {
//   value = vsphere_virtual_machine.vm.guest_ip_addresses
// }

output "ipv4" {
  value = {
      for vm in vsphere_virtual_machine.vm:
      vm.name => vm.guest_ip_addresses
  }
}
