+++
title = "Interacting with the Kubernetes Cluster"
weight = 11
+++

In this step, we will be showing basic interaction with our Kubernetes cluster.

1. Click into your newly `active` cluster.
2. Note the diagrams dials, which illustrate cluster capacity, and the box that show you the recent events in your cluster.
3. Click the `Kubectl Shell` button (the button with the Prompt icon) in the top right corner of the Cluster Explorer, and enter `kubectl get pods --all-namespaces` and observe the fact that you can interact with your Kubernetes cluster using `kubectl`.
4. Also take note of the `Download Kubeconfig File` button next to it which will generate a Kubeconfig file that can be used from your local desktop or within your deployment pipelines.
5. In the left menu, you have access to all Kubernetes resources, the Rancher Application Marketplace and additional cluster tools.
