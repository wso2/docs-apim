# BigQuery Connector Reference

The following operations allow you to work with the BigQuery Connector. Click an operation name to see parameter details and samples on how to use it.

---

## Initialize the connector

To use the BigQuery connector, add the <bigquery.init> or <bigquery.getAccessTokenFromServiceAccount> element in your configuration before carrying out any other BigQuery operations.

The BigQuery API requires all requests to be authenticated as a user or a service account. For more information, see https://cloud.google.com/bigquery/authentication. See https://developers.google.com/identity/protocols/OAuth2ServiceAccount for information on service account authentication. For more information, see [related BigQuery documentation](https://developers.google.com/identity/protocols/OAuth2WebServer).

??? note "init"
    The init operation is used to initialize the connection to BigQuery.

    **Sample configuration**

    ```xml
    <bigquery.init>
        <apiUrl>{$ctx:apiUrl}</apiUrl>
        <accessToken>{$ctx:accessToken}</accessToken>
        <clientSecret>{$ctx:clientSecret}</clientSecret>
        <client>{$ctx:clientId}</clientId>
        <refreshToken>{$ctx:refreshToken}</refreshToken>
        <registryPath>{$ctx:registryPath}</registryPath>
        <fields>{$ctx:fields}</fields>
        <prettyPrint>{$ctx:prettyPrint}</prettyPrint>
        <quotaUser>{$ctx:quotaUser}</quotaUser>
        <userIp>{$ctx:userIp}</userIp>
    </bigquery.init>
    ```

    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>apiUrl</td>
            <td>The base endpoint URL of the BigQuery API.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>accessToken</td>
            <td>The OAuth token for the BigQuery API.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>clientId</td>
            <td>The client ID for the BigQuery API.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>clientSecret</td>
            <td>The client secret for the BigQuery API.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>refreshToken</td>
            <td>The refresh token for the BigQuery API.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>registryPath</td>
            <td>The registry path to save the access token.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>fields</td>
            <td>List of fields to be returned in the response.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>callback</td>
            <td>The name of the JavaScript callback function that handles the response. Used in JavaScript JSON-P requests.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>apiKey</td>
            <td>The API key. Required unless you provide an OAuth 2.0 token.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>prettyPrint</td>
            <td>Returns the response with indentations and line breaks. If the property is true, the response is returned in a human-readable format.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>quotaUser</td>
            <td>Alternative to userIp. Lets you enforce per-user quotas from a server-side application even in cases where the user's IP address is unknown.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>userIp</td>
            <td>IP address of the end user for whom the API call is being made. Lets you enforce per-user quotas when calling the API from a server-side application.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>ifMatch</td>
            <td>Etag value to use for returning a page of list values if the values have not changed.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>ifNoneMatch</td>
            <td>Etag value to use for returning a page of list values if the values have changed.</td>
            <td>Yes</td>
        </tr>
    </table>
    
    Alternatively, you can use the following operation (getAccessTokenFromServiceAccount) to get the access token and to do all the other operations.

    ```xml
    <bigquery.getAccessTokenFromServiceAccount>
        <apiUrl>{$ctx:apiUrl}</apiUrl>
        <keyStoreLocation>{$ctx:keyStoreLocation}</keyStoreLocation>
        <serviceAccount>{$ctx:serviceAccount}</serviceAccount>
        <scope>{$ctx:scope}</scope>
        <accessTokenRegistryPath>{$ctx:accessTokenRegistryPath}</accessTokenRegistryPath>
    </bigquery.getAccessTokenFromServiceAccount>
    ```

    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>apiUrl</td>
            <td>The base endpoint URL of the BigQuery API.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>keyStoreLocation</td>
            <td>The location where the p12 key file is located.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>serviceAccount</td>
            <td>The value of the service account.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>scope</td>
            <td>The space delimited scope to access the API.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>accessTokenRegistryPath</td>
            <td>The registry path to store the access token (this is an optional parameter).</td>
            <td>Yes</td>
        </tr>
    </table>

    You can also use the below operation (getAccessTokenFromAuthorizationCode) to get the access token and to do all the other operations.

    ```xml
    <bigquery.getAccessTokenFromAuthorizationCode>
        <apiUrl>{$ctx:apiUrl}</apiUrl>
        <authorizationCode>{$ctx:authorizationCode}</authorizationCode>           
        <redirectUrl>{$ctx:redirectUrl}</redirectUrl>
        <clientSecret>{$ctx:clientSecret}</clientSecret>
        <clientId>{$ctx:clientId}</clientId>
        <registryPath>{$ctx:registryPath}</registryPath>
    </bigquery.getAccessTokenFromAuthorizationCode>
    ```

    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>apiUrl</td>
            <td>The base endpoint URL of the BigQuery API.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>authorizationCode</td>
            <td>The authorization code to be used for obtaining the access token.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>redirectUrl</td>
            <td>The redirect URL to be used in the OAuth 2.0 authorization flow.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>clientSecret</td>
            <td>The space delimited scope to access the API.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>clientId</td>
            <td>The registry path to store the access token (this is an optional parameter).</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>registryPath</td>
            <td>The registry path to store the access token (this is an optional parameter).</td>
            <td>Yes</td>
        </tr>
    </table>

    You can also use the below operation (getAccessTokenFromRefreshToken) to get the access token and to do all the other operations.

    ```xml
    <bigquery.getAccessTokenFromRefreshToken>
        <apiUrl>{$ctx:apiUrl}</apiUrl>
        <clientSecret>{$ctx:clientSecret}</clientSecret>
        <clientId>{$ctx:clientId}</clientId>
        <refreshToken>{$ctx:refreshToken}</refreshToken>
    </bigquery.getAccessTokenFromRefreshToken>
    ```

    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>apiUrl</td>
            <td>The base endpoint URL of the BigQuery API.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>clientSecret</td>
            <td>The space delimited scope to access the API.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>clientId</td>
            <td>The registry path to store the access token (this is an optional parameter).</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>refreshToken</td>
            <td>The refresh token for the BigQuery API.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample request**

    ```json
    {
        "apiUrl": "https://www.googleapis.com",
        "clientId": "504627865627-kdni8r2s10sjcgd4v6stthdaqb4bvnba.apps.googleusercontent.com",
        "refreshToken": "1/uWful-diQNAdk-alDUa6ixxxxxxxx-LpJIikEQ2sqA",
        "clientSecret": "ChlbHI_T7zssXXTRYuqj_-TM"
    }
    ```

    
---

### Datasets

??? note "getDataset"
    The getDataset operation retrieves a dataset. For more information, see related [BigQuery documentation](https://cloud.google.com/bigquery/docs/reference/v2/datasets/get).
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>projectId</td>
            <td>The ID of the project to which the dataset belongs.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>datasetId</td>
            <td>The ID of the dataset.</td>
            <td>Yes.</td>
        </tr>
    </table>

    **Sample configurations**

    ```xml
    <bigquery.getDataset>
        <projectId>{$ctx:projectId}</projectId>
        <datasetId>{$ctx:datasetId}</datasetId>
    </bigquery.getDataset>
    ```

    **Sample request**

    ```json
    {
        "accessToken": "ya29.BwKYx40Dith1DFQBDjZOHNqhcxmKs9zbkjAWQa1q8mdMFndp2-q8ifG66fwprOigRwKSNw",
        "apiUrl": "https://www.googleapis.com",
        "clientId": "504627865627-kdni8r2s10sjddfgXzqb4bvnba.apps.googleusercontent.com",
        "clientSecret": "ChlbHI_T7zssXXTRYuqj_-TM",
        "refreshToken": "1/uWful-diQNAdk-alDUa6ixxxxxxxx-LpJIikEQ2sqA",
        "registryPath": "connectors/bq",
        "projectId": "publicdata",
        "datasetId": "samples",
        "fields": "id",
        "callback": "callBackFunction",
        "apiKey": "154987fd5h4x6gh4",
        "prettyPrint": "true",
        "quotaUser": "1hx46f5g4h5ghx6h41x54gh6f4hx",
        "userIp": "192.77.88.12",
        "ifNoneMatch":"hnk59tKBkX8cdlePZ8VtzgVzuO4/tS1oqpXxnkU21hZeK5k4lqRrRr8",
        "ifMatch":"hnk59tKBkX8cdlePZ8VtzgVzuO4/tS1oqpXxnkU21hZeK5k4lqRrRr8"
    }
    ```

    **Sample response**

    ```json
    {
        "kind": "bigquery#dataset",
        "etag": "1xuEK5ngZZ+fj0iioOa6Og==",
        "id": "testbig-235116:testData",
        "selfLink": "https://content.googleapis.com/bigquery/v2/projects/testbig-235116/datasets/testData",
        "datasetReference": {
            "datasetId": "testData",
            "projectId": "testbig-235116"
        },
        "defaultTableExpirationMs": "5184000000",
        "access": [
            {
                "role": "WRITER",
                "specialGroup": "projectWriters"
            },
            {
                "role": "OWNER",
                "specialGroup": "projectOwners"
            },
            {
                "role": "OWNER",
                "userByEmail": "iamkesan@gmail.com"
            },
            {
                "role": "READER",
                "specialGroup": "projectReaders"
            }
        ],
        "creationTime": "1553104741840",
        "lastModifiedTime": "1553104741840",
        "location": "US",
        "defaultPartitionExpirationMs": "5184000000"
    }
    ```

??? note "listDatasets"
    The listDatasets operation lists a set of data. For more information, see related [BigQuery documentation](https://cloud.google.com/bigquery/docs/reference/v2/datasets/list).
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>projectId</td>
            <td>The ID of the project to which the dataset belongs.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>maxResults</td>
            <td>The maximum number of results per page.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>pageToken</td>
            <td>The page token value.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>isAll</td>
            <td>A boolean value that determines whether to list all datasets, including hidden ones.</td>
            <td>Yes.</td>
        </tr>
    </table>

    **Sample configurations**

    ```xml
    <bigquery.listDatasets>
        <projectId>{$ctx:projectId}</projectId>
        <maxResults>{$ctx:maxResults}</maxResults>
        <pageToken>{$ctx:pageToken}</pageToken>
        <isAll>{$ctx:isAll}</isAll>
    </bigquery.listDatasets>
    ```

    **Sample request**

    ```json
    {
        "accessToken": "ya29.BwKYx40Dith1DFQBDjZOHNqhcxmKs9zbkjAWQa1q8mdMFndp2-q8ifG66fwprOigRwKSNw",
        "apiUrl": "https://www.googleapis.com",
        "clientId": "504627865627-kdni8r2s10sjddfgXzqb4bvnba.apps.googleusercontent.com",
        "clientSecret": "ChlbHI_T7zssXXTRYuqj_-TM",
        "refreshToken": "1/uWful-diQNAdk-alDUa6ixxxxxxxx-LpJIikEQ2sqA",
        "registryPath": "connectors/bq",
        "projectId": "publicdata",
        "maxResults": "1",
        "pageToken": "1",
        "isAll": "true",
        "fields": "datasets/datasetReference",
        "callback": "callBackFunction",
        "apiKey": "154987fd5h4x6gh4",
        "prettyPrint": "true",
        "quotaUser": "1hx46f5g4h5ghx6h41x54gh6f4hx",
        "userIp": "192.77.88.12",
        "ifNoneMatch":"hnk59tKBkX8cdlePZ8VtzgVzuO4/tS1oqpXxnkU21hZeK5k4lqRrRr8",
        "ifMatch":"hnk59tKBkX8cdlePZ8VtzgVzuO4/tS1oqpXxnkU21hZeK5k4lqRrRr8"
    }
    ```

    **Sample response**

    ```json
    {
        "kind": "bigquery#datasetList",
        "etag": "5xsXo/uZ5RUfG49EzOV9Gg==",
        "datasets": [
            {
                "kind": "bigquery#dataset",
                "id": "testbig-235116:testData",
                "datasetReference": {
                    "datasetId": "testData",
                    "projectId": "testbig-235116"
                },
                "location": "US"
            }
        ]
    }
    ```

### Jobs

??? note "runQuery"
    The runQuery operation runs an SQL query (BigQuery) and returns results if the query completes within a specified timeout. For more information, see related [BigQuery documentation](https://cloud.google.com/bigquery/docs/reference/v2/jobs/query).
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>useQueryCache</td>
            <td>Specifies whether to look for the result in the query cache. The default value is true.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>timeoutMs</td>
            <td>Specifies how long (in milliseconds) the system should wait for the query to complete before expiring and returning the request.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>query</td>
            <td>A query string (required) that complies with the BigQuery query syntax.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>dryRun</td>
            <td>If set to true, BigQuery does not run the job. Instead, if the query is valid, BigQuery returns statistics about the job. If the query is invalid, an error returns. The default value is false.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>defaultProjectId</td>
            <td>The ID of the project that contains this dataset.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>defaultDatasetId</td>
            <td>A unique ID (required) for this dataset without the project name. The ID must contain only letters (a-z, A-Z), numbers (0-9), or underscores (_). The maximum length is 1,024 characters.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>projectId</td>
            <td>The ID of the project that is billed for the query.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>maxResults</td>
            <td>The maximum number of rows of data (results) to return per page. Responses are also limited to 10 MB. By default, there is no maximum row count and only the byte limit applies.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>kind</td>
            <td>The resource type of the request.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>useLegacySql</td>
            <td>Specifies whether to use BigQuery's legacy SQL dialect for this query. The default value is true. If set to false, the query will use BigQuery's standard SQL. For information on BigQuery's standard SQL, see https://cloud.google.com/bigquery/docs/reference/standard-sql/migrating-from-legacy-sql.</td>
            <td>Yes.</td>
        </tr>
    </table>

    **Sample configurations**

    ```xml
    <bigquery.runQuery>
        <useQueryCache>{$ctx:useQueryCache}</useQueryCache>
        <timeoutMs>{$ctx:timeoutMs}</timeoutMs>
        <query>{$ctx:query}</query>
        <dryRun>{$ctx:dryRun}</dryRun>
        <defaultProjectId>{$ctx:defaultProjectId}</defaultProjectId>
        <defaultDatasetId>{$ctx:defaultDatasetId}</defaultDatasetId>
        <projectId>{$ctx:projectId}</projectId>
        <maxResults>{$ctx:maxResults}</maxResults>
        <kind>{$ctx:kind}</kind>
        <useLegacySql>{$ctx:useLegacySql}</useLegacySql>
    </bigquery.runQuery>
    ```

    **Sample request**

    ```json
    {
        "quotaUser":"1hx46f5g4h5ghx6h41x54gh6f4hx",
        "userIp":"192.77.88.12",
        "accessToken":"ya29.6QFjdRjTZyXmIjxkO6G6dJoLrch1Ktt1IzFm",
        "clientId": "504627865627-kdni8r2s10sjddfgXzqb4bvnba.apps.googleusercontent.com",
        "clientSecret": "ChlbHI_T7zssXXTRYuqj_-TM",
        "refreshToken": "1/uWful-diQNAdk-alDUa6ixxxxxxxx-LpJIikEQ2sqA",
        "registryPath": "connectors/bq",
        "prettyPrint":"true",
        "callback":"callBackFunction",
        "apiUrl":"https://www.googleapis.com",
        "fields":"id,etag",
        "useQueryCache":"true",
        "timeoutMs":"10000",
        "query":"SELECT count(*) FROM [publicdata:samples.github_nested]",
        "dryRun":"false",
        "defaultProjectId":"bigqueryproject-1092",
        "defaultDatasetId":"test_100",
        "projectId":"bigqueryproject-1092",
        "maxResults":"10000",
        "kind":"bigquery#queryRequest",
        "ifNoneMatch":"hnk59tKBkX8cdlePZ8VtzgVzuO4/tS1oqpXxnkU21hZeK5k4lqRrRr8",
        "ifMatch":"hnk59tKBkX8cdlePZ8VtzgVzuO4/tS1oqpXxnkU21hZeK5k4lqRrRr8"
    }
    ```

    **Sample response**

    ```json
    {
        "kind": "bigquery#queryResponse",
        "schema": {
            "fields": [
                {
                    "name": "Name",
                    "type": "STRING",
                    "mode": "NULLABLE"
                },
                {
                    "name": "Age",
                    "type": "INTEGER",
                    "mode": "NULLABLE"
                }
            ]
        },
        "jobReference": {
            "projectId": "testbig-235116",
            "jobId": "job_GECobzPaLdbBW-SqIG-WrfOzaqtQ",
            "location": "US"
        },
        "totalRows": "2",
        "rows": [
            {
                "f": [
                    {
                        "v": "John"
                    },
                    {
                        "v": "45"
                    }
                ]
            },
            {
                "f": [
                    {
                        "v": "Harry"
                    },
                    {
                        "v": "25"
                    }
                ]
            }
        ],
        "totalBytesProcessed": "670",
        "jobComplete": true,
        "cacheHit": false
    }
    ```

### Projects

??? note "listProjects"
    The listProjects operation retrieves all projects. For more information, see related [BigQuery documentation](https://cloud.google.com/bigquery/docs/reference/v2/projects/list).
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>maxResults</td>
            <td>The maximum number of results per page.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>pageToken</td>
            <td>The page token value.</td>
            <td>Yes.</td>
        </tr>
    </table>

    **Sample configurations**

    ```xml
    <bigquery.listProjects>
        <maxResults>{$ctx:maxResults}</maxResults>
        <pageToken>{$ctx:pageToken}</pageToken>
    </bigquery.listProjects>
    ```

    **Sample request**

    ```json
    {
        "accessToken" : "ya29.BwKYx40Dith1DFQBDjZOHNqhcxmKs9zbkjAWQa1q8mdMFndp2-q8ifG66fwprOigRwKSNw",
        "apiUrl" : "https://www.googleapis.com",
        "clientId": "504627865627-kdni8r2s10sjddfgXzqb4bvnba.apps.googleusercontent.com",
        "clientSecret": "ChlbHI_T7zssXXTRYuqj_-TM",
        "refreshToken": "1/uWful-diQNAdk-alDUa6ixxxxxxxx-LpJIikEQ2sqA",
        "registryPath": "connectors/bq",
        "maxResults" : "1",
        "pageToken" : "1",
        "fields": "id",
        "callback": "callBackFunction",
        "apiKey": "154987fd5h4x6gh4",
        "prettyPrint": "true",
        "quotaUser": "1hx46f5g4h5ghx6h41x54gh6f4hx",
        "userIp": "192.77.88.12",
        "ifNoneMatch":"hnk59tKBkX8cdlePZ8VtzgVzuO4/tS1oqpXxnkU21hZeK5k4lqRrRr8",
        "ifMatch":"hnk59tKBkX8cdlePZ8VtzgVzuO4/tS1oqpXxnkU21hZeK5k4lqRrRr8"
    }
    ```

    **Sample response**

    ```json
    {
        "kind": "bigquery#projectList",
        "etag": "jdhx8JpxmSC6iJhWFNchpw==",
        "projects": [
            {
                "kind": "bigquery#project",
                "id": "ascendant-lore-235117",
                "numericId": "719690246975",
                "projectReference": {
                    "projectId": "ascendant-lore-235117"
                },
                "friendlyName": "My First Project"
            },
            {
                "kind": "bigquery#project",
                "id": "true-kite-235118",
                "numericId": "911077124704",
                "projectReference": {
                    "projectId": "true-kite-235118"
                },
                "friendlyName": "My First Project"
            }
        ],
        "totalItems": 2
    }
    ```

### Table Data

??? note "listTabledata"
    The listTabledata operation retrieves table data from a specified set of rows. For more information, see related [BigQuery documentation](https://cloud.google.com/bigquery/docs/reference/v2/tabledata/list).
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>datasetId</td>
            <td>The maximum number of results per page.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>projectId</td>
            <td>The ID of the project to which the dataset belongs.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>tableId</td>
            <td>The ID of the table.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>maxResults</td>
            <td>The maximum results per page.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>pageToken</td>
            <td>The page token value.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>startIndex</td>
            <td>Zero-based index of the starting row.</td>
            <td>Yes.</td>
        </tr>
    </table>

    **Sample configurations**

    ```xml
    <bigquery.listTabledata>
        <datasetId>{$ctx:datasetId}</datasetId>
        <projectId>{$ctx:projectId}</projectId>
        <tableId>{$ctx:tableId}</tableId>
        <maxResults>{$ctx:maxResults}</maxResults>
        <pageToken>{$ctx:pageToken}</pageToken>
        <startIndex>{$ctx:startIndex}</startIndex>
    </bigquery.listTabledata>
    ```

    **Sample request**

    ```json
    {
        "accessToken": "ya29.BwKYx40Dith1DFQBDjZOHNqhcxmKs9zbkjAWQa1q8mdMFndp2-q8ifG66fwprOigRwKSNw",
        "apiUrl": "https://www.googleapis.com",
        "clientId": "504627865627-kdni8r2s10sjddfgXzqb4bvnba.apps.googleusercontent.com",
        "clientSecret": "ChlbHI_T7zssXXTRYuqj_-TM",
        "refreshToken": "1/uWful-diQNAdk-alDUa6ixxxxxxxx-LpJIikEQ2sqA",
        "registryPath": "connectors/bq",
        "projectId": "publicdata",
        "datasetId": "samples",
        "tableId": "github_nested",
        "maxResults": "1",
        "pageToken": "1",
        "startIndex": "1",
        "fields": "id",
        "callback": "callBackFunction",
        "apiKey": "154987fd5h4x6gh4",
        "prettyPrint": "true",
        "quotaUser": "1hx46f5g4h5ghx6h41x54gh6f4hx",
        "userIp": "192.77.88.12",
        "ifNoneMatch":"hnk59tKBkX8cdlePZ8VtzgVzuO4/tS1oqpXxnkU21hZeK5k4lqRrRr8",
        "ifMatch":"hnk59tKBkX8cdlePZ8VtzgVzuO4/tS1oqpXxnkU21hZeK5k4lqRrRr8"
    }
    ```

    **Sample response**

    ```json
    {
        "kind": "bigquery#tableDataList",
        "etag": "RRRjVfSIc2CcCrEaLPH6Dg==",
        "totalRows": "2",
        "rows": [
            {
                "f": [
                    {
                        "v": "John"
                    },
                    {
                        "v": null
                    }
                ]
            },
            {
                "f": [
                    {
                        "v": "Harry"
                    },
                    {
                        "v": "90"
                    }
                ]
            }
        ]
    }
    ```

??? note "insertAllTableData"
    The insertAllTableData operation retrieves table data from a specified set of rows. For more information, see related [BigQuery documentation](https://cloud.google.com/bigquery/docs/reference/v2/tabledata/insertAll).
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>datasetId</td>
            <td>The maximum number of results per page.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>projectId</td>
            <td>The ID of the project to which the dataset belongs.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>tableId</td>
            <td>The ID of the table.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>skipInvalidRows</td>
            <td>A boolean value to check whether the row should be validated.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>ignoreUnknownValues</td>
            <td>A boolean value to validate whether the values match the table schema.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>templateSuffix</td>
            <td>Instance table.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>jsonPay</td>
            <td>A JSON object that contains a row of data.</td>
            <td>Yes.</td>
        </tr>
    </table>

    **Sample configurations**

    ```xml
    <bigquery.insertAllTableData>
        <datasetId>{$ctx:datasetId}</datasetId>
        <projectId>{$ctx:projectId}</projectId>
        <tableId>{$ctx:tableId}</tableId>
        <skipInvalidRows>{$ctx:skipInvalidRows}</skipInvalidRows>
        <ignoreUnknownValues>{$ctx:ignoreUnknownValues}</ignoreUnknownValues>
        <templateSuffix>{$ctx:templateSuffix}</templateSuffix>
        <jsonPay>{$ctx:jsonPay}</jsonPay>
    </bigquery.insertAllTableData>
    ```

    **Sample request**

    ```json
    {
        "apiUrl":"https://www.googleapis.com",
        "keyStoreLocation":"/home/hariprasath/Desktop/bigQuery/p12/Non Production-232c0d8ac8f2.p12",
        "serviceAccount":"service-account.gserviceaccount.com",
        "scope":"https://www.googleapis.com/auth/bigquery",
        "datasetId": "zSta",
        "tableId": "ECOMM",
        "projectId": "dataservices",
        "kind": "bigquery#tableDataInsertAllRequest",
        "skipInvalidRows": true,
        "ignoreUnknownValues": true,
        "templateSuffix":"_20160315",
        "jsonPay":
            {
                "insertId": "xxxxx",
                "json":
                    {
                        "SOURCE_ID":"2",
                        "DESTINATION_ID":"13",
                        "SIGNAL_TYPE_ID":"13",
                        "DATA":"hariprasath",
                        "TRANSACTION_TIMESTAMP":"2014-03-01T22:12:22.000Z",
                        "BQ_INSERT_TIMESTAMP":"2016-02-26 20:12:01"      
                    }
            }
    }
    ```

    Following is a sample request that inserts multiple records.

    ```json
    {
        "apiUrl":"https://www.googleapis.com",
        "keyStoreLocation":"/home/hariprasath/Desktop/bigQuery/p12/Non Production-232c0d8ac8f2.p12",
        "serviceAccount":"service-account.gserviceaccount.com",
        "scope":"https://www.googleapis.com/auth/bigquery",
        "datasetId": "zSta",
        "tableId": "Sample",
        "projectId": "dataservices",
        "kind": "bigquery#tableDataInsertAllRequest",
        "skipInvalidRows": true,
        "ignoreUnknownValues": true,
        "templateSuffix":"_20160315",
        "jsonPay":[
            {
                "insertId":"1014",
                "json":{
                    "Name":"John",
                    "Age":25
                }
            },
            {
                "insertId":"1015",
                "json":{
                    "Name":"Vasan",
                    "Age":45
                }
            }
        ]
    }
    ```

    **Sample response**

    ```json
    {
        "kind": "bigquery#tableDataInsertAllResponse"
    }
    ```

### Tables

??? note "getTable"
    The getTable operation retrieves a table by ID. For more information, see related [BigQuery documentation](https://cloud.google.com/bigquery/docs/reference/v2/tables/get).
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>tableId</td>
            <td>The ID of the table.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>datasetId</td>
            <td>The dataset ID of the requested table.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>projectId</td>
            <td>The project ID of the requested table.</td>
            <td>Yes.</td>
        </tr>
    </table>

    **Sample configurations**

    ```xml
    <bigquery.getTable>
        <tableId>{$ctx:tableId}</tableId>
        <datasetId>{$ctx:datasetId}</datasetId>
        <projectId>{$ctx:projectId}</projectId>
    </bigquery.getTable>
    ```

    **Sample request**

    ```json
    {
        "accessToken": "ya29.BwKYx40Dith1DFQBDjZOHNqhcxmKs9zbkjAWQa1q8mdMFndp2-q8ifG66fwprOigRwKSNw",
        "apiUrl": "https://www.googleapis.com",
        "clientId": "504627865627-kdni8r2s10sjddfgXzqb4bvnba.apps.googleusercontent.com",
        "clientSecret": "ChlbHI_T7zssXXTRYuqj_-TM",
        "refreshToken": "1/uWful-diQNAdk-alDUa6ixxxxxxxx-LpJIikEQ2sqA",
        "registryPath": "connectors/bq",
        "projectId": "publicdata",
        "datasetId": "samples",
        "tableId": "github_nested",
        "maxResults": "1",
        "pageToken": "1",
        "startIndex": "1",
        "fields": "id",
        "callback": "callBackFunction",
        "apiKey": "154987fd5h4x6gh4",
        "prettyPrint": "true",
        "quotaUser": "1hx46f5g4h5ghx6h41x54gh6f4hx",
        "userIp": "192.77.88.12",
        "ifNoneMatch":"hnk59tKBkX8cdlePZ8VtzgVzuO4/tS1oqpXxnkU21hZeK5k4lqRrRr8",
        "ifMatch":"hnk59tKBkX8cdlePZ8VtzgVzuO4/tS1oqpXxnkU21hZeK5k4lqRrRr8"
    }
    ```

    **Sample response**

    ```json
    {
        "kind": "bigquery#tableList",
        "etag": "ASMRI9cY0t0ilhpaFI4OMA==",
        "tables": [
            {
                "kind": "bigquery#table",
                "id": "testbig-235116:testData.github_nested_copy",
                "tableReference": {
                    "projectId": "testbig-235116",
                    "datasetId": "testData",
                    "tableId": "github_nested_copy"
                },
                "type": "TABLE",
                "creationTime": "1553104818977",
                "expirationTime": "1558288818977"
            },
            {
                "kind": "bigquery#table",
                "id": "testbig-235116:testData.sample_20190322",
                "tableReference": {
                    "projectId": "testbig-235116",
                    "datasetId": "testData",
                    "tableId": "sample_20190322"
                },
                "type": "TABLE",
                "creationTime": "1553239767833",
                "expirationTime": "1558423767833"
            }
        ],
        "totalItems": 2
    }
    ```

??? note "listTables"
    The listTables operation retrieves all available tables in the specified dataset. For more information, see related [BigQuery documentation](https://cloud.google.com/bigquery/docs/reference/v2/tables/list).
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>datasetId</td>
            <td>The dataset ID of the tables that should be listed.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>pageToken</td>
            <td>The page token (which is returned by a previous call) for requesting the next page of results.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>projectId</td>
            <td>The project ID of the tables that should be listed.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>maxResults</td>
            <td>The maximum number of results to return.</td>
            <td>Yes.</td>
        </tr>
    </table>

    **Sample configurations**

    ```xml
    <bigquery.listTables>
        <datasetId>{$ctx:datasetId}</datasetId>
        <pageToken>{$ctx:pageToken}</pageToken>
        <projectId>{$ctx:projectId}</projectId>
        <maxResults>{$ctx:maxResults}</maxResults>
    </bigquery.listTables>
    ```

    **Sample request**

    ```json
    {
        "accessToken": "ya29.BwKYx40Dith1DFQBDjZOHNqhcxmKs9zbkjAWQa1q8mdMFndp2-q8ifG66fwprOigRwKSNw",
        "apiUrl": "https://www.googleapis.com",
        "clientId": "504627865627-kdni8r2s10sjddfgXzqb4bvnba.apps.googleusercontent.com",
        "clientSecret": "ChlbHI_T7zssXXTRYuqj_-TM",
        "refreshToken": "1/uWful-diQNAdk-alDUa6ixxxxxxxx-LpJIikEQ2sqA",
        "registryPath": "connectors/bq",
        "projectId": "publicdata",
        "datasetId": "samples",
        "tableId": "github_nested",
        "maxResults": "1",
        "pageToken": "1",
        "startIndex": "1",
        "fields": "id",
        "callback": "callBackFunction",
        "apiKey": "154987fd5h4x6gh4",
        "prettyPrint": "true",
        "quotaUser": "1hx46f5g4h5ghx6h41x54gh6f4hx",
        "userIp": "192.77.88.12",
        "ifNoneMatch":"hnk59tKBkX8cdlePZ8VtzgVzuO4/tS1oqpXxnkU21hZeK5k4lqRrRr8",
        "ifMatch":"hnk59tKBkX8cdlePZ8VtzgVzuO4/tS1oqpXxnkU21hZeK5k4lqRrRr8"
    }
    ```

    **Sample response**

    ```json
    {
        "kind": "bigquery#tableList",
        "etag": "ASMRI9cY0t0ilhpaFI4OMA==",
        "tables": [
            {
                "kind": "bigquery#table",
                "id": "testbig-235116:testData.github_nested_copy",
                "tableReference": {
                    "projectId": "testbig-235116",
                    "datasetId": "testData",
                    "tableId": "github_nested_copy"
                },
                "type": "TABLE",
                "creationTime": "1553104818977",
                "expirationTime": "1558288818977"
            },
            {
                "kind": "bigquery#table",
                "id": "testbig-235116:testData.sample_20190322",
                "tableReference": {
                    "projectId": "testbig-235116",
                    "datasetId": "testData",
                    "tableId": "sample_20190322"
                },
                "type": "TABLE",
                "creationTime": "1553239767833",
                "expirationTime": "1558423767833"
            }
        ],
        "totalItems": 2
    }
    ```