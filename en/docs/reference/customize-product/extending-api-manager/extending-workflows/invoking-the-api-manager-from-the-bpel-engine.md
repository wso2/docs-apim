# Invoking the API Manager from the BPEL Engine

Once the workflow configurations are finalized at the BPEL, the call-back URL of the APIM, which is originally configured in the `<APIM_HOME>/repository/conf/api-manager.xml` file and sent to the BPEL engine in the outflow will be called to progress the workflow. In APIM, the endpoint is available in both SOAP and REST variants as follows:

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<thead>
<tr class="header">
<th>Type</th>
<th>URI</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>SOAP</td>
<td><p><a href="https://localhost:8243/services/WorkflowCallbackService" class="uri">https://localhost:8243/services/WorkflowCallbackService</a></p>
<p>WSDL Location : <a href="http://localhost:8280/services/WorkflowCallbackService?wsdl" class="uri">http://localhost:8280/services/WorkflowCallbackService?wsdl</a></p></td>
</tr>
<tr class="even">
<td>REST</td>
<td><a href="https://localhost:9443/api/am/admin/v2/workflows/update-workflow-status" class="uri">https://localhost:9443/api/am/admin/v2/workflows/update-workflow-status</a></td>
</tr>
</tbody>
</table>

Both the endpoints are secured via basic authentication. Therefore, when you invoke either endpoint, you need to include an authorization header with a base64-encoded value of the username and password with the request. E.g., `Authorization: Basic <base64 encoded                   username:password                  >` .

The endpoint expects the following list of parameters:

<table>
<colgroup>
<col width="33%" />
<col width="33%" />
<col width="33%" />
</colgroup>
<thead>
<tr class="header">
<th>Parameter</th>
<th>Description</th>
<th>Mandatory</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><pre><code>workflowReference</code></pre></td>
<td>The unique identifier sent to the BPEL against which the workflow is tracked in API Manager</td>
<td>YES</td>
</tr>
<tr class="even">
<td><pre><code>status</code></pre></td>
<td>The next status to which the workflow needs to be promoted to.</td>
<td>YES</td>
</tr>
<tr class="odd">
<td><pre><code>description</code></pre></td>
<td>Notes, that may need to be persisted against a particular workflow.</td>
<td>NO</td>
</tr>
</tbody>
</table>

A sample curl request for invoking the REST endpoint is as follows:

``` 
curl -H "Authorization:Basic YWRtaW46YWRtaW4=" -X POST https://localhost:9443/api/am/admin/v2/workflows/update-workflow-status -d 'workflowReference=b530be39-9174-43b3-acb3-2603a223b094&status=APPROVED&description=DESCRIPTION'
```

A sample SOAP request is given below:

``` xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:cal="http://callback.workflow.apimgt.carbon.wso2.org">
   <soapenv:Header/>
   <soapenv:Body>
      <cal:resumeEvent>
         <cal:workflowReference>b530be39-9174-43b3-acb3-2603a223b094</cal:workflowReference>
         <cal:status>APPROVED</cal:status>
         <cal:description>DESCRIPTION</cal:description>
      </cal:resumeEvent>
   </soapenv:Body>
</soapenv:Envelope>
```
