# Permission APIs

## Adding a permission string

### Overview

<table>
<tbody>
<tr class="odd">
<th>Description</th>
<td>Adds a new permission string.</td>
</tr>
<tr class="even">
<th>API Context</th>
<td><code>/permissions</code></td>
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
<td>server/tooling</td>
</tr>
</tbody>
</table>

### curl command syntax

```java
curl -X POST https://<HOST_NAME>:<PORT>/permissions/ -H 'content-type: application/json' -d ' { "appName":"<SIDDHI_APPLICATION_NAME>", "permissionString":"<PERMISSION_STRING>"}' -k
```

### Sample curl command

```java
curl -X POST https://localhost:9443/permissions/ -H 'content-type: application/json' -d ' { "appName":"MON", "permissionString":"MON.manager"}' -k
```

### Sample output

Returns the permission ID for the particular permission string

### Response

<table>
<tbody>
<tr class="odd">
<th>HTTP Status Code</th>
<td><p>Possible codes are 200 and 404.</p>
<p>For descriptions of the HTTP status codes, see <a href="https://ei.docs.wso2.com/en/latest/streaming-integrator/ref/hTTP-Status-Codes/">HTTP Status Codes</a> .</p></td>
</tr>
</tbody>
</table>

## Getting a permission ID for a permission string

### Overview

<table>
<tbody>
<tr class="odd">
<th>Description</th>
<td>Returns the permission ID for a given permission string.</td>
</tr>
<tr class="even">
<th>API Context</th>
<td><code>/permissions/app/{appName}</code></td>
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

| Parameter | Description                                       |
|-----------|---------------------------------------------------|
|`{appName}`|                                                   |

### curl command syntax

```java
curl -X GET https://<HOST_NAME>:<PORT>/permissions/app/{appName}
```

### Sample curl command

```java
curl -X GET https://localhost:9443/permissions/app/MON
```

### Sample output

```java
[{"permissionID": "f0c74633-2f07-3896-841a-154afb0c29da","permissionString": "MON.consumer"}]
```

### Response

<table>
<tbody>
<tr class="odd">
<th>HTTP Status Code</th>
<td><p>Possible codes are 200 and 404.</p>
<p>For descriptions of the HTTP status codes, see <a href="https://ei.docs.wso2.com/en/latest/streaming-integrator/ref/hTTP-Status-Codes/">HTTP Status Codes</a> .</p></td>
</tr>
</tbody>
</table>

## Checking whether a specific user role is granted a specific permission

### Overview

<table>
<tbody>
<tr class="odd">
<th>Description</th>
<td>Checks whether the specified user role is granted a specific permission.</td>
</tr>
<tr class="even">
<th>API Context</th>
<td><code>/permissions/auth/{permissionID}/{roleName}</code></td>
</tr>
<tr class="odd">
<th>HTTP Method</th>
<td>GET</td>
</tr>
<tr class="even">
<th>Request/Response format</th>
<td></td>
</tr>
<tr class="odd">
<th>Authentication</th>
<td></td>
</tr>
<tr class="even">
<th>Username</th>
<td></td>
</tr>
<tr class="odd">
<th>Password</th>
<td></td>
</tr>
<tr class="even">
<th>Runtime</th>
<td>server/tooling</td>
</tr>
</tbody>
</table>

| Parameter      | Description                                                                                                  |
|----------------|--------------------------------------------------------------------------------------------------------------|
|`{permissionID}`|The ID of a specific permission. The API checks whether this permission is granted to the specified user role.|
|`{roleName}`    |The ID of a specific user role. The API checks whether this user role is granted the specified permission ID. |

### curl command syntax

```java
curl --location --request GET 'https://<host>:port/permissions/auth/<permission-string-id>/<user>'
```

### Sample curl command

```java
curl --location --request GET 'https://localhost:9443/permissions/auth/f0c74633-2f07-3896-841a-154afb0c29da/admin'
```

### Sample output

```java
{ "code": 4, "type": "ok", "message": "Checking permission for app:f0c74633-2f07-3896-841a-154afb0c29da role: admin successful" }
```

### Response

<table>
<tbody>
<tr class="odd">
<th>HTTP Status Code</th>
<td><p>Possible codes are 200 and 404.</p>
<p>For descriptions of the HTTP status codes, see <a href="https://ei.docs.wso2.com/en/latest/streaming-integrator/ref/hTTP-Status-Codes/">HTTP Status Codes</a> .</p></td>
</tr>
</tbody>
</table>

## Deleting a permission string

### Overview

<table>
<tbody>
<tr class="odd">
<th>Description</th>
<td>Deletes the specified permission string.</td>
</tr>
<tr class="even">
<th>API Context</th>
<td><code>/permissions/{permissionID}</code></td>
</tr>
<tr class="odd">
<th>HTTP Method</th>
<td>DELETE</td>
</tr>
<tr class="even">
<th>Request/Response format</th>
<td></td>
</tr>
<tr class="odd">
<th>Authentication</th>
<td></td>
</tr>
<tr class="even">
<th>Username</th>
<td></td>
</tr>
<tr class="odd">
<th>Password</th>
<td></td>
</tr>
<tr class="even">
<th>Runtime</th>
<td>server/tooling</td>
</tr>
</tbody>
</table>

| Parameter      | Description                                  |
|----------------|----------------------------------------------|
|`{permissionID}`|The ID of the permission string to be deleted.|

### curl command syntax

```java
curl -X DELETE https://<HOST_NAME>:<PORT>/permissions/{permissionID}
```

### Sample curl command

```java
curl -X DELETE https://localhost:9443/permissions/e9687c6f-b5b2-3216-b3bd-82e7a8e14367
```

### Sample output

```
{ 
  "code": 4, 
  "type": "ok", 
  "message": "Deleted permission with ID: f0c74633-2f07-3896-841a-154afb0c29da" 
}
```

### Response

<table>
<tbody>
<tr class="odd">
<th>HTTP Status Code</th>
<td><p>Possible codes are 200 and 404.</p>
<p>For descriptions of the HTTP status codes, see <a href="https://ei.docs.wso2.com/en/latest/streaming-integrator/ref/hTTP-Status-Codes/">HTTP Status Codes</a> .</p></td>
</tr>
</tbody>
</table>

## Listing roles with a specific permission

### Overview

<table>
<tbody>
<tr class="odd">
<th>Description</th>
<td>Lists the user roles that are currently granted the specified user role.</td>
</tr>
<tr class="even">
<th>API Context</th>
<td><code>/permissions/{permissionsID}/roles</code></td>
</tr>
<tr class="odd">
<th>HTTP Method</th>
<td>GET</td>
</tr>
<tr class="even">
<th>Request/Response format</th>
<td></td>
</tr>
<tr class="odd">
<th>Authentication</th>
<td></td>
</tr>
<tr class="even">
<th>Username</th>
<td></td>
</tr>
<tr class="odd">
<th>Password</th>
<td></td>
</tr>
<tr class="even">
<th>Runtime</th>
<td>server/tooling</td>
</tr>
</tbody>
</table>

| Parameter      | Description                                                        |
|----------------|--------------------------------------------------------------------|
|`{permissionID}`|The ID of the permission for which the user roles need to be listed.|

### curl command syntax

```java
curl -X GET https://<HOST_NAME>:<PORT>/permissions/{permissionID}/roles
```

### Sample curl command

```java
curl -X GET https://localhost:9443/permissions/8dc31fec-8364-3082-9f88-c7ca7d979873/roles
```

### Sample output

```java

```

### Response

<table>
<tbody>
<tr class="odd">
<th>HTTP Status Code</th>
<td><p>Possible codes are 200 and 404.</p>
<p>For descriptions of the HTTP status codes, see <a href="https://ei.docs.wso2.com/en/latest/streaming-integrator/ref/hTTP-Status-Codes/">HTTP Status Codes</a> .</p></td>
</tr>
</tbody>
</table>

## Revoking a specific permission for all roles

### Overview

<table>
<tbody>
<tr class="odd">
<th>Description</th>
<td>Revokes the specified permission for all the user roles.</td>
</tr>
<tr class="even">
<th>API Context</th>
<td><code>/permissions/revoke/{permissionID}</code></td>
</tr>
<tr class="odd">
<th>HTTP Method</th>
<td>POST</td>
</tr>
<tr class="even">
<th>Request/Response format</th>
<td></td>
</tr>
<tr class="odd">
<th>Authentication</th>
<td></td>
</tr>
<tr class="even">
<th>Username</th>
<td></td>
</tr>
<tr class="odd">
<th>Password</th>
<td></td>
</tr>
<tr class="even">
<th>Runtime</th>
<td>server/tooling</td>
</tr>
</tbody>
</table>

| Parameter      | Description                                                         |
|----------------|---------------------------------------------------------------------|
|`{permissionID}`|The ID of the permission that needs to be revoked for all user roles.|

### curl command syntax

```java
curl -X POST https://<HOST_NAME>:<PORT>/permissions/revoke/{permissionID}
```

### Sample curl command

```java
curl -X POST https://localhost:9443/permissions/revoke/8dc31fec-8364-3082-9f88-c7ca7d979873
```

### Sample output

```java
{ 
  "code": 4, 
  "type": "ok", 
  "message": "Permission revoke for permissionID e9687c6f-b5b2-3216-b3bd-82e7a8e14367 success." 
}
```

### Response

<table>
<tbody>
<tr class="odd">
<th>HTTP Status Code</th>
<td><p>Possible codes are 200 and 404.</p>
<p>For descriptions of the HTTP status codes, see <a href="https://ei.docs.wso2.com/en/latest/streaming-integrator/ref/hTTP-Status-Codes/">HTTP Status Codes</a> .</p></td>
</tr>
</tbody>
</table>

## Revoking a specific permission for a specific role

### Overview

<table>
<tbody>
<tr class="odd">
<th>Description</th>
<td>Grants or revokes a permission for the specified user role. The permission is passed as an array in the body of the request.</td>
</tr>
<tr class="even">
<th>API Context</th>
<td><code>/permissions/roles/{roleID}?action=revoke/grant</code></td>
</tr>
<tr class="odd">
<th>HTTP Method</th>
<td>POST</td>
</tr>
<tr class="even">
<th>Request/Response format</th>
<td><code>application/json</code></td>
</tr>
<tr class="odd">
<th>Authentication</th>
<td></td>
</tr>
<tr class="even">
<th>Username</th>
<td></td>
</tr>
<tr class="odd">
<th>Password</th>
<td></td>
</tr>
<tr class="even">
<th>Runtime</th>
<td>server/tooling</td>
</tr>
</tbody>
</table>

| Parameter | Description                                                                                              |
|-----------|----------------------------------------------------------------------------------------------------------|
|`{roleID}` |The ID of the user role for which the permission given in the request body needs to be granted or revoked.|

### curl command syntax

```java
curl -X POST 'https://<host>:<port>/permissions/roles/<user>?action=revoke' -H 'content-type: application/json' -d ' { "appName":"<Siddhi-app-name>", "permissionString":"<permission-string>"}' -k
```

### Sample curl command

```java
curl -X POST 'https://localhost:9444/permissions/roles/admin?action=revoke' -H 'content-type: application/json' -d ' { "appName":"MON", "permissionString":"MON.consumer"}' -k
```

### Sample output

```yaml
{
  "code":4,
  "type":"ok",
  "message":"Action, revoke for permission, Permission[appName\u003dMON, permissionString\u003dMON.consumer] successful."
}
```

### Response

<table>
<tbody>
<tr class="odd">
<th>HTTP Status Code</th>
<td><p>Possible codes are 200 and 404.</p>
<p>For descriptions of the HTTP status codes, see <a href="https://ei.docs.wso2.com/en/latest/streaming-integrator/ref/hTTP-Status-Codes/">HTTP Status Codes</a> .</p></td>
</tr>
</tbody>
</table>