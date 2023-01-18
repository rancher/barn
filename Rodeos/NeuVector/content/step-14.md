+++
title = "Configure and test admission control hook"
weight = 14
+++

Now let's try out some policy based features. First, we will look at the built-in admission controller.

An admission controller in kubernetes is a small piece of software that will take the object being submitted to the API server and either allow it as-is, modify it, or block the resource from being added. In NeuVectors case, we want to block the deployment of workloads based on a set of security criteria.

By default, this is disabled. To enable, navigate to **Policy -> Admission Control**, and click the **Status** toggle.

Let us create a rule that will block deployments to the `default` namespace. For more information on other available criteria, please see [Admission](https://open-docs.neuvector.com/policy/admission).

Click **Add** and use the following settings:

```text
Type: Deny
Comment: Deny default namespace
Criterion: Namespace
Operator: Is one of
Value: default
```

Note that you have to click the `+` icon to actually add the rule that you configured in the form.

When Admission Control is first enabled, it is placed in monitor mode. Let's see what happens when we try and create a hello-world pod in the default namespace.

```ctr:Kubernetes01
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: hello-world
  namespace: default
spec:
  containers:
    - name: hello-world
      image: rancher/hello-world:latest
      ports:
        - name: web
          containerPort: 80
          protocol: TCP
EOF
```

You should see the following:
`pod/hello-world created`

Even though we have created a deny rule that should block this, the fact that we are in monitor mode means we still allow the action. You can see that a warning was logged for this activity, showing that it would be blocked. These are viewed under **Notifications -> Risk Reports**.

Now let's put this into protect mode, and see how it behaves. On the **Policy -> Admission Control** page, click the **Mode** toggle to change from Monitor to Protect, and click OK.

Delete the previous pod:

```ctr:Kubernetes01
kubectl delete pod hello-world -n default
```

Re-deploy pod:

```ctr:Kubernetes01
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: hello-world
  namespace: default
spec:
  containers:
    - name: hello-world
      image: rancher/hello-world:latest
      ports:
        - name: web
          containerPort: 80
          protocol: TCP
EOF
```

Now we see a message like this showing that the creation of the pod is blocked:

`Error from server: error when creating "STDIN": admission webhook "neuvector-validating-admission-webhook.cattle-neuvector-system.svc" denied the request: Creation of Kubernetes Pod is denied.`

This is also visible under **Notifications -> Risk Reports**.
