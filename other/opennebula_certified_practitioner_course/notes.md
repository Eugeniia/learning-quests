# OpenNebula Certified Practitioner Course
## Introduction
MiniONE: https://github.com/OpenNebula/minione

Frontend - responsible for serving Web GUI, oned service, perform environment monitoring as well as management of network, storage or VMs.

Hypervisor nodes (hosts) are responsible for providing physical resources for VMs to run. You must have a passwordless SSH access from ONED node (Frontend) to hosts.
 
opennebula - main component that contains the toolset that is necessary to manage the environment. opennebula-fireedge - the web-based GUI for easier management of the environment. opennebula-flow - the service to orchestrate the multi-VM application deployment and support through the life-cycle.

Different types of storages used to store images. OpenNebula supports multiple datastore backends - local storage, NFS?NAS, Ceph, SAN/iSCSI.

OpenNebula editions.: community edition and enterprise eddition. Differences: different repository that has the token-based access; different patching and different enterprise-only features (e.g. veeam backup&replication, native NetApp driver, native PureStorage driver, full LVM storage driver).

Sunstone views. Declutter the web GUI by removing unnecessary tabs. Controls tabs, functionality of checkboxes and the availability of actions. Bundled with the set of default views (admin, group admin, user, cloud).

## Users, Groups & Permissions
Each user has two types of the group membership: primary group & secondary group. Primary group is mandatory! This group defines the resourse group ownership. Secondary group - maybe empty or more than one record. This group provides a user with an access to this group's shared resources.

User types: admins, users and service users. Admins can perform any operation, belong to the oneadmin group, can manage any resource in the OpenNebula environment. Regular users can perform almost every operation in OpenNebula. 

Permission system: by default users are the sole owners of their resource. Permission types: 1) Use - operations that do not modify the resource like listing it or using it 2) Manage - operations that modify the resource like stopping a VM, changing the persistent attribute of an image or removing a leasef rom a network 3) Admin - special operations that are typically limited to admins e.g. updating the data of a host or deliting an user group.

Owner, group, other.

## Hosts
Host - virtualization worker that runs a supported Virtualization platform (KVM, QEMU, LXC). 

Monitoring. The monitoring process collects metrics from the Host, including memory, disk space and CPU. Additionally, metrics are also collected from the VMs running on the Host.
onemonitord process is responsible for defining the monitoring configuration. the configuration for the process is stored in monitord.conf. Probes agents are agthering the requested info about the host and vms, and are sending this message to the onemonitord that runs on the OpenNebula frontend.

## Images, Storage & Marketplaces



