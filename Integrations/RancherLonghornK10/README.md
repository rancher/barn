# Rancher, Longhorn, K10 integration example

This examples deploys Longhorn, Kasten K10 and an example workload with a K10 backup policy into a Rancher managed cluster using Rancher Continuous Delivery (Fleet).

To test this, create a GitRepo with:

* Name: e.g. `rlk10`
* Repository URL: `https://github.com/rancher/barn`
* Branch: `main`
* Paths: `Integrations/RancherLonghornK10/fleet`
* Git Authentication: Either a username/password or SSH Key that allows access to the barn repo
* Deploy to: Cluster(s) of your choice

Pre-requisites:

* The [Longhorn installation requirements](https://longhorn.io/docs/latest/deploy/install/#installation-requirements)

After the deployment finished, you can access the K10 UI with a NavLink from the cluster.

The [VolumeSnapshotClass](./fleet/csi-snapshot-class/csi-snapshot-class.yaml) is configured to do Longhorn internal snapshots. If you want to perform external backups,  you have to configure a backup target in Longhorn: See [Longhorn Backup Target](https://longhorn.io/docs/latest/references/settings/#backup-target), either through the Longhorn UI or directly in the [Longhorn Helm values](./fleet/longhorn/fleet.yaml). And you have to change the `VolumeSnapshotClass` configuration: See [Longhorn CSI Snapshot support](https://longhorn.io/docs/latest/snapshots-and-backups/csi-snapshot-support/csi-volume-snapshot-associated-with-longhorn-backup/#create-a-csi-volumesnapshot-associated-with-longhorn-backup).
