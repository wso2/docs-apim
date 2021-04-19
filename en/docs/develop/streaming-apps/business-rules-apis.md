# Business Rules APIs

## Listing the available business rule instances

### Overview

<table>
<tbody>
<tr class="odd">
<th>Description</th>
<td>Returns the list of business rule instances that are currently available.</td>
</tr>
<tr class="even">
<th>API Context</th>
<td><code>/business-rules/instances</code></td>
</tr>
<tr class="odd">
<th>HTTP Method</th>
<td><code>GET</code></td>
</tr>
<tr class="even">
<th>Request/Response Format</th>
<td>application/json</td>
</tr>
<tr class="odd">
<th>Authentication</th>
<td>Basic</td>
</tr>
<tr class="even">
<th>Username</th>
<td><code>admin</code></td>
</tr>
<tr class="odd">
<th>Password</th>
<td><code>admin</code></td>
</tr>
<tr class="even">
<th>Runtime</th>
<td>tooling</td>
</tr>
</tbody>
</table>

### curl command syntax

``` java
curl -X GET "https://<HOST_NAME>:<PORT>/business-rules/instances" -u admin:admin -k
```

### Sample curl command

``` java
curl -X GET "https://localhost:9743/business-rules/instances" -u admin:admin -k
```

### Sample output

``` java
[ "Found Business Rules", "Loaded available business rules", [ [ { "ruleTemplateUUID": "identifying-continuous-production-decrease", "properties": { "timeInterval": "6", "timeRangeInput": "5", "email": "example@email.com", "validateTimeRange": "function validateTimeRange(number) {\n\tif (!isNaN(number) && (number > 0)) {\n\t\treturn number;\n\t} else {\n\t\tthrow 'A positive number expected for time range';\n\t}\n}", "getUsername": "function getUsername(email) {\n\tif (email.match(/\\S+@\\S+/g)) {\n\t\tif (email.match(/\\S+@\\S+/g)[0] === email) {\n\t\t\treturn email.split('@')[0];\n\t\t}\n\t\tthrow 'Invalid email address provided';\n\t}\n\tthrow 'Invalid email address provided';\n}", "timeRange": "5", "username": "example" }, "uuid": "samplesiddhiapp", "name": "SampleSiddhiApp", "templateGroupUUID": "3432442", "type": "template" }, 1 ] ], 0 ]
```

### Response

<table>
<tbody>
<tr class="odd">
<th>HTTP Status Code</th>
<td><p>200 or 404</p>
<p>For descriptions of the HTTP status codes, see <a href="https://ei.docs.wso2.com/en/latest/streaming-integrator/ref/hTTP-Status-Codes/">HTTP Status Codes</a>.</p></td>
</tr>
</tbody>
</table>

## Delete business rule with given UUID

### Overview

<table>
<tbody>
<tr class="odd">
<th>Description</th>
<td>Deletes the business rule with the given UUID. </td>
</tr>
<tr class="even">
<th>API Context</th>
<td><code>/business-rules/instances/{businessRuleInstanceID}?force-delete=false</code></td>
</tr>
<tr class="odd">
<th>HTTP Method</th>
<td><code>DELETE</code></td>
</tr>
<tr class="even">
<th>Request/Response Format</th>
<td>application/json</td>
</tr>
<tr class="odd">
<th>Authentication</th>
<td>Basic</td>
</tr>
<tr class="even">
<th>Username</th>
<td><code>admin</code></td>
</tr>
<tr class="odd">
<th>Password</th>
<td><code>admin</code></td>
</tr>
<tr class="even">
<th>Runtime</th>
<td>tooling</td>
</tr>
</tbody>
</table>

#### Parameter Description

| Parameter                | Description                                                                      |
|--------------------------|----------------------------------------------------------------------------------|
|`{businessRuleInstanceID}`| The UUID (Uniquely Identifiable ID) of the business rules instance to be deleted.|                                                                                     |

### curl command syntax

``` java
curl -X DELETE "https://<HOST_NAME>:<PORT>/business-rules/instances/business-rule-1?force-delete=false" -H "accept: application/json" -u admin:admin
```

### Sample curl command

``` java
curl -X DELETE "https://localhost:9743/business-rules/instances/business-rule-1?force-delete=false" -H "accept: application/json" -u admin:admin
```

### Sample output

``` java
[ "Deletion Successful", "Successfully deleted the business rule", 6 ]
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

## Fetch template group with the given UUID

### Overview

<table>
<tbody>
<tr class="odd">
<th>Description</th>
<td>Returns the template group that has the given UUID.</td>
</tr>
<tr class="even">
<th>API Context</th>
<td><code>/business-rules/template-groups/{templateGroupID}</code></td>
</tr>
<tr class="odd">
<th>HTTP Method</th>
<td><code>GET</code></td>
</tr>
<tr class="even">
<th>Request/Response Format</th>
<td>application/json
</td>
</tr>
<tr class="odd">
<th>Authentication</th>
<td>Basic</td>
</tr>
<tr class="even">
<th>Username</th>
<td><code>admin</code></td>
</tr>
<tr class="odd">
<th>Password</th>
<td><code>admin</code></td>
</tr>
<tr class="even">
<th>Runtime</th>
<td>tooling</td>
</tr>
</tbody>
</table>

#### Parameter description

| Parameter           | Description                                   |
|---------------------|-----------------------------------------------|
| `{templateGroupID}` | The UUID of the template group to be fetched. |

### curl command syntax

``` java
curl -X GET "https://<HOST_NAME>:<PORT>/business-rules/template-groups/{templateGroupID}" -u admin:admin -k
```  

### Sample curl command

``` java
curl -X GET "https://localhost:9743/business-rules/template-groups/sweet-factory" -u admin:admin -k
```

### Sample output

``` java
[ "Found Template Group", "Loaded template group with uuid '3432442'", { "uuid": "3432442", "name": "Sweet Factory", "description": "Configure Sweet Factory Rules", "ruleTemplates": [ { "uuid": "identifying-continuous-production-decrease", "name": "Identify Continuous Production Decrease", "type": "template", "instanceCount": "many", "script": "var timeRange = validateTimeRange(${timeRangeInput});\nvar username = getUsername('${email}');\n\n// Validates the input provided for time range\nfunction validateTimeRange(number) {\n\tif (!isNaN(number) && (number > 0)) {\n\t\treturn number;\n\t} else {\n\t\tthrow 'A positive number expected for time range';\n\t}\n}\n\n// Gets the username from provided email\nfunction getUsername(email) {\n\tif (email.match(/\\S+@\\S+/g)) {\n\t\tif (email.match(/\\S+@\\S+/g)[0] === email) {\n\t\t\treturn email.split('@')[0];\n\t\t}\n\t\tthrow 'Invalid email address provided';\n\t}\n\tthrow 'Invalid email address provided';\n}", "description": "Alert factory managers if rate of production continuously decreases for `X` time period", "templates": [ { "type": "siddhiApp", "content": "@App:name('SweetFactory-TrendAnalysis')\n\n@source(type='http', @map(type='json'))\ndefine stream SweetProductionStream (name string, amount double, factoryId int);\n\n@sink(type='log', @map(type='text', @payload(\"\"\"\nHi ${username},\nProduction at Factory {{factoryId}} has gone\nfrom {{initalamout}} to {{finalAmount}} in ${timeInterval} seconds!\"\"\")))\ndefine stream ContinousProdReductionStream (factoryId int, initaltime long, finalTime long, initalamout double, finalAmount double);\n\nfrom 
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

## Fetch rule template of specific UUID available under a template group with specific UUID

### Overview

<table>
<tbody>
<tr class="odd">
<th>Description</th>
<td>Returns the rule template with the specified UUID that is defined under the template group with the specified UUID.</td>
</tr>
<tr class="even">
<th>API Context</th>
<td><code>/business-rules/template-groups/{templateGroupID}/templates/{ruleTemplateID}</code></td>
</tr>
<tr class="odd">
<th>HTTP Method</th>
<td><code>GET</code></td>
</tr>
<tr class="even">
<th>Request/Response Format</th>
<td>application/json</td>
</tr>
<tr class="odd">
<th>Authentication</th>
<td>Basic</td>
</tr>
<tr class="even">
<th>Username</th>
<td><code>admin</code></td>
</tr>
<tr class="odd">
<th>Password</th>
<td><code>admin</code></td>
</tr>
<tr class="even">
<th>Runtime</th>
<td>Tooling</td>
</tr>
</tbody>
</table>

#### Parameter description

| Parameter          | Description                                                                                  |
|--------------------|----------------------------------------------------------------------------------------------|
| `{templateGroupID}`| The UUID of the template group from which the specified rule template needs to be retrieved. |
| `{ruleTemplateID}` | The UUID of the rule template that needs to be retrieved from the specified template group.  |

### curl command syntax

``` java
curl -X GET "https://localhost:9743/business-rules/template-groups/{templateGroupID}/templates/{ruleTemplateID}" -u admin:admin -k
```

### Sample curl command

``` java
curl -X GET "https://localhost:9643/business-rules/template-groups/sweet-factory/templates/identifying-continuous-production-decrease" -u admin:admin -k
```

### Sample output

``` java
[ "Found Rule Template", "Loaded rule template with uuid 'identifying-continuous-production-decrease'", { "uuid": "identifying-continuous-production-decrease", "name": "Identify Continuous Production Decrease", "type": "template", "instanceCount": "many", "script": "var timeRange = validateTimeRange(${timeRangeInput});\nvar username = getUsername('${email}');\n\n// Validates the input provided for time range\nfunction validateTimeRange(number) {\n\tif (!isNaN(number) && (number > 0)) {\n\t\treturn number;\n\t} else {\n\t\tthrow 'A positive number expected for time range';\n\t}\n}\n\n// Gets the username from provided email\nfunction getUsername(email) {\n\tif (email.match(/\\S+@\\S+/g)) {\n\t\tif (email.match(/\\S+@\\S+/g)[0] === email) {\n\t\t\treturn email.split('@')[0];\n\t\t}\n\t\tthrow 'Invalid email address provided';\n\t}\n\tthrow 'Invalid email address provided';\n}", "description": "Alert factory managers if rate of production continuously decreases for `X` time period", "templates": [ { "type": "siddhiApp", "content": "@App:name('SweetFactory-TrendAnalysis')\n\n@source(type='http', @map(type='json'))\ndefine stream SweetProductionStream (name string, amount double, factoryId int);\n\n@sink(type='log', @map(type='text', @payload(\"\"\"\nHi ${username},\nProduction at Factory {{factoryId}} has gone\nfrom {{initalamout}} to {{finalAmount}} in ${timeInterval} seconds!\"\"\")))\ndefine stream ContinousProdReductionStream (factoryId int, initaltime long, finalTime long, initalamout do
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

## Fetch available template groups

### Overview

<table>
<tbody>
<tr class="odd">
<th>Description</th>
<td>Returns all the template groups that are currently available in the SI setup.</td>
</tr>
<tr class="even">
<th>API Context</th>
<td><code>/business-rules/template-groups</code></td>
</tr>
<tr class="odd">
<th>HTTP Method</th>
<td><code>GET</code></td>
</tr>
<tr class="even">
<th>Request/Response Format</th>
<td>application/json</td>
</tr>
<tr class="odd">
<th>Authentication</th>
<td>Basic</td>
</tr>
<tr class="even">
<th>Username</th>
<td><code>admin</code></td>
</tr>
<tr class="odd">
<th>Password</th>
<td><code>admin</code></td>
</tr>
<tr class="even">
<th>Runtime</th>
<td>Tooling</td>
</tr>
</tbody>
</table>

### curl command syntax

``` java
curl -X GET "https://<HOST_NAME>:<PORT>/business-rules/template-groups" -u admin:admin -k
```

### Sample curl command

``` java
curl -X GET "https://localhost:9743/business-rules/template-groups" -u admin:admin -k
```

### Sample output

``` java
[ "Found Template Groups", "Loaded available template groups", [ { "uuid": "stock-exchange", "name": "Stock Exchange", "description": "Domain for stock exchange analytics", "ruleTemplates": [ { "uuid": "stock-exchange-input", "name": "Stock Exchange Input", "type": "input", "instanceCount": "many", "script": "", "description": "configured http source to receive stock exchange updates", "templates": [ { "type": "siddhiApp", "content": "@App:name('appName1')\n@Source(type = 'http', receiver.url='${receiverUrl}',  basic.auth.enabled='false',\n@map(type='text'))\ndefine stream StockInputStream(symbol string, price float, volume long, name string);", "exposedStreamDefinition": "define stream StockInputStream(symbol string, price float, volume long, name string);" } ], "properties": { "receiverUrl": { "fieldName": "Receiver URL", "description": "Enter the URL of the http receiver for text messages. One URL can only be used once", "defaultValue": "https://localhost:8005/stockInputStream" } } }, { "uuid": "stock-exchange-output", "name": "Stock Exchange Output", "type": "output", "instanceCount": "many", "script": "", "description": "configured output to log the filtered stock exchange data", "templates": [ { "type": "siddhiApp", "content": "@App:name('appName2')\n\ndefine stream StockOutputStream(companyName string, companySymbol string, sellingPrice float);\
```

### Response

<table>
<tbody>
<tr class="odd">
<th>HTTP Status Code</th>
<td><p>200 or 404</p>
<p>For descriptions of the HTTP status codes, see <a href="https://ei.docs.wso2.com/en/latest/streaming-integrator/ref/hTTP-Status-Codes/">HTTP Status Codes</a>.</p></td>
</tr>
</tbody>
</table>

## Fetch business rule instance with given UUID

### Overview

<table>
<tbody>
<tr class="odd">
<th>Description</th>
<td>Returns the business rule instance with the given UUID.</td>
</tr>
<tr class="even">
<th>API Context</th>
<td><code>/business-rules/instances/{businessRuleInstanceID}</code></td>
</tr>
<tr class="odd">
<th>HTTP Method</th>
<td><code>GET</code></td>
</tr>
<tr class="even">
<th>Request/Response Format</th>
<td><code>application/json</code>
</td>
</tr>
<tr class="odd">
<th>Authentication</th>
<td>Basic</td>
</tr>
<tr class="even">
<th>Username</th>
<td><code>admin</code></td>
</tr>
<tr class="odd">
<th>Password</th>
<td><code>admin</code></td>
</tr>
<tr class="even">
<th>Runtime</th>
<td>Tooling</td>
</tr>
</tbody>
</table>


#### Parameter description

| Parameter                  | Description                                            |
|----------------------------|--------------------------------------------------------|
| `{businessRuleInstanceID}` | The UUID of the business rules instance to be fetched. |

### curl command syntax

``` java
curl -X GET "https://<HOST_NAME>:<PORT>/business-rules/instances/{businessRuleInstanceID}" -H "accept: application/json" -u admin:admin -k
```

### Sample curl command

``` java
curl -X GET "https://localhost:9743/business-rules/instances/business-rule-1" -H "accept: application/json" -u admin:admin -k
```

### Sample output

``` java
[ "Found Business Rule", "Loaded business rule with uuid 'sample'", { "ruleTemplateUUID": "identifying-continuous-production-decrease", "properties": { "timeInterval": "6", "timeRangeInput": "5", "email": "example@email.com", "validateTimeRange": "function validateTimeRange(number) {\n\tif (!isNaN(number) && (number > 0)) {\n\t\treturn number;\n\t} else {\n\t\tthrow 'A positive number expected for time range';\n\t}\n}", "getUsername": "function getUsername(email) {\n\tif (email.match(/\\S+@\\S+/g)) {\n\t\tif (email.match(/\\S+@\\S+/g)[0] === email) {\n\t\t\treturn email.split('@')[0];\n\t\t}\n\t\tthrow 'Invalid email address provided';\n\t}\n\tthrow 'Invalid email address provided';\n}", "timeRange": "5", "username": "example" }, "uuid": "sample", "name": "Sample", "templateGroupUUID": "3432442", "type": "template" } ]
```

### Response

<table>
<tbody>
<tr class="odd">
<th>HTTP Status Code</th>
<td><p>200 or 404</p>
<p>For descriptions of the HTTP status codes, see <a href="https://ei.docs.wso2.com/en/latest/streaming-integrator/ref/hTTP-Status-Codes/">HTTP Status Codes</a>.</p></td>
</tr>
</tbody>
</table>

## Create and save a business rule

### Overview

<table>
<tbody>
<tr class="odd">
<th>Description</th>
<td>Creates and saves a business rule.</td>
</tr>
<tr class="even">
<th>API Context</th>
<td><code>/business-rules/instances?deploy={deploymentStatus}</code></td>
</tr>
<tr class="odd">
<th>HTTP Method</th>
<td><code>POST</code></td>
</tr>
<tr class="even">
<th>Request/Response Format</th>
<td><code>application/json</code>
</td>
</tr>
<tr class="odd">
<th>Authentication</th>
<td>Basic</td>
</tr>
<tr class="even">
<th>Username</th>
<td><code>admin</code></td>
</tr>
<tr class="odd">
<th>Password</th>
<td><code>admin</code></td>
</tr>
<tr class="even">
<th>Runtime</th>
<td>Tooling</td>
</tr>
</tbody>
</table>

#### Parameter description

<table>
<thead>
<tr class="header">
<th>Parameter</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>{deploymentStatus}</code></td>
<td><br />
</td>
</tr>
</tbody>
</table>

### curl command syntax

``` java

```

### Sample curl command

``` java
curl -X POST "https://localhost:9743/business-rules/instances?deploy=true" -H "accept: application/json" -H "content-type: multipart/form-data" -F 'businessRule={"name":"Business Rule 5","uuid":"business-rule-5","type":"template","templateGroupUUID":"sweet-factory","ruleTemplateUUID":"identifying-continuous-production-decrease","properties":{"timeInterval":"6","timeRangeInput":"5","email":"example@email.com"}}' -u admin:admin -k
```

### Sample output

``` java
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

## Update business rules instance with given UUID

### Overview

<table>
<tbody>
<tr class="odd">
<th>Description</th>
<td>Updates the business rules instance with the given UUID. </td>
</tr>
<tr class="even">
<th>API Context</th>
<td><code>/business-rules/instances/{businessRuleInstanceID}?deploy={deploymentStatus}</code></td>
</tr>
<tr class="odd">
<th>HTTP Method</th>
<td><code>PUT</code></td>
</tr>
<tr class="even">
<th>Request/Response Format</th>
<td>application/json</td>
</tr>
<tr class="odd">
<th>Authentication</th>
<td>Basic</td>
</tr>
<tr class="even">
<th>Username</th>
<td><code>admin</code></td>
</tr>
<tr class="odd">
<th>Password</th>
<td><code>admin</code></td>
</tr>
<tr class="even">
<th>Runtime</th>
<td>Tooling</td>
</tr>
</tbody>
</table>


#### Parameter description

<table>
<thead>
<tr class="header">
<th>Parameter</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>{businessRuleInstanceID}</code></td>
<td>The UUID of the business rules instance to be updated.</td>
</tr>
<tr class="even">
<td><code>{deploymentStatus}</code></td>
<td><br />
</td>
</tr>
</tbody>
</table>
 
### Sample curl command

``` java
curl -X PUT "https://localhost:9743/business-rules/instances/business-rule-5?deploy=true" -H "accept: application/json" -H "content-type: application/json" -d '{"name":"Business Rule 5","uuid":"business-rule-5","type":"template","templateGroupUUID":"sweet-factory","ruleTemplateUUID":"identifying-continuous-production-decrease","properties":{"timeInterval":"9","timeRangeInput":"8","email":"newexample@email.com"}}' -u admin:admin -k
```

### Response

<table>
<tbody>
<tr class="odd">
<th>HTTP Status Code</th>
<td><p>200 or 404</p>
<p>For descriptions of the HTTP status codes, see <a href="https://ei.docs.wso2.com/en/latest/streaming-integrator/ref/hTTP-Status-Codes/">HTTP Status Codes</a>.</p></td>
</tr>
</tbody>
</table>
