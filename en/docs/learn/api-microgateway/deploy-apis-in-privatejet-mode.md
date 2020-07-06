# PrivateJet mode for Microgateways
With many of applications gearing towards microservice architecture, it’s no surprise that container-orchestration systems such as Kubernetes have become so popular with functionalities such as automating computer application deployment, scaling, and management, 
which simplifies a number of complex management tasks. WSO2 API-Manager provides cloud-native API management where user can expose microservices as managed APIs in cloud environments such as Kubernetes with the support of [WSO2-Kubernetes API Operator]({{base_path}}/learn/kubernetes-operators/k8s-api-operator.md). 

 ![Architecture]({{base_path}}/assets/img/learn/privatejet-mode/architecture.png)
 
Microservices will expose as managed APIs in cloud clusters in privetJet mode, where each microservice will have a dedicated [WSO2 API Microgateway](https://wso2.com/api-management/api-microgateway/). This will provide maximum security and guaranteed resource allocation for API execution. As depicted in the above diagram, When the APIs published via API-Manager in cloud environments,
deployment, scaling, and management tasks will handle by the [WSO2 -Kubernetes API Operator]({{base_path}}/learn/kubernetes-operators/k8s-api-operator.md) itself.

## Configuring APIs to deploy in PrivateJet mode

Follow the steps below to configure the PrivateJet mode for Microgateways in API Manager to deploy APIs as managed APIs in cloud clusters. (Ex: Kubernetes)

1. Install and setup [Kubernetes API Operator]({{base_path}}/learn/kubernetes-operators/k8s-api-operator.md). In order to expose APIs using ingress controller [deploy the k8s-api-operator in ingress mode](https://github.com/wso2/k8s-api-operator/tree/v1.1.0/scenarios/scenario-17). 
2. Deploying cluster configurations
 
    Processes in containers inside pods are authenticated when contacting the apiserver and accessing resources. In order to regulate access to the resources need to establish the RBAC Authorization with at least permissions to, 
    Create, Delete, Update, Get , List, Post the customresourcedefinitions, apis and configmaps.

    i.  Create a service account

        kubectl create serviceaccount <service-account name> -n <namespace>

    ii. Create a clusterRole

        apiVersion: rbac.authorization.k8s.io/v1
        kind: ClusterRole
        metadata:
          name: clusterrole-privatejet
        rules:
        - apiGroups: ["","apiextensions.k8s.io","wso2.com"]
          resources: ["configmaps","customresourcedefinitions","apis"]
          verbs: ["get", "post", "create", "delete", "put", "list","update"]
     
    iii. Create a  clusterRoleBinding

        apiVersion: rbac.authorization.k8s.io/v1
        kind: ClusterRoleBinding
        metadata:
          name: clusterrolebinding-privatejet
        subjects:
        - kind: ServiceAccount
          name: wso2am-privatejet # Name is case sensitive
          apiGroup: ""
          namespace: default
        roleRef:
          kind: ClusterRole
          name: clusterrole-privatejet
          apiGroup: rbac.authorization.k8s.io
                                                                                                                      
3. Obtaining service account token

    First you need to get the secret name for your service account. This can be done by executing,

        kubectl get secrets -n <serviceaccount-namespace>
     
    Then, get the service account token by executing the following command,

        kubectl describe secrets -n <serviceaccount-namespace> <secret-namespace>

4. Obtaining the master URL

    In order to establish the connection with the cluster need to obtain the Master URL. this be done by executing following command.
    
        kubectl cluster-info
        
        Result:
        Kubernetes master is running at https://35.223.28.131
        GLBCDefaultBackend is running at https://35.223.28.131/api/v1/namespaces/kube-system/services/default-http-backend:http/proxy
        Heapster is running at https://35.223.28.131/api/v1/namespaces/kube-system/services/heapster/proxy
        KubeDNS is running at https://35.223.28.131/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy
        Metrics-server is running at https://35.223.28.131/api/v1/namespaces/kube-system/services/https:metrics-server:/proxy

    <html><div class="admonition note">
      <p class="admonition-title">Note</p>
      <p>If the APIM deployed in a kubenretes cluster Master URL and serviceaccount token are not required to configure. </p>
      </div>
    </html>
    
5. Adding configurations of clusters.

    For the super tenant users the cluster configurations should be added to the `<API-M_HOME>/repository/conf/deployment.toml` file as follows.
    
    ``` json tab="Format"
    [[ContainerMgtClusterConfig]]
    type = "<cloud-environment-type>"
    clusterName = "<cluster-name>"
    displayName = "<cluster-name-to_display>"
    properties.Replicas = "<number-of-replicas>"
    properties.AccessURL = "<access-URL>"
    properties.MasterURL = "<Master-URL-of-clsuter>"
    properties.SAToken = "<serviceacccount-token>"
    properties.Namespace = "<namespcae>"
    ```

    ``` json tab="Example"
    [[ContainerMgtClusterConfig]]
    type = "Kubernetes"
    clusterName = "docker-desktop"
    displayName = "cluster-1"
    properties.Replicas = 1
    properties.AccessURL = "mgw.ingress.wso2.com"
    properties.MasterURL = "https://kubernetes.docker.internal:6443"
    properties.SAToken = "eyJhbGciOiJSUzI1NiIsImtpZCI6Ijg2UlYySEFkaVBOVG4zZ3FhWERXQUxQVUQ0bjlzOXE3dFhpbUZNZlFiRjQifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJ3c28yIiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZWNyZXQubmFtZSI6IndzbzJhbS1wYXR0ZXJuLTEtc3ZjLWFjY291bnQtdG9rZW4tZGR0OTkiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC5uYW1lIjoid3NvMmFtLXBhdHRlcm4tMS1zdmMtYWNjb3VudCIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50LnVpZCI6Ijc3NmRmMjFkLTA3NjItNDM2Zi05ZDIwLTZlYzFkODMxYzc1NSIsInN1YiI6InN5c3RlbTpzZXJ2aWNlYWNjb3VudDp3c28yOndzbzJhbS1wYXR0ZXJuLTEtc3ZjLWFjY291bnQifQ.YwlSgnSnwS7BNP0q0iDHsjlq_r3RhobG-SrduuEi35VXNfipPsK3UVJcCBmDKQOzKAxRG9415h2pr3cS-QsM6PR_UU2UWlXiUO-3UtSMqVY48Ek_1wdfmfCkiE7IOeua_58CV15tXtMLom0Oh27nkmWGfTHVvImQnqho4nv26BKZH4vKWgkw0HpMt73KHdN6SlVMK0cynktO5H-2A4V2rh-uL-OUXCLON_sBypVoPc9PAMxHo-bUe0SqBPiM0SiALu-0-J6dBcwbzPb5g-yUZmHmtuw3O32C304Hgfr-4Dui3X5DSKBSeqlrjjjfrvMVNug0J4JKk3bJ56h0OgujFw"
    properties.Namespace = "default"
    ```
         
       Tenant users, can edit the cluster configurations included in `tenant-conf.json` file. Go to the carbon console and edit the tenant-conf.json file in `/_system/config/apimgt/applicationdata/` path.
       
    ``` json tab="Format"
    "ContainerMgt": [
      {
        "Type": "Kubernetes",
        "ContainerMgtInfo": [
        {
          "ClusterName": "",
          "DisplayName": "",
          "Properties": {
            "MasterURL": "",
            "AccessURL": "",
            "SAToken": "",
            "Namespace": "default",
            "Replicas": 1,
            "BasicSecurityCustomResourceName": "",
            "OauthSecurityCustomResourceName": "",
            "JWTSecurityCustomResourceName": ""
            }
          }
        ]
      }
    ]
    ```
    
    ``` json tab="Example"
    "ContainerMgt": [
      {
        "Type": "Kubernetes",
        "ContainerMgtInfo": [
         {
           "ClusterName": "docker-desktop",
           "DisplayName": "cluster-1",
           "Properties": {
           "MasterURL": "https://kubernetes.docker.internal:6443",
           "AccessURL": "mgw.ingress.wso2.com",
           "SAToken": "eyJhbGciOiJSUzI1NiIsImtpZCI6Ijg2UlYySEFkaVBOVG4zZ3FhWERXQUxQVUQ0bjlzOXE3dFhpbUZNZlFiRjQifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJ3c28yIiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZWNyZXQubmFtZSI6IndzbzJhbS1wYXR0ZXJuLTEtc3ZjLWFjY291bnQtdG9rZW4tZGR0OTkiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC5uYW1lIjoid3NvMmFtLXBhdHRlcm4tMS1zdmMtYWNjb3VudCIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50LnVpZCI6Ijc3NmRmMjFkLTA3NjItNDM2Zi05ZDIwLTZlYzFkODMxYzc1NSIsInN1YiI6InN5c3RlbTpzZXJ2aWNlYWNjb3VudDp3c28yOndzbzJhbS1wYXR0ZXJuLTEtc3ZjLWFjY291bnQifQ.YwlSgnSnwS7BNP0q0iDHsjlq_r3RhobG-SrduuEi35VXNfipPsK3UVJcCBmDKQOzKAxRG9415h2pr3cS-QsM6PR_UU2UWlXiUO-3UtSMqVY48Ek_1wdfmfCkiE7IOeua_58CV15tXtMLom0Oh27nkmWGfTHVvImQnqho4nv26BKZH4vKWgkw0HpMt73KHdN6SlVMK0cynktO5H-2A4V2rh-uL-OUXCLON_sBypVoPc9PAMxHo-bUe0SqBPiM0SiALu-0-J6dBcwbzPb5g-yUZmHmtuw3O32C304Hgfr-4Dui3X5DSKBSeqlrjjjfrvMVNug0J4JKk3bJ56h0OgujFw",
           "Namespace": "default",
           "Replicas": 1,
           "BasicSecurityCustomResourceName": "",
           "OauthSecurityCustomResourceName": "",
           "JWTSecurityCustomResourceName": ""
            }
          }
        ]
      }
    ]
    ```
 
     <html><div class="admonition note">
        <p class="admonition-title">Note</p>
        <p> Super tenant users can customize the container management implementations if required. Then customize classes should be added to the `<API-M_HOME>/repository/conf/deployment.toml` file as follows. </p>   
        
    ``` json tab="Format"
    [ContainerMgtConfig]
    <Environment-type> = "<class-name>"
    ```  
   
    ``` json tab="Example"
    [ContainerMgtConfig]
    Kubernetes = "org.wso2.carbon.apimgt.impl.containermgt.K8sManager_CustomClass"
    ```
  
      </div>
      </html>
         
6. Start the server and create an API in publisher
    
    After setting up configurations go to the <API-M-HOME>/bin directory and start the server. Then Sign in to the WSO2 API Publisher and create
   a new API.
    
7. Select the clusters from envioranment tab

    Navigate to the environment page and select the clusters to deploy the API.
    
     ![Environments]({{base_path}}/assets/img/learn/privatejet-mode/environment.png)
    
8. Go to lifecycle tab and publish the API

    Navigate to the lifecycle page and publish the API. This will expose microservices as managed APIs in selected clusters.
    
     ![API LifeCycle]({{base_path}}/assets/img/learn/privatejet-mode/lifecycle_publish.png)
     
9. Go to the devportal overview page and get the accessURL to access the deployed API
   
    To obtain the accessURL configured, Sign in to the WSO2 Developer Portal overview page. The accessURL can be seen under Gateway Environments.
   
    ![Developer portal - Overview]({{base_path}}/assets/img/learn/privatejet-mode/devportal.png)
   
10. Invoking the API
    
    i. Sign in to the WSO2 Developer Portal. Subscribe to the API and obtain an access token required to invoke the API or can use the following sample token.
    
        TOKEN=eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsIng1dCI6Ik5UZG1aak00WkRrM05qWTBZemM1TW1abU9EZ3dNVEUzTVdZd05ERTVNV1JsWkRnNE56YzRaQT09In0.eyJhdWQiOiJodHRwOlwvXC9vcmcud3NvMi5hcGltZ3RcL2dhdGV3YXkiLCJzdWIiOiJhZG1pbkBjYXJib24uc3VwZXIiLCJhcHBsaWNhdGlvbiI6eyJvd25lciI6ImFkbWluIiwidGllciI6IjEwUGVyTWluIiwibmFtZSI6InNhbXBsZS1jcmQtYXBwbGljYXRpb24iLCJpZCI6NCwidXVpZCI6bnVsbH0sInNjb3BlIjoiYW1fYXBwbGljYXRpb25fc2NvcGUgZGVmYXVsdCIsImlzcyI6Imh0dHBzOlwvXC93c28yYXBpbTozMjAwMVwvb2F1dGgyXC90b2tlbiIsInRpZXJJbmZvIjp7fSwia2V5dHlwZSI6IlBST0RVQ1RJT04iLCJzdWJzY3JpYmVkQVBJcyI6W10sImNvbnN1bWVyS2V5IjoieF8xal83MW11dXZCb01SRjFLZnVLdThNOVVRYSIsImV4cCI6MzczMTQ5Mjg2MSwiaWF0IjoxNTg0MDA5MjE0LCJqdGkiOiJkYTA5Mjg2Yy03OGEzLTQ4YjgtYmFiNy1hYWZiYzhiMTUxNTQifQ.MKmGDwh855NrZ2wOvXO7TwFbCtsgsOFuoZW4DBVIbJ1KQ2F6TgTgBbtzBUvrYGPslEExMemhepfvvlYv8Gd6MMo3GVH4aO8AKyc8gHmeIQ8MQtXGn7u9N00ZW3_9JWaQkU-OYEDsLHvKKHzO0t2umaskSyCS2UkAS4wIT_szZ5sm-O-ez4nKGeJmESiV-1EchFjOhLpEH4p9wIj3MlKnZrIcJByRKK9ZGaHBqxwwYuJtMCDNa2wFAPMOh-45eabIUdo1KUO3gZLVcME93aza1t1jzL9mFsx0LGaXIxB7klrDuBCAdG9Yi3O7-3WUF74QaS2tmCxW36JhhOJ5DdacfQ
    
    ii. Go to the kubectl command line tool and get the ingress.
    
        kubectl get ingress
        
        Output:
        NAME                                 HOSTS                  ADDRESS     PORTS     AGE
        api-operator-ingress-test            mgw.ingress.wso2.com   localhost   80, 443   37h
        api-operator-ingress-pizzashackapi   mgw.ingress.wso2.com   localhost   80, 443   21h
        
    iii. Invoke the API using following curl command.
    
        curl -H "<host-name>" https://<ingress-IP>/<resource-path> -H "Authorization:Bearer $TOKEN" -k
        
        Example of PizzashakAPI :
        curl -H "Host:mgw.ingress.wso2.com”  https://localhost/pizzashack/1.0.0/menu -H "accept: application/json" -H "Authorization: Bearer $TOKEN"
        
        Output:
        [{"name":"BBQ Chicken Bacon","description":"Grilled white chicken, hickory-smoked bacon and fresh sliced onions in barbeque sauce","price":"18.99","icon":"/images/6.png"},{"name":"Chicken Parmesan","description":"Grilled chicken, fresh tomatoes, feta and mozzarella cheese","price":"15.99","icon":"/images/1.png"},{"name":"Chilly Chicken Cordon Bleu","description":"Spinash Alfredo sauce topped with grilled chicken, ham, onions and mozzarella","price":"23.99","icon":"/images/10.png"},{"name":"Double Bacon 6Cheese","description":"Hickory-smoked bacon, Julienne cut Canadian bacon, Parmesan, mozzarella, Romano, Asiago and and Fontina cheese","price":"27.99","icon":"/images/9.png"},{"name":"Garden Fresh","description":"Slices onions and green peppers, gourmet mushrooms, black olives and ripe Roma tomatoes","price":"12.99","icon":"/images/3.png"},{"name":"Grilled Chicken Club","description":"Grilled white chicken, hickory-smoked bacon and fresh sliced onions topped with Roma tomatoes","price":"23.99","icon":"/images/8.png"},{"name":"Hawaiian BBQ Chicken","description":"Grilled white chicken, hickory-smoked bacon, barbeque sauce topped with sweet pine-apple","price":"14.99","icon":"/images/7.png"},{"name":"Spicy Italian","description":"Pepperoni and a double portion of spicy Italian sausage","price":"11.99","icon":"/images/2.png"},{"name":"Spinach Alfredo","description":"Rich and creamy blend of spinach and garlic Parmesan with Alfredo sauce","price":"9.99","icon":"/images/5.png"},{"name":"Tuscan Six Cheese","description":"Six cheese blend of mozzarella, Parmesan, Romano, Asiago and Fontina","price":"21.99","icon":"/images/4.png"}]%

### Securing APIs deployed in privateJet mode

By default the APIs deployed in cloud clusters with k8s-api-operator are secured with JWT authentication. Hence the APIs deployed in privateJet mode are secured with JWT authentication.

WSO2 API offers JWT authentication, Oauth2 authentication and Basic authentication mechanisms to secure your API from unauthenticated access in cloud-native API management. 

In order to secure APIs with above mechanisms,

   1. Create the corresponding [security custom resources and secrets](https://github.com/wso2/k8s-api-operator/blob/v1.1.0/docs/HowToGuide/OverviewOfCrds/apply-security-to-api.md)
    
   2. Refer the names of the security custom resources in the configurations.

    For the super tenant users the cluster configurations should be added to the deployment.toml file in <API-M_HOME>/repository/conf path as follows.
        
    ``` json tab="Format"
    [[ContainerMgtClusterConfig]]
    type = "<cloud-environment-type>"
    clusterName = "<cluster-name>"
    displayName = "<cluster-name-to_display>"
    properties.Replicas = "<number-of-replicas>"
    properties.AccessURL = "<access-URL>"
    properties.MasterURL = "<Master-URL-of-clsuter>"
    properties.SAToken = "<serviceacccount-token>"
    properties.Namespace = "<namespcae>"
    properties.BasicSecurityCustomResourceName = "<basic-security-CR-name>"
    properties.OauthSecurityCustomResourceName = "<Oauth-security-CR-name>"
    properties.JWTSecurityCustomResourceName = "<JWT-security-CR-name>"
    ```
            
    ``` json tab="Example"
    [[ContainerMgtClusterConfig]]
    type = "Kubernetes"
    clusterName = "docker-desktop"
    displayName = "cluster-1"
    properties.Replicas = 1
    properties.AccessURL = "mgw.ingress.wso2.com"
    properties.MasterURL = "https://kubernetes.docker.internal:6443"
    properties.SAToken = "eyJhbGciOiJSUzI1NiIsImtpZCI6Ijg2UlYySEFkaVBOVG4zZ3FhWERXQUxQVUQ0bjlzOXE3dFhpbUZNZlFiRjQifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJ3c28yIiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZWNyZXQubmFtZSI6IndzbzJhbS1wYXR0ZXJuLTEtc3ZjLWFjY291bnQtdG9rZW4tZGR0OTkiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC5uYW1lIjoid3NvMmFtLXBhdHRlcm4tMS1zdmMtYWNjb3VudCIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50LnVpZCI6Ijc3NmRmMjFkLTA3NjItNDM2Zi05ZDIwLTZlYzFkODMxYzc1NSIsInN1YiI6InN5c3RlbTpzZXJ2aWNlYWNjb3VudDp3c28yOndzbzJhbS1wYXR0ZXJuLTEtc3ZjLWFjY291bnQifQ.YwlSgnSnwS7BNP0q0iDHsjlq_r3RhobG-SrduuEi35VXNfipPsK3UVJcCBmDKQOzKAxRG9415h2pr3cS-QsM6PR_UU2UWlXiUO-3UtSMqVY48Ek_1wdfmfCkiE7IOeua_58CV15tXtMLom0Oh27nkmWGfTHVvImQnqho4nv26BKZH4vKWgkw0HpMt73KHdN6SlVMK0cynktO5H-2A4V2rh-uL-OUXCLON_sBypVoPc9PAMxHo-bUe0SqBPiM0SiALu-0-J6dBcwbzPb5g-yUZmHmtuw3O32C304Hgfr-4Dui3X5DSKBSeqlrjjjfrvMVNug0J4JKk3bJ56h0OgujFw"
    properties.Namespace = "default"
    properties.BasicSecurityCustomResourceName = "securitybasic"
    properties.OauthSecurityCustomResourceName = "securityoauth"
    properties.JWTSecurityCustomResourceName = "securityjwt"
    ```

    For the tenant users the cluster configurations should be added to the `tenant-conf.json` file. Go to the carbon console and edit the tenant-conf.json file in `/_system/config/apimgt/applicationdata/` path.
      
    ``` json tab="Format"
    "ContainerMgt": [
      {
        "Type": "Kubernetes",
        "ContainerMgtInfo": [
        {
          "ClusterName": "",
          "DisplayName": "",
          "Properties": {
            "MasterURL": "",
            "AccessURL": "",
            "SAToken": "",
            "Namespace": "default",
            "Replicas": 1,
            "BasicSecurityCustomResourceName": "",
            "OauthSecurityCustomResourceName": "",
            "JWTSecurityCustomResourceName": ""
            }
          }
        ]
      }
    ]
    ```
    
    ``` json tab="Example"
    "ContainerMgt": [
      {
        "Type": "Kubernetes",
        "ContainerMgtInfo": [
         {
           "ClusterName": "docker-desktop",
           "DisplayName": "cluster-1",
           "Properties": {
           "MasterURL": "https://kubernetes.docker.internal:6443",
           "AccessURL": "mgw.ingress.wso2.com",
           "SAToken": "eyJhbGciOiJSUzI1NiIsImtpZCI6Ijg2UlYySEFkaVBOVG4zZ3FhWERXQUxQVUQ0bjlzOXE3dFhpbUZNZlFiRjQifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJ3c28yIiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZWNyZXQubmFtZSI6IndzbzJhbS1wYXR0ZXJuLTEtc3ZjLWFjY291bnQtdG9rZW4tZGR0OTkiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC5uYW1lIjoid3NvMmFtLXBhdHRlcm4tMS1zdmMtYWNjb3VudCIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50LnVpZCI6Ijc3NmRmMjFkLTA3NjItNDM2Zi05ZDIwLTZlYzFkODMxYzc1NSIsInN1YiI6InN5c3RlbTpzZXJ2aWNlYWNjb3VudDp3c28yOndzbzJhbS1wYXR0ZXJuLTEtc3ZjLWFjY291bnQifQ.YwlSgnSnwS7BNP0q0iDHsjlq_r3RhobG-SrduuEi35VXNfipPsK3UVJcCBmDKQOzKAxRG9415h2pr3cS-QsM6PR_UU2UWlXiUO-3UtSMqVY48Ek_1wdfmfCkiE7IOeua_58CV15tXtMLom0Oh27nkmWGfTHVvImQnqho4nv26BKZH4vKWgkw0HpMt73KHdN6SlVMK0cynktO5H-2A4V2rh-uL-OUXCLON_sBypVoPc9PAMxHo-bUe0SqBPiM0SiALu-0-J6dBcwbzPb5g-yUZmHmtuw3O32C304Hgfr-4Dui3X5DSKBSeqlrjjjfrvMVNug0J4JKk3bJ56h0OgujFw",
           "Namespace": "default",
           "Replicas": 1,
           "BasicSecurityCustomResourceName": "",
           "OauthSecurityCustomResourceName": "",
           "JWTSecurityCustomResourceName": ""
            }
          }
        ]
      }
    ]
    ```

    <html><div class="admonition note">
      <p class="admonition-title">Note</p>
      <p>Configuring `BasicSecurityCustomResourceName`, `OauthSecurityCustomResourceName` and `JWTSecurityCustomResourceName` are only required when applying security for APIs. </p>
      </div>
    </html>