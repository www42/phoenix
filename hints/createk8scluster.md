# Create container cluster

**Hint:** The "set KEY value" values commands work in Powershell. In Bash use KEY=value.

0. Choose a region for your cluster where AKS is supported

```
az provider list --query "[?namespace=='Microsoft.ContainerService'].resourceTypes[] | [?resourceType=='managedClusters'].locations[]" -o tsv
```

1. Use bash to create the resource group. You can also use [Azure Cloud Shell](https://shell.azure.com/) for that task.
```
LOCATION=<your_region>
KUBE_GROUP=myKubeRG
KUBE_NAME=myFirstKube
az group create -n $KUBE_GROUP -l $LOCATION
```

2. Create the aks cluster
https://docs.microsoft.com/en-us/azure/aks/tutorial-kubernetes-deploy-cluster
```
OPTIONAL (when errors occur): az provider register -n Microsoft.ContainerService
set KUBE_NAME myFirstKube
az aks create --name $KUBE_NAME --resource-group $KUBE_GROUP --node-count 3 --generate-ssh-keys --kubernetes-version 1.10.8
```
on the command line, if you have to use the given service principal (because you are not allowed to create services principals in Azure AD), add the following parameters
```
--client-secret HEREBESECRET --service-principal HEREBEAPPID


```
3. Export the kubectrl credentials files. 
```
az aks get-credentials --resource-group=$KUBE_GROUP --name=$KUBE_NAME
```
If you were using Azure Cloud Shell:
```
az aks get-credentials --resource-group=$KUBE_GROUP --name=$KUBE_NAME -f config
download config
```
Then place the config file in your userhome folder under %HOMEPATH%\\.kube

4. Download kubectl for your plattform
https://kubernetes.io/docs/tasks/tools/install-kubectl/ 

Make sure to use the corresponding version for your Kubernetes cluster version. If your were creating the cluster in a shell on your local machine, you can also use:
```
az aks install-cli
```

> Need a cheat sheet? Get it here: <https://kubernetes.io/docs/reference/kubectl/cheatsheet/>

5. Check that everything is running ok
```
kubectl cluster-info
```
8. Launch the dashboard
```
kubectl proxy
```
or via 

Go to kubernetes dashoard
http://localhost:8001/api/v1/namespaces/kube-system/services/kubernetes-dashboard/proxy/#!/pod?namespace=default 


**If the Kubernetes Dashboard is displaying errors** (e.g. permission errors), fix them by following [this tutorial](https://docs.microsoft.com/en-us/azure/aks/kubernetes-dashboard#for-rbac-enabled-clusters)
