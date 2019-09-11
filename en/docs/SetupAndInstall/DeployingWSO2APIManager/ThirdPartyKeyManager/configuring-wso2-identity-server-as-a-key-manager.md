# Configuring WSO2 Identity Server as a Key Manager

!!! warning
Before you begin check the product compatibility

![](images/icons/grey_arrow_down.png){.expand-control-image} Click here to see the compatibility matrix.

The compatibility matrix with regard to WSO2 API Manager (WSO2 API-M) and WSO2 Identity Server Key Manager ( WSO2 IS-KM ) product distribution is as follows:

![](images/icons/grey_arrow_down.png){.expand-control-image} What is referred to as the prepackaged WSO2 Identity Server as a Key Manager?

!!! info
The **prepackaged WSO2 Identity Server as a Key Manager 5.7.0** comes with the necessary configurations already installed in order to connect WSO2 Identity Server as the Key Manager for WSO2 API Manager, and is therefore different to the default version (vanilla pack) of WSO2 Identity Server 5.7.0. The prepackaged WSO2 Identity Server as a Key Manager 5.7.0 is compatible with WSO2 API Manager 2.6.0 and is supported by [WUM](https://wso2.com/updates) .

<table>
<thead>
<tr class="header">
<th>WSO2 API-M</th>
<th>WSO2 IS-KM</th>
<th>Details</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>API-M 2.6.0 GA</td>
<td><p>GA or WUM update for WSO2 IS-KM-5.7.0</p></td>
<td><br />
</td>
</tr>
<tr class="even">
<td>API-M-2.6.0 WUM update</td>
<td><p>GA or WUM update for WSO2 IS-KM-5.7.0</p></td>
<td><br />
</td>
</tr>
<tr class="odd">
<td>APIM-2.6.0-update-X</td>
<td>-</td>
<td>APIM-2.6.0-update-X (e.g., WSO2 APIM-2.6.0-update-1) releases are <strong>not compatible</strong> with the GA or WUM updates that are available for WSO2 IS-KM.</td>
</tr>
</tbody>
</table>


-   [Step 1 - Download WSO2 IS as a Key Manager (WSO2 IS-KM)](#ConfiguringWSO2IdentityServerasaKeyManager-Step1-DownloadWSO2ISasaKeyManager(WSO2IS-KM))
-   [Step 2 - Optionally, configure port offset for WSO2 IS](#ConfiguringWSO2IdentityServerasaKeyManager-Step2-Optionally,configureportoffsetforWSO2IS)
-   [Step 3 - Install and configure the databases](#ConfiguringWSO2IdentityServerasaKeyManager-Step3-Installandconfigurethedatabases)
-   [Step 4 - Configure the Key Manager (WSO2 IS) with WSO2 API-M](#ConfiguringWSO2IdentityServerasaKeyManager-Step4-ConfiguretheKeyManager(WSO2IS)withWSO2API-M)
-   [Step 5 - Configure WSO2 API-M with the Key Manager (WSO2 IS)](#ConfiguringWSO2IdentityServerasaKeyManager-Step5-ConfigureWSO2API-MwiththeKeyManager(WSO2IS))
-   [Step 6 - Optionally, configure High Availability (HA) for the Key Manager](#ConfiguringWSO2IdentityServerasaKeyManager-Step6-Optionally,configureHighAvailability(HA)fortheKeyManager)
-   [Step 7 - Start the Key Manager(s)](#ConfiguringWSO2IdentityServerasaKeyManager-Step7-StarttheKeyManager(s))
-   [Step 8 - Configure the other API-M components](#ConfiguringWSO2IdentityServerasaKeyManager-Step8-ConfiguretheotherAPI-Mcomponents)

### Step 1 - Download WSO2 IS as a Key Manager (WSO2 IS-KM)

Download the prepackaged WSO2 Identity Server from [here](https://wso2.com/api-management/install/key-manager/) and unzip it. `         <IS_KM_HOME>        ` will refer to the root folder of the unzipped WSO2 IS pack.

!!! info
It is assumed that you have already downloaded WSO2 API Manager. `         <APIM_HOME>        ` will refer to the root folder of the unzipped WSO2 API-M pack.

!!! note
The product distributions are also available as a WUM update. For more information, see Getting Started with WUM in the Administration Guide.


### Step 2 - Optionally, configure port offset for WSO2 IS

!!! note
This is only required if you are running both WSO2 API Manager and WSO2 Identity Server on the same Virtual Machine (VM).


![](images/icons/grey_arrow_down.png){.expand-control-image} Click here for more information on port offsetting

!!! info
The port offset feature allows you to run multiple WSO2 products, multiple instances of a WSO2 product, or multiple WSO2 product clusters on the same server or virtual machine (VM). The port offset defines the number by which all ports defined in the runtime such as the HTTP/S ports will be offset. For example, if the HTTP port is defined as 9763 and the port offset is 1, the effective HTTP port will be 9764. Therefore, for each additional WSO2 product, instance, or cluster you add to a server, set the port offset to a unique value (the default is 0).

Open the `         <IS_KM_HOME>/repository/conf/carbon.xml        ` file and change the offset to 1. This increments the product's default port by one.

**carbon.xml**

``` xml
    <Offset>1</Offset>
```

### Step 3 - Install and configure the databases

You can create the required databases for the API-M deployment on a separate server and point to the databases from the respective nodes.

!!! warning
If you have already created the databases, you need to only configure the data source configurations, so that WSO2 IS, which acts as the Key Manager, can connect to the required databases.


![](images/icons/grey_arrow_down.png){.expand-control-image} Click here for information on installing and configuring the databases.

The following diagram illustrates how the databases are shared between WSO2 IS and WSO2 API-M.

![](attachments/103334507/103334508.png)
-   **WSO2REG\_DB** - This database (DB) stores the registry information. The registry database is shared between WSO2 IS as the Key Manager and WSO2 API-M to share artifacts such as, metadata configurations, policies, and API details.

-   **WSO2UM\_DB** - This DB stores the permissions (i.e., permission store) and the internal roles of the users.

-   **WSO2AM\_DB** - This DB stores the identity data and API-related data and it includes OAuth tokens and keys. When serving key-validation requests, the Key Manager accesses the `             WSO2AM_DB            ` , validates whether there are subscriptions made by the particular key.

-   **LDAP** - This DB stores the users and their role mapping. You do not need to configure the data source configuration in the `            master-datasources.xml           ` file for the LDAP.

------------------------------------------------------------------------

For more information, see \_Configuring the Databases for IS as the Key Manager .

### Step 4 - Configure the Key Manager (WSO2 IS) with WSO2 API-M

!!! warning
The following instructions are only applicable in the following scenarios:

-   If you are deploying WSO2 API-M using a hybrid single node deployment with WSO2 Identity Server as the Key Manager.
-   If you are deploying WSO2 API-M using a hybrid active-active deployment pattern with WSO2 Identity Server as the Key Manager.


1.  

    Configure the Key Manager to enable communication between the Key Manager and the Gateway.

        !!! warning
    This step is **only applicable if you have enabled Hazelcast clustering** in the API-M Gateway node.

    ![](images/icons/grey_arrow_down.png){.expand-control-image} Click here for information on configuring the WSO2 API-M Gateway with or without Hazelcast.

    -   When should I use Hazelcast?

    -   Distributed Deployment of the Gateway using a shared file system

    -   \_Configuring the Gateway in a Distributed Environment with rsync


    1.  When users and roles are removed via the Key Manager, if the corresponding user tokens are cached on the Gateway, these tokens will only get invalidated when the cache is timed out. However, if Hazelcast clustering is enabled, token invalidation takes place immediately. Therefore, you need to enable communication between the Key Manager and Gateway to enable immediate token invalidation.
        For this purpose open the `              <IS_KM_HOME>/repository/conf/api-manager.xml             ` file and change the `              <ServerURL>             ` element that appears under the `              <APIGateway>             ` section, so that it points to the API Manager server.

        ``` java
                <ServerURL>https://${gateway-server-host}:{port}/services/</ServerURL>
        ```

        -   If you are working with a **hybrid single node or active-active node** deployment where WSO2 IS is the Key Manager and the rest of the API-M components are in one node, you need to replace `               {gateway-server-host}              ` with the host of the **WSO2 API-M** node.
        -   If you are working with a **single Gateway** in distributed set up, you need to replace `               {gateway-server-host}              ` with the host of the **Gateway** node.
        -   If you are working with **Gateways** in a **High Availability (HA)** set up that uses a **shared file system** (e.g., NFS), you need to replace `               {gateway-server-host}              ` with the host of **any Gateway** node as all nodes have the worker manager capability when using shared file system.
        -   If you are working with **Gateways** in a **High Availability (HA)** set up that uses **rsync** , you need to replace `                {gateway-server-host}               ` with the host of the **Gateway Manager** node.

        -   The port value you enter here should be the management transport port. For more information, see [Default Product Ports](https://docs.wso2.com/display/AM260/Default+Product+Ports) .

    2.  When tokens are revoked, the corresponding token cache entries should be cleared in the Gateway. For this purpose, open the `              <IS_KM_HOME>/repository/conf/api-manager.xml             ` file and change the `              <RevokeAPIURL>             ` element that appears under the `              <OAuthConfigurations>             ` section, so that it points to the WSO2 API Manager server, or the Gateway worker server if it is a distributed setup. Note the port used here is the NIO port, which is 8243 by default for HTTPS.

        ``` java
                    <RevokeAPIURL>https://${gateway-worker-server-host}:{nio-port}/revoke</RevokeAPIURL>
        ```

                !!! info
        If you are using a load balancer to front the API-M/Gateway nodes, you can use the load balancer endpoints for the configurations mentioned under step 1 and step 2 above.


2.  Configure the [JSON Web Token (JWT)](http://openid.net/specs/draft-jones-json-web-token-07.html#anchor3) in the `          <IS_KM_HOME>/repository/conf/api-manager.xml         ` file in the WSO2 Identity Server. For more information on JWT Token generation, see [Passing Enduser Attributes to the Backend Using JWT](https://docs.wso2.com/display/AM260/Passing+Enduser+Attributes+to+the+Backend+Using+JWT) .

    -   Enable `            ClaimsRetrieverImplClass           ` , `            ConsumerDialectURI,           ` and `            SignatureAlgorithm           ` by uncommenting the respective elements.
    -   Set &lt; `            SignatureAlgorithm>           ` to one of the following values - `            NONE or SHA256withRSA           ` `                       `

        !!! note
    If you wish to encrypt the Auth Keys (access tokens, client secrets and authorization codes) follow [Encrypting OAuth Keys](https://docs.wso2.com/display/AM260/Encrypting+OAuth+Keys) by modifying the `           <PRODUCT_HOME>/repository/conf/api-manager.xml          ` file in both the WSO2 Identity Server and WSO2 API Manager products.


3.  Change the datasource in the `           <IS_KM_HOME>/repository/conf/user-mgt.xml          ` file to point to the `           WSO2UM_DB          ` datasource.
    You need to do this in order to point to the correct database for user management purposes. By default, this configuration points to the embedded H2 database.

    **user-mgt.xml**

    ``` java
        <UserManager>
            <Realm>        
                <Configuration>
                    ...
                    <Property name="dataSource">jdbc/WSO2UM_DB</Property>
                </Configuration>
                ...
            </Realm>
        </UserManager>
    ```

4.  Make sure that the data source name defined under `           JDBCPersistenceManager          ` is `           jdbc/WSO2AM_DB          ` in the `           <IS_KM_HOME>/repository/conf/identity/identity.xml          ` file.

        !!! note
    Make sure you add the user store configuration correctly. This is the same configuration that you added in WSO2 API Manager. For more information on how to do this, see [Configuring User Stores](https://docs.wso2.com/display/ADMIN44x/Configuring+User+Stores) in the Administration Guide.


    ``` java
            <JDBCPersistenceManager>
                <DataSource>
                    <Name>jdbc/WSO2AM_DB</Name>
                </DataSource>
                ...
             <JDBCPersistenceManager>
    ```

### Step 5 - Configure WSO2 API-M with the Key Manager (WSO2 IS)

!!! warning
The following instructions are only applicable in the following scenarios:

-   If you are deploying WSO2 API-M using a hybrid single node deployment with WSO2 Identity Server as the Key Manager.
-   If you are deploying WSO2 API-M using a hybrid active-active deployment pattern with WSO2 Identity Server as the Key Manager.


1.  Change the `           ServerURL          ` of the **`            AuthManager           `** and the `           ServerURL          ` of the **`            APIKeyValidator           `** to point to WSO2 IS in the `           <API-M_HOME>/repository/conf/api-manager.xml          ` file.
    You need to add this configuration so that WSO2 API Manager will be aware of the URL of the Key Manager, which in this case is WSO2 Identity Server, in order to handover the Key validation and Authorization related tasks.

        !!! note
    Make sure to import the Key Manager's public certificate to WSO2 API-M's `           client-truststore.jks          ` . For more information, see [Creating New Keystores](https://docs.wso2.com/display/ADMIN44x/Creating+New+Keystores) .


    ``` java
        <APIManager>
            ...
        <!-- Authentication manager configuration for API publisher and API store. This is
             a required configuration for both web applications as their user authentication
             logic relies on this. -->
        <AuthManager>
            <!-- Server URL of the Authentication service -->
            <ServerURL>https://${IS-server-host}:{port}/services/</ServerURL>
            ...
        </AuthManager>

        ...

        <APIKeyValidator>
            <!-- Server URL of the API key manager -->
            <ServerURL>https://${IS-server-host}:{port}/services/</ServerURL>

            ...

        </APIKeyValidator>

        ...
    </APIManager>
    ```
    -   If you are working with a **single Key Manager** in hybrid single node setup where WSO2 IS is the Key Manager and the rest of the API-M components are in one node, you need to replace `            {IS-server-host}           ` with the actual host of the WSO2 IS sever **** node.
    -   If you are working with a **single Key Manager** in distributed setup, you need to replace `            {IS-server-host}           ` with the actual host of the WSO2 IS sever **** node.
    -   If you are working with **Key Managers** in **High Availability (HA)** mode with a hybrid active-active node setup, where WSO2 IS is the Key Manager and the rest of the API-M components are in one node, you need to replace `            {IS-server-host}           ` with the host of the **Key Manager Load Balancer** node.
    -   If you are working with **Key Managers** in a **High Availability (HA)** setup, you need to replace `            {IS-server-host}           ` with the host of the **Key Manager Load Balancer** node.

2.  Enable WS Client and disable the Thrift Client.
    Do this by changing the &lt; `           KeyValidatorClientType>          ` from `           ThriftClient          ` to `           WSClient          ` , and by setting `           <                       EnableThriftServer>           ` to `                       false           ` to optimize performance.

        !!! note
    As API Gateway and Key Manager are two separate components (distributed) they talk to each other via API calls. This API call happens out-of-the-box via Thrift in WSO2 API Manager. However, when it comes to a production environment with high availability, it’s recommended to switch to WSClient for key validation.


    **api-manager.xml**

    ``` xml
        <APIManager>
            ...
            <APIKeyValidator>
                ...
                <KeyValidatorClientType>WSClient</KeyValidatorClientType>
                <EnableThriftServer>false</EnableThriftServer>
               ...
            </APIKeyValidator>
            ...
        </APIManager>
    ```

3.  If you are using the embedded LDAP that comes with WSO2 IS, then you need to point to the particular LDAP user store from WSO2 API Manager. You can copy this configuration from the `           <IS_KM_HOME>/repository/conf/user-mgt.xml          ` file to the `           <API-M_HOME>/repository/conf/user-mgt.xml          ` file.

    When copying configurations, note that you must update the ports. For instance, when configuring the `           ConnectionURL          ` property, you must update the port, because otherwise it will point to the port of the Identity Server when starting up if you copy it directly.

    ``` java
            <Property name="ConnectionURL">ldap://<ip_address_of_IS>:10389</Property>
    ```

    Note that if you have offset the IS port, then this port value 10389 should be incremented by the given WSO2 IS port offset.

4.  Make sure data source name in `           JDBCPersistenceManager          ` is `           jdbc/WSO2AM_DB          ` in the `           <API-M_HOME>/repository/conf/identity/identity.xml          ` file.

        !!! note
    Make sure you add the user store configuration correctly. This is the same configuration that you added in the Identity Server. For more information on how to do this, see [Configuring User Stores](https://docs.wso2.com/display/ADMIN44x/Configuring+User+Stores) in the Administration Guide.


    ``` java
            <JDBCPersistenceManager>
                <DataSource>
                    <Name>jdbc/WSO2AM_DB</Name>
                </DataSource>
                ...
             <JDBCPersistenceManager>
    ```

### Step 6 - Optionally, configure High Availability (HA) for the Key Manager

!!! warning
These steps are **ONLY applicable** if you need to configure **HA for the Key Manager.**


1.  Make a copy of the active instance configured above and use this copy as the second Key Manager active instance.

2.  Configure a Load Balancer to front the two Key Manager nodes.
    For more information, see \_Configuring the Proxy Server and the Load Balancer .

### Step 7 - Start the Key Manager(s)

Start WSO2 Identity Server for the changes to take effect. For more information, see [Running the Product](https://docs.wso2.com/display/IS530/Running+the+Product) in the WSO2 Identity Server documentation.

``` java
    sh <IS_KM_HOME>/bin/wso2server.sh
```

![](images/icons/grey_arrow_down.png){.expand-control-image} Click here for information on troubleshooting

-   You may notice the following error messages when starting up the server. This occurs because some API Manager directories are not available in the Identity Server. These are not critical errors, so they can be ignored. Alternatively, you can create the listed directories in the Identity Server pack.

    ``` java
            ERROR {org.wso2.carbon.apimgt.impl.utils.APIUtil} - Custom sequence template location unavailable for custom sequence type in : repository/resources/customsequences/in 
             ERROR {org.wso2.carbon.apimgt.impl.utils.APIUtil} - Custom sequence template location unavailable for custom sequence type out : repository/resources/customsequences/out 
             ERROR {org.wso2.carbon.apimgt.impl.utils.APIUtil} - Custom sequence template location unavailable for custom sequence type fault : repository/resources/customsequences/fault
    ```

-   If you have configured the hostnames for WSO2 API Manager and WSO2 Identity Server in the server start up, you will see the following warning in the WSO2 API Manager backend logs.

    ``` java
            WARN {org.wso2.carbon.apimgt.gateway.throttling.util.BlockingConditionRetriever} -  Failed retrieving Blocking Conditions from remote endpoint: sun.security.validator.ValidatorException: PKIX path building failed: sun.security.provider.certpath.SunCertPathBuilderException: unable to find valid certification path to requested target. Retrying after 15 seconds... {org.wso2.carbon.apimgt.gateway.throttling.util.BlockingConditionRetriever}
    ```

    The reason for this is that the default certificates that come with WSO2 Servers are created for localhost. Therefore, when WSO2 API Manager boots up, it makes an HTTP call to a webapp that is in the Key Manager (throttle data at `             KM_URL/throttle/data/v1/keyTemplates            ` ). Thereafter, WSO2 API Manager decides the URL of the Key Manager base on the URL that is configured in the `             api-manager.xml            ` , `            ` which is localhost.

    To overcome this issue, you need to create self-signed certificates for WSO2 API-M and WSO2 IS host names. Then export the public certs of WSO2 API-M to the `             trust-store.jks            ` of WSO2 IS and vice versa. This should resolve the SSL handshake failure.

### Step 8 - Configure the other API-M components

Follow the instructions below to configure the other WSO2 API-M components, namely the Publisher, Store, Traffic Manager, and Gateway:

-   If you are working with a single WSO2 API-M instance, which has all the API-M components in one instance, and a separate Key Manager, then configure the steps mentioned in \_Configuring a Single Node .
-   If you are working with an Active-Active setup, which has two all-in-one instances of API-M, and a separate Key Manager in high availability (HA) mode, then configure the steps mentioned in \_Configuring an Active-Active Deployment .
-   If you are working with a distributed API-M setup, see \_Deploying WSO2 API-M in a Distributed Setup to configure the other API-M components.

