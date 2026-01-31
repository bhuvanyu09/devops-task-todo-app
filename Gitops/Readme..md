# GitOps Deployment Strategy

This directory represents the configuration repository in a GitOps architecture. In a real-world production environment, this folder would contain the Kubernetes manifests (YAMLs) or Helm charts that define the desired state of the cluster.

## 🔄 The GitOps Workflow

We strictly follow the "Pull Model" for deployment to ensure security and auditability. The CI pipeline (Jenkins) never touches the Kubernetes cluster directly.

### 1. How Deployments are Triggered
1.  **CI Pipeline:** Jenkins builds the Docker image and pushes it to the registry with a new tag (e.g., `v123`).
2.  **Config Update:** Jenkins automatically commits a change to *this* repository, updating the image tag in `deployment.yaml` from `v122` to `v123`.
3.  **Sync:** A GitOps operator running inside the cluster (like **ArgoCD** or **Flux**) detects the change in this Git repository.
4.  **Apply:** The operator pulls the new manifest and applies it to the cluster, updating the application.

### 2. How Rollback is Performed
Rollbacks are instantaneous and handled entirely via Git, not by running complex scripts.

1.  **Identify Fault:** If version `v123` is buggy, we identify the previous working commit hash.
2.  **Git Revert:** We execute `git revert HEAD` in this repository to restore the file state to `v122`.
3.  **Auto-Healing:** ArgoCD detects that the Git state (`v122`) no longer matches the Cluster state (`v123`). It immediately forces the cluster back to `v122`, effectively performing the rollback.

## 📂 Directory Structure (Simulation)

If this were a live environment, the structure would be:

```text
gitops/
├── base/                   # Common configurations
│   ├── deployment.yaml
│   └── service.yaml
├── overlays/               # Environment-specific changes
│   ├── dev/
│   │   └── kustomization.yaml
│   └── prod/
│       └── kustomization.yaml
└── applications/           # ArgoCD Application CRDs
    └── todo-app.yaml