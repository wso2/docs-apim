# Configuring WSO2 Identity Server as a Key Manager

Follow the instructions below to configure WSO2 Identity Server (WSO2 IS) as the Key Manager of the WSO2 API Manager (WSO2 API-M) deployment globally.

- [Step 1 - Download and install WSO2 IS](#step-1-download-and-install-wso2-is)
- [Step 2 - Optionally, configure port offset for WSO2 IS](#step-2-optionally-configure-port-offset-for-wso2-is)
- [Step 3 - Install and configure the databases](#step-3-install-and-configure-the-databases)
- [Step 4 - Configure WSO2 IS with WSO2 API-M](#step-4-configure-wso2-is-with-wso2-api-m)
- [Step 5 - Configure WSO2 API-M with the WSO2 IS](#step-5-configure-wso2-api-m-with-the-wso2-is)
- [Step 6 - Optionally, configure High Availability (HA) for the Identity Server](#step-6-optionally-configure-high-availability-ha-for-the-identity-server)
- [Step 7 - Start the Identity Server(s)](#step-7-start-the-identity-servers)

## Step 1 - Download and install WSO2 IS

Download and install the [latest WSO2 Identity Server](https://wso2.com/identity-and-access-management/#). If you downloaded the archive, extract it. `<IS_HOME>` refers to the root folder of the extracted WSO2 Identity Server.

It is assumed that you have already downloaded WSO2 API Manager.
`<APIM_HOME>` refers to the root folder of the unzipped WSO2 API-M pack.

## Step 2 - Optionally, configure port offset for WSO2 IS

!!! note
    This is only required if you are running both WSO2 API Manager and WSO2 Identity Server on the same Virtual Machine (VM). For more information, see [Changing the Default Ports with Offset]({{base_path}}/install-and-setup/deploying-wso2-api-manager/changing-the-default-ports-with-offset).

Open the `<IS_HOME>/repository/conf/deployment.toml` file and change the offset to 1 by applying the following config as follows:

``` yaml
[server]
offset = 1
```

This increments the product's default port by one.

## Step 3 - Install and configure the databases

You can create the required databases for the API-M deployment on a separate server and point to the databases from the respective nodes.

The following diagram depicts how the databases are shared between WSO2 IS and WSO2 API-M.

<a href="{{base_path}}/assets/img/setup-and-install/is-as-km-dbs.png" ><img src="{{base_path}}/assets/img/setup-and-install/is-as-km-dbs.png" alt="IS-AS-KM-DBS" title="IS-AS-KM-DBS" width="90%" /></a>

-   **WSO2SHARED_DB** - This database contains the registry and user management data. 

Follow the instructions below to set up and configure the databases for the WSO2 IS as the Key Manager node:

1. Install, setup, and configure `WSO2_SHARED_DB` databases as illustrated in [Changing the Default Databases]({{base_path}}/install-and-setup/setup/setting-up-databases/overview/). 

     This particular guide provides you all the steps on how to install the database, set up database users, create tables using relevant scripts, apply the drivers that are compatible with the database type, and configure the connection details in the connection data in the `<IS_HOME>/repository/conf/deployment.toml` file.

     This step is needed if a shared user store has to be used among the servers.
 
    !!! warning
        If you have already created and set up the database (`WSO2_SHARED_DB`) for WSO2 API Manager, you only need to configure the data source configurations in the WSO2 IS node for it to connect with the required databases and act as the Key Manager.

     <a name="#step3-2"></a>

2. Share `WSO2_SHARED_DB`with WSO2 IS.

     You need to define the following configuration in the `<IS_HOME>/repository/conf/deployment.toml` file. Sample configurations for MySQL have been provided.
  
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

3. **If multi-tenancy is used**, you need to share the `WSO2AM_DB` with the Identity Server.
    
     You need to define the following configuration in the `<IS_HOME>/repository/conf/deployment.toml` file. Sample configurations for MySQL have been provided.

    !!! note
        **If you are using Identity Server in an HA setup and not using multi-tenancy**, create an identity database and share the `[database.identity_db]` db between the two IS nodes.

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

4. Share `WSO2_SHARED_DB` with WSO2 API-M.

     Define the same datasource configurations that were mentioned in <a href="#step3-2">step 3.2</a> for `WSO2_SHARED_DB` in the `<APIM_HOME>/repository/conf/deployment.toml` file.

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

5.  Share `WSO2AM-DB` with WSO2 API-M.

     Define the datasource configurations for `WSO2AM-DB` in the `<APIM_HOME>/repository/conf/deployment.toml` file. 

     ``` tab="Format"

     [database.apim_db]
     type = "mysql"
     url = "jdbc:mysql://<database-host>:3306/<WSO2AM_DB>"
     username = "<db_username>"
     password = "<db_password>"
     ```

     ``` tab="Example"

     [database.apim_db]
     type = "mysql"
     url = "jdbc:mysql://localhost:3306/apim_db"
     username = "amadmin"
     password = "amadmin"
     ```

## Step 4 - Configure WSO2 IS with WSO2 API-M

1. Download the [WSO2 IS Connector]({{base_path}}/assets/attachments/administer/wso2is-km-connector-1.0.17.zip).

2. Extract the distribution and copy the following JAR files, which are in the `<wso2is-extensions-1.0.17>/dropins` directory, to the `<IS_HOME>/repository/components/dropins` directory.

     - `wso2is.key.manager.core-1.0.17.jar`

     - `wso2is.notification.event.handlers_1.0.17.jar`

3. Add the `keymanager-operations.war`, which is in the `<wso2is-extensions-1.0.17>/webapps` directory, to the `<IS_HOME>/repository/deployment/server/webapps` directory.

4.  Configure the Traffic Manager endpoints.

     Add the following configuration in the `<IS_HOME>/repository/conf/deployment.toml` file and configure the Traffic Manager endpoints as follows:

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

    [[resource.access_control]]
    context = "(.*)/keymanager-operations/dcr/register(.*)"
    secure = true
    http_method = "PUT"
    permissions = "/permission/admin/manage/identity/applicationmgt/update"
    scopes = "internal_application_mgt_update"

    [[resource.access_control]]
    context = "(.)/keymanager-operations/dcr/register(.)"
    secure = true
    http_method = "POST"
    permissions = "/permission/admin/manage/identity/applicationmgt/update"
    scopes = "internal_application_mgt_update"

    [tenant_context.rewrite]
    custom_webapps = ["/keymanager-operations/"]
    ```

5. Configure the event listener endpoint to publish controller events to the Traffic Manager.

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

6.  If you wish to encrypt the OAuth2 Keys (access tokens, client secrets, and authorization codes) follow the steps given in [Encrypting OAuth Keys](https://is.docs.wso2.com/en/5.10.0/learn/testing-oidc-encrypted-id-token-with-is/#enable-id-token-encryption), which is in the WSO2 Identity Server 5.10.0 documentation, and apply the relevant configurations in the `<IS_HOME>/repository/conf/deployment.toml` file to enable the feature.

## Step 5 - Configure WSO2 API-M with the WSO2 IS

By default, WSO2 API Manager and WSO2 Identity Server comes with a JDBC User Store as the primary userstore. However, if you wish to use any other type of user store (e.g., LDAP, Active Directory, etc.) in WSO2 IS, that particular user store has to be configured in the API Manager nodes as well. For more information, see [Configuring the Primary User Store]({{base_path}}/administer/product-administration/managing-users-and-roles/managing-user-stores/configure-primary-user-store/configuring-the-primary-user-store/) and apply the relevant configs to plug in a new user store.

1. Add below config in `<APIM_HOME>/repository/conf/deployment.toml`

```java
   [apim.key_manager]
   service_url = "https://localhost:9444/services/"
   type = "WSO2-IS"

```
## Step 6 - Optionally, configure High Availability (HA) for the Identity Server

!!! warning
    These steps are **ONLY applicable** if you need to configure **HA for the Key Manager.**

1.  Make a copy of the active instance configured above and use this copy as the second Key Manager active instance.

2.  Configure a Load Balancer to front the two WSO2 Identity Server nodes.

## Step 7 - Start the Identity Server(s)

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

        If you have configured the hostnames for WSO2 API Manager and WSO2 Identity Server, during the server startup, you will see the following warning in the WSO2 API Manager backend logs.

        ``` java
        WARN {org.wso2.carbon.apimgt.gateway.throttling.util.BlockingConditionRetriever} -  Failed retrieving Blocking Conditions from remote endpoint: sun.security.validator.ValidatorException: PKIX path building failed: sun.security.provider.certpath.SunCertPathBuilderException: unable to find valid certification path to requested target. Retrying after 15 seconds... {org.wso2.carbon.apimgt.gateway.throttling.util.BlockingConditionRetriever}
        ```

        The reason for this is that the default certificates that come with the WSO2 servers are created for `localhost`. Therefore, when WSO2 API Manager boots up, it makes an HTTP call to a webapp that is in the Key Manager (throttle data at `KM_URL/internal/data/v1/keyTemplates`). Thereafter, WSO2 API Manager decides the URL of the Key Manager based on the URL that is configured in the `deployment.toml`, which is `localhost`.

        To overcome this issue, you need to create self-signed certificates for WSO2 API-M and WSO2 IS hostnames. Then [import the public certificates]({{base_path}}/install-and-setup/setup/security/configuring-keystores/keystore-basics/creating-new-keystores/#step-3-importing-certificates-to-the-truststore) of WSO2 API-M to the `trust-store.jks` of WSO2 IS and vice versa. This should resolve the SSL handshake failure.

Follow the instructions below to configure the other WSO2 API-M components, namely the Publisher, Developer Portal, Traffic Manager, and Gateway:

- All-in-One Deployment
    - [Configuring a Single Node]({{base_path}}/install-and-setup/deploying-wso2-api-manager/single-node/configuring-a-single-node/)
    - [Configuring an Active-Active Deployment]({{base_path}}/install-and-setup/deploying-wso2-api-manager/single-node/configuring-an-active-active-deployment/)
- [Distributed Deployment]({{base_path}}/install-and-setup/setup/distributed-deployment/deploying-wso2-api-m-in-a-distributed-setup/)
