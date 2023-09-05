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
            <td>Instance URL</td>
            <td>Salesforce instance url.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>Client ID</td>
            <td>Salesforce connected app's client id.</td>
            <td>No. Connector will renew the access token if it gets 4xx response and clientId, clientSecret, refreshToken are configured.</td>
        </tr>
        <tr>
            <td>Client Secret</td>
            <td>Salesforce connected app's client secret.</td>
            <td>No. Connector will renew the access token if it gets 4xx response and clientId, clientSecret, refreshToken are configured.</td>
        </tr>
        <tr>
            <td>Refresh Token</td>
            <td>Salesforce connected app's refresh token.</td>
            <td>No. Connector will renew the access token if it gets 4xx response and clientId, clientSecret, refreshToken are configured.</td>
        </tr>
        <tr>
            <td>Access Token</td>
            <td>Salesforce connected app's access token.</td>
            <td>Optional if clientId, clientSecret, refreshToken are configured. Required otherwise.</td>
        </tr>
      </table>

    > **Note:** It is recommended to use the OAuth client credentials (`Client ID` and `Client Secret`) along with the `Refresh Token` instead of `Access Token`. 


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
            <td>Job ID</td>
            <td>Bulk job ID</td>
            <td>Yes</td>
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
            <td>Object</td>
            <td>The object type for the data being processed. Use only a single object type per job.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>Column Delimeter</td>
            <td>The column delimiter used for CSV job data. The default value is COMMA. Valid values are: 
              <ul>
                <li>BACKQUOTE—backquote character (``)</li> 
                <li>CARET—caret character (^)</li>
                <li>COMMA—comma character (,) which is the default delimiter</li>
                <li>PIPE—pipe character (|)</li>
                <li>SEMICOLON—semicolon character (;)</li>
                <li>TAB—tab character</li>
              </ul>
            </td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>Line Ending</td>
            <td>The line ending used for CSV job data, marking the end of a data row. The default is LF. Valid values are: 
              <ul>
                <li>LF—linefeed character</li>
                <li>CRLF—carriage return character followed by a linefeed character</li>
              </ul>    
            </td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>Assignment Rule ID</td>
            <td>The ID of an assignment rule to run for a Case or a Lead. The assignment rule can be active or inactive. The ID can be retrieved by using the Lightning Platform SOAP API or the Lightning Platform REST API to query the AssignmentRule object.</td>
            <td>No</td>
        </tr>
        <tr>
            <td>External ID Field Name</td>
            <td>The external ID field in the object being updated. Only needed for upsert operations. Field values must also exist in CSV job data.</td>
            <td>No</td>
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
            <td>Job ID</td>
            <td>Bulk job ID</td>
            <td>Yes</td>
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
            <td>Job ID</td>
            <td>Bulk job ID</td>
            <td>Yes</td>
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
          <ul>
            <li>Classic—Bulk API jobs. This includes both query jobs and ingest jobs.</li>
            <li>BigObjectIngest.</li>
            <li>V2Ingest—Bulk API 2.0 ingest (upload and upsert) jobs.</li>
            <li>All-Gets information about all job types.</li>
          </ul>       
        </td>
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
            <td>The response content type</td>
            <td>Yes</td>
        </tr>
         <tr>
            <td>Add Results To</td>
            <td>Store the result in FILE or BODY</td>
            <td>Yes</td>
        </tr>
         <tr>
            <td>File Path</td>
            <td>The file path to store results</td>
            <td>If selected `FILE` in `Add Results To` </td>
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
            <td>Job ID</td>
            <td>Bulk job ID</td>
            <td>Yes</th>
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
          <td>The response content type</td>
          <td>Yes</td>
      </tr>
      <tr>
          <td>Add Results To</td>
          <td>Store the result in FILE or BODY</td>
          <td>Yes</td>
      </tr>
      <tr>
          <td>File Path</td>
          <td>The file path to store results</td>
          <td>If selected `FILE` in `Add Results To` </td>
      </tr>
      </table>
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
        <td>The response content type</td>
        <td>Yes</td>
      </tr>
      <tr>
        <td>Add Results To</td>
        <td>Store the result in FILE or BODY</td>
        <td>Yes</td>
      </tr>
      <tr>
        <td>File Path</td>
        <td>The file path to store results</td>
        <td>If selected `FILE` in `Add Results To` </td>
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
        <td>Input Data</td>
        <td>The CSV content that needs to be uploaded.</td>
        <td>Required</td>
      </tr>
    </table>



## Bulk API 2.0 Query

??? note "salesforce_bulkapi_v2.createQueryJob"
    The `salesforce_bulkapi_v2.createQueryJob` operation creates a bulk query job in Salesforce using Salesforce Bulk API v2. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_asynch.meta/api_asynch/query_create_job.htm) for more information.
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
            <td>The type of query. Possible values are: QUERY, QUERY_ALL</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>Column Delimiter</td>
            <td>The column delimiter used for CSV job data. The default value is COMMA. Valid values are: 
              <ul>
                <li>BACKQUOTE—backquote character (``)</li> 
                <li>CARET—caret character (^)</li>
                <li>COMMA—comma character (,) which is the default delimiter</li>
                <li>PIPE—pipe character (|)</li>
                <li>SEMICOLON—semicolon character (;)</li>
                <li>TAB—tab character</li>
              </ul>
            </td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>Line Ending</td>
            <td>The line ending used for CSV job data, marking the end of a data row. The default is LF. Valid values are: LF—linefeed character,  CRLF—carriage return character followed by a linefeed character</td>
            <td>Yes</td>
        </tr>
    </table>

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
            <td>Query Job ID</td>
            <td>Bulk Query job ID</td>
            <td>Yes</td>
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
            <td>Query Job ID</td>
            <td>Bulk Query job ID</td>
            <td>Yes</td>
        </tr>
    </table>

??? note "salesforce_bulkapi_v2.getQueryJobInfo"
    The `salesforce_bulkapi_v2.getQueryJobInfo` operation retrieve bulk query job information from Salesforce using Salesforce Bulk API v2. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_asynch.meta/api_asynch/query_get_one_job.htm) for more information.
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
            <td>Query job ID</td>
            <td>Yes</th>
        </tr>
    </table>

??? note "salesforce_bulkapi_v2.getAllQueryJobInfo"
    The `salesforce_bulkapi_v2.getAllQueryJobInfo` operation retrieve all the bulk query job information from Salesforce using Salesforce Bulk API v2. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api_asynch.meta/api_asynch/query_get_all_jobs.htm) for more information.
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
            <ul>
              <li>Classic—Bulk API jobs. This includes both query jobs and ingest jobs.</li>
              <li>V2Query—Bulk API 2.0 query jobs.</li>
              <li>V2Ingest—Bulk API 2.0 ingest (upload and upsert) jobs.</li>
              <li>All-Gets information about all job types.</li>
            </ul>
          </td>
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
        <td>Locator</td>
        <td>A string that identifies a specific set of query results. Providing a value for this parameter returns only that set of results.</td>
        <td>Optional</td>
      </tr>
      <tr>
        <td>Max Records</td>
        <td>The maximum number of records to retrieve per set of results for the query.</td>
        <td>Optional</td>
      </tr>
      <tr>
        <td>Output Type</td>
        <td>The response content type</td>
        <td>Yes</td>
      </tr>
      <tr>
        <td>Add Results To</td>
        <td>Store the result in FILE or BODY</td>
        <td>Yes</td>
      </tr>
      <tr>
        <td>File Path</td>
        <td>The file path to store results</td>
        <td>If selected `FILE` in `Add Results To` </td>
      </tr>
    </table>
