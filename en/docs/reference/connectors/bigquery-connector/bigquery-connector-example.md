# BigQuery Connector Example

The WSO2 EI BigQuery connector is mostly comprised of operations that are useful for retrieving BigQuery data such as project details, datasets, tables, and jobs (it has one operation that can be used to insert data into BigQuery tables).

In this example we are trying to build up a sample scenario based on the BigQuery Table operations.

## What you'll build

Given below is a sample scenario that demonstrates how to work with the WSO2 EI BigQuery Connector:

1. The user sends the request to invoke an API to get created table details from the BigQuery. This REST call will retrieve schema level information and send it back to the API caller.
2. Insert data in to the created table.
3. Retrieve inserted details from the BigQuery table.
4. Run an SQL query (BigQuery) and retrieve details from BigQuery table.

All four operations are exposed via an `bigquery-testAPI` API. The API with the context `/resources` has four resources.

* `/gettabledetails`: This is used to get get created table details from the BigQuery table by ID.
* `/insertdetails` : This is used to inserts the data into the table.
* `/getdetails` : This is used to retrieves table data from a specified set of rows.
* `/runQuery` : The runQuery operation runs an SQL query (BigQuery) and returns results if the query completes within a specified timeout.              

 > **Note**: Before starting this scenario, you need to create a **project** in BigQuery. Next, create a **Dataset** and under that Dataset you have to have **Table**. For more information about these operations, please refer to the [Setting up the BigQuery Environment]({{base_path}}/reference/connectors/bigquery-connector/bigquery-connector-configuration/). 

The following diagram shows the overall solution. User can invoke the table schema level details from the `gettabledetails` resource. Using the response details, the API caller can insert data into the created table. If users need to retrieve table data from a specified set of rows, they need to invoke the `getdetails` resource. Finally `/runQuery` resource runs an SQL query (BigQuery) and returns results back to the API caller.

<img src="{{base_path}}/assets/img/integrate/connectors/bigquery-example.png" title="BigQuery connector example" width="800" alt="BigQuery connector example"/>

If you do not want to configure this yourself, you can simply [get the project](#get-the-project) and run it.

## Configure the connector in WSO2 Integration Studio

Connectors can be added to integration flows in [WSO2 Integration Studio](https://wso2.com/integration/integration-studio/), which is the tooling component of WSO2 EI. Once added, the operations of the connector can be dragged onto your canvas and added to your resources.

### Import the connector

Follow these steps to set up the Integration Project and the Connector Exporter Project. 

{!reference/connectors/importing-connector-to-integration-studio.md!} 

### Add integration logic

First create an API, which will be where we configure the integration logic. Right click on the created Integration Project and select, **New** -> **Rest API** to create the REST API. Specify the API name as `bigquery-testAPI` and API context as `/resources`.
    
<img src="{{base_path}}/assets/img/integrate/connectors/adding-an-api.png" title="Adding a Rest API" width="800" alt="Adding a Rest API"/>

#### Configuring the API

##### Configure a resource for the gettabledetails operation

Create a resource that to invoke an API to get created table details from the BigQuery. To achieve this, add the following components to the configuration.

1. Initialize the connector.
    
    1. Navigate into the **Palette** pane and select the graphical operations icons listed under **BigQuery Connector** section. Then drag and drop the `init` operation into the Design pane.
        
        <img src="{{base_path}}/assets/img/integrate/connectors/bigquery-drag-and-drop-init.png" title="Drag and drop init operation" width="600" alt="Drag and drop init operation"/>   
    
    2. Add the property values into the `init` operation as shown below. Replace the `apiUrl`, `accessToken`, `clientId`, `clientSecret`, `refreshToken`, `apiKey`, `callback`, and `prettyPrint` with your values.
        
        - **apiUrl**: The base endpoint URL of the BigQuery API.
        - **accessToken**: The OAuth token for the BigQuery API.
        - **clientId** : The client ID for the BigQuery API.
        - **clientSecret** : The client Secret for the BigQuery API.
        - **refreshToken** : The refresh token for the BigQuery API.
        - **apiKey** : The API key. Required unless you provide an OAuth 2.0 token.
        - **callback** : The name of the JavaScript callback function that handles the response. Used in JavaScript JSON-P requests.
        - **prettyPrint** : Returns the response with indentations and line breaks. If the property is true, the response is returned in a human-readable format.
    
        <img src="{{base_path}}/assets/img/integrate/connectors/bigquery-init-parameterspng.png" title="Add values to the init operation" width="800" alt="Add values to the init operation"/>

2. Set up the getTable operation. This operation retrieves a table by ID.                                               

    1. Navigate into the **Palette** pane and select the graphical operations icons listed under **BigQuery Connector** section. Then drag and drop the `getTable` operation into the Design pane.
           
        <img src="{{base_path}}/assets/img/integrate/connectors/bigquery-gettable-drag-and-drop.png" title="Drag and drop getTable operation" width="600" alt="Drag and drop getTable operation"/>    

    2. In this operation we are going to get a BigQuery table details. 
                                                                                 
        - **datasetId** : The dataset ID of the requested table.
        - **projectId** : The project ID of the requested table.
        - **tableId** : The ID of the requested table.
        
        In this example, the above `datasetId`,`projectId` and `tableId` parameter values are populated as an input value for the BigQuery `getTable` operation.
        
        <img src="{{base_path}}/assets/img/integrate/connectors/bigquery-gettable-drag-and-drop-parameter.png" title="hSet parameters" width="600" alt="hSet parameters"/> 
    
3. To get the input values in to the `getTable`, we can use the [property mediator]({{base_path}}/reference/mediators/property-mediator). Navigate into the **Palette** pane and select the graphical mediators icons listed under **Mediators** section. Then drag and drop the `Property` mediators onto the Design pane as shown below.    
      > **Note**: The properties should be added to the pallet before creating the operation.
        
     The parameters available for configuring the Property mediator are as follows:
    
     1. Add the property mediator to capture the `tableId` value. The 'tableId' contains the ID of the requested table.
   
        - **name** : tableId
        - **value expression** : json-eval($.tableId)
   
        <img src="{{base_path}}/assets/img/integrate/connectors/bigquery-gettableid-properties1.png" title="Add property mediators to get tableId" width="600" alt="Add property mediators to get tableId"/>
    
    2. Add the property mediator to capture the `datasetId` values. The 'volume' contains stock quote volume of the selected company.              
   
        - **name** : datasetId
        - **value expression** : json-eval($.datasetId)
     
        <img src="{{base_path}}/assets/img/integrate/connectors/bigquery-getdatasetid-properties1.png" title="Add property mediators to get datasetId" width="600" alt="Add property mediators to get datasetId"/>  
    
    3. Add the property mediator to capture the `projectId` values. The 'volume' contains stock quote volume of the selected company.              
       
        - **name** : projectId
        - **value expression** : json-eval($.projectId)
         
        <img src="{{base_path}}/assets/img/integrate/connectors/bigquery-projectid-properties1.png" title="Add property mediators to get projectId" width="600" alt="Add property mediators to get projectId"/>  
                    
4. Forward the backend response to the API caller.
    
    When you are invoking the created resource, the request of the message is going through the `/gettabledetails` resource. Finally, it is passed to the [Respond mediator]({{base_path}}/reference/mediators/respond-mediator/). The Respond Mediator stops the processing on the current message and sends the message back to the client as a response.            
    
    1. Drag and drop **respond mediator** to the **Design view**. 
    
         <img src="{{base_path}}/assets/img/integrate/connectors/bigquery-respond-mediator.png" title="Add Respond mediator" width="800" alt="Add Respond mediator"/> 

    2. Once you have setup the resource, you can see the `gettabledetails` resource as shown below.
    
         <img src="{{base_path}}/assets/img/integrate/connectors/bigquery-gettabledetails-resource.png" title="Resource design view" width="600" alt="Resource design view"/>

##### Configure a resource for the insertdetails operation
    
1. Initialize the connector.
   You can use the same configuration to initialize the connector. Please follow the steps given in section 1 for setting up the `init` operation to the `gettabledetails` operation.
   
2. Set up the insertAllTableData operation.
   Navigate into the **Palette** pane and select the graphical operations icons listed under **BigQuery Connector** section. Then drag and drop the `insertAllTableData` operation into the Design pane. The `insertAllTableData` operation inserts the data into the table.
   
      - **datasetId** : The dataset ID of the requested table.
      - **projectId** : The project ID of the requested table.
      - **tableId** : The ID of the requested table.
      - **skipInvalidRows** : A boolean value to check whether the row should be validated.
      - **ignoreUnknownValues** : A boolean value to validate whether the values match the table schema.
      - **jsonPay** : A JSON object that contains a row of data.
          
      <img src="{{base_path}}/assets/img/integrate/connectors/bigquery-insertalltabledata-drag-and-drop.png" title="Drag and drop insertAllTableData operation" width="600" alt="Drag and drop insertAllTableData operation"/>

3. To get the input values in to the `getTable`, we can use the [property mediator]({{base_path}}/reference/mediators/property-mediator). Navigate into the **Palette** pane and select the graphical mediators icons listed under **Mediators** section. Then drag and drop the `Property` mediators onto the Design pane as shown below.    
        
   The parameters available for configuring the Property mediator are as follows:
    
   1. Add the property mediator to capture the `datasetId`, `projectId`, `tableId` values. Please follow the steps given in `gettabledetails` operation section 3. 
       
   2. Add the property mediator to capture the `datasetId` values. The 'volume' contains stock quote volume of the selected company.              
   
      - **name** : jsonPay
      - **value expression** : json-eval($.jsonPay)
     
       <img src="{{base_path}}/assets/img/integrate/connectors/bigquery-jsonpay-properties1.png" title="Add property mediators to get jsonPay" width="600" alt="Add property mediators to get jsonPay"/>  
    
    In this example, `skipInvalidRows` value is configured as **true** and `ignoreUnknownValues` value is configured as **true**. 
    
4. Forward the backend response to the API caller. Please follow the steps given in section 4 in the `gettabledetails` operation.   

##### Configure a resource for the listTabledata operation
    
1. Initialize the connector.
   You can use the same configuration to initialize the connector. Please follow the steps given in section 1 for setting up the `init` operation to the `gettabledetails` operation.
   
2. Set up the listTabledata operation.
   Navigate into the **Palette** pane and select the graphical operations icons listed under **BigQuery Connector** section. Then drag and drop the `listTabledata` operation into the Design pane. The `listTabledata` operation retrieves table data from a specified set of rows.
   
      - **datasetId** : The dataset ID of the requested table.
      - **projectId** : The project ID of the requested table.
      - **tableId** : The ID of the requested table.
          
      <img src="{{base_path}}/assets/img/integrate/connectors/bigquery-listtabledata-drag-and-drop.png" title="Drag and drop insertAllTableData operation" width="600" alt="Drag and drop insertAllTableData operation"/>

3. To get the input values in to the `listTabledata`, we can use the [property mediator]({{base_path}}/reference/mediators/property-mediator). Navigate into the **Palette** pane and select the graphical mediators icons listed under **Mediators** section. Then drag and drop the `Property` mediators onto the Design pane as shown below.    
        
   The parameters available for configuring the Property mediator are as follows:
    
   1. Add the property mediator to capture the `datasetId`, `projectId`, `tableId` values. Please follow the steps given in `gettabledetails` operation section 3. 
    
4. Forward the backend response to the API caller. Please follow the steps given in section 4 in the `gettabledetails` operation.   

##### Configure a resource for the /runQuery operation
    
1. Initialize the connector.
   You can use the same configuration to initialize the connector. Please follow the steps given in section 1 for setting up the `init` operation to the `gettabledetails` operation.
   
2. Set up the /runQuery operation.
   Navigate into the **Palette** pane and select the graphical operations icons listed under **BigQuery Connector** section. Then drag and drop the `/runQuery` operation into the Design pane. The `/runQuery` operation runs an SQL query (BigQuery) and returns results if the query completes within a specified timeout.
      
      - **projectId** : The project ID of the requested table.
      - **kind** : The resource type of the request.
      - **defaultProjectId** : The ID of the project that contains this dataset.
      - **defaultDatasetId** :  A unique ID (required) for this dataset without the project name. The ID must contain only letters (a-z, A-Z), numbers (0-9), or underscores (_). The maximum length is 1,024 characters.
      - **query** : A query string (required) that complies with the BigQuery query syntax.
      - **maxResults** : The maximum number of rows of data (results) to return per page. Responses are also limited to 10 MB. By default, there is no maximum row count and only the byte limit applies.
      - **timeoutMs** : Specifies how long (in milliseconds) the system should wait for the query to complete before expiring and returning the request.
      - **dryRun** :  If set to true, BigQuery does not run the job. Instead, if the query is valid, BigQuery returns statistics about the job. If the query is invalid, an error returns. The default value is false.
      - **useQueryCache** : Specifies whether to look for the result in the query cache. The default value is true.
          
      <img src="{{base_path}}/assets/img/integrate/connectors/bigquery-runquery-drag-and-drop.png" title="Drag and drop insertAllTableData operation" width="600" alt="Drag and drop insertAllTableData operation"/>

3. To get the input values in to the `runQuery`, we can use the [property mediator]({{base_path}}/reference/mediators/property-mediator/). Navigate into the **Palette** pane and select the graphical mediators icons listed under **Mediators** section. Then drag and drop the `Property` mediators onto the Design pane as shown below.    
        
   The parameters available for configuring the Property mediator are as follows:
    
   1. Add the property mediator to capture the `projectId`, `defaultDatasetId` value. Please follow the steps given in `gettabledetails` operation section 3. 
      In this example, `kind` value is configured as **bigquery#tableDataInsertAllResponse**, `query` value is configured as **SELECT * FROM students**, `maxResults` value is configured as **1000**, `timeoutMs` value is configured as **1000**, `dryRun` value is configured as **false** and `useQueryCache` value is configured as **true**.
    
4. Forward the backend response to the API caller. Please follow the steps given in section 4 in the `gettabledetails` operation.   

Now you can switch into the Source view and check the XML configuration files of the created API and sequences. 
    
??? note "bigquery-testAPI.xml"
    ```
      <?xml version="1.0" encoding="UTF-8"?>
          <api context="/resources" name="bigquery-testAPI" xmlns="http://ws.apache.org/ns/synapse">
              <resource methods="POST" url-mapping="/gettabledetails">
                  <inSequence>
                      <property expression="json-eval($.tableId)" name="tableId" scope="default" type="STRING"/>
                      <property expression="json-eval($.datasetId)" name="datasetId" scope="default" type="STRING"/>
                      <property expression="json-eval($.projectId)" name="projectId" scope="default" type="STRING"/>
                      <bigquery.init>
                          <apiUrl>https://www.googleapis.com</apiUrl>
                          <accessToken>ya29.a0AfH6SMA6j0L_cGNi0BpxXLGaYlUQUbkHpGY31iFpjz4VOlbx3PlP5XBWW9E5bvdqW7cu8kjxMqJ7WShYGxOooXNc20cnNkHOkfesaun6NnhA3omK8ERWKSfICJGucG1tp3P0mVWNtQ6M2ZdDgigQ-3gmB0Xtphj3Ovw</accessToken>
                          <clientId>392276369305-pg6a4bq41r79gsv3mdmd8vesscf477sf.apps.googleusercontent.com</clientId>
                          <clientSecret>UgtzggStea3Xfd9q7TUMeyNo</clientSecret>
                          <refreshToken>1//0gCwbRibyQinFCgYIARAAGBASNwF-L9IrO9590FKKiOro0UUEZEHD4DiG9or41nbIEmWOzsaM22btR4QLKXHfGMDDUWK2hrp5EBo</refreshToken>
                          <registryPath>{$ctx:registryPath}</registryPath>
                          <apiKey>XXXX</apiKey>
                          <callback>callBackFunction</callback>
                          <prettyPrint>true</prettyPrint>
                          <quotaUser>{$ctx:quotaUser}</quotaUser>
                          <userIp>{$ctx:userIp}</userIp>
                          <fields>{$ctx:fields}</fields>
                          <ifNoneMatch>{$ctx:ifNoneMatch}</ifNoneMatch>
                          <ifMatch>{$ctx:ifMatch}</ifMatch>
                      </bigquery.init>
                      <bigquery.getTable>
                          <datasetId>{$ctx:datasetId}</datasetId>
                          <projectId>{$ctx:projectId}</projectId>
                          <tableId>{$ctx:tableId}</tableId>
                      </bigquery.getTable>
                      <respond/>
                  </inSequence>
                  <outSequence/>
                  <faultSequence/>
              </resource>
              <resource methods="POST" url-mapping="/insertdetails">
                  <inSequence>
                      <property expression="json-eval($.tableId)" name="tableId" scope="default" type="STRING"/>
                      <property expression="json-eval($.datasetId)" name="datasetId" scope="default" type="STRING"/>
                      <property expression="json-eval($.projectId)" name="projectId" scope="default" type="STRING"/>
                      <property expression="json-eval($.jsonPay)" name="jsonPay" scope="default" type="STRING"/>
                      <bigquery.init>
                          <apiUrl>https://www.googleapis.com</apiUrl>
                          <accessToken>ya29.a0AfH6SMA6j0L_cGNi0BpxXLGaYlUQUbkHpGY31iFpjz4VOlbx3PlP5XBWW9E5bvdqW7cu8kjxMqJ7WShYGxOooXNc20cnNkHOkfesaun6NnhA3omK8ERWKSfICJGucG1tp3P0mVWNtQ6M2ZdDgigQ-3gmB0Xtphj3Ovw</accessToken>
                          <clientId>392276369305-pg6a4bq41r79gsv3mdmd8vesscf477sf.apps.googleusercontent.com</clientId>
                          <clientSecret>UgtzggStea3Xfd9q7TUMeyNo</clientSecret>
                          <refreshToken>1//0gCwbRibyQinFCgYIARAAGBASNwF-L9IrO9590FKKiOro0UUEZEHD4DiG9or41nbIEmWOzsaM22btR4QLKXHfGMDDUWK2hrp5EBo</refreshToken>
                          <registryPath>{$ctx:registryPath}</registryPath>
                          <apiKey>XXXX</apiKey>
                          <callback>callBackFunction</callback>
                          <prettyPrint>true</prettyPrint>
                          <quotaUser>{$ctx:quotaUser}</quotaUser>
                          <userIp>{$ctx:userIp}</userIp>
                          <fields>{$ctx:fields}</fields>
                          <ifNoneMatch>{$ctx:ifNoneMatch}</ifNoneMatch>
                          <ifMatch>{$ctx:ifMatch}</ifMatch>
                      </bigquery.init>
                      <bigquery.insertAllTableData>
                          <datasetId>{$ctx:datasetId}</datasetId>
                          <projectId>{$ctx:projectId}</projectId>
                          <tableId>{$ctx:tableId}</tableId>
                          <skipInvalidRows>true</skipInvalidRows>
                          <ignoreUnknownValues>true</ignoreUnknownValues>
                          <templateSuffix>{$ctx:templateSuffix}</templateSuffix>
                          <jsonPay>{$ctx:jsonPay}</jsonPay>
                      </bigquery.insertAllTableData>
                      <respond/>
                  </inSequence>
                  <outSequence/>
                  <faultSequence/>
              </resource>
              <resource methods="POST" url-mapping="/getdetails">
                  <inSequence>
                      <property expression="json-eval($.tableId)" name="tableId" scope="default" type="STRING"/>
                      <property expression="json-eval($.datasetId)" name="datasetId" scope="default" type="STRING"/>
                      <property expression="json-eval($.projectId)" name="projectId" scope="default" type="STRING"/>
                      <bigquery.init>
                          <apiUrl>https://www.googleapis.com</apiUrl>
                          <accessToken>ya29.a0AfH6SMA6j0L_cGNi0BpxXLGaYlUQUbkHpGY31iFpjz4VOlbx3PlP5XBWW9E5bvdqW7cu8kjxMqJ7WShYGxOooXNc20cnNkHOkfesaun6NnhA3omK8ERWKSfICJGucG1tp3P0mVWNtQ6M2ZdDgigQ-3gmB0Xtphj3Ovw</accessToken>
                          <clientId>392276369305-pg6a4bq41r79gsv3mdmd8vesscf477sf.apps.googleusercontent.com</clientId>
                          <clientSecret>UgtzggStea3Xfd9q7TUMeyNo</clientSecret>
                          <refreshToken>1//0gCwbRibyQinFCgYIARAAGBASNwF-L9IrO9590FKKiOro0UUEZEHD4DiG9or41nbIEmWOzsaM22btR4QLKXHfGMDDUWK2hrp5EBo</refreshToken>
                          <registryPath>{$ctx:registryPath}</registryPath>
                          <apiKey>XXXX</apiKey>
                          <callback>callBackFunction</callback>
                          <prettyPrint>true</prettyPrint>
                          <quotaUser>{$ctx:quotaUser}</quotaUser>
                          <userIp>{$ctx:userIp}</userIp>
                          <fields>{$ctx:fields}</fields>
                          <ifNoneMatch>{$ctx:ifNoneMatch}</ifNoneMatch>
                          <ifMatch>{$ctx:ifMatch}</ifMatch>
                      </bigquery.init>
                      <bigquery.listTabledata>
                          <datasetId>{$ctx:datasetId}</datasetId>
                          <projectId>{$ctx:projectId}</projectId>
                          <tableId>{$ctx:tableId}</tableId>
                          <maxResults>{$ctx:maxResults}</maxResults>
                          <pageToken>{$ctx:pageToken}</pageToken>
                          <startIndex>{$ctx:startIndex}</startIndex>
                      </bigquery.listTabledata>
                      <respond/>
                  </inSequence>
                  <outSequence/>
                  <faultSequence/>
              </resource>
              <resource methods="POST" url-mapping="/runQuery">
                  <inSequence>
                      <property expression="json-eval($.tableId)" name="tableId" scope="default" type="STRING"/>
                      <property expression="json-eval($.defaultDatasetId)" name="defaultDatasetId" scope="default" type="STRING"/>
                      <property expression="json-eval($.projectId)" name="projectId" scope="default" type="STRING"/>
                      <bigquery.init>
                          <apiUrl>https://www.googleapis.com</apiUrl>
                          <accessToken>ya29.a0AfH6SMA6j0L_cGNi0BpxXLGaYlUQUbkHpGY31iFpjz4VOlbx3PlP5XBWW9E5bvdqW7cu8kjxMqJ7WShYGxOooXNc20cnNkHOkfesaun6NnhA3omK8ERWKSfICJGucG1tp3P0mVWNtQ6M2ZdDgigQ-3gmB0Xtphj3Ovw</accessToken>
                          <clientId>392276369305-pg6a4bq41r79gsv3mdmd8vesscf477sf.apps.googleusercontent.com</clientId>
                          <clientSecret>UgtzggStea3Xfd9q7TUMeyNo</clientSecret>
                          <refreshToken>1//0gCwbRibyQinFCgYIARAAGBASNwF-L9IrO9590FKKiOro0UUEZEHD4DiG9or41nbIEmWOzsaM22btR4QLKXHfGMDDUWK2hrp5EBo</refreshToken>
                          <registryPath>{$ctx:registryPath}</registryPath>
                          <apiKey>XXXX</apiKey>
                          <callback>callBackFunction</callback>
                          <prettyPrint>true</prettyPrint>
                          <quotaUser>{$ctx:quotaUser}</quotaUser>
                          <userIp>{$ctx:userIp}</userIp>
                          <fields>{$ctx:fields}</fields>
                          <ifNoneMatch>{$ctx:ifNoneMatch}</ifNoneMatch>
                          <ifMatch>{$ctx:ifMatch}</ifMatch>
                      </bigquery.init>
                      <bigquery.runQuery>
                          <projectId>{$ctx:projectId}</projectId>
                          <kind>bigquery#tableDataInsertAllResponse</kind>
                          <query>SELECT * FROM students</query>
                          <maxResults>10000</maxResults>
                          <timeoutMs>10000</timeoutMs>
                          <dryRun>false</dryRun>
                          <useQueryCache>true</useQueryCache>
                          <defaultDatasetId>{$ctx:defaultDatasetId}</defaultDatasetId>
                          <defaultProjectId>{$ctx:defaultProjectId}</defaultProjectId>
                          <useLegacySql>{$ctx:useLegacySql}</useLegacySql>
                      </bigquery.runQuery>
                      <respond/>
                  </inSequence>
                  <outSequence/>
                  <faultSequence/>
              </resource>
          </api>       <?xml version="1.0" encoding="UTF-8"?>
                           <api context="/resources" name="bigquery-testAPI" xmlns="http://ws.apache.org/ns/synapse">
                               <resource methods="POST" url-mapping="/gettabledetails">
                                   <inSequence>
                                       <property expression="json-eval($.tableId)" name="tableId" scope="default" type="STRING"/>
                                       <property expression="json-eval($.datasetId)" name="datasetId" scope="default" type="STRING"/>
                                       <property expression="json-eval($.projectId)" name="projectId" scope="default" type="STRING"/>
                                       <bigquery.init>
                                           <apiUrl>https://www.googleapis.com</apiUrl>
                                           <accessToken>ya29.a0AfH6SMA6j0L_cGNi0BpxXLGaYlUQUbkHpGY31iFpjz4VOlbx3PlP5XBWW9E5bvdqW7cu8kjxMqJ7WShYGxOooXNc20cnNkHOkfesaun6NnhA3omK8ERWKSfICJGucG1tp3P0mVWNtQ6M2ZdDgigQ-3gmB0Xtphj3Ovw</accessToken>
                                           <clientId>392276369305-pg6a4bq41r79gsv3mdmd8vesscf477sf.apps.googleusercontent.com</clientId>
                                           <clientSecret>UgtzggStea3Xfd9q7TUMeyNo</clientSecret>
                                           <refreshToken>1//0gCwbRibyQinFCgYIARAAGBASNwF-L9IrO9590FKKiOro0UUEZEHD4DiG9or41nbIEmWOzsaM22btR4QLKXHfGMDDUWK2hrp5EBo</refreshToken>
                                           <registryPath>{$ctx:registryPath}</registryPath>
                                           <apiKey>XXXX</apiKey>
                                           <callback>callBackFunction</callback>
                                           <prettyPrint>true</prettyPrint>
                                           <quotaUser>{$ctx:quotaUser}</quotaUser>
                                           <userIp>{$ctx:userIp}</userIp>
                                           <fields>{$ctx:fields}</fields>
                                           <ifNoneMatch>{$ctx:ifNoneMatch}</ifNoneMatch>
                                           <ifMatch>{$ctx:ifMatch}</ifMatch>
                                       </bigquery.init>
                                       <bigquery.getTable>
                                           <datasetId>{$ctx:datasetId}</datasetId>
                                           <projectId>{$ctx:projectId}</projectId>
                                           <tableId>{$ctx:tableId}</tableId>
                                       </bigquery.getTable>
                                       <respond/>
                                   </inSequence>
                                   <outSequence/>
                                   <faultSequence/>
                               </resource>
                               <resource methods="POST" url-mapping="/insertdetails">
                                   <inSequence>
                                       <property expression="json-eval($.tableId)" name="tableId" scope="default" type="STRING"/>
                                       <property expression="json-eval($.datasetId)" name="datasetId" scope="default" type="STRING"/>
                                       <property expression="json-eval($.projectId)" name="projectId" scope="default" type="STRING"/>
                                       <property expression="json-eval($.jsonPay)" name="jsonPay" scope="default" type="STRING"/>
                                       <bigquery.init>
                                           <apiUrl>https://www.googleapis.com</apiUrl>
                                           <accessToken>ya29.a0AfH6SMA6j0L_cGNi0BpxXLGaYlUQUbkHpGY31iFpjz4VOlbx3PlP5XBWW9E5bvdqW7cu8kjxMqJ7WShYGxOooXNc20cnNkHOkfesaun6NnhA3omK8ERWKSfICJGucG1tp3P0mVWNtQ6M2ZdDgigQ-3gmB0Xtphj3Ovw</accessToken>
                                           <clientId>392276369305-pg6a4bq41r79gsv3mdmd8vesscf477sf.apps.googleusercontent.com</clientId>
                                           <clientSecret>UgtzggStea3Xfd9q7TUMeyNo</clientSecret>
                                           <refreshToken>1//0gCwbRibyQinFCgYIARAAGBASNwF-L9IrO9590FKKiOro0UUEZEHD4DiG9or41nbIEmWOzsaM22btR4QLKXHfGMDDUWK2hrp5EBo</refreshToken>
                                           <registryPath>{$ctx:registryPath}</registryPath>
                                           <apiKey>XXXX</apiKey>
                                           <callback>callBackFunction</callback>
                                           <prettyPrint>true</prettyPrint>
                                           <quotaUser>{$ctx:quotaUser}</quotaUser>
                                           <userIp>{$ctx:userIp}</userIp>
                                           <fields>{$ctx:fields}</fields>
                                           <ifNoneMatch>{$ctx:ifNoneMatch}</ifNoneMatch>
                                           <ifMatch>{$ctx:ifMatch}</ifMatch>
                                       </bigquery.init>
                                       <bigquery.insertAllTableData>
                                           <datasetId>{$ctx:datasetId}</datasetId>
                                           <projectId>{$ctx:projectId}</projectId>
                                           <tableId>{$ctx:tableId}</tableId>
                                           <skipInvalidRows>true</skipInvalidRows>
                                           <ignoreUnknownValues>true</ignoreUnknownValues>
                                           <templateSuffix>{$ctx:templateSuffix}</templateSuffix>
                                           <jsonPay>{$ctx:jsonPay}</jsonPay>
                                       </bigquery.insertAllTableData>
                                       <respond/>
                                   </inSequence>
                                   <outSequence/>
                                   <faultSequence/>
                               </resource>
                               <resource methods="POST" url-mapping="/getdetails">
                                   <inSequence>
                                       <property expression="json-eval($.tableId)" name="tableId" scope="default" type="STRING"/>
                                       <property expression="json-eval($.datasetId)" name="datasetId" scope="default" type="STRING"/>
                                       <property expression="json-eval($.projectId)" name="projectId" scope="default" type="STRING"/>
                                       <bigquery.init>
                                           <apiUrl>https://www.googleapis.com</apiUrl>
                                           <accessToken>ya29.a0AfH6SMA6j0L_cGNi0BpxXLGaYlUQUbkHpGY31iFpjz4VOlbx3PlP5XBWW9E5bvdqW7cu8kjxMqJ7WShYGxOooXNc20cnNkHOkfesaun6NnhA3omK8ERWKSfICJGucG1tp3P0mVWNtQ6M2ZdDgigQ-3gmB0Xtphj3Ovw</accessToken>
                                           <clientId>392276369305-pg6a4bq41r79gsv3mdmd8vesscf477sf.apps.googleusercontent.com</clientId>
                                           <clientSecret>UgtzggStea3Xfd9q7TUMeyNo</clientSecret>
                                           <refreshToken>1//0gCwbRibyQinFCgYIARAAGBASNwF-L9IrO9590FKKiOro0UUEZEHD4DiG9or41nbIEmWOzsaM22btR4QLKXHfGMDDUWK2hrp5EBo</refreshToken>
                                           <registryPath>{$ctx:registryPath}</registryPath>
                                           <apiKey>XXXX</apiKey>
                                           <callback>callBackFunction</callback>
                                           <prettyPrint>true</prettyPrint>
                                           <quotaUser>{$ctx:quotaUser}</quotaUser>
                                           <userIp>{$ctx:userIp}</userIp>
                                           <fields>{$ctx:fields}</fields>
                                           <ifNoneMatch>{$ctx:ifNoneMatch}</ifNoneMatch>
                                           <ifMatch>{$ctx:ifMatch}</ifMatch>
                                       </bigquery.init>
                                       <bigquery.listTabledata>
                                           <datasetId>{$ctx:datasetId}</datasetId>
                                           <projectId>{$ctx:projectId}</projectId>
                                           <tableId>{$ctx:tableId}</tableId>
                                           <maxResults>{$ctx:maxResults}</maxResults>
                                           <pageToken>{$ctx:pageToken}</pageToken>
                                           <startIndex>{$ctx:startIndex}</startIndex>
                                       </bigquery.listTabledata>
                                       <respond/>
                                   </inSequence>
                                   <outSequence/>
                                   <faultSequence/>
                               </resource>
                               <resource methods="POST" url-mapping="/runQuery">
                                   <inSequence>
                                       <property expression="json-eval($.tableId)" name="tableId" scope="default" type="STRING"/>
                                       <property expression="json-eval($.defaultDatasetId)" name="defaultDatasetId" scope="default" type="STRING"/>
                                       <property expression="json-eval($.projectId)" name="projectId" scope="default" type="STRING"/>
                                       <bigquery.init>
                                           <apiUrl>https://www.googleapis.com</apiUrl>
                                           <accessToken>ya29.a0AfH6SMA6j0L_cGNi0BpxXLGaYlUQUbkHpGY31iFpjz4VOlbx3PlP5XBWW9E5bvdqW7cu8kjxMqJ7WShYGxOooXNc20cnNkHOkfesaun6NnhA3omK8ERWKSfICJGucG1tp3P0mVWNtQ6M2ZdDgigQ-3gmB0Xtphj3Ovw</accessToken>
                                           <clientId>392276369305-pg6a4bq41r79gsv3mdmd8vesscf477sf.apps.googleusercontent.com</clientId>
                                           <clientSecret>UgtzggStea3Xfd9q7TUMeyNo</clientSecret>
                                           <refreshToken>1//0gCwbRibyQinFCgYIARAAGBASNwF-L9IrO9590FKKiOro0UUEZEHD4DiG9or41nbIEmWOzsaM22btR4QLKXHfGMDDUWK2hrp5EBo</refreshToken>
                                           <registryPath>{$ctx:registryPath}</registryPath>
                                           <apiKey>XXXX</apiKey>
                                           <callback>callBackFunction</callback>
                                           <prettyPrint>true</prettyPrint>
                                           <quotaUser>{$ctx:quotaUser}</quotaUser>
                                           <userIp>{$ctx:userIp}</userIp>
                                           <fields>{$ctx:fields}</fields>
                                           <ifNoneMatch>{$ctx:ifNoneMatch}</ifNoneMatch>
                                           <ifMatch>{$ctx:ifMatch}</ifMatch>
                                       </bigquery.init>
                                       <bigquery.runQuery>
                                           <projectId>{$ctx:projectId}</projectId>
                                           <kind>bigquery#tableDataInsertAllResponse</kind>
                                           <query>SELECT * FROM students</query>
                                           <maxResults>10000</maxResults>
                                           <timeoutMs>10000</timeoutMs>
                                           <dryRun>false</dryRun>
                                           <useQueryCache>true</useQueryCache>
                                           <defaultDatasetId>{$ctx:defaultDatasetId}</defaultDatasetId>
                                           <defaultProjectId>{$ctx:defaultProjectId}</defaultProjectId>
                                           <useLegacySql>{$ctx:useLegacySql}</useLegacySql>
                                       </bigquery.runQuery>
                                       <respond/>
                                   </inSequence>
                                   <outSequence/>
                                   <faultSequence/>
                               </resource>
                           </api>       
    ```  
## Get the project

You can download the ZIP file and extract the contents to get the project code.

<a href="{{base_path}}/assets/attachments/connectors/bigquery-connector.zip">
    <img src="{{base_path}}/assets/img/integrate/connectors/download-zip.png" width="200" alt="Download ZIP">
</a>

## Deployment

Follow these steps to deploy the exported CApp in the Enterprise Integrator Runtime. 

{!reference/connectors/deploy-capp.md!}   

## Testing

Invoke the API as shown below using the curl command. Curl Application can be downloaded from [here](https://curl.haxx.se/download.html).

1. The user sends the request to invoke an API to get created table details from the BigQuery.
 
   **Sample request**
   
   Save a file called **data.json** with the following payload.
      
   ```json
     {
        "tableId":"students",
        "datasetId":"Sample1",
        "projectId":"ei-connector-improvement"
     }
   ```
   ```
   curl -v POST -d @data.json "http://localhost:8290/resources/getTable" -H "Content-Type:application/json"
   ```
   **Expected Response**
    
   ```json
     // API callback
     callBackFunction({
       "kind": "bigquery#table",
       "etag": "G5Yv0gFoLTD2gSToi5YPwA==",
       "id": "ei-connector-improvement:Sample1.students",
       "selfLink": "https://www.googleapis.com/bigquery/v2/projects/ei-connector-improvement/datasets/Sample1/tables/students",
       "tableReference": {
         "projectId": "ei-connector-improvement",
         "datasetId": "Sample1",
         "tableId": "students"
       },
       "schema": {
         "fields": [
           {
             "name": "name",
             "type": "STRING",
             "mode": "NULLABLE"
           },
           {
             "name": "age",
             "type": "INTEGER",
             "mode": "NULLABLE"
           }
         ]
       },
       "numBytes": "0",
       "numLongTermBytes": "0",
       "numRows": "0",
       "creationTime": "1592219906721",
       "lastModifiedTime": "1592219906768",
       "type": "TABLE",
       "location": "US"
     }
     );
   ```     
2. Insert data in to the created table.
 
   **Sample request**
   
   Save a file called **data.json** with the following payload.
   
   ```json
   {
     "tableId":"students",
     "datasetId":"Sample1",
     "projectId":"ei-connector-improvement",
     "jsonPay":{
            "json":
                  {
                   "name":"Jhone",
                   "age":"30"
                   }
                }
   }
   ```
   ```
   curl -v POST -d @data.json "http://localhost:8290/resources/insertAllTableData" -H "Content-Type:application/json"
   ```

   **Expected Response**
    
   ```json
   {
       "kind": "bigquery#tableDataInsertAllResponse"
   }
   ```
3. Retrieve inserted details from the BigQuery table.
 
   **Sample request**
   
   Save a file called **data.json** with the following payload.
      
   ```json
   {
       "tableId":"students",
       "datasetId":"Sample1",
       "projectId":"ei-connector-improvement"
   }
   ```
   ```
   curl -v POST -d @data.json "http://localhost:8290/resources/listTabledata" -H "Content-Type:application/json"
   ```

   **Expected Response**
    
     ```json
     // API callback
     callBackFunction({
       "kind": "bigquery#tableDataList",
       "etag": "CddYdG3ttrhpWPEGTOpKKg==",
       "totalRows": "0",
       "rows": [
         {
           "f": [
             {
               "v": "Kasun"
             },
             {
               "v": "25"
             }
           ]
         },
         {
           "f": [
             {
               "v": "Jhone"
             },
             {
               "v": "30"
             }
           ]
         }
       ]
     }
     );
   ```
4. Run an SQL query (BigQuery) and retrieve details from BigQuery table.
 
   **Sample request**
   
   Save a file called **data.json** with the following payload.
   
   ```json
   {
         "defaultDatasetId":"Sample1",
         "projectId":"ei-connector-improvement"
   }
   ```  
   
   ```
   curl -v POST -d @data.json "http://localhost:8290/resources/runQuery" -H "Content-Type:application/json"
   ```
   **Expected Response**
   
   ```json
      {
             "kind": "bigquery#queryResponse",
             "schema": {
                 "fields": [
                     {
                         "name": "name",
                         "type": "STRING",
                         "mode": "NULLABLE"
                     },
                     {
                         "name": "age",
                         "type": "INTEGER",
                         "mode": "NULLABLE"
                     }
                 ]
             },
             "jobReference": {
                 "projectId": "ei-connector-improvement",
                 "jobId": "job_YQS1kmzYpfBT-wKvkLi5uVbSL_Mh",
                 "location": "US"
             },
             "totalRows": "2",
             "rows": [
                 {
                     "f": [
                         {
                             "v": "Kasun"
                         },
                         {
                             "v": "25"
                         }
                     ]
                 },
                 {
                     "f": [
                         {
                             "v": "Jhone"
                         },
                         {
                             "v": "30"
                         }
                     ]
                 }
             ],
             "totalBytesProcessed": "30",
             "jobComplete": true,
             "cacheHit": false
         }
   ```  
## What's next

* You can deploy and run your project on Docker or Kubernetes. See the instructions in [Running the Micro Integrator on Containers]({{base_path}}/install-and-setup/installation/run_in_containers).