# Kubernetes Multicontainer

First, we need to create our own images of the sample application. Switch over to the *apps/js-calc-frontend* folder.

1. Build images local. 
Navigate to the multi-calculator folder and into the calc-frontend folder.
Then run:
```
docker build -t calcfrontend .
```
Do the same for the backend (folders *go-calc-backend* and *js-calc-backend*).

2. Push the images to your ACR.
    - Login to your ACR
    ```
    docker login YOURREGISTRY.io
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

3. Run your images by using YAML files (you can find sample file under *hints/yaml* folder). Make sure, you adjust the files with your own container registry/tags of the images.
You will need to deploy your pods for the backend + a backend service and the frontend pods + a frontend service. E.g.:
```
kubectl apply -f backend-pod.yml
kubectl apply -f backend-svc.yml
kubectl apply -f frontend-pod.yml
kubectl apply -f frontend-svc.yml
```
Have a look at the frontend-svc.yml file (type: **LoadBalancer**! You will receive a public IP adress that exposes your frontend service to the public internet from the Azure load balancer!).


