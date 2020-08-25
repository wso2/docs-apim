# Configuring WSO2 Identity Server as a Key Manager

Please follow below steps to configure the WSO2 Identity Server as the Key Manager of WSO2 API Manager deployment globally.

- [Step 1 - Download Prepackaged WSO2 Identity Server ](#step-1---downloadprepackaged-wso2-is-as-a-key-manager-wso2-is-km)
- [Step 2 - Optionally, configure port offset for WSO2 IS](#step-2---optionally-configure-port-offset-for-wso2-is)
- [Step 3 - Install and configure the databases](#step-3---install-and-configure-the-databases)
- [Step 4 - Configure the WSO2 IS as Key Manager with WSO2 API Manager](#step-4---configure-the-wso2-is-as-key-manager-with-wso2-api-manager)
- [Step 5 - Configure WSO2 API-M with the WSO2 IS as Key Manager](#step-5---configure-wso2-api-m-with-the-wso2-is-as-key-manager)
- [Step 6 - Optionally, configure High Availability (HA) for the Key Manager](#step-6---optionallyconfigure-high-availability-ha-for-the-key-manager)
- [Step 7 - Start the Key Manager(s)](#step-7---start-the-key-managers)
- [Step 8 - Configure the other API-M components](#step-8---configure-the-other-api-m-components)

### Step 1 - Download and install the [latest WSO2 Identity Server](https://wso2.com/identity-and-access-management/#).

    If you downloaded the archive, extract it.
    `<IS_HOME>` refers to the root folder of the extracted WSO2 IS.

It is assumed that you have already downloaded WSO2 API Manager.
`<APIM_HOME>` will refer to the root folder of the unzipped WSO2 API-M pack.

### Step 2 - Optionally, configure port offset for WSO2 IS

!!! note
    This is only required if you are running both WSO2 API Manager and WSO2 Identity Server on the same Virtual Machine (VM). Please refer [Changing the Default Ports with Offset]({{base_path}}/install-and-setup/deploying-wso2-api-manager/changing-the-default-ports-with-offset) for more information.

Open the `<IS_HOME>/repository/conf/deployment.toml` file and change the offset to 1 by applying following config. This increments the product's default port by one.

``` yaml
[server]
offset = 1
```

### Step 3 - Install and configure the databases

You can create the required databases for the API-M deployment on a separate server and point to the databases from the respective nodes.

The following diagram depicts how the databases are shared between WSO2 IS and WSO2 API-M.

<a href="{{base_path}}/assets/img/setup-and-install/is-as-km-dbs.png" ><img src="{{base_path}}/assets/img/setup-and-install/is-as-km-dbs.png" alt="IS-AS-KM-DBS" title="IS-AS-KM-DBS" width="70%" /></a>

-   **WSO2SHARED_DB** - This database contains the registry and user management data. 

The steps to setup and configure the databases for WSO2 IS as the Key Manager node is given below.

1 . Install, setup, and configure `WSO2_SHARED_DB` databases as illustrated in [Changing the Default Databases]({{base_path}}/install-and-setup/setup/setting-up-databases/overview/). This particular guide provides you all the steps on how to install the database, how to setup database users, create tables using relevant scripts, apply the drivers which are compatible with the database type and how to configure the connection details in connection data in
`<IS_HOME>/repository/conf/deployment.toml` file.
This step is needed if a shared user store has to be used among the servers.
 
    !!! warning
        If you have already created and setup database(`WSO2_SHARED_DB`) for WSO2 API Manager, you only need configure the data source configurations in WSO2 IS node. Then it will connect with required databases and acts as the Key Manager.

Sample configuration which is required to be applied in `<IS_HOME>/repository/conf/deployment.toml` for MySQL is given below.
  
    ``` tab="Format"
     
     [database.shared_db]
     type = "mysql"
     url = "jdbc:mysql://<database-host>:3306/<WSO2_SHARED_DB>"
     username = "<db_username>"
     password = "<db_password>"
    ```
    
    ``` tab="Example"
    
     [database.shared_db]
     type = "mysql"
     url = "jdbc:mysql://localhost:3306/shared_db"
     username = "umadmin"
     password = "umadmin"
    ```
2. If multi tenancy is used, it is required to share the `WSO2AM_DB` with the Identity Server.
    Sample configuration which is required to be applied in `<IS_HOME>/repository/conf/deployment.toml` for MySQL is given below.

    ``` tab="Format"
     [database.identity_db]
     type = "mysql"
     url = "jdbc:mysql://<database-host>:3306/<WSO2AM_DB>?useSSL=false"
     username = "wso2carbon"
     password = "wso2carbon"
    ```

    ``` tab="Example"
     [database.identity_db]
     type = "mysql"
     url = "jdbc:mysql://localhost:3306/apim_db?useSSL=false"
     username = "wso2carbon"
     password = "wso2carbon"
    ```

3. Apply the same datasource configuration in above step for `WSO2_SHARED_DB` in `<APIM_HOME>/repository/conf/deployment.toml` as well. Additionally configure WSO2AM-DB in `<APIM_HOME>/repository/conf/deployment.toml

    ``` tab="Format"

     [database.apim_db]
     type = "mysql"
     url = "jdbc:mysql://<database-host>:3306/<WSO2AM_DB>"
     username = "<db_username>"
     password = "<db_password>"
    ```

    ``` tab="Example"

     [database.shared_db]
     type = "mysql"
     url = "jdbc:mysql://localhost:3306/apim_db"
     username = "amadmin"
     password = "amadmin"
    ```

    ### Step 4 - Configure the WSO2 IS with WSO2 API Manager

1. Download the [WSO2 IS Connector]({{base_path}}/assets/attachments/administer/wso2is-km-connector-1.0.15.zip).

2. Extract the distribution and copy the following JAR files to the `<IS_HOME>/repository/components/dropins` directory.

        - wso2is.key.manager.core-1.0.15

        - wso2is.notification.event.handlers_1.0.15

3. Add `keymanager-operations.war` to the `<IS_HOME>/repository/deployment/server/webapps` directory.


4.  Add following configuration to `<IS_HOME>/repository/conf/deployment.toml` file and configure the traffic manager endpoints as follows.

    ```
    [[event_listener]]
    id = "token_revocation"
    type = "org.wso2.carbon.identity.core.handler.AbstractIdentityHandler"
    name = "org.wso2.is.notification.ApimOauthEventInterceptor"
    order = 1

    [[resource.access_control]]
    context = "(.)/keymanager-operations/user-info/claims(.)"
    secure = true
    http_method = "GET"
    permissions = "/permission/admin/manage/identity/usermgt/list"
    scopes = "internal_user_mgt_list"

    [[resource.access_control]]
    context = "(.*)/keymanager-operations/user-info/claims/generate"
    secure = true
    http_method = "POST"
    permissions = "/permission/admin/manage/identity/usermgt/list"
    scopes = "internal_user_mgt_list"

    [[resource.access_control]]
    context = "(.*)/keymanager-operations/dcr/register"
    secure = true
    http_method = "POST"
    permissions = "/permission/admin/manage/identity/applicationmgt/create"
    scopes = "internal_application_mgt_create"

    [[resource.access_control]]
    context = "(.*)/keymanager-operations/dcr/register(.*)"
    secure = true
    http_method = "GET"
    permissions = "/permission/admin/manage/identity/applicationmgt/view"
    scopes = "internal_application_mgt_view"

    [[resource.access_control]]
    context = "(.*)/keymanager-operations/dcr/register(.*)"
    secure = true
    http_method = "DELETE"
    permissions = "/permission/admin/manage/identity/applicationmgt/delete"
    scopes = "internal_application_mgt_delete"


    [tenant_context.rewrite]
    custom_webapps = ["/keymanager-operations/"]
    ```

Configure event listener endpoint to publish controller events to traffic manager.

    ``` tab="Format"

    [event_listener.properties]
    notification_endpoint = "https://<traffic-manager-host>:<traffic-manager-https-port>/internal/data/v1/notify"
    username = "${admin.username}"
    password = "${admin.password}"
    'header.X-WSO2-KEY-MANAGER' = "WSO2IS"
    ```

    ``` tab="Example"

    [event_listener.properties]
    notification_endpoint = "https://<tm.wso2.com>:9443/internal/data/v1/notify"
    username = "${admin.username}"
    password = "${admin.password}"
    'header.X-WSO2-KEY-MANAGER' = "WSO2IS"
    ```

Configure throttling url groups as below.

    ``` tab="Format"
    [[apim.throttling.url_group]]
    traffic_manager_urls=["tcp://<traffic-manager-ip>:<binary-data-publishing-port>"]
    traffic_manager_auth_urls=["ssl://<traffic-manager-ip>:<binary-data-publishing-authentication-port>"]
    ```
         
    ``` tab="Example"
    [[apim.throttling.url_group]]
    traffic_manager_urls=["tcp://tm.wso2.com:9611"]
    traffic_manager_auth_urls=["ssl://tm.wso2.com:9711"]
    ```
    
If the traffic Manager deployment with High Availability(HA), the endpoints of both nodes has to be configured as follows.
    
    ``` tab="Format"        
    [[apim.throttling.url_group]]
    traffic_manager_urls=["tcp://<traffic-manager-1-ip>:<binary-data-publishing-port>"]
    traffic_manager_auth_urls=["ssl://<traffic-manager-1-ip>:<binary-data-publishing-authentication-port>"]
    
    [[apim.throttling.url_group]]
    traffic_manager_urls=["tcp://<traffic-manager-2-ip>:<binary-data-publishing-port>"]
    traffic_manager_auth_urls=["ssl://<traffic-manager-2-ip>:<binary-data-publishing-authentication-port>"]
    ```
         
    ``` tab="Example"
    [[apim.throttling.url_group]]
    traffic_manager_urls=["tcp://tm1.wso2.com:9611"]
    traffic_manager_auth_urls=["ssl://tm1.wso2.com:9711"]
    
    [[apim.throttling.url_group]]
    traffic_manager_urls=["tcp://tm2.wso2.com:9611"]
    traffic_manager_auth_urls=["ssl://tm2.wso2.com:9711"]    
    ```
    
    !!!Info
            
        -   This particular configuration should be applied in Key Manager nodes to establish the connection with traffic manager node/nodes in order to immediately notify the access token revocations to gateways through traffic manager. 
        -   If you are having an [All-in-One Deployment]({{base_path}}/install-and-setup/deploying-wso2-api-manager/single-node/all-in-one-deployment-overview), the `traffic_manager_urls` and `traffic_manager_auth_urls` has to be pointed to all in one node's data publishing endpoints(Replace the `<traffic-manager-ip>` placeholder with all in one node's IP or a DNS mapping and `<binary-data-publishing-port>`, `<binary-data-publishing-authentication-port>` with releavant ports with offset). 
        -   If you are working with a [Distributed Deployment]({{base_path}}/install-and-setup/deploying-wso2-api-manager/distributed-deployment/understanding-the-distributed-deployment-of-wso2-api-m) the `traffic_manager_urls` and `traffic_manager_auth_urls` should be pointed to traffic manager node's data publishing endpoints(Replace the `<traffic-manager-ip>` placeholder with traffic manager node's IP or a DNS mapping and `<binary-data-publishing-port>`, `<binary-data-publishing-authentication-port>` with releavant ports with offset).
        
4.  If you wish to encrypt the OAuth2 Keys (access tokens, client secrets and authorization codes) follow the steps given in [Encrypting OAuth Keys](https://is.docs.wso2.com/en/latest/learn/testing-oidc-encrypted-id-token-with-is/#enable-id-token-encryption) and apply relevant configurations in `Identity Server` file to enable the feature.


### Step 5 - Configure WSO2 API-M with the WSO2 IS.

1.  Import the Identity Server's public certificate to WSO2 API-M's truststore.

     Import the public certificate of WSO2 IS, which is used to sign the tokens, to the WSO2 API-M truststore (`client-truststore.jks`) under the "gateway_certificate_alias" alias.
     
     For more information, see [Import the public certificate into the client trust store]({{base_path}}/learn/api-security/oauth2/access-token-types/jwt-tokens/#importing-the-public-certificate-into-the-client-trust-store).

2. By default, both API Manager and the WSO2 Identity Server comes with JDBC User Store as the primary userstore. But if you wish to use any other type of user store(LDAP, Active Directory etc) in IS, that particular user store has to be configured in API Manager nodes as well. Refer [Configuring Primary User Store]({{base_path}}/administer/product-administration/managing-users-and-roles/managing-user-stores/configure-primary-user-store/configuring-the-primary-user-store/) and apply relevant configs to plug a new user store.


### Step 6 - Optionally, configure High Availability (HA) for the Identity Server
    `11`
!!! warning
    These steps are **ONLY applicable** if you need to configure **HA for the Key Manager.**

1.  Make a copy of the active instance configured above and use this copy as the second Key Manager active instance.

2.  Configure a Load Balancer to front the two WSO2 Identity Server nodes.

### Step 7 - Start the Identity Server(s)

Start WSO2 Identity Server for the changes to take effect. For more information, see [Running the Product](https://is.docs.wso2.com/en/5.10.0/setup/running-the-product/) in the WSO2 Identity Server documentation.

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

        - If you have configured the hostnames for WSO2 API Manager and WSO2 Identity Server, during the server start up, you will see the following warning in the WSO2 API Manager backend logs.

        ``` java
            WARN {org.wso2.carbon.apimgt.gateway.throttling.util.BlockingConditionRetriever} -  Failed retrieving Blocking Conditions from remote endpoint: sun.security.validator.ValidatorException: PKIX path building failed: sun.security.provider.certpath.SunCertPathBuilderException: unable to find valid certification path to requested target. Retrying after 15 seconds... {org.wso2.carbon.apimgt.gateway.throttling.util.BlockingConditionRetriever}
        ```

        The reason for this is that the default certificates that come with WSO2 Servers are created for localhost. Therefore, when WSO2 API Manager boots up, it makes an HTTP call to a webapp that is in the Key Manager (throttle data at `KM_URL/internal/data/v1/keyTemplates` ). Thereafter, WSO2 API Manager decides the URL of the Key Manager based on the URL that is configured in the `deployment.toml`, which is localhost.

        To overcome this issue, you need to create self-signed certificates for WSO2 API-M and WSO2 IS host names. Then [import the public certs]({{base_path}}/administer/product-security/General/UsingAsymmetricEncryption/admin-creating-new-keystores/#step-3-importing-certificates-to-the-truststore) of WSO2 API-M to the `trust-store.jks` of WSO2 IS and vice versa. This should resolve the SSL handshake failure.


Follow the instructions below to configure the other WSO2 API-M components, namely the Publisher, Developer Portal, Traffic Manager, and Gateway:

- All-in-One Deployment
    - [Configuring a Single Node]({{base_path}}/install-and-setup/deploying-wso2-api-manager/single-node/configuring-a-single-node/)
    - [Configuring an Active-Active Deployment]({{base_path}}/install-and-setup/deploying-wso2-api-manager/single-node/configuring-an-active-active-deployment/)
- [Distributed Deployment]({{base_path}}/install-and-setup/setup/distributed-deployment/deploying-wso2-api-m-in-a-distributed-setup/)