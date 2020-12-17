# SalesforceBulk Connector Reference

The following operations allow you to work with the Salesforce Bulk Connector. Click an operation name to see parameter details and samples on how to use it.

---

## Initialize the connector

Salesforce Bulk API uses the OAuth protocol to allow application users to securely access data without having to reveal their user credentials. For more information on how authentication is done in Salesforce, see [Understanding Authentication](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/intro_understanding_authentication.htm).

To use the Salesforce Bulk connector, add the `<salesforcerest.init>` element in your configuration before carrying out any other Salesforce Bulk operations. 

??? note "salesforcebulk.init"
    The salesforcerest.init operation initializes the connector to interact with the Salesforce REST API. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_asynch.meta/api_asynch/asynch_api_intro.htm) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>apiVersion</td>
            <td>The version of the Salesforce API.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>accessToken</td>
            <td>The access token to authenticate your API calls.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>apiUrl</td>
            <td>The instance URL for your organization.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>tokenEndpointHostname</td>
            <td>The instance url for OAuth 2.0 token endpoint when issuing authentication requests in your application. If you haven't set any token endpoint hostname, the default hostname [https://login.salesforce.com](https://login.salesforce.com) will be set.</td>
            <td>No</td>
        </tr>
        <tr>
            <td>refreshToken</td>
            <td>The refresh token that you received to refresh the API access token.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>clientId</td>
            <td>The consumer key of the connected application that you created.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>clientSecret</td>
            <td>The consumer secret of the connected application that you created.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>intervalTime</td>
            <td>The time interval in milliseconds, after which you need to check the validity of the access token.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>registryPath</td>
            <td>The registry path of the connector. You must specify the registry path as follows: registryPath = “connectors/salesforcebulk”</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcebulk.init>
        <apiVersion>{$ctx:apiVersion}</apiVersion>
        <accessToken>{$ctx:accessToken}</accessToken>
        <apiUrl>{$ctx:apiUrl}</apiUrl>
        <tokenEndpointHostname>{$ctx:tokenEndpointHostname}</tokenEndpointHostname>
        <refreshToken>{$ctx:refreshToken}</refreshToken>
        <clientId>{$ctx:clientId}</clientId>
        <clientSecret>{$ctx:clientSecret}</clientSecret>
        <intervalTime>{$ctx:intervalTime}</intervalTime>
        <registryPath>{$ctx:registryPath}</registryPath>
    </salesforcebulk.init>
    ```

    **Sample request**

    ```xml
    <salesforcebulk.init>
        <apiVersion>34.0</apiVersion>
        <accessToken>00D280000011oQO!ARwAQFPbKzWInyf.4veB3NY0hiKNQTxaSiZnPh9AybHplDpix34y_UOdwiKcL3e1_IquaUuO3A54A4thmSplNUQei9ARsNFV</accessToken>
        <apiUrl>https://ap17.salesforce.com</apiUrl>
        <tokenEndpointHostname>{$ctx:tokenEndpointHostname}</tokenEndpointHostname>
        <refreshToken>5Aep861TSESvWeug_wHqvFVePrOMjj7CUFncs.cGdlPln68mKYpAbAJ9l7A5FTFsmqFY8Jl0m6fkIMWkIKc4WKL</refreshToken>
        <clientId>3MVG9ZL0ppGP5UrDGNWmP9oSpiNtudQv6b06Ru7K6UPW5xQhd6vakhfjA2HUGsLSpDOQmO8JGozttODpABcnY</clientId>
        <clientSecret>5437293348319318299</clientSecret>
        <intervalTime>1000000</intervalTime>
        <registryPath>connectors/SalesforceBulk</registryPath>
    </salesforcebulk.init>
    ```
---

## Working with Jobs
    
??? note "createJob"
    The salesforcebulk.createJob method creates a new job based on the properties that you specify. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_asynch.meta/api_asynch/asynch_api_quickstart_create_job.htm) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>operation</td>
            <td>The processing operation that the job should perform.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>contentType</td>
            <td>The content type of the job.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>object</td>
            <td>The object type of data that is to be processed by the job.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>externalIdFieldName</td>
            <td>The id of the external object.</td>
            <td>No</td>
        </tr>
    </table>

    **Sample configuration**
    
    Following is a sample request that can be handled by the createJob operation.

    ```xml
    <salesforcebulk.createJob>
        <operation>{$ctx:operation}</operation>
        <contentType>{$ctx:contentType}</contentType>
        <object>{$ctx:object}</object>
        <externalIdFieldName>{$ctx:externalIdFieldName}</externalIdFieldName>
    </salesforcebulk.createJob>
    ```

    **Sample request**
    
    ```xml
    <createJob>
       <apiVersion>34.0</apiVersion>
       <accessToken>00D280000011oQO!ARwAQFPbKzWInyf.4veB3NY0hiKNQTxaSiZnPh9AybHplDpix34y_UOdwiKcL3e1_IquaUuO3A54A4thmSplNUQei9ARsNFV</accessToken>
       <apiUrl>https://ap2.salesforce.com</apiUrl>
       <refreshToken>5Aep861TSESvWeug_wHqvFVePrOMjj7CUFncs.cGdlPln68mKYpAbAJ9l7A5FTFsmqFY8Jl0m6fkIMWkIKc4WKL</refreshToken>
       <clientId>3MVG9ZL0ppGP5UrDGNWmP9oSpiNtudQv6b06Ru7K6UPW5xQhd6vakhfjA2HUGsLSpDOQmO8JGozttODpABcnY</clientId>
       <clientSecret>5437293348319318299</clientSecret>
       <intervalTime>1000000</intervalTime>
       <registryPath>connectors/SalesforceBulk</registryPath>
       <operation>insert</operation>
       <contentType>CSV</contentType>
       <object>Contact</object>
       <externalIdFieldName>Languages__c</externalIdFieldName>
    </createJob>
    ```
    
??? note "updateJob"
    The salesforcebulk.updateJob method closes or aborts a job that you specify. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_asynch.meta/api_asynch/asynch_api_quickstart_close_job.htm) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>jobId</td>
            <td>The ID of the job that you either want to close or abort.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>state</td>
            <td>The state of processing of the job.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**
    
    Following is a sample request that can be handled by the updateJob operation.

    ```xml
    <salesforcebulk.updateJob>
        <jobId>{$ctx:jobId}</jobId>
        <state>{$ctx:state}</state>
    </salesforcebulk.updateJob>
    ```

    **Sample request**
    
    ```xml
    <updateJob>
       <apiVersion>34.0</apiVersion>
       <accessToken>00D280000011oQO!ARwAQFPbKzWInyf.4veB3NY0hiKNQTxaSiZnPh9AybHplDpix34y_UOdwiKcL3e1_IquaUuO3A54A4thmSplNUQei9ARsNFV</accessToken>
       <apiUrl>https://ap2.salesforce.com</apiUrl>
       <refreshToken>5Aep861TSESvWeug_wHqvFVePrOMjj7CUFncs.cGdlPln68mKYpAbAJ9l7A5FTFsmqFY8Jl0m6fkIMWkIKc4WKL</refreshToken>
       <clientId>3MVG9ZL0ppGP5UrDGNWmP9oSpiNtudQv6b06Ru7K6UPW5xQhd6vakhfjA2HUGsLSpDOQmO8JGozttODpABcnY</clientId>
       <clientSecret>5437293348319318299</clientSecret>
       <intervalTime>1000000</intervalTime>
       <registryPath>connectors/SalesforceBulk</registryPath>
       <jobId>75028000000MCtIAAW</jobId>
       <state>Closed</state>
    </updateJob>
    ```    
    
??? note "getJob"
    The salesforcebulk.getJob method retrieves all details of an existing job based on the job ID that you specify. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_asynch.meta/api_asynch/asynch_api_jobs_get_details.htm) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>jobId</td>
            <td> The ID of the job that you either want to close or abort.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**
    
    Following is a sample request that can be handled by the getJob operation.

    ```xml
    <salesforcebulk.getJob>
        <jobId>{$ctx:jobId}</jobId>
    </salesforcebulk.getJob>
    ```

    **Sample request**
    
    ```xml
    <getJob>
       <apiVersion>34.0</apiVersion>
       <accessToken>00D280000011oQO!ARwAQFPbKzWInyf.4veB3NY0hiKNQTxaSiZnPh9AybHplDpix34y_UOdwiKcL3e1_IquaUuO3A54A4thmSplNUQei9ARsNFV</accessToken>
       <apiUrl>https://ap2.salesforce.com</apiUrl>
       <refreshToken>5Aep861TSESvWeug_wHqvFVePrOMjj7CUFncs.cGdlPln68mKYpAbAJ9l7A5FTFsmqFY8Jl0m6fkIMWkIKc4WKL</refreshToken>
       <clientId>3MVG9ZL0ppGP5UrDGNWmP9oSpiNtudQv6b06Ru7K6UPW5xQhd6vakhfjA2HUGsLSpDOQmO8JGozttODpABcnY</clientId>
       <clientSecret>5437293348319318299</clientSecret>
       <intervalTime>1000000</intervalTime>
       <registryPath>connectors/SalesforceBulk</registryPath>
       <jobId>75028000000MCqEAAW</jobId>
    </getJob>
    ```
    
## Working with Batches  
    
??? note "addBatch"
    The salesforcebulk.addBatch method adds a new batch to a job based on the properties that you specify. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_asynch.meta/api_asynch/asynch_api_batches_create.htm) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>jobId</td>
            <td>The ID of the job that you either want to close or abort.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>objects</td>
            <td>A list of records to process.</td>
            <td>Yes</td>
        </tr>
        <tr>
        <td>contentType</td>
            <td>The content type of the batch data. The content type you specify should be compatible with the content type of the associated job. Possible values are application/xml and text/csv.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>isQuery</td>
            <td>Set to true if the operation is query.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforcebulk.addBatch>
        <jobId>{$ctx:jobId}</jobId>
        <objects>{$ctx:objects}</objects>
        <contentType>{$ctx:contentType}</contentType>
        <isQuery>{$ctx:isQuery}</isQuery>
    </salesforcebulk.addBatch>
    ```

    **Sample request**
    
    Following is a sample request that can be handled by the addBatch operation, where the content type of the batch data is in application/xml format.
    
    ```xml
    <addBatch>
       <apiUrl>https://ap2.salesforce.com</apiUrl>
       <apiVersion>34.0</apiVersion>
       <accessToken>5Aep861TSESvWeug_xOdumSVTdDsD7OrADzhKVu9YrPFLB1zce_I21lnWIBR7uaGvedTTXJ4uPswE676H2pQpCZ</accessToken>
       <refreshToken>5Aep861TSESvWeug_wHqvFVePrOMjj7CUFncs.cGdlPln68mKYpAbAJ9l7A5FTFsmqFY8Jl0m6fkIMWkIKc4WKL</refreshToken>
       <clientId>3MVG9ZL0ppGP5UrDGNWmP9oSpiNtudQv6b06Ru7K6UPW5xQhd6vakhfjA2HUGsLSpDOQmO8JGozttODpABcnY</clientId>
       <clientSecret>5437293348319318299</clientSecret>
       <intervalTime>1000000</intervalTime>
       <registryPath>connectors/SalesforceBulk</registryPath>
       <contentType>application/xml</contentType>
       <isQuery>false</isQuery>
       <jobId>75028000000McSwAAK</jobId>
       <objects>
          <values>
             <sObject>
                <description>Created from Bulk API on Tue Apr 14 11:15:59 PDT 2009</description>
                <name>Account 711 (batch 0)</name>
             </sObject>
             <sObject>
                <description>Created from Bulk API on Tue Apr 14 11:15:59 PDT 2009</description>
                <name>Account 37811 (batch 5)</name>
             </sObject>
          </values>
       </objects>
    </addBatch>
    ```        
    Following is a sample request that can be handled by the addBatch operation, where the content type of the batch data is in text/csv format.
    
    ```xml
    <addBatch>
       <apiUrl>https://ap2.salesforce.com</apiUrl>
       <apiVersion>34.0</apiVersion>
       <accessToken>5Aep861TSESvWeug_xOdumSVTdDsD7OrADzhKVu9YrPFLB1zce_I21lnWIBR7uaGvedTTXJ4uPswE676H2pQpCZ</accessToken>
       <refreshToken>5Aep861TSESvWeug_wHqvFVePrOMjj7CUFncs.cGdlPln68mKYpAbAJ9l7A5FTFsmqFY8Jl0m6fkIMWkIKc4WKL</refreshToken>
       <clientId>3MVG9ZL0ppGP5UrDGNWmP9oSpiNtudQv6b06Ru7K6UPW5xQhd6vakhfjA2HUGsLSpDOQmO8JGozttODpABcnY</clientId>
       <clientSecret>5437293348319318299</clientSecret>
       <intervalTime>1000000</intervalTime>
       <registryPath>connectors/SalesforceBulk</registryPath>
       <contentType>text/csv</contentType>
       <isQuery>false</isQuery>
       <jobId>75028000000McSwAAK</jobId>
       <objects>
          <values>Name,description
            Tom Dameon,Created from Bulk API
          </values>
       </objects>
    </addBatch>
    ```
    Following is a sample request that can be handled by the addBatch operation, where the operation is query and the content type of the bulk query results is in application/xml format.
    
    ```xml
    <addBatch>
       <apiUrl>https://ap2.salesforce.com</apiUrl>
       <apiVersion>34.0</apiVersion>
       <accessToken>5Aep861TSESvWeug_xOdumSVTdDsD7OrADzhKVu9YrPFLB1zce_I21lnWIBR7uaGvedTTXJ4uPswE676H2pQpCZ</accessToken>
       <refreshToken>5Aep861TSESvWeug_wHqvFVePrOMjj7CUFncs.cGdlPln68mKYpAbAJ9l7A5FTFsmqFY8Jl0m6fkIMWkIKc4WKL</refreshToken>
       <clientId>3MVG9ZL0ppGP5UrDGNWmP9oSpiNtudQv6b06Ru7K6UPW5xQhd6vakhfjA2HUGsLSpDOQmO8JGozttODpABcnY</clientId>
       <clientSecret>5437293348319318299</clientSecret>
       <intervalTime>1000000</intervalTime>
       <registryPath>connectors/SalesforceBulk</registryPath>
       <contentType>application/xml</contentType>
       <isQuery>true</isQuery>
       <jobId>75028000000McSwAAK</jobId>
       <objects>
          <values>SELECT Id, Name FROM Account LIMIT 100</values>
       </objects>
    </addBatch>
    ```
    
??? note "getBatchStatus"
    The salesforcebulk.getBatchStatus method retrieves the status of a batch based on the properties that you specify. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_asynch.meta/api_asynch/asynch_api_quickstart_check_status.htm) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>jobId</td>
            <td>The unique identifier of the job to which the batch you specify belongs.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>batchId</td>
            <td>The unique identifier of the batch for which you want to retrieve the status.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**
    
    Following is a sample request that can be handled by the getBatchStatus operation.

    ```xml
    <salesforcebulk.getBatchStatus>
        <jobId>{$ctx:jobId}</jobId>
        <batchId>{$ctx:batchId}</batchId>   
    </salesforcebulk.getBatchStatus>
    ```

    **Sample request**
        
    ```xml
    <getBatchStatus>
        <apiUrl>https://ap2.salesforce.com</apiUrl>
        <accessToken>5Aep861TSESvWeug_xOdumSVTdDsD7OrADzhKVu9YrPFLB1zce_I21lnWIBR7uaGvedTTXJ4uPswE676H2pQpCZ</accessToken>
        <apiVersion>34.0</apiVersion>
        <refreshToken>5Aep861TSESvWeug_wHqvFVePrOMjj7CUFncs.cGdlPln68mKYpAbAJ9l7A5FTFsmqFY8Jl0m6fkIMWkIKc4WKL</refreshToken>
        <clientId>3MVG9ZL0ppGP5UrDGNWmP9oSpiNtudQv6b06Ru7K6UPW5xQhd6vakhfjA2HUGsLSpDOQmO8JGozttODpABcnY</clientId>
        <clientSecret>5437293348319318299</clientSecret>
        <intervalTime>1000000</intervalTime>
        <registryPath>connectors/SalesforceBulk</registryPath>
        <jobId>75028000000M5X0</jobId>
        <batchId>75128000000OZzq</batchId>
    </getBatchStatus>
    ```
    
??? note "getBatchResults"
    The salesforcebulk.getBatchResults method retrieves results of a batch that has completed processing. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_asynch.meta/api_asynch/asynch_api_batches_get_results.htm) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>jobId</td>
            <td>The unique identifier of the job to which the batch you specify belongs.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>batchId</td>
            <td>The unique identifier of the batch for which you want to retrieve results.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**
    
    Following is a sample request that can be handled by the getBatchResults operation.

    ```xml
    <salesforcebulk.getBatchRequest>
        <jobId>{$ctx:jobId}</jobId>
        <batchId>{$ctx:batchId}</batchId>
    </salesforcebulk.getBatchRequest>
    ```

    **Sample request**
        
    ```xml
    <getBatchResults>
       <apiUrl>https://ap2.salesforce.com</apiUrl>
       <apiVersion>34.0</apiVersion>
       <accessToken>5Aep861TSESvWeug_xOdumSVTdDsD7OrADzhKVu9YrPFLB1zce_I21lnWIBR7uaGvedTTXJ4uPswE676H2pQpCZ</accessToken>
       <refreshToken>5Aep861TSESvWeug_wHqvFVePrOMjj7CUFncs.cGdlPln68mKYpAbAJ9l7A5FTFsmqFY8Jl0m6fkIMWkIKc4WKL</refreshToken>
       <clientId>3MVG9ZL0ppGP5UrDGNWmP9oSpiNtudQv6b06Ru7K6UPW5xQhd6vakhfjA2HUGsLSpDOQmO8JGozttODpABcnY</clientId>
       <clientSecret>5437293348319318299</clientSecret>
       <intervalTime>1000000</intervalTime>
       <registryPath>connectors/SalesforceBulk</registryPath>
       <jobId>75028000000M5X0</jobId>
       <batchId>75128000000OZzq</batchId>
    </getBatchResults>
    ```         
    
??? note "getBatchRequest"
    The salesforcebulk.getBatchRequest method retrieves a batch request based on the properties that you specify. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_asynch.meta/api_asynch/asynch_api_batches_get_request.htm) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>jobId</td>
            <td>The unique identifier of the job to which the batch you specify belongs.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>batchId</td>
            <td>The unique identifier of the batch for which you want to retrieve the batch request.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**
    
    Following is a sample request that can be handled by the getBatchRequest operation.

    ```xml
    <salesforcebulk.getBatchRequest>
        <jobId>{$ctx:jobId}</jobId>
        <batchId>{$ctx:batchId}</batchId>
    </salesforcebulk.getBatchRequest>
    ```

    **Sample request**
        
    ```xml
    <getBatchRequest>
       <apiVersion>34.0</apiVersion>
       <accessToken>00D280000011oQO!ARwAQFPbKzWInyf.4veB3NY0hiKNQTxaSiZnPh9AybHplDpix34y_UOdwiKcL3e1_IquaUuO3A54A4thmSplNUQei9ARsNFV</accessToken>
       <apiUrl>https://ap2.salesforce.com</apiUrl>
       <refreshToken>5Aep861TSESvWeug_wHqvFVePrOMjj7CUFncs.cGdlPln68mKYpAbAJ9l7A5FTFsmqFY8Jl0m6fkIMWkIKc4WKL</refreshToken>
       <clientId>3MVG9ZL0ppGP5UrDGNWmP9oSpiNtudQv6b06Ru7K6UPW5xQhd6vakhfjA2HUGsLSpDOQmO8JGozttODpABcnY</clientId>
       <clientSecret>5437293348319318299</clientSecret>
       <intervalTime>1000000</intervalTime>
       <registryPath>connectors/SalesforceBulk</registryPath>
       <jobId>75028000000MCtIAAW</jobId>
       <batchId>75128000000OpZFAA0</batchId>
    </getBatchRequest>
    ```
    
??? note "listBatches"
    The salesforcebulk.listBatches method retrieves details of all batches in a job that you specify. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_asynch.meta/api_asynch/asynch_api_batches_get_info_all.htm) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>jobId</td>
            <td>The unique identifier of the job for which you want to retrieve batch details.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**
    
    Following is a sample request that can be handled by the listBatches operation.

    ```xml
    <salesforcebulk.listBatches>
        <jobId>{$ctx:jobId}</jobId>
    </salesforcebulk.listBatches>
    ```

    **Sample request**
        
    ```xml
    <listBatches>
       <apiVersion>34.0</apiVersion>
       <accessToken>00D280000011oQO!ARwAQFPbKzWInyf.4veB3NY0hiKNQTxaSiZnPh9AybHplDpix34y_UOdwiKcL3e1_IquaUuO3A54A4thmSplNUQei9ARsNFV</accessToken>
       <apiUrl>https://ap2.salesforce.com</apiUrl>
       <refreshToken>5Aep861TSESvWeug_wHqvFVePrOMjj7CUFncs.cGdlPln68mKYpAbAJ9l7A5FTFsmqFY8Jl0m6fkIMWkIKc4WKL</refreshToken>
       <clientId>3MVG9ZL0ppGP5UrDGNWmP9oSpiNtudQv6b06Ru7K6UPW5xQhd6vakhfjA2HUGsLSpDOQmO8JGozttODpABcnY</clientId>
       <clientSecret>5437293348319318299</clientSecret>
       <intervalTime>1000000</intervalTime>
       <registryPath>connectors/SalesforceBulk</registryPath>
       <jobId>75028000000MCqEAAW</jobId>
    </listBatches>
    ```
    
??? note "getBulkQueryResults"
    The salesforcebulk.getBulkQueryResults method retrieves the bulk query results that you specify. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_asynch.meta/api_asynch/asynch_api_code_curl_walkthrough.htm) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>jobId</td>
            <td>The unique identifier of the job for which you want to retrieve batch details.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>batchId</td>
            <td>The unique identifier of the batch for which you want to retrieve the batch request.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>resultsId</td>
            <td>The unique identifier of the results for which you want to retrieve.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**
    
    Following is a sample request that can be handled by the getBulkQueryResults operation.

    ```xml
    <salesforcebulk.getBulkQueryResults>
        <jobId>{$ctx:jobId}</jobId>
        <batchId>{$ctx:batchId}</batchId>
        <resultsId>{$ctx:resultsId}</resultsId>
    </salesforcebulk.getBulkQueryResults>
    ```

    **Sample request**
        
    ```xml
    <getBulkQueryResults>
       <apiVersion>34.0</apiVersion>
       <accessToken>00D280000011oQO!ARwAQFPbKzWInyf.4veB3NY0hiKNQTxaSiZnPh9AybHplDpix34y_UOdwiKcL3e1_IquaUuO3A54A4thmSplNUQei9ARsNFV</accessToken>
       <apiUrl>https://ap2.salesforce.com</apiUrl>
       <refreshToken>5Aep861TSESvWeug_wHqvFVePrOMjj7CUFncs.cGdlPln68mKYpAbAJ9l7A5FTFsmqFY8Jl0m6fkIMWkIKc4WKL</refreshToken>
       <clientId>3MVG9ZL0ppGP5UrDGNWmP9oSpiNtudQv6b06Ru7K6UPW5xQhd6vakhfjA2HUGsLSpDOQmO8JGozttODpABcnY</clientId>
       <clientSecret>5437293348319318299</clientSecret>
       <intervalTime>1000000</intervalTime>
       <registryPath>connectors/SalesforceBulk</registryPath>
       <jobId>75028000000MCqEAAW</jobId>
       <batchId>7510K00000Kzb6XQAR</batchId>
       <resultId>7520K000006xofz</resultId>
    </getBulkQueryResults>
    ```        
    
---

## Working with Binary Attachments


??? note "createJobToUploadBatchFile"
    The salesforcebulk.createJobToUploadBatchFile method creates a job for batches that contain attachment records. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_asynch.meta/api_asynch/binary_create_job.htm) for more information.
 
    **Sample configuration**
    
    Following is a sample request that can be handled by the createJobToUploadBatchFile operation. It creates a job for batches that contain attachment records..
    
    ```xml
    <salesforcebulk.createJobToUploadBatchFile>
    </salesforcebulk.createJobToUploadBatchFile>
    ```

    **Sample request**
        
    ```xml
    http://localhost:8280/services/salesforcebulk_uploadBatchFile?apiUrl=https://ap2.salesforce.com&accessToken=00D280000011oQO!ARwAQFPbKzWInyf.4veB3NY0hiKNQTxaSiZnPh9AybHplDpix34y_UOdwiKcL3e1_IquaUuO3A54A4thmSplNUQei9ARsNFV&apiVersion=34.0&refreshToken=5Aep861TSESvWeug_wHqvFVePrOMjj7CUFncs.cGdlPln68mKYpAbAJ9l7A5FTFsmqFY8Jl0m6fkIMWkIKc4WKL&clientId=3MVG9ZL0ppGP5UrDGNWmP9oSpiNtudQv6b06Ru7K6UPW5xQhd6vakhfjA2HUGsLSpDOQmO8JGozttODpABcnY&clientSecret=5437293348319318299&intervalTime=1000000&jobId=75028000000MCv9AAG
    ```
    
??? note "getBulkQueryResults"
    The salesforcebulk.getBulkQueryResults method creates a batch of attachment records. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_asynch.meta/api_asynch/binary_create_batch.htm) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>jobId</td>
            <td>The ID of the job for which you want to create a batch of attachment records.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**
    
    Following is a sample request that can be handled by the uploadBatchFile operation.It creates a job for batches that contain attachment records.
    
    ```xml
    <salesforcebulk.uploadBatchFile>
       <jobId>{$url:jobId}</jobId>
    </salesforcebulk.uploadBatchFile>
    ```

    **Sample request**
        
    ```xml
    http://localhost:8280/services/salesforcebulk_uploadBatchFile?apiUrl=https://ap2.salesforce.com&accessToken=00D280000011oQO!ARwAQFPbKzWInyf.4veB3NY0hiKNQTxaSiZnPh9AybHplDpix34y_UOdwiKcL3e1_IquaUuO3A54A4thmSplNUQei9ARsNFV&apiVersion=34.0&refreshToken=5Aep861TSESvWeug_wHqvFVePrOMjj7CUFncs.cGdlPln68mKYpAbAJ9l7A5FTFsmqFY8Jl0m6fkIMWkIKc4WKL&clientId=3MVG9ZL0ppGP5UrDGNWmP9oSpiNtudQv6b06Ru7K6UPW5xQhd6vakhfjA2HUGsLSpDOQmO8JGozttODpABcnY&clientSecret=5437293348319318299&intervalTime=1000000&jobId=75028000000MCv9AAG
    ```