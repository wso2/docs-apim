# Publish an API to a Cloud Cluster in PrivateJet Mode

In an age where more and more applications are adopting the microservice architecture, it is obvious that container-orchestration systems such as Kubernetes have gained popularity due to the attractive functionalities they offer to simplify a number of complex management tasks.
Automating computer application deployment, scaling, and management are a few of such functionalities to name. WSO2 API Manager provides cloud-native API management, where a user is able to expose microservices as managed APIs in cloud environment such as Kubernetes. 
This could be done with the support of WSO2-Kubernetes API Operator. 

 [![Architecture]({{base_path}}/assets/img/learn/privatejet-mode/architecture.png)]({{base_path}}/assets/img/learn/privatejet-mode/architecture.png)

Microservices will be exposed as managed APIs in cloud clusters in the PrivetJet mode. Here, each microservice wll have a dedicated [WSO2 API Microgateway](https://wso2.com/api-management/api-microgateway/). This will provide maximum security and guaranteed resource allocation for API execution. As depicted in the above diagram, When the APIs published via API-Manager in cloud environments, deployment, scaling, and management tasks will handle by the WSO2 -Kubernetes API Operator itself.

!!! attention "Before you Begin"
    1. Follow the document [Enabling PrivateJet Mode for Microgateways]({{base_path}}/install-and-setup/setup/kubernetes-operators/k8s-api-operator/enabling-privatejet-mode-to-deploy-apis/) to enable deploying APIs to cloud clusters in PrivateJet mode.
    2. Follow the document [Securing APIs deployed in cloud clusters]({{base_path}}/design/api-security/api-authentication/securing-apis-deployed-in-cloud-clusters/) to secure the API using any other [authentication mechanisms](https://github.com/wso2/k8s-api-operator/blob/v1.2.0-alpha/docs/HowToGuide/OverviewOfCrds/apply-security-to-api.md) other than JWT authentication. 

## Publish an API to a Cloud Cluster in PrivateJet Mode  
 
1. Start the API-M server.

2. Sign in to the API Publisher `https://<hostname>:9443/publisher` (e.g., `https://localhost:9443/publisher` ). Upon signing in, the list of APIs in the API Publisher is listed. Please refer [create an API guide]({{base_path}}/design/create-api/create-a-rest-api.md) to create a new API. 

3. Click on an API that is in the **CREATED** state.
   
     <a href="{{base_path}}/assets/img/learn/select-created-api.png"><img src="{{base_path}}/assets/img/learn/select-created-api.png" alt="Select API" title="Select API" width="35%" /></a>

    
3. Click the *Environments* tab and select the cluster(s) to deploy the API.
    
     ![Environments]({{base_path}}/assets/img/learn/privatejet-mode/environment.png)
    
4. Click the **Lifecycle**  tab  and publish the API.  This will expose microservices as managed APIs in selected clusters.
 
     ![API LifeCycle]({{base_path}}/assets/img/learn/privatejet-mode/lifecycle_publish.png)
     
Now, you have successfully published your API to a cloud cluster. Next, you can [test your API by invoking it from the developer portal]({{base_path}}/consume/invoke-apis/invoke-apis-using-tools/invoke-an-api-using-the-integrated-api-console/#invoke-an-api-deployed-on-a-cloud-cluster).
