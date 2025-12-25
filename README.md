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
