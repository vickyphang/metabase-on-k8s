# Installing Metabase on Kubernetes

### Overview
This repository provides a step-by-step guide to deploy a production-ready **Metabase** instance on a Kubernetes cluster. Metabase is an open-source business intelligence tool that allows you to visualize and analyze your data. This setup includes deploying **PostgreSQL** as the backend database for Metabase metadata and exposing Metabase via an **Ingress** with TLS/SSL support.



### Table of Contents
- [Prerequisites](#prerequisites)
- [Deploy PostgreSQL for Metabase Metadata](#deploy-postgresql-for-metabase-metadata)
- [Deploy Metabase](#deploy-metabase)
- [Expose Metabase via Ingress](#expose-metabase-via-ingress)
- [Accessing Metabase](#accessing-metabase)
- [References](#references)

### Prerequisites
- A running Kubernetes cluster
- `kubectl` installed
- A dynamic storage class (e.g., `nfs-storage`) for PersistentVolumeClaims (PVCs).
- An Ingress controller (e.g., Contour) and Cert-Manager for TLS/SSL certificates (optional but recommended for production).



## Deploy PostgreSQL for Metabase Metadata

Metabase requires a PostgreSQL database to store its metadata. Follow these steps to deploy PostgreSQL:

### 1. Create a Namespace for Metabase
```bash
kubectl create ns metabase
```

### 2. Create a Secret for PostgreSQL Credentials
```bash
kubectl create secret generic pg-secret -n metabase \
  --from-literal=POSTGRES_DB=metabase \
  --from-literal=POSTGRES_USER=pguser \
  --from-literal=POSTGRES_PASSWORD=supersecret
```

### 3. Deploy PostgreSQL
Apply the `postgres.yaml` manifest to deploy PostgreSQL:
```bash
kubectl apply -f postgres.yaml
```

### 4. Verify PostgreSQL Deployment
Check the status of the PostgreSQL deployment:
```bash
kubectl get pod,pvc,svc -n metabase
```


## Deploy Metabase

Once PostgreSQL is running, deploy Metabase and connect it to the PostgreSQL database.

### 1. Create a Secret for Metabase Database Connection
```bash
kubectl create secret generic mb-secret -n metabase \
  --from-literal=MB_DB_USER=pguser \
  --from-literal=MB_DB_PASS=supersecret \
  --from-literal=MB_DB_HOST=postgres
```

### 2. Deploy Metabase
Apply the `metabase.yaml` manifest to deploy Metabase:
```bash
kubectl apply -f metabase.yaml
```

### 3. Verify Metabase Deployment
Check the status of the Metabase deployment:
```bash
kubectl get pod,svc -n metabase
```


## Expose Metabase via Ingress

To access Metabase externally, expose it using an Ingress. Ensure you have an Ingress controller (e.g., Contour) and Cert-Manager installed for TLS/SSL certificates. Refer to the [Auto-Renew Ingress TLS Documentation](https://github.com/vickyphang/auto-renew-ing-tls) for setting up Cert-Manager.

### Deploy the Ingress
Apply the following Ingress manifest to expose Metabase:
```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: metabase-ingress
  namespace: metabase
  annotations:
    kubernetes.io/ingress.class: contour # Replace with your ingress controller
    cert-manager.io/cluster-issuer: letsencrypt-prod  # Replace with your cluster issuer
spec:
  tls:
  - hosts:
    - metabase.example.com
    secretName: metabase-tls  # Secret to store the certificate
  rules:
  - host: metabase.example.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: metabase
            port:
              number: 80
```

Replace `metabase.example.com` with your domain name.


## Accessing Metabase

Once the Ingress is deployed, access Metabase via the configured domain (e.g., `https://metabase.example.com`).


## References

1. [Metabase Documentation](https://www.metabase.com/docs/latest/)
2. [Deploying Metabase on Kubernetes](https://medium.com/@10anupriya/deploying-metabase-on-kubernetes-02d65d07837d)
3. [How to deploy Metabase on Kubernetes](https://medium.com/@mathieuces/how-to-deploy-metabase-on-kubernetes-4aa77b9eac2d)
