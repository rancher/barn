+++
title = "pull policy and deploy it to your Kubernetes cluster"
weight = 25
+++
+++

**Run the following commands on the victim01 VM.**


Now we need to pull the policy to our local datastore 
```ctr
kwctl pull ghcr.io/kubewarden/policies/user-group-psp:v0.4.9
```

Now we will create a yaml file from that policy to modify the file and put some rules into it.
```ctr
kwctl scaffold manifest -t AdmissionPolicy registry://ghcr.io/kubewarden/policies/user-group-psp:v0.4.9 > user-group-psp.yaml
```

Now we need to add the following configuration parameter into the `user-group-psp.yaml`.Open the yaml file with vi.
```ctr
vi user-group-psp.yaml
```

Press `i` and copy the content into the file. 
```ctr
  settings:
    description: null
    run_as_group:
      rule: RunAsAny
    run_as_user:
      rule: MustRunAsNonRoot
    supplemental_groups:
      rule: RunAsAny
```
Press ESC and exit vi with `:x`

Now we can apply the policy to our kubernetes cluster
```ctr
kubectl apply -f user-group-psp.yaml
```

Let us check if the policy is in place
```ctr
kubectl get admissionpolicies
```

Now we will delete the pod of the sample application to check the policy
```ctr
kubectl get pods | tail -n 1 | kubectl delete pod $(awk '{print $1}')
```


```ctr
kubectl get events
```
