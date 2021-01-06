# Siddhi Application Management APIs

## Creating a Siddhi application

### Overview

<table>
<tbody>
<tr class="odd">
<th>Description</th>
<td>Creates a new Siddhi Application.</td>
</tr>
<tr class="even">
<th>API Context</th>
<td><code>/siddhi-apps</code></td>
</tr>
<tr class="odd">
<th>HTTP Method</th>
<td>POST</td>
</tr>
<tr class="even">
<th>Request/Response format</th>
<td><strong>Request</strong> : text/plain<br />
<strong>Response</strong> : application/json</td>
</tr>
<tr class="odd">
<th>Authentication</th>
<td>Basic</td>
</tr>
<tr class="even">
<th>Username</th>
<td>admin</td>
</tr>
<tr class="odd">
<th>Password</th>
<td>admin</td>
</tr>
<tr class="even">
<th>Runtime</th>
<td>server/tooling</td>
</tr>
</tbody>
</table>

### curl command syntax

``` java
curl -X POST "https://<HOST_NAME>:<PORT>/siddhi-apps" -H "accept: application/json" -H "Content-Type: text/plain" -d @{appName} -u <SI_USERNAME>:<SI_PASSWORD> -k
```

### Sample curl command

``` java
curl -X POST "https://localhost:9443/siddhi-apps" -H "accept: application/json" -H "Content-Type: text/plain" -d @TestSiddhiApp.siddhi -u admin:admin -k
```

### Sample output

The response for the sample curl command given above can be one of the
following.

-   If API request is valid and there is no existing Siddhi application
    with the given name, a response similar to the following is
    generated with response code 201. This response contains a location
    header with the path of the newly created file from product root
    home.

    ``` java
    {
      "type":"success",
      "message":"Siddhi App saved succesfully and will be deployed in next deployment cycle"
    }
    ```

-   If the API request is valid, but a Siddhi application with the given
    name already exists,  a response similar to the following is
    generated with response code 409.

    ``` java
    {
      "type": "conflict",
      "message": "There is a Siddhi App already exists with same name" 
    }
    ```

-   If the API request is invalid due to invalid content in the Siddhi
    queries you have included in the request body,  a response similar
    to the following is generated is generated with response code 400.

    ``` java
    {
      "code": 800101,
      "type": "validation error",
      "message": "You have an error in your SiddhiQL at line 8:8, missing INTO at 'BarStream'" 
    }
    ```

-   If the API request is valid, but an exception occurred during file
    processing or saving, the following response is generated with
    response code 500.

    ``` java
    {
      "code": 800102,
      "type": "file processing error",
      "message": <error-message>
    }
    ```

### Response

<table>
<tbody>
<tr class="odd">
<th>HTTP Status Code</th>
<td><p>Possible codes are 201, 409, 400, and 500.</p>
<p>For descriptions of the HTTP status codes, see <a href="https://ei.docs.wso2.com/en/latest/streaming-integrator/ref/hTTP-Status-Codes/">HTTP Status Codes</a> .</p></td>
</tr>
</tbody>
</table>

## Updating a Siddhi Application

### Overview

<table>
<tbody>
<tr class="odd">
<th>Description</th>
<td>Updates a Siddhi Application.</td>
</tr>
<tr class="even">
<th>API Context</th>
<td><code>/siddhi-apps</code></td>
</tr>
<tr class="odd">
<th>HTTP Method</th>
<td>PUT</td>
</tr>
<tr class="even">
<th>Request/Response format</th>
<td><strong>Request</strong> : text/plain<br />
<strong>Response</strong> : application/json</td>
</tr>
<tr class="odd">
<th>Authentication</th>
<td>Basic</td>
</tr>
<tr class="even">
<th>Username</th>
<td>admin</td>
</tr>
<tr class="odd">
<th>Password</th>
<td>admin</td>
</tr>
<tr class="even">
<th>Runtime</th>
<td>server/tooling</td>
</tr>
</tbody>
</table>

### curl command syntax

``` java
curl -X PUT "http://<HOST_NAME>:<PORT>/siddhi-apps" -H "accept: application/json" -H "Content-Type: text/plain" -d @{appName}.siddhi -u admin:admin -k
```

### Sample curl command

``` java
curl -X PUT "https://localhost:9443/siddhi-apps" -H "accept: application/json" -H "Content-Type: text/plain" -d @TestSiddhiApp.siddhi -u admin:admin -k
```

### Sample output

-   If the API request is valid and the specified Siddhi application is successfully updated, the following response is returned with response code 200.

    ```
    {
      "type":"success",
      "message":"Siddhi App updated succesfully and will be deployed in next deployment cycle"}
    ```

-   If the API request is invalid due to invalid content in the Siddhi
    query, a response similar to the following is returned with response
    code 400.

    ``` java
    {
      "code": 800101,
      "type": "validation error",
      "message": "You have an error in your SiddhiQL at line 8:8, missing INTO at 'BarStream'" 
    }
    ```

-   If the API request is valid, but an exception occurred when saving or
    processing files, a response similar to the following is returned
    with response code 500.

    ``` java
    {
      "code": 800102,
      "type": "file processing error",
      "message": <error-message>
    }
    ```

### Response

<table>
<tbody>
<tr class="odd">
<th>HTTP Status Code</th>
<td><p>Possible codes are 200, 201, 400, and 500.</p>
<p>For descriptions of the HTTP status codes, see <a href="https://ei.docs.wso2.com/en/latest/streaming-integrator/ref/hTTP-Status-Codes/">HTTP Status Codes</a> .</p></td>
</tr>
</tbody>
</table>

  

## Deleting a Siddhi application

### Overview

<table>
<tbody>
<tr class="odd">
<th>Description</th>
<td>Delets an existing Siddhi application.</td>
</tr>
<tr class="even">
<th>API Context</th>
<td><code>/siddhi-apps/{appName}</code></td>
</tr>
<tr class="odd">
<th>HTTP Method</th>
<td>DELETE</td>
</tr>
<tr class="even">
<th>Request/Response format</th>
<td>application/json</td>
</tr>
<tr class="odd">
<th>Authentication</th>
<td>Basic</td>
</tr>
<tr class="even">
<th>Username</th>
<td>admin</td>
</tr>
<tr class="odd">
<th>Password</th>
<td>admin</td>
</tr>
<tr class="even">
<th>Runtime</th>
<td>server/tooling</td>
</tr>
</tbody>
</table>
  
#### Parameter Description

| Parameter | Description                                       |
|-----------|---------------------------------------------------|
|`{appName}`| The name of the Siddhi application to be deleted. |

### curl command syntax

``` java
curl -X DELETE "http://<HOST_NAME>:<PORT>/siddhi-apps/{app-name}" -H "accept: application/json" -u admin:admin -k
```

### Sample curl command

``` java
curl -X DELETE "https://localhost:9443/siddhi-apps/TestSiddhiApp" -H "accept: application/json" -u admin:admin -k
```

### Sample output

The response for the sample curl command given above can be one of the
following:

-   If the API request is valid and a Siddhi application with the given
    name exists, an empty response is received with response
    code 200.

    ``` java
    http://localhost:9090/siddhi-apps/TestExecutionPlan1
    ```

-   If the API request is valid, but a Siddhi application with the given
    name is not deployed, the following response is received with
    response code 404.

    ``` java
    {
      "type": "not found",
      "message": "There is no Siddhi App exist with provided name : TestExecutionPlan1" 
    }
    ```

-   If the API request is valid, but an exception occurred when deleting
    the given Siddhi application, the following response is received
    with response code 500.

    ``` java
    {
      "code": 800102,
      "type": "file processing error",
      "message": <error-message>
    }
    ```

-   If the API request is valid, but there are restricted characters in
    the given Siddhi application name, the following response is
    received with response code 400.

    ``` java
    {
      "code": 800101,
      "type": "validation error",
      "message": "File name contains restricted path elements . : ../../siddhiApp2'" 
    }
    ```

### Response

<table>
<tbody>
<tr class="odd">
<th>HTTP Status Code</th>
<td><p>200, 404, 500 or 400.</p>
<p>For descriptions of the HTTP status codes, see <a href="https://ei.docs.wso2.com/en/latest/streaming-integrator/ref/hTTP-Status-Codes/">HTTP Status Codes</a> .</p></td>
</tr>
</tbody>
</table>

## Listing all active Siddhi applications

### Overview

<table>
<tbody>
<tr class="odd">
<th>Description</th>
<td><p>Lists all the currently active Siddhi applications.</p>
<p>If the <code>isActive=true</code> parameter is set, all the active Siddhi Applications are listed. If not, all the inactive Siddhi applications are listed.</p></td>
</tr>
<tr class="even">
<th>API Context</th>
<td><code>/siddhi-apps</code></td>
</tr>
<tr class="odd">
<th>HTTP Method</th>
<td>GET</td>
</tr>
<tr class="even">
<th>Request/Response format</th>
<td><strong>Request content type</strong> : any<br />
<strong>Response content type</strong> : <code>application/json</code></td>
</tr>
<tr class="odd">
<th>Authentication</th>
<td>Basic</td>
</tr>
<tr class="even">
<th>Username</th>
<td>admin</td>
</tr>
<tr class="odd">
<th>Password</th>
<td>admin</td>
</tr>
<tr class="even">
<th>Runtime</th>
<td>server/tooling</td>
</tr>
</tbody>
</table>

### curl command syntax

``` java
curl -X GET "http://<HOST_NAME>:<PORT>/siddhi-apps" -H "accept: application/json" -u admin:admin -k
```

### Sample curl command

``` java
curl -X GET "https://localhost:9443/siddhi-apps?isActive=true" -H "accept: application/json" -u admin:admin -k
```

### Sample output

Possible responses are as follows:

- If the API request is valid and there are Siddhi applications deployed in your WSO2 Streaming Integrator setup, a response similar to the following is returned with response code 200.

    ``` java
    ["TestExecutionPlan3", "TestExecutionPlan4"]
    ```

- If the API request is valid, there are Siddhi applications deployed in your Streaming Integrator setup, and a query parameter is defined in the request, a response similar to the following is returned with response code 200. This response only contains Siddhi applications that are active.<br/><br/>

    !!! info
        If these conditions are met, but the `isActive` parameter is set to `false`, the response contains only inactive Siddhi applications.
    
    ``` java
    ["TestExecutionPlan3"]
    ```

- If the API request is valid, but there are no Siddhi applications deployed in your Streaming Integrator setup, the following response is returned.

    ``` java
    []
    ```

### Response

<table>
<tbody>
<tr class="odd">
<th>HTTP Status Code</th>
<td><p>200</p>
<p>For descriptions of the HTTP status codes, see <a href="https://ei.docs.wso2.com/en/latest/streaming-integrator/ref/hTTP-Status-Codes/">HTTP Status Codes</a> .</p></td>
</tr>
</tbody>
</table>

## Retrieving a specific Siddhi application

### Overview

<table>
<tbody>
<tr class="odd">
<th>Description</th>
<td>Retrieves the given Siddhi application.</td>
</tr>
<tr class="even">
<th>API Context</th>
<td><code>/siddhi-apps/{appName}</code></td>
</tr>
<tr class="odd">
<th>HTTP Method</th>
<td>GET</td>
</tr>
<tr class="even">
<th>Request/Response format</th>
<td>application/json</td>
</tr>
<tr class="odd">
<th>Authentication</th>
<td>Basic</td>
</tr>
<tr class="even">
<th>Username</th>
<td>admin</td>
</tr>
<tr class="odd">
<th>Password</th>
<td>admin</td>
</tr>
<tr class="even">
<th>Runtime</th>
<td>server/tooling</td>
</tr>
</tbody>
</table>


#### Parameter Description

| Parameter   | Description                                         |
|-------------|-----------------------------------------------------|
| `{appName}` | The name of the Siddhi application to be retrieved. |

  

### curl command syntax

``` java
curl -X GET "http://<HOST_NAME>:<PORT>/siddhi-apps/{app-name}" -H "accept: application/json" -u admin:admin -k
```

### Sample curl command

``` java
curl -X GET "https://localhost:9443/siddhi-apps/SiddhiTestApp" -H "accept: application/json" -u admin:admin -k
```

### Sample output

- If the API request is valid and a Siddhi application of the given name exists, a response similar to the following is returned with response code 200.

    ``` java
    {
      "content": "\n@Plan:name('TestExecutionPlan')\ndefine stream FooStream (symbol string, price float, volume long);\n\n@source(type='inMemory', topic='symbol', @map(type='passThrough'))Define stream BarStream (symbol string, price float, volume long);\n\nfrom FooStream\nselect symbol, price, volume\ninsert into BarStream;" 
    }
    ```

- If the API request is valid, but a Siddhi application of the given name is not deployed, a response similar to the following is returned with response code 404.

    ``` java
    {
      "type": "not found",
      "message": "There is no Siddhi App exist with provided name : TestExecutionPlan1" 
    }
    ```

### Response

<table>
<tbody>
<tr class="odd">
<th>HTTP Status Code</th>
<td><p>200 or 404</p>
<p>For descriptions of the HTTP status codes, see <a href="https://ei.docs.wso2.com/en/latest/streaming-integrator/ref/hTTP-Status-Codes/">HTTP Status Codes</a> .</p></td>
</tr>
</tbody>
</table>

## Fetching the status of a Siddhi Application

### Overview

<table>
<colgroup>
<col style="width: 33%" />
<col style="width: 66%" />
</colgroup>
<tbody>
<tr class="odd">
<th>Description</th>
<td>This fetches the status of the specified Siddhi application.</td>
</tr>
<tr class="even">
<th>API Context</th>
<td><code>/siddhi-apps/{appName}/status</code></td>
</tr>
<tr class="odd">
<th>HTTP Method</th>
<td>GET</td>
</tr>
<tr class="even">
<th>Request/Response format</th>
<td>application/json</td>
</tr>
<tr class="odd">
<th>Authentication</th>
<td>Basic</td>
</tr>
<tr class="even">
<th>Username</th>
<td>admin</td>
</tr>
<tr class="odd">
<th>Password</th>
<td>admin</td>
</tr>
<tr class="even">
<th>Runtime</th>
<td>server/runtime</td>
</tr>
</tbody>
</table>

#### Parameter Description

|Parameter   | Description                                                                 |
|------------|-----------------------------------------------------------------------------|
|`{appName}` | The name of the Siddhi application of which the status needs to be fetched. |

### curl command syntax

``` java
curl -X GET "http://<HOST_NAME>:<PORT>/siddhi-apps/{app-file-name}/status" -H "accept: application/json" -u admin:admin -k
```

### Sample curl command

``` java
curl -X GET "https://localhost:9443/siddhi-apps/TestSiddhiApp/status" -H "accept: application/json" -u admin:admin -k
```

### Sample output

- If the Siddhi application is active, the following is returned with response code 200.

    ``` java
    {"status":"active"} 
    ```

- If the Siddhi application is inactive, the following is returned with response code 200.

    ``` java
    {"status":"inactive"} 
    ```

- If the Siddhi application does not exist, but the REST API call is valid, the following is returned with the response code 404.

    ``` java
    {
      "type": "not found",
      "message": "There is no Siddhi App exist with provided name : TestExecutionPlan1" 
    }
    ```

### Response

<table>
<tbody>
<tr class="odd">
<th>HTTP Status Code</th>
<td><p>200 or 404</p>
<p>For descriptions of the HTTP status codes, see <a href="https://ei.docs.wso2.com/en/latest/streaming-integrator/ref/hTTP-Status-Codes/">HTTP Status Codes</a> .</p></td>
</tr>
</tbody>
</table>

## Taking a snapshot of a Siddhi Application

### Overview

<table>
<colgroup>
<col style="width: 33%" />
<col style="width: 66%" />
</colgroup>
<tbody>
<tr class="odd">
<th>Description</th>
<td>This takes a snapshot of the specific Siddhi application.</td>
</tr>
<tr class="even">
<th>API Context</th>
<td><code>/siddhi-apps/{appName}/backup </code></td>
</tr>
<tr class="odd">
<th>HTTP Method</th>
<td>POST</td>
</tr>
<tr class="even">
<th>Request/Response format</th>
<td>application/json</td>
</tr>
<tr class="odd">
<th>Authentication</th>
<td>Basic</td>
</tr>
<tr class="even">
<th>Username</th>
<td>admin</td>
</tr>
<tr class="odd">
<th>Password</th>
<td>admin</td>
</tr>
<tr class="even">
<th>Runtime</th>
<td>server/runtime</td>
</tr>
</tbody>
</table>
 

#### Parameter Description

| Parameter | Description                                                               |
|-----------|---------------------------------------------------------------------------|
|`{appName}`| The name of the Siddhi application of which a snapshot needs to be taken. |

  
### curl command syntax

``` java
curl -X POST "http://<HOST_NAME>:<PORT>/siddhi-apps/{appName}/backup" -H "accept: application/json" -u admin:admin -k
```

### Sample curl command

``` java
curl -X POST "https://localhost:9443/siddhi-apps/TestSiddhiApp/backup" -H "accept: application/json" -u admin:admin -k
```

### Sample output

The output can be one of the following:

- If the API request is valid and a Siddhi application exists with the given name, an output similar to the following (i.e., with the snapshot revision number) is returned with response code 201.

    ``` java
    {"revision": "89489242494242"} 
    ```

- If the API request is valid, but no Siddhi application with the given name is deployed, an output similar to the following is returned with response code 404.

    ``` java
    {
      "type": "not found",
      "message": "There is no Siddhi App exist with provided name : TestExecutionPlan1" 
    }
    ```

- If the API request is valid, but an exception has occurred when backing up the state at Siddhi level, an output similar to the following is returned with response code 500.

    ``` java
            {
              "code": 800102,
              "type": "file processing error",
              "message": <error-message>
            }
    ```

### Response

<table>
<tbody>
<tr class="odd">
<th>HTTP Status Code</th>
<td><p>201, 404, or 500.</p>
<p>For descriptions of the HTTP status codes, see <a href="https://ei.docs.wso2.com/en/latest/streaming-integrator/ref/hTTP-Status-Codes/">HTTP Status Codes</a> .</p></td>
</tr>
</tbody>
</table>

## Restoring a Siddhi Application via a snapshot

!!! info
    In order to call this API, you need to have already taken a snapshot of the Siddhi application to be restored. For more information about the API via which the snapshot is taken, see [Taking a snapshot of a Siddhi application](#SiddhiApplicationManagementAPIs-Snapshot).

### Overview

<table>
<tbody>
<tr class="odd">
<th><p>Description</p></th>
<td><p>This restores a Siddhi application using a previously taken snapshot of the same Siddhi Application.</p></td>
</tr>
<tr class="even">
<th><p>API Context</p></th>
<td><ul>
<li><strong>To restore without considering the version</strong> : <code>/siddhi-apps/{appName}/restore</code></li><br/>
<li><strong>To restore a specific version</strong> : <code>/siddhi-apps/{appName}/restore?version=</code></li>
</ul></td>
</tr>
<tr class="odd">
<th><p>HTTP Method</p></th>
<td>POST</td>
</tr>
<tr class="even">
<th><p>Request/Response format</p></th>
<td>application/json</td>
</tr>
<tr class="odd">
<th>Authentication</th>
<td>Basic</td>
</tr>
<tr class="even">
<th>Username</th>
<td>admin</td>
</tr>
<tr class="odd">
<th>Password</th>
<td>admin</td>
</tr>
<tr class="even">
<th><p>Runtime</p></th>
<td>server/tooling</td>
</tr>
</tbody>
</table>

#### Parameter Description

| Parameter | Description                                                               |
|-----------|---------------------------------------------------------------------------|
|`{appName}`| The name of the Siddhi application that needs to be restored.             |

  

### curl command syntax

``` java
curl -X POST "http://<HOST_NAME>:<PORT>/siddhi-apps/{appName}/restore" -H "accept: application/json" -u admin:admin -k
```

### Sample curl command

``` java
curl -X POST "https://localhost:9443/siddhi-apps/TestSiddhiApp/restore?revision=1514981290838_TestSiddhiApp" -H "accept: application/json" -u admin:admin -k
```

### Sample output

The above sample curl command can generate either one of the following responses:

- If the API request is valid, a Siddhi application with the given name exists, and no revision information is passed as a query parameter, the following response is returned with response code 200.

    ``` java
    {
      "type": "success",
      "message": "State restored to last revision for Siddhi App :TestExecutionPlan" 
    }
    ```

- If the API request is valid, a Siddhi application with the given name exists, and revision information is passed as a query parameter, the following response is returned with response code 200. In this scenario, the Siddhi snapshot is created in the file system.

    ``` java
    {
      "type": "success",
      "message": "State restored to revision 1234563 for Siddhi App :TestExecutionPlan" 
    }
    ```

- If the API request is valid, but no Siddhi application is deployed with the given name, the following response is returned with response code 404.

    ``` java
    {
      "type": "not found",
      "message": "There is no Siddhi App exist with provided name : TestExecutionPlan1" 
    }
    ```

- If the API request is valid, but an exception occurred when restoring the state at Siddhi level, the following response is returned with response code 500.

    ``` java
    {
      "code": 800102,
      "type": "file processing error",
      "message": <error-message>
    }
    ```

### Response

<table>
<tbody>
<tr class="odd">
<th>HTTP Status Code</th>
<td><p>200, 404 or 500.</p>
<p>For descriptions of the HTTP status codes, see <a href="https://ei.docs.wso2.com/en/latest/streaming-integrator/ref/hTTP-Status-Codes/">HTTP Status Codes</a> .</p></td>
</tr>
</tbody>
</table>

## Returning real-time statistics of a Streaming Integrator node

### Overview

<table>
<tbody>
<tr class="odd">
<th>Description</th>
<td>Returns the real-time statistics of a Streaming Integrator node.</td>
</tr>
<tr class="even">
<th><p>API Context</p></th>
<td><code>/statistics</code></td>
</tr>
<tr class="odd">
<th>HTTP Method</th>
<td>GET</td>
</tr>
<tr class="even">
<th>Request/Response format</th>
<td>application/json</td>
</tr>
<tr class="odd">
<th>Authentication</th>
<td>Basic</td>
</tr>
<tr class="even">
<th>Username</th>
<td>admin</td>
</tr>
<tr class="odd">
<th>Password</th>
<td>admin</td>
</tr>
<tr class="even">
<th><p>Runtime</p></th>
<td>server/tooling</td>
</tr>
</tbody>
</table>


### curl command syntax

``` java
curl -X GET "https://<HOST_NAME>>:<PORT>/statistics" -H "accept: application/json" -u admin:admin -k
```

### Sample curl command

``` java
curl -X GET "https://localhost:9443/statistics" -H "accept: application/json" -u admin:admin -k
```

### Sample output

```
{
  "workerMetrics": {
    "processCPU": 0.0,
    "systemCPU": 0.0,
    "loadAverage": 0.0,
    "memoryUsage": 0.0
  },
  "runningStatus": "Reachable",
  "isStatsEnabled": false,
  "clusterID": "Single Node Deployments",
  "lastSyncTime": "n/a",
  "lastSnapshotTime": "Thu, 01 Jan 1970 05:30:00 IST",
  "isInSync": false,
  "message": "Metrics are disabled."
}
```

### Response

<table>
<tbody>
<tr class="odd">
<th>HTTP Status Code</th>
<td><p>200 or 404</p>
<p>For descriptions of the HTTP status codes, see <a href="https://ei.docs.wso2.com/en/latest/streaming-integrator/ref/hTTP-Status-Codes/">HTTP Status Codes</a> .</p></td>
</tr>
</tbody>
</table>

## Enabling/disabling node statistics

### Overview

<table>
<tbody>
<tr class="odd">
<th>Description</th>
<td>Enables/disables the real-time statistics of a Streaming Integrator node.</td>
</tr>
<tr class="even">
<th><p>API Context</p></th>
<td><code>/statistics</code></td>
</tr>
<tr class="odd">
<th>HTTP Method</th>
<td>PUT</td>
</tr>
<tr class="even">
<th>Request/Response format</th>
<td>application/json</td>
</tr>
<tr class="odd">
<th>Authentication</th>
<td>Basic</td>
</tr>
<tr class="even">
<th>Username</th>
<td>admin</td>
</tr>
<tr class="odd">
<th>Password</th>
<td>admin</td>
</tr>
<tr class="even">
<th><p>Runtime</p></th>
<td>server/tooling</td>
</tr>
</tbody>
</table>

### curl command syntax

``` java
curl -X PUT "https://<HOST_NAME>:<PORT/statistics" -H "accept: application/json" -H "Content-Type: application/json" -d "{\"statsEnable\":\"true\"}" -u admin:admin -k
```

### Sample curl command

``` java
curl -X PUT "https://localhost:9443/statistics" -H "accept: application/json" -H "Content-Type: application/json" -d "{\"statsEnable\":\"true\"}" -u admin:admin -k
```

### Sample output

- If the statistics are successfully enabled, the following response is returned.

    ```
      {
        "code":4,
        "type":"ok",
        "message":"Successfully enabled the metrics."
      }  
    ```
- If the statistics are already enabled, the following response is returned.

    ```
      {
        "code":4,
        "type":"ok",
        "message":"Metrics are enabled already."
      }
    ```

- If the statistics are successfully disabled, the following response is returned.

    ```
      {
        "code":4,
        "type":"ok",
        "message":"Successfully disabled the metrics."
      }
    ```
  
- If the statistics are already disabled, the following response is returned.

    ```
      {
        "code":4,
        "type":"ok",
        "message":"Metrics are disabled already."
      }
    ```

### Response

<table>
<tbody>
<tr class="odd">
<th>HTTP Status Code</th>
<td><p>200 or 404</p>
<p>For descriptions of the HTTP status codes, see <a href="https://ei.docs.wso2.com/en/latest/streaming-integrator/ref/hTTP-Status-Codes/">HTTP Status Codes</a> .</p></td>
</tr>
</tbody>
</table>

## Returning general details of a Streaming Integrator node

### Overview

<table>
<tbody>
<tr class="odd">
<th>Description</th>
<td>Returns general details of a Streaming Integrator node.</td>
</tr>
<tr class="even">
<th>API Context</th>
<td><code>/system-details</code></td>
</tr>
<tr class="odd">
<th>HTTP Method</th>
<td>GET</td>
</tr>
<tr class="even">
<th>Request/Response format</th>
<td>application/json</td>
</tr>
<tr class="odd">
<th>Authentication</th>
<td>Basic</td>
</tr>
<tr class="even">
<th>Username</th>
<td>admin</td>
</tr>
<tr class="odd">
<th>Password</th>
<td>admin</td>
</tr>
<tr class="even">
<th><p>Runtime</p></th>
<td>server/tooling</td>
</tr>
</tbody>
</table>

### curl command syntax

``` java
curl -X GET "https://<HOST_NAME>:<PORT>/system-details" -H "accept: application/json" -u admin:admin -k
```

### Sample curl command

``` java
curl -X GET "https://localhost:9443/system-details" -H "accept: application/json" -u admin:admin -k
```

### Sample output

```
{
  "carbonId": "wso2-si",
  "javaRuntimeName": "Java(TM) SE Runtime Environment",
  "javaVMVersion": "25.152-b16",
  "javaVMVendor": "Oracle Corporation",
  "javaHome": "/Library/Java/JavaVirtualMachines/jdk1.8.0_152.jdk/Contents/Home/jre",
  "javaVersion": "1.8.0_152",
  "osName": "Mac OS X",
  "osVersion": "10.14.5",
  "userHome": "/Users/wso2user",
  "userTimezone": "Asia/Colombo",
  "userName": "wso2user",
  "userCountry": "LK",
  "repoLocation": "/Users/wso2user/wso2si/deployment",
  "serverStartTime": "Thu, 06 Aug 2020 15:45:51 IST"
}
```

### Response

<table>
<tbody>
<tr class="odd">
<th>HTTP Status Code</th>
<td><p>200 or 404</p>
<p>For descriptions of the HTTP status codes, see <a href="https://ei.docs.wso2.com/en/latest/streaming-integrator/ref/hTTP-Status-Codes/">HTTP Status Codes</a> .</p></td>
</tr>
</tbody>
</table>

## Returning detailed statistics of all Siddhi applications

### Overview

<table>
<tbody>
<tr class="odd">
<th>Description</th>
<td>Returns the detailed statistics of all the Siddhi applications currently deployed in the Streaming Integrator setup.</td>
</tr>
<tr class="even">
<th>API Context</th>
<td><code>/siddhi-apps/statistics </code></td>
</tr>
<tr class="odd">
<th>HTTP Method</th>
<td>GET</td>
</tr>
<tr class="even">
<th>Request/Response format</th>
<td>application/json</td>
</tr>
<tr class="odd">
<th>Authentication</th>
<td>Basic</td>
</tr>
<tr class="even">
<th>Username</th>
<td>admin</td>
</tr>
<tr class="odd">
<th>Password</th>
<td>admin</td>
</tr>
<tr class="even">
<th><p>Runtime</p></th>
<td>server/tooling</td>
</tr>
</tbody>
</table>

### curl command syntax

``` java
curl -X GET "https://<HOST_NAME>>:<PORT>/siddhi-apps/statistics" -H "accept: application/json" -u admin:admin -k
```

### Sample curl command

``` java
curl -X GET "https://localhost:9443/siddhi-apps/statistics" -H "accept: application/json" -u admin:admin -k
```

### Sample output

- If Siddhi applications exist, a response similar to the following is returned with details of each Siddhi application. This response is returned with the 200 code.

    ```
      [
        {
          "appName": "TestExecutionPlan1",
          "status": "active",
          "age": 89981329,
          "isStatEnabled": "DETAIL",
          "siddhiStatEnabledLevel": { "name": "DETAIL", "intLevel": 500 }
        },
        {
          "appName": "TestExecutionPlan2",
          "status": "active",
          "age": 89981639,
          "isStatEnabled": "DETAIL",
          "siddhiStatEnabledLevel": { "name": "DETAIL", "intLevel": 500 }
        },
        {
          "appName": "TestExecutionPlan3",
          "status": "active",
          "age": 87053026,
          "isStatEnabled": "DETAIL",
          "siddhiStatEnabledLevel": { "name": "DETAIL", "intLevel": 500 }
        }
      ]
    ```

- If Siddhi applications do not exist, the following response is returned with the 404 response code.

    ```
      {
        "type":"not-found",
        "message":"There are no any Siddhi App exist."
      }
    ```

### Response

<table>
<tbody>
<tr class="odd">
<th>HTTP Status Code</th>
<td><p>200 or 404</p>
<p>For descriptions of the HTTP status codes, see <a href="https://ei.docs.wso2.com/en/latest/streaming-integrator/ref/hTTP-Status-Codes/">HTTP Status Codes</a> .</p></td>
</tr>
</tbody>
</table>

## Enabling/disabling the statistics of a specific Siddhi application

### Overview

<table>
<tbody>
<tr class="odd">
<th>Description</th>
<td>Enables/disables statistics for a specified Siddhi application.</td>
</tr>
<tr class="even">
<th>API Context</th>
<td><code>/siddhi-apps/{appName}/statistics</code></td>
</tr>
<tr class="odd">
<th>HTTP Method</th>
<td>PUT</td>
</tr>
<tr class="even">
<th>Request/Response format</th>
<td>application/json</td>
</tr>
<tr class="odd">
<th>Authentication</th>
<td>Basic</td>
</tr>
<tr class="even">
<th>Username</th>
<td>admin</td>
</tr>
<tr class="odd">
<th>Password</th>
<td>admin</td>
</tr>
<tr class="even">
<th><p>Runtime</p></th>
<td>server/tooling</td>
</tr>
</tbody>
</table>

#### Parameter Description

| Parameter | Description                                                                              |
|-----------|------------------------------------------------------------------------------------------|
| `appName` | The name of the Siddhi application for which the statistics need to be enabled/disabled. |

  
### curl command syntax

``` java
curl -X PUT "https://<HOST_NAME>:<PORT>/siddhi-apps/{appName}/statistics" -H "accept: application/json" -H "Content-Type: application/json" -d "{\"statsEnable\": \"true\"}" -u admin:admin -k
```

### Sample curl command

``` java
curl -X PUT "https://localhost:9443/siddhi-apps/TestSiddhiApp/statistics" -H "accept: application/json" -H "Content-Type: application/json" -d "{\"statsEnable\": \"true\"}" -u admin:admin -k
```

### Sample output

- If statistics are successfully enabled, the following response is returned.

    ```
      {
        "type":"success",
        "message":"Sucessfully updated Aiddhi App : TestSiddhiApp"
      }
    ```
  
- If statistics are already enabled, the following response is returned.

    ```
      {"type":"success","message":"Stats level is already set to :class StatsEnable {\n    enabledStatLevel: DETAIL\n} for siddhi appTestSiddhiApp"}   
    ```

- If statistics are successfully disabled, the following response is returned.

    ```
      {
        "type":"success",
        "message":"Sucessfully updated Aiddhi App : TestSiddhiApp"
      }
    ```
  
- If statistics are already disabled, the following response is returned.

    ```
      {"type":"success","message":"Stats level is already set to :class StatsEnable {\n    enabledStatLevel: OFF\n} for siddhi appTestSiddhiApp"}
    ```
  
- If no Siddhi application of the specified name exists, the following response is returned with the 404 code.

    ```
      {
        "type":"not-found",
        "message":"There is no Siddhi App exist with provided name : TestSiddhiApp"
      }
    ```
    

### Response

<table>
<tbody>
<tr class="odd">
<th>HTTP Status Code</th>
<td><p>200 or 404</p>
<p>For descriptions of the HTTP status codes, see <a href="https://ei.docs.wso2.com/en/latest/streaming-integrator/ref/hTTP-Status-Codes/">HTTP Status Codes</a> .</p></td>
</tr>
</tbody>
</table>

## Enabling/disabling the statistics of all Siddhi applications

### Overview

<table>
<tbody>
<tr class="odd">
<th>Description</th>
<td>Enables/disables statistics for all the Siddhi applications.</td>
</tr>
<tr class="even">
<th>API Context</th>
<td><code>/siddhi-apps/statistics </code></td>
</tr>
<tr class="odd">
<th>HTTP Method</th>
<td>PUT</td>
</tr>
<tr class="even">
<th>Request/Response format</th>
<td>application/json</td>
</tr>
<tr class="odd">
<th>Authentication</th>
<td>Basic</td>
</tr>
<tr class="even">
<th>Username</th>
<td>admin</td>
</tr>
<tr class="odd">
<th>Password</th>
<td>admin</td>
</tr>
<tr class="even">
<th><p>Runtime</p></th>
<td>server/tooling</td>
</tr>
</tbody>
</table>
                                                           

### curl command syntax

``` java
curl -X PUT "https://<HOST_NAME>:<PORT>/siddhi-apps/statistics" -H "accept: application/json" -H "Content-Type: application/json" -d "{\"statsEnable\": \"true\"}" -u admin:admin -k
```

### Sample curl command

``` java
curl -X PUT "https://localhost:9443/siddhi-apps/statistics" -H "accept: application/json" -H "Content-Type: application/json" -d "{\"statsEnable\": \"true\"}" -u admin:admin -k
```

### Sample output

```
{
  "type":"success",
  "message":"All siddhi apps Sucessfully updated."
}
```

### Response

<table>
<tbody>
<tr class="odd">
<th>HTTP Status Code</th>
<td><p>200 or 404</p>
<p>For descriptions of the HTTP status codes, see <a href="https://ei.docs.wso2.com/en/latest/streaming-integrator/ref/hTTP-Status-Codes/">HTTP Status Codes</a> .</p></td>
</tr>
</tbody>
</table>
