# Scripts

## OPA Mutating Webhook Examples

* [Add K8s Namespace into Rancher Project](./OPA-Webhooks/namespace-to-project.yaml)
  This webhook will mutate any Namespace with a specified label and add it into the specified Rancher project.  The Rancher Project ID is **not** the Project's `spec.displayName`, it is the `metadata.name` field (beginning with `p-`).

* [Inject proxy certs & values](./OPA-Webhooks/proxy-values-webhook.yaml)
  Every container has its own `env` & certificate store.  These webhook manifests will append specified HTTP/S proxy values and certificates to every pod requiring them.  These examples are Namespace-scoped, but can easily be changed to Cluster-scoped if needed.
