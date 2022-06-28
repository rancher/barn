# Rancher, Longhorn, K10 integration example

This examples deploys Longhorn, Kasten K10 and an example workload with a K10 backup policy into a Rancher managed cluster using Rancher Continuous Delivery (Fleet).

To test this, create a GitRepo with:

* Name: `rlk10` (the name can't be changed to not break fleet bundle dependencies)
* Repository URL: `https://github.com/rancher/barn`
* Branch: `main`
* Paths: `Integrations/RancherLonghornK10/fleet`
* Git Authentication: Either a username/password or SSH Key that allows access to the barn repo
* Deploy to: Cluster(s) of your choice

Pre-requisites:

* The Longhorn installation requirements: https://longhorn.io/docs/latest/deploy/install/#installation-requirements
* In order for the backup to succeed, you have to configure a backup target in Longhorn: https://longhorn.io/docs/latest/references/settings/#backup-target, either through the Longhorn UI or directly in the [Longhorn Helm values](./fleet/longhorn/fleet.yaml)

After the deployment finished, you can access the K10 UI with a NavLink from the cluster.