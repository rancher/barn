# Demo workloads

This installs all the Rancher cluster tools and some demo workloads into an RKE2 Kubernetes cluster.

Before running the `install.sh` script:

* Install kubectl and helm
* Make sure that kubectl can access your target Kubernetes cluster
* Make sure that the ingress controller is publicly reachable, otherwise cert-manager won't be able to order Let'sEncrypt certificates
* Best create a wildcard DNS entry that points to the ingress controller
* Change all the hostnames from `*.susecon.plgrnd.be` to your DNS entry
* For Longhorn backups, log into AWS with the `aws` CLI, create a S3 bucket and change the bucket name in the Longhorn install options in `install.sh`
* Change the cluster name and the cluster id in `monitoring/values.yaml`
