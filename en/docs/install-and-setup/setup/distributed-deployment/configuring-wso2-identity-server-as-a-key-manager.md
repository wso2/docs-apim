# Configuring WSO2 Identity Server as a Key Manager

Please follow the steps below to configure a prepackaged WSO2 Identity Server as  Key Manager for your WSO2 API Manager deployment. 

!!! Info
    What is referred to as the prepackaged WSO2 Identity Server as a Key Manager?

    The **prepackaged WSO2 Identity Server as a Key Manager 5.10.0** is pre-configured to connect with WSO2 API Manager out of the box. Therefore, it is different from the vanilla form of a WSO2 Identity Server 5.10.0 distribution. The prepackaged WSO2 Identity Server as a Key Manager 5.10.0 is compatible with WSO2 API Manager 3.1.0 and supports in-place updates via [WUM](https://wso2.com/updates).

!!! warning
    Before you begin check the product compatibility for [WSO2 IS as Key Manager]({{base_path}}/install-and-setup/ProductCompatibility/#compatible-wso2-identity-server-as-the-key-managers).

### Step 1 - Download the prepackaged WSO2 IS as a Key Manager (WSO2 IS-KM)

1. Download the prepackaged WSO2 IS-KM from [here](https://wso2.com/api-management/install/key-manager/) or get the [wum updated distribution](https://wso2.com/updates) and unzip it. `<IS_KM_HOME>` will refer to the root folder of the unzipped WSO2 IS-KM pack. 
2. If you have not downloaded WSO2 API Manager, you can download it from [here](https://wso2.com/api-management/#). `<APIM_HOME>` will refer to the root folder of the unzipped WSO2 API-M pack.

### Step 2 - Optionally, configure a port offset for WSO2 IS

!!! note
    This step is only required to be followed if you are running both WSO2 API Manager and WSO2 Identity Server on the same Virtual Machine (VM). Please refer [Changing the Default Ports with Offset]({{base_path}}/install-and-setup/deploying-wso2-api-manager/changing-the-default-ports-with-offset) for more information.
    
    This feature is available only as a **WUM** update and is effective from 20th April 2020 (2020-04-20).

1. Open the `<IS_KM_HOME>/repository/conf/deployment.toml` file.
2. Change the offset by 1 as shown in the following configuration. This increments the server's default port by one.

``` yaml
[server]
offset = 1
```

### Step 3 - Install and configure the databases

#### Step 3.1 Overview

You can create the required databases for the API-M deployment on a separate server and point to the databases from the respective nodes.

The following diagram depicts how the databases are shared between WSO2 IS-KM and WSO2 API-M.

<a href="{{base_path}}/assets/img/setup-and-install/is-as-km-dbs.png" ><img src="{{base_path}}/assets/img/setup-and-install/is-as-km-dbs.png" alt="IS-AS-KM-DBS" title="IS-AS-KM-DBS" width="70%" /></a>

-   **WSO2AM_DB** - This database stores the identity-related data, API related data as well as OAuth tokens and keys. When serving key-validation requests, the key manager accesses the `WSO2AM_DB` and validates whether there are subscriptions made by the particular key. 

-   **WSO2SHARED_DB** - This database contains the registry and user management data. 

#### Step 3.2 Setup and configure the databases for WSO2 IS-KM

Follow the steps below to set up and configure the databases for WSO2 IS-KM node.

1. Open `<IS_KM_HOME>/repository/conf/deployment.toml` file. Comment out the default database configuration as follows.

    ```
    #[database.config]
    #type = "h2"
    #url ="jdbc:h2:./repository/database/WSO2SHARED_DB;DB_CLOSE_ON_EXIT=FALSE;MVCC=TRUE"
    #username = "wso2carbon"
    #password = "wso2carbon"
    ```
    
2. Install, setup and configure `WSO2AM_DB` and `WSO2_SHARED_DB` databases as explained in [Changing the Default Databases]({{base_path}}/install-and-setup/setting-up-databases/overview/#changing-the-default-databases). This guide includes instructions on how to install the database, how to set up database users, create tables using relevant scripts, apply the drivers which are compatible with the database type, and how to set up the connection details in the `<IS_KM_HOME>/repository/conf/deployment.toml` file. 

    !!! warning
        If you have already created and set up databases(`WSO2AM_DB` and `WSO2_SHARED_DB`) for WSO2 API Manager, you will only need to configure the data source configurations in the WSO2 IS-KM node. This will allow the key manager node to connect to the required databases. 
        
 
    Find below a sample configuration of the connection details in the `<IS_KM_HOME>/repository/conf/deployment.toml`.
   
    ``` tab="Format"
     [database.apim_db]
     type = "mysql"
     url = "jdbc:mysql://<database-host>:3306/<WSO2AM_DB>"
     username = "<db_username>"
     password = "<db_password>"
     
     [database.shared_db]
     type = "mysql"
     url = "jdbc:mysql://<database-host>:3306/<WSO2_SHARED_DB>"
     username = "<db_username>"
     password = "<db_password>"
    ```
    
    ``` tab="Example"
     [database.apim_db]
     type = "mysql"
     url = "jdbc:mysql://localhost:3306/apim_db"
     username = "apimadmin"
     password = "apimadmin"
    
     [database.shared_db]
     type = "mysql"
     url = "jdbc:mysql://localhost:3306/shared_db"
     username = "regadmin"
     password = "regadmin"
    ```
   
3. Apply the data source configuration (`WSO2AM_DB` and `WSO2_SHARED_DB`) done above, to the `<APIM_HOME>/repository/conf/deployment.toml` of the API-M node as well.

### Step 4 - Optionally, configure cache invalidation for WSO2 IS-KM

!!! note
    This configuration is required only if it is needed to immediately invalidate the cache within the WSO2 IS-KM nodes via the Traffic manager.

Open the `<IS_KM_HOME>/repository/conf/deployment.toml` file and add following configuration.

``` toml
       [apim.cache_invalidation]
       enabled = true
       domain = "keymanager-domain"
```

### Step 5 - Configure the WSO2 IS-KM to connect to WSO2 API-M

#### Step 5.1 Configure the key manager (WSO2 IS-KM) to connect to the traffic manager

The following configuration should be applied to the key manager node(s). It allows the key manager to establish a connection with the traffic manager node(s) to immediately notify any access token revocations to the gateways via the traffic manager.
 
 Follow the steps below to configure the traffic manager endpoints. 
 
 1. Open the `<IS_KM_HOME>/repository/conf/deployment.toml` file.
 
 2. Configure the traffic manager endpoints as follows.
 
    !!! note
         - **If your deployment is an** [All-in-One Deployment]({{base_path}}/install-and-setup/deploying-wso2-api-manager/single-node/all-in-one-deployment-overview), the `traffic_manager_urls` and `traffic_manager_auth_urls` needs to point to the all in one node's data publishing endpoints (all in one node's IP or a DNS mapping). To do this, follow the steps below.
             -  Replace the `<traffic-manager-ip>` placeholder value with the all in one node's IP or a DNS mapping.
             -  Replace the `<binary-data-publishing-port>` and `<binary-data-publishing-authentication-port>` with the respective port (reflecting any port offsets). 
         -   **If your deployment is a** [Distributed Deployment]({{base_path}}/install-and-setup/deploying-wso2-api-manager/distributed-deployment/understanding-the-distributed-deployment-of-wso2-api-m) the `traffic_manager_urls` and `traffic_manager_auth_urls` should point to the traffic manager node's data publishing endpoints. To do this, follow the steps below. 
            - Replace the `<traffic-manager-ip>` placeholder value with the traffic manager node's IP or a DNS mapping.
            - Replace the `<binary-data-publishing-port>`and `<binary-data-publishing-authentication-port>` placeholder value with the respective port (reflecting any port offsets).
          
    ``` tab="Format"        
    [apim.throttling]
    enable_data_publishing = false
    enable_policy_deploy = false
    enable_blacklist_condition = false
    enable_decision_connection = false
    throttle_decision_endpoints = ["tcp://<traffic-manager-ip>:5672"]

    [[apim.throttling.url_group]]
    traffic_manager_urls=["tcp://<traffic-manager-ip>:<binary-data-publishing-port>"]
    traffic_manager_auth_urls=["ssl://<traffic-manager-ip>:<binary-data-publishing-authentication-port>"]
    ```
         
    ``` tab="Example"
    [apim.throttling]
    enable_data_publishing = false
    enable_policy_deploy = false
    enable_blacklist_condition = false
    enable_decision_connection = false
    throttle_decision_endpoints = ["tcp://tm.wso2.com:5672"]

    [[apim.throttling.url_group]]
    traffic_manager_urls=["tcp://tm.wso2.com:9611"]
    traffic_manager_auth_urls=["ssl://tm.wso2.com:9711"]
    ```
    
    If the traffic Manager deployment is a High Availability(HA) deployment, the endpoints of both nodes have to be configured as follows.
    
    ``` tab="Format"        
    [apim.throttling]
    enable_data_publishing = false
    enable_policy_deploy = false
    enable_blacklist_condition = false
    enable_decision_connection = false
    throttle_decision_endpoints = ["tcp://<traffic-manager-1-ip>:5672","tcp://<traffic-manager-2-ip>:5672"]

    [[apim.throttling.url_group]]
    traffic_manager_urls=["tcp://<traffic-manager-1-ip>:<binary-data-publishing-port>"]
    traffic_manager_auth_urls=["ssl://<traffic-manager-1-ip>:<binary-data-publishing-authentication-port>"]
    
    [[apim.throttling.url_group]]
    traffic_manager_urls=["tcp://<traffic-manager-2-ip>:<binary-data-publishing-port>"]
    traffic_manager_auth_urls=["ssl://<traffic-manager-2-ip>:<binary-data-publishing-authentication-port>"]
    ```
         
    ``` tab="Example"
    [apim.throttling]
    enable_data_publishing = false
    enable_policy_deploy = false
    enable_blacklist_condition = false
    enable_decision_connection = false
    throttle_decision_endpoints = ["tcp://tm1.wso2.com:5672","tcp://tm2.wso2.com:5672"]

    [[apim.throttling.url_group]]
    traffic_manager_urls=["tcp://tm1.wso2.com:9611"]
    traffic_manager_auth_urls=["ssl://tm1.wso2.com:9711"]
    
    [[apim.throttling.url_group]]
    traffic_manager_urls=["tcp://tm2.wso2.com:9611"]
    traffic_manager_auth_urls=["ssl://tm2.wso2.com:9711"]    
    ```
    
#### Step-5.2 Configure WSO2 IS to pass end-user attributes to the backend (JWT)
  
Follow the steps below to configure [JSON Web Token (JWT)](http://openid.net/specs/draft-jones-json-web-token-07.html#anchor3) to pass the end-user attributes to the backend.
 
 1. Open the `<IS_KM_HOME>/repository/conf/deployment.toml` file in the WSO2 IS as KM node.
 2. Follow the document [Passing Enduser Attributes to the Backend Using JWT]({{base_path}}/learn/api-gateway/passing-end-user-attributes-to-the-backend/passing-enduser-attributes-to-the-backend-using-jwt).

#### Step 5.3 Encrypting OAuth2 Keys (access tokens, client secrets, and authorization codes)

Follow the steps below to encrypt OAuth2 Keys (access tokens, client secrets, and authorization codes).

 1. Open the `<IS_KM_HOME>/repository/conf/deployment.toml` file in the WSO2 IS as KM node.
 2. Follow the steps given in [Encrypting OAuth Keys]({{base_path}}/learn/api-security/oauth2/encrypting-oauth2-tokens/#encrypting-oauth2-tokens/).


### Step 6 - Configure the WSO2 API-M Gateway to connect to WSO2 IS-KM 

!!! note
    In this document, the term **API Gateways** refers to  [All-in-One Deployment]({{base_path}}/install-and-setup/deploying-wso2-api-manager/single-node/all-in-one-deployment-overview) nodes or the Gateway nodes in a [Distributed Deployment]({{base_path}}/install-and-setup/deploying-wso2-api-manager/distributed-deployment/understanding-the-distributed-deployment-of-wso2-api-m).  

The WSO2 API-M Gateway nodes should be aware of the key manager (IS as KM) endpoints, to handover key validation and authorization tasks. 

Follow the steps below to configure the API gateway(s) (WSO2 API Manager nodes) to connect to the IS as KM(s). 

1. Open the `<APIM_HOME>/repository/conf/deployment.toml` file of API Manager gateway nodes.
2. Apply the following configuration by pointing to the key manager URL.

    ``` tab="Format"
    [apim.key_manager]
    service_url = "https://<key-manager-host>:<key-manager-port>/services/"
    ```

    ``` tab="Example"
    [apim.key_manager]
    service_url = "https://km.wso2.com:9444/services/"
    ```
    !!! note
        - If you have a **Single IS as Key Manager** deployment, you need to replace the `<key-manager-host>` found in the `service_url` config, with the actual host of the WSO2 IS as KM node or the host of the load balancer fronting the WSO2 IS as KM node.
        - If you have  **multiple IS as Key Managers in High Availability(HA)** mode, in an **active-active** node setup, you need to replace the `<key-manager-host>` in `service_url` config with the host of the load balancer which is used to front all of the key manager nodes.


2. Import the public certificate of WSO2 IS-KM, which is used to sign the tokens, to the WSO2 API-M truststore (`client-truststore.jks`) under the "gateway_certificate_alias" alias. For more information, see [Import the public certificate into the client trust store]({{base_path}}/learn/api-security/oauth2/access-token-types/jwt-tokens/#importing-the-public-certificate-into-the-client-trust-store).

3. By default, both API Manager and WSO2 IS-KM is configured to have the JDBC User Store as the primary user store. But if you wish to use any other type of user store (LDAP, Active Directory, etc.) in IS-KM, that user store has to be configured in the API Manager nodes as well. Refer to [Configuring Primary User Store]({{base_path}}/administer/product-administration/managing-users-and-roles/managing-user-stores/configure-primary-user-store/configuring-the-primary-user-store/) to configure a new user store.


### Step 7 - Optionally, configure High Availability (HA) for the Key Manager

!!! warning
    Follow the steps below **ONLY if you need to configure HA for the Key Manager.**

1.  Make a copy of the active WSO2 IS-KM instance configured above and use this copy as the second key manager active instance.

2.  Configure a load balancer to front the two key manager nodes.

### Step 8 - Start the Key Manager(s)

1. Use the command below to start the WSO2 IS as KM.  For more information, see [Running the Product](https://is.docs.wso2.com/en/5.10.0/setup/running-the-product/) in the WSO2 Identity Server documentation.

   -   [**Linux/Mac OS**](#Linux-Mac)
        ``` java
        cd <IS_KM_HOME>>/bin/
        sh wso2server.sh 
        ```
       
   -   [**Windows**](#windows)
        ``` java
        cd <IS_KM_HOME>>\bin\    
        wso2server.bat 
        ```

    !!! Troubleshooting
    
        If you have configured the hostnames for WSO2 API Manager and WSO2 Identity Server at server startup, you will see the following warning in the WSO2 API Manager backend logs.

        ``` java
            WARN {org.wso2.carbon.apimgt.gateway.throttling.util.BlockingConditionRetriever} -  Failed retrieving Blocking Conditions from remote endpoint: sun.security.validator.ValidatorException: PKIX path building failed: sun.security.provider.certpath.SunCertPathBuilderException: unable to find valid certification path to requested target. Retrying after 15 seconds... {org.wso2.carbon.apimgt.gateway.throttling.util.BlockingConditionRetriever}
        ```
        The reason for this is that the default certificates that come with WSO2 Servers are created for localhost. Therefore, when WSO2 API Manager boots up, it makes an HTTP call to a web app that is in the key manager (throttle data at `KM_URL/throttle/data/v1/keyTemplates` ). Thereafter, WSO2 API Manager derives the URL of the key manager that is configured in the `deployment.toml`, which is localhost.  
           
        To overcome this issue, follow the steps below.
        
          1. Create self-signed certificates for WSO2 API-M and WSO2 IS hostnames.
          2. [Import the public certs]({{base_path}}/administer/product-security/General/UsingAsymmetricEncryption/admin-creating-new-keystores/#step-3-importing-certificates-to-the-truststore) of WSO2 API-M to the `trust-store.jks` of WSO2 IS and vice versa. 
  
### Step 9 - Configure the other API-M components

Follow the instructions below to configure the other WSO2 API-M components, namely the Publisher, Developer Portal, Traffic Manager, and Gateway:

- All-in-One Deployment
    - [Configuring a Single Node]({{base_path}}/install-and-setup/deploying-wso2-api-manager/single-node/configuring-a-single-node/)
    - [Configuring an Active-Active Deployment]({{base_path}}/install-and-setup/deploying-wso2-api-manager/single-node/configuring-an-active-active-deployment/)
- [Distributed Deployment]({{base_path}}/install-and-setup/setup/distributed-deployment/deploying-wso2-api-m-in-a-distributed-setup/)
