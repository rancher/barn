resource "rancher2_cloud_credential" "monitoring_aws" {
  name = "monitoring-aws"
  amazonec2_credential_config {
    access_key = var.aws_access_key
    secret_key = var.aws_secret_key
  }
}

resource "rancher2_machine_config_v2" "monitoring_demo_nodes_downstream_one" {
  generate_name = "monitoring-demo-nodes-downstream-one"
  amazonec2_config {
    ami            = data.aws_ami.sles.id
    region         = var.aws_region
    security_group = [aws_security_group.monitoring_demo[0].name]
    subnet_id      = aws_subnet.monitoring_demo_subnet[0].id
    vpc_id         = aws_vpc.monitoring_demo_vpc[0].id
    zone           = "b"
    instance_type  = "t3a.xlarge"
    ssh_user       = "ec2-user"
  }
}
resource "rancher2_machine_config_v2" "monitoring_demo_nodes_downstream_two" {
  generate_name = "monitoring-demo-nodes-downstream-two"
  amazonec2_config {
    ami            = data.aws_ami.sles.id
    region         = var.aws_region
    security_group = [aws_security_group.monitoring_demo[1].name]
    subnet_id      = aws_subnet.monitoring_demo_subnet[1].id
    vpc_id         = aws_vpc.monitoring_demo_vpc[1].id
    zone           = "b"
    instance_type  = "t3a.xlarge"
    ssh_user       = "ec2-user"
  }
}
resource "rancher2_machine_config_v2" "monitoring_demo_nodes_central_monitoring" {
  generate_name = "monitoring-demo-nodes-central-monitoring"
  amazonec2_config {
    ami            = data.aws_ami.sles.id
    region         = var.aws_region
    security_group = [aws_security_group.monitoring_demo[2].name]
    subnet_id      = aws_subnet.monitoring_demo_subnet[2].id
    vpc_id         = aws_vpc.monitoring_demo_vpc[2].id
    zone           = "b"
    instance_type  = "t3a.xlarge"
    ssh_user       = "ec2-user"
  }
}

resource "rancher2_cluster_v2" "monitoring_demo_downstream_one" {
  name                         = "monitoring-demo-downstream-one"
  kubernetes_version           = "v1.21.12+rke2r2"
  cloud_credential_secret_name = rancher2_cloud_credential.monitoring_aws.id
  rke_config {
    machine_pools {
      name                         = "nodes"
      cloud_credential_secret_name = rancher2_cloud_credential.monitoring_aws.id
      control_plane_role           = true
      etcd_role                    = true
      worker_role                  = true
      quantity                     = 3
      machine_config {
        kind = rancher2_machine_config_v2.monitoring_demo_nodes_downstream_one.kind
        name = rancher2_machine_config_v2.monitoring_demo_nodes_downstream_one.name
      }
    }
  }
}

resource "rancher2_cluster_v2" "monitoring_demo_downstream_two" {
  name                         = "monitoring-demo-downstream-two"
  kubernetes_version           = "v1.21.12+rke2r2"
  cloud_credential_secret_name = rancher2_cloud_credential.monitoring_aws.id
  rke_config {
    machine_pools {
      name                         = "nodes"
      cloud_credential_secret_name = rancher2_cloud_credential.monitoring_aws.id
      control_plane_role           = true
      etcd_role                    = true
      worker_role                  = true
      quantity                     = 3
      machine_config {
        kind = rancher2_machine_config_v2.monitoring_demo_nodes_downstream_two.kind
        name = rancher2_machine_config_v2.monitoring_demo_nodes_downstream_two.name
      }
    }
  }
}

resource "rancher2_cluster_v2" "monitoring_demo_central_monitoring" {
  name                         = "monitoring-demo-central-monitoring"
  kubernetes_version           = "v1.21.12+rke2r2"
  cloud_credential_secret_name = rancher2_cloud_credential.monitoring_aws.id
  rke_config {
    machine_pools {
      name                         = "nodes"
      cloud_credential_secret_name = rancher2_cloud_credential.monitoring_aws.id
      control_plane_role           = true
      etcd_role                    = true
      worker_role                  = true
      quantity                     = 3
      machine_config {
        kind = rancher2_machine_config_v2.monitoring_demo_nodes_central_monitoring.kind
        name = rancher2_machine_config_v2.monitoring_demo_nodes_central_monitoring.name
      }
    }
  }
}

resource "rancher2_cluster_sync" "sync_downstream_one" {
  cluster_id = rancher2_cluster_v2.monitoring_demo_downstream_one.cluster_v1_id
}
resource "rancher2_cluster_sync" "sync_downstream_two" {
  cluster_id = rancher2_cluster_v2.monitoring_demo_downstream_two.cluster_v1_id
}
resource "rancher2_cluster_sync" "sync_central_monitoring" {
  cluster_id = rancher2_cluster_v2.monitoring_demo_central_monitoring.cluster_v1_id
}

locals {
  worker_ips_downstream_one                = toset([for node in rancher2_cluster_sync.sync_downstream_one.nodes : node.external_ip_address if contains(node.roles, "worker")])
  worker_ips_downstream_two                = toset([for node in rancher2_cluster_sync.sync_downstream_two.nodes : node.external_ip_address if contains(node.roles, "worker")])
  worker_ips_downstream_central_monitoring = toset([for node in rancher2_cluster_sync.sync_central_monitoring.nodes : node.external_ip_address if contains(node.roles, "worker")])
}

resource "local_file" "kubeconfig_downstream_one" {
  content  = rancher2_cluster_sync.sync_downstream_one.kube_config
  filename = "${path.module}/kubeconfig_downstream_one"
}
resource "local_file" "kubeconfig_downstream_two" {
  content  = rancher2_cluster_sync.sync_downstream_two.kube_config
  filename = "${path.module}/kubeconfig_downstream_two"
}
resource "local_file" "kubeconfig_downstream_central_monitoring" {
  content  = rancher2_cluster_sync.sync_central_monitoring.kube_config
  filename = "${path.module}/kubeconfig_central_monitoring"
}
