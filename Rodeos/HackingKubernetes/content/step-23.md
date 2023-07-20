+++
title = "Configure admission control"
weight = 23
+++

Next we want to prevent a Pod to be run as root to begin with.

An admission controller in kubernetes is a small piece of software that will take the object being submitted to the API server and either allow it as-is, modify it, or block the resource from being added. In NeuVectors case, we want to block the deployment of workloads based on a set of security criteria.

By default, this is disabled. To enable, navigate to **Policy -> Admission Control**, and click the **Status** toggle.

Also make sure to switch the admission control to **Protect** mode.

Let us create a rule that will block pods running as root in the `default` namespace. For more information on other available criteria, please see [Admission](https://open-docs.neuvector.com/policy/admission).

Click **Add** and use the following settings:

* Type: Deny
* Comment: Deny root in default namespace

Then add two criterion.

First:

* Criterion: Namespace
* Operator: Is one of
* Value: default

Second:

* Criterion: Run as root

Note that you have to click the `+` icon for each criterion to actually add the rule that you configured in the form.

Delete the Pod again to force Kubernetes to recreate it

**Run the following commands on the victim01 VM.**

```ctr
kubectl delete pod -n default -l app=sample-app
```

Kubernetes will now prevent the Pod creation. You can see this in the events of the Deployment's ReplicaSet:

```ctr
kubectl describe replicaset
```
