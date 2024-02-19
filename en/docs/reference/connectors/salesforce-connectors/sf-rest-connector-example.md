# Salesforce Rest API Connector Example

The Salesforce REST Connector allows you to work with records in Salesforce, a web-based service that allows organizations to manage contact relationship management (CRM) data. You can use the Salesforce connector to create, query, retrieve, update, and delete records in your organization's Salesforce data. The connector uses the [Salesforce REST API](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/intro_what_is_rest_api.htm) to interact with Salesforce.

## What you'll build

This example explains how to use the Salesforce client to connect with the Salesforce instance and perform the
following operations:

* Create an account.

  The user sends the request payload that includes sObjects (any object that can be stored in the Lightning platform database), to create a new Account object in Salesforce. This request is sent to the integration runtime by invoking the Salesforce connector API.

* Execute a SOQL query to retrieve the Account Name and ID in all the existing accounts.

  In this example use the Salesforce Object Query Language (SOQL) to search stored Salesforce data for specific information which is created under `sObjects`.

<img src="{{base_path}}/assets/img/integrate/connectors/salesforce.png" title="Using Salesforce Rest Connector" width="800" alt="Using Salesforce Rest Connector"/>

The user calls the Salesforce REST API. It invokes the **create** sequence and creates a new account in Salesforce. Then through the **retrieve** sequence, it displays all the existing account details to the user.

If you do not want to configure this yourself, you can simply [get the project](#get-the-project) and run it.

## Configure the connector in WSO2 Integration Studio

Connectors can be added to integration flows in [WSO2 Integration Studio](https://wso2.com/integration/integration-studio/). Once added, the operations of the connector can be dragged onto your canvas and added to your sequences.

### Import the connector

Follow these steps to set up the Integration Project and the Connector Exporter Project.

{!includes/reference/connectors/importing-connector-to-integration-studio.md!}

### Add integration logic

1. First create an API, which will be where we configure the integration logic. Right click on the created Integration Project and select, **New** -> **Rest API** to create the REST API. Specify the API name as `salesforcerest` and API context as `/salesforcerest`.
   <img src="{{base_path}}/assets/img/integrate/connectors/adding-an-api.jpg" title="Adding a Rest API" width="800" alt="Adding a Rest API"/>

2. Now, we will add the relevant Salesforce REST operations to create an account and retrieve data. 

3. Navigate into the Palette pane and select the graphical operations icons listed under Salesforcerest Connector section. Then, drag and drop the 'create' operation into the Design pane.
   <img src="{{base_path}}/assets/img/integrate/connectors/salesforcerest-connector-1.png" title="Adding the create operation." width="800" alt="Adding the create operation."/>

4. Now, when you select the `create` operation on the canvas, the properties window will appear. Create a connection from the properties window by clicking on the '+' icon as shown below.
   <img src="{{base_path}}/assets/img/integrate/connectors/salesforcerest-connector-2.png" title="Adding the connection." width="800" alt="Adding the connection."/>
   
    In the pop-up window, following parameters must be provided. See the [Salesforce REST Connector reference page]({{base_path}}/reference/connectors/salesforce-connectors/sf-rest-connector-config-v2) for more information.<br/>
    
    - Connection Name - A Unique name for the Salesforce REST connection.
    - Connection Type - Type of the connection which specifies the protocol to be used.
    - Access Token - The access token to authenticate your API calls.
    - API Version - The version of the Salesforce API.
    - Host Name - SalesforceOAuth endpoint when issuing authentication requests in your application.
    - Refresh Token - The refresh token that you received to refresh the API access token.
    - Refresh Token Endpoint - The endpoint of the refresh token that you invoke to refresh the API access token.
    - Client Secret - The consumer secret of the connected application that you created.
    - Client ID - The consumer key of the connected application that you created.
    - API URL - The instance URL for your organization.
    - Timeout - Timeout duration of the API request.
    - Username - The username for the salesforce.
    - Password - The password for Salesforce (need to append the password with security key).
    - Blocking - Set to true to perform the blocking invocations to Salesforce.
    
    Following values can be provided to connect to Salesforce. <br/>
    
    - Connection Name - SALESFORCEREST_CONNECTION_1
    - Connection Type - Init Saleforcerest Connection
    - Access Token - &lt;your_salesforce_access_token&gt;
    - API Version - v59.0.
    - Host Name - https://login.salesforce.com
    - Refresh Token - &lt;your_salesforce_refresh_token&gt;
    - Refresh Token Endpoint - &lt;your_salesforce_refresh_token_endpoint&gt;
    - Client Secret - &lt;your_salesforce_client_secret&gt;
    - Client ID - &lt;your_salesforce_client_id&gt;
    - API URL - https://&lt;your_salesforce_instance_name&gt;.salesforce.com
    - Timeout - 30000
    - Username - &lt;your_salesforce_username&gt;
    - Password - &lt;your_salesforce_password&gt;
    - Blocking - false
      
    <img src="{{base_path}}/assets/img/integrate/connectors/salesforcerest-connector-3.png" title="Connection parameters." width="600" alt="Connection parameters."/>

5. After the connection is successfully created, select the created connection as 'Connection' from the drop down in the properties window. 
    
    <img src="{{base_path}}/assets/img/integrate/connectors/salesforcerest-connector-4.png" title="Selecting the connection." width="800" alt="Selecting the connection."/>
   
6. Set up the create operation.

    1. By using this `create` operation we are going to create an `sObject` in the Salesforce account. An `sObject` represents a specific table in the database that you can discretely query. It describes the individual metadata for the specified object. Please find the `create` operation parameters listed here.

        - **sObjectName** : Name of the sObject that you need to create in Salesforce.
        - **fieldAndValue** : The field and value you need to store in the created Salesforce sObject.

    2. While invoking the API, the above two parameters values come as a user input. You can provide the expressions as below in the properties window to obtain respective values from the JSON request payload.

        - sObject Name - json-eval($.sObjectName)
        - Field and Value - json-eval($.fieldAndValue)
          
         <img src="{{base_path}}/assets/img/integrate/connectors/salesforcerest-connector-6.png" title="Configure create operation." width="800" alt="Configure create operation."/>


7. Set up the retrieve operation.

    1. To retrieve data from the created objects in the Salesforce account, you need to add the `query` operation next to the `create` operation. Please find the `query` operation parameters listed here.

        - **queryString** :  This variable contains specified SOQL query. In this sample this SOQL query executes to retrieve `id` and `name` from created `Account`. If the query results are too large, the response contains the first batch of results.

    2. Navigate into the **Palette** pane and select the graphical operations icons listed under **Salesforce Connector** section. Then drag and drop the `query` operation into the Design pane.
        <img src="{{base_path}}/assets/img/integrate/connectors/salesforcerest-connector-5.png" title="Add query operation." width="800" alt="Add query operation."/>

    3. Select the query operation and add the `Connection` and `id, name from Account` query string to the properties section shown as bellow.
        <img src="{{base_path}}/assets/img/integrate/connectors/salesforcerest-connector-7.png" title="Configure query operation." width="800" alt="Configure query operation."/>

8. Finally, drag and drop the [Respond Mediator]({{base_path}}/reference/mediators/respond-mediator/) to send the message back to the client as a response.
   <img src="{{base_path}}/assets/img/integrate/connectors/salesforcerest-connector-8.png" title="Add respond mediator." width="800" alt="Add respond mediator."/>

9. Now, you can switch into the Source view and check the complete XML configuration files of the created API and the Local Entry.
   
    ??? note "salesforcerest.xml"
        ```
        <?xml version="1.0" encoding="UTF-8"?>
        <api context="/salesforcerest" name="salesforcerest" xmlns="http://ws.apache.org/ns/synapse">
            <resource methods="POST">
                <inSequence>
                    <salesforcerest.create configKey="SALESFORCEREST_CONNECTION_1">
                        <sObjectName>{json-eval($.sObjectName)}</sObjectName>
                        <fieldAndValue>{json-eval($.fieldAndValue)}</fieldAndValue>
                    </salesforcerest.create>
                    <salesforcerest.query configKey="SALESFORCEREST_CONNECTION_1">
                        <queryString>id, name from Account</queryString>
                    </salesforcerest.query>
                    <respond/>
                </inSequence>
                <outSequence/>
                <faultSequence/>
            </resource>
        </api>
        ```

    ??? note "SALESFORCEREST_CONNECTION_1.xml"   
        ```
        <?xml version="1.0" encoding="UTF-8"?>
        <localEntry key="SALESFORCEREST_CONNECTION_1" xmlns="http://ws.apache.org/ns/synapse">
            <salesforcerest.init>
                <hostName>https://login.salesforce.com</hostName>
                <connectionType>init</connectionType>
                <timeout>3000</timeout>
                <apiVersion>v59.0</apiVersion>
                <apiUrl>https://xxxx.salesforce.com</apiUrl>
                <clientSecret>xxxx</clientSecret>
                <clientId>xxxx</clientId>
                <name>SALESFORCEREST_CONNECTION_1</name>
                <refreshToken>xxxx</refreshToken>
            </salesforcerest.init>
        </localEntry>
        ```

## Get the project

You can download the ZIP file and extract the contents to get the project code.

<a href="{{base_path}}/assets/attachments/connectors/salesforcerest.zip">
    <img src="{{base_path}}/assets/img/integrate/connectors/download-zip.png" width="200" alt="Download ZIP">
</a>

!!! tip
    You may need to update the value of the access token/refresh token and make other such changes before deploying and running this project.

## Deployment

Follow these steps to deploy the exported CApp in the integration runtime.

{!includes/reference/connectors/deploy-capp.md!}

## Testing
Save a file called data.json with the following payload.

```json
{
	"sObjectName":"Account",
	"fieldAndValue": {
        "name": "Engineers",
        "description":"This Account belongs to WSO2"
    }
}
```

Invoke the API as shown below using the curl command. Curl application can be downloaded from [here](https://curl.haxx.se/download.html).


```
curl -X POST -d @data.json http://localhost:8280/salesforcerest --header "Content-Type:application/json"
```

You will get a set of account names and the respective IDs as the output.

## What's Next

* To customize this example for your own scenario, see [Salesforce REST Connector Configuration]({{base_path}}/reference/connectors/salesforce-connectors/sf-rest-connector-config-v2) documentation for all operation details of the connector.
