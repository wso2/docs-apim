# HTTP Status Codes

When REST API requests are sent to carry out various actions, various HTTP status codes will be returned based on the state of the action (success or failure) and the HTTP method (`POST`, `GET`, `PUT`, `DELETE`) executed. The following are the definitions of the various HTTP status codes that are returned.

## HTTP status codes indicating successful delivery

<table>
<tr>
<td> Code</td>
<td>Code Summary</td>
<td> Description</td>
</tr>
<tr> 200</td>
<td>Ok</td>
<td>HTTP request was successful. The output corresponding to the HTTP request will be returned. Generally used as a response to successful <code>GET</code> and <code>PUT</code> REST API HTTP methods.</td>
</tr>
<tr> 
<td>201</td>
<td>Created</td>
<td>HTTP request was successfully processed and a new resource was created. Generally used as a response to a successful <code>POST</code> REST API HTTP method.</td>
</tr>
<tr> 
<td>204</td>
<td>No content</td>
<td>HTTP request was successfully processed. No content will be returned. Generally used as a response to a successful <code>DELETE</code> REST API HTTP method.</td>
</tr>
<tr> 
<td>202</td>
<td>Accepted</td>
<td>HTTP request was accepted for processing, but the processing was not complete. This generally occurs when you are successful in trying to undeploy an application.</td>
</tr>

</table>

## Error HTTP status codes

<table>
<tr>
<td>Code</td>
<td>Code Summary</td>
<td>Description</td>
</tr>
<tr>
<td>404</td>
<td>Not found</td>
<td>Requested resource not found. Generally used as a response for unsuccessful <code>GET</code> and <code>PUT</code> REST API HTTP methods.</td>
</tr>
<tr>
<td>409</td>
<td>Conflict</td>
<td>Request could not be processed because of conflict in the request. This generally occurs when you are trying to add a resource that already exists. For example, when trying to add an auto-scaling policy that has an already existing ID.
</td>
</tr>
<tr>
<td>500</td>
<td>Internal server error</td>
<td>Server error occurred.</td> </tr>
</table>
