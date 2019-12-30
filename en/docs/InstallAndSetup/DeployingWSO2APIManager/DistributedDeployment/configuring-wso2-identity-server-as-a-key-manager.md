# Configuring WSO2 Identity Server as a Key Manager

Please follow below steps to configure the prepackaged WSO2 Identity Server as the Key Manager of WSO2 API Manager deployment. 

!!! warning
    Before you begin check the product compatibility for [WSO2 IS as Key Manager]({{base_path}}/InstallAndSetup/ProductCompatibility/#compatible-wso2-identity-server-as-the-key-managers).

-   [Step 1 - Download WSO2 IS as a Key Manager (WSO2 IS-KM)](#ConfiguringWSO2IdentityServerasaKeyManager-Step1-DownloadWSO2ISasaKeyManager(WSO2IS-KM))
-   [Step 2 - Optionally, configure port offset for WSO2 IS](#ConfiguringWSO2IdentityServerasaKeyManager-Step2-Optionally,configureportoffsetforWSO2IS)
-   [Step 3 - Install and configure the databases](#ConfiguringWSO2IdentityServerasaKeyManager-Step3-Installandconfigurethedatabases)
-   [Step 4 - Configure the Key Manager (WSO2 IS) with WSO2 API-M](#ConfiguringWSO2IdentityServerasaKeyManager-Step4-ConfiguretheKeyManager(WSO2IS)withWSO2API-M)
-   [Step 5 - Configure WSO2 API-M with the Key Manager (WSO2 IS)](#ConfiguringWSO2IdentityServerasaKeyManager-Step5-ConfigureWSO2API-MwiththeKeyManager(WSO2IS))
-   [Step 6 - Optionally, configure High Availability (HA) for the Key Manager](#ConfiguringWSO2IdentityServerasaKeyManager-Step6-Optionally,configureHighAvailability(HA)fortheKeyManager)
-   [Step 7 - Start the Key Manager(s)](#ConfiguringWSO2IdentityServerasaKeyManager-Step7-StarttheKeyManager(s))
-   [Step 8 - Configure the other API-M components](#ConfiguringWSO2IdentityServerasaKeyManager-Step8-ConfiguretheotherAPI-Mcomponents)

### Step 1 - Download Prepackaged WSO2 IS as a Key Manager (WSO2 IS-KM)

!!! Info
    What is referred to as the prepackaged WSO2 Identity Server as a Key Manager?

    The **prepackaged WSO2 Identity Server as a Key Manager 5.9.0** comes with the necessary configurations already installed in order to connect it with WSO2 API Manager, and is therefore different to the default version (vanilla pack) of WSO2 Identity Server 5.9.0. The prepackaged WSO2 Identity Server as a Key Manager 5.9.0 is compatible with WSO2 API Manager 3.0.0 and is available as  by [WUM](https://wso2.com/updates) .
    
Download the prepackaged WSO2 Identity Server from [here](https://wso2.com/api-management/install/key-manager/) or get the [wum updated distribution](https://wso2.com/updates) and unzip it. `<IS_KM_HOME>` will refer to the root folder of the unzipped WSO2 IS pack. It is assumed that you have already downloaded WSO2 API Manager. `<APIM_HOME>` will refer to the root folder of the unzipped WSO2 API-M pack.

### Step 2 - Optionally, configure port offset for WSO2 IS

!!! note
    This is only required if you are running both WSO2 API Manager and WSO2 Identity Server on the same Virtual Machine (VM). Please refer [Changing the Default Ports with Offset]({{base_path}}/Reference/Guides/changing-the-default-ports-with-offset/) for more information.

Open the `<IS_KM_HOME>/repository/conf/deployment.toml` file and change the offset to 1 by applying following config. This increments the product's default port by one.

``` yaml
[server]
offset = 1
```

### Step 3 - Install and configure the databases

You can create the required databases for the API-M deployment on a separate server and point to the databases from the respective nodes.

The following diagram depicts how the databases are shared between WSO2 IS and WSO2 API-M.

<a href="../../../../../assets/img/setup-and-install/is-as-km-dbs.png" ><img src="../../../../../assets/img/setup-and-install/is-as-km-dbs.png" alt="IS-AS-KM-DBS" title="IS-AS-KM-DBS" width="70%" /></a>

-   **WSO2AM_DB** - This database stores the identity data and API-related data and it includes OAuth tokens and keys. When serving key-validation requests, the Key Manager accesses the `WSO2AM_DB` , validates whether there are subscriptions made by the particular key. 

-   **WSO2SHARED_DB** - This database contains the registry and user management data. 

The steps to setup and configure the databases for WSO2 IS as the Key Manager node is given below.

1.  Open `<IS_KM_HOME>/repository/conf/deployment.toml` file and comment out the default config database configuration as given below.

    ```
    #[database.config]
    #type = "h2"
    #url ="jdbc:h2:./repository/database/WSO2SHARED_DB;DB_CLOSE_ON_EXIT=FALSE;MVCC=TRUE"
    #username = "wso2carbon"
    #password = "wso2carbon"
    ```
2. Install, setup and configure `WSO2AM_DB` and `WSO2_SHARED_DB` databases as illustrated in [Changing the Default Databases]({{base_path}}/InstallAndSetup/SettingUpDatabases/overview/#changing-the-default-databases). This particular guide provides you all the steps to install, setup (users, database tables and drivers) and configure the connection data in `<IS_KM_HOME>/repository/conf/deployment.toml`
 
    !!! warning
        If you have already created and setup databases(`WSO2AM_DB` and `WSO2_SHARED_DB`) for WSO2 API Manager, you only need configure the data source configurations, so that WSO2 IS, which acts as the Key Manager, can connect to the required databases. 
        
    Sample configuration which is required to be applied in `<IS_KM_HOME>/repository/conf/deployment.toml` for MySQL is given below. The same datasource configuration should be applied in `<APIM_HOME>/repository/conf/deployment.toml` as well.
  
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

### Step 4 - Configure the WSO2 IS as Key Manager with WSO2 API Manager

1.  Configure the Key Manager to setup communication with API Gateway Environments.

    !!!Info    
        When users and roles are removed via the Key Manager, the tokens issued for that particular users and roles should be invalidated. But if the corresponding user tokens are cached on the Gateway, these tokens will only get invalidated when the cache is timed out. Therefore, you need to enable communication between the Key Manager and Gateway/Gateways to immediately invalidate the tokens in such scenarios.
    
    For that, open `<IS_KM_HOME>/repository/conf/deployment.toml` file and configure the available [Gateway Environments]({{base_path}}/Learn/APIGateway/maintaining-separate-production-and-sandbox-gateways/#maintaining-separate-production-and-sandbox-gateways) as follows.
    
    - Single gateway environment
    
    ``` tab="Format"
    [[apim.gateway.environment]]
    name = "<Environment-Name>"
    type = "<Environment-Type>"
    description = "<Environment-Description>"
    service_url = "https://<gateway-server-host>:<gateway-server-port>/services/"
    username= "<admin-username>"
    password= "<admin-password>"
    ```
    
    ``` tab="Example"
    [[apim.gateway.environment]]
    name = "Production and Sandbox"
    type = "hybrid"
    description = "This is a hybrid gateway that handles both production and sandbox token traffic."
    service_url = "https://localhost:9443}/services/"
    username= "${admin.username}"
    password= "${admin.password}"
    ```   
    
    - Multiple gateway environments
    
    ``` tab="Format"
    [[apim.gateway.environment]]
    name = "<Environment-1-Name>"
    type = "<Environment-1-Type>"
    description = "<Environment-1-Description"
    service_url = "https://<gateway1-server-host>:<gateway1-server-port>/services/"
    username= "<admin-username>"
    password= "<admin-password>"
    
    [[apim.gateway.environment]]
    name = "<Environment-2-Name>"
    type = "<Environment-2-Type>"
    description = "<Environment-2-Description"
    service_url = "https://<gateway2-server-host>:<gateway2-server-port>/services/"
    username= "<admin-username>"
    password= "<admin-password>"
    
    ```
    
    ``` tab="Example"
    [[apim.gateway.environment]]
    name = "Production"
    type = "production"
    description = "This is the gateway that handles production token traffic."
    service_url = "https://localhost:9445/services/"
    username= "admin"
    password= "admin"

    [[apim.gateway.environment]]
    name = "Sandbox"
    type = "sandbox"
    description = "This is the gateway that handles sandbox token traffic."
    service_url = "https://localhost:9446/services/"
    username= "admin"
    password= "admin"
    ```  

2.  If you want to configure [JSON Web Token (JWT)](http://openid.net/specs/draft-jones-json-web-token-07.html#anchor3) in order to pass the end user attributes to backend, open the `<IS_KM_HOME>/repository/conf/deployment.toml` file in the WSO2 IS as KM node and add relevant config changes given in [Passing Enduser Attributes to the Backend Using JWT]({{base_path}}/Learn/APIGateway/PassingEndUserAttributesToTheBackend/passing-enduser-attributes-to-the-backend-using-jwt)

3.  If you wish to encrypt the OAuth2 Keys (access tokens, client secrets and authorization codes) follow the steps given in [Encrypting OAuth Keys]({{base_path}}/Learn/APISecurity/OAuth2DeepDive/encrypting-oauth-keys/) and apply relevant configurations in `<IS_KM_HOME>/repository/conf/deployment.toml` file to enable the feature.


### Step 5 - Configure WSO2 API-M with the WSO2 IS as Key Manager

1.  Configure the WSO2 API Manager nodes which acts as the API gateways to setup communication with IS as KM node/nodes. For that, open `<APIM_HOME>/repository/conf/deployment.toml` file of API Manager gateway nodes and apply following config pointing to Key Manager URL.

    ```toml
    [apim.key_manager]
    service_url = "https://<key-manager-host>:<key-manager-port>/services/"
    ```

    !!!Info
        - In here, **API Gateways** are referred to [All-in-One Deployment]({{base_path}}/InstallAndSetup/DeployingWSO2APIManager/SingleNode/all-in-one-deployment-overview) nodes and the Gateway nodes in a [Distributed Deployment]({{base_path}}/InstallAndSetup/DeployingWSO2APIManager/DistributedDeployment/understanding-the-distributed-deployment-of-wso2-api-m). Basically, the Gateway nodes should be aware of the Key Manager endpoints,which in this case is WSO2 Identity Server as Key Manager, in order to handover key validation and authorization tasks. 
        - If you are working with a **Single IS as Key Manager** node, you need to replace the `<key-manager-host>` in `service_url` config with the actual host of the WSO2 IS as KM or the host of the fronted load balancer.
        - If you are working with multiple IS as Key Manager in **High Availability(HA)** mode **active-activ** node setup, you need to replace the `<key-manager-host>` in `service_url` config with the host of the load balancer which is used to front the all key manager nodes.


2. Make sure to import the Key Manager's public certificate to WSO2 API-M's `client-truststore.jks` . For more information, see [Importing Certificates to TrustStore]({{base_path}}/Administer/ProductSecurity/General/UsingAsymmetricEncryption/admin-creating-new-keystores/#step-3-importing-certificates-to-the-truststore) .

3. By default, both API Manager and the WSO2 IS as Key Manager comes with JDBC User Store as the primary userstore. But if you wish to use any other type of user store(LDAP, Active Directory etc) in IS as Key Manager, that particular user store has to be configured in API Manager nodes as well. Please refer [Configuring Primary User Store]({{base_path}}/Administer/ProductAdministration/ManagingUsersAndRoles/ManagingUserStores/ConfigurePrimaryUserStore/configuring-the-primary-user-store/) and apply relevant configs to plug a new user store.


### Step 6 - Optionally, configure High Availability (HA) for the Key Manager

!!! warning
    These steps are **ONLY applicable** if you need to configure **HA for the Key Manager.**

1.  Make a copy of the active instance configured above and use this copy as the second Key Manager active instance.

2.  Configure a Load Balancer to front the two Key Manager nodes.

### Step 7 - Start the Key Manager(s)

Start WSO2 Identity Server for the changes to take effect. For more information, see [Running the Product](https://is.docs.wso2.com/en/5.9.0/setup/running-the-product/) in the WSO2 Identity Server documentation.

``` java
sh <IS_KM_HOME>/bin/wso2server.sh
```

!!! Troubleshooting

    - You may notice the following error messages when starting up the server. This occurs because some API Manager directories are not available in the Identity Server. These are not critical errors, so they can be ignored. Alternatively, you can create the listed directories in the Identity Server pack.

        ``` java
        ERROR {org.wso2.carbon.apimgt.impl.utils.APIUtil} - Custom sequence template location unavailable for custom sequence type in : repository/resources/customsequences/in 
        ERROR {org.wso2.carbon.apimgt.impl.utils.APIUtil} - Custom sequence template location unavailable for custom sequence type out : repository/resources/customsequences/out 
        ERROR {org.wso2.carbon.apimgt.impl.utils.APIUtil} - Custom sequence template location unavailable for custom sequence type fault : repository/resources/customsequences/fault
        ```
    
    - If you have configured the hostnames for WSO2 API Manager and WSO2 Identity Server in the server start up, you will see the following warning in the WSO2 API Manager backend logs.

        ``` java
        WARN {org.wso2.carbon.apimgt.gateway.throttling.util.BlockingConditionRetriever} -  Failed retrieving Blocking Conditions from remote endpoint: sun.security.validator.ValidatorException: PKIX path building failed: sun.security.provider.certpath.SunCertPathBuilderException: unable to find valid certification path to requested target. Retrying after 15 seconds... {org.wso2.carbon.apimgt.gateway.throttling.util.BlockingConditionRetriever}
        ```

        The reason for this is that the default certificates that come with WSO2 Servers are created for localhost. Therefore, when WSO2 API Manager boots up, it makes an HTTP call to a webapp that is in the Key Manager (throttle data at `KM_URL/throttle/data/v1/keyTemplates` ). Thereafter, WSO2 API Manager decides the URL of the Key Manager base on the URL that is configured in the `deployment.toml`, which is localhost.

        To overcome this issue, you need to create self-signed certificates for WSO2 API-M and WSO2 IS host names. Then [import the public certs]({{base_path}}/Administer/ProductSecurity/General/UsingAsymmetricEncryption/admin-creating-new-keystores/#step-3-importing-certificates-to-the-truststore) of WSO2 API-M to the `trust-store.jks` of WSO2 IS and vice versa. This should resolve the SSL handshake failure.

### Step 8 - Configure the other API-M components

Follow the instructions below to configure the other WSO2 API-M components, namely the Publisher, Store, Traffic Manager, and Gateway:

-   If you are working with a single WSO2 API-M instance, which has all the API-M components in one instance, and a separate Key Manager, then configure the steps mentioned in [Configuring a Single Node] .
-   If you are working with an Active-Active setup, which has two all-in-one instances of API-M, and a separate Key Manager in high availability (HA) mode, then configure the steps mentioned in \_Configuring an Active-Active Deployment .
-   If you are working with a distributed API-M setup, see \_Deploying WSO2 API-M in a Distributed Setup to configure the other API-M components.

