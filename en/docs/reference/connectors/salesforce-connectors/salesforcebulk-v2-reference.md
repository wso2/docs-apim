# SalesforceBulkV2 Connector Reference

The following operations allow you to work with the Salesforce Bulk V2 Connector. Click an operation name to see parameter details and samples on how to use it.

Salesforce Bulk API uses the OAuth protocol to allow application users to securely access data without having to reveal their user credentials. For more information on how authentication is done in Salesforce, see [Understanding Authentication](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/intro_understanding_authentication.htm).


## Bulk API 2.0 Connector Connector Configuration

??? note "Connection configuration"
    In the 'Properties' section of each operation, users can configure connection-related information. Once the configuration is created, it can be reused in other operations.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>Salesforce Configuration Name</td>
            <td>Name of the configuration.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <th>Instance URL</th>
            <th>Salesforce instance url.</th>
            <th>Yes</th>
        </tr>
        <tr>
            <th>Client ID</th>
            <th>Salesforce connected app's client id.</th>
            <th>No. Connector will renew the access token if it gets 4xx response and clientId, clientSecret, refreshToken are configured.</th>
        </tr>
        <tr>
            <th>Client Secret</th>
            <th>Salesforce connected app's client secret.</th>
            <th>No. Connector will renew the access token if it gets 4xx response and clientId, clientSecret, refreshToken are configured.</th>
        </tr>
        <tr>
            <th>Refresh Token</th>
            <th>Salesforce connected app's refresh token.</th>
            <th>No. Connector will renew the access token if it gets 4xx response and clientId, clientSecret, refreshToken are configured.</th>
        </tr>
        <tr>
            <th>Access Token</th>
            <th>Salesforce connected app's access token.</th>
            <th>Optional if clientId, clientSecret, refreshToken are configured. Required otherwise.</th>
        </tr>
      </table>


## Bulk API 2.0 Ingest

??? note "salesforce_bulkapi_v2.abortJob"
    The `salesforce_bulkapi_v2.abortJob` operation aborts a bulk ingest job in Salesforce using Salesforce Bulk API v2. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_asynch.meta/api_asynch/close_job.htm) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>Salesforce configuration</td>
            <td>The Salesforce configuration to store OAuth related data.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <th>Job ID</th>
            <th>Bulk job ID</th>
            <th>Yes</th>
        </tr>
      </table>

??? note "salesforce_bulkapi_v2.createJob"
    The `salesforce_bulkapi_v2.createJob` operation creates a bulk ingest job in Salesforce using Salesforce Bulk API v2. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_asynch.meta/api_asynch/create_job.htm) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>Salesforce configuration</td>
            <td>The Salesforce configuration to store OAuth related data.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>Operation</td>
            <td>The ID of an assignment rule to run for a Case or a Lead. The assignment rule can be active or inactive. The ID can be retrieved by using the Lightning Platform SOAP API or the Lightning Platform REST API to query the AssignmentRule object.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <th>Object</th>
            <th>The object type for the data being processed. Use only a single object type per job.</th>
            <th>Yes</th>
        </tr>
        <tr>
            <th>Column Delimeter</th>
            <th>The column delimiter used for CSV job data. The default value is COMMA. Valid values are: BACKQUOTE—backquote character (``), CARET—caret character (^), COMMA—comma character (,) which is the default delimiter, PIPE—pipe character (|), SEMICOLON—semicolon character (;), TAB—tab character</th>
            <th>Yes</th>
        </tr>
        <tr>
            <th>Line Ending</th>
            <th>The line ending used for CSV job data, marking the end of a data row. The default is LF. Valid values are: LF—linefeed character,  CRLF—carriage return character followed by a linefeed character</th>
            <th>Yes</th>
        </tr>
        <tr>
            <th>Assignment Rule ID</th>
            <th>The ID of an assignment rule to run for a Case or a Lead. The assignment rule can be active or inactive. The ID can be retrieved by using the Lightning Platform SOAP API or the Lightning Platform REST API to query the AssignmentRule object.</th>
            <th>No</th>
        </tr>
        <tr>
            <th>External ID Field Name</th>
            <th>The external ID field in the object being updated. Only needed for upsert operations. Field values must also exist in CSV job data.</th>
            <th>No</th>
        </tr>
      </table>

??? note "salesforce_bulkapi_v2.closeJob"
    The `salesforce_bulkapi_v2.closeJob` operation closes a bulk ingest job in Salesforce using Salesforce Bulk API v2. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_asynch.meta/api_asynch/close_job.htm) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>Salesforce configuration</td>
            <td>The Salesforce configuration to store OAuth related data.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <th>Job ID</th>
            <th>Bulk job ID</th>
            <th>Yes</th>
        </tr>
      </table>

??? note "salesforce_bulkapi_v2.deleteJob"
    The `salesforce_bulkapi_v2.deleteJob` operation deletes a bulk ingest job in Salesforce using Salesforce Bulk API v2. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_asynch.meta/api_asynch/delete_job.htm) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>Salesforce configuration</td>
            <td>The Salesforce configuration to store OAuth related data.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <th>Job ID</th>
            <th>Bulk job ID</th>
            <th>Yes</th>
        </tr>
      </table>

??? note "salesforce_bulkapi_v2.getAllJobInfo"
    The `salesforce_bulkapi_v2.getJobInfo` operation retrieve all the bulk ingest job information from Salesforce using Salesforce Bulk API v2. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_asynch.meta/api_asynch/get_all_jobs.htm) for more information.
    <table>
      <tr>
          <th>Parameter Name</th>
          <th>Description</th>
          <th>Required</th>
      </tr>
      <tr>
          <td>Salesforce configuration</td>
          <td>The Salesforce configuration to store OAuth related data.</td>
          <td>Yes</td>
      </tr>
      <tr>
        <td>IsPKChunkingEnabled</td>
        <td>If set to true, the request only returns information about jobs where PK Chunking is enabled. This only applies to Bulk API (not Bulk API 2.0) jobs.</td>
        <td>No</td>
      </tr>
      <tr>
        <td>Job Type</td>
        <td>Gets information only about jobs matching the specified job type. Possible values are: 
        * Classic—Bulk API jobs. This includes both query jobs and ingest jobs.
        * V2Query—Bulk API 2.0 query jobs.
        * V2Ingest—Bulk API 2.0 ingest (upload and upsert) jobs.</td>
        <td>No</td>
      </tr>
      <tr>
        <td>Query Locator</td>
        <td>Gets information about jobs starting with that locator value.</td>
        <td>No</td>
      </tr>
    </table>

??? note "salesforce_bulkapi_v2.getFailedResults"
    The salesforce_bulkapi_v2.getFailedResults operation retrieves failed records of a specific bulk job from Salesforce using the Salesforce Bulk API v2. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_asynch.meta/api_asynch/get_job_failed_results.htm) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>Salesforce configuration</td>
            <td>The Salesforce configuration to store OAuth related data.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>Job ID</td>
            <td>Bulk job ID</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>Output Type</td>
            <td>Users can use this parameter to select whether the operation should send the response through the response body or store it in a file. The possible values are BODY and FILE. If BODY is selected, the Salesforce response will be returned to the user in the response body. If FILE is selected, the Salesforce response will be stored in the file specified in the 'File Path' parameter.</td>
            <td></td>
        </tr>
        <tr>
            <td>File Path</td>
            <td>This parameter specifies the path of the file where the Salesforce response should be stored.</td>
            <td>Required only when 'Output Type' == FILE</td>
        </tr>
      </table>

??? note "salesforce_bulkapi_v2.getJobInfo"
    The `salesforce_bulkapi_v2.getJobInfo` operation retrieve bulk ingest job information from Salesforce using Salesforce Bulk API v2. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_asynch.meta/api_asynch/get_job_info.htm) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>Salesforce configuration</td>
            <td>The Salesforce configuration to store OAuth related data.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <th>Job ID</th>
            <th>Bulk job ID</th>
            <th>Yes</th>
        </tr>
      </table>





??? note "salesforce_bulkapi_v2.getSuccessfulResults"
    The salesforce_bulkapi_v2.getSuccessfulResults operation retrieves successful records of a specific bulk job from Salesforce using the Salesforce Bulk API v2. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_asynch.meta/api_asynch/get_job_successful_results.htm) for more information.
    <table>
      <tr>
        <th>Parameter Name</th>
        <th>Description</th>
        <th>Required</th>
      </tr>
      <tr>
        <td>Salesforce configuration</td>
        <td>The Salesforce configuration to store OAuth related data.</td>
        <td>Yes</td>
      </tr>
      <tr>
        <td>Job ID</td>
        <td>Bulk job ID</td>
        <td>Yes</td>
      </tr>
      <tr>
        <td>Output Type</td>
        <td>Users can use this parameter to select whether the operation should send the response through the response body or store it in a file. The possible values are BODY and FILE. If BODY is selected, the Salesforce response will be returned to the user in the response body. If FILE is selected, the Salesforce response will be stored in the file specified in the 'File Path' parameter.</td>
        <td>Yes</td>
      </tr>
      <tr>
        <td>File Path</td>
        <td>This parameter specifies the path of the file where the Salesforce response should be stored.</td>
        <td>Required only when 'Output Type' == FILE</td>
      </tr>
    </table>


??? note "salesforce_bulkapi_v2.getUnprocessedResults"
  The salesforce_bulkapi_v2.getUnprocessedResults operation retrieves unprocessed records of a specific bulk job from Salesforce using the Salesforce Bulk API v2. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_asynch.meta/api_asynch/get_job_unprocessed_results.htm) for more information.
  <table>
    <tr>
      <th>Parameter Name</th>
      <th>Description</th>
      <th>Required</th>
    </tr>
    <tr>
      <td>Salesforce configuration</td>
      <td>The Salesforce configuration to store OAuth related data.</td>
      <td>Yes</td>
    </tr>
    <tr>
      <td>Job ID</td>
      <td>Bulk job ID</td>
      <td>Yes</td>
    </tr>
    <tr>
      <td>Output Type</td>
      <td>Users can use this parameter to select whether the operation should send the response through the response body or store it in a file. The possible values are BODY and FILE. If BODY is selected, the Salesforce response will be returned to the user in the response body. If FILE is selected, the Salesforce response will be stored in the file specified in the 'File Path' parameter.</td>
      <td>Yes</td>
    </tr>
    <tr>
      <td>File Path</td>
      <td>This parameter specifies the path of the file where the Salesforce response should be stored.</td>
      <td>Required only when 'Output Type' == FILE</td>
    </tr>
  </table>



??? note "salesforce_bulkapi_v2.uploadJobData"
  The salesforce_bulkapi_v2.uploadJobData operation upload the csv records to a bulk job in Salesforce using the Salesforce Bulk API v2. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_asynch.meta/api_asynch/upload_job_data.htm) for more information.
  <table>
    <tr>
      <th>Parameter Name</th>
      <th>Description</th>
      <th>Required</th>
    </tr>
    <tr>
      <td>Salesforce configuration</td>
      <td>The Salesforce configuration to store OAuth related data.</td>
      <td>Yes</td>
    </tr>
    <tr>
      <td>Job ID</td>
      <td>Bulk job ID</td>
      <td>Yes</td>
    </tr>
    <tr>
      <td>Input Type</td>
      <td>The users can use this parameter to select whether the operation should use CSV from the parameter or retrieve it from a file. The possible values are `INLINE` and `FILE`. If `INLINE` is selected, the operation will upload the value of the inputData. If `FILE` is selected, the operation will upload the content of the file specified in the 'File Path' parameter.</td>
      <td>Yes</td>
    </tr>
    <tr>
      <td>Input Data</td>
      <td>The CSV content that needs to be uploaded.</td>
      <td>Required only when 'Input Type' == FILE</td>
    </tr>
    <tr>
      <td>File Path</td>
      <td>This parameter specifies the path of the file from which the content is to be uploaded.</td>
      <td>Required only when 'Input Type' == FILE</td>
    </tr>
  </table>



## Bulk API 2.0 Query

??? note "salesforce_bulkapi_v2.abortQueryJob"
    The `salesforce_bulkapi_v2.abortQueryJob` operation aborts a bulk query job in Salesforce using Salesforce Bulk API v2. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_asynch.meta/api_asynch/query_abort_job.htm) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>Salesforce configuration</td>
            <td>The Salesforce configuration to store OAuth related data.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <th>Query Job ID</th>
            <th>Bulk Query job ID</th>
            <th>Yes</th>
        </tr>
      </table>

??? note "salesforce_bulkapi_v2.deleteQueryJob"
    The `salesforce_bulkapi_v2.deleteQueryJob` operation deletes a bulk query job in Salesforce using Salesforce Bulk API v2. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_asynch.meta/api_asynch/query_delete_job.htm) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>Salesforce configuration</td>
            <td>The Salesforce configuration to store OAuth related data.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <th>Query Job ID</th>
            <th>Bulk Query job ID</th>
            <th>Yes</th>
        </tr>
      </table>


??? note "salesforce_bulkapi_v2.getAllQueryJobInfo"
    The `salesforce_bulkapi_v2.getQueryJobInfo` operation retrieve all the bulk query job information from Salesforce using Salesforce Bulk API v2. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_asynch.meta/api_asynch/query_get_all_jobs.htm) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>Salesforce configuration</td>
            <td>The Salesforce configuration to store OAuth related data.</td>
            <td>Yes</td>
        </tr>
        <tr>
          <td>IsPKChunkingEnabled</td>
          <td>If set to true, the request only returns information about jobs where PK Chunking is enabled. This only applies to Bulk API (not Bulk API 2.0) jobs.</td>
          <td>No</td>
        </tr>
        <tr>
          <td>Job Type</td>
          <td>Gets information only about jobs matching the specified job type. Possible values are: 
          * Classic—Bulk API jobs. This includes both query jobs and ingest jobs.
          * V2Query—Bulk API 2.0 query jobs.
          * V2Ingest—Bulk API 2.0 ingest (upload and upsert) jobs.</td>
          <td>No</td>
        </tr>
        <tr>
          <td>Query Locator</td>
          <td>Gets information about jobs starting with that locator value.</td>
          <td>No</td>
        </tr>
      </table>

??? note "salesforce_bulkapi_v2.getQueryJobResults"
  The salesforce_bulkapi_v2.getQueryJobResults operation retrieves the results of a specified bulk query job from Salesforce using the Salesforce Bulk API v2. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_asynch.meta/api_asynch/query_get_job_results.htm) for more information.
  <table>
    <tr>
      <th>Parameter Name</th>
      <th>Description</th>
      <th>Required</th>
    </tr>
    <tr>
      <td>Salesforce configuration</td>
      <td>The Salesforce configuration to store OAuth related data.</td>
      <td>Yes</td>
    </tr>
    <tr>
      <td>Job ID</td>
      <td>The ID of the bulk query job.</td>
      <td>Yes</td>
    </tr>
    <tr>
      <td>Output Type</td>
      <td>Users can use this parameter to select whether the operation should send the response through the response body or store it in a file. The possible values are BODY and FILE. If BODY is selected, the Salesforce response will be returned to the user in the response body. If FILE is selected, the Salesforce response will be stored in the file specified in the 'File Path' parameter.</td>
      <td></td>
    </tr>
    <tr>
      <td>File Path</td>
      <td>This parameter specifies the path of the file where the Salesforce response should be stored.</td>
      <td>Required only when 'Output Type' == FILE</td>
    </tr>
  </table>
