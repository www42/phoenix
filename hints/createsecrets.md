# Create Azure Container Registry secret in Kubernetes

Create a Kubernetes secret that can be referenced whenever a Docker image must be pulled from your private registry, e.g. your Azure Container Registry
```
kubectl create secret docker-registry kuberegistry --docker-server myveryownregistry-on.azurecr.io --docker-username username --docker-password password --docker-email example@example.com

```

or

```
kubectl create secret docker-registry kuberegistry --docker-server $REGISTRY_URL --docker-username $REGISTRY_NAME --docker-password $REGISTRY_PASSWORD --docker-email example@example.com
```
Further reading: https://medium.com/devoops-and-universe/your-very-own-private-docker-registry-for-kubernetes-cluster-on-azure-acr-ed6c9efdeb51

# Deploying additional secrets
https://kubernetes.io/docs/concepts/configuration/secret/

Simple way to deploy secrets via command line
```
kubectl create secret generic mySecretName --from-literal=username=someRandomSecretValue
```
OR do it via yaml files  - here secrets must be base64 encoded.
~~~
echo -n "someRandomSecretValue" | base64
~~~

Later, we need secrets for Application Insights. To create an Application Insights secret in your Kubernetes cluster required for the sample application, enter the following with the correct instrumentation key
~~~
kubectl create secret generic appinsightsecret --from-literal=appinsightskey=12345678
~~~

Or define the secret in yaml file (remember, value must be base64 encoded)
```
apiVersion: v1
kind: Secret
metadata:
  name: mySecretName
type: Opaque
data:
  username: c29tZVJhbmRvbVNlY3JldFZhbHVl
```

Deploy secret to cluster
```
kubectl create -f secrets.yml
```

# Referencing a secret from an environment variable

Assuming you have deployed your secret to your cluster you can now reference your secret during deployments and set the value of a secret to an environment variable like this:

```
apiVersion: v1
kind: Pod
metadata:
  name: secret-env-pod
spec:
  containers:
  - name: mycontainer
    image: redis
    env:
      - name: SECRET_USERNAME
        valueFrom:
          secretKeyRef:
            name: mySecretName
            key: mySecretLookUpKey
```
