# Amazon DynamoDB Connector Example

 Amazon DynamoDB Connector allows you to access the [Amazon DynamoDB REST API](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/HowItWorks.API.html) through WSO2 EI.

## What you'll build

Given below is a sample scenario that demonstrates how to work with the WSO2 EI Amazon DynamoDB Connector and how to perform various `table` and `items` operations with Amazon DynamoDB.

This example explains how to use Amazon DynamoDB Connector to:

1. Create a table (a location for storing employee details) in Amazon DynamoDB.
2. Insert employee details (items) in to the created table.
3. Update employee details table.
4. Retrieve information about the inserted employee details (items).
5. Remove inserted employee details (items).
6. Retrieve list of tables.
7. Remove created employee details table.

All seven operations are exposed via an API. The API with the context `/resources` has seven resources

* `/addtable` : Creates a new table in the Amazon DynamoDB with the specified table name to store employee details.
* `/insertdetails` : Insert employee data (items) and store in the specified table.
* `/updatetable` : Update specified table (provisioned throughput settings, global secondary indexes, or DynamoDB Streams settings for a specified table).
* `/listdetails` : Retrieve information about the added employee details (items).
* `/deletedetails` : Remove added employee details from the specified table (items).
* `/listtable` : Retrieve information about the created tables.
* `/deletetable` : Remove created table in the Amazon DynamoDB.

For more information about these operations, please refer to the [Amazon DynamoDB connector reference guide]({{base_path}}/reference/connectors/amazondynamodb-connector/amazondynamodb-connector-configuration/).

> **Note**: Before invoking the API, you need to configure message builders/formatters in deployment.toml. See [Setting up the Amazon DynamoDB Connector](amazondynamodb-connector-configuration/) documentation for more information.

The following diagram shows the overall solution. The user creates a table, stores some employee details (items) into the table, and then receives it back. To invoke each operation, the user uses the same API. 

<img src="{{base_path}}/assets/img/integrate/connectors/amazon-dynamodb-connector-example.png" title="Amazon DynamoDB connector example" width="800" alt="Amazon DynamoDB connector example"/>

If you do not want to configure this yourself, you can simply [get the project](#get-the-project) and run it.

## Configure the connector in WSO2 Integration Studio

Connectors can be added to integration flows in [WSO2 Integration Studio](https://wso2.com/integration/integration-studio/), which is the tooling component of WSO2 EI. Once added, the operations of the connector can be dragged onto your canvas and added to your resources.

### Import the connector

Follow these steps to set up the Integration Project and the Connector Exporter Project.  

{!reference/connectors/importing-connector-to-integration-studio.md!} 

### Add integration logic

First create an API, which will be where we configure the integration logic. Right click on the created Integration Project and select, **New** -> **Rest API** to create the REST API. Specify the API name as `amazonDynamoDBAPI` and API context as `/resources`.
    
<img src="{{base_path}}/assets/img/integrate/connectors/adding-an-api.png" title="Adding a Rest API" width="800" alt="Adding a Rest API"/>

#### Configuring the API

Now follow the steps below to add resources to the API.

#### Configure a resource for the addtable operation

1. Initialize the connector.
    
    1. Navigate into the **Palette** pane and select the graphical operations icons listed under **Amazondynamodb Connector** section. Then drag and drop the `init` operation into the Design pane.
        
        <img src="{{base_path}}/assets/img/integrate/connectors/amazon-dynamodb-api-init.png" title="Drag and drop init operation" width="500" alt="Drag and drop init operation"/>   
    
    2. Add the property values into the `init` operation as shown below. Replace the `region`, `accessKeyId`, `secretAccessKey`, `blocking` with your values.
        
       - **region** : The region of the application access.
       - **accessKeyId** : The AWS secret access key.
       - **secretAccessKey** : The AWS accessKeyId of the user account to generate the signature.
       - **blocking** : Boolean type, this property helps the connector perform blocking invocations to AmazonDynamoDB. 
    
        <img src="{{base_path}}/assets/img/integrate/connectors/amazon-dynamodb-api-init-operation.png" title="Add values to the init operation" width="800" alt="Add values to the init operation"/>

2. Set up the createTable operation.

    1. Navigate into the **Palette** pane and select the graphical operations icons listed under **Amazondynamodb Connector** section. Then drag and drop the `createTable` operation into the Design pane.
           
        <img src="{{base_path}}/assets/img/integrate/connectors/amazon-dynamodb-drag-and-drop-create-table.png" title="Drag and drop create table operation" width="500" alt="Drag and drop create table operation"/>    

    2. The createTable operation creates a new table. Table names must be unique within each region. The `createTable` operation parameters are listed here.
               
       - **attributeDefinitions** : A list of attributes that describe the key schema for the table and indexes. If you are adding a new global secondary index to the table, AttributeDefinitions should include the key element(s) of the new index. 
       - **tableName** : The name of the table to create. 
       - **keySchema** : Specifies the attributes that make up the primary key for a table or an index. The attributes in keySchema must also be defined in attributeDefinitions.
       - **localSecondaryIndexes** : One or more local secondary indexes (the maximum is five) to be created on the table. Each index is scoped to a given partition key value. There is a 10 GB size limit per partition key value. Alternately, the size of a local secondary index is unconstrained. 
       - **provisionedThroughput** : Represents the provisioned throughput setting for a specified table or index.
        
        While invoking the API, the above five parameter values come as a user inputs.
        
        <img src="{{base_path}}/assets/img/integrate/connectors/amazon-dynamodb-drag-and-drop-create-table-parameters.png" title="Drag and drop create table operation" width="500" alt="Drag and drop create table operation"/> 
    
    3. To get the input values in to the API we can use the [property mediator]({{base_path}}/reference/mediators/property-mediator). Navigate into the **Palette** pane and select the graphical mediators icons listed under the **Mediators** section. Then drag and drop the `Property` mediators into the Design pane as shown below.
    
        <img src="{{base_path}}/assets/img/integrate/connectors/amazon-dynamodb-drag-and-drop-property-mediator.png" title="Add property mediators" width="800" alt="Add property mediators"/>

        The parameters available for configuring the Property mediator are as follows:
    
        > **Note**: That the properties should be add to the pallet before create the operation.
    
    4. Add the property mediator to capture the `attributeDefinitions` value.  
   
       - **name** : attributeDefinitions
       - **expression** : json-eval($.attributeDefinitions)
   
        <img src="{{base_path}}/assets/img/integrate/connectors/amazon-dynamodb-property-mediator-property1-value1.png" title="Add property mediators attributeDefinitions" width="600" alt="Add property mediators attributeDefinitions"/>
    
    5. Add the property mediator to capture the `tableName` values.                 
   
       - **name** : tableName
       - **expression** : json-eval($.tableName)
     
        <img src="{{base_path}}/assets/img/integrate/connectors/amazon-dynamodb-property-mediator-property2-value2.png" title="Add values to capture tableName" width="600" alt="Add values to capture tableName"/>  
      
    6. Add the property mediator to capture the `keySchema` values.                   
       
       - **name** : keySchema
       - **expression** : json-eval($.keySchema)
                 
        <img src="{{base_path}}/assets/img/integrate/connectors/amazon-dynamodb-property-mediator-property3-value3.png" title="Add values to capture keySchema" width="600" alt="Add values to capture keySchema"/>  

    7. Add the property mediator to capture the `localSecondaryIndexes` values.                 
       
       - **name** : localSecondaryIndexes
       - **expression** : json-eval($.localSecondaryIndexes)
         
        <img src="{{base_path}}/assets/img/integrate/connectors/amazon-dynamodb-property-mediator-property4-value4.png" title="Add values to capture localSecondaryIndexes" width="600" alt="Add values to capture localSecondaryIndexes"/>  
          
    8. Add the property mediator to capture the `provisionedThroughput` values.                   
           
       - **name** : provisionedThroughput
       - **expression** : json-eval($.provisionedThroughput)
                     
        <img src="{{base_path}}/assets/img/integrate/connectors/amazon-dynamodb-property-mediator-property5-value5.png" title="Add values to capture provisionedThroughput" width="600" alt="Add values to capture provisionedThroughput"/>  
    
#### Configure a resource for the insertdetails operation

1. Initialize the connector.
   
   You can use the same configuration to initialize the connector. Please follow the steps given in 1.1 for setting up the `init` operation to the addtable operation.
   
2. Set up the putItem operation.

    1. Navigate into the **Palette** pane and select the graphical operations icons listed under **Amazondynamodb Connector** section. Then drag and drop the `putItem` operation into the Design pane.
           
        <img src="{{base_path}}/assets/img/integrate/connectors/amazon-dynamodb-drag-and-drop-put-items.png" title="Drag and drop create put items operation" width="500" alt="Drag and drop put items operation"/>    

    2. The putItem operation use to insert new items to the tables. `putItem` operation parameters listed here.
               
       - **item** : A map of attribute name/value pairs, one for each attribute. Only the primary key attributes are required, but you can optionally provide other attribute name-value pairs for the item 
       - **tableName** :  The name of the table to contain the item. 
        
        While invoking the API, the above two parameter values come as a user inputs.
        
        <img src="{{base_path}}/assets/img/integrate/connectors/amazon-dynamodb-drag-and-drop-put-items-table-parameters.png" title="Drag and drop put items table operation" width="500" alt="Drag and drop put items table operation"/> 
    
    3. Then drag and drop the `Property` mediators into the Design pane as mentioned in `addtable` operation. The parameters available for configuring the Property mediator are as follows.
             
       Add the property mediator to capture the `item` value.  
   
       - **name** : item
       - **expression** : json-eval($.item)
   
        <img src="{{base_path}}/assets/img/integrate/connectors/amazon-dynamodb-property-mediator-put-items-table-property1-value1.png" title="Add property mediators to capture item" width="600" alt="Add property mediators to capture item"/>
    
    4. Add the property mediator to capture the `tableName` values. Please follow the steps given in `addtable` operation.               
   
       - **name** : tableName
       - **expression** : json-eval($.tableName)     
     
#### Configure a resource for the updatetable operation

1. Initialize the connector.
   
   You can use the same configuration to initialize the connector. Please follow the steps given in 1.1 for setting up the `init` operation to the addtable operation.
   
2. Set up the updateTable operation.

    1. Navigate into the **Palette** pane and select the graphical operations icons listed under **Amazondynamodb Connector** section. Then drag and drop the `updateTable` operation into the Design pane.
           
        <img src="{{base_path}}/assets/img/integrate/connectors/amazon-dynamodb-drag-and-drop-update-table.png" title="Drag and drop create put items operation" width="500" alt="Drag and drop put items operation"/>    

    2. The updateTable operation is used to update the created tables. The `updateTable` operation parameters are listed here.
               
       - **provisionedThroughput** : The new provisioned throughput setting for the specified table or index. 
       - **tableName** :  The name of the table to contain the item. 
        
        While invoking the API, the above two parameter values come as a user inputs.
        
        <img src="{{base_path}}/assets/img/integrate/connectors/amazon-dynamodb-drag-and-drop-update-table-parameters.png" title="Drag and drop put items table operation" width="500" alt="Drag and drop put items table operation"/> 
    
    3. Then drag and drop the `Property` mediators into the Design pane as mentioned in the `addtable` operation. The parameters available for configuring the Property mediator are as follows.
        
       Add the property mediator to capture the `provisionedThroughput` value.  
   
       - **name** : provisionedThroughput
       - **expression** : json-eval($.provisionedThroughput)
   
        <img src="{{base_path}}/assets/img/integrate/connectors/amazon-dynamodb-property-mediator-update-table-property1-value1.png" title="Add property mediators to capture provisionedThroughput" width="600" alt="Add property mediators to capture provisionedThroughput"/>
    
    4. Add the property mediator to capture the `tableName` values. Please follow the steps given in `addtable` operation.               
   
       - **name** : tableName
       - **expression** : json-eval($.tableName)

#### Configure a resource for the listdetails operation

1. Initialize the connector.
   
   You can use the same configuration to initialize the connector. Please follow the steps given in 1.1 for setting up the `init` operation to the addtable operation.
   
2. Set up the getItem operation.

    1. Navigate into the **Palette** pane and select the graphical operations icons listed under **Amazondynamodb Connector** section. Then drag and drop the `getItem` operation into the Design pane.
           
        <img src="{{base_path}}/assets/img/integrate/connectors/amazon-dynamodb-drag-and-drop-get-item.png" title="Drag and drop create get items operation" width="500" alt="Drag and drop get items operation"/>    

    2. The getItem operation is used to retrieve inserted items to the tables. The `getItem` operation parameters are listed here.
               
       - **key** : An array of primary key attribute values that define specific items in the table. For each primary key, you must provide all of the key attributes. 
       - **tableName** :  The name of the table to contain the item. 
        
        While invoking the API, the above two parameter values come as a user inputs.
        
        <img src="{{base_path}}/assets/img/integrate/connectors/amazon-dynamodb-drag-and-drop-get-item-parameters.png" title="Drag and drop put items table operation" width="500" alt="Drag and drop put items table operation"/> 
    
    3. Then drag and drop the `Property` mediators into the Design pane as mentioned in `addtable` operation. The parameters available for configuring the Property mediator are as follows.
                
       Add the property mediator to capture the `key` value.  
   
       - **name** : key
       - **expression** : json-eval($.key)
   
        <img src="{{base_path}}/assets/img/integrate/connectors/amazon-dynamodb-property-mediator-get-item-property1-value1.png" title="Add property mediators to capture key" width="600" alt="Add property mediators to capture key"/>
    
    4. Add the property mediator to capture the `tableName` values. Please follow the steps given in `addtable` operation.               
   
       - **name** : tableName
       - **expression** : json-eval($.tableName)        
         
#### Configure a resource for the deletedetails operation

1. Initialize the connector.
   
   You can use the same configuration to initialize the connector. Please follow the steps given in 1.1 for setting up the `init` operation to the addtable operation.
   
2. Set up the deleteItem operation.

    1. Navigate into the **Palette** pane and select the graphical operations icons listed under **Amazondynamodb Connector** section. Then drag and drop the `deleteItem` operation into the Design pane.
           
        <img src="{{base_path}}/assets/img/integrate/connectors/amazon-dynamodb-drag-and-drop-delete-item.png" title="Drag and drop create get items operation" width="500" alt="Drag and drop get items operation"/>    

    2. The deleteItem operation is used to remove inserted items from the table. The `deleteItem` operation parameters are listed here.
               
       - **key** : An array of primary key attribute values that define specific items in the table. For each primary key, you must provide all of the key attributes. 
       - **tableName** :  The name of the table to contain the item.
       - **returnConsumedCapacity** : Determines the level of detail about provisioned throughput consumption that is returned in the response.
       - **returnValues** : Use returnValues if you want to get the item attributes as they appeared before they were deleted.
        
        While invoking the API, the above two parameter values (key, tableName) come as a user inputs.
        
        <img src="{{base_path}}/assets/img/integrate/connectors/amazon-dynamodb-drag-and-drop-delete-item-parameters.png" title="Drag and drop put items table operation" width="500" alt="Drag and drop put items table operation"/> 
    
    3. Then drag and drop the `Property` mediators into the Design pane as mentioned in the `addtable` operation. The parameters available for configuring the Property mediator are as follows.
                
       Add the property mediator to capture the `key` value.  Please follow the steps given in `listdetails` operation.
   
       - **name** : key
       - **expression** : json-eval($.key)
       
    4. Add the property mediator to capture the `tableName` values. Please follow the steps given in `listdetails` operation.               
   
       - **name** : tableName
       - **expression** : json-eval($.tableName)     
        
#### Configure a resource for the listtable operation

1. Initialize the connector.
   
   You can use the same configuration to initialize the connector. Please follow the steps given in 1.1 for setting up the `init` operation to the addtable operation.
   
2. Set up the listTables operation.

    1. Navigate into the **Palette** pane and select the graphical operations icons listed under **Amazondynamodb Connector** section. Then drag and drop the `listTables` operation into the Design pane.
           
        <img src="{{base_path}}/assets/img/integrate/connectors/amazon-dynamodb-drag-and-drop-list-table.png" title="Drag and drop list table operation" width="500" alt="Drag and drop list table operation"/>    

    2. The listTables operation use to retrieve information about the created tables. `listTables` operation parameters listed here.
               
       - **exclusiveStartTableName** : The first table name that the listTables operation evaluates. Use the value returned for LastEvaluatedTableName. 
       - **limit** : The maximum number of table names to retrieve. If this parameter is not specified, the limit is 100.
       
        While invoking the API, the above two parameter values come as a user inputs.
       
        <img src="{{base_path}}/assets/img/integrate/connectors/amazon-dynamodb-drag-and-drop-list-table-parameters.png" title="Drag and drop list table parameter operation" width="500" alt="Drag and drop list table parameter operation"/> 
    
    3. Then drag and drop the `Property` mediators into the Design pane as mentioned in `addtable` operation. The parameters available for configuring the Property mediator are as follows.
        
       Add the property mediator to capture the `exclusiveStartTableName` value.  Please follow the steps given in the `listTables` operation.
   
       - **name** : exclusiveStartTableName
       - **expression** : json-eval($.exclusiveStartTableName)
        
        <img src="{{base_path}}/assets/img/integrate/connectors/amazon-dynamodb-property-mediator-list-table-property1-value1.png" title="Add property mediators to capture key" width="600" alt="Add property mediators to capture exclusiveStartTableName"/>
       
    4. Add the property mediator to capture the `limit` values. Please follow the steps given in the `listTables` operation.               
   
       - **name** : limit
       - **expression** : json-eval($.limit)               
         
        <img src="{{base_path}}/assets/img/integrate/connectors/amazon-dynamodb-property-mediator-list-table-property2-value2.png" title="Add property mediators to capture key" width="600" alt="Add property mediators to capture limit"/>
        
#### Configure a resource for the deletetable operation

1. Initialize the connector.
   
   You can use the same configuration to initialize the connector. Please follow the steps given in 1.1 for setting up the `init` operation to the addtable operation.
   
2. Set up the deleteTable operation.

    1. Navigate into the **Palette** pane and select the graphical operations icons listed under **Amazondynamodb Connector** section. Then drag and drop the `deleteTable` operation into the Design pane.
           
       <img src="{{base_path}}/assets/img/integrate/connectors/amazon-dynamodb-drag-and-drop-delete-table.png" title="Drag and drop list table operation" width="500" alt="Drag and drop list table operation"/>    

    2. The listTables operation is used to retrieve information about the created tables. The `deleteTable` operation parameters are listed here.
               
       - **exclusiveStartTableName** : The first table name that the listTables operation evaluates. Use the value returned for LastEvaluatedTableName. 
       - **limit** : The maximum number of table names to retrieve. If this parameter is not specified, the limit is 100.
       
        While invoking the API, the above two parameter values come as user inputs.
        
        <img src="{{base_path}}/assets/img/integrate/connectors/amazon-dynamodb-drag-and-drop-delete-table-parameters.png" title="Drag and drop list table parameter operation" width="500" alt="Drag and drop list table parameter operation"/> 
    
    3. Then drag and drop the `Property` mediators into the Design pane as mentioned in `addtable` operation. The parameters available for configuring the Property mediator are as follows:
                
       Add the property mediator to capture the `tableName` value.  Please follow the steps given in the `deleteTable` and `listdetails` operations.
   
       - **name** : tableName
       - **expression** : json-eval($.tableName)
    
#### Get a response.   
 
When you are invoking the created API, the request of the message is going through the each resource. Finally, it is passed to the [Respond mediator]({{base_path}}/reference/mediators/respond-mediator/). The Respond Mediator stops the processing on the current message and sends the message back to the client as a response. 

Drag and drop **respond mediator** to the **Design view**.

<img src="{{base_path}}/assets/img/integrate/connectors/amazon-dynamodb-drag-and-drop-respond-mediator.png" title="Add Respond mediator" width="800" alt="Add Respond mediator"/> 
               
Now you can switch into the Source view and check the XML configuration files of the created API.         

??? note "amazonDynamoDBAPI.xml"
       ```
       <?xml version="1.0" encoding="UTF-8"?>
       <api xmlns="http://ws.apache.org/ns/synapse" context="/resources" name="amazonDynamoDBAPI">
          <resource methods="POST" url-mapping="/addtable">
             <inSequence>
                <property expression="json-eval($.attributeDefinitions)" name="attributeDefinitions" scope="default" type="STRING" />
                <property expression="json-eval($.tableName)" name="tableName" scope="default" type="STRING" />
                <property expression="json-eval($.keySchema)" name="keySchema" scope="default" type="STRING" />
                <property expression="json-eval($.localSecondaryIndexes)" name="localSecondaryIndexes" scope="default" type="STRING" />
                <property expression="json-eval($.provisionedThroughput)" name="provisionedThroughput" scope="default" type="STRING" />
                <amazondynamodb.init>
                   <region>us-east-2</region>
                   <accessKeyId>AKIAY4QELOL7GF35XBW5</accessKeyId>
                   <secretAccessKey>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</secretAccessKey>
                   <blocking>false</blocking>
                </amazondynamodb.init>
                <amazondynamodb.createTable>
                   <attributeDefinitions>{$ctx:attributeDefinitions}</attributeDefinitions>
                   <tableName>{$ctx:tableName}</tableName>
                   <keySchema>{$ctx:keySchema}</keySchema>
                   <localSecondaryIndexes>{$ctx:localSecondaryIndexes}</localSecondaryIndexes>
                   <provisionedThroughput>{$ctx:provisionedThroughput}</provisionedThroughput>
                </amazondynamodb.createTable>
                <respond />
             </inSequence>
             <outSequence>
                <send />
             </outSequence>
             <faultSequence />
          </resource>
          <resource methods="POST" url-mapping="/insertdetails">
             <inSequence>
                <property expression="json-eval($.item)" name="item" scope="default" type="STRING" />
                <property expression="json-eval($.tableName)" name="tableName" scope="default" type="STRING" />
                <amazondynamodb.init>
                   <region>us-east-2</region>
                   <accessKeyId>AKIAY4QELOL7GF35XBW5</accessKeyId>
                   <secretAccessKey>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</secretAccessKey>
                   <blocking>false</blocking>
                </amazondynamodb.init>
                <amazondynamodb.putItem>
                   <item>{$ctx:item}</item>
                   <tableName>{$ctx:tableName}</tableName>
                </amazondynamodb.putItem>
                <respond />
             </inSequence>
             <outSequence>
                <send />
             </outSequence>
             <faultSequence />
          </resource>
          <resource methods="POST" url-mapping="/deletedetails">
             <inSequence>
                <property expression="json-eval($.key)" name="key" scope="default" type="STRING" />
                <property expression="json-eval($.tableName)" name="tableName" scope="default" type="STRING" />
                <amazondynamodb.init>
                   <region>us-east-2</region>
                   <accessKeyId>AKIAY4QELOL7GF35XBW5</accessKeyId>
                   <secretAccessKey>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</secretAccessKey>
                   <blocking>false</blocking>
                </amazondynamodb.init>
                <amazondynamodb.deleteItem>
                   <key>{$ctx:key}</key>
                   <tableName>{$ctx:tableName}</tableName>
                   <returnConsumedCapacity>TOTAL</returnConsumedCapacity>
                   <returnValues>ALL_OLD</returnValues>
                </amazondynamodb.deleteItem>
                <respond />
             </inSequence>
             <outSequence>
                <send />
             </outSequence>
             <faultSequence />
          </resource>
          <resource methods="POST" url-mapping="/listdetails">
             <inSequence>
                <property expression="json-eval($.key)" name="key" scope="default" type="STRING" />
                <property expression="json-eval($.tableName)" name="tableName" scope="default" type="STRING" />
                <amazondynamodb.init>
                   <region>us-east-2</region>
                   <accessKeyId>AKIAY4QELOL7GF35XBW5</accessKeyId>
                   <secretAccessKey>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</secretAccessKey>
                   <blocking>false</blocking>
                </amazondynamodb.init>
                <amazondynamodb.getItem>
                   <key>{$ctx:key}</key>
                   <tableName>{$ctx:tableName}</tableName>
                </amazondynamodb.getItem>
                <respond />
             </inSequence>
             <outSequence>
                <send />
             </outSequence>
             <faultSequence />
          </resource>
          <resource methods="POST" url-mapping="/listtable">
             <inSequence>
                <property expression="json-eval($.exclusiveStartTableName)" name="exclusiveStartTableName" scope="default" type="STRING" />
                <property expression="json-eval($.limit)" name="limit" scope="default" type="STRING" />
                <amazondynamodb.init>
                   <region>us-east-2</region>
                   <accessKeyId>AKIAY4QELOL7GF35XBW5</accessKeyId>
                   <secretAccessKey>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</secretAccessKey>
                   <blocking>false</blocking>
                </amazondynamodb.init>
                <amazondynamodb.listTables>
                   <exclusiveStartTableName>{$ctx:exclusiveStartTableName}</exclusiveStartTableName>
                   <limit>{$ctx:limit}</limit>
                </amazondynamodb.listTables>
                <respond />
             </inSequence>
             <outSequence>
                <send />
             </outSequence>
             <faultSequence />
          </resource>
          <resource methods="POST" url-mapping="/updatetable">
             <inSequence>
                <property expression="json-eval($.tableName)" name="tableName" scope="default" type="STRING" />
                <property expression="json-eval($.provisionedThroughput)" name="provisionedThroughput" scope="default" type="STRING" />
                <amazondynamodb.init>
                   <region>us-east-2</region>
                   <accessKeyId>AKIAY4QELOL7GF35XBW5</accessKeyId>
                   <secretAccessKey>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</secretAccessKey>
                   <blocking>false</blocking>
                </amazondynamodb.init>
                <amazondynamodb.updateTable>
                   <tableName>{$ctx:tableName}</tableName>
                   <provisionedThroughput>{$ctx:provisionedThroughput}</provisionedThroughput>
                </amazondynamodb.updateTable>
                <respond />
             </inSequence>
             <outSequence>
                <send />
             </outSequence>
             <faultSequence />
          </resource>
          <resource methods="POST" url-mapping="/deletetable">
             <inSequence>
                <property expression="json-eval($.tableName)" name="tableName" scope="default" type="STRING" />
                <amazondynamodb.init>
                   <region>us-east-2</region>
                   <accessKeyId>AKIAY4QELOL7GF35XBW5</accessKeyId>
                   <secretAccessKey>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</secretAccessKey>
                   <blocking>false</blocking>
                </amazondynamodb.init>
                <amazondynamodb.deleteTable>
                   <tableName>{$ctx:tableName}</tableName>
                </amazondynamodb.deleteTable>
                <respond />
             </inSequence>
             <outSequence>
                <send />
             </outSequence>
             <faultSequence />
          </resource>
       </api>
       ```        
## Get the project

You can download the ZIP file and extract the contents to get the project code.

<a href="{{base_path}}/assets/attachments/connectors/amazondynamodb-connector.zip">
    <img src="{{base_path}}/assets/img/integrate/connectors/download-zip.png" width="200" alt="Download ZIP">
</a>

## Deployment

Follow these steps to deploy the exported CApp in the Enterprise Integrator Runtime. 

{!reference/connectors/deploy-capp.md!}   

## Testing

Invoke the API as shown below using the curl command. Curl Application can be downloaded from [here](https://curl.haxx.se/download.html).

1. Creating a new table in the Amazon DynamoDB with the specified table name for store employee details.
 
   **Sample request**
   
   Save a file called data.json with the following payload. 
   
   ```json
   {
      "attributeDefinitions":[
         {
            "AttributeName":"employee_id",
            "AttributeType":"S"
         },
         {
            "AttributeName":"name",
            "AttributeType":"S"
         },
         {
            "AttributeName":"department",
            "AttributeType":"S"
         }
      ],
      "tableName":"Employee_Details",
      "keySchema":[
         {
            "AttributeName":"employee_id",
            "KeyType":"HASH"
         },
         {
            "AttributeName":"name",
            "KeyType":"RANGE"
         }
      ],
      "localSecondaryIndexes":[
         {
            "IndexName":"department",
            "KeySchema":[
               {
                  "AttributeName":"employee_id",
                  "KeyType":"HASH"
               },
               {
                  "AttributeName":"department",
                  "KeyType":"RANGE"
               }
            ],
            "Projection":{
               "ProjectionType":"KEYS_ONLY"
            }
         }
      ],
      "provisionedThroughput":{
         "ReadCapacityUnits":5,
         "WriteCapacityUnits":5
      }
   } 
   ```
   
   Invoke the API as shown below using the curl command.
   ```
   curl -v POST -d @data.json "http://localhost:8290/resources/addtable" -H "Content-Type:application/json"
   ```

   **Expected Response**
    
   ```json
   {
      "TableDescription":{
         "AttributeDefinitions":[
            {
               "AttributeName":"department",
               "AttributeType":"S"
            },
            {
               "AttributeName":"employee_id",
               "AttributeType":"S"
            },
            {
               "AttributeName":"name",
               "AttributeType":"S"
            }
         ],
         "CreationDateTime":1590068547.564,
         "ItemCount":0,
         "KeySchema":[
            {
               "AttributeName":"employee_id",
               "KeyType":"HASH"
            },
            {
               "AttributeName":"name",
               "KeyType":"RANGE"
            }
         ],
         "LocalSecondaryIndexes":[
            {
               "IndexArn":"arn:aws:dynamodb:us-east-2:610968236798:table/Employee_Details/index/department",
               "IndexName":"department",
               "IndexSizeBytes":0,
               "ItemCount":0,
               "KeySchema":[
                  {
                     "AttributeName":"employee_id",
                     "KeyType":"HASH"
                  },
                  {
                     "AttributeName":"department",
                     "KeyType":"RANGE"
                  }
               ],
               "Projection":{
                  "ProjectionType":"KEYS_ONLY"
               }
            }
         ],
         "ProvisionedThroughput":{
            "NumberOfDecreasesToday":0,
            "ReadCapacityUnits":5,
            "WriteCapacityUnits":5
         },
         "TableArn":"arn:aws:dynamodb:us-east-2:610968236798:table/Employee_Details",
         "TableId":"10520308-ae1e-4742-b9d4-fc6aae67191e",
         "TableName":"Employee_Details",
         "TableSizeBytes":0,
         "TableStatus":"CREATING"
      }
   }
    
   ```
   
2. Insert employee details (items) and stored into the specified table.
   
   **Sample request**
   
   Save a file called data.json with the following payload.
   
   ```json
   {
      "tableName":"Employee_Details",
      "item":{
         "employee_id":{
            "S":"001"
         },
         "name":{
            "S":"Jhone Fedrick"
         },
         "department":{
            "S":"Engineering"
         }
      }
   }
   ```
   
   Invoke the API as shown below using the curl command.
   
   ```
   curl -v POST -d @data.json "http://localhost:8290/resources/insertdetails" -H "Content-Type:application/json"
   ```
   
   **Expected Response**
   
   ``` 
   {}
   ``` 
3. Update specified table.
   
   **Sample request**
   
   Save a file called data.json with the following payload.
   
   ```json
   {
      "tableName":"Employee_Details",
      "provisionedThroughput":{
         "ReadCapacityUnits":12,
         "WriteCapacityUnits":12
      }
   }
   ```
   
   Invoke the API as shown below using the curl command.
   
   ```
   curl -v POST -d @data.json "http://localhost:8290/resources/updatetable" -H "Content-Type:application/json"
   ```
   
   **Expected Response**
   
   ```json
   {
      "TableDescription":{
         "AttributeDefinitions":[
            {
               "AttributeName":"department",
               "AttributeType":"S"
            },
            {
               "AttributeName":"employee_id",
               "AttributeType":"S"
            },
            {
               "AttributeName":"name",
               "AttributeType":"S"
            }
         ],
         "CreationDateTime":1590068547.564,
         "ItemCount":0,
         "KeySchema":[
            {
               "AttributeName":"employee_id",
               "KeyType":"HASH"
            },
            {
               "AttributeName":"name",
               "KeyType":"RANGE"
            }
         ],
         "LocalSecondaryIndexes":[
            {
               "IndexArn":"arn:aws:dynamodb:us-east-2:610968236798:table/Employee_Details/index/department",
               "IndexName":"department",
               "IndexSizeBytes":0,
               "ItemCount":0,
               "KeySchema":[
                  {
                     "AttributeName":"employee_id",
                     "KeyType":"HASH"
                  },
                  {
                     "AttributeName":"department",
                     "KeyType":"RANGE"
                  }
               ],
               "Projection":{
                  "ProjectionType":"KEYS_ONLY"
               }
            }
         ],
         "ProvisionedThroughput":{
            "LastIncreaseDateTime":1590071461.81,
            "NumberOfDecreasesToday":0,
            "ReadCapacityUnits":5,
            "WriteCapacityUnits":5
         },
         "TableArn":"arn:aws:dynamodb:us-east-2:610968236798:table/Employee_Details",
         "TableId":"10520308-ae1e-4742-b9d4-fc6aae67191e",
         "TableName":"Employee_Details",
         "TableSizeBytes":0,
         "TableStatus":"UPDATING"
      }
   }
   ```

4. Retrieve information about the added employee details (items).
   
   **Sample request**
   
   Save a file called data.json with the following payload.
   
   ```json
   {
      "tableName":"Employee_Details",
      "key":{
         "employee_id":{
            "S":"001"
         },
         "name":{
            "S":"Jhone Fedrick"
         }
      }
   }
   ```
   
   Invoke the API as shown below using the curl command.
   
   ```
   curl -v POST -d @data.json "http://localhost:8290/resources/listdetails" -H "Content-Type:application/json"
   ```
   
   **Expected Response**
   
   ```json
   {
      "Item":{
         "department":{
            "S":"Engineering"
         },
         "name":{
            "S":"Jhone Fedrick"
         },
         "employee_id":{}
      }
   }
    
   ```
5. Remove added employee details from the specified table (items).
   
   **Sample request**
   
   Save a file called data.json with the following payload.
   
   ```json
   {
      "tableName":"Employee_Details",
      "key":{
         "employee_id":{
            "S":"001"
         },
         "name":{
            "S":"Jhone Fedrick"
         }
      }
   }
   ```
   
   Invoke the API as shown below using the curl command.
   
   ```
   curl -v POST -d @data.json "http://localhost:8290/resources/deletedetails" -H "Content-Type:application/json"
   ```
   
   **Expected Response**
   
   ```json
   {
      "Attributes":{
         "department":{
            "S":"Engineering"
         },
         "name":{
            "S":"Jhone Fedrick"
         },
         "employee_id":{
            "S":"001"
         }
      },
      "ConsumedCapacity":{
         "CapacityUnits":2,
         "TableName":"Employee_Details"
      }
   } 
   ```  
6. Retrieve information about the created tables.
   
   **Sample request**
   
   Save a file called data.json with the following payload.
   
   ```json
   {
      "exclusiveStartTableName":"Employee_Details",
      "limit":4
   }
   ```
   
   Invoke the API as shown below using the curl command.
   
   ```
   curl -v POST -d @data.json "http://localhost:8290/resources/listtable" -H "Content-Type:application/json"
   ```
   
   **Expected Response**
   
   ```json
   {
      "LastEvaluatedTableName":"TTestMyTablehread",
      "TableNames":[
         "Results",
         "Results1",
         "Results123",
         "TTestMyTablehread"
      ]
   } 
   ``` 
7. Remove created table in the Amazon DynamoDB.
   
   **Sample request**
   
   Save a file called data.json with the following payload.
   
   ```json
   {
   	"tableName":"Employee_Details"
   }
   
   ```
   
   Invoke the API as shown below using the curl command.
   
   ```
   curl -v POST -d @data.json " http://localhost:8290/resources/deletetable" -H "Content-Type:application/json"
   ```
   
   **Expected Response**
   
   ```json
   {
      "TableDescription":{
         "ItemCount":0,
         "ProvisionedThroughput":{
            "NumberOfDecreasesToday":0,
            "ReadCapacityUnits":12,
            "WriteCapacityUnits":12
         },
         "TableArn":"arn:aws:dynamodb:us-east-2:610968236798:table/Employee_Details",
         "TableId":"10520308-ae1e-4742-b9d4-fc6aae67191e",
         "TableName":"Employee_Details",
         "TableSizeBytes":0,
         "TableStatus":"DELETING"
      }
   }
   ```
## What's next

* You can deploy and run your project on Docker or Kubernetes. See the instructions in [Running the Micro Integrator on Containers]({{base_path}}/install-and-setup/installation/run_in_containers).