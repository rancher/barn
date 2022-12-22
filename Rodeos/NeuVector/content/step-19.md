+++
title = "Export rules as Kubernetes manifests"
weight = 19
+++

Now we will export the ruleset for the WordPress application. This mechanism is used to migrate rules between clusters and environments, either via UI import, directly applying CRDs, or packaging in CI/CD with helm/kustomize etc...

Under **Groups** select the nv.wordpress.wordpress item and click "Export Group Policy". This will download a yaml file including process, network, file DLP, and WAF policies for this group. When exporting a group policy you can choose the target mode that in which the policies are exported. For example, you could export the policies from a QA cluster running in **protect** mode as **monitor** mode. When you apply the manifest then into a PROD cluster, the group would be automatically in **monitor** mode.

You can view the file, and see that it is a kubernetes object using the Custom Resource for `NvSecurityRule`.

If this file is imported into a new cluster via the "Import Group Policy" button, the rules/groups will be treated as though they were created/discovered within the UI, and will be editable as we have shown in the previous steps.

Let's try and import a new NvSecurityRule with additional allowed processes using kubectl and see what happens.

```ctr:Kubernetes01
cat <<EOF | kubectl apply -f -
apiVersion: neuvector.com/v1
kind: NvSecurityRule
metadata:
    name: nv.wordpress.wordpress
    namespace: wordpress
spec:
    process:
    - action: allow
      allow_update: false
      name: ls
      path: /bin/ls
    - action: allow
      allow_update: false
      name: find
      path: /usr/bin/find
    process_profile:
      baseline: basic
    target:
      policymode: Protect
      selector:
        comment: ""
        criteria:
        - key: service
          op: =
          value: wordpress.wordpress
        - key: domain
          op: =
          value: wordpress
        name: nv.wordpress.wordpress
        original_name: ""
EOF
```

You should see:
```nvsecurityrule.neuvector.com/nv.wordpress.wordpress created```

Now in the rules, observe how the nv.wordpress.wordpress group and some others, show CRD type rules. You will also note that the group is not editable in the UI.

If we had cluster federation enabled, you would also see rules of type "Federated". Precedence for enforcement goes from federated, to CRD, then local. So federated policy will always trump a local policy.

To clean up, delete the rule again:

```ctr:kubernetes01
kubectl delete nvsecurityrules nv.wordpress.wordpress -n wordpress
```

Deleting the rule, will reset the WordPress Pod to the `Discover` pod. In order to continue, change the mode back to `Protect`:

Under **Groups** select the nv.wordpress.wordpress group and switch it back to **Protect** mode.
