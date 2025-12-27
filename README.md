# ✅ Problem Statement 1 (PS1)
## CI/CD Deployment Strategy

This project uses GitHub Actions for Continuous Integration (CI):

- On every push to main:
  - Docker image is built
  - Image is pushed to Docker Hub

### Why Continuous Deployment is not automated to Kubernetes?

The Kubernetes cluster used in this project is a local Docker Desktop cluster.
GitHub-hosted runners do not have network access to local Kubernetes environments.

In real-world production, Continuous Deployment would be achieved by:
- Deploying to a cloud-based Kubernetes cluster (EKS/GKE/AKS), or
- Using a self-hosted GitHub Actions runner inside the cluster, or
- Using GitOps tools like ArgoCD or FluxCD.

For this assessment:
- Kubernetes manifests are provided
- Deployment is applied manually using kubectl
- CI/CD design and understanding are demonstrated







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

### Author

**Muthu Raj**
Cloud / DevOps / Kubernetes Security Learner
