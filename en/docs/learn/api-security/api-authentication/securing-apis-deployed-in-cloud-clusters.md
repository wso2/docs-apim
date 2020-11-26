# Securing APIs deployed in cloud clusters

By default the APIs deployed in cloud clusters with k8s-api-operator are secured with JWT authentication. Hence the APIs deployed in privateJet mode are secured with JWT authentication.

WSO2 API-Manager offers [authentication mechanisms](https://github.com/wso2/k8s-api-operator/blob/v1.2.0-alpha/docs/HowToGuide/OverviewOfCrds/apply-security-to-api.md) to secure APIs from unauthenticated access in cloud-native API management. JWT authentication, Oauth2 authentication and Basic authentication are the mechanisms provided to secure APIs.

!!! info

In order to secure APIs with above mechanisms follow the steps below.
 
   1. Create the security custom resources and secrets for the selected authentication mechanism(s). 
       Follow the steps in the document [Applying security for APIs](https://github.com/wso2/k8s-api-operator/blob/v1.2.0-alpha/docs/HowToGuide/OverviewOfCrds/apply-security-to-api.md) and create the security custom resources and secrets.
    
   2. Refer the names of the security custom resources created in step 1, in the deployment.toml configuration file as follows.

      For the **super tenant** users the cluster configurations should be added to the deployment.toml file in <API-M_HOME>/repository/conf path as follows.
        
    
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
    
     For the **tenant users** the cluster configurations should be added to the `tenant-conf.json` file. Go to the carbon console and edit the tenant-conf.json file in `/_system/config/apimgt/applicationdata/` path.
      
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
    
    !!! note 
         Configuring `BasicSecurityCustomResourceName`, `OauthSecurityCustomResourceName` and `JWTSecurityCustomResourceName` are only required when applying security for APIs.
  