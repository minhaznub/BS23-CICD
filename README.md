
# Weather api app on AKS with CI/CD and Observability

This project builds the API app Docker image, pushes it to Docker Hub, and provisions the AKS cluster infrastructure using a fully automated Terraform pipeline. It deploys the app in the AKS cluster and sets up Grafana and Prometheus for observability through an automated pipeline.

---
## Project Structure


## 🚀 Release & Deploy Workflow
set the folling secrets in github project 
![alt text]({A65B21E9-E350-40A9-A4D0-97503C3231AF}.png)

### 🔁 Step 1: Create a New Release (e.g. `v1.0.9`)

1. Clone the repo and Push your latest changes to your repo (including updated `version.txt`) to `main`
    Example: [Releases](https://github.com/minhaznub/BS23-CICD/releases)
2. Click **"Draft a new release"**
3. Tag version: `v1.0.9`
4. Release title: `v1.0.9`
5. Click **"Publish release"**

> ✅ This triggers a GitHub Actions "Build & Docker Push" workflow that: 
> - Builds and tags the Docker image
    https://github.com/minhaznub/BS23-CICD/actions/workflows/release-build.yml
> - Pushes it to Docker Hub as [`minhajulcse7/weatherapp:v1.0.9`](https://hub.docker.com/repository/docker/minhajulcse7/weatherapp/tags)

---

### ☁️ Step 2: Provision AKS Infrastructure (Once)

This creates the AKS cluster and required network using Terraform.

1. Go to GitHub Actions → Run workflow: **"Terraform AKS Infrastructure"**
see the old run here: https://github.com/minhaznub/BS23-CICD/actions/runs/15968550919
2. Input `action = apply` and click **Run**
3. Terraform provisions:
   - Resource Group
   - AKS Cluster
   - Networking

Deprovision the infra with selecting "destroy" when done with the testing ![alt text]({713B78EC-DE35-43BC-9EBD-D84592CD27EB}.png)

Secrets needed:
- `ARM_CLIENT_ID`, `ARM_CLIENT_SECRET`, `ARM_SUBSCRIPTION_ID`, `ARM_TENANT_ID`

---

### 🐳 Step 3: Deploy the App to AKS

1. Run the GitHub Actions workflow: **"Deploy app to AKS"**
workflow run: https://github.com/minhaznub/BS23-CICD/actions/workflows/deploy-app.yml
2. The workflow will:
   - Fetch the latest release tag (`v1.0.9`)
   - Patch `deployment.yaml` with the correct image tag
   - Apply manifests in `k8s_manifest/`
   - Wait for zero-downtime rolling update to finish

Make sure the GitHub secret `AZURE_KUBECONFIG_B64` (base64 of kubeconfig) is configured.

after the pipeline **"Deploy app to AKS"** succeeded . 
visit aks cluster http://<EXTERNAL-IP of "flask-api-servie"> /api/hello

![alt text]({6574FE9D-58A3-4456-8DEB-43AE3DA87BF6}.png)

For health: visit
http://<EXTERNAL-IP of "flask-api-servie"> /api/health
![alt text]({23D5D76E-1184-4C4F-B7BD-CDBB97308AB3}.png)

---

## 📊 Observability Setup (Prometheus + Grafana)

> Automatically deployed with the GitHub Actions workflow: **"Deploy Observability Stack"**

Copy the EXTERNAL-IP of grafana-service

Visit: http://<EXTERNAL-IP>

Login:
Username: admin
Password: supersecurepassword123

### Dashboards Included:
- Request count
- Request duration
- Status breakdown


