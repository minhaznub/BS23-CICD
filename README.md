
#How to run deployment locally
az aks get-credentials --resource-group aks-rg --name prod-aks-cluster

kubectl apply -f k8s_manifest/
# Check deployment status
kubectl get deployments

# Check pods
kubectl get pods

# Check service (to get LoadBalancer IP)
kubectl get svc

http://<EXTERNAL-IP>/api/hello
http://<EXTERNAL-IP>/api/health
