# Monitoring custom workloads

Rancher Monitoring is a powerful and flexible solutions which includes many metrics, alerts and dashboards out-of-the-box. You can also easily extend Rancher Monitoring and configure Prometheus to scrape additional targets for metrics, add alerts on these metrics and add dashboards to Grafana to visualize them.

## Prometheus Operator

Under the hood, Rancher Monitoring uses the upstream Prometheus Operator to configure Prometheus and AlertManager. You can find more information in the [Prometheus Operator documentation](https://prometheus-operator.dev/).

The following examples show how you can configure Prometheus Operator through the Kubernetes API. Alternatively, you can also create these resources through the Rancher UI in the Monitoring section of the cluster.

## Deploying a workload

In order to add metrics from your custom workload, your workload needs to expose metrics in the format that Prometheus understands. Prometheus expects workloads (targets) to expose their metrics over standard HTTP(S) (see [Prometheus Exposition Formats](https://prometheus.io/docs/instrumenting/exposition_formats/)). There are [exporters](https://prometheus.io/docs/instrumenting/exporters/) available for lots of different existing 3rd party workloads like databases, queues etc., which expose their metrics in a Prometheus ready format. For your own workloads, there are libraries for all the popular programming languages and framework that can help you to implement these Prometheus metrics endpoints.

This example deploys a single node Redis instance with a Redis Prometheus Exporter as a sidecar:

**This example is meant for demonstration purposes only and is not meant to run a Redis instance in production!**

[01-redis-workload.yaml](./01-redis-workload.yaml)

## Creating a ServiceMonitor

Next, you can create a [ServiceMonitor](https://prometheus-operator.dev/docs/operator/api/#servicemonitor) that selects the redis service and instructs Prometheus to start scraping the endpoints of this service:

[02-service-monitor.yaml](./02-service-monitor.yaml)

## Adding an alert

Alerts are created with [PrometheusRules](https://prometheus-operator.dev/docs/operator/api/#prometheusrule).

[03-prometheus-rule.yaml](./03-prometheus-rule.yaml)

## Adding a Grafana dashboard

Grafana dashboards can also be added programmatically by adding a ConfigMap to the `cattle-dashboards` Namespace with the label `grafana_dashboard: "1"`.

[04-grafana-dashboard.yaml](./04-grafana-dashboard.yaml)

A good source to discover existing dashboards is the [Grafana Dashboard Directory](https://grafana.com/grafana/dashboards/).
