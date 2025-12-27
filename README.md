# ✅ Problem Statement 1 (PS1)

## 1. Objective

The objective of this project is to **containerize and deploy the Wisecow application** on a Kubernetes environment (Docker Desktop / Minikube / Kind) with:

* Automated **CI/CD using GitHub Actions**
* Secure **TLS-based access** using Kubernetes Ingress
* Optional **Zero-Trust Runtime Security** using KubeArmor

This repository demonstrates real-world DevOps practices including Dockerization, Kubernetes deployment, CI/CD automation, ingress-based TLS, and runtime security enforcement.

---

---

## 2. Dockerization

### 2.1 Dockerfile

The Wisecow application is packaged using a Dockerfile.

**Key points:**

* Lightweight base image
* Exposes application port
* Runs Wisecow startup script

**Build locally:**

```bash
docker build -t wisecow:2.0 .
```

**Run locally:**

```bash
docker run -p 4499:4499 wisecow:2.0
```

---

## 3. Kubernetes Deployment

### 3.1 Deployment

* Runs 2 replicas of Wisecow
* Uses Docker Hub image `usernam/wisecow:2.0`

```bash
kubectl apply -f k8s/deployment.yaml
```

### 3.2 Service

* Exposes Wisecow internally and via NodePort

```bash
kubectl apply -f k8s/service.yaml
```

Verify:

```bash
kubectl get pods
kubectl get svc
```

---

## 4. Ingress & TLS Configuration

### 4.1 Ingress Controller

NGINX Ingress Controller is installed in the cluster.

```bash
kubectl get pods -n ingress-nginx
```

### 4.2 TLS Setup

* Self-signed certificate generated
* Stored as Kubernetes TLS secret
* Ingress configured for HTTPS

```bash
kubectl create secret tls wisecow-tls \
--cert=tls/tls.crt \
--key=tls/tls.key

kubectl get secret wisecow-tls

kubectl apply -f k8s/ingress.yaml
```

### 4.3 Host Mapping

Add entry to `/etc/hosts`:
```
sudo nano /etc/hosts
entry at last 127.0.0.1    wisecow.local
```

```text
127.0.0.1 wisecow.local
```

Access:

```
https://wisecow.local
```

---

## 5. CI/CD with GitHub Actions

### 5.1 Continuous Integration (CI)

GitHub Actions workflow performs:

* Checkout code
* Build Docker image
* Push image to Docker Hub

Triggered on:

```yaml
on:
  push:
    branches: ["main"]
```

### 5.2 Continuous Deployment (CD) – Challenge Goal

> ⚠️ **Important Note**

GitHub Actions **cannot directly deploy to a local Kubernetes cluster** (Docker Desktop / Minikube) because it runs in GitHub-hosted runners.

**CD is possible only when:**

* Kubernetes cluster is hosted on EC2 / Cloud VM
* `kubeconfig` is securely added as GitHub Secret

In this project:

* CI is fully automated
* Deployment is applied manually to local cluster

This behavior is **expected and correct** for a local setup.

---


---

## 6. Expected Artifacts (Completed)

✔ Wisecow application source code
✔ Dockerfile
✔ Kubernetes manifests (Deployment, Service, Ingress)
✔ GitHub Actions CI workflow
✔ TLS-secured access

---

## 7. End Goal Status

✅ Application containerized
✅ Deployed to Kubernetes
✅ Exposed securely via HTTPS
✅ CI pipeline automated
✅ Security controls enforced


# ✅ Problem Statement 2 (PS2)

This problem demonstrates basic system automation and monitoring skills using scripting (Bash).
Two objectives were selected and implemented to showcase real-world DevOps/Linux operational tasks.

---

## Selected Objectives

### ✅ 1. System Health Monitoring Script

### ✅ 2. Application Health Checker

---

## 1. System Health Monitoring Script

### Objective

Monitor the health of a Linux system and alert when system resources exceed predefined thresholds.

### What the Script Checks

* **CPU Usage** (Alert if > 80%)
* **Memory Usage** (Alert if > 80%)
* **Disk Usage** (Alert if > 80%)
* **Running Processes** (basic count / top consumers)

### How It Works

* Collects system metrics using standard Linux commands.
* Compares current usage against threshold values.
* Prints alerts to the console (can be redirected to a log file).

### Execution

```bash
bash system_health.sh
```

### Output

* Displays current CPU, memory, and disk usage.
* Shows warning messages if any threshold is crossed.

---

## 2. Application Health Checker

### Objective

Check whether an application is **UP or DOWN** by validating HTTP response status codes.

### What the Script Checks

* Sends an HTTP request to the application URL.
* Verifies the returned **HTTP status code**.
* Determines application availability.

### Health Logic

| Status Code          | Result                  |
| -------------------- | ----------------------- |
| 200–299              | Application is **UP**   |
| Others / No response | Application is **DOWN** |

### Execution

```bash
bash app_health_check.sh
```

### Output

* Clearly indicates whether the application is **UP** or **DOWN**.
* Prints HTTP status code for troubleshooting.

---






# ✅ Problem Statement 3 (PS3)

## Zero-Trust KubeArmor Policy

### Objective

Apply a **zero-trust KubeArmor policy** to the Wisecow workload and demonstrate policy violations.

---

## Step-by-Step Execution

### 1. Install KubeArmor

```bash
kubectl apply -f https://raw.githubusercontent.com/kubearmor/KubeArmor/main/deployments/kubearmor.yaml
```

Verify:

```bash
kubectl get pods -n kubearmor
```

---
KubeArmor does NOT print deny alerts automatically in relay logs.

You need one of these:
Option 1️⃣ karmor CLI

### 2. Install karmor CLI

```bash
curl -sfL https://raw.githubusercontent.com/kubearmor/kubearmor-client/main/install.sh | sh
export PATH=$PATH:$(pwd)/bin
```

Verify:

```bash
karmor version
```

---

### 3. Apply Zero-Trust Policy

```
zerotrustpolicy.yaml
```

```bash
kubectl apply -f wisecow-policy.yaml
```

---

### 4. Trigger Policy Violation

```bash
kubectl exec -it <wisecow-pod> -- sh
cat /etc/passwd
```

Expected:

```
Permission denied
```

---

### 5. Observe Alerts

```bash
karmor logs --namespace default
```

---


### Final Result

* Zero-trust policy enforced
* Unauthorized file access blocked
* Alert captured via karmor

---

---

# ✅ Assignment Completion Checklist

* [x] Wisecow deployed on Kubernetes
* [x] Application accessible
* [x] Zero-trust KubeArmor policy applied
* [x] Policy violation demonstrated
* [x] Logs captured using karmor

---
