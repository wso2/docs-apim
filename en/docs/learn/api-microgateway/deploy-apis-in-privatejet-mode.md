# PrivateJet mode for Microgateways
In an age where more and more applications are adopting the microservice architecture, it is obvious that container-orchestration systems such as Kubernetes have gained popularity due to the attractive functionalities they offer to simplify a number of complex management tasks.
Automating computer application deployment, scaling, and management are a few of such functionalities to name. WSO2 API Manager provides cloud-native API management, where a user is able to expose microservices as managed APIs in cloud environment such as Kubernetes. 
This could be done with the support of [WSO2-Kubernetes API Operator]({{base_path}}/learn/kubernetes-operators/k8s-api-operator.md). 

 ![Architecture]({{base_path}}/assets/img/learn/privatejet-mode/architecture.png)
 
Microservices will be exposed as managed APIs in cloud clusters in the PrivetJet mode. Here, each microservice wll have a dedicated [WSO2 API Microgateway](https://wso2.com/api-management/api-microgateway/). This will provide maximum security and guaranteed resource allocation for API execution. As depicted in the above diagram, When the APIs published via API-Manager in cloud environments,
deployment, scaling, and management tasks will handle by the [WSO2 -Kubernetes API Operator]({{base_path}}/learn/kubernetes-operators/k8s-api-operator.md) itself.

## Enabling PrivateJet mode

Follow the steps below to enable PrivateJet mode for Microgateways in API Manager to deploy APIs as managed APIs in cloud clusters. (Ex: Kubernetes)

1. Install and setup [Kubernetes API Operator]({{base_path}}/learn/kubernetes-operators/k8s-api-operator.md). 
2. Follow the prerequisites given below in order to expose APIs using ingress controller.  Go to the README guide of [Expose an API using Ingress](https://github.com/wso2/k8s-api-operator/tree/v1.2.0-alpha/scenarios/scenario-17) for scenarios. 

    **Prerequisites:**
    
    i. First install the [Nginx-ingress controller](https://kubernetes.github.io/ingress-nginx/deploy/)
    
    ii. Navigate to the `api-operator/controller-artifacts` directory and set the operatorMode to `ingress` in the **controler_conf.yaml** file.
        
        operatorMode: "ingress"
        
    iii. If you have already deployed the operator you have to update operatorMode to `ingress` and apply the changes using following command.
    
        apictl apply -f api-operator/controller-artifacts/controler_conf.yaml
        
2. Deploying cluster configurations
 
    Processes in containers inside pods are authenticated when contacting the apiserver and accessing resources. In order to regulate access to the resources need to establish the RBAC Authorization with at least permissions to, 
    Create, Delete, Update, Get , List, Post the customresourcedefinitions, apis and configmaps.
    
    For that we need to create an service account containing an authentication token. ClusterRole which define permissions on cluster-scoped resources can then be bound to this ServiceAccount with a ClusterRoleBinding, so the ServiceAccount is authorized to perform those actions. 
    
    Follow the steps below to regulate access to the resources in the cluster.

    i.  Create a service account
    
    ``` json tab="Format"
    kubectl create serviceaccount <service-account name> -n <namespace>
    ```  
   
    ``` json tab="Example"
    kubectl create serviceaccount wso2am-privatejet
    ```
   
    ii. Create a clusterRole

        cat <<EOF | kubectl apply -f -
        apiVersion: rbac.authorization.k8s.io/v1
        kind: ClusterRole
        metadata:
          name: clusterrole-privatejet
        rules:
        - apiGroups: ["","apiextensions.k8s.io","wso2.com"]
          resources: ["configmaps","customresourcedefinitions","apis"]
          verbs: ["get", "post", "create", "delete", "put", "list","update"]
        EOF
     
    iii. Create a  clusterRoleBinding

        cat <<EOF | kubectl apply -f -
        apiVersion: rbac.authorization.k8s.io/v1
        kind: ClusterRoleBinding
        metadata:
         name: clusterrolebinding-privatejet
        subjects:
        - kind: ServiceAccount
          name: wso2sa # Name is case sensitive
          apiGroup: ""
          namespace: default
        roleRef:
          kind: ClusterRole
          name: clusterrole-privatejet
          apiGroup: rbac.authorization.k8s.io
        EOF
                                                                                                                   
    iv. Obtaining service account token

    First you need to get the secret name for your service account. This can be done by executing,
    
    ``` json tab="Format"
    kubectl get secrets -n <serviceaccount-namespace>
    ```  
   
    ``` json tab="Example"
    kubectl get secrets 
    ```
     
    Then, get the service account token by executing the following command,
    
    ``` json tab="Format"
    kubectl describe secret <secret-name> -n <serviceaccount-namespace> 
    ```  
   
    ``` json tab="Example"
    kubectl describe secret wso2am-privatejet-token-rsf7q
    ```

    v. Obtaining the master URL

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
      <p>If the API-Manager deployed in a kubernetes cluster Master URL and ServiceAccount token are not required to configure. </p>
      </div>
    </html>
    
3. Configuring the cluster details.

    The cluster configurations carried out in the above step, should be added in the `<API-M_HOME>/repository/conf/deployment.toml` file or in the `tenant-conf.json` file respect to the user.

    For the super tenant users the cluster configurations should be added in the `<API-M_HOME>/repository/conf/deployment.toml` file as follows.
    
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
    properties.AccessURL = "https://internal.wso2.com"
    properties.MasterURL = "https://kubernetes.docker.internal:6443"
    properties.SAToken = "eyJhbGciOiJSUzI1NiIsImtpZCI6Ijg2UlYySEFkaVBOVG4zZ3FhWERXQUxQVUQ0bjlzOXE3dFhpbUZNZlFiRjQifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJ3c28yIiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZWNyZXQubmFtZSI6IndzbzJhbS1wYXR0ZXJuLTEtc3ZjLWFjY291bnQtdG9rZW4tZGR0OTkiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC5uYW1lIjoid3NvMmFtLXBhdHRlcm4tMS1zdmMtYWNjb3VudCIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50LnVpZCI6Ijc3NmRmMjFkLTA3NjItNDM2Zi05ZDIwLTZlYzFkODMxYzc1NSIsInN1YiI6InN5c3RlbTpzZXJ2aWNlYWNjb3VudDp3c28yOndzbzJhbS1wYXR0ZXJuLTEtc3ZjLWFjY291bnQifQ.YwlSgnSnwS7BNP0q0iDHsjlq_r3RhobG-SrduuEi35VXNfipPsK3UVJcCBmDKQOzKAxRG9415h2pr3cS-QsM6PR_UU2UWlXiUO-3UtSMqVY48Ek_1wdfmfCkiE7IOeua_58CV15tXtMLom0Oh27nkmWGfTHVvImQnqho4nv26BKZH4vKWgkw0HpMt73KHdN6SlVMK0cynktO5H-2A4V2rh-uL-OUXCLON_sBypVoPc9PAMxHo-bUe0SqBPiM0SiALu-0-J6dBcwbzPb5g-yUZmHmtuw3O32C304Hgfr-4Dui3X5DSKBSeqlrjjjfrvMVNug0J4JKk3bJ56h0OgujFw"
    properties.Namespace = "default"
    ```
         
       Tenant users, can edit the cluster configurations in `tenant-conf.json` file. Log in to the Management Console ( `https://<hostname>:9443/carbon` ) and edit the tenant-conf.json file in `/_system/config/apimgt/applicationdata/` path.
       
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
            "Replicas": 1
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
           "AccessURL": "https://internal.wso2.com",
           "SAToken": "eyJhbGciOiJSUzI1NiIsImtpZCI6Ijg2UlYySEFkaVBOVG4zZ3FhWERXQUxQVUQ0bjlzOXE3dFhpbUZNZlFiRjQifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJ3c28yIiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZWNyZXQubmFtZSI6IndzbzJhbS1wYXR0ZXJuLTEtc3ZjLWFjY291bnQtdG9rZW4tZGR0OTkiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC5uYW1lIjoid3NvMmFtLXBhdHRlcm4tMS1zdmMtYWNjb3VudCIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50LnVpZCI6Ijc3NmRmMjFkLTA3NjItNDM2Zi05ZDIwLTZlYzFkODMxYzc1NSIsInN1YiI6InN5c3RlbTpzZXJ2aWNlYWNjb3VudDp3c28yOndzbzJhbS1wYXR0ZXJuLTEtc3ZjLWFjY291bnQifQ.YwlSgnSnwS7BNP0q0iDHsjlq_r3RhobG-SrduuEi35VXNfipPsK3UVJcCBmDKQOzKAxRG9415h2pr3cS-QsM6PR_UU2UWlXiUO-3UtSMqVY48Ek_1wdfmfCkiE7IOeua_58CV15tXtMLom0Oh27nkmWGfTHVvImQnqho4nv26BKZH4vKWgkw0HpMt73KHdN6SlVMK0cynktO5H-2A4V2rh-uL-OUXCLON_sBypVoPc9PAMxHo-bUe0SqBPiM0SiALu-0-J6dBcwbzPb5g-yUZmHmtuw3O32C304Hgfr-4Dui3X5DSKBSeqlrjjjfrvMVNug0J4JKk3bJ56h0OgujFw",
           "Namespace": "default",
           "Replicas": 1
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
         
4. Start the server and create an API in publisher
    
    After setting up configurations go to the <API-M-HOME>/bin directory and start the server. Then Sign in to the WSO2 API Publisher and [create a new API]({{base_path}}/learn/design-api/create-api/create-a-rest-api.md).
    
5. Select the clusters from environment tab

    Navigate to the environment tab by clicking on the `Environments` in the navigation bar, and select the clusters to deploy the API.
    
     ![Environments]({{base_path}}/assets/img/learn/privatejet-mode/environment.png)
    
6. Go to lifecycle tab by clicking on the `Lifecycle` in the navigation bar, and publish the API.

    Navigate to the lifecycle tab and publish the API. This will expose microservices as managed APIs in selected clusters.
    
     ![API LifeCycle]({{base_path}}/assets/img/learn/privatejet-mode/lifecycle_publish.png)
     
7. Go to the Developer Portal ( `https://<hostname>:9443/carbon` ) or click **View in Dev Portal** in the API Publisher and navigate to the Overview tab by clicking on the `Overview` in the navigation bar, and get the accessURL to access the deployed API Log in to the Management Console 
   
    To obtain the accessURL configured, Sign in to the WSO2 Developer Portal overview page. The accessURL can be seen under Gateway Environments.
   
    ![Developer portal - Overview]({{base_path}}/assets/img/learn/privatejet-mode/devportal.png)
   
8. Invoking the API
    
    i. Sign in to the Developer Portal ( `https://<hostname>:9443/carbon` ). Subscribe to the API and obtain an access token required to invoke the API.
    
    ii. Click **Try Out** to navigate to the API Console.
    
    iii. Select the gateway as configured container management cluster.
    
    ![Developer portal - Try Out gateway selection]({{base_path}}/assets/img/learn/privatejet-mode/tryout-console-gateway-selection.png)
    
    iv. Expand any method and click **Try it out**.
    
     [![Tryout click]({{base_path}}/assets/img/learn/create-api-prototype-tryout-click.png)]({{base_path}}/assets/img/learn/create-api-prototype-tryout-click.png)

    v. Enter the value for the parameter and click **Execute** to invoke the API.
   
      ![Developer portal - Try Out Execute for petid1]({{base_path}}/assets/img/learn/privatejet-mode/tryout-Execute.png)
     
       The response payload :
                
      ![Developer portal - Try Out Response for petid1]({{base_path}}/assets/img/learn/privatejet-mode/tryout-response.png)
        
### Securing APIs deployed in privateJet mode

By default the APIs deployed in cloud clusters with k8s-api-operator are secured with JWT authentication. Hence the APIs deployed in privateJet mode are secured with JWT authentication.

WSO2 API-Manager offers [authentication mechanisms](https://github.com/wso2/k8s-api-operator/blob/v1.2.0-alpha/docs/HowToGuide/OverviewOfCrds/apply-security-to-api.md) to secure APIs from unauthenticated access in cloud-native API management. JWT authentication, Oauth2 authentication and Basic authentication are the mechanisms provided to secure APIs.

In order to secure APIs with above mechanisms,

   1. First need to create the security custom resources and secrets for the selected authentication mechanisms. Follow the steps in the document [Applying security for APIs](https://github.com/wso2/k8s-api-operator/blob/v1.2.0-alpha/docs/HowToGuide/OverviewOfCrds/apply-security-to-api.md) and create the security custom resources and secrets.
    
   2. Refer the names of the security custom resources created in step 1, in the configurations as follows.

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
    properties.AccessURL = "https://internal.wso2.com"
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
           "AccessURL": "https://internal.wso2.com",
           "SAToken": "eyJhbGciOiJSUzI1NiIsImtpZCI6Ijg2UlYySEFkaVBOVG4zZ3FhWERXQUxQVUQ0bjlzOXE3dFhpbUZNZlFiRjQifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJ3c28yIiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZWNyZXQubmFtZSI6IndzbzJhbS1wYXR0ZXJuLTEtc3ZjLWFjY291bnQtdG9rZW4tZGR0OTkiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC5uYW1lIjoid3NvMmFtLXBhdHRlcm4tMS1zdmMtYWNjb3VudCIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50LnVpZCI6Ijc3NmRmMjFkLTA3NjItNDM2Zi05ZDIwLTZlYzFkODMxYzc1NSIsInN1YiI6InN5c3RlbTpzZXJ2aWNlYWNjb3VudDp3c28yOndzbzJhbS1wYXR0ZXJuLTEtc3ZjLWFjY291bnQifQ.YwlSgnSnwS7BNP0q0iDHsjlq_r3RhobG-SrduuEi35VXNfipPsK3UVJcCBmDKQOzKAxRG9415h2pr3cS-QsM6PR_UU2UWlXiUO-3UtSMqVY48Ek_1wdfmfCkiE7IOeua_58CV15tXtMLom0Oh27nkmWGfTHVvImQnqho4nv26BKZH4vKWgkw0HpMt73KHdN6SlVMK0cynktO5H-2A4V2rh-uL-OUXCLON_sBypVoPc9PAMxHo-bUe0SqBPiM0SiALu-0-J6dBcwbzPb5g-yUZmHmtuw3O32C304Hgfr-4Dui3X5DSKBSeqlrjjjfrvMVNug0J4JKk3bJ56h0OgujFw",
           "Namespace": "default",
           "Replicas": 1,
           "BasicSecurityCustomResourceName": "securitybasic",
           "OauthSecurityCustomResourceName": "securityoauth",
           "JWTSecurityCustomResourceName": "securityjwt"
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