# Todo Summary Assistant - DevOps Edition

This repository contains the source code and DevOps configuration for the Todo Summary Assistant application. The project has been containerized and configured for a complete CI/CD workflow using Jenkins, Docker, and Kubernetes with a GitOps approach.

---

## 🚀 Project Understanding & Local Execution

### Local Run Steps
To run this application locally without Docker (for development or testing):

1.  **Prerequisites:**
    * Java Development Kit (JDK) 17
    * Maven 3.8+
    * Git

2.  **Build the Application:**
    Navigate to the root directory and run the Maven wrapper or installed Maven:
    ```bash
    mvn -f Backend/todo-summary-assistant/pom.xml clean install
    ```

3.  **Run the Application:**
    Once the build is successful, execute the jar file:
    ```bash
    java -jar Backend/todo-summary-assistant/target/*.jar
    ```

4.  **Access:**
    The application server will start on port `8080`.
    * API Health Check: `http://localhost:8080/actuator/health`

### Dependencies
* **Backend:** Java 17, Spring Boot
* **Build Tool:** Maven
* **Containerization:** Docker
* **CI Pipeline:** Jenkins
* **Orchestration:** Kubernetes (Deployment & Services)
* **GitOps Strategy:** Configuration decoupled from source code (simulated structure)

### Assumptions Made
* **Database:** The application uses an in-memory H2 database for this deployment, removing the need for an external database container.
* **Ports:** Port `8080` is free on the host or container environment.
* **Infrastructure:** It is assumed that an Ingress Controller or LoadBalancer is available in the target Kubernetes cluster to expose the service externally.
* **Secrets:** In a real production environment, secrets (like DB passwords) would be injected via HashiCorp Vault or AWS Secrets Manager, rather than standard Kubernetes Secrets.

---

## 📂 DevOps Structure

This repository follows a strict separation of concerns:

| File/Folder | Description |
| :--- | :--- |
| `Dockerfile` | Multi-stage build configuration (Alpine based for security). |
| `Jenkinsfile` | CI pipeline definition (Build -> Test -> Docker Push). |
| `k8s/` | Kubernetes manifests (`deployment.yaml`, `service.yaml`). |
| `gitops/` | Documentation for the GitOps deployment strategy. |
| `FAILURE_AND_ROLLBACK.md` | Manual on handling production incidents. |
| `MONITORING_AND_OPERATIONS.md` | Operational guide for metrics and logging. |

---

## 🛠️ Architecture Overview

1.  **Code Commit:** Developer pushes code to GitHub.
2.  **CI (Jenkins):** Detects change, runs Maven build, and runs Unit Tests.
3.  **Package:** Builds an optimized Docker image and pushes it to the Registry.
4.  **CD (GitOps):** In a full environment, the pipeline would update the manifest version. An operator (like ArgoCD) would then sync the Kubernetes cluster to the new state.

---

*Submitted by: Bhuvanyu Geel*