# Salesforce Bulk v2.0 Connector Example

The **Salesforce Bulk v2.0 Connector** provides seamless integration with the [Salesforce Bulk v2.0 REST API](https://developer.salesforce.com/docs/atlas.en-us.api_asynch.meta/api_asynch/asynch_api_intro.htm), enabling easy and efficient handling of large volumes of data. The SalesforceBulk API operates on a RESTful architecture, offering a fast and reliable method to load or delete vast amounts of data from your organization's Salesforce account. With SalesforceBulk, you can perform asynchronous operations like querying, inserting, updating, upserting, or deleting a considerable number of records by submitting them in batches. These batches can be processed by Salesforce in the background, ensuring minimal disruption to your workflow.


## What you'll build

The following example demonstrates how to use the Salesforce Bulk v2.0 Connector for performing various operations on your Salesforce data:

1. Insert account records to the salesforce.
2. Get the created bulk job information. 
3. Get the successfully processed records to a file.
4. Delete the bulk job.
5. Create a query job to get account details.
6. Get the successful results of the created query job to a file.

You can use the following resources to achieve your requirements.

* `/createJobAndUploadData` : 
  1. Create a new bulk ingest job for insert operation
  2. Upload the CSV content passed through the request body
  3. Close the job to denote that the upload is completed.
* `/getJobInfo` : 
  1. Get the bulkJob info identified by the jobId passed through the request body
* `/getSuccessfulResults` : 
  1. Retrive the successful results of the bulk job identified by the jobId
* `/deleteJob` : 
  1. Delete the bulkJob identified by the jobId passed through the request body
* `/createQuery` : 
  1. Create a query job in salesforce
* `/getSuccessfulQueryResults` : 
  1. Retrive the successful results of the bulk query job identified by the queryJobId 

## Configure the connector in WSO2 Integration Studio

Connectors can be added to integration flows in [WSO2 Integration Studio](https://wso2.com/integration/integration-studio/). Once added, the operations of the connector can be dragged onto your canvas and added to your sequences.

### Import the connector

Follow these steps to set up the Integration Project and the Connector Exporter Project. 

{!includes/reference/connectors/importing-connector-to-integration-studio.md!} 

### Add integration logic

First create a REST API called `Salesforce` in your project

| Name | Context |
| ---------------- | ---------------- |
| Salesforce  | /salesforce  |

Create the following resources in 'Salesforce' REST API

| uri-template |
| ---------------- | 
| /createJobAndUploadData  |
| /getJobInfo  |
| /getSuccessfulResults  |
| /deleteJob  |
| /createQuery  |
| /getSuccessfulQueryResults  |


Lets add the operations to the resources in `Salesforce` API

* /createJobAndUploadData

  Users can utilize this resource to send CSV content for upload via the request body. The API will utilize an 'enrich' mediator to store the CSV content in a 'csvContent' property. The 'UploadJobData' operation will then upload the 'csvContent'. After uploading the content, the 'CloseJob' operation will be used to change the job status to 'UploadComplete'.

    1. In the API insequence drag and drop the Enrich mediator. Using the Enrich mediator clone the body content to a property called `csvContent`.
      Enrich source: 

      ```xml
        <enrich>
          <source clone="true" type="body"/>
          <target property="csvContent" type="property"/>
        </enrich>
      ```  

    2. Drag and drop 'createJob' operation from Salesforce_bulkapi_v2_Connector section.
        1. Double click the operation. It will show you the properties section.
        2. In the properties section, In the General Section, click on the `+` button next to `Salesforce Configuration`
           1. In the `Connection configurtion` section give a name for `Salesforce Connection Name`
           2. Provide your Salesforce instance URL in the `Instance URL` text box.
           3. Provide your Salesforce connected app's client id in the `Client ID` text box.
           4. Provide your Salesforce connected app's client secret in the `Client Secret` text box.
           5. Provide your Salesforce connected app's refresh token in the `Refresh Token` text box.
           6. Provide your Salesforceconnected app's Access Token in the `Access Token` text box.
           7. Click finish
        3. In the properties section, under `Basic`, select `INSERT` in the Operation dropdown.
        4. Input `Account` in the `Object` text box
        5. Select `COMMA` in the `Column Delimeter` dropbox
        6. Select `LF` or `CRLF` in the `Line Ending` dropbox based on your operating system. IF Windows : `CRLF`, for Unix-based systems : `LF`

    3. Drag and drop a property mediator. Using this mediator we will extract the jobId from the response and will use it in other operations in this sequence.
 
      
      ```xml
        <property expression="json-eval($.id)" name="jobId" scope="default" type="STRING"/>
      ```

    4. Drag and drop `uploadJobData` operation from Salesforce_bulkapi_v2_Connector section.
       1. Double click the operation. It will show you the properties section.
       2. In the 'General' section of the properties, select the Salesforce connection configuration you created.
       3. For `Job ID` text box enter `$ctx:jobId` as expression.
       4. For `Input Type` select `INLINE`
       5. For `Input Data` enter `$ctx:payload//text()` as the expression

  
      ```xml
      <salesforce_bulkapi_v2.uploadJobData configKey="SF_CONNECTION_CONFIG_NAME_1">
        <jobId>{$ctx:jobId}</jobId>
        <inputType>INLINE</inputType>
        <inputData>{$ctx:payload//text()}</inputData>
        <filePath></filePath>
      </salesforce_bulkapi_v2.uploadJobData>
      ```

    5. Drag and drop `closeJob` operation from Salesforce_bulkapi_v2_Connector section.
      1. Double-click the operation to view its properties section.
      2. In the 'General' section of the properties, select the Salesforce connection configuration you created.
      3. In the 'Job ID' text box, enter the expression `$ctx:jobId`.

    6. Drag and rdrop 'Respond' mediator.


* /getJobInfo
  
  Using this resource, users can get the job information.

    1. Drag and drop a 'Property' mediator. This mediator will extract the jobId from the request payload and enable its use in other operations within this sequence.
        ```xml
        <property expression="json-eval($.id)" name="jobId" scope="default" type="STRING"/>
        ```
    2. Drag and drop `getJobInfo` operation from Salesforce_bulkapi_v2_Connector section.
      1. Double-click the operation to view its properties section.
      2. In the 'General' section of the properties, select the Salesforce connection configuration you created.
      3. In the 'Job ID' text box, enter the expression `$ctx:jobId`.


        ```xml
        <salesforce_bulkapi_v2.getJobInfo configKey="SF_CONNECTION_CONFIG_NAME_1">
          <jobId>{$ctx:jobId}</jobId>
        </salesforce_bulkapi_v2.getJobInfo>
        ``` 
    3. Drag and drop 'Respond' mediator.

* /getSuccessfulResults
  
  Using this resource, users can retrieve the successfully processed records of a particular bulk job.

    1. Drag and drop a 'Property' mediator. This mediator will extract the jobId from the request payload and enable its use in other operations within this sequence.
        ```xml
        <property expression="json-eval($.id)" name="jobId" scope="default" type="STRING"/>
        ```
    2. Drag ann drop `getSuccessfulResults` operation from Salesforce_bulkapi_v2_Connector section.
      1. Double-click the operation to view its properties section.
      2. In the 'General' section of the properties, select the Salesforce connection configuration you created.
      3. In the 'Job ID' text box, enter the expression `$ctx:jobId`.


        ```xml
        <salesforce_bulkapi_v2.getSuccessfulResults configKey="SF_CONNECTION_CONFIG_NAME_1">
          <jobId>{$ctx:jobId}</jobId>
          <outputType>BODY</outputType>
          <filePath></filePath>
        </salesforce_bulkapi_v2.getSuccessfulResults>
        ``` 
    3. Drag and drop 'Respond' mediator.

* /deleteJob

  Using this resource, users can delete a perticular bulk job

    1. Drag and drop a 'Property' mediator. This mediator will extract the jobId from the request payload and enable its use in other operations within this sequence.
        ```xml
        <property expression="json-eval($.id)" name="jobId" scope="default" type="STRING"/>
        ```
    2. Drag ann drop `getSuccessfulResults` operation from Salesforce_bulkapi_v2_Connector section.
      1. Double-click the operation to view its properties section.
      2. In the 'General' section of the properties, select the Salesforce connection configuration you created.
      3. In the 'Job ID' text box, enter the expression `$ctx:jobId`.


        ```xml
        <salesforce_bulkapi_v2.getSuccessfulResults configKey="SF_CONNECTION_CONFIG_NAME_1">
          <jobId>{$ctx:jobId}</jobId>
          <outputType>BODY</outputType>
          <filePath></filePath>
        </salesforce_bulkapi_v2.getSuccessfulResults>
        ``` 
    3. Drag and drop 'Respond' mediator.

* /createQuery

  Using this resource, users can create a bulk query job in salesforce

    1. Drag ann drop `createQueryJob` operation from Salesforce_bulkapi_v2_Connector section.
      1. Double-click the operation to view its properties section.
      2. In the 'General' section of the properties, select the Salesforce connection configuration you created.
      3. In the properties section, under `Basic`, select `QUERY` in the Operation dropdown.
      4. Input `SELECT Id, name FROM Account` in the `Object` text box
      5. Select `COMMA` in the `Column Delimeter` dropbox
      6. Select `LF` or `CRLF` in the `Line Ending` dropbox based on your operating system. IF Windows : `CRLF`, for Unix-based systems : `LF`

    2. Drag and drop 'Respond' mediator.

* /getSuccessfulQueryResults

  Using this resource, users can get the successful query results from salesforce

    1. Drag and drop a 'Property' mediator. This mediator will extract the queryJobId from the request payload and enable its use in other operations within this sequence.
        ```xml
        <property expression="json-eval($.id)" name="queryJobId" scope="default" type="STRING"/>
        ```
    2. Drag ann drop `getQueryJobResults` operation from Salesforce_bulkapi_v2_Connector section.
      1. Double-click the operation to view its properties section.
      2. In the 'General' section of the properties, select the Salesforce connection configuration you created.
      3. In the 'Job ID' text box, enter the expression `$ctx:jobId`.


        ```xml
        <salesforce_bulkapi_v2.getQueryJobResults configKey="SF_CONNECTION_CONFIG_NAME_1">
                <queryJobId>{$ctx:queryJobId}</queryJobId>
                <outputType>BODY</outputType>
            </salesforce_bulkapi_v2.getQueryJobResults>
        ``` 
    3. Drag and drop 'Respond' mediator.


The resources are now ready to be tested. The API source should resemble the following:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<api context="/salesforce" name="createjob" xmlns="http://ws.apache.org/ns/synapse">
    <resource methods="POST GET" uri-template="/createJobAndUploadData">
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
                <inputType>INLINE</inputType>
                <inputData>{$ctx:csvContent//text()}</inputData>
            </salesforce_bulkapi_v2.uploadJobData>
            <salesforce_bulkapi_v2.closeJob configKey="SF_CONNECTION_CONFIG_NAME_1">
                <jobId>{$ctx:jobId}</jobId>
            </salesforce_bulkapi_v2.closeJob>
            <respond/>
        </inSequence>
        <outSequence/>
        <faultSequence/>
    </resource>
    <resource methods="POST GET" uri-template="/getJobInfo">
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
    <resource methods="POST GET" uri-template="/getSuccessfulResults">
        <inSequence>
            <property expression="json-eval($.id)" name="jobId" scope="default" type="STRING"/>
            <salesforce_bulkapi_v2.getSuccessfulResults configKey="SF_CONNECTION_CONFIG_NAME_1">
                <jobId>{$ctx:jobId}</jobId>
                <outputType>BODY</outputType>
            </salesforce_bulkapi_v2.getSuccessfulResults>
            <respond/>
        </inSequence>
        <outSequence/>
        <faultSequence/>
    </resource>
    <resource methods="POST GET" uri-template="/deleteJob">
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
    <resource methods="POST GET" uri-template="/getSuccessfulQueryResults">
        <inSequence>
            <property expression="json-eval($.id)" name="queryJobId" scope="default" type="STRING"/>
            <log level="custom">
                <property expression="$ctx:queryJobId" name="testprop1"/>
            </log>
            <salesforce_bulkapi_v2.getQueryJobResults configKey="SF_CONNECTION_CONFIG_NAME_1">
                <queryJobId>{$ctx:queryJobId}</queryJobId>
                <outputType>BODY</outputType>
            </salesforce_bulkapi_v2.getQueryJobResults>
            <respond/>
        </inSequence>
        <outSequence/>
        <faultSequence/>
    </resource>
</api>

```

### Testing the resources

Lets test the api. Start the MI and deploy the API. 

1. Let's create a bulk ingest job using our `/createJobAndUploadData` resource. To invoke the resource, please use the following curl command:

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

1. Let's get the job information of the bulk job using our `/getJobInfo` resource. To invoke the resource, please use the following curl command: 

  ```bash
  curl --location 'http://localhost:8290/salesforce/getJobInfo' \
  --header 'Content-Type: application/json' \
  --header 'Cookie: CookieConsentPolicy=0:1; LSKey-c$CookieConsentPolicy=0:1' \
  --data '{
      "id" : "7508d00000Ihhl5AAB"
  }'
  ```
  (Please replace the id value)


  You will receive a response similar to the following:

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

3. Let's get the successfully processed records using our `/getSuccessfulResults` resource. To invoke the resource, please use the following curl command: 

  ```bash
  curl --location 'http://localhost:8290/salesforce/getSuccessfulResults' \
  --header 'Content-Type: application/json' \
  --header 'Cookie: CookieConsentPolicy=0:1; LSKey-c$CookieConsentPolicy=0:1' \
  --data '{
      "id" : "7508d00000Ihhl5AAB"
  }'
  ```
  (Please replace the id value)


  You will receive a response similar to the following:

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

4. Let's delete the bulk job using our `/deleteJob` resource. To invoke the resource, please use the following curl command:

  ```bash
  curl --location 'http://localhost:8290/salesforce/deleteJob' \
  --header 'Content-Type: application/json' \
  --header 'Cookie: CookieConsentPolicy=0:1; LSKey-c$CookieConsentPolicy=0:1' \
  --data '{
      "id" : "7508d00000Ihhl5AAB"
  }'
  ```
  (Please replace the id value)

  You will receive a response similar to the following:

  ```json
  {
    "result": "Success"
  }
  ```

5. Let's create a bulk query job using our `/createQuery` resource. To invoke the resource, please use the following curl command:

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
  (Note down the id value)

6. Let's get the query results using our `/createQuery` resource. To invoke the resource, please use the following curl command:

  ```bash
  curl --location 'http://localhost:8290/salesforce/getSuccessfulQueryResults' \
  --header 'Content-Type: application/json' \
  --header 'Cookie: CookieConsentPolicy=0:1; LSKey-c$CookieConsentPolicy=0:1' \
  --data '{
      "id" : "7508d00000IhhkKAAR"
  }'
  ```
  (Please replace the id value)


  You will receive a response similar to the following:

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
