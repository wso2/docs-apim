# Securing APIs with Mutual SSL

!!! warning
    This is available only as a **WUM** update and is effective from 22nd October 2018 (2018-10-22). For more information on updating WSO2 API Manager, see [Updating WSO2 API Manager](../../../../Administer/ProductAdministration/updating-wso2-api-manager).


In contrast to the usual one-way SSL authentication where a client verifies the identity of the server, in mutual SSL the server validates the identity of the client so that both parties trust each other. This builds a system that has a very tight security and avoids any requests made to the client to provide the username/password, as long as the server is aware of the certificates that belong to the client.

This section explains how to APIs in WSO2 API Manager can be secured using mutual SSL in addition to OAuth2.

### Enable securing APIs with mutual SSL

Follow the steps below to enable this feature in WSO2 API Manager.

1.  Create the `AM_API_CLIENT_CERTIFICATE` table in the APIM DB using the appropriate script given below. Note that the database name will depend on the databases present in your environment.

    ``` java tab="H2"
            IF NOT  EXISTS (SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[AM_API_CLIENT_CERTIFICATE]') AND TYPE IN (N'U'))
            CREATE TABLE AM_API_CLIENT_CERTIFICATE (
               TENANT_ID INTEGER NOT NULL,
               ALIAS VARCHAR(45) NOT NULL,
               API_ID INTEGER NOT NULL,
               CERTIFICATE VARBINARY(MAX) NOT NULL,
               REMOVED BIT NOT NULL DEFAULT 0,
               TIER_NAME VARCHAR(512),
               PRIMARY KEY (ALIAS, TENANT_ID, REMOVED),
               FOREIGN KEY (API_ID) REFERENCES AM_API(API_ID) ON DELETE CASCADE
            );
    ```

    ``` java tab="MSSQL"
            CREATE TABLE IF NOT EXISTS `AM_API_CLIENT_CERTIFICATE` (
             `TENANT_ID` INT(11) NOT NULL,
             `ALIAS` VARCHAR(45) NOT NULL,
             `API_ID` INTEGER NOT NULL,
             `CERTIFICATE` BLOB NOT NULL,
             `REMOVED` BOOLEAN NOT NULL DEFAULT 0,
             `TIER_NAME` VARCHAR (512),
             FOREIGN KEY (API_ID) REFERENCES AM_API (API_ID) ON DELETE CASCADE ON UPDATE CASCADE,
             PRIMARY KEY (`ALIAS`, `TENANT_ID`, `REMOVED`)
            ) ENGINE=InnoDB;
    ```

    ``` java tab="MySQL"
            CREATE TABLE IF NOT EXISTS `AM_API_CLIENT_CERTIFICATE` (
             `TENANT_ID` INT(11) NOT NULL,
             `ALIAS` VARCHAR(45) NOT NULL,
             `API_ID` INTEGER NOT NULL,
             `CERTIFICATE` BLOB NOT NULL,
             `REMOVED` BOOLEAN NOT NULL DEFAULT 0,
             `TIER_NAME` VARCHAR (512),
             FOREIGN KEY (API_ID) REFERENCES AM_API (API_ID) ON DELETE CASCADE,
             PRIMARY KEY (`ALIAS`, `TENANT_ID`, `REMOVED`)
            ) ENGINE=NDB;
    ```

    ``` java tab="MySQL Cluster"
            CREATE TABLE AM_API_CLIENT_CERTIFICATE (
             TENANT_ID INTEGER NOT NULL,
             ALIAS VARCHAR2(45) NOT NULL,
             API_ID INTEGER NOT NULL,
             CERTIFICATE BLOB NOT NULL,
             REMOVED INTEGER DEFAULT 0 NOT NULL,
             TIER_NAME VARCHAR2 (512),
             FOREIGN KEY (API_ID) REFERENCES AM_API (API_ID) ON DELETE CASCADE,
             PRIMARY KEY (ALIAS, TENANT_ID, REMOVED)
            )
            /
    ```

    ``` java tab="Oracle"
            CREATE TABLE AM_API_CLIENT_CERTIFICATE (
             TENANT_ID INTEGER NOT NULL,
             ALIAS VARCHAR2(45) NOT NULL,
             API_ID INTEGER NOT NULL,
             CERTIFICATE BLOB NOT NULL,
             REMOVED INTEGER DEFAULT 0 NOT NULL,
             TIER_NAME VARCHAR2(512),
             FOREIGN KEY (API_ID) REFERENCES AM_API (API_ID) ON DELETE CASCADE,
             PRIMARY KEY (ALIAS, TENANT_ID, REMOVED)
            )
            /
    ```

    ``` java tab="Oracle rac"
            DROP TABLE IF EXISTS AM_API_CLIENT_CERTIFICATE;
            CREATE TABLE AM_API_CLIENT_CERTIFICATE (
             TENANT_ID INTEGER NOT NULL,
             ALIAS VARCHAR(45) NOT NULL,
             API_ID INTEGER NOT NULL,
             CERTIFICATE BYTEA NOT NULL,
             REMOVED BOOLEAN NOT NULL DEFAULT '0',
             TIER_NAME VARCHAR(512),
             FOREIGN KEY (API_ID) REFERENCES AM_API (API_ID) ON DELETE CASCADE,
             PRIMARY KEY (ALIAS, TENANT_ID, REMOVED)
            );
    ```

    ``` java tab="DB2"
            CREATE TABLE AM_API_CLIENT_CERTIFICATE (
              TENANT_ID INT NOT NULL,
              ALIAS VARCHAR(45) NOT NULL,
              API_ID INTEGER NOT NULL,
              CERTIFICATE BLOB NOT NULL,
              REMOVED SMALLINT NOT NULL DEFAULT 0,
              TIER_NAME VARCHAR (512),
              FOREIGN KEY (API_ID) REFERENCES AM_API (API_ID) ON DELETE CASCADE ON UPDATE CASCADE,
              PRIMARY KEY (ALIAS, TENANT_ID, REMOVED)
            )/
    ```

2.  Open the `<API-M_HOME>/repository/conf/axis2/axis2.xml` file. Locate the `transportReceiver` for `https` as shown below.

    ``` java
            <transportReceiver name="https" class="org.apache.synapse.transport.passthru.PassThroughHttpSSLListener">
    ```

    Change the class name to `org.apache.synapse.transport.passthru.PassThroughHttpMultiSSLListener`. The sample is given below.

    ``` java
            <transportReceiver name="https" class="org.apache.synapse.transport.passthru.PassThroughHttpMultiSSLListener">
    ```

3.  Add the following parameters under `transportReceiver` similar to the sample given below.

    ``` java
            <parameter name="dynamicSSLProfilesConfig">
                <filePath>repository/resources/security/listenerprofiles.xml</filePath>
                <fileReadInterval>600000</fileReadInterval>
            </parameter>
            <parameter name="SSLVerifyClient">optional</parameter>
    ```

    The `dynamicSSLProfilesConfig` specifies the file read to load the dynamic SSL profile and the time interval in which it will be read.
    Note that if the `fileReadInterval` parameter is set to 600000, it will take at least 10 minutes for the gateway to accept a newly added client certificate.

    ![](images/icons/grey_arrow_down.png){.expand-control-image} Expand to see the transportReceiver segment after the changes mentioned above have been made...

    ``` java
            <transportReceiver name="https" class="org.apache.synapse.transport.passthru.PassThroughHttpMultiSSLListener">
                    <parameter name="port" locked="false">8243</parameter>
                    <parameter name="non-blocking" locked="false">true</parameter>
                    <!--parameter name="bind-address" locked="false">hostname or IP address</parameter-->
                    <!--parameter name="WSDLEPRPrefix" locked="false">https://apachehost:port/somepath</parameter-->
                   <parameter name="httpGetProcessor" locked="false">org.wso2.carbon.mediation.transport.handlers.PassThroughNHttpGetProcessor</parameter>
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
                   <!-- ============================================== -->
                   <!-- Configuration for Listener Dynamic SSL Profile loading. -->
                   <!-- Configured for 10 mins. -->
                   <!-- ============================================== -->
                   <parameter name="dynamicSSLProfilesConfig">
                       <filePath>repository/resources/security/listenerprofiles.xml</filePath>
                       <fileReadInterval>600000</fileReadInterval>
                   </parameter>
                   <parameter name="SSLVerifyClient">optional</parameter>
                    <!--<parameter name="SSLVerifyClient">require</parameter>
                        supports optional|require or defaults to none -->
            </transportReceiver>
    ```

4.  Copy the code given below to create the `listenerprofiles.xml` file in the `<API-M_HOME>/repository/resources/security` directory.

    ``` java
            <?xml version="1.0" encoding="ISO-8859-1"?>
            <parameter name="SSLProfiles">
            <profile>
                    <bindAddress>0.0.0.0</bindAddress>
                     <KeyStore>
                        <Location>repository/resources/security/wso2carbon.jks</Location>
                        <Type>JKS</Type>
                        <Password>wso2carbon</Password>
                        <KeyPassword>wso2carbon</KeyPassword>
                    </KeyStore>
                    <TrustStore>
                        <Location>repository/resources/security/client-truststore.jks</Location>
                        <Type>JKS</Type>
                        <Password>wso2carbon</Password>
                    </TrustStore>
                    <SSLVerifyClient>optional</SSLVerifyClient>
                </profile>
            </parameter>
    ```

    !!! note
        The `<API-M_HOME>/repository/resources/security` directory can be changed according to the file path you have configured in Step 2.


5.  Open the `<API-M_HOME>/repository/conf/api-manager.xml` file. Set the `EnableMTLSForAPIs` parameter to `true`.

    ``` java
        <APIManager>
            ...
          <EnableMTLSForAPIs>true</EnableMTLSForAPIs>
    ```

6.  Restart the server.

### Create an API secured with mutual SSL

1.  [Create an API](../../../../Learn/DesignAPI/CreateAPI/create-a-rest-api).
2.  **Edit** the API and navigate to the **Manage** tab.
3.  Select **Mutual SSL** under **API Security**.
    ![]({{base_path}}/assets/attachments/103334944/103334943.png)

    !!! info
        You can select both OAuth2 and Mutual SSL options. This means that the user can access the API using a valid OAuth2 token or using a valid client certificate.


4.  Click **Manage Certificates** to upload a new client certificate. Select **Add New Certificate**.
    ![]({{base_path}}/assets/attachments/103334944/103334942.png)
    
    !!! note
        This feature currently supports only the following formats for keystores and certificates.

    -   Keystore : `.jks            `
    -   Certificate : `.crt            `

    If you need to use a certificate in any other format, you can convert it using a standard tool before uploading.


    !!! info
        After configuring, the certificate will be added to the Gateway nodes which are defined under the Environments in `api-manager.xml`. In a clustered setup, as gateway configurations are identical, sync the `<API-M_HOME>/repository/resources/security/listenerprofiles.xml` and `<API-M_HOME>/repository/resources/security/client-truststore.jks` among the gateway nodes. After the configured interval, the synapse transport will be reloaded in all the gateway nodes.


5.  Provide an alias and public certificate. Select the tier that should be used to throttle out the calls using this particular client certificate and click **Upload**.
    ![]({{base_path}}/assets/attachments/103334944/103334941.png)
6.  **Save and Publish** the API

### Invoke an API secured with Mutual SSL from the API Store

!!! note "Before you begin..."
    Add the relevant certificate to your browser according to your private certificate.


1.  [Invoke an API from the API Store](../../../../Learn/ConsumeAPI/InvokeApis/InvokeApisUsingTools/invoke-an-api-using-the-integrated-api-console).
2.  When you click **Execute** the browser will send a prompt similar to the one shown below. Select the corresponding certificate for the API.
    ![]({{base_path}}/assets/attachments/103334944/103334940.png)

#### Limitations

Listed below are the known limitations for this feature.

-   Application subscription is not permitted for APIs that are only protected with mutual SSL. Hence, subscription/application level throttling is not applicable for these type of APIs.

-   Resource level throttling is not applicable for the APIs that are only protected with mutual SSL.

-   Resource level security will not be applicable for the APIs that are only protected with mutual SSL.

-   Scope level security will not be applicable for the APIs that are only protected with mutual SSL.

