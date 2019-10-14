# Deploying WSO2 API-M in a Distributed Setup

Follow the instructions below to deploy WSO2 API Manager (WSO2 API-M) in a distributed environment, as depicted in the following deployment diagram:

-   [Step 1 - Install and configure WSO2 API-M](#DeployingWSO2API-MinaDistributedSetup-Step1-InstallandconfigureWSO2API-M)
-   [Step 2 - Install and configure the databases](#DeployingWSO2API-MinaDistributedSetup-Step2-Installandconfigurethedatabases)
-   [Step 3 - Configure your deployment with production hardening](#DeployingWSO2API-MinaDistributedSetup-Step3-Configureyourdeploymentwithproductionhardening)
-   [Step 4 - Create and import SSL certificates](#DeployingWSO2API-MinaDistributedSetup-Step4-CreateandimportSSLcertificates)
-   [Step 5 - Configure API-M Analytics](#DeployingWSO2API-MinaDistributedSetup-Step5-ConfigureAPI-MAnalytics)
-   [Step 6 - Configure the connections among the components and start the servers](#DeployingWSO2API-MinaDistributedSetup-Step6-Configuretheconnectionsamongthecomponentsandstarttheservers)

![]({{base_path}}/assets/attachments/103334487/103334488.png)
### Step 1 - Install and configure WSO2 API-M

![](images/icons/grey_arrow_down.png){.expand-control-image} Click here for information on installing and configuring WSO2 API-M.

The following steps describe how to download, install, and configure WSO2 API Manager, with five instances.

1.  Download the [WSO2 API Manager](http://wso2.com/products/api-manager/) in each of the five servers in the cluster for distributed deployment.
2.  Unzip the WSO2 API Manager zipped archive, and rename each of those directories respectively as Key Manager, Gateway, Publisher, Store, and Traffic Manager.
    These five directories are located in a server of their own and are used for each component of WSO2 API-M. Each of these unzipped directories are referred to as `<API-M_HOME>` or `<PRODUCT_HOME>` in this document.

3.  In each of the five servers, replace the default certificates (where `CN=localhost` ) with new certificates generated with proper common name (CN) values.
    You need to do this in order to avoid getting an error with regard to the fact that the hostname in the certificate did not match.

        !!! note
    Note that you should use the same primary keystore for all the API Manager instances here in order to decrypt the registry resources. For more information, see [Configuring Primary Keystores](https://docs.wso2.com/display/ADMIN44x/Configuring+Keystores+in+WSO2+Products#ConfiguringKeystoresinWSO2Products-ConfiguringtheprimarykeystoreConfiguringtheprimarykeystore(forinternaldataencryption)) in the Administration Guide. When creating the keystore, always use a longer validity period so that it will avoid the need of migration on the registry data when shifting to a new keystore.


### Step 2 - Install and configure the databases

You can create the required databases for the API-M deployment in a separate server and point to the databases from the respective nodes. For information on configuring the databases, see \_Installing and Configuring the Databases .

### Step 3 - Configure your deployment with production hardening

Ensure that you have taken into account the respective security hardening factors (e.g., changing and encrypting the default passwords, configuring JVM security, etc.) before deploying WSO2 API-M. For more information, see the [Production Deployment Guidelines](https://docs.wso2.com/display/ADMIN44x/Production+Deployment+Guidelines#ProductionDeploymentGuidelines-Commonguidelinesandchecklist) in the Administration Guide.

### Step 4 - Create and import SSL certificates

Create a SSL certificate for each of the WSO2 API-M nodes (e.g., Publisher, Store, Key Manager, Gateway, and Traffic Manager ) and import them to the keyStore and the trustStore. For more information, see [Creating SSL Certificates](https://docs.wso2.com/display/ADMIN44x/Creating+New+Keystores) in the Administration Guide.

!!! note
When maintaining high availability (HA) i n the WSO2 API-M distributed set up , you need to create and import a SSL certificate for each of the WSO2 API-M HA nodes.


### Step 5 - Configure API-M Analytics

The page: **\_Configuring a Single Node** was not found. Please check/update the page name used in the 'multiexcerpt-include macro.

### Step 6 - Configure the connections among the components and start the servers

You will now configure the inter-component relationships of the distributed setup by modifying their `<API-M_HOME>/repository/conf/api-manager.xml` files. It is recommended to start the components in the following order: Key Manager, Publisher, Store, Traffic Manager, and Gateway.

!!! note
In a clustered environment, you use session affinity ( sticky sessions ) to ensure that requests from the same client always get routed to the same server.

It is **mandatory** to set up Session Affinity in the load balancers that front the **Publisher** and **Store** clusters, and it is **optional** in the load balancer (if any) that fronts a **Key Manager** cluster or **Gateway** Cluster. However, you need to enable Session Affinity if you are working with multiple Gateway Managers in a Gateway High Availability (HA) deployment.

However, authentication via session ID fails when session affinity is disabled in the load balancer.

First time authentication happens via Basic Auth and the Gateway gets a cookie. This cookie is used in every consequent request along with the Basic Auth credentials. The admin service validates the cookie and if the validation fails it re-authenticates it using Basic Auth and issues a new cookie.


![](images/icons/grey_arrow_down.png){.expand-control-image} Click here for information on configuring the connections among the components and starting the servers.

-   [Step 6.1 - Configure the common configurations](#DeployingWSO2API-MinaDistributedSetup-Step6.1-Configurethecommonconfigurations)
-   [Step 6.2 - Configure and start the Key Manager](#DeployingWSO2API-MinaDistributedSetup-Step6.2-ConfigureandstarttheKeyManager)
-   [Step 6.3 - Configure and start the API Publisher](#DeployingWSO2API-MinaDistributedSetup-Step6.3-ConfigureandstarttheAPIPublisher)
-   [Step 6.4 - Configure and start the API Store](#DeployingWSO2API-MinaDistributedSetup-Step6.4-ConfigureandstarttheAPIStore)
-   [Step 6.5 - Configure and start the Traffic Manager](#DeployingWSO2API-MinaDistributedSetup-Step6.5-ConfigureandstarttheTrafficManager)
-   [Step 6.6 - Configure and start the Gateway](#DeployingWSO2API-MinaDistributedSetup-Step6.6-ConfigureandstarttheGateway)

#### Step 6.1 - Configure the common configurations

The common configurations can be done automatically when starting up the server. For instructions, see [Starting an API-M profile](https://docs.wso2.com/display/AM260/Product+Profiles) .

!!! tip
When a node starts, it starts all the components and featured bundled with it. If you are concerned about resource utilization, you can run the product on a specific profile, so that only the components and features that are required for that node and common features start up.
**Example**

``` java
    sh <PRODUCT_HOME>/bin/wso2server.sh -Dprofile=api-store
```

For more information on using multi-profile support, see [Product Profiles](https://docs.wso2.com/display/AM260/Product+Profiles) .

#### Step 6.2 - Configure and start the Key Manager

This section involves setting up the Key Manager node and enabling it to work with the other components in a distributed deployment .

!!! warning
**Skip** this step if you are using **WSO2 Identity Server as the Key Manager** and follow the instructions mentioned in \_Configuring WSO2 Identity Server as a Key Manager to configure and start the Key Manager.
1.  Open the `<API-M_HOME>/repository/conf/api-manager.xml` file in the Key Manager node and c hange the `<ServerURL>` element that appears under the `<APIGateway>` section, so that it points to the API Manager Gateway.
    You need to add these configurations so that when a user is deleted or when the role of a user is updated in the Key Manager, it will update the Gateway cache by clearing the cache entries of a particular user.
    -   If you are working with a **single Gateway** in distributed set up, you need to replace \[ `GATEWAY_SERVER_HOST]` with the host of the **Gateway** node.
    -   If you are working with **Gateways** in a **High Availability (HA)** setup that uses a **shared file system** (e.g., [NFS](https://en.wikipedia.org/wiki/Network_File_System) ), you need to replace \[ `GATEWAY_SERVER_HOST]` with the host of the **Gateway load balancer** node.
    -   If you are working with **Gateways** in a **High Availability (HA)** setup that uses **rsync** , you need to replace \[ `GATEWAY_SERVER_HOST]` with the host of the **Gateway Manager** node.
    -   You need to replace `[port]` with the management transport port. For more information, see [Default Product Ports](https://docs.wso2.com/display/AM260/Default+Product+Ports) .

        ``` java
                <ServerURL>https://$[GATEWAY_SERVER_HOST]:[port]/services/</ServerURL>
        ```

2.  Configure the API key validator in the Key Manager.
    The Thrift protocol is normally enabled by default. However, if you have disabled the Thrift protocol, enable it as follows in the `<API-M_HOME>/repository/conf/api-manager.xml` file.

    -   [**Single Key Manager**](#single-Key-Manager-KM)
    -   [**Key Manager with HA**](#HA-Key-Manager-KM)

    When you are using a single Key Manager, add `ThriftClient` for the `<KeyValidatorClientType>` element to use the Thrift protocol.

    ``` plain
            <APIKeyValidator>    
                
                <KeyValidatorClientType>ThriftClient</KeyValidatorClientType>   
                <EnableThriftServer>true</EnableThriftServer>
                <ThriftServerHost>localhost</ThriftServerHost>
                <ThriftServerPort>10397</ThriftServerPort>
                ...
            </APIKeyValidator>
    ```

        !!! note
        The default Thrift server port is 10397. You need to only uncomment the following code to set the Thrift server port if you need to use a port that differs from the default value.
        <ThriftServerPort>[port]</ThriftServerPort>


    When you are using multiple Key Managers fronted by a load balancer, you need to add `WSClient` for the `<KeyValidatorClientType>` element to use the Web Service Client, and change &lt; `EnableThriftServer>` to `false` to optimize performance.

    ``` plain
        <APIKeyValidator>
            ...
            <KeyValidatorClientType>WSClient</KeyValidatorClientType>    
         
            <EnableThriftServer>false</EnableThriftServer>
            <ThriftServerHost>localhost</ThriftServerHost>
            <ThriftServerPort>10397</ThriftServerPort>
         
            ...
        </APIKeyValidator>
    ```

        !!! tip
    If you wish to encrypt the Auth Keys (access tokens, client secrets, and authorization codes), see [Encrypting OAuth Keys](https://docs.wso2.com/display/AM260/Encrypting+OAuth+Keys) .


3.  Optionally, configure High Availability (HA) for the Key Manager.

        !!! warning
    These steps are **ONLY applicable** if you need to configure **HA for the Key Manager.**


    1.  Make a copy of the active instance configured above and use this copy as the second Key Manager active instance.

    2.  Configure a load balancer to front the two Key Manager nodes.
        For information on configuring the load balancer, see \_Configuring the Proxy Server and the Load Balancer .

4.  Start the WSO2 API-M Key Manager node(s) by typing the following command in the command prompt. For more information on starting a WSO2 server, see [Starting the server](https://docs.wso2.com/display/AM260/Running+the+Product#RunningtheProduct-Startingtheserver) .

    The page: **\_Configuring a Single Node** was not found. Please check/update the page name used in the 'multiexcerpt-include macro.

!!! note
It is not recommended to share the Solr directory between the Store and Publisher servers. You need to have separate Solr directories for each of the latter mentioned servers so that they will perform Solr indexing separately.
!!! warning
If you get an error similar to the following in both or one of the nodes, check whether you have shared the Solr directory.
``` java
    org.apache.solr.common.SolrException: 
    SolrCore 'registry-indexing' is not available due to init failure: Index locked for write for core registry-indexing
```


#### Step 6.3 - Configure and start the API Publisher

This section involves setting up the API Publisher node and enabling it to work with the other components in the distributed deployment .

1.  Open the `<API-M_HOME>/repository/conf/api-manager.xml` file in the API Publisher node and make the following changes .
    1.  Configure the **Publisher with the Key Manager** .
        You need to update the following configuration ONLY when you do not wish to share the user stores with the WSO2 API-M instance.

                !!! warning
        This step is **not applicable** if you are **enabling Single Sign-on (SSO)** .


        -   [**Single Key Manager**](#single-KM-Publisher)
        -   [**Key Manager with HA**](#HA-KM-Publisher)

        Configure the **Publisher with a single Key Manager** as follows:

        ``` java
                <AuthManager>    
                    <ServerURL>https://[Key-Manager-host]:9443/services/</ServerURL>
                    <Username>admin</Username>
                    <Password>admin</Password>
                </AuthManager>
        ```

        Configure the **Publisher with multiple Key Managers** that are fronted by a load balancer as follows:

        ``` java
                    <AuthManager>
                        <ServerURL>https://[Key-Manager-LB-host]:9443/services/</ServerURL>
                        <Username>admin</Username>
                        <Password>admin</Password>
                    </AuthManager>
        ```

    2.  Configure the **Publisher with** the **Traffic Manager** .
        This configuration enables the publishing of throttling policies, custom templates, and block conditions to the Gateway node.

        -   [**Single Traffic Manager**](#single-TM-Publisher)
        -   [**Traffic Manager with HA**](#HA-TM-Publisher)

        Configure the **Publisher with** a **single Traffic Manager** as follows:

        ``` xml
                    <ThrottlingConfigurations> 
                        <EnableAdvanceThrottling>true</EnableAdvanceThrottling>
                        <DataPublisher>
                               <Enabled>true</Enabled>
                    Type>Binary</Type>            
                                <ReceiverUrlGroup>tcp://[Traffic-Manager-host]:9611</ReceiverUrlGroup>
                                <AuthUrlGroup>ssl://[Traffic-Manager-host]:9711</AuthUrlGroup>
                              ……………………
                        </DataPublisher>
                        <PolicyDeployer>
                            <ServiceURL>https://[Traffic-Manager-Host]:9443/services/</ServiceURL>
                            <Username>${admin.username}</Username>
                            <Password>${admin.password}</Password>
                        </PolicyDeployer>
                        <BlockCondition>
                            <Enabled>false</Enabled>
                            ………………
                        </BlockCondition>
                        <JMSConnectionDetails>
                            <Enabled>false</Enabled>
                             ……………………
                        </JMSConnectionDetails>
                         ………………………………
                    </ThrottlingConfigurations>
        ```

        Configure the **Publisher with multiple Traffic Managers** that are fronted by a load balancer as follows:

        ``` xml
                    <ThrottlingConfigurations>     
                    <EnableAdvanceThrottling>true</EnableAdvanceThrottling>
                        <DataPublisher>
                               <Enabled>true</Enabled>
                              <Type>Binary</Type>
                              <ReceiverUrlGroup>{tcp://[Traffic-Manager-1-host]:9611}, {tcp://[Traffic-Manager-2-host]:9611}</ReceiverUrlGroup>
                              <!--ReceiverUrlGroup>tcp://${carbon.local.ip}:9612</ReceiverUrlGroup-->
                              <AuthUrlGroup>{ssl://[Traffic-Manager-1-host]:9711}, {ssl://[Traffic-Manager-2-host]:9711}</AuthUrlGroup>
                               <!--AuthUrlGroup>ssl://${carbon.local.ip}:9712</AuthUrlGroup-->
                              ……………………
                        </DataPublisher>
                        <PolicyDeployer>
                            <ServiceURL>https://[Traffic-Manager-LB-Host]:9443/services/</ServiceURL>
                            <Username>${admin.username}</Username>
                            <Password>${admin.password}</Password>
                        </PolicyDeployer>
                        <BlockCondition>
                            <Enabled>false</Enabled>
                            ………………
                        </BlockCondition>
                        <JMSConnectionDetails>
                            <Enabled>false</Enabled>
                             ……………………
                        </JMSConnectionDetails>
                       
                         ………………………………
                    </ThrottlingConfigurations>
        ```

    3.  Configure the **Publisher with the Gateway** .
        You need to add these configurations, because when creating an API, it calls the Gateway endpoint to create the actual Synapse file.

        -   If you are using a single Gateway node, configure the **Publisher** with the **Gateway** as follows:

            ``` xml
                            <APIGateway>
                               <Environments>
                                   <Environment type="hybrid" api-console="true">
                                        <Name>Production and Sandbox</Name>
                                        <Description>This is a hybrid gateway that handles both production and sandbox token traffic.</Description>           
                                        <ServerURL>https://[API-Gateway-Host-or-IP]:9443/services/</ServerURL>
                                        <Username>${admin.username}</Username>
                                        <Password>${admin.password}</Password>          
                                        <GatewayEndpoint>http://[API-Gateway-Host]:8280,https://[API-Gateway-Host]:8243</GatewayEndpoint>
                                   </Environment>
                               </Environments>
                            </APIGateway>
            ```

        -   If you are using **multiple Gateway nodes** , configure the **Publisher** with the **Gateway nodes** as follows:

            -   [**Gateway with Shared File System**](#gateway-with-NFS-Publisher)
            -   [**Gateway with rsync**](#gateway-with-rsync-Publisher)

            Configure the **Publisher when working with multiple Gateways** that are fronted by a load balancer when using a **shared file system** (e.g., NFS), to synchronize the data between your Gateway nodes as follows:

            ``` xml
                            <APIGateway>
                               <Environments>
                                   <Environment type="hybrid" api-console="true">
                                        <Name>Production and Sandbox</Name>
                                        <Description>This is a hybrid gateway that handles both production and sandbox token traffic.</Description>           
                                        <ServerURL>https://[API-Gateway-LB-Host-or-IP]:9443/services/</ServerURL>
                                        <Username>${admin.username}</Username>
                                        <Password>${admin.password}</Password>          
                                        <GatewayEndpoint>http://[API-Gateway-LB-Host]:8280,https://[API-Gateway-LB-Host]:8243</GatewayEndpoint>
                                   </Environment>
                               </Environments>
                            </APIGateway>
            ```

            Configure the **Publisher with a multiple Gateways** that are fronted by a load balancer when using Remote Synchronization ( **rsync),** to synchronize the data between your Gateway nodes as follows:

            ``` xml
                            <APIGateway>
                               <Environments>
                                   <Environment type="hybrid" api-console="true">
                                        <Name>Production and Sandbox</Name>
                                        <Description>This is a hybrid gateway that handles both production and sandbox token traffic.</Description>           
                                        <ServerURL>https://[API-Gateway-Manager-Host-or-IP]:9443/services/</ServerURL>
                                        <Username>${admin.username}</Username>
                                        <Password>${admin.password}</Password>          
                                        <GatewayEndpoint>http://[API-Gateway-Manager-Host]:8280,https://[API-Gateway-Manager-Host]:8243</GatewayEndpoint>
                                   </Environment>
                               </Environments>
                            </APIGateway>
            ```

                !!! info
        To change the admin password, see [Changing the super admin password](https://docs.wso2.com/display/AM260/Maintaining+Logins+and+Passwords) . Furthermore, make sure to adhere to the note given under step 2 in the latter mentioned section if your password has special characters.


    4.  Configure the Store URL to appear in the Publisher UI.
        For this purpose you need to set the `<DisplayURL>` to `true` and provide the URL of the Store.

        -   [**Single Store**](#single-Store-Publisher)
        -   [**Store with HA**](#HA-Store-Publisher)

        Configure the **Publisher with a single API Store** as follows:

        **Example**

        ``` java
                <APIStore>  
                       <DisplayURL>true</DisplayURL>     
                       <URL>https://[Store-hostname]:9443/store</URL>
                </APIStore>
        ```

        Configure the **Publisher with multiple API Stores** that are fronted by a load balancer as follows:

        **Example**

        ``` java
                    <APIStore>  
                           <DisplayURL>true</DisplayURL>     
                           <URL>https://[Store-LB-hostname]:9443/store</URL>
                    </APIStore>
        ```

2.  Configure the blocked apps and API notifications to go to the Topic.
    Open the `<API-M_HOME>/repository/conf/jndi.properties` file and make the following changes.

        !!! note
    -   The following configuration is related to the Admin App in WSO2 API-M. In this guide it is assumed that the WSO2 API-M Admin App is configured in the Publisher node.

    -   If you change the default username (i.e., admin) and password (i.e., admin) in the `user-mgt.xml` file, that username and password should be changed at the broker connection URL as well.


    ``` xml
        connectionfactory.TopicConnectionFactory = amqp://admin:admin@clientid/carbon?brokerlist='tcp://[Traffic-Manager-host]:[Port-number]'
        topic.throttleData = throttleData
    ```

3.  Disable the Thrift Server to optimize performance.
    You need to configure this in the Publisher `<API-M_HOME>/repository/conf/api-manager.xml` file.

    ``` java
            <APIKeyValidator> 
            ...  
                <EnableThriftServer>false</EnableThriftServer>
            </APIKeyValidator>
    ```

4.  Optionally, configure High Availability (HA) for the Publisher.

        !!! warning
    These instructions are **ONLY applicable** if you need to configure **HA for the Publisher.**


    1.  Make a copy of the active Publisher instance configured above and use this copy as the second active Publisher instance.

    2.  Configure a load balancer to front the two Publisher nodes.
        For information on configuring the load balancer, see \_Configuring the Proxy Server and the Load Balancer .

5.  Start the WSO2 API-M Publisher node(s) by typing the following command in the command prompt.
    For more information on starting a WSO2 server, see [Starting the server](https://docs.wso2.com/display/AM260/Running+the+Product#RunningtheProduct-Startingtheserver) .

    The page: **\_Configuring a Single Node** was not found. Please check/update the page name used in the 'multiexcerpt-include macro.

#### Step 6.4 - Configure and start the API Store

This section involves setting up the API Store node and enabling it to work with the other components in the distributed deployment .

1.  Open the `<API-M_HOME>/repository/conf/api-manager.xml` file in the API Store node and make the following changes.

    1.  Configure the **API Store with the Key Manager.**

        -   [**Single Key Manager**](#single-Key-Manager-Store)
        -   [**Key Manager with HA**](#HA-Key-Manager-Store)

        Configure the **API Store with a single Key Manager** as follows:

        1.  Configure the API key validator.
            When you are connecting the API Store directly to the Key Manager, add `ThriftClient` for the `<KeyValidatorClientType>` element to use the Thrift protocol.

            ``` plain
                        <APIKeyValidator>
                            <ServerURL>https://[Key-Manager-host]:9443/services/</ServerURL>
                            <Username>${admin.username}</Username>
                            <Password>${admin.password}</Password>
                            <KeyValidatorClientType>ThriftClient</KeyValidatorClientType>    
                            <ThriftClientConnectionTimeOut>10000</ThriftClientConnectionTimeOut>
                            <!--ThriftClientPort>10397</ThriftClientPort-->
                         
                            <EnableThriftServer>true</EnableThriftServer>
                            <ThriftServerHost>[Key-Manager_host]</ThriftServerHost>
                            <!--ThriftServerPort>10397</ThriftServerPort-->
                            ...
                        </APIKeyValidator>
            ```

        2.  Configure the Authentication Manager, so that the API Store can connect to the Key Manager.
            You need to update the following configuration ONLY when you do not wish to share the user stores with the WSO2 API-M instance.

                        !!! warning
            This step is **not applicable** if you are **enabling Single Sign-on (SSO)** .


            ``` java
                        <AuthManager>
                            <ServerURL>https://[Key-Manager-host]:9443/services/</ServerURL>
                            <Username>${admin.username}</Username>
                            <Password>${admin.password}</Password>
                        </AuthManager>
            ```

        Configure the **Store with multiple Key Managers** that are fronted by a load balancer as follows:

        1.  Configure the API key validator.
            When you are using multiple Key Managers fronted by a load balancer, you need to add `WSClient` for the `<KeyValidatorClientType>` element to use the Web Service Client.

            ``` plain
                            <RevokeAPIURL>https://[Gateway-host]:8243/revoke</RevokeAPIURL>
                             
                            <APIKeyValidator>
                                <ServerURL>https://[Key-Manager-LB-host]:9443/services/</ServerURL>
                                <Username>${admin.username}</Username>
                                <Password>${admin.password}</Password>
                                <KeyValidatorClientType>WSClient</KeyValidatorClientType>    
                                <ThriftClientConnectionTimeOut>10000</ThriftClientConnectionTimeOut>
                                <!--ThriftClientPort>10397</ThriftClientPort-->
                             
                                <EnableThriftServer>false</EnableThriftServer>
                                <ThriftServerHost>localhost</ThriftServerHost>
                                <!--ThriftServerPort>10397</ThriftServerPort-->
                             
                                ...
                            </APIKeyValidator>
            ```

        2.  Configure the Authentication Manager, so that the API Store can connect to the Key Manager.
            You need to update the following configuration ONLY when you do not wish to share the user stores with the WSO2 API-M instance.

                        !!! warning
            This step is **not applicable** if you are **enabling Single Sign-on (SSO)** .


            ``` java
                        <AuthManager>
                            <ServerURL>https://[Key-Manager-LB-host]:9443/services/</ServerURL>
                            <Username>${admin.username}</Username>
                            <Password>${admin.password}</Password>
                        </AuthManager>
            ```

    2.  Make the following throttling related changes that correspond to the Traffic Manager.

        ``` xml
                    <ThrottlingConfigurations>
                            <EnableAdvanceThrottling>true</EnableAdvanceThrottling>
                            <DataPublisher>
                                <Enabled>false</Enabled>
                            ……………………
                            </DataPublisher> 
                            …………………
                            <BlockCondition>
                                <Enabled>false</Enabled>
                            ………………………
                            </BlockCondition>
                            <JMSConnectionDetails>
                                <Enabled>false</Enabled>
                             …………………………………
                            </JMSConnectionDetails>
                         ………………………………
                    </ThrottlingConfigurations>
        ```

    3.  Configure the **Store with** the **Gateway** .

        -   If you are using a single Gateway node, configure the **Store** with the **Gateway** as follows:

            ``` java
                            <APIGateway>
                                <Environments>
                                    <Environment type="hybrid">
                                    ...
                                        <ServerURL>https://[API-Gateway-host-or-IP]:9443/services/</ServerURL>
                                        <Username>${admin.username}</Username>
                                        <Password>${admin.password}</Password> 
                                        <GatewayEndpoint>http://[API-Gateway-host]:8280,https://[API-Gateway-host]:8243</GatewayEndpoint>
                                    </Environment>
                                </Environments> 
                            ...
                            </APIGateway>
            ```

        -   If you are using **multiple Gateway nodes** , configure the **Store** with the **Gateway nodes** as follows:

            -   [**Gateway with Shared File System**](#gateway-with-NFS-Store)
            -   [**Gateway with rsync**](#gateway-with-rsync-Store)

            Configure the **Store when working with multiple Gateways** that are fronted by a load balancer, and when using a **shared file system** (e.g., NFS), to synchronize the data between your Gateway nodes as follows:

            ``` java
                            <APIGateway>
                                <Environments>
                                    <Environment type="hybrid">
                                    ...
                                        <ServerURL>https://[API-Gateway-LB-Host-or-IP]:9443/services/</ServerURL>
                                        <Username>${admin.username}</Username>
                                        <Password>${admin.password}</Password> 
                                        <GatewayEndpoint>http://[API-Gateway-LB-Host]:8280,https://[API-Gateway-LB-Host]:8243</GatewayEndpoint>
                                    </Environment>
                                </Environments> 
                            ...
                            </APIGateway>
            ```

            Configure the **Store with multiple Gateways** that are fronted by a load balancer, and when using Remote Synchronization ( **rsync),** to synchronize the data between your Gateway nodes as follows:

            ``` java
                            <APIGateway>
                                <Environments>
                                    <Environment type="hybrid">
                                    ...
                                        <ServerURL>https://[API-Gateway-Manager-host]:9443/services/</ServerURL>
                                        <Username>${admin.username}</Username>
                                        <Password>${admin.password}</Password> 
                                        <GatewayEndpoint>http://[API-Gateway-Manager-host]:8280,https://[API-Gateway-Manager-host]:8243</GatewayEndpoint>
                                    </Environment>
                                </Environments> 
                            ...
                            </APIGateway>
            ```

    4.  Configure the Token Revoke endpoint to point to Gateway.

        -   [**Single Gateway**](#tokenRevoke-GW)
        -   [**Gateway with HA**](#tokenRevoke-2GW)

        Configure the **Token Revoke endpoint with a single Gateway** as follows:

        ``` java
                    <OAuthConfigurations>
                        ...
                        <RevokeAPIURL>https://[API-Gateway-host]:8243/revoke</RevokeAPIURL>
                    </OAuthConfigurations>
        ```

        Configure the **Token Revoke endpoint with multiple Gateways** , which are fronted by a load balancer as follows:

        ``` java
                    <OAuthConfigurations>
                        ...
                        <RevokeAPIURL>https://[API-Gateway-Worker-LB-host]:8243/revoke</RevokeAPIURL>
                    </OAuthConfigurations>
        ```

2.  Disable the Thrift Server to optimize performance.
    You need to configure this in the Store `<API-M_HOME>/repository/conf/api-manager.xml` file.

    ``` java
            <APIKeyValidator> 
            ...  
                <EnableThriftServer>false</EnableThriftServer>
            </APIKeyValidator>
    ```

3.  Optionally, configure High Availability (HA) for the Store.

        !!! warning
    This is **ONLY applicable** if you need to configure **HA for the Store.**


    Make a copy of the active instance configured above and use this copy as the second API Store active instance.

4.  Start the API Store node(s) by typing the following command in the command prompt. For more information on starting a WSO2 server, see [Starting the server](https://docs.wso2.com/display/AM260/Running+the+Product#RunningtheProduct-Startingtheserver) .

    The page: **\_Configuring a Single Node** was not found. Please check/update the page name used in the 'multiexcerpt-include macro.

#### Step 6.5 - Configure and start the Traffic Manager

This section involves setting up the Traffic Manager node(s) and enabling it to work with the other components in a distributed deployment.

1.  Delete the `<API-M_HOME>/repository/conf/registry.xml` file and rename the `<API-M_HOME>/repository/conf/registry_TM.xml` file as the `registry.xml` file.
    To disable registry indexing when setting up the Traffic Manager, see [Registry indexing configurations](https://docs.wso2.com/display/AM260/Tuning+Performance#TuningPerformance-Registryindexingconfigurations) . ``

2.  Delete the `<API-M_HOME>/repository/conf/axis2/axis2.xml` file and rename the `<API-M_HOME>/repository/conf/axis2/axis2_TM.xml` file as the `axis2.xml` file .

        !!! note
    Note that all the jaggery apps and webapps in the `<API-M_HOME>/repository/deployment/server/` directory are removed when you optimize the profile. For more details, see [Product Profiles](https://docs.wso2.com/display/AM260/Product+Profiles) .


3.  **Optionally** , mount the `<API-M_HOME>/repository/deployment/server` directory of all the Traffic Manager nodes to the shared file system.

        !!! warning
    This step is **ONLY applicable** if you are configuring the **Traffic Manager with HA** and **shared file system** as the content synchronization mechanism.


    You need to do this to share all the Throttling policies between traffic management nodes.

4.  Disable the Thrift Server to optimize performance.
    You need to configure this in the Traffic Manager `<API-M_HOME>/repository/conf/api-manager.xml` file.

    ``` java
        <APIKeyValidator> 
        ...  
            <EnableThriftServer>false</EnableThriftServer>
        </APIKeyValidator>
    ```

5.  Optionally, configure High Availability (HA) for the Traffic Manager.

        !!! warning
    This is **ONLY applicable** if you need to configure **HA for the Traffic Manager.**


    Make a copy of the active instance configured above and use this copy as the second active Traffic Manager instance.

6.  Start the WSO2 API-M Traffic Manager node(s) by typing the following command in the command prompt. For more information on starting a WSO2 server, see [Starting the server](https://docs.wso2.com/display/AM260/Running+the+Product#RunningtheProduct-Startingtheserver) .

    -   [**Linux/Mac OS**](#Linux-Mac)
    -   [**Windows**](#windows)

    ``` java
        cd <API-M_HOME>/bin/
        sh wso2server.sh -Dprofile=traffic-manager
    ```

    ``` java
            cd <API-M_HOME>\bin\
            wso2server.bat --run -Dprofile=traffic-manager
    ```

        !!! note
    Always start the Traffic Manager using the `-Dprofile=traffic-manager` profile **** to avoid FATAL errors such as the following.

    ``` java
        FATAL - ServiceBusInitializer Couldn't initialize the ESB...
        org.apache.synapse.SynapseException: The synapse.xml location ././
                ./repository/deployment/server/synapse-configs
            /default doesn't exist
    ```


!!! note
Troubleshooting
If you have a firewall between the Traffic Manager and the Gateway, you need to configure the heartbeat value to keep the JMS connection alive. To configure this, open the `<APIM_HOME>/repository/conf/advanced/qpid-config.xml` file and set the heartbeat to a non-zero value as shown below.

``` java
    <heartbeat>    
        <delay>60</delay>
        <timeoutFactor>2.0</timeoutFactor>
    </heartbeat>
```


#### Step 6.6 - Configure and start the Gateway

This section involves setting up the Gateway node and enabling it to work with the other components in the distributed deployment .

!!! note
**Steps 1 to 5** in the following section are **common** irrespective of your API-M deployment, such as deploying a single Gateway node or deploying multiple Gateway nodes for High Availability (HA). However, if you are using two Gateway nodes for high availability (HA), first follow the instructions that is available in the \_Distributed Deployment of the Gateway document, and then carry out the following steps to configure the connections from Gateway(s) to other components.
1.  Open the `<API-M_HOME>/repository/conf/api-manager.xml` file in the Gateway node.
2.  Modify the `api-manager.xml` file as follows. This configures the connection to the Key Manager component.

    -   [**Single Key Manager**](#single-Key-Manager-GW)
    -   [**Key Managers with HA**](#HA-Key-Manager-GW)

    Configure the **Gateway with a single Key Manager** as follows:

    1.  Configure the API Key Validator.

        ``` plain
                <APIKeyValidator> 
                  <ServerURL>https://[Key-Manager-host]:9443/services/</ServerURL>
                  <Username>${admin.username}</Username>
                  <Password>${admin.password}</Password>
                  ...
                  <ThriftServerHost>[Key-Manager-host]</ThriftServerHost>
                  ...
                </APIKeyValidator>
        ```

`[Key-Manager-host]` - If you have a single Key Manager node, this should be the host of the Key Manager (i.e., the host of the WSO2 Identity Server).

                !!! note
        To change the admin password, see [Changing the super admin password](https://docs.wso2.com/display/AM260/Maintaining+Logins+and+Passwords) . If your password has special characters, follow the guidelines mentioned as a note under step 2 in the latter mentioned section.


    2.  Use `ThriftClient` as the `KeyValidatorClientType` in the `<API-M_HOME>/repository/conf/api-manager.xml` file.

                !!! note
        You can only use the Thrift protocol when the Key Manager cluster is NOT fronted by a load balancer.


        ``` plain
                <KeyValidatorClientType>ThriftClient</KeyValidatorClientType>
        ```

    3.  Disable the Thrift Server to optimize performance.
        You need to configure this in the Gateway `<API-M_HOME>/repository/conf/api-manager.xml` file

        ``` java
                    <APIKeyValidator> 
                    ...  
                        <EnableThriftServer>false</EnableThriftServer>
                    </APIKeyValidator>
        ```

    4.  Uncomment `ThriftClientPort` element if its commented out and set the Thrift Client port in the Gateway to the same port as the Thrift Server port, which you defined in the Key Manager.
        This enables the Gateway to communicate with the Key Manager.

                !!! note
        Do this step **only if** one of the following scenarios are applicable to your set up .

        -   You started or you plan on starting the Key Manager or Gateway with a port offset.

        -   Your Thrift Server port in the Key Manager differs from the default value, which is 10397.


        ``` java
                <ThriftClientPort>[port]</ThriftClientPort>
        ```

    5.  Specify the hostname or IP of the Key Manager.
        The default is `localhost` . In a distributed deployment you must set this parameter in both Key Manager nodes and Gateway nodes **only** if the Key Manager is running on a separate machine. Gateway uses this parameter to connect to the key validation Thrift service.

        ``` java
                    <ThriftServerHost>[Key-Manager-host]</ThriftServerHost>
        ```

                !!! info
        The parameter `ThriftClientConnectionTimeOut` **** is used to specify the client side time-out when connecting to Thrift Key Validation Service in Key Manager. The default value is 10000 milliseconds , which is sufficient for most cases.


    Configure the **Gateway with multiple Key Managers** , which are fronted by a load balancer as follows:

    1.  Configure the `APIKeyValidator` as follows:

        ``` plain
                <APIKeyValidator> 
                  <ServerURL>https://[Key-Manager-LB-host]:9443/services/</ServerURL>
                  <Username>${admin.username}</Username>
                  <Password>${admin.password}</Password>
                  ...
                </APIKeyValidator>
        ```

        -`[Key-Manager-LB-host]` - If there are multiple Key Managers (i.e., Multiple WSO2 Identity Servers as the Key Manager) fronted by a load balancer, this should be the host of the Key Manager's load balancer. For example, in the configuration we have defined `key-manager` as the load balancer host in the Key Manager section.

                !!! note
        To change the admin password, see [Changing the super admin password](https://docs.wso2.com/display/AM260/Maintaining+Logins+and+Passwords) . If your password has special characters, follow the guidelines mentioned as a note under step 2 in the latter mentioned section.


    2.  Use `WSClient` as `KeyValidatorClientType` in the `<API-M_HOME>/repository/conf/api-manager.xml` file.
        Note that you can only use the Web Service Client when the Key Manager cluster is fronted by a load balancer.

        ``` plain
                <KeyValidatorClientType>WSClient</KeyValidatorClientType>
        ```

    3.  Ensure that Thrift is disabled in the Gateway.
        This is enabled by default in all instances of the product, so you need to disable the Thrift server by setting `EnableThriftServer` to false in the `<API-M_HOME>/repository/conf/api-manager.xml` file of each node.

        ``` plain
                    <EnableThriftServer>false</EnableThriftServer>
        ```

3.  If you need to enable JSON Web Token (JWT),  you have to enable it in all Gateway and Key Manager components.
    For more information on configuring JWT, see [Generating JSON Web Token](https://docs.wso2.com/display/AM260/Passing+Enduser+Attributes+to+the+Backend+Using+JWT) .

4.  Configure the Gateway to communicate with the Traffic Manager.
    You need to do this to enable Throttling for the Traffic Manager node(s).

        !!! warning
    These configurations vary based on whether you have a single Traffic Manager node or multiple Traffic Manager nodes.


    -   [**Single Traffic Manager**](#single-TM-GW)
    -   [**HA of Traffic Manager**](#TM-HA-GW)

    Configure the **Gateway with a single Traffic Manager** as follows:

        !!! info
        9611 and 9711 are the Traffic Manager receiver ports for the binary type.
    1.  Update the Throttling configurations as follows:

        ``` xml
                <ThrottlingConfigurations>
                        <EnableAdvanceThrottling>true</EnableAdvanceThrottling>
                        <DataPublisher>
                            <Enabled>true</Enabled>
                            <Type>Binary</Type>
                            <ReceiverUrlGroup>tcp://[Traffic-Manager-host]:9611</ReceiverUrlGroup>
                            <AuthUrlGroup>ssl://[Traffic-Manager-host]:9711</AuthUrlGroup>
                        ……………………
                        </DataPublisher>
                        <PolicyDeployer>
                            <Enabled>false</Enabled>
                            <ServiceURL>https://[Traffic-Manager-host]:9443/services/</ServiceURL>
                        ………………
                        </PolicyDeployer>
                        ………………
                        <JMSConnectionDetails>
                            <Enabled>true</Enabled>
                            <ServiceURL>tcp://[Traffic-Manager-host]:5672</ServiceURL>
                        …………
                        </JMSConnectionDetails>
                </ThrottlingConfigurations>
        ```

                !!! warning
        In the Gateway profile of WSO2 API Manager, disable the `<PolicyDeployer>` configuration to prevent blocking the API Publisher.


    2.  Configure `JMSConnectionParameters` to connect to the broker running within the Traffic Manager.

        **Example**

        ``` java
                <JMSConnectionParameters>
                   <transport.jms.ConnectionFactoryJNDIName>TopicConnectionFactory</transport.jms.ConnectionFactoryJNDIName>
                   <transport.jms.DestinationType>topic</transport.jms.DestinationType>
                   <java.naming.factory.initial>org.wso2.andes.jndi.PropertiesFileInitialContextFactory</java.naming.factory.initial>
                   <connectionfactory.TopicConnectionFactory>amqp://admin:admin@clientID/carbon?brokerlist='tcp://<Traffic-Manager-host>:<Port-number>?retries='5'%26connectdelay='50'</connectionfactory.TopicConnectionFactory>
                </JMSConnectionParameters>
        ```

    Configure the **Gateway with multiple Traffic Managers** , which are fronted by a load balancer as follows:
    The Gateway publishes all Throttling events to the two Traffic Manager instances, and it fetches the throttle decisions from the Traffic Manager instances. Follow the instructions below to configure the API Gateway worker to communicate with the Traffic Managers and to push throttle events to both Traffic Manager instances.

    1.  Configure the receiver URL group `<ReceiverUrlGroup>` and Authentication URL Group `<AuthUrlGroup>` values, which are under the `<DataPublisher>` element in the `<API-M_HOME>/repository/conf/api-manager.xml` file, in order to contain all the Traffic Manager receiver URLs.
        This is required when you have more than one Traffic Manager instance, and you are publishing to both as per the deployment pattern selected. As an example, if you are using two Traffic Manager instances and data should be published to both of them, the `ReceiverUrlGroup` and `AuthUrlGroup` should be configured as follows:

        **Example**

        ``` java
                    <ThrottlingConfigurations>
                       <EnableAdvanceThrottling>true</EnableAdvanceThrottling>
                       <DataPublisher>
                          <Enabled>true</Enabled>
                          <Type>Binary</Type>
                          <ReceiverUrlGroup>{tcp://[Traffic-Manager-1-host]:9611}, {tcp://[Traffic-Manager-2-host]:9611}</ReceiverUrlGroup>
                          <!--ReceiverUrlGroup>tcp://${carbon.local.ip}:9612</ReceiverUrlGroup-->
                          <AuthUrlGroup>{ssl://[Traffic-Manager-1-host]:9711}, {ssl://[Traffic-Manager-2-host]:9711}</AuthUrlGroup>
                          <!--AuthUrlGroup>ssl://${carbon.local.ip}:9712</AuthUrlGroup-->
                          <Username>${admin.username}</Username>
                          <Password>${admin.password}</Password>
                          <DataPublisherPool>
                             <MaxIdle>1000</MaxIdle>
                             <InitIdleCapacity>200</InitIdleCapacity>
                          </DataPublisherPool>
                          <DataPublisherThreadPool>
                             <CorePoolSize>200</CorePoolSize>
                             <MaxmimumPoolSize>1000</MaxmimumPoolSize>
                             <KeepAliveTime>200</KeepAliveTime>
                          </DataPublisherThreadPool>
                       </DataPublisher>
                    ...
                    </ThrottlingConfigurations>
        ```

`[Traffic-Manager-1-host]` and \[ `Traffic-Manager-2-host]` are the IPs/hostnames of two Traffic Manager nodes.

        Based on the above configuration, the API Gateway publishes events to both the Traffic Managers.

    2.  Configure `JMSConnectionParameters` to connect to multiple brokers running within each Traffic Manager using fail over mechanism.

        **Example**

        ``` java
                    <JMSConnectionParameters>
                       <transport.jms.ConnectionFactoryJNDIName>TopicConnectionFactory</transport.jms.ConnectionFactoryJNDIName>
                       <transport.jms.DestinationType>topic</transport.jms.DestinationType>
                       <java.naming.factory.initial>org.wso2.andes.jndi.PropertiesFileInitialContextFactory</java.naming.factory.initial>
                       <connectionfactory.TopicConnectionFactory>amqp://admin:admin@clientID/carbon?failover='roundrobin'%26cyclecount='2'%26brokerlist='tcp://[Traffic-Manager-1-host]:<Port-number>?retries='5'%26connectdelay='50';tcp://[Traffic-Manager-2-host]:<Port-number>?retries='5'%26connectdelay='50''</connectionfactory.TopicConnectionFactory>
                    </JMSConnectionParameters>
        ```

        !!! info
    By default, WSO2 API Manager is shipped with a keystore ( `wso2carbon.jks` ) and a trust store ( `client-truststore.jks` ). For more information on how to create a new key store and a trust store with a private key and a self-signed certificate, see Configuring Keystore and Truststore and also see the [Administration guide](https://docs.wso2.com/display/ADMIN44x/Using+Asymmetric+Encryption#UsingAsymmetricEncryption-RecommendationsforsettingupkeystoresinWSO2products) for r ecommendations on setting up keystores in WSO2 products.


5.  Start the WSO2 API-M Gateway node by typing the following command in the command prompt. For more information on starting a WSO2 server, see [Starting the server](https://docs.wso2.com/display/AM260/Running+the+Product#RunningtheProduct-Startingtheserver) .

    The page: **\_Configuring a Single Node** was not found. Please check/update the page name used in the 'multiexcerpt-include macro.


