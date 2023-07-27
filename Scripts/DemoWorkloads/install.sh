#!/usr/bin/env bash

cd $(dirname $0)

set -e

helm repo add rodeo https://rancher.github.io/rodeo/
helm repo add rancher-charts https://charts.rancher.io
helm repo add jetstack https://charts.jetstack.io
helm repo add neuvector https://neuvector.github.io/neuvector-helm/
helm repo add kubewarden https://charts.kubewarden.io
helm repo add open-telemetry https://open-telemetry.github.io/opentelemetry-helm-charts

helm repo update

helm upgrade --install cert-manager jetstack/cert-manager --namespace cert-manager --version v1.12.0 --set installCRDs=true --wait --create-namespace
kubectl apply -f cert-manager
kubectl create namespace longhorn-system || true
kubectl delete secret -n longhorn-system backup-credentials || true
kubectl create secret generic -n longhorn-system backup-credentials --from-env-file=<(tail ${HOME}/.aws/credentials -n 2 | awk '{printf "%s=%s\n",toupper($1), $3}')
helm upgrade --install --namespace longhorn-system longhorn-crd rancher-charts/longhorn-crd --create-namespace --wait
helm upgrade --install --namespace longhorn-system longhorn rancher-charts/longhorn --create-namespace --set "defaultSettings.backupTarget=s3://bhofmann-longhorn-backup@eu-central-1/" --set "defaultSettings.backupTargetCredentialSecret=backup-credentials"
helm upgrade --install --namespace cattle-monitoring-system rancher-monitoring-crd rancher-charts/rancher-monitoring-crd --create-namespace --wait
helm upgrade --install --namespace cattle-monitoring-system rancher-monitoring rancher-charts/rancher-monitoring --create-namespace -f monitoring/values.yaml
helm upgrade --install --namespace cattle-gatekeeper-system rancher-gatekeeper-crd rancher-charts/rancher-gatekeeper-crd --create-namespace --wait
helm upgrade --install --namespace cattle-gatekeeper-system rancher-gatekeeper rancher-charts/rancher-gatekeeper --create-namespace
helm upgrade --install --namespace cattle-logging-system rancher-logging-crd rancher-charts/rancher-logging-crd --create-namespace --wait
helm upgrade --install --namespace cattle-logging-system rancher-logging rancher-charts/rancher-logging --create-namespace
helm upgrade --install --namespace istio-system rancher-kiali-server-crd rancher-charts/rancher-kiali-server-crd --create-namespace --wait
helm upgrade --install --namespace istio-system rancher-istio rancher-charts/rancher-istio --create-namespace --set tracing.enabled=true
kubectl apply -f helm-repos
kubectl create namespace shop || true
kubectl label namespace shop istio-injection=enabled || true
kubectl create namespace bookinfo || true
kubectl label namespace bookinfo istio-injection=enabled || true
helm upgrade --install --namespace shop shop rodeo/online-boutique --create-namespace -f shop/values.yaml
helm upgrade --install --namespace rancher-demo rancher-demo rodeo/rancher-demo --create-namespace -f rancher-demo/values.yaml
helm upgrade --install --namespace tetris tetris rodeo/tetris --create-namespace -f tetris/values.yaml
helm upgrade --install --namespace bookinfo bookinfo rodeo/bookinfo --create-namespace
helm upgrade --install --namespace wordpress wordpress rodeo/wordpress --create-namespace -f wordpress/values.yaml
kubectl apply -f longhorn_monitoring/
helm upgrade --install neuvector-crd --namespace cattle-neuvector-system rancher-charts/neuvector-crd --create-namespace
helm upgrade --install neuvector --namespace cattle-neuvector-system rancher-charts/neuvector --create-namespace -f neuvector/values.yaml
helm upgrade --install neuvector-monitor --namespace cattle-neuvector-system neuvector/monitor --create-namespace -f neuvector/monitor-values.yaml
kubectl apply -f nginx_ingress

helm upgrade --install --wait \
  --namespace open-telemetry \
  --create-namespace \
  open-telemetry-operator open-telemetry/opentelemetry-operator

helm upgrade --install rancher-kubewarden-crds --namespace cattle-kubewarden-system kubewarden/kubewarden-crds --create-namespace --version 1.3.1
helm upgrade --install rancher-kubewarden-controller --namespace cattle-kubewarden-system kubewarden/kubewarden-controller --create-namespace --version v1.5.3 -f kubewarden/controller-values.yaml
helm upgrade --install rancher-kubewarden-defaults --namespace cattle-kubewarden-system kubewarden/kubewarden-defaults --create-namespace --version v1.6.1 -f kubewarden/values.yaml

kubectl apply -f gatekeeper_constraint/
kubectl apply -f kubewarden_monitoring/
