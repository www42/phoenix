# Local PowerShell
$PSVersionTable
az --version
az account list
az login --user tj@az.training

$location='westeurope'
$rg='AKS-Basic-RG'
$acr='aksbasic'

az acr show --name $acr --resource-group $rg
$loginServer=$(az acr show --name $acr --resource-group $rg --query 'loginServer' -o tsv)

$username=$acr
$password='oOEkfCNcju06dtYgQQRue3GyynXt+ygD'
az acr login --name $acr --username $username --password $password

$gitRoot='C:\Git\AKS_Basic'
cd $gitRoot\apps\aci-helloworld
dir
docker --version
docker build -t helloworld .
docker images
docker run -d -p 8080:80 helloworld
docker ps -a
docker kill f9
docker rm f9