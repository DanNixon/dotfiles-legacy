# Terraform Apply

Used to apply a Terraform configuration and add hosts to Ansible's in memory inventory as a result.

Expects an output named "inventory" to be defined in the Terraform config as per the example below:

```
output "inventory" {
  value = concat(
    [
      for s in proxmox_vm_qemu.k8s_etcd:
      {
        name   = s.name
        host   = s.ssh_host
        user   = "ubuntu"
        groups = ["k8s", "etcd"]
      }
    ],
    ...
  )
}
```
