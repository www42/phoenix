# Kubernetes Multicontainer

First, we need to create our own images of the sample application. 

1. Build images local. 
Navigate to the *apps* folder and into the *js-calc-frontend* folder.
Then run:
```
docker build -t calcfrontend .
```
Do the same for the backend (folder: *apps/js-calc-backend*).

2. Push the images to your ACR.
    - Login to your ACR
    ```
    docker login YOURREGISTRY.azurecr.io
    ```
    Provide username and password as found in the portal.
    
    - Tag your image
    ```
    docker tag calcfrontend YOURREGISTRY.azurecr.io/calcfrontend
    ```

    - Then push your images. Do it for both frontend and backend images.
    ```
    docker push YOURREGISTRY.azurecr.io/calcfrontend
    ```
    Your images are now available in your ACR.

3. Run your images by using YAML files (you can find sample files under *hints/yaml* folder). Make sure, you adjust the files with your own container registry/tags of the images.
You will need to deploy your pods for the backend + a backend service and the frontend pods + a frontend service. E.g.:
```
kubectl apply -f backend-pod.yml
kubectl apply -f backend-svc.yml
kubectl apply -f frontend-pod.yml
kubectl apply -f frontend-svc.yml
```
Have a look at the frontend-svc.yml file (type: **LoadBalancer**! You will receive a public IP adress that exposes your frontend service to the public internet via the Azure load balancer!).


