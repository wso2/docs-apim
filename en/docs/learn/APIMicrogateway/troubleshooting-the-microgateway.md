# Troubleshooting the Microgateway

When errors/exceptions occur in the system, the API Microgateway throws error responses to the client by default. The following sections explain about the different ways of troubleshooting common problems that might occur while you use the Microgateway.

-   [Common exceptions and solutions](#TroubleshootingtheMicrogateway-Commonexceptionsandsolutions)
-   [Error responses](#TroubleshootingtheMicrogateway-Errorresponses)
-   [Error codes](#TroubleshootingtheMicrogateway-Errorcodes)

### Common exceptions and solutions

The table below shows the common exceptions that might occur when you are trying to use the API Microgateway, and how to fix them. These exceptions can happen due to misconfigurations.

<table>
<thead>
<tr class="header">
<th>Error log</th>
<th>Possible cause</th>
<th>Resolution</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>             micro-gw: Error occurred while trying to connect with server. Is the server running at                           https://localhost:9443?                         </code></td>
<td><p>The API Manager node (Publisher) is down when running the setup command in the Microgateway.</p></td>
<td>Verify the connectivity between the Microgateway and the API manager node.</td>
</tr>
<tr class="even">
<td><code>             micro-gw: Error in client response : {message:&quot;Network is unreachable: www.mocky.io/54.194.152.6:80&quot;, cause:null}            </code></td>
<td><p>A connection to the backend could not be established because the network is unavailable.</p></td>
<td>Verify the network stability.</td>
</tr>
<tr class="odd">
<td><code>             Micro-gw: ERROR [src:0.0.0] - Error in client response : {message:&quot;Connection refused: localhost/127.0.0.1:8080&quot;, cause:null}            </code></td>
<td>Connection to the backend is refused.</td>
<td>Check the connection to the backend.</td>
</tr>
<tr class="even">
<td><code>             error [docker plugin]: Unable to build docker image: {&quot;message&quot;:&quot;invalid reference format: repository name must be lowercase&quot;}            </code></td>
<td><p>The name of the docker images should be in lower case.</p>
<p>When building the project with docker annotations, the docker image name is retrieved from the API name and version. If the API name contains a capital letter, then the docker image n ame would reflect that, resuling in this error.</p>
<p><br />
</p></td>
<td><div class="content-wrapper">
<p><br />
</p>
<div>
When building the API microgateway project, provide a simple letter name for the docker image in the <code>               deployment.toml              </code> file as shown below.
</div>
<div>
<p><br />
</p>
<div class="code panel pdl" style="border-width: 1px;">
<div class="codeContent panelContent pdl">
<pre class="java" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence"><code>[docker]
  [docker.dockerConfig]
    enable = true
    name = &quot;hello_world&quot;</code></pre>
</div>
</div>
<p><br />
</p>
</div>
<p><br />
</p>
</div></td>
</tr>
<tr class="odd">
<td><p><code>              ERROR [wso2/gateway:0.0.0] - Error occurred while reading the key validation response : {message:&quot;Connection refused: localhost/127.0.0.1:9443&quot;, cause:null}             </code><br />
<code>              ERROR [wso2/gateway:0.0.0] - Error occurred while converting the authorized value from the key validation response to a             </code><br />
<code>              string value : {message:&quot;'null' cannot be cast to 'string'&quot;, cause:null}             </code></p>
<p><code>              ERROR [wso2/gateway:0.0.0] - Error occurred while getting key validation information for the access token : {message:&quot;call failed&quot;, cause:{message:&quot;call failed&quot;, cause:{message:&quot;'null' cannot be cast to 'string'&quot;, cause:null}, causes:[{message:&quot;'null' cannot be cast to 'string'&quot;, cause:null}]}, causes:[{message:&quot;call failed&quot;, cause:{message:&quot;'null' cannot be cast to 'string'&quot;, cause:null}, causes:[{message:&quot;'null' cannot be cast to 'string'&quot;, cause:null}]}]}             </code></p></td>
<td>The Microgateway could not connect to the Key Manager for OAuth2 key validation.</td>
<td>Check the connection between the Microgateway and the Key Manager.</td>
</tr>
<tr class="even">
<td><code>             ERROR [wso2/gateway:0.0.0] - Error occurred while reading the key validation response : {message:&quot;General SSLEngine problem/192.168.8.101:9443&quot;, cause:null}            </code><br />
<code>             ERROR [wso2/gateway:0.0.0] - Error occurred while converting the authorized value from the key validation response to a            </code><br />
<code>             string value : {message:&quot;'null' cannot be cast to 'string'&quot;, cause:null}            </code></td>
<td>SSL hostname verification has failed in the key validation call.</td>
<td><div>
The <code>              localhost             </code> hostname is supported by default.
</div>
<div>
You need to add the public certificate of the Key Manager to the Microgateway truststore. Also, make sure that you change the <code>              certificateAlias             </code> accordingly.
</div></td>
</tr>
<tr class="odd">
<td><code>             ERROR [ballerina/http] - Error while validating JWT token : {message:&quot;Invalid signature&quot;, cause:null}            </code></td>
<td>JWT signature verification has failed.</td>
<td><div>
Verify the following:
</div>
<ul>
<li>JWT signer’s public cert should be available in the Microgateway’s truststore.</li>
<li>The correct Certificate Alias should be given in the <code>               &lt;MICROGW_HOME&gt;/conf/micro-gw.conf              </code> file.</li>
</ul></td>
</tr>
<tr class="even">
<td><code>             ERROR {org.wso2.apimgt.gateway.cli.cmd.Main} - Internal error occurred while executing command.            </code><br />
<code>             com.github.jknack.handlebars.HandlebarsException: /home/pubudu/Downloads/wso2am-micro-gw-toolkit-2.5.0/resources/templates/service.mustache:36:87: java.lang.IllegalStateException: Can't resolve: 'doc'            </code></td>
<td>This is due to an issue in the Service template.</td>
<td><ul>
<li>Open the <code>               &lt;MICROGW_HOME&gt;/resources/templates              </code> file.</li>
<li>Remove the <code>               @swagger:ServiceInfo              </code> annotation-related <a href="https://github.com/wso2/product-microgateway/blob/v2.5.0-rc2/components/micro-gateway-cli/src/main/resources/templates/service.mustache#L28-L42">configuration</a> in the service.mustache template.</li>
<li>Re-run the setup command.</li>
</ul></td>
</tr>
</tbody>
</table>

### Error responses

| Error code                          | Error response                                               | Possible reasons                                                                   |
|-------------------------------------|--------------------------------------------------------------|------------------------------------------------------------------------------------|
| `101503` | ``` java                                                     
      {                                                             
          "fault": {                                                
              "code": "101503",                                     
              "message": "Runtime Error",                           
              "description": "Error connecting to the back end"     
          }                                                         
      }                                                             
  ```| -   The network is not reachable by the backend.                                   
   -   The connection from the backend has been refused.                               |
| `101504` | ``` java                                                     
      {                                                             
          "fault": {                                                
              "code": "101504",                                     
              "message": "Runtime Error",                           
              "description": "Connection timed out"                 
          }                                                         
      }                                                             
  ```| -   The connection has timed out.                                                  
   -   The connection has timed out from the Microgateway end.                         
   -   Response is getting delayed and hence timeout occurs in the Microgateway side.  |
| 900900                              | ``` java                                                     
      {                                                             
          "fault": {                                                
              "code": 900900,                                       
              "message": "Unclassified Authentication Failure",     
              "description": "Unclassified Authentication Failure"  
          }                                                         
      }                                                             
  ```| -   The Key Manager is down.                                                       |

### Error codes

Given below are some API Manager-specific error codes and their meanings. For more details on error codes and their descriptions, see [Error Handling](https://docs.wso2.com/display/AM260/Error+Handling) .

| Error code                        | Possible reason                                                                                                                                                                                                    |
|-----------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `900901` | The production/sandbox key offered by the requested endpoint is not specified.                                                                                                                                     |
| `900900` | API-M authentication related error.                                                                                                                                                                                |
| `900901` | Invalid access token.                                                                                                                                                                                              |
| `900902` | Missing credentials.                                                                                                                                                                                               |
| `900903` | Access token expired.                                                                                                                                                                                              |
| `900904` | Access token inactive.                                                                                                                                                                                             |
| `900905` | Incorrect access token type provided.                                                                                                                                                                              |
| `900906` | No matching resource found in the API for the given request.                                                                                                                                                       |
| `900907` | The requested API is temporarily blocked.                                                                                                                                                                          |
| `900908` | Resource forbidden.                                                                                                                                                                                                |
| `900909` | The subscription to the API is inactive.                                                                                                                                                                           |
| `900910` | The access token does not allow you to access the requested resource.                                                                                                                                              |
| `900803` | Application level throttled out.                                                                                                                                                                                   |
| `900804` | Subscription level throttled out.                                                                                                                                                                                  |
| `900808` | An internal error occurred in the Microgateway.                                                                                                                                                                    |
| `900809` | An internal error occurred in the Microgateway, since a subscription or application throttle policy is not deployed. This might be due to adding a throttle policy to API-M and not regenerating the Microgateway. |


