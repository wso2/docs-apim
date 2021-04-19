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

{!reference/connectors/importing-connector-to-integration-studio.md!} 

### Add integration logic

First create an API, which will be where we configure the integration logic. Right click on the created Integration Project and select, **New** -> **Rest API** to create the REST API. Specify the API name as `salesforcerest` and API context as `/salesforcerest`.
    
<img src="{{base_path}}/assets/img/integrate/connectors/adding-an-api.png" title="Adding a Rest API" width="800" alt="Adding a Rest API"/>

#### Configure a sequence for the create operation

Create the sequence needed to create Salesforce object. We will create two defined sequences called `create.xml` and  `retrieve.xml` to create an account and retrieve data. Right click on the created Integration Project and select, -> **New** -> **Sequence** to create the Sequence. 
  
<img src="{{base_path}}/assets/img/integrate/connectors/add-sequence.png" title="Adding a Sequnce" width="500" alt="Adding a Sequnce"/>

Now follow the steps below to add configurations to the sequence.
    
1. Initialize the connector.
    
    1. Follow these steps to [generate the Access Tokens for Salesforce]({{base_path}}/reference/connectors/salesforce-connectors/sf-access-token-generation/) and obtain the Client Id, Client Secret, Access Token, and Refresh Token.
    
    2. Navigate into the **Palette** pane and select the graphical operations icons listed under **Salesforce Connector** section. Then drag and drop the `init` operation into the Design pane.
        
        <img src="{{base_path}}/assets/img/integrate/connectors/salesforce-drag-and-drop-init.png" title="Drag and drop init operation" width="500" alt="Drag and drop init operation"/>
        
    3. Add the property values into the `init` operation as shown bellow. Replace the `clientSecret`, `clientId`, `accessToken`, `refreshToken` with obtained values from above steps.
      
        - **clientSecret** : Value of your client secret given when you registered your application with Salesforce.
        - **clientId** : Value of your client ID given when you registered your application with Salesforce.
        - **accessToken** : Value of the access token to access the API via request.
        - **refreshToken** : Value of the refresh token.
       
        <img src="{{base_path}}/assets/img/integrate/connectors/salesforce-api-init-operation-sequnce1.png" title="Add values to the init operation" width="800" alt="Add values to the init operation"/>
    
     
2. Set up the created operation.

    1. Setup the `create` sequence configurations. In this operation we are going to create a `sObjects` in the Salesforce account. An `SObject` represents a specific table in the database that you can discretely query. It describes the individual metadata for the specified object. Please find the `create` operation parameters listed here.
       
        - **sObjectName** : Name of the sObject which we need to create in the salesforce.
        - **fieldAndValue** : The field and value need to store in the created salesforce sObject.
        
        While invoking the API, the above two parameters values come as a user input.
    
    2. Navigate into the **Palette** pane and select the graphical operations icons listed under **Salesforce Connector** section. Then drag and drop the `create` operation into the Design pane.
    
        <img src="{{base_path}}/assets/img/integrate/connectors/salesforce-drag-and-drop-create.png" title="Drag and drop create operation" width="500" alt="Drag and drop create operations"/>
    
    3. To get the input values in to the API we can use the [property mediator]({{base_path}}/reference/mediators/property-mediator/). Navigate into the **Palette** pane and select the graphical mediators icons listed under **Mediators** section. Then drag and drop the `Property` mediators into the Design pane as shown bellow.
    
        <img src="{{base_path}}/assets/img/integrate/connectors/salesforce-api-drag-and-drop-property-mediator.png" title="Add property mediators" width="800" alt="Add property mediators"/>

        The parameters available for configuring the Property mediator are as follows:
    
        > **Note**: That the properties should be add to the pallet before create the operation.
    
    4. Add the property mediator to capture the `sObjectName` value.The sObjectName type can be used to retrieve the metadata for the Account object using the GET method, or create a new Account object using the POST method. In this example we are going to create a new Account object using the POST method.
   
        - **name** : sObjectName
        - **expression** : json-eval($.sObject)
        - **type** : STRING
   
        <img src="{{base_path}}/assets/img/integrate/connectors/salesforce-api-property-mediator-property1-value1.png" title="Add values to capture sObjectName value" width="600" alt="Add values to capture sObjectName value"/>
    
    5. Add the property mediator to capture the `fieldAndValue` values. The fieldAndValue contains object fields and values that user need to store.
   
        - **name** : fieldAndValue
        - **expression** : json-eval($.fieldAndValue)
        - **type** : STRING
     
        <img src="{{base_path}}/assets/img/integrate/connectors/salesforce-api-property-mediator-property2-value2.png" title="Add values to capture fieldAndValue value" width="600" alt="Add values to capture fieldAndValue value"/>  
    
#### Configure a sequence for the retrieve operation

Create the sequence to retrive the Salesforce objects created.

1. Initialize the connector.
    
    You can use the generated tokens to initialize the connector. Please follow the steps  given in 2.1 for setting up the `init` operation to the `retrive.xml` sequence. 
    
2. Set up the retrieve operation.

    1. To retrieve data from the created objects in the Salesforce account, you need to add the `query` operation to the `retrieve` sequence. 
    
        - **queryString** :  This variable contains specified SOQL query. In this sample this SOQL query executes to retrive `id` and `name` from created `Account`. If the query results are too large, the response contains the first batch of results.

    2. Navigate into the **Palette** pane and select the graphical operations icons listed under **Salesforce Connector** section. Then drag and drop the `query` operations into the Design pane.      
    
        <img src="{{base_path}}/assets/img/integrate/connectors/salesforce-drag-and-drop-query.png" title="Add query operation to retrive sequnce" width="500" alt="Add query operation to retrive sequnce"/> 
    
    3. Select the query operation and add `id, name from Account` query to the properties section shown as bellow.
    
        <img src="{{base_path}}/assets/img/integrate/connectors/salesforce-api-retrive-query-operation-sequnce1.png" title="Add query to the query operation in retrive sequnce" width="800" alt="Add query to the query operation in retrive sequnce"/>
    
#### Configuring the API

1. Configure the `salesforcerest API` using the created `create` and `retrive` sequences.
 
    Now you can select the API that we created initially. Navigate into the **Palette** pane and select the graphical operations icons listed under **Defined Sequences** section. Drag and drop the created `create` and `retrive` sequences to the Design pane.
    
    <img src="{{base_path}}/assets/img/integrate/connectors/salesforce-drag-and-drop-sequencestothe-designpane.png" title="Drag and drop sequences to the Design view" width="500" alt="Drag and drop sequences to the Design view"/> 
 
2. Get a response from the user.
    
    When you invoking the created API the request of the message is going through the `create` and `retrive` sequences. Finally pass to the the [Respond mediator]({{base_path}}/reference/mediators/respond-mediator/). In here the Respond Mediator stops the processing on the current message and sends the message back to the client as a response.            
    
    1. Drag and drop **respond mediator** to the **Design view**. 
    
        <img src="{{base_path}}/assets/img/integrate/connectors/salesforce-drag-and-drop-respond-mediator.png" title="Add Respond mediator" width="800" alt="Add Respond mediator"/> 

    2. Once you have setup the sequences and API, you can see the `salesforcerest` API as shown below.
    
        <img src="{{base_path}}/assets/img/integrate/connectors/salesforce-api-design-view.png" title="API Design view" width="600" alt="API Design view"/>
       
3.  Now you can switch into the Source view and check the XML configuration files of the created API and sequences. 

    ??? note "create.xml"
        ```
        <?xml version="1.0" encoding="UTF-8"?>
        <sequence name="create" trace="disable" xmlns="http://ws.apache.org/ns/synapse">
            <property expression="json-eval($.sObject)" name="sObject" scope="default" type="STRING"/>
            <property expression="json-eval($.fieldAndValue)" name="fieldAndValue" scope="default" type="STRING"/>
            <salesforcerest.init>
                <accessToken></accessToken>
                <apiVersion>v44.0</apiVersion>
                <hostName>https://login.salesforce.com</hostName>
                <refreshToken></refreshToken>
                <clientSecret></clientSecret>
                <clientId></clientId>
                <apiUrl>https://ap16.salesforce.com</apiUrl>
                <registryPath>connectors/SalesforceRest</registryPath>
            </salesforcerest.init>
            <salesforcerest.create>
                <sObjectName>{$ctx:sObject}</sObjectName>
                <fieldAndValue>{$ctx:fieldAndValue}</fieldAndValue>
            </salesforcerest.create>
        </sequence>
        ```

    ??? note "retrieve.xml"   
        ```
        <?xml version="1.0" encoding="UTF-8"?>
        <sequence name="retrieve" trace="disable" xmlns="http://ws.apache.org/ns/synapse">
            <salesforcerest.init>
                <accessToken></accessToken>
                <apiVersion>v44.0</apiVersion>
                <hostName>https://login.salesforce.com</hostName>
                <refreshToken></refreshToken>
                <clientSecret></clientSecret>
                <clientId></clientId>
                <apiUrl>https://ap16.salesforce.com</apiUrl>
                <registryPath>connectors/SalesforceRest</registryPath>
            </salesforcerest.init>
            <salesforcerest.query>
                <queryString>select id, name from Account</queryString>
            </salesforcerest.query>
        </sequence>
        ```

    ??? note "salesforcerest.xml"
        ```
        <?xml version="1.0" encoding="UTF-8"?>
        <api context="/salesforcerest" name="salesforcerest" xmlns="http://ws.apache.org/ns/synapse">
            <resource methods="POST">
                <inSequence>
                    <sequence key="create"/>
                    <sequence key="retrieve"/>
                    <respond/>
                </inSequence>
                <outSequence/>
                <faultSequence/>
            </resource>
        </api>
        ```

## Get the project

You can download the ZIP file and extract the contents to get the project code.

<a href="{{base_path}}/assets/attachments/connectors/salesforcerest.zip">
    <img src="{{base_path}}/assets/img/integrate/connectors/download-zip.png" width="200" alt="Download ZIP">
</a>

!!! tip
    You may need to update the value of the access token and make other such changes before deploying and running this project.

## Deployment

Follow these steps to deploy the exported CApp in the integration runtime. 

{!reference/connectors/deploy-capp.md!}

## Testing
Save a file called data.json with the following payload. 

```json
{
	"sObject":"Account",
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

* You can deploy and run your project on Docker or Kubernetes. See the instructions in [Running the Micro Integrator on Containers]({{base_path}}/install-and-setup/installation/run_in_containers).
* To customize this example for your own scenario, see [Salesforce REST Connector Configuration]({{base_path}}/reference/connectorssalesforce-connectors/sf-rest-connector-config/) documentation for all operation details of the connector.
