+++
title = "Create a Deployment And Service"
weight = 14
+++

In this step, we will be creating a Kubernetes Deployment and Kubernetes Service for an arbitrary workload. For the purposes of this lab, we will be using the container image `rancher/hello-world:latest` but you can use your own container image if you have one for testing.

When we deploy our container in a pod, we probably want to make sure it stays running in case of failure or other disruption. Pods by nature will not be replaced when they terminate, so for a web service or something we intend to be always running, we should use a Deployment.

The deployment is a factory for pods, so you'll notice a lot of similarities with the Pod's spec. When a deployment is created, it first creates a replica set, which in turn creates pod objects, and then continues to supervise those pods in case one or more fails.

1. Under the **Workloads** sections in the left menu, go to **Deployments** and press **Create** in the top right corner and enter the following criteria:
   - **Name** - `helloworld`
   - **Replicas** - `2`
   - **Container Image** - `rancher/hello-world:latest`
   - Under **Ports** click **Add Port**
   - Under **Service Type** choose to create a `Node Port` service
   - Enter `80` for the **Private Container Port**
   - **NOTE:** Note the other capabilities you have for deploying your container. We won't be covering these in this Rodeo, but you have plenty of capabilities here.
2. Scroll down and click **Create**
3. You should see a new **helloworld** deployment. If you click on it, you will see two Pods getting deployed.
4. From here you can click on a Pod, to have a look at the Pod's events. In the **three-dots** menu on a Pod, you can also access the logs of a Pod or start an interactive shell into the Pod.
5. In the left menu under **Service Discovery** > **Services**, you will find a new Node Port Service which exposes the hello world application publicly on a high port on every worker node. You can click on the linked Port to directly access it.
