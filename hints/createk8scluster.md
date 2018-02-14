# Create container cluster
https://docs.microsoft.com/en-us/azure/aks/

**Hint:** The "set KEY value" values commands work in Powershell. In Bash use KEY=value.

1a. Create the resource group (Powershell)
```
set LOCATION westus
set KUBE_GROUP myKubeRG
az group create -n $KUBE_GROUP -l $LOCATION
```


1b. OR use bash to create the resource group 
```
LOCATION=westus
KUBE_GROUP=myKubeRG
az group create -n $KUBE_GROUP -l $LOCATION
```

2. Create the aks cluster
https://docs.microsoft.com/en-us/azure/aks/tutorial-kubernetes-deploy-cluster
```
az provider register -n Microsoft.ContainerService
set KUBE_NAME myFirstKube
az aks create --resource-group $KUBE_GROUP --name $KUBE_NAME --node-count 1 --generate-ssh-keys
```
Additional parameters can be found by typing 
```bash 
az aks create
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

or If you are not using the Azure Cloud Shell and don’t have the Kubernetes client kubectl, run 
```
az aks install-cli

scp azureuser@$KUBE_NAMEmgmt.westeurope.cloudapp.azure.com:.kube/config $HOME/.kube/config
```
4. Download kubectl for your plattform
https://kubernetes.io/docs/tasks/tools/install-kubectl/ 

5. Check that everything is running ok
```
kubectl version
kubectl config current-context
```

Use flag to use context if multiple clusters are in use
```
kubectl config use-context
```
