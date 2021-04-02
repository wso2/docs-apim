# Salesforce SOAP Connector Configuration

The Salesforce SOAP connector allows you to access the [Salesforce SOAP API](https://developer.salesforce.com/docs/atlas.en-us.api.meta/api/sforce_api_quickstart_intro.htm?search_text=SOAP%20API%20Developer%20Guide) from the integration sequence. 

## Setting up the Salesforce account

1. To work with the Salesforce SOAP connector, you need to have a Salesforce account. If you do not have a Salesforce account, go to [https://developer.salesforce.com/signup](https://developer.salesforce.com/signup) and create a Salesforce developer account.

2. After creating a Salesforce account you will get a [Salesforce security token](https://help.salesforce.com/articleView?id=user_security_token.htm&type=5). 

3. To configure the Salesforce SOAP Connector you need to save and keep the **username**, **password**, and **security token** of your Salesforce account.

## Importing the Salesforce Certificate

To use the Salesforce connector, add the `<salesforce.init>` element to your configuration before carrying out any other Salesforce operations.

Before you start configuring the connector, import the **Salesforce certificate** to your integration runtime's **client keystore**.

Follow the steps below to import the Salesforce certificate into the integration runtime's client keystore:

1. To view the certificate, log in to your Salesforce account in your browser.
2. Search the **Certificate and Key Management** in the search box.

   <img src="{{base_path}}/assets/img/integrate/connectors/salesforcesoap-certificste-and-key-management.png" title="salesforcesoap-certificste-and-key-management" width="600" alt="salesforcesoap-certificste-and-key-management"/>  
    
3. Export the certificate to the file system.
4. Import the certificate to the integration runtime's client keystore using the following [command]({{base_path}}/install-and-setup/security/importing_ssl_certificate/).

    ```
    keytool -importcert -file <certificate file> -keystore <PRODUCT_HOME>/repository/resources/security/client-truststore.jks -alias "Salesforce"
    ```

5. Restart the server and deploy the following Salesforce configuration:

    ```
    <salesforce.init>
        <username>MyUsername</username>
        <password>MyPassword</password>
        <loginUrl>https://login.salesforce.com/services/Soap/u/42.0</loginUrl>
        <blocking>false</blocking>
    </salesforce.init>
    ```

> **Note**: Secure Vault is supported for [encrypting passwords]({{base_path}}/install-and-setup/security/encrypting_plain_text/). See, Working with Passwords on integrating and using Secure Vault.

## Re-using Salesforce configurations

You can save the Salesforce connection configuration as a [local entry]({{base_path}}/integrate/develop/creating-artifacts/registry/creating-local-registry-entries/) and then easily reference it with the configKey attribute in your operations. For example, if you saved the above <salesforce.init> entry as a local entry named MySFConfig, you could reference it from an operation like getUserInfo as follows:

```
<salesforce.getUserInformation configKey="MySFConfig"/>
```
The Salesforce connector operation examples use this convention to show how to specify the connection configuration for that operation. In all cases, the configKey attribute is optional if the connection to Salesforce has already been established and is required only if you need to specify a different connection from the current connection.