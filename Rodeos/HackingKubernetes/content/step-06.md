+++
title = "Deploy the vulnerable sample application"
weight = 6
+++

**Run the following commands on the victim01 VM.**

Create some cloud-provider fake access token. This could theoretically be used by a Kubernetes cloud controller to provision load balancer or persistent volumes:

```ctr
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Secret
metadata:
  name: digitalocean
  namespace: kube-system
stringData:
  access-token: this-does-not-work
EOF  
```

Let's now deploy a sample application that will be vulnerable to a Log4Shell attack:

```ctr
cat <<EOF | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: sample-app
  name: sample-app
  namespace: default
spec:
  replicas: 1
  selector:
    matchLabels:
      app: sample-app
  template:
    metadata:
      labels:
        app: sample-app
    spec:
      containers:
      - image: docker.io/bashofmann/hacking-kubernetes-vulnerable-application:latest
        imagePullPolicy: Always
        name: sample-app
        ports:
        - containerPort: 8080
        securityContext:
          runAsUser: 0
EOF
```

The application will be exposed through an Ingress:

```ctr
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Service
metadata:
  labels:
    app: sample-app
  name: sample-app
  namespace: default
spec:
  ports:
  - name: http
    port: 8080
    protocol: TCP
    targetPort: 8080
  selector:
    app: sample-app
  type: ClusterIP
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: sample-app
  namespace: default
spec:
  rules:
  - host: sample-app.default.${vminfo:victim01:public_ip}.sslip.io
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: sample-app
            port:
              number: 8080
EOF
```

You now should be able to access the application at [http://sample-app.default.${vminfo:victim01:public_ip}.sslip.io](http://sample-app.default.${vminfo:victim01:public_ip}.sslip.io).
