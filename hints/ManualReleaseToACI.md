Manual Release to ACI

Navigate to your Azure Container Registry in the Azure Portal and right click your container Image to run it. *If "Run instance" is not available, make sure the admin user in your Azure Container Registry is activated!**

![Run on ACI](images/manualRunOnAci.jpg)

Or use the command line as described in the sample. 
For usage of images of your private ACR also specify 
**fully qualified image name and ACR credentials**.
 
Sample: 
```
az container create --name mycontainer --image IMAGENAME --resource-group myResourceGroup --ip-address public --port 8080
```
