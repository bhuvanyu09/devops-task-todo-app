# Failure & Rollback Strategy

1. **Rollback:** We use GitOps. To rollback, we execute `git revert HEAD` on the configuration repository. ArgoCD detects the change and applies the previous stable version immediately.
2. **App Crash:** Kubernetes `livenessProbes` detect the crash. The kubelet restarts the container automatically to attempt self-healing.
3. **Jenkins Down:** Deployment is decoupled from Jenkins. Since we use GitOps, we can manually update the manifest in Git, and the cluster will still sync without Jenkins.
4. **Secrets Leaked:** - Revoke the compromised credentials immediately.
   - Generate new keys.
   - Update Kubernetes Secrets/Vault.
   - Restart pods to pick up new secrets.
5. **Node Failure:** The Kubernetes Control Plane detects the `NotReady` status. The Scheduler moves the pods from the failed node to a healthy node automatically.