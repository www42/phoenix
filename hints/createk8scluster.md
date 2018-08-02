# Create container cluster
https://docs.microsoft.com/en-us/azure/aks/kubernetes-walkthrough

**Hint:** The "set KEY value" values commands work in Powershell. In Bash use KEY=value.

1. Use bash to create the resource group by using azure cloud shell (https://shell.azure.com/ )
```
LOCATION=eastus
KUBE_GROUP=myKubeRG
KUBE_NAME=myFirstKube
az group create -n $KUBE_GROUP -l $LOCATION
```

2. Create the aks cluster
https://docs.microsoft.com/en-us/azure/aks/tutorial-kubernetes-deploy-cluster
```
az provider register -n Microsoft.ContainerService
set KUBE_NAME myFirstKube
az aks create --name $KUBE_NAME --resource-group $KUBE_GROUP --node-count 3 --generate-ssh-keys --kubernetes-version 1.8.2
```
on the command line if you have to use the given service principal (because you are not allowed to create services principals in azure ad) add the following parameters
```
--client-secret HEREBESECRET --service-principal HEREBEAPPID


bash-4.3# az aks create
usage: az aks create [-h] [--verbose] [--debug]
                     [--output {json,jsonc,table,tsv}] [--query JMESPATH]
                     --resource-group RESOURCE_GROUP_NAME --name NAME
                     [--ssh-key-value SSH_KEY_VALUE]
                     [--dns-name-prefix DNS_NAME_PREFIX] [--location LOCATION]
                     [--admin-username ADMIN_USERNAME]
                     [--kubernetes-version KUBERNETES_VERSION]
                     [--node-vm-size NODE_VM_SIZE]
                     [--node-osdisk-size NODE_OSDISK_SIZE]
                     [--node-count NODE_COUNT]
                     [--service-principal SERVICE_PRINCIPAL]
                     [--client-secret CLIENT_SECRET]
                     [--tags [TAGS [TAGS ...]]] [--generate-ssh-keys]
                     [--no-wait]
```
3. Export the kubectrl credentials files. 
```
az aks get-credentials --resource-group=$KUBE_GROUP --name=$KUBE_NAME
```
4. Download kubectl for your plattform
https://kubernetes.io/docs/tasks/tools/install-kubectl/ 

5. Check that everything is running ok
```
kubectl cluster-info
```
8. Launch the dashboard
```
kubectl proxy
```

Go to kubernetes dashoard
http://localhost:8001/api/v1/namespaces/kube-system/services/kubernetes-dashboard/proxy/#!/pod?namespace=default 
