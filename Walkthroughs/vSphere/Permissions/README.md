# vSphere Privileges Summary

## Rancher vSphere CPI

These are the minimum privileges required for using Rancher vSphere CPI and/or Cloud Credential.

### Datastore {#cpi}

- [x] Allocate space
- [x] Browse datastore
- [x] Low level file operations

### Network {#cpi}

- [x] Assign network

### Profile-driven storage {#cpi}

>:memo: This privilege is for vSphere 7.  For vSphere 8, use [VM storage policies](#vm-storage-policies-cpi)) instead.

- [x] Profile-driven storage view

### Resource {#cpi}

- [x] Assign virtual machine to resource pool

### vApp {#cpi}

>:memo: If not deploying from a Content Library these privileges can be omitted.

- [x] Create
- [x] Import

### Virtual machine {#cpi}

#### Change Configuration {#cpi}

- [x] Add existing disk
- [x] Add new disk
- [x] Add or remove device
- [x] Advanced configuration
- [x] Change CPU count
- [x] Change Memory
- [x] Change Settings
- [x] Change resource
- [x] Display connection settings
- [x] Extend virtual disk
- [x] Modify device settings
- [x] Remove disk
- [x] Rename
- [x] Reset guest information

#### Edit Inventory {#cpi}

- [x] Create from existing
- [x] Create new
- [x] Move
- [x] Register
- [x] Remove
- [x] Unregister

#### Guest operations {#cpi}

- [x] Guest operation alias modification
- [x] Guest operation alias query
- [x] Guest operation modifications
- [x] Guest operation program execution
- [x] Guest operation queries

#### Interaction {#cpi}

- [x] Configure CD media
- [x] Connect devices
- [x] Install VMware Tools
- [x] Power off
- [x] Power on
- [x] Reset

#### Provisioning {#cpi}

- [x] Allow disk access
- [x] Allow file access
- [x] Clone template
- [x] Customize guest
- [x] Deploy template
- [x] Modify customization specification
- [x] Read customization specifications

### VM storage policies {#cpi}

>:memo: These privileges are for vSphere 8.  For vSphere 7, use [Profile-driven storage](#profile-driven-storage-cpi) instead.

- [x] Apply VM storage policies
- [x] View VM storage policies

### vSphere Tagging {#cpi}

- [x] Assign or Unassign vSphere Tag
- [x] Assign or Unassign vSphere Tag on Object

## Rancher vSphere CSI

These are the minimum privileges required to provision and attach Rancher vSphere CSI volumes. ***If not using vSAN, vSphere CSI volumes can be RWO only***.

### Cns {#csi}

- [x] Searchable

### Datastore {#csi}

- [x] Low level file operations

### Host {#csi}

- [x] Configuration
- [x] Storage partition configuration

### Profile-driven storage {#csi}

>:memo: This privilege is for vSphere 7.  For vSphere 8, use [VM storage policies](#vm-storage-policies-csi)) instead.

- [x] Profile-driven storage view

### Virtual machine {#csi}

#### Change Configuration {#csi}

- [x] Add existing disk
- [x] Add or remove device
- [x] Remove disk

### VM storage policies {#csi}

>:memo: These privileges are for vSphere 8.  For vSphere 7, use [Profile-driven storage](#profile-driven-storage-csi) instead.

- [x] Apply VM storage policies
- [x] View VM storage policies

## Helm Configuration Examples

Below are basic CPI & CSI Helm chart values for an RKE2 cluster.  More comprehensive `values.yaml` examples are in the RKE2 Charts GitHub repository:

- [Rancher vSphere CPI](https://github.com/rancher/rke2-charts/tree/main/charts/rancher-vsphere-cpi/rancher-vsphere-cpi)

- [Rancher vSphere CSI](https://github.com/rancher/rke2-charts/tree/main/charts/rancher-vsphere-csi/rancher-vsphere-csi)

For guidance on deploying these charts via Terraform plan, see [HERE](https://github.com/frank-at-suse/vsphere_rancher_cluster).

### CPI

```yaml
rancher-vsphere-cpi:
  vCenter:
    host: <vcenter_server>
    port: 443
    insecureFlag: true
    datacenters: <vsphere_datacenter>
    username: <cpi_username>
    password: <cpi_password>
    credentialsSecret:
      name: "vsphere-cpi-creds"
      generate: true
```

### CSI

```yaml
rancher-vsphere-csi:
  vCenter:
    host: <vcenter_server>
    port: 443
    insecureFlag: "1"
    datacenters: <vsphere_datacenter>
    username: <csi_username>
    password: <csi_password>
    configSecret:
      name: "vsphere-config-secret"
      generate: true
  storageClass:
    allowVolumeExpansion: true  # Optional Value
    datastoreURL: <ds://datastore_url/>
```
