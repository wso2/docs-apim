# Salesforce Bulk v2.0 Connector Example

The **Salesforce Bulk v2.0 Connector** provides seamless integration with the [Salesforce Bulk v2.0 REST API](https://developer.salesforce.com/docs/atlas.en-us.api_asynch.meta/api_asynch/asynch_api_intro.htm), enabling easy and efficient handling of large volumes of data. The SalesforceBulk API operates on a RESTful architecture, offering a fast and reliable method to load or delete vast amounts of data from your organization's Salesforce account. With SalesforceBulk, you can perform asynchronous operations like querying, inserting, updating, upserting, or deleting a considerable number of records by submitting them in batches. These batches can be processed by Salesforce in the background, ensuring minimal disruption to your workflow.

## What you'll build

The following example demonstrates how to use the Salesforce Bulk v2.0 Connector for performing various operations on your Salesforce data:

1. Insert account records to the salesforce.
2. Insert account records from a file to the salesforce.
3. Get the created bulk job information. 
4. Get the successfully processed records.
5. Get the unprocessed records to a file.
6. Delete the bulk job.
7. Create a query job to get account details.
8. Get the created query job information.
9. Get the successful results of the created query job to a file.

You can use the following resources to achieve your requirements.

1. `/createJobAndUploadData` : 
    - Create a new bulk ingest job for insert operation.
    - Upload the CSV content passed through the request body.
    - Close the job to denote that the upload is completed.
2. `/createJobAndUploadFile` : 
    - Create a new bulk ingest job for insert operation.
    - Read a CSV file using [File Connector]({{base_path}}/reference/connectors/file-connector/file-connector-overview/).
    - Upload the CSV content read from the file.
    - Close the job to denote that the upload is completed.
3. `/getJobInfo` : 
    - Get the bulkJob info identified by the jobId passed through the request body.
4. `/getSuccessfulResults` : 
    - Retrive the successful results of the bulk job identified by the `jobId`.
5. `/getUnprocessedResults` : 
    - Retrive the unprocessed records of the bulk job identified by the `jobId`.
    - Store the results to a CSV file.
6. `/deleteJob` : 
    - Delete the bulkJob identified by the jobId passed through the request body.
7. `/createQuery` : 
    - Create a query job in salesforce.
8. `/getQueryJobInfo` : 
    - Get the queryJob info identified by the jobId passed through the request body.
6. `/getSuccessfulQueryResults` : 
    - Retrive the successful results of the bulk query job identified by the `queryJobId`.
    - Store it in a CSV file.

## Setting up the environment

By default, the `text/csv` message formatter and message builder are not configured in the Micro Integrator settings. To enable this connector to function correctly with `text/csv` data, you will need to follow these steps to add the necessary message formatter and message builder configurations.

1. Open `[MI_Root]/conf/axis2/axis2.xml` using a text editor.
2. Navigate to the `Message Formatters` section.
3. Add a new message formatter for the type `text/csv`.
    - `<messageFormatter contentType="text/csv" class="org.apache.axis2.format.PlainTextFormatter"/>`
4. Navigate to the `Message Builders` section.
5. Add a new message builder for the type `text/csv`.
    - `	<messageBuilder contentType="text/csv" class="org.apache.axis2.format.PlainTextBuilder"/>`
6. Save the file and restart the Micro Integrator.

## Configure the connector in WSO2 Integration Studio

Connectors can be added to integration flows in [WSO2 Integration Studio](https://wso2.com/integration/integration-studio/). Once added, the operations of the connector can be dragged onto your canvas and added to your sequences.

### Import the connector

Follow these steps to set up the Integration Project and the Connector Exporter Project. 

1. Open WSO2 Integration Studio and create an **Integration Project**.
   <a href="https://apim.docs.wso2.com/en/4.1.0/assets/img/integrate/new-project/new-integration-project.png"><img src="https://apim.docs.wso2.com/en/4.1.0/assets/img/integrate/new-project/new-integration-project.png" title="Creating a new Integration Project" width="800" alt="Creating a new Integration Project" /></a>

2. Right-click the project that you created and click on **Add or Remove Connector** -> **Add Connector**. You will get directed to the WSO2 Connector Store.

3. Search for the "Salesforce Bulk API V2.0" connector and download it to the workspace.
   <a href="{{base_path}}/assets/img/integrate/connectors/salesforcebulk_v2/Salesforce_bulk_v2_connector.png"><img src="{{base_path}}/assets/img/integrate/connectors/salesforcebulk_v2/Salesforce_bulk_v2_connector.png" title="Search Connector in the Connector Store" width="40%" alt="Search Connector in the Connector Store" /></a>

4. Click **Finish**, and your Integration Project is ready. The downloaded connector is displayed on the side palette with its operations.

5. You can drag and drop the operations to the design canvas and build your integration logic.
   <a href="{{base_path}}/assets/img/integrate/connectors/salesforcebulk_v2/Salesforce_bulk_v2_connectorWindow.png"><img src="{{base_path}}/assets/img/integrate/connectors/salesforcebulk_v2/Salesforce_bulk_v2_connectorWindow.png" title="Drag connector operations" alt="Drag connector operations" /></a>

6. Right click on the created Integration Project and select **New** -> **Rest API** to create the REST API.


### Add integration logic

First create a REST API called `Salesforce` in your project

| Name | Context |
| ---------------- | ---------------- |
| Salesforce  | /salesforce  |

Create the following resources in 'Salesforce' REST API

| uri-template | method|
| ---------------- | ------|
| /createJobAndUploadData  | POST |
| /createJobAndUploadFile | GET, POST |
| /getJobInfo  | POST |
| /getSuccessfulResults  | POST |
| /getUnprocessedResults | POST |
| /deleteJob  | POST |
| /createQuery  | GET, POST |
| /getQueryJobInfo | POST |
| /getSuccessfulQueryResults  | POST |


Lets add the operations to the resources in `Salesforce` API

#### - /createJobAndUploadData

  Users can utilize this resource to send CSV content for upload via the request body. The API will utilize an `enrich` mediator to store the CSV content in a `csvContent` property. The 'UploadJobData' operation will then upload the `csvContent`. After uploading the content, the `CloseJob` operation will be used to change the job status to `UploadComplete`.

  1. In the API insequence drag and drop the Enrich mediator. Using the Enrich mediator clone the body content to a property called `csvContent`.
      Enrich source: 

      ```xml
        <enrich>
          <source clone="true" type="body"/>
          <target property="csvContent" type="property"/>
        </enrich>
      ```  

  2. Drag and drop `createJob` operation from **Salesforce_bulkapi_v2_Connector** section.
    1. Double click the operation. It will show you the properties section.
    2. In the properties section, In the General Section, click on the `+` button next to `Salesforce Configuration`
        1. In the `Connection configurtion` section give a name for `Salesforce Connection Name`
        2. Provide your Salesforce instance URL in the `Instance URL` text box.
        3. Provide your Salesforce connected app's client id in the `Client ID` text box.
        4. Provide your Salesforce connected app's client secret in the `Client Secret` text box.
        5. Provide your Salesforce connected app's refresh token in the `Refresh Token` text box.
        6. Provide your Salesforceconnected app's Access Token in the `Access Token` text box.
            - We recommend not to use `Access Token`.
            - If you are using an `Access Token`, please update it promptly upon expiration.
            - If you are providing an `Access Token` along with `Client ID, Client Secret, and Refresh Token`, and if the `Access Token` has expired, kindly remove the expired `Access Token`. An invalid `Access Token` could lead to poor connector performance.
        7. Click finish.
    3. In the properties section, under `Basic`, select `INSERT` in the Operation dropdown.
    4. Input `Account` in the `Object` text box
    5. Select `COMMA` in the `Column Delimeter` dropbox
    6. Select `LF` or `CRLF` in the `Line Ending` dropbox based on your operating system. IF Windows : `CRLF`, for Unix-based systems : `LF`

  3. Drag and drop a property mediator. Using this mediator we will extract the jobId from the response and will use it in other operations in this sequence.
    
      ```xml
        <property expression="json-eval($.id)" name="jobId" scope="default" type="STRING"/>
      ```

  4. Drag and drop `uploadJobData` operation from **Salesforce_bulkapi_v2_Connector** section.
       1. Double click the operation. It will show you the properties section.
       2. In the 'General' section of the properties, select the Salesforce connection configuration you created.
       3. For `Job ID` text box enter `$ctx:jobId` as expression.
       4. For `Input Data` enter `$ctx:csvContent` as the expression

      ```xml
      <salesforce_bulkapi_v2.uploadJobData configKey="SF_CONNECTION_CONFIG_NAME_1">
        <jobId>{$ctx:jobId}</jobId>
        <inputData>{$ctx:csvContent}</inputData>
      </salesforce_bulkapi_v2.uploadJobData>
      ```

  5. Drag and drop `closeJob` operation from **Salesforce_bulkapi_v2_Connector** section.
      1. Double-click the operation to view its properties section.
      2. In the 'General' section of the properties, select the Salesforce connection configuration you created.
      3. In the 'Job ID' text box, enter the expression `$ctx:jobId`.

  6. Drag and drop 'Respond' mediator.

  <a href="{{base_path}}/assets/img/integrate/connectors/salesforcebulk_v2/Salesforce_bulk_v2_createJobAndUploadData.png"><img src="{{base_path}}/assets/img/integrate/connectors/salesforcebulk_v2/Salesforce_bulk_v2_createJobAndUploadData.png" width="800"/></a>

#### - /createJobAndUploadFile

  Users can utilize this resource to send CSV content for upload via a CSV file. The API will utilize an `File Connector` to store the CSV content in a `csvContent` property. The 'UploadJobData' operation will then upload the `csvContent`. After uploading the content, the `CloseJob` operation will be used to change the job status to `UploadComplete`.
  
  1. Drag and drop `createJob` operation from **Salesforce_bulkapi_v2_Connector** section.
    1. Double-click the operation to view its properties section.
    2. In the 'General' section of the properties, select the Salesforce connection configuration you created.
    3. In the properties section, under `Basic`, select `INSERT` in the Operation dropdown.
    4. Input `Account` in the `Object` text box
    5. Select `COMMA` in the `Column Delimeter` dropbox
    6. Select `LF` or `CRLF` in the `Line Ending` dropbox based on your operating system. IF Windows : `CRLF`, for Unix-based systems : `LF`

  2. Drag and drop a property mediator. Using this mediator we will extract the jobId from the response and will use it in other operations in this sequence.
    
      ```xml
        <property expression="json-eval($.id)" name="jobId" scope="default" type="STRING"/>
      ```

  3. Drag and drop `read` operation from **[File_Connector]({{base_path}}/reference/connectors/file-connector/file-connector-config/#operations)** section.
      1. Prior to this step, you must configure the **File Connector**. For setup instructions, please refer to the [File Connector Documentation]({{base_path}}/reference/connectors/file-connector/file-connector-overview/).
      2. Create a File Connection and select it.
      3. In the `Basic` section, enter the file path.
      4. In the `Operation Result` section, select `Add Result To` as "Message Property",
      5. Set the `Property Name` as "csvContent".

  4. Drag and drop `uploadJobData` operation from **Salesforce_bulkapi_v2_Connector** section.
       1. Double click the operation. It will show you the properties section.
       2. In the 'General' section of the properties, select the Salesforce connection configuration you created.
       3. For `Job ID` text box enter `$ctx:jobId` as expression.
       4. For `Input Data` enter `$ctx:csvContent` as the expression

      ```xml
      <salesforce_bulkapi_v2.uploadJobData configKey="SF_CONNECTION_CONFIG_NAME_1">
        <jobId>{$ctx:jobId}</jobId>
        <inputData>{$ctx:csvContent}</inputData>
      </salesforce_bulkapi_v2.uploadJobData>
      ```

  5. Drag and drop `closeJob` operation from **Salesforce_bulkapi_v2_Connector** section.
      1. Double-click the operation to view its properties section.
      2. In the 'General' section of the properties, select the Salesforce connection configuration you created.
      3. In the 'Job ID' text box, enter the expression `$ctx:jobId`.

  6. Drag and drop 'Respond' mediator.

<a href="{{base_path}}/assets/img/integrate/connectors/salesforcebulk_v2/Salesforce_bulk_v2_createJobAndUploadFile.png"><img src="{{base_path}}/assets/img/integrate/connectors/salesforcebulk_v2/Salesforce_bulk_v2_createJobAndUploadFile.png" width="800" /></a>

#### - /getJobInfo
  
  Using this resource, users can get the job information.

  1. Drag and drop a 'Property' mediator. This mediator will extract the jobId from the request payload and enable its use in other operations within this sequence.
        ```xml
        <property expression="json-eval($.id)" name="jobId" scope="default" type="STRING"/>
        ```
  2. Drag and drop `getJobInfo` operation from **Salesforce_bulkapi_v2_Connector** section.
      1. Double-click the operation to view its properties section.
      2. In the 'General' section of the properties, select the Salesforce connection configuration you created.
      3. In the 'Job ID' text box, enter the expression `$ctx:jobId`.


        ```xml
        <salesforce_bulkapi_v2.getJobInfo configKey="SF_CONNECTION_CONFIG_NAME_1">
          <jobId>{$ctx:jobId}</jobId>
        </salesforce_bulkapi_v2.getJobInfo>
        ``` 

  3. Drag and drop 'Respond' mediator.

  <a href="{{base_path}}/assets/img/integrate/connectors/salesforcebulk_v2/Salesforce_bulk_v2_getJobInfo.png"><img src="{{base_path}}/assets/img/integrate/connectors/salesforcebulk_v2/Salesforce_bulk_v2_getJobInfo.png" width="600" /></a>

#### - /getSuccessfulResults
  
  Using this resource, users can retrieve the successfully processed records of a particular bulk job.

  1. Drag and drop a 'Property' mediator. This mediator will extract the jobId from the request payload and enable its use in other operations within this sequence.
        ```xml
        <property expression="json-eval($.id)" name="jobId" scope="default" type="STRING"/>
        ```
  2. Drag and drop `getSuccessfulResults` operation from **Salesforce_bulkapi_v2_Connector** section.
      1. Double-click the operation to view its properties section.
      2. In the 'General' section of the properties, select the Salesforce connection configuration you created.
      3. In the 'Job ID' text box, enter the expression `$ctx:jobId`.
      4. In the 'Output type' drop down, select `JSON` or `CSV`.


        ```xml
        <salesforce_bulkapi_v2.getSuccessfulResults configKey="SF_CONNECTION_CONFIG_NAME_1">
          <jobId>{$ctx:jobId}</jobId>
          <outputType>JSON</outputType>
          <includeResultTo>BODY</includeResultTo>
        </salesforce_bulkapi_v2.getSuccessfulResults>
        ``` 

  3. Drag and drop 'Respond' mediator.

  <a href="{{base_path}}/assets/img/integrate/connectors/salesforcebulk_v2/Salesforce_bulk_v2_getSuccessfulResults.png"><img src="{{base_path}}/assets/img/integrate/connectors/salesforcebulk_v2/Salesforce_bulk_v2_getSuccessfulResults.png" width="600" /></a>

#### - /getUnprocessedResults
  
  Using this resource, users can retrieve the unprocessed records of a particular bulk job.

  1. Drag and drop a 'Property' mediator. This mediator will extract the jobId from the request payload and enable its use in other operations within this sequence.
        ```xml
        <property expression="json-eval($.id)" name="jobId" scope="default" type="STRING"/>
        ```
  2. Drag ann drop `getUnprocessedResults` operation from **Salesforce_bulkapi_v2_Connector** section.
      1. Double-click the operation to view its properties section.
      2. In the 'General' section of the properties, select the Salesforce connection configuration you created.
      3. In the 'Job ID' text box, enter the expression `$ctx:jobId`.
      4. In the 'Output type' drop, select `CSV`.


        ```xml
        <salesforce_bulkapi_v2.getUnprocessedResults configKey="SF_CONNECTION_CONFIG_NAME_1">
          <jobId>{$ctx:jobId}</jobId>
          <outputType>CSV</outputType>
          <includeResultTo>BODY</includeResultTo>
        </salesforce_bulkapi_v2.getUnprocessedResults>
        ``` 


  3.  Drag and drop `write` operation from **[File_Connector]({{base_path}}/reference/connectors/file-connector/file-connector-config/#operations)** section.
      1. In the `General` section of the properties, select the File Connection configuration you created.
      2. In the `Basic` section, enter the file path.

  4. Drag and drop 'Respond' mediator.

  <a href="{{base_path}}/assets/img/integrate/connectors/salesforcebulk_v2/Salesforce_bulk_v2_getUnprocessedResults.png"><img src="{{base_path}}/assets/img/integrate/connectors/salesforcebulk_v2/Salesforce_bulk_v2_getUnprocessedResults.png" width="700" /></a>

#### - /deleteJob

  Using this resource, users can delete a perticular bulk job

  1. Drag and drop a 'Property' mediator. This mediator will extract the jobId from the request payload and enable its use in other operations within this sequence.
        ```xml
        <property expression="json-eval($.id)" name="jobId" scope="default" type="STRING"/>
        ```
  2. Drag and drop `deleteJob` operation from **Salesforce_bulkapi_v2_Connector** section.
      1. Double-click the operation to view its properties section.
      2. In the 'General' section of the properties, select the Salesforce connection configuration you created.
      3. In the 'Job ID' text box, enter the expression `$ctx:jobId`.


        ```xml
        <salesforce_bulkapi_v2.deleteJob configKey="SF_CONNECTION_CONFIG_NAME_1">
          <jobId>{$ctx:jobId}</jobId>
        </salesforce_bulkapi_v2.deleteJob>
        ``` 

  3. Drag and drop 'Respond' mediator.

  <a href="{{base_path}}/assets/img/integrate/connectors/salesforcebulk_v2/Salesforce_bulk_v2_deleteJob.png"><img src="{{base_path}}/assets/img/integrate/connectors/salesforcebulk_v2/Salesforce_bulk_v2_deleteJob.png" width="600" /></a>

#### - /createQuery

  Using this resource, users can create a bulk query job in salesforce

  1. Drag and drop `createQueryJob` operation from **Salesforce_bulkapi_v2_Connector** section.
      1. Double-click the operation to view its properties section.
      2. In the 'General' section of the properties, select the Salesforce connection configuration you created.
      3. In the properties section, under `Basic`, select `QUERY` in the Operation dropdown.
      4. Input `SELECT Id, name FROM Account` in the `Object` text box
      5. Select `COMMA` in the `Column Delimeter` dropbox
      6. Select `LF` or `CRLF` in the `Line Ending` dropbox based on your operating system. IF Windows : `CRLF`, for Unix-based systems : `LF`
        
        
        ```xml
        <salesforce_bulkapi_v2.createQueryJob configKey="SF_CONFIG_1">
            <query>SELECT Name FROM Account</query>
            <operation>QUERY</operation>
            <columnDelimiter>COMMA</columnDelimiter>
            <lineEnding>LF</lineEnding>
        </salesforce_bulkapi_v2.createQueryJob>
        ```

  2. Drag and drop 'Respond' mediator.

  <a href="{{base_path}}/assets/img/integrate/connectors/salesforcebulk_v2/Salesforce_bulk_v2_createQueryJob.png"><img src="{{base_path}}/assets/img/integrate/connectors/salesforcebulk_v2/Salesforce_bulk_v2_createQueryJob.png" width="500" /></a>

#### - /getQueryJobInfo
  
  Using this resource, users can get the query job information.

  1. Drag and drop a 'Property' mediator. This mediator will extract the jobId from the request payload and enable its use in other operations within this sequence.
        ```xml
        <property expression="json-eval($.id)" name="jobId" scope="default" type="STRING"/>
        ```
  2. Drag and drop `getQueryJobInfo` operation from **Salesforce_bulkapi_v2_Connector** section.
      1. Double-click the operation to view its properties section.
      2. In the 'General' section of the properties, select the Salesforce connection configuration you created.
      3. In the 'Job ID' text box, enter the expression `$ctx:jobId`.


        ```xml
        <salesforce_bulkapi_v2.getQueryJobInfo configKey="SF_CONNECTION_CONFIG_NAME_1">
          <jobId>{$ctx:jobId}</jobId>
        </salesforce_bulkapi_v2.getQueryJobInfo>
        ``` 

  3. Drag and drop 'Respond' mediator.

  <a href="{{base_path}}/assets/img/integrate/connectors/salesforcebulk_v2/Salesforce_bulk_v2_getQueryJobInfo.png"><img src="{{base_path}}/assets/img/integrate/connectors/salesforcebulk_v2/Salesforce_bulk_v2_getQueryJobInfo.png" width="600" /></a>

#### - /getSuccessfulQueryResults

  Using this resource, users can get the successful query results from salesforce

  1. Drag and drop a 'Property' mediator. This mediator will extract the queryJobId from the request payload and enable its use in other operations within this sequence.
        ```xml
        <property expression="json-eval($.id)" name="queryJobId" scope="default" type="STRING"/>
        ```
  2. Drag and drop `getQueryJobResults` operation from **Salesforce_bulkapi_v2_Connector** section.
      1. Double-click the operation to view its properties section.
      2. In the 'General' section of the properties, select the Salesforce connection configuration you created.
      3. In the 'Job ID' text box, enter the expression `$ctx:jobId`.
        ```xml
        <salesforce_bulkapi_v2.getQueryJobResults configKey="SF_CONNECTION_CONFIG_NAME_1">
                <queryJobId>{$ctx:queryJobId}</queryJobId>
                <outputType>JSON</outputType>
                <includeResultTo>FILE</includeResultTo>
                <filePath>/path/to/file/out.json</filePath>
            </salesforce_bulkapi_v2.getQueryJobResults>
        ``` 

        > **Note:** The includeResultTo 'FILE' feature is `deprecated`. 

  3. Drag and drop 'Respond' mediator.

  <a href="{{base_path}}/assets/img/integrate/connectors/salesforcebulk_v2/Salesforce_bulk_v2_getQueryJobResults.png"><img src="{{base_path}}/assets/img/integrate/connectors/salesforcebulk_v2/Salesforce_bulk_v2_getQueryJobResults.png" width="600" /></a>


??? info "The resources are now ready to be tested. The API source should resemble the following. Expand to see."
    ```xml
    <?xml version="1.0" encoding="UTF-8"?>
    <api context="/salesforce" name="createjob" xmlns="http://ws.apache.org/ns/synapse">
        <resource methods="POST" uri-template="/createJobAndUploadData">
            <inSequence>
                <enrich>
                    <source clone="true" type="body"/>
                    <target property="csvContent" type="property"/>
                </enrich>
                <salesforce_bulkapi_v2.createJob configKey="SF_CONNECTION_CONFIG_NAME_1">
                    <operation>INSERT</operation>
                    <object>Account</object>
                    <columnDelimiter>COMMA</columnDelimiter>
                    <lineEnding>LF</lineEnding>
                </salesforce_bulkapi_v2.createJob>
                <property expression="json-eval($.id)" name="jobId" scope="default" type="STRING"/>
                <salesforce_bulkapi_v2.uploadJobData configKey="SF_CONNECTION_CONFIG_NAME_1">
                    <jobId>{$ctx:jobId}</jobId>
                    <inputData>{$ctx:csvContent}</inputData>
                </salesforce_bulkapi_v2.uploadJobData>
                <salesforce_bulkapi_v2.closeJob configKey="SF_CONNECTION_CONFIG_NAME_1">
                    <jobId>{$ctx:jobId}</jobId>
                </salesforce_bulkapi_v2.closeJob>
                <respond/>
            </inSequence>
            <outSequence/>
            <faultSequence/>
        </resource>
        <resource methods="POST GET" uri-template="/createJobAndUploadFile">
            <inSequence>
                <salesforce_bulkapi_v2.createJob configKey="SF_CONNECTION_CONFIG_NAME_1">
                    <operation>INSERT</operation>
                    <object>Account</object>
                    <columnDelimiter>COMMA</columnDelimiter>
                    <lineEnding>LF</lineEnding>
                </salesforce_bulkapi_v2.createJob>
                <property expression="json-eval($.id)" name="jobId" scope="default" type="STRING"/>
                <file.read configKey="MY_CONN">
                    <path>data.csv</path>
                    <readMode>Complete File</readMode>
                    <startLineNum>0</startLineNum>
                    <lineNum>0</lineNum>
                    <includeResultTo>Message Property</includeResultTo>
                    <resultPropertyName>csvContent</resultPropertyName>
                    <enableStreaming>false</enableStreaming>
                    <enableLock>false</enableLock>
                </file.read>
                <salesforce_bulkapi_v2.uploadJobData configKey="SF_CONNECTION_CONFIG_NAME_1">
                    <jobId>{$ctx:jobId}</jobId>
                    <inputData>{$ctx:csvContent}</inputData>
                </salesforce_bulkapi_v2.uploadJobData>
                <salesforce_bulkapi_v2.closeJob configKey="SF_CONNECTION_CONFIG_NAME_1">
                    <jobId>{$ctx:jobId}</jobId>
                </salesforce_bulkapi_v2.closeJob>
                <respond/>
            </inSequence>
            <outSequence/>
            <faultSequence/>
        </resource>
        <resource methods="POST" uri-template="/getJobInfo">
            <inSequence>
                <property expression="json-eval($.id)" name="jobId" scope="default" type="STRING"/>
                <salesforce_bulkapi_v2.getJobInfo configKey="SF_CONNECTION_CONFIG_NAME_1">
                    <jobId>{$ctx:jobId}</jobId>
                </salesforce_bulkapi_v2.getJobInfo>
                <respond/>
            </inSequence>
            <outSequence/>
            <faultSequence/>
        </resource>
        <resource methods="POST" uri-template="/getSuccessfulResults">
            <inSequence>
                <property expression="json-eval($.id)" name="jobId" scope="default" type="STRING"/>
                <salesforce_bulkapi_v2.getSuccessfulResults configKey="SF_CONNECTION_CONFIG_NAME_1">
                    <jobId>{$ctx:jobId}</jobId>
                    <outputType>JSON</outputType>
                    <includeResultTo>BODY</includeResultTo>
                </salesforce_bulkapi_v2.getSuccessfulResults>
                <respond/>
            </inSequence>
            <outSequence/>
            <faultSequence/>
        </resource>
        <resource methods="POST" uri-template="/getUnprocessedResults">
            <inSequence>
                <property expression="json-eval($.id)" name="jobId" scope="default" type="STRING"/>
                <salesforce_bulkapi_v2.getUnprocessedResults configKey="SF_CONNECTION_CONFIG_NAME_1">
                    <jobId>{$ctx:jobId}</jobId>
                    <outputType>CSV</outputType>
                    <includeResultTo>BODY</includeResultTo>
                </salesforce_bulkapi_v2.getUnprocessedResults>
                <file.write configKey="MY_CONN">
                    <filePath>path/to/folder/out.csv</filePath>
                    <mimeType>Automatic</mimeType>
                    <writeMode>Append</writeMode>
                    <enableStreaming>false</enableStreaming>
                    <appendNewLine>false</appendNewLine>
                    <enableLock>false</enableLock>
                    <includeResultTo>Message Body</includeResultTo>
                    <updateLastModified>true</updateLastModified>
                </file.write>
                <respond/>
            </inSequence>
            <outSequence/>
            <faultSequence/>
        </resource>
        <resource methods="POST" uri-template="/deleteJob">
            <inSequence>
                <property expression="json-eval($.id)" name="jobId" scope="default" type="STRING"/>
                <salesforce_bulkapi_v2.deleteJob configKey="SF_CONNECTION_CONFIG_NAME_1">
                    <jobId>{$ctx:jobId}</jobId>
                </salesforce_bulkapi_v2.deleteJob>
                <respond/>
            </inSequence>
            <outSequence/>
            <faultSequence/>
        </resource>
        <resource methods="POST GET" uri-template="/createQuery">
            <inSequence>
                <salesforce_bulkapi_v2.createQueryJob configKey="SF_CONNECTION_CONFIG_NAME_1">
                    <query>SELECT Id, name FROM Account</query>
                    <operation>QUERY</operation>
                    <columnDelimiter>COMMA</columnDelimiter>
                    <lineEnding>LF</lineEnding>
                </salesforce_bulkapi_v2.createQueryJob>
                <respond/>
            </inSequence>
            <outSequence/>
            <faultSequence/>
        </resource>
        <resource methods="POST" uri-template="/getQueryJobInfo">
            <inSequence>
                <property expression="json-eval($.id)" name="jobId" scope="default" type="STRING"/>
                <salesforce_bulkapi_v2.getQueryJobInfo configKey="SF_CONFIG_1">
                    <queryJobId>{$ctx:jobId}</queryJobId>
                </salesforce_bulkapi_v2.getQueryJobInfo>
                <log level="full"/>
                <respond/>
            </inSequence>
            <outSequence/>
            <faultSequence/>
        </resource>
        <resource methods="POST" uri-template="/getSuccessfulQueryResults">
            <inSequence>
                <property expression="json-eval($.id)" name="queryJobId" scope="default" type="STRING"/>
                <log level="custom">
                    <property expression="$ctx:queryJobId" name="testprop1"/>
                </log>
                <salesforce_bulkapi_v2.getQueryJobResults configKey="SF_CONNECTION_CONFIG_NAME_1">
                    <queryJobId>{$ctx:queryJobId}</queryJobId>
                    <outputType>JSON</outputType>
                    <includeResultTo>FILE</includeResultTo>
                    <filePath>path/to/file/out.json</filePath>
                </salesforce_bulkapi_v2.getQueryJobResults>
                <respond/>
            </inSequence>
            <outSequence/>
            <faultSequence/>
        </resource>
    </api>
    ```

### Testing the resources

Let's test the API. Start the MI and deploy the API. 

1. Let's create a bulk ingest job using our `/createJobAndUploadData` resource. To invoke the resource,  use the following curl command:
    ```bash
    curl --location 'http://localhost:8290/salesforce/createJobAndUploadData' \
    --header 'Content-Type: text/plain' \
    --header 'Cookie: CookieConsentPolicy=0:1; LSKey-c$CookieConsentPolicy=0:1' \
    --data 'Name,ShippingCity,NumberOfEmployees,AnnualRevenue,Website,Description
    Lorem Ipsum,Milano,2676,912260031,https://ft.com/lacus/at.jsp,"Lorem ipsum dolor sit amet"'
    ```
  You will receive a response similar to the following:
    ```json
    {
      "id": "7508d00000Ihhl5AAB",
      "operation": "insert",
      "object": "Account",
      "createdById": "0058d000006mtd1AAA",
      "createdDate": "2023-03-16T06:43:09.000+0000",
      "systemModstamp": "2023-03-16T06:43:09.000+0000",
      "state": "UploadComplete",
      "concurrencyMode": "Parallel",
      "contentType": "CSV",
      "apiVersion": 57.0
    }
    ```
  Note down the `id` from the response.

2. Let's create a bulk ingest job using our `/createJobAndUploadFile` resource. To invoke the resource,  use the following curl command:
    ```bash
    curl --location 'http://localhost:8290/salesforce/createJobAndUploadFile' \
    --header 'Content-Type: text/plain' \
    --header 'Cookie: CookieConsentPolicy=0:1; LSKey-c$CookieConsentPolicy=0:1'
    ```
  You will receive a response similar to the following:
    ```json
    {
      "id": "7508d00000Ahhl5AAB",
      "operation": "insert",
      "object": "Account",
      "createdById": "0058d000006mtd1AAA",
      "createdDate": "2023-03-16T06:43:09.000+0000",
      "systemModstamp": "2023-03-16T06:43:09.000+0000",
      "state": "UploadComplete",
      "concurrencyMode": "Parallel",
      "contentType": "CSV",
      "apiVersion": 57.0
    }
    ```
  Note down the `id` from the response.

3. Let's get the job information of the bulk job using our `/getJobInfo` resource. To invoke the resource, please use the following curl command: 
  ```bash
  curl --location 'http://localhost:8290/salesforce/getJobInfo' \
  --header 'Content-Type: application/json' \
  --header 'Cookie: CookieConsentPolicy=0:1; LSKey-c$CookieConsentPolicy=0:1' \
  --data '{
      "id" : "7508d00000Ihhl5AAB"
  }'
  ```
  Make sure you replace the `id` value. You will receive a response similar to the following:

    ```json
    {
      "id": "7508d00000Ihhl5AAB",
      "operation": "insert",
      "object": "Account",
      "createdById": "0058d000006mtd1AAA",
      "createdDate": "2023-03-16T06:43:09.000+0000",
      "systemModstamp": "2023-03-16T06:43:13.000+0000",
      "state": "JobComplete",
      "concurrencyMode": "Parallel",
      "contentType": "CSV",
      "apiVersion": 57.0,
      "jobType": "V2Ingest",
      "lineEnding": "LF",
      "columnDelimiter": "COMMA",
      "numberRecordsProcessed": 1,
      "numberRecordsFailed": 0,
      "retries": 0,
      "totalProcessingTime": 139,
      "apiActiveProcessingTime": 81,
      "apexProcessingTime": 0
    }
    ```

4. Let's get the successfully processed records using our `/getSuccessfulResults` resource. To invoke the resource, please use the following curl command: 
    ```bash
    curl --location 'http://localhost:8290/salesforce/getSuccessfulResults' \
    --header 'Content-Type: application/json' \
    --header 'Cookie: CookieConsentPolicy=0:1; LSKey-c$CookieConsentPolicy=0:1' \
    --data '{
        "id" : "7508d00000Ihhl5AAB"
    }'
    ```
  Make sure you replace the `id` value. You will receive a response similar to the following:

    ```json
    [
      {
        "sf__Id": "0018d00000UVCjuAAH",
        "sf__Created": "true",
        "Name": "Lorem Ipsum",
        "ShippingCity": "Milano",
        "NumberOfEmployees": "2676",
        "AnnualRevenue": "9.12260031E8",
        "Website": "https://ft.com/lacus/at.jsp",
        "Description": "Lorem ipsum dolor sit amet"
      }
    ]
    ```

5. Let's get the successfully processed records using our `/getUnprocessedResults` resource. To invoke the resource, please use the following curl command: 
    ```bash
    curl --location 'http://localhost:8290/salesforce/getUnprocessedResults' \
    --header 'Content-Type: application/json' \
    --header 'Cookie: CookieConsentPolicy=0:1; LSKey-c$CookieConsentPolicy=0:1' \
    --data '{
        "id" : "7508d00000Ihhl5AAB"
    }'
    ```
  Make sure you replace the `id` value. Upon successful execution, you will receive a `200 OK` response, and the output will be written to the designated file.
  ```json
    {
      "result": "success",
    }
  ```  

6. Let's delete the bulk job using our `/deleteJob` resource. To invoke the resource, please use the following curl command:

    ```bash
    curl --location 'http://localhost:8290/salesforce/deleteJob' \
    --header 'Content-Type: application/json' \
    --header 'Cookie: CookieConsentPolicy=0:1; LSKey-c$CookieConsentPolicy=0:1' \
    --data '{
        "id" : "7508d00000Ihhl5AAB"
    }'
    ```
  Make sure you replace the `id` value.  
  Upon successful execution, you will receive a response similar to the following,
  ```json
    {
      "result": "success",
    }
  ```  
  In the event that the provided job ID does not exist, the API will respond with a `404 Not Found` response.

7. Let's create a bulk query job using our `/createQuery` resource. To invoke the resource, please use the following curl command:

    ```bash
    curl --location --request POST 'http://localhost:8290/salesforce/createQuery' \
    --header 'Cookie: CookieConsentPolicy=0:1; LSKey-c$CookieConsentPolicy=0:1'
    ```
  You will receive a response similar to the following:

    ```json
    {
      "id": "7508d00000IhhkKAAR",
      "operation": "query",
      "object": "Account",
      "createdById": "0058d000006mtd1AAA",
      "createdDate": "2023-03-16T06:37:50.000+0000",
      "systemModstamp": "2023-03-16T06:37:50.000+0000",
      "state": "UploadComplete",
      "concurrencyMode": "Parallel",
      "contentType": "CSV",
      "apiVersion": 57.0,
      "lineEnding": "LF",
      "columnDelimiter": "COMMA"
    }
    ```
  Make sure you replace the `id` value.

8. Let's get the job information of the query job using our `/getQueryJobInfo` resource. To invoke the resource, please use the following curl command: 
  ```bash
  curl --location 'http://localhost:8290/salesforce/getQueryJobInfo' \
  --header 'Content-Type: application/json' \
  --header 'Cookie: CookieConsentPolicy=0:1; LSKey-c$CookieConsentPolicy=0:1' \
  --data '{
      "id" : "7508d00000Ihhl5AAB"
  }'
  ```
  Make sure you replace the `id` value. You will receive a response similar to the following:

    ```json
    {
      "id":"7508d00000Ihhl5AAB",
      "operation":"query",
      "object":"Account",
      "createdById":"0055j000008dizPAAQ",
      "createdDate":"2023-08-23T16:12:50.000+0000",
      "systemModstamp":"2023-08-23T16:12:50.000+0000",
      "state":"JobComplete",
      "concurrencyMode":"Parallel",
      "contentType":"CSV",
      "apiVersion":57.0,
      "jobType":"V2Query",
      "lineEnding":"LF",
      "columnDelimiter":"COMMA",
      "numberRecordsProcessed":28,
      "retries":0,
      "totalProcessingTime":255
    }
    ```

9. Let's get the query results using our `/getSuccessfulQueryResults` resource. To invoke the resource, please use the following curl command:

    ```bash
    curl --location 'http://localhost:8290/salesforce/getSuccessfulQueryResults' \
    --header 'Content-Type: application/json' \
    --header 'Cookie: CookieConsentPolicy=0:1; LSKey-c$CookieConsentPolicy=0:1' \
    --data '{
      "id" : "7508d00000IhhkKAAR"
    }'
    ```
  Make sure you replace the `id` value. You will receive a response similar to the following:
    ```json
    [
      {
          "Id": "0018d00000SIDcyAAH",
          "Name": "Sample Account for Entitlements"
      }
    ]
    ```

## What's Next

- To customize this example for your own scenario, see [Salesforce bulk V2 Connector Configuration]({{base_path}}/reference/connectors/salesforce-connectors/salesforcebulk-v2-reference/) documentation for all operation details of the connector.
