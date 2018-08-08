# Kubernetes Operational InsightsChallenge

> In this chapter you will upgrade your application to use another implementation of the calculator backend written in Go. You have heard that Go is so much faster and better and want to try this out without interrupting your users. Therefore you have to do a blue green deployment with your old frontend and backend along with your new go-calc-backend. All containers are sending telemetry to Application Insights (assuming you have configured the configuration of the insights key correctly) - so you should be able to evaluate the performance of your new container relative to the old one. If it does not improve your service you should perform a rollback - all without impacting your users.

## Here's what you'll learn:

> - How to set up and configure ingress
> - Learn how Helm facilitates the deployment of complex container dependencies
> - How to gain insights into your application performance using Application Insights
> - How to rollback a deployment

## 1. Containerize the go-calc-backend

- Install and configure Go on your build machine
- Build a container
- Put it in your container registry

**If you do not want to build the go backend** you can use the already built image from docker hub:

<https://hub.docker.com/r/denniszielke/go-calc-backend/>
<https://hub.docker.com/r/denniszielke/js-calc-frontend/>
<https://hub.docker.com/r/denniszielke/js-calc-backend/>

## 2. Deploy an ingress controller

- Learn about ingress controller (<https://kubernetes.io/docs/concepts/services-networking/ingress/)>
- Deploy an ingress controller via Helm (<https://github.com/kubernetes/charts/tree/master/stable/nginx-ingress)>
- Configure the routes for ingress to your application. 

> Need help with Helm? Check hints [here :blue_book:](hints/helm.md)!


## 3. Deploy your new backend

- Create a deployment yaml file with and ingress resource, your pod deployments and services
- make sure, your service definitions don't use type *LoadBalancer* as traffic from the internet will be handled by the ingress controller now
- Make sure that the environment variables for PORT and INSTRUMENTATIONKEY are set correctly
- Deploy everything into your cluster

>INFO: There is a sample *ingress.yml* in the *hints/yaml* folder you can us to redirect traffic from the ingress controller to your frontend service.

## 4. Analyze and Improve the performance of your new backend

![](/img/appmap.jpg)

- Trigger a continuous look and generate sufficient telemetry data
- Use Application Insights to compare the performance
- Use OMS to check for performance and health of the containers and your cluster
- If the performance is not good enough perform a rollback

