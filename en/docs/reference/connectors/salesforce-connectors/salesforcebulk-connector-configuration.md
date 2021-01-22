# Setting up the SalesforceBulk Environment  

The SalesforceBulk connector allows you to access the [SalesforceBulk REST API](https://developer.salesforce.com/docs/atlas.en-us.api_asynch.meta/api_asynch/) through WSO2 EI. SalesforceBulk is a RESTful API that allows you to either quickly load large sets of your organisation’s data into Salesforce or delete large sets of your organisation’s data from Salesforce.

> **Note**: To work with the Salesforce Bulk connector, you need to have a Salesforce account. If you do not have a Salesforce account, go to [https://developer.salesforce.com/signup](https://developer.salesforce.com/signup) and create a Salesforce developer account.

Salesforce uses the OAuth protocol to allow application users to securely access data without having to reveal their user credentials. For more information on authentication is done in Salesforce, see [Understanding Authentication](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/intro_oauth_and_connected_apps.htm).

### Obtaining user credentials 

Follow the steps below to create a connected application using Salesforce and to obtain the consumer key as well as the consumer secret for the created connected application.

{!reference/connectors/salesforce-connectors/sf-access-token-generation.md!} 

### Configuring Axis2 configurations

Be sure to add and enable the following Axis2 configurations in the `<PRODUCT_HOME>/conf/axis2/axis2.xml` file.

* **Required message formatters**

```
<messageFormatter contentType="text/csv" class="org.wso2.carbon.relay.ExpandingMessageFormatter"/>
<messageFormatter contentType="zip/xml" class="org.wso2.carbon.relay.ExpandingMessageFormatter"/>
<messageFormatter contentType="zip/csv" class="org.wso2.carbon.relay.ExpandingMessageFormatter"/>
<messageFormatter contentType="text/xml" class="org.wso2.carbon.relay.ExpandingMessageFormatter"/>
<messageFormatter contentType="text/html" class="org.wso2.carbon.relay.ExpandingMessageFormatter"/> 
```

* **Required message builders**
```
<messageBuilder contentType="text/csv" class="org.wso2.carbon.relay.BinaryRelayBuilder"/>
<messageBuilder contentType="zip/xml" class="org.wso2.carbon.relay.BinaryRelayBuilder"/>
<messageBuilder contentType="zip/csv" class="org.wso2.carbon.relay.BinaryRelayBuilder"/>
<messageBuilder contentType="text/xml" class="org.wso2.carbon.relay.BinaryRelayBuilder"/>
<messageBuilder contentType="text/html" class="org.wso2.carbon.relay.BinaryRelayBuilder"/>
```