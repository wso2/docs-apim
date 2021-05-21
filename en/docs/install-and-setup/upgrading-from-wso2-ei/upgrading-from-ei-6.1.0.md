# Migrating from WSO2 EI 6.1.0 to WSO2 API-M 4.0.0

This guide provides the recommended strategy for upgrading from the ESB profile of WSO2 EI 6.1.0 to the Micro Integrator of WSO2 API-M 4.0.0.

{!includes/integration/pull-content-migration-esb-mi.md!}

## Migrating to the Micro Integrator

Follow the instructions below to start the migration!

### Set up the migration

-   Make a backup of the EI 6.1.0 distribution (`<EI_HOME>` folder) to back up the product configurations.
-   Make a backup of the database used by the current EI 6.1.0 deployment. This backup is necessary in case the migration causes any issues in the existing database.
-   [Download and install]({{base_path}}/install-and-setup/install/installing-the-product/installing-mi) the latest Micro Integrator in your environment:

    !!! Tip
        The home directory of your Micro Integrator will be referred to as `<MI_HOME>` from hereon.

-   Use [WSO2 Update Manager](https://updates.docs.wso2.com/en/latest/updates/overview/) to get the latest available updates for your Micro Integrator distribution.

    !!! Info
        Note that you need a valid [WSO2 subscription](https://wso2.com/subscription) to use updates in a production environment.

### Migrating the user store

!!! info "Before you begin"
    Read about [users and roles in the Micro Integrator]({{base_path}}/install-and-setup/setup/mi-setup/user_stores/managing_users) and about how they function. Note the following important facts:

    - Users in the Micro Intgrator are categorized as <b>admin</b> users and <b>non-admin</b> users.
    - All admin users in your existing EI 6.1.0 user store will function as admin users in the Micro integrator.
    - Tenant admins are no longer valid because the Micro Integrator does not support multitenancy.
    - **Secondary** user stores are currently not supported in the Micro Integrator.

If you are using an **LDAP user store** with EI 6.1.0, you can simply connect the same to the Micro Integrator of API-M 4.0.0 by updating the configuration details in the Micro Integrator's `deployment.toml` file. 

If you are using a **JDBC user store** with EI 6.1.0, you need to first update the database before connecting the same to APIM 4.0.0.

Follow the steps given below.

#### Step 1 - Update the database structure

This step is applicable only if your user store is JDBC. 

There are changes in the database structure (schema) that is used in EI 6.1.0. To update the database schema:

1. Download the [database migration scripts]({{base_path}}/assets/attachments/migration/micro-integrator/migration-scripts-ei6.1.0-to-apim4.0.0.zip).

2. Unzip the downloaded file and select the script relevant to your database type.

3. Connect to the database and run the script.

Your database schema is now updated for APIM 4.0.0. Now you can update the configuration details in the Micro Integrator's `deployment.toml` file.

#### Step 2 - Connect to the user store

To connect the Micro Integrator of API-M 4.0.0 to the primary user store:

1.  Open the `deployment.toml` file of your Micro Integrator.
2.  Note that you have the `[user_store]` section enabled by default.

    ```toml
    [user_store]
    type = "read_only_ldap"
    ```

3.  See the instructions in the following sections:

    -   [Configuring an LDAP user store]({{base_path}}/install-and-setup/setup/mi-setup/user_stores/setting_up_a_userstore/#configuring-an-ldap-user-store) for the Micro Integrator in API-M 4.0.0.
    -   [Configuring an RDBMS user store]({{base_path}}/install-and-setup/setup/mi-setup/user_stores/setting_up_a_userstore/#configuring-an-rdbms-user-store) for the Micro Integrator in API-M 4.0.0.  

4.  If your user store is an RDBMS, be sure to add the client JAR of your RDBMS to the `<MI_HOME>/lib` folder.

See the instructions on [configuring a user store]({{base_path}}/install-and-setup/setup/mi-setup/user_stores/setting_up_a_userstore) for more information.

### Migrating the registry

{!includes/integration/pull-content-registry-migration.md!}

### Migrating deployed Connectors

- If the connector is added to EI 6.1.0 via a composite application with the [Connector Exporter Project]({{base_path}}/integrate/develop/creating-artifacts/adding-connectors), the same can be used in the Micro Integrator seamlessly. Simply copy the CAR file in EI 6.1.0 to the `<MI_HOME>/repository/deployment/server/carbonapps` folder.
- If the connector is added to EI 6.1.0 via the management console, pack them using the [Connector Exporter Project]({{base_path}}/integrate/develop/creating-artifacts/adding-connectors) and deploy via a composite application in the Micro Integrator.

### Migrating custom components

Copy custom OSGI components in the `<EI_HOME>/dropins` folder to the `<MI_HOME>/dropins` folder. If you have custom JARs in the `<EI_HOME>/lib` directory, copy those components to the `<MI_HOME>/lib` folder.

!!! Note
    -   To provide seamless integration with RabbitMQ, the Rabbitmq client lib is included in the Micro Integrator by default. Hence, you don't need to manually add any RabbitMQ components.
    -   The Micro Integrator no longer contains the VFS/SMB provider by default. If you need to use the <b>VFS SMB</b> feature, download `jcifs-1.3.17.jar` and add it to the `<MI_HOME/lib` folder. Since this library is licensed under LGPL version 2.1, you have to comply with the [terms of LGPL version 2.1](https://www.gnu.org/licenses/old-licenses/lgpl-2.1.en.html) and its restrictions.
    -   If you used an <b>HL7 Message Store</b> (custom message store) implementation, note that the Micro Integrator does not support this functionality. See the list of [removed features]({{base_path}}/get-started/about-this-release/#features-removed) for details.

### Migrating tenants

Multitenancy within one JVM is not supported in the Micro Integrator. Therefore, if you used multiple tenants in your EI 6.1.0 deployment, you can replicate the setup by using separate Micro Integrator nodes.

### Migrating keystores

Copy the JKS files from the `<EI_HOME>/repository/resources/security` folder to the `<MI_HOME>/repository/resources/security` folder.

### Migrating configurations

!!! info "Before you begin"
    Note the following:

    -   Configuration management was handled in EI 6.1.0 via multiple files such as `carbon.xml`, `synapse.properties`, and `axis2.xml`.
    -   The Micro Integrator uses a new configuration model where most of the product configurations are managed by a single configuration file named `deployment.toml` (stored in the `<MI_HOME>/conf` directory).
    -   Log configurations are managed with log4j2, which are configured in the `log4j2.properties` file. Prior to EI 6.6.0, all ESB versions use log4j instead of log4j2.

The following sections of this document will guide you to migrate the product configurations including log4j.

#### Migrating to TOML configurations

!!! Tip
     If you have a [WSO2 subscription](https://wso2.com/subscription), it is highly recommended to contact WSO2 Support before attempting to proceed with the configuration migration.

Given below are the main configurations that have changed in the Micro integrator. Expand the sections to find the TOML configurations corresponding to the XML configurations.

??? note "Clustering configurations"

    In the Micro Integrator, you don't need to enable clustering as you did with previous EI versions. Instead, you need to configure all nodes in the cluster to coordinate through an RDBMS. Find out more about [cluster coordination]({{base_path}}/install-and-setup/setup/mi-setup/deployment/deploying_wso2_ei/#cluster-coordination).

    ```xml tab='XML configuration'
    <clustering class="org.wso2.carbon.core.clustering.hazelcast.HazelcastClusteringAgent"
                    enable="true">
    <parameter name="clusteringPattern">nonWorkerManager</parameter>
    </clustering>
    ```

    ```toml tab='TOML configuration'
    # Cluster coordination database connection.
    [[datasource]]
    id = "WSO2_COORDINATION_DB"
    url= "jdbc:mysql://localhost:3306/clusterdb"
    username="root"
    password="root"
    driver="com.mysql.jdbc.Driver"

    # Identifying nodes in the cluster.
    [cluster_config]
    node_id = "node-1"
    ```

    Find more [parameters]({{base_path}}/install-and-setup/setup/mi-setup/deployment/deploying_wso2_ei).

??? note "Analytics configurations"

    If you used EI Analytics with your ESB profile, you have configured the following to be able to publish statistics to the Analytics server.

    -   `<EI_HOME>/repository/deployment/server/eventpublishers/MessageFlowConfigurationPublisher.xml`
    -   `<EI_HOME>/repository/deployment/server/eventpublishers/MessageFlowStatisticsPublisher.xml`

    If you are using EI Analytics with your new Micro Integrator solution, you can follow the instructions in [Setting up the EI Analytics Profile for Observability]({{base_path}}/install-and-setup/setup/mi-setup/observability/setting-up-classic-observability-deployment).

Given below are some of the most critical XML configuraton files in the ESB profile of EI 6.1.0. Expand each section to find the TOML configurations corresponding to the XML configurations in the file.

??? note "carbon.xml"

    -   Hostname

        ```xml tab='XML configuration'
        <HostName>www.wso2.org</HostName>
        ```

        ```toml tab='TOML configuration'
        [server]
        hostname = "www.wso2.org"
        ```

        Find more [parameters]({{base_path}}/reference/config-catalog-mi/#deployment).

    -   Port offset

        ```xml tab='XML configuration'
        <Ports>
            <Offset>1</Offset>
        </Ports>
        ```

        ```toml tab='TOML configuration'
        [server]
        offset  = 0
        ```

        Find more [parameters]({{base_path}}/reference/config-catalog-mi/#deployment).


    -   Primary keystore

        ```xml tab='XML configuration'
        <Security>
            <KeyStore>            
                <Location>${carbon.home}/repository/resources/security/wso2carbon.jks</Location>
                <Type>JKS</Type>
                <Password>wso2carbon</Password>
                <KeyAlias>wso2carbon</KeyAlias>
                <KeyPassword>wso2carbon</KeyPassword>
            </KeyStore>
        </Security>
        ```

        ```toml tab='TOML configuration'
        [keystore.primary]
        file_name = "wso2carbon.jks"
        type = "JKS"
        password = "wso2carbon"
        alias = "wso2carbon"
        key_password = "wso2carbon"
        ```

        Find more [parameters]({{base_path}}/reference/config-catalog-mi/#primary-keystore).

    -   Internal keystore

        ```xml tab='XML configuration'
        <InternalKeyStore>
             <Location>${carbon.home}/repository/resources/security/wso2carbon.jks</Location>
                <Type>JKS</Type>
                <Password>wso2carbon</Password>
                <KeyAlias>wso2carbon</KeyAlias>
               <KeyPassword>wso2carbon</KeyPassword>
        </InternalKeyStore>
        ```

        ```toml tab='TOML configuration'
        [keystore.internal]
        file_name = "wso2carbon.jks"
        type = "JKS"
        password = "wso2carbon"
        alias = "wso2carbon"
        key_password = "wso2carbon"
        ```

        Find more [parameters]({{base_path}}/reference/config-catalog-mi/#internal-keystore).

    -   Truststore

        ```xml tab='XML configuration'
        <TrustStore>
            <Location>${carbon.home}/repository/resources/security/client-truststore.jks</Location>
            <Type>JKS</Type>
            <Password>wso2carbon</Password>
        </TrustStore>
        ```

        ```toml tab='TOML configuration'
        [truststore]
        file_name = "client-truststore.jks"  
        type = "JKS"                        
        password = "wso2carbon"            
        alias = "symmetric.key.value"      
        algorithm = "AES"
        ```

        Find more [parameters]({{base_path}}/reference/config-catalog-mi/#trust-store).


??? note "user-mgt.xml"

    -   Admin user

        ```xml tab='XML configuration'
        <Realm>
            <Configuration>
                <AdminRole>admin</AdminRole>
                <AdminUser>                
                    <UserName>admin</UserName>                
                    <Password>admin</Password>
                </AdminUser>
            </Configuration>
        </Realm>
        ```

        ```toml tab='TOML configuration'
        [super_admin]
        username = "admin"              # inferred
        password = "admin"              # inferred
        admin_role = "admin"            # inferred
        ```

    -   User datasource

        ```xml tab='XML configuration'
        <Realm>
            <Configuration>
                 <Property name="isCascadeDeleteEnabled">true</Property>
                 <Property name="dataSource">jdbc/WSO2CarbonDB</Property>
            </Configuration>
        </Realm>
        ```

        ```toml tab='TOML configuration'
        [realm_manager]
        data_source = "WSO2CarbonDB"       
        properties.isCascadeDeleteEnabled = true   
        ```

    -   LDAP userstore

        ```xml tab='XML configuration'
        <UserStoreManager class="org.wso2.carbon.user.core.ldap.ReadOnlyLDAPUserStoreManager">
            <Property name="TenantManager">org.wso2.carbon.user.core.tenant.CommonHybridLDAPTenantManager</Property>
            <Property name="ConnectionURL">ldap://localhost:10389</Property>
            <Property name="ConnectionName">uid=admin,ou=system</Property>
        </UserStoreManager>
        ```

        ```toml tab='TOML configuration'
        [internal_apis.file_user_store]
        enable = false

        [user_store]
        type = "read_only_ldap" # inferred default read_only_ldap # OR  read_write_ldap
        class = "org.wso2.micro.integrator.security.user.core.ldap.ReadOnlyLDAPUserStoreManager" # inferred
        connection_url = "ldap://localhost:10389"   #inferred
        connection_name = "uid=admin,ou=system"   #inferred
        ```

        Find more [parameters]({{base_path}}/reference/config-catalog-mi/#ldap-user-store).

    -   JDBC userstore

        ```xml tab='XML configuration'
         <UserStoreManager class="org.wso2.carbon.user.core.jdbc.JDBCUserStoreManager">
            <Property name="TenantManager">org.wso2.carbon.user.core.tenant.JDBCTenantManager</Property>
         </UserStoreManager>
        ```

        ```toml tab='TOML configuration'
        [internal_apis.file_user_store]
        enable = false

        [user_store]
        class = "org.wso2.micro.integrator.security.user.core.jdbc.JDBCUserStoreManager"
        type = "database"
        ```

??? note "master-datasource.xml"

    Carbon database (`WSO2_CARBON_DB`).

    ```xml tab='XML configuration'
    <datasource>
        <name>WSO2_CARBON_DB</name>
        <description>The datasource used for registry and user manager</description>
        <jndiConfig>
            <name>jdbc/WSO2CarbonDB</name>
        </jndiConfig>
        <definition type="RDBMS">
            <configuration>
                <url>jdbc:h2:./repository/database/WSO2CARBON_DB;DB_CLOSE_ON_EXIT=FALSE;LOCK_TIMEOUT=60000</url>
                <username>wso2carbon</username>
                <password>wso2carbon</password>
                <driverClassName>org.h2.Driver</driverClassName>
                <maxActive>50</maxActive>
                <maxWait>60000</maxWait>
                <testOnBorrow>true</testOnBorrow>
            </configuration>
        </definition>
    </datasource>
    ```

    ```toml tab='TOML configuration'
    [[datasource]]
    id = "WSO2_CARBON_DB"
    url= "jdbc:h2:./repository/database/WSO2CARBON_DB;DB_CLOSE_ON_EXIT=FALSE;LOCK_TIMEOUT=60000"
    username="username"
    password="password"
    driver="org.h2.Driver"
    pool_options.maxActive=50
    pool_options.maxWait = 60000 # wait in milliseconds
    pool_options.testOnBorrow = true
    ```

    Find more [parameters]({{base_path}}/reference/config-catalog-mi/#database-connection).


??? note "axis2.xml"

    -   Hot deployment

        ```xml tab='XML configuration'
        <parameter name="hotdeployment" locked="false">true</parameter>
        ```

        ```toml tab='TOML configuration'
        [server]
        hot_deployment = true
        ```

    -   Enable MTOM

        ```xml tab='XML configuration'
        <parameter name="enableMTOM" locked="false">false</parameter>
        ```

        ```toml tab='TOML configuration'
        [server]
        enable_mtom = false
        ```

        Find more [parameters]({{base_path}}/reference/config-catalog-mi/#deployment).

    -   Enable SWA

        ```xml tab='XML configuration'
        <parameter name="enableSwA" locked="false">false</parameter>
        ```

        ```toml tab='TOML configuration'
        [server]
        enable_swa = false
        ```

        Find more [parameters]({{base_path}}/reference/config-catalog-mi/#deployment).

    -   Message formatters

        ```xml tab='XML configuration'
        <messageFormatters>
                <messageFormatter contentType="application/x-www-form-urlencoded"
                                  class="org.apache.synapse.commons.formatters.XFormURLEncodedFormatter"/>
                <messageFormatter contentType="multipart/form-data"
                                  class="org.apache.axis2.transport.http.MultipartFormDataFormatter"/>
                <messageFormatter contentType="application/xml"
                                  class="org.apache.axis2.transport.http.ApplicationXMLFormatter"/>
                <messageFormatter contentType="text/xml"
                                 class="org.apache.axis2.transport.http.SOAPMessageFormatter"/>
                <messageFormatter contentType="application/soap+xml"
                                 class="org.apache.axis2.transport.http.SOAPMessageFormatter"/>
                <messageFormatter contentType="text/plain"
                                 class="org.apache.axis2.format.PlainTextFormatter"/>
                <messageFormatter contentType="application/octet-stream"
                                  class="org.wso2.carbon.relay.ExpandingMessageFormatter"/>
                <messageFormatter contentType="application/json"
                                  class="org.wso2.carbon.integrator.core.json.JsonStreamFormatter"/>
        </messageFormatters>                         
        ```

        ```toml tab='TOML configuration'
        [message_formatters]
        form_urlencoded =  "org.apache.synapse.commons.formatters.XFormURLEncodedFormatter"
        multipart_form_data =  "org.apache.axis2.transport.http.MultipartFormDataFormatter"
        application_xml = "org.apache.axis2.transport.http.ApplicationXMLFormatter"
        text_xml = "org.apache.axis2.transport.http.SOAPMessageFormatter"
        soap_xml = "org.apache.axis2.transport.http.SOAPMessageFormatter"
        text_plain = "org.apache.axis2.format.PlainTextFormatter"
        application_json =  "org.wso2.micro.integrator.core.json.JsonStreamFormatter"
        octet_stream = "org.wso2.carbon.relay.ExpandingMessageFormatter"

        # Custom message formatters.
        [[custom_message_formatters]]
        content_type = "application/json/badgerfish"
        class = "org.apache.axis2.json.JSONBadgerfishMessageFormatter"
        ```

        Find more [parameters]({{base_path}}/reference/config-catalog-mi/#message-formatters-non-blocking-mode).

    -   Message builders

        ```xml tab='XML configuration'
        <messageBuilders>
                <messageBuilder contentType="application/xml"
                                class="org.apache.axis2.builder.ApplicationXMLBuilder"/>
                <messageBuilder contentType="application/x-www-form-urlencoded"
                                class="org.apache.synapse.commons.builders.XFormURLEncodedBuilder"/>
                <messageBuilder contentType="multipart/form-data"
                                class="org.apache.axis2.builder.MultipartFormDataBuilder"/>
                <messageBuilder contentType="text/plain"
                                class="org.apache.axis2.format.PlainTextBuilder"/>
                <messageBuilder contentType="application/octet-stream"
                                class="org.wso2.carbon.relay.BinaryRelayBuilder"/>
                <messageBuilder contentType="application/json"
                                class="org.wso2.carbon.integrator.core.json.JsonStreamBuilder"/>
        </messageBuilders>                                               
        ```

        ```toml tab='TOML configuration'
        [message_builders]
        application_xml = "org.apache.axis2.builder.ApplicationXMLBuilder"
        form_urlencoded = "org.apache.synapse.commons.builders.XFormURLEncodedBuilder"
        multipart_form_data = "org.apache.axis2.builder.MultipartFormDataBuilder"
        text_plain = "org.apache.axis2.format.PlainTextBuilder"
        application_json = "org.wso2.micro.integrator.core.json.JsonStreamBuilder"
        octet_stream =  "org.wso2.carbon.relay.BinaryRelayBuilder"

        # Custom message builders
        [[custom_message_builders]]
        content_type = "application/json/badgerfish"
        class = "org.apache.axis2.json.JSONBadgerfishOMBuilder"
        ```

        Find more [parameters]({{base_path}}/reference/config-catalog-mi/#message-builders-non-blocking-mode).

    -   HTTP transport receiver

        ```xml tab='XML configuration'
        <transportReceiver name="http" class="org.apache.synapse.transport.passthru.PassThroughHttpListener">
                <parameter name="port" locked="false">8280</parameter>
                <parameter name="non-blocking" locked="false">true</parameter>
                <parameter name="bind-address" locked="false">hostname or IP address</parameter>
                <parameter name="WSDLEPRPrefix" locked="false">https://apachehost:port/somepath</parameter>      
        </transportReceiver>                                             
        ```

        ```toml tab='TOML configuration'
        [transport.http]
        listener.enable = true                     
        listener.port = 8280    
        listener.wsdl_epr_prefix ="https://apachehost:port/somepath"
        listener.bind_address = "hostname or IP address"
        ```

        Find more [parameters]({{base_path}}/reference/config-catalog-mi/#https-transport-non-blocking-mode).

    -   HTTPS transport receiver

        ```xml tab='XML configuration'
        <transportReceiver name="https" class="org.apache.synapse.transport.passthru.PassThroughHttpSSLListener">
            <parameter name="port" locked="false">8243</parameter>
            <parameter name="non-blocking" locked="false">true</parameter>
            <parameter name="HttpsProtocols">TLSv1,TLSv1.1,TLSv1.2</parameter>
            <parameter name="bind-address" locked="false">hostname or IP address</parameter>
            <parameter name="WSDLEPRPrefix" locked="false">https://apachehost:port/somepath</parameter>
            <parameter name="keystore" locked="false">
                <KeyStore>
                    <Location>repository/resources/security/wso2carbon.jks</Location>
                    <Type>JKS</Type>
                    <Password>wso2carbon</Password>
                    <KeyPassword>wso2carbon</KeyPassword>
                </KeyStore>
            </parameter>
            <parameter name="truststore" locked="false">
                <TrustStore>
                    <Location>repository/resources/security/client-truststore.jks</Location>
                    <Type>JKS</Type>
                    <Password>wso2carbon</Password>
                </TrustStore>
            </parameter>
        </transportReceiver>                                         
        ```

        ```toml tab='TOML configuration'
        [transport.http]
        listener.secured_enable = true              
        listener.secured_port = 8243        
        listener.secured_wsdl_epr_prefix = "https://apachehost:port/somepath"  
        listener.secured_bind_address = "hostname or IP address"
        listener.secured_protocols = "TLSv1,TLSv1.1,TLSv1.2"   
        listener.keystore.location ="repository/resources/security/wso2carbon.jks"
        listener.keystore.type = "JKS" listener.keystore.password = "wso2carbon"
        listener.keystore.key_password = "wso2carbon"
        listener.truststore.location = "repository/resources/security/client-truststore.jks"
        listener.truststore.type = "JKS" listener.truststore.password = "wso2carbon"
        ```

        Find more [parameters]({{base_path}}/reference/config-catalog-mi/#https-transport-non-blocking-mode).

    -   VFS transport receiver

        ```xml tab='XML configuration'
        <transportReceiver name="vfs" class="org.apache.synapse.transport.vfs.VFSTransportListener"/>                                            
        ```

        ```toml tab='TOML configuration'
        [transport.vfs]
        listener.enable = true
        ```

        Find more [parameters]({{base_path}}/reference/config-catalog-mi/#vfs-transport).

    -   Mailto transport receiver

        ```xml tab='XML configuration'
        <transportReceiver name="mailto" class="org.apache.axis2.transport.mail.MailTransportListener"/>    ```
        ```

        ```toml tab='TOML configuration'
        [transport.mail.listener]
        enable = true
        name = "mailto"
        ```

        Find more [parameters]({{base_path}}/reference/config-catalog-mi/#mail-transport-listener-non-blocking-mode).

    -   JMS transport receiver

        ```xml tab='XML configuration'
        <transportReceiver name="jms" class="org.apache.axis2.transport.jms.JMSListener">
                <parameter name="myTopicConnectionFactory" locked="false">
                    <parameter name="java.naming.factory.initial" locked="false">org.apache.activemq.jndi.ActiveMQInitialContextFactory</parameter>
                    <parameter name="java.naming.provider.url" locked="false">tcp://localhost:61616</parameter>
                    <parameter name="transport.jms.ConnectionFactoryJNDIName" locked="false">TopicConnectionFactory</parameter>
                    <parameter name="transport.jms.ConnectionFactoryType" locked="false">topic</parameter>
                </parameter>
        </transportReceiver>
        ```

        ```toml tab='TOML configuration'
        [transport.jms]
        listener_enable = true

        [[transport.jms.listener]]
        name = "myTopicListener"
        parameter.initial_naming_factory = "org.apache.activemq.artemis.jndi.ActiveMQInitialContextFactory"
        parameter.provider_url = "tcp://localhost:61616"
        parameter.connection_factory_name = "TopicConnectionFactory"
        parameter.connection_factory_type = "topic" # [queue, topic]
        parameter.cache_level = "consumer"
        ```

        Find more [parameters]({{base_path}}/reference/config-catalog-mi/#jms-transport-listener-blocking-mode).

    -   FIX transport receiver

        ```xml tab='XML configuration'
        <transportReceiver name="fix" class="org.apache.synapse.transport.fix.FIXTransportListener"/>
        ```

        ```toml tab='TOML configuration'
        [transport.fix]
        listener.enable = true
        ```

        Find more [parameters]({{base_path}}/reference/config-catalog-mi/#fix-transport).

    -   RabbitMQ transport receiver

        ```xml tab='XML configuration'
        <transportReceiver name="rabbitmq" class="org.apache.axis2.transport.rabbitmq.RabbitMQListener">
                <parameter name="AMQPConnectionFactory" locked="false">
                    <parameter name="rabbitmq.server.host.name" locked="false">localhost</parameter>
                    <parameter name="rabbitmq.server.port" locked="false">5672</parameter>
                    <parameter name="rabbitmq.server.user.name" locked="false">guest</parameter>
                    <parameter name="rabbitmq.server.password" locked="false">guest</parameter>
                </parameter>
        </transportReceiver>
        ```

        ```toml tab='TOML configuration'
        [transport.rabbitmq]
        listener_enable = true

        [[transport.rabbitmq.listener]]
        name = "AMQPConnectionFactory"
        parameter.hostname = "localhost"
        parameter.port = 5672
        parameter.username = "guest"
        parameter.password = "guest"
        ```

        Find more [parameters]({{base_path}}/reference/config-catalog-mi/#rabbitmq-listener).

    -   HL7 transport listener

        ```xml tab='XML configuration'
            <transportReceiver name="hl7" class="org.wso2.carbon.business.messaging.hl7.transport.HL7TransportListener">
                <parameter name="port">9292</parameter>
            </transportReceiver>
        ```

        ```toml tab='TOML configuration'
        [[custom_transport.listener]]
        class="org.wso2.micro.integrator.business.messaging.hl7.transport.HL7TransportListener"
        protocol = "hl7"
        parameter.'transport.hl7.TimeOut' = 10000
        ```

    -   HTTP transport sender

        !!! Warning
            Do not duplicate the `[transport.http]` TOML header when you enable both the JMS listener and sender. Use the TOML header once and add both parameters (`listener_enabled` and `sender_enabled`).

        ```xml tab='XML configuration'
        <transportSender name="http" class="org.apache.synapse.transport.passthru.PassThroughHttpSender">
                <parameter name="non-blocking" locked="false">true</parameter>
         </transportSender>
        ```

        ```toml tab='TOML configuration'
        [transport.http]
        #listener_enable = true
        sender.enable = true
        ```

        Find more [parameters]({{base_path}}/reference/config-catalog-mi/#https-transport-non-blocking-mode).

    -   HTTPS transport sender

        ```xml tab='XML configuration'
        <transportSender name="https" class="org.apache.synapse.transport.passthru.PassThroughHttpSSLSender">
                <parameter name="non-blocking" locked="false">true</parameter>
                <parameter name="keystore" locked="false">
                    <KeyStore>
                        <Location>repository/resources/security/wso2carbon.jks</Location>
                        <Type>JKS</Type>
                        <Password>wso2carbon</Password>
                        <KeyPassword>wso2carbon</KeyPassword>
                    </KeyStore>
                </parameter>
                <parameter name="truststore" locked="false">
                    <TrustStore>
                        <Location>repository/resources/security/client-truststore.jks</Location>
                        <Type>JKS</Type>
                        <Password>wso2carbon</Password>
                    </TrustStore>
                </parameter>
        </transportSender>
        ```

        ```toml tab='TOML configuration'
        [transport.http]
        sender.secured_enable = true
        sender.keystore.location ="repository/resources/security/wso2carbon.jks"
        sender.keystore.type = "JKS"
        sender.keystore.password = "wso2carbon"
        sender.keystore.key_password = "wso2carbon"
        sender.truststore.location = "repository/resources/security/client-truststore.jks"
        sender.truststore.type = "JKS"
        sender.truststore.password = "wso2carbon"
        ```

        Find more [parameters]({{base_path}}/reference/config-catalog-mi/#https-transport-non-blocking-mode).

    -   VFS transport sender

        ```xml tab='XML configuration'
        <transportSender name="vfs" class="org.apache.synapse.transport.vfs.VFSTransportSender"/>
        ```

        ```toml tab='TOML configuration'
        [transport.vfs]
        sender.enable = true
        ```

        Find more [parameters]({{base_path}}/reference/config-catalog-mi/#vfs-transport).

    -   VFS transport sender

        ```xml tab='XML configuration'
        <transportSender name="mailto" class="org.apache.axis2.transport.mail.MailTransportSender">
                <parameter name="mail.smtp.host">smtp.gmail.com</parameter>
                <parameter name="mail.smtp.port">587</parameter>
                <parameter name="mail.smtp.starttls.enable">true</parameter>
                <parameter name="mail.smtp.auth">true</parameter>
                <parameter name="mail.smtp.user">synapse.demo.0</parameter>
                <parameter name="mail.smtp.password">mailpassword</parameter>
                <parameter name="mail.smtp.from">synapse.demo.0@gmail.com</parameter>
        </transportSender>
        ```

        ```toml tab='TOML configuration'
        [[transport.mail.sender]]
        name = "mailto"
        parameter.hostname = "smtp.gmail.com"
        parameter.port = "587"
        parameter.enable_tls = true
        parameter.auth = true
        parameter.username = "synapse.demo.0"
        parameter.password = "mailpassword"
        parameter.from = "synapse.demo.0@gmail.com"
        ```

        Find more [parameters]({{base_path}}/reference/config-catalog-mi/#mail-transport-sender-non-blocking-mode).

    -   FIX transport sender

        ```xml tab='XML configuration'
        <transportSender name="fix" class="org.apache.synapse.transport.fix.FIXTransportSender"/>
        ```

        ```toml tab='TOML configuration'
        [transport.fix]
        sender.enable = true
        ```

        Find more [parameters]({{base_path}}/reference/config-catalog-mi/#fix-transport).

    -   RabbitMQ transport sender

        ```xml tab='XML configuration'
        <transportSender name="rabbitmq" class="org.apache.axis2.transport.rabbitmq.RabbitMQSender"/>
        ```

        ```toml tab='TOML configuration'
        [transport.rabbitmq]
        sender_enable = true
        ```

        Find more [parameters]({{base_path}}/reference/config-catalog-mi/#rabbitmq-sender).


    -   JMS transport sender

        ```xml tab='XML configuration'
        <transportSender name="jms" class="org.apache.axis2.transport.jms.JMSSender"/>
        ```

        ```toml tab='TOML configuration'
        [transport.jms]
        sender_enable = true
        ```

        Find more [parameters]({{base_path}}/reference/config-catalog-mi/#jms-transport-sender-non-blocking-mode).

    -   HL7 transport sender

        ```xml tab='XML configuration'
            <transportSender name="hl7" class="org.wso2.carbon.business.messaging.hl7.transport.HL7TransportSender">
            <!--parameter name="non-blocking">true</parameter-->
          </transportSender>
        ```

        ```toml tab='TOML configuration'
        [[custom_transport.sender]]
        class="org.wso2.micro.integrator.business.messaging.hl7.transport.HL7TransportSender"
        protocol = "hl7"
        ```

??? note "synapse.properties"

    Synapse thread pool properties:

    ```xml tab='XML configuration'
    synapse.threads.core = 20
    synapse.threads.max = 100
    ```

    ```toml tab='TOML configuration'
    [mediation]
    synapse.core_threads = 20
    synapse.max_threads = 100
    ```

    Find more [parameters]({{base_path}}/reference/config-catalog-mi/#message-mediation).

??? note "passthru-http.properties"

    -   HTTP/S worker pool properties

        ```xml tab='XML configuration'
        worker_pool_size_core=400
        worker_pool_size_max=400
        worker_pool_queue_length=-1
        ```

        ```toml tab='TOML configuration'
        [transport.http]
        core_worker_pool_size = 400         # inferred default: 400
        max_worker_pool_size = 400          # inferred default: 400
        worker_pool_queue_length = -1
        ```

        Find more [parameters]({{base_path}}/reference/config-catalog-mi/#https-transport-non-blocking-mode).

    -   Preserve headers

        ```xml tab='XML configuration'
        http.user.agent.preserve=false
        http.server.preserve=true
        http.headers.preserve=Content-Type
        ```

        ```toml tab='TOML configuration'
        [transport.http]
        preserve_http_user_agent = false
        preserve_http_server_name = true
        preserve_http_headers = ["Content-Type"]
        ```

        Find more [parameters]({{base_path}}/reference/config-catalog-mi/#https-transport-non-blocking-mode).

??? note "jndi.properties"

    -   JMS connection factory

        ```xml tab='XML configuration'
        connectionfactory.QueueConnectionFactory = amqp://admin:admin@clientID/carbon?brokerlist='tcp://localhost:5675'
        connectionfactory.TopicConnectionFactory = amqp://admin:admin@clientID/carbon?brokerlist='tcp://localhost:5675'
        ```

        ```toml tab='TOML configuration'
        [transport.jndi.connection_factories]
        'connectionfactory.QueueConnectionFactory' = "amqp://admin:admin@clientID/carbon?brokerlist='tcp://localhost:5675'"
        'connectionfactory.TopicConnectionFactory' = "amqp://admin:admin@clientID/carbon?brokerlist='tcp://localhost:5675'"
        ```

        Find more [parameters]({{base_path}}/reference/config-catalog-mi/#jndi-connection-factories).

    -   JMS queue

        ```xml tab='XML configuration'
        queue.JMSMS=JMSMS
        ```

        ```toml tab='TOML configuration'
        [transport.jndi.queue]
        JMSMS = "JMSMS"
        ```

        Find more [parameters]({{base_path}}/reference/config-catalog-mi/#jndi-connection-factories).

    -   JMS topic

        ```xml tab='XML configuration'
        topic.MyTopic = example.MyTopic
        ```

        ```toml tab='TOML configuration'
        [transport.jndi.topic]
        MyTopic = "example.MyTopic"
        ```

        Find more [parameters]({{base_path}}/reference/config-catalog-mi/#jndi-connection-factories).

??? note "tasks-config.xml"

    ```xml tab='XML configuration'
    <taskServerCount>1</taskServerCount>
    <defaultLocationResolver>
        <locationResolverClass>org.wso2.carbon.ntask.core.impl.RoundRobinTaskLocationResolver</locationResolverClass>
    </defaultLocationResolver>      
    ```

    ```toml tab='TOML configuration'
    [task_handling]
    resolver_class = "org.wso2.micro.integrator.ntask.coordination.task.resolver.RoundRobinResolver"

    [[task_resolver]]
    task_server_count = "3"
    ```

    Find more [parameters]({{base_path}}/install-and-setup/setup/mi-setup/deployment/deploying_wso2_ei).

The complete list of TOML configurations for the Micro Integrator are listed in the [product configuration catalog]({{base_path}}/reference/config-catalog-mi).

#### Migrating Log4j configurations

All ESB versions prior to EI 6.6.0 use <b>log4j</b>. In the Micro Integrator, the `carbon.logging.jar` file is not included and the `pax-logging-api` is used instead. With this upgrade, the log4j version is also updated to log4j2.

See the topics given below to configure log4j2 in the Micro Integrator.

-   [Log4j2 properties]({{base_path}}/install-and-setup/setup/mi-setup/observability/logs/configuring_log4j_properties)
-   [Correlation logs]({{base_path}}/install-and-setup/setup/mi-setup/observability)
-   [Wire logs]({{base_path}}/integrate/develop/using-wire-logs)
-   [Service-level logs]({{base_path}}/integrate/develop/enabling-logs-for-services)
-   [REST API Access logs]({{base_path}}/integrate/develop/enabling-logs-for-api)
-   [Managing Log Growth]({{base_path}}/install-and-setup/setup/mi-setup/observability/logs/managing_log_growth)

Follow the instructions given below if you have used a **custom log4j component** in your older EI version.

1.  Replace carbon logging or commons.logging dependencies with pax-logging dependency as shown below.
        ```xml
        <!-- Pax Logging -->
        <dependency>
           <groupId>org.ops4j.pax.logging</groupId>
           <artifactId>pax-logging-api</artifactId>
           <version>${pax.logging.api.version}</version>
        </dependency>
        <!-- Pax Logging Version -->
        <pax.logging.api.version>1.10.1</pax.logging.api.version>
        ```

2.  If log4j dependency is directly used, apply one of the options given below.

    -   Replace the log4j dependency (shown below) with log4j2 and rewrite the loggers accordingly.
            ```xml
            <dependency>
               <groupId>org.ops4j.pax.logging</groupId>
               <artifactId>pax-logging-log4j2</artifactId>
               <version>${pax.logging.log4j2.version}</version>
            </dependency>
            ```
    -   Replace the log4j dependency with pax-logging dependency and rewrite the loggers using commons.logging accordingly.

3.  If commons.logging is imported using Import-Package, add the version range.
        ```xml
        org.apache.commons.logging;
        version="${commons.logging.version.range}" 
        <commons.logging.version.range>[1.2.0,2.0.0)</commons.logging.version.range>
        ```

4.  Follow the instructions on [configuring log4j2]({{base_path}}/install-and-setup/setup/mi-setup/observability/logs/configuring_log4j_properties) to register the Appenders and Loggers.

### Migrating encrypted passwords

To migrate the encrypted passwords from EI 6.1.0, you need to first re-encrypt (using OAEP) all the encrypted information 
in the database. Then, you can obtain the plain-text passwords by following the normal procedure of encrypting secrets 
in the Micro Integrator. See [Encrypting Secrets]({{base_path}}/install-and-setup/setup/mi-setup/security/encrypting_plain_text) 
for instructions.

!!! Info 

    API-M 4.0.0 uses OAEP for data encryption in addition to the RSA algorithm 
    (which is used in the ESB profile of EI 6.1.0). Therefore, the internally encrypted data in your current databases (such as 
    datasource configurations, syslog passwords, user store configurations, keystore registry entries, service security policies, 
    event publisher configurations, event receiver configurations, and event sink configurations), as well as data encrypted using 
    secure vault (such as plain text passwords in configuration files and synapse configurations) should be re-encrypted using OAEP.

#### Step 1: Re-encrypt all internally encrypted data using OAEP

First, let's re-encrypt all the internally encrypted data by using OAEP.

1. Get the latest update for your existing EI 6.1.0 by using [WSO2 Updates](https://updates.docs.wso2.com/en/latest/updates/overview/). This will give you a new EI distribution with the latest updates.

    !!! Info
        Note that you need a valid [WSO2 subscription](https://wso2.com/subscription) to use updates in a production environment.
        
2. Connect the updated EI distribution to your existing databases (which are used for registry data and user management data):

    ??? note "Connecting to the database"
    
        1. Open the `master-datasources.xml` file (stored in the `<UPDATED_EI_6.1.0_HOME>/conf/datasources/` directory) and update the parameters given below.
           By default, registry and user management data are stored in one database and is configured in the `master-datasources.xml` file. If you have separate databases for registry and user management data, you may have separate datasource configurations.
            -   `driverCalssName`: The class name of the database driver.
            -   `url`: The URL of the database.
            -   `username` and `password`: The name and password of the database user.
           
        2. Open the `registry.xml` file (stored in the `<UPDATED_EI_6.1.0_HOME>/conf` directory) and specify the datasource name.
           ```xml
           <dbConfig name="wso2registry">   
                <dataSource>jdbc/MY_DATASOURCE_NAME</dataSource>
            </dbConfig>
           ```
        
        3. If a JDBC user store is used in your ESB, open the `user-mgt.xml` file (stored in the `<UPDATED_EI_6.1.0_HOME>/conf/` directory), and update the following database connection parameters under the `<UserStoreManager class="org.wso2.carbon.user.core.jdbc.JDBCUserStoreManager">` section. 
            -   `driverCalssName`: The class name of the database driver.
            -   `url`: The URL of the database.
            -   `username` and `password`: The name and password of the database user.  
            
           Further, update the system administrator configurations and the datasource name in the `user-mgt.xml` file. See [Configuring a JDBC user store](https://docs.wso2.com/display/EI660/Configuring+a+JDBC+User+Store) for instructions.
           
        4. [Encrypt the plain text passwords](https://docs.wso2.com/display/EI660/Encrypting+Passwords+with+Cipher+Tool) that you added to the configuration files (master-datasources.xml, user-mgt.xml, etc.).   

3. Be sure that the [carbon.properties]({{base_path}}/assets/attachments/migration/micro-integrator/carbon.properties) file is included in the `<UPDATED_EI_6.1.0_HOME>/conf/` directory with the following parameter:

    ```text
    org.wso2.CipherTransformation=RSA/ECB/OAEPwithSHA1andMGF1Padding
    ```

4. Start the updated ESB server of EI 6.1.0. This will re-encrypt the data in the databases.

#### Step 2: Run the migration tool

Now, let's run the [password decryption tool](https://github.com/wso2-docs/WSO2_EI/tree/master/migration-client) from EI 6.1.0 to obtain the plain-text passwords by decrypting the encrypted passwords in the EI 6.1.0.

Follow the instructions given below to use the password decryption tool.

1. Download the [tool](https://github.com/wso2-docs/WSO2_EI/blob/master/migration-client/org.wso2.mi.migration-1.2.0.jar).

2. Copy the `org.wso2.mi.migration-1.2.0.jar` into the `EI_HOME/dropins` folder in the server.

3. Create a directory named migration in `EI_HOME`.

4. Copy the [migration-conf.properties](https://github.com/wso2-docs/WSO2_EI/blob/master/migration-client/migration-conf.properties) file into the migration directory and update the following property.

    | Property         | Description   |
    | ---------------- | ------------- |
    | admin.user.name  | The user name of the system [administrator](https://docs.wso2.com/display/EI660/Configuring+the+System+Administrator). |

5. Start the server using the `migrate.from.product.version` system property as follows:

    ```bash tab='On Linux/Unix'
    sh integrator.sh -Dmigrate.from.product.version=ei
    ```

    ```bash tab='On Windows'
    integrator.bat -Dmigrate.from.product.version=ei
    ```

    !!! Info
        Upon successful execution, the decrypted (plain-text) values in the `secure-vault.properties` and `cipher-text.properties` files will be written respectively to the `<EI_HOME>/migration/secure-vault-decrypted.properties` file and the `<EI_HOME>/migration/cipher-text-decrypted.properties` file in EI 6.1.0.

    The encrypted passwords are now decrypted and you have access to the plain-text password values.

6.  Use the plain-text passwords and follow the normal procedure of encrypting secrets in the Micro Integrator of API-M 4.0.0. See [Encrypting Secrets]({{base_path}}/install-and-setup/setup/mi-setup/security/encrypting_plain_text) for instructions.

### Migrating the Hl7 Transport

HL7 transport is not shipped by default in the API-M 4.0.0 Micro Integrator distribution. Therefore, the jars need to be added to the Micro Integrator server manually. See [Configuring the HL7 transport]({{base_path}}/install-and-setup/setup/mi-setup/transport_configurations/configuring-transports/#configuring-the-hl7-transport) for details.
