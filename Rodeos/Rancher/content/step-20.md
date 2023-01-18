+++
title = "Creating a Stateful WordPress Project in your Kubernetes Cluster"
weight = 20
+++

Let's deploy a second WordPress instance into the cluster that uses the NFS storage provider. First create a new project for it:

1. In the left menu go to **Cluster** > **Projects/Namespaces**
2. Click **Create Project** in the top right
3. Give your project a name, like `stateful-wordpress`
    - Note the ability to add members, set resource quotas and a pod security policy for this project.
4. Next create a new namespace in the `stateful-wordpress` project. In the list of all **Projects/Namespaces**, scroll down to the `stateful-wordpress` project and click the **Create Namespace** button.
5. Enter the **Name** `stateful-wordpress` and click **Create**.
