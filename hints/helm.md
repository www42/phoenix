# Using Helm

https://github.com/kubernetes/helm
## Installing Helm and Tiller

### Install Helm

https://docs.microsoft.com/en-us/azure/aks/kubernetes-helm
https://github.com/helm/helm/blob/master/docs/install.md

### Install/configure Helm and Tiller

```
helm init --service-account tiller
echo "Updating chart repo..."
helm repo update
```

See all pods (including tiller)
```
kubectl get pods --namespace kube-system
```

Test Helm by installing MySQL (optional)
```
helm install stable/mysql
```

Reinstall or delete Tiller
```
helm reset
```

> You can find more Helm charts via https://kubeapps.com/

## Create your own helm chart (optional)

1. Create using draft

Go to app folder and launch draft
https://github.com/Azure/draft 
```
draft create
```

2. Create helm chart manually and modify accordingly

```
helm create multicalc
```
Validate template
```
helm lint ./multicalchart
```

3. Dry run the chart and override parameters
```
helm install --dry-run --debug ./multicalchart --set frontendReplicaCount=3
```

4. Make sure you have the app insights key secret provisioned
```
kubectl create secret generic appinsightsecret --from-literal=appinsightskey=$APPINSIGHTS_KEY
```

5. Install
```
helm install multicalchart --name=c3 --set frontendReplicaCount=1 --set backendReplicaCount=1 --set image.frontendTag=redis --set image.backendTag=redis
```

6. verify
```
helm get values c3
```

7. Change config and perform an upgrade
```
helm upgrade --set backendReplicaCount=4 c3 multicalchart
```

8. See rollout history
```
helm history c3
helm rollback c3 1
```

9. Cleanup
```
helm delete c3 --purge
```