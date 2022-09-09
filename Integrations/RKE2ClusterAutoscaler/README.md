# Kubernetes Cluster Autoscaler for RKE2 clusters

The [Kubernetes Cluster Autoscaler](https://github.com/kubernetes/autoscaler/tree/master/cluster-autoscaler) allows to automatically add or remove nodes of a Kubernetes cluster to gracefully and economically handle load changes.

Whenever Kubernetes wants to schedule Pods on a cluster and doesn't have enough resources for it anymore, the autoscaler can add nodes within configured limits. When Pods get removed, the autoscaler can also remove freed up nodes again.

It works together quite nicely with Kubernetes' built-in [HorizontalPodAutoscaler](https://kubernetes.io/de/docs/tasks/run-application/horizontal-pod-autoscale/).

## Usage with Rancher

In Rancher, you can use the Kubernetes Cluster Autoscaler for RKE2 clusters that were provisioned from Rancher with a connection to an infrastructure provider, such as AWS EC2, Azure VMs, vSphere, ...

**Note: You need at use at least [Cluster Autoscaler 1.25.0](https://github.com/kubernetes/autoscaler/releases/tag/cluster-autoscaler-1.25.0) for the RKE2 support.**

## Installation

Create a [Rancher API key](https://rancher.com/docs/rancher/v2.6/en/user-settings/api-keys/). The key must not be scoped. Note the bearer token value.

Add the cluster-autoscaler Helm Repository to the App Marketplace of the cluster, that you want to autoscale:

* Target: http(s) URL
* Index URL: `https://kubernetes.github.io/autoscaler`

Create a `cluster-autoscaler-cloud-config` Secret with the connection configuration to Rancher:

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: cluster-autoscaler-cloud-config
stringData:
  rancher.conf: |
    # rancher server credentials
    url: https://rancher.example.org
    token: <rancher API bearer token>
    # name and namespace of the clusters.provisioning.cattle.io resource on the
    # rancher server
    clusterName: <my-cluster>
    clusterNamespace: fleet-default
    # optional, will be auto-discovered if not specified
    #clusterAPIVersion: v1alpha4
```

Next install the `cluster-autoscaler` app and change the following configuration values. If you are using the UI to install the cluster-autoscaler, only overwrite the below values and keep the rest of the values as default.

```yaml
autoDiscovery:
  clusterName: <my-cluster>
cloudProvider: rancher
extraArgs:
  cloud-config: /etc/rancher/rancher.conf
extraVolumeSecrets:
  cloud-config:
    name: cluster-autoscaler-cloud-config
    mountPath: /etc/rancher
```

Secret and installation must be in the same namespace.

## Configuring a MachinePool

Next, you can configure autoscaling individually for each MachinePool by editing the cluster configuration as YAML and adding `machineDeploymentAnnotations` to a pool. Abbreviated example:

```yaml
apiVersion: provisioning.cattle.io/v1
kind: Cluster
spec:
  rkeConfig:
    machinePools:
    - name: pool-1
      quantity: 1
      workerRole: true
      machineDeploymentAnnotations:
        cluster.provisioning.cattle.io/autoscaler-min-size: "1"
        cluster.provisioning.cattle.io/autoscaler-max-size: "3"
```

For a full list of annotations and configuration options see [Rancher cloud provider](https://github.com/kubernetes/autoscaler/tree/master/cluster-autoscaler/cloudprovider/rancher).

## Terraform

A boilerplate example of implementing the RKE2 cluster autoscaler using the rancher2 Terraform provider can be found [HERE](https://github.com/frank-at-suse/vsphere_HA_autoscale_cluster)

## Testing the autoscaler

To test the autoscaler, create one or more Pod/Deployment with a CPU or memory resource request that can't be fulfilled by the cluster anymore. if that happens, and a Pod remains in `Pending` state, the autoscaler will start to increase the MachinePool and add more VMs.
