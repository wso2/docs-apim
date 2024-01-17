# Using the Management API

The Management API of the Micro Integrator is an internal REST API, which was introduced to substitute
the **admin services** that were available in WSO2 EI 6.x.x.

The [Micro Integrator dashboard]({{base_path}}/observe/mi-observe/working-with-monitoring-dashboard) communicates with this service to
obtain administrative information of the server instance and to perform various administration tasks. If you are not using the dashboard, you can directly access the [resources](#accessing-api-resources) of the management API by following the instructions given below.

## Securely invoking the API
The management API is secured using JWT authentication by default. Therefore, when you directly access the management API, you must first acquire a JWT token with your valid username and password.

!!! Tip
    See [Securing the Management API]({{base_path}}/install-and-setup/setup/mi-setup/security/securing_management_api) for information on configuring **users**, **JWT authentication**, and other security options for the management API.

### Getting a JWT token

Follow the steps given below to acquire the JWT token.

1.	First, encode your username:password in Basic Auth format (encoded in base64). For example, use the default `admin:admin` credentials.
2.	Invoke the `/login` resource of the API with your encoded credentials as shown below.
  	```bash
  	curl -X GET "https://localhost:9164/management/login" -H "accept: application/json" -H "Authorization: Basic YWRtaW46YWRtaW4=" -k -i
  	```
3.	The API will validate the authorization header and provide a response with the JWT token as follows:
  	```json
  	{
  	   "AccessToken":"%AccessToken%"
  	}
  	```

### Invoking an API resource

You can now use this token when you invoke a [resource](#accessing-api-resources).

!!! Info
     When the default JWT security handler is engaged, all the management API resources except `/login` are protected by JWT auth. Therefore, it is necessary to send the token as a bearer token when invoking the API resources.

```bash
curl -X GET "https://localhost:9164/management/inbound-endpoints" -H "accept: application/json" -H "Authorization: Bearer %AccessToken%”
```

### Log out from management API

Invoke the `/logout` resource to revoke the JWT token you used for [invoking the API resource](#invoking-an-api-resource).

```bash
curl -X GET "https://localhost:9164/management/logout" -H "accept: application/json" -H "Authorization: Bearer TOKEN" -k -i
```

## Accessing API resources

The management API has multiple resources to provide information regarding the deployed artifacts as well as the server itself.

### GET USERS

-	**Resource**: `/users`

	**Description**: Retrieves a list of all users stored in an [external user store]({{base_path}}/install-and-setup/setup/mi-setup/user_stores/setting_up_a_userstore).

	**Example**:

  	```bash tab='Request'
  	curl -X GET "https://localhost:9164/management/users?pattern=”*us*”&role=”role”" -H "accept: application/json" -H "Authorization: Bearer %AccessToken%" -k -i
  	```

    ```bash tab='Response'
    {
    	count:2
    	list:
    	[
    		userId: user1,
    		userId: user2,
    		userId: user3,
    	]
    }
    ```

	??? note "Search for a user by name"
		You can also search for a user by name. To do that, use the following example cURL command.

		```bash tab='Request'
		curl -X GET "https://localhost:9164/management/users?searchKey=read-only" -H "accept: application/json" -H "Authorization: Bearer $AccessToken" -k -i

		```

		```base tab='Response'
		{
			"count": 1,
			"list": [{
				"userId": "read-only-user"
			}]
		}
		```

-	**Resource**: `/users/{user_id}`

	**Description**: Retrieves information related to a specified user stored in the [external user store]({{base_path}}/install-and-setup/setup/mi-setup/user_stores/setting_up_a_userstore).

	**Example**:

  	```bash tab='Request'
  	curl -X GET "https://localhost:9164/management/users/user1?domain=wso2.com" -H "accept: application/json" -H "Authorization: Bearer %AccessToken%" -k -i
  	```

    ```bash tab='Response'
    {
      userid: "WSO2.COM/user1",
      isAdmin: true/false,
      roles :
      [
          "WSO2.COM/role1",
          "role2",
      ]
    }
    ```

	!!! note
		When fetching users from the primary user store, the `domain` query parameter can be ignored or set as `primary`.

-	**Resource**: `/users/pattern=”*”&role=admin`

	**Description**: Retrieves information related to user names (stored in an [external user store]({{base_path}}/install-and-setup/setup/mi-setup/user_stores/setting_up_a_userstore) that match a specific pattern and user role.

	**Example**:

  	```bash tab='Request'
  	curl -X GET "https://localhost:9164/management/users?pattern=”*us*”&role=”role”" -H "accept: application/json" -H "Authorization: Bearer %AccessToken%" -k -i
  	```

    ```bash tab='Response'
    {
    	count:2
    	list:
    	[
    		userId: user1,
    		userId: user2,
    		userId: user3,
    	]
    }
    ```

### ADD USERS

-	**Resource**: `/users`

	**Description**: Adds a user to the [external user store]({{base_path}}/install-and-setup/setup/mi-setup/user_stores/setting_up_a_userstore). Note that only admin users can create other users with admin access.

	**Example**:

    First create the following JSON file with user details as shown below. Note that this new user is granted the admin role.

    ```json
    {
     "userId":"user4",
     "password":"pwd1",
     "isAdmin":"false",
     "domain":"wso2.com"
    }
    ```

	!!! note
		When adding users to the primary user store, the `domain` can be ignored or set as `primary`.

		We cannot add admin users to the secondary user stores. 

    Execute the following request and receive the response:

  	```bash tab='Request'
  	curl -X POST -d @user "https://localhost:9164/management/users" -H "accept: application/json" -H "Content-Type: application/json" -H "Authorization: Bearer %AccessToken% " -k -i
  	```

  	```bash tab='Response'
    {
      "userId":"user4",
      “status”:added
    }
  	```

### REMOVE USERS

-	**Resource**: `/users`

	**Description**: Removes a user from the [external user store]({{base_path}}/install-and-setup/setup/mi-setup/user_stores/setting_up_a_userstore). Note that only admin users can remove other users with admin access.

	**Example**:

    The following request deletes the `user1` from the user store:

  	```bash tab='Request'
  	curl -X DELETE "https://localhost:9164/management/users/user1" -H "accept: application/json" -H "Authorization: Bearer %AccessToken%" -k -i
  	```

  	```bash tab='Response'
    {
      "userId":"user1",
      “status”:deleted
    }
  	```

	**Example**:

    The following request deletes `user1` from the secondary user store: 

  	```bash tab='Request'
  	curl -X DELETE "https://localhost:9164/management/users/user1?domain=wso2.com" -H "accept: application/json" -H "Authorization: Bearer %AccessToken%" -k -i
  	```

  	```bash tab='Response'
    {
      "userId":"user1",
      “status”:deleted
    }
  	```

### UPDATE USERS

-	**Resource**: `/users`

	**Description**: Update the password of a user from the [external user store]({{base_path}}/install-and-setup/setup/mi-setup/user_stores/setting_up_a_userstore). Note that only super admin user can remove other users with admin access. Any user with admin access can update the own password and the passwords of non-admin users.

	**Example**:

	First create the following JSON file with user details as shown below. Here we are changing the password of user1.

    ```json
    {
     "newPassword": "user111",
     "confirmPassword": "user111",
     "oldPassword": "user1"
    }
    ```

    The following request update the password of the `user1` from the user store:

  	```bash tab='Request'
  	curl -X PATCH -d @user "https://localhost:9164/management/users/user1" -H "accept: application/json" -H "Authorization: Bearer %AccessToken%" -k
  	```

  	```bash tab='Response'
    {
	  "userId":"user1",
      "status":"Password updated"
    }
  	```

### GET Roles

-	**Resource**: `/roles`

	**Description**: Retrieves a list of all roles stored in an [external user store]({{base_path}}/install-and-setup/setup/mi-setup/user_stores/setting_up_a_userstore).

	**Example**:

  	```bash tab='Request'
  	curl -X GET "https://localhost:9164/management/roles" -H "accept: application/json" -H "Authorization: Bearer %AccessToken%" -k -i
  	```

    ```bash tab='Response'
    {
    	count:3
    	list:
    	[
    		{"role": "admin"},
    		{"role": "Internal/everyone"},
			{"role": "WSO2.COM/wso2Role"}
    	]
    }
    ```

	??? note "Search for a role by name"
		You can also search for a role by name. To do that, use the following example cURL command.

		```bash tab='Request'
		curl -X GET "https://localhost:9164/management/roles?searchKey=admin" -H "accept: application/json" -H "Authorization: Bearer $AccessToken" -k -i

		```

		```base tab='Response'
		{
			"count": 2,
			"list": [{
				"role": "admin"
			}, {
				"role": "super-admin"
			}]
		}
		```

-	**Resource**: `/roles/{role_name}`

	**Description**: Retrieves information related to a specified role stored in the [external user store]({{base_path}}/install-and-setup/setup/mi-setup/user_stores/setting_up_a_userstore).

	**Example**:

  	```bash tab='Request'
  	curl -X GET "https://localhost:9164/management/roles/wso2role?domain=wso2.com" -H "accept: application/json" -H "Authorization: Bearer %AccessToken%" -k -i
  	```

    ```bash tab='Response'
    {
      role: "WSO2.COM/wso2role",
      users :
      [
          "WSO2.COM/wso2User1",
          "user2",
      ]
    }
    ```

	!!! note
		When fetching roles from the primary user store, the `domain` query parameter can be ignored or set as `primary`.
		
		When fetching hybrid roles, the `domain` query parameter should be set as `Internal` or `Application` accordingly.

### ADD ROLES

-	**Resource**: `/roles`

	**Description**: Adds a role to the [external user store]({{base_path}}/install-and-setup/setup/mi-setup/user_stores/setting_up_a_userstore).

	**Example**:

    First create the following JSON file with role details as shown below.

    ```json
    {
		"role" : "wso2role",
		"domain" : "wso2.com"
	}
    ```

	!!! note
		When adding roles to the primary user store, the `domain` can be ignored or set as `primary`.

        When adding a hybrid role, respective hybrid domain (Internal/Application) should be added to the role name Ex: Internal/internalRole 

    Execute the following request and receive the response:

  	```bash tab='Request'
  	curl -X POST -d @role "https://localhost:9164/management/roles" -H "accept: application/json" -H "Content-Type: application/json" -H "Authorization: Bearer %AccessToken% " -k -i
  	```

  	```bash tab='Response'
	{
		"role": "wso2role",
		"status": "Added"
	}
  	```

### REMOVE Roles

-	**Resource**: `/users`

	**Description**: Removes a role from the [external user store]({{base_path}}/install-and-setup/setup/mi-setup/user_stores/setting_up_a_userstore). 

	**Example**:

    The following request deletes the `wso2role` from the user store:

  	```bash tab='Request'
  	curl -X DELETE "https://localhost:9164/management/roles/wso2role?domain=wso2.com" -H "accept: application/json" -H "Authorization: Bearer %AccessToken%" -k -i
  	```

  	```bash tab='Response'
	{
		"role": "wso2role",
		"status": "Deleted"
	}
  	```

	!!! note
		When deleting roles from the primary user store, the `domain` can be ignored or set as `primary`.

### ASSIGN / REVOKE Roles

-	**Resource**: `/roles`

	**Description**: Assign/remove set of roles to/from a given user in the [external user store]({{base_path}}/install-and-setup/setup/mi-setup/user_stores/setting_up_a_userstore). 

	**Example**:

    First create the following JSON file with role details as shown below.

    ```json
    {
    	"userId" : "wso2user",
    	"addedRoles" :["Internal/internalRole", "Application/applicationRole"],
    	"removedRoles":["wso2role"],
    	"domain" : "wso2.com"
	}
    ```

	!!! note
		When the user belongs to the primary user store, `domain` can be ignored or set as `primary`.

        Users in secondary user stores can have roles from that user store and hybrid roles only.

		Users in secondary user stores cannot have the admin role.

    Execute the following request and receive the response:

  	```bash tab='Request'
  	curl -X PUT -d @user "https://localhost:9164/management/roles" -H "accept: application/json" -H "Content-Type: application/json" -H "Authorization: Bearer %AccessToken% " -k -i
  	```

  	```bash tab='Response'
	{
		"userId": "wso2user",
		"status": "Added/removed the roles"
	}

  	```
### GET PROXY SERVICES

-	**Resource**: `/proxy-services`

	**Description**: Retrieves a list of all deployed proxy services.

	**Example**:

	```bash tab='Request'
	curl -X GET "https://localhost:9164/management/proxy-services" -H "accept: application/json" -H "Authorization: Bearer TOKEN" -k -i
	```


	```bash tab='Response'
	{
	  "count": 1,
	  "list": [
	    {
	      "name": "TestProxy",
	      "wsdl1_1": "http://ThinkPad-X1-Carbon-3rd:8290/services/TestProxy?wsdl",
	      "wsdl2_0": "http://ThinkPad-X1-Carbon-3rd:8290/services/TestProxy?wsdl2"
	    }
	  ]
	}
	```

	??? note "Search for a proxy by name"
		You can also search for a proxy by name. To do that, use the following example cURL command.

		```bash tab='Request'
		curl -X GET "https://localhost:9164/management/proxy-services?searchKey=hello" -H "accept: application/json" -H "Authorization: Bearer $AccessToken" -k -i
		```

		```base tab='Response'
		{
			"count": 1,
			"list": [{
				"name": "HelloProxyService",
				"wsdl1_1": "http://localhost:8285/services/HelloProxyService?wsdl",
				"wsdl2_0": "http://localhost:8285/services/HelloProxyService?wsdl2"
				}]
		}
		```



-	**Resource**: `/proxy-services?proxyServiceName={proxyName}`

	**Description**: Retrieves information related to a specified proxy.

	**Example**:
	```bash
	curl -X GET "https://localhost:9164/management/proxy-services?proxyServiceName=helloProxy" -H "accept: application/json" -H "Authorization: Bearer TOKEN" -k -i
	```

### ACTIVATE/DEACTIVATE PROXY SERVICES

-	**Resource**: `/proxy-services`

	**Description**: Activate and Deactivate a specified proxy service.

	**Example**:

	```bash tab='Request'
		curl -X POST \
    	  https://localhost:9164/management/proxy-services \
    	  -H 'authorization: Bearer TOKEN
    	  -H 'content-type: application/json' \
    	  -d '{
    		"name": "HelloWorld",
    		"status": "inactive"
    	}' -k -i
	```


	```bash tab='Response'
    {"Message":"Proxy service HelloWorld stopped successfully"}
	```
	
### ENABLE/DISABLE MESSAGE TRACING for PROXY SERVICES

-	**Resource**: `/proxy-services`

	**Description**: Enable or disable message tracing for a specified proxy service.

	**Example**:

	```bash tab='Request'
		curl -X POST \
    	  https://localhost:9164/management/proxy-services \
    	  -H 'authorization: Bearer TOKEN' \
    	  -H 'content-type: application/json' \
    	  -d '{
    		"name": "HelloWorld",
    		"trace": "enable"
    	}' -k -i
	```

	```bash tab='Response'
    {"message":"Enabled tracing for ('HelloWorld')"}
	```

### GET CARBON APPLICATIONS

-	**Resource**: `/applications`

	**Description**: This operation provides you a list of available active and faulty Applications.

	**Example**:

	```bash tab='Request'
	curl -X GET "https://localhost:9164/management/applications" -H "accept: application/json" -H "Authorization: Bearer TOKEN" -k -i
	```

	```bash tab='Response'
	{
	  "totalCount": 2,
	  "activeCount": 1,
	  "faultyCount": 1,
	  "activeList": [
	    {
	      "name": "SampleServicesCompositeApplication",
	      "version": "1.0.0"
	    }
	  ],
	  "faultyList": [
	    {
	      "name": "FaultyCAppCompositeExporter",
	      "version": "1.0.0"
	    }
	  ]
	}
	```

	??? note "Search for a Carbon Application by name"
		You can also search for a Carbon Application by name. To do that, use the following example cURL command.

		```bash tab='Request'
		curl -X GET "https://localhost:9164/management/applications?searchKey=hello" -H "accept: application/json" -H "Authorization: Bearer $AccessToken" -k -i

		```

		```base tab='Response'
		{
			"count": 1,
			"list": [{
				"name": "helloartifactsPackComposite",
				"version": "1.0.0-SNAPSHOT",
				"artifacts": [{
					"name": "HelloLocalEntry",
					"type": "local-entry"
				}, {
					"name": "HelloLocalEntry",
					"type": "local-entry"
				}, {
					"name": "CSV-connector",
					"type": "lib"
				}, {
					"name": "HelloMessageStore",
					"type": "message-store"
				}, {
					"name": "HelloMessageStore",
					"type": "message-store"
				}, {
					"name": "AbcRestApi",
					"type": "api"
				}, {
					"name": "HelloRestApi",
					"type": "api"
				}, {
					"name": "AbcEndPoint",
					"type": "endpoint"
				}, {
					"name": "HelloEndPoint",
					"type": "endpoint"
				}, {
					"name": "AbcSequence",
					"type": "sequence"
				}, {
					"name": "AbcMessageProcessor",
					"type": "message-processors"
				}, {
					"name": "HelloMessageProcessor",
					"type": "message-processors"
				}, {
					"name": "AbcTemplate",
					"type": "template"
				}, {
					"name": "AbcDataService",
					"type": "dataservice"
				}, {
					"name": "HelloDataService",
					"type": "dataservice"
				}, {
					"name": "AbcProxyService",
					"type": "proxy-service"
				}, {
					"name": "HelloProxyService",
					"type": "proxy-service"
				}, {
					"name": "HttpListenerEP1",
					"type": "inbound-endpoint"
				}, {
					"name": "AbcScheduledTask",
					"type": "task"
				}]
			}]
		}
		```

-	**Resource**: `/applications?carbonAppName={appname}`

	**Description**: Retrieves information related to a specified carbon application.

	**Example**:
	```
	curl -X GET "https://localhost:9164/management/applications?carbonAppName=HelloCApp" -H "accept: application/json" -H "Authorization: Bearer TOKEN" -k -i
	```

### DOWNLOAD CARBON APPLICATION

-	**Resource**: `/applications`

	**Description**: Download a carbon application.

    **Example**:
    
  	```bash
		wget \
    	  https://localhost:9164/management/applications?carbonAppName=myHttpServiceCompositeExporter_1.0.0.car \
    	  -O myHttpServiceCompositeExporter_1.0.0.car \
    	  --header 'Authorization: Bearer TOKEN' \
    	  --header 'accept: application/octet-stream' \
    	  --no-check-certificate -i
	```

### GET ENDPOINTS

-	**Resource**: `/endpoints`

	**Description**:  Retrieves a list of available endpoints.

	**Example**:

	```bash tab='Request'
	curl -X GET "https://localhost:9164/management/endpoints" -H "accept: application/json" -H "Authorization: Bearer TOKEN" -k -i
	```

	```bash tab='Response'
	{
	    "count": 2,
	    "list": [
		{
		    "name": "FailOver_EP",
		    "type": "failover"
		},
		{
		    "name": "WSDL_EP",
		    "type": "wsdl"
		}
	    ]
	}
	```

	??? note "Search for an endpoint by name"
		You can also search for an endpoint by name. To do that, use the following example cURL command.

		```bash tab='Request'
		curl -X GET "https://localhost:9164/management/endpoints?searchKey=hello" -H "accept: application/json" -H "Authorization: Bearer $AccessToken" -k -i
		```

		```base tab='Response'
		{
			"count": 1,
			"list": [{
				"name": "HelloEndPoint",
				"type": "http",
				"isActive": true
			}]
		}

		```	

-	**Resource**: `/endpoints?endpointName={endpointname}`

	**Description**: Retrieves information related to a specified endpoint.


### ACTIVATE/DEACTIVATE ENDPOINTS

-	**Resource**: `/endpoints`

	**Description**: Activate or deactivate a specified endpoint.

	**Example**:

	```bash tab='Request'
	curl -X POST \https://localhost:9164/management/endpoints \ -H 'authorization: Bearer TOKEN -H 'content-type: application/json' \ -d '{"name": "HTTPEP", "status": "inactive"} -k -i
	```

	```bash tab='Response'
	{"Message":"HTTPEP : is switched Off"}
	```

### ENABLE/DISABLE MESSAGE TRACING for ENDPOINTS

-	**Resource**: `/endpoints`

	**Description**: Enable or disable message tracing for a specified endpoint.

	**Example**:
	
    ```bash tab='Request'
		curl -X POST \
    	  https://localhost:9164/management/endpoints \
    	  -H 'authorization: Bearer TOKEN' \
    	  -H 'content-type: application/json' \
    	  -d '{
    		"name": "HTTPEP",
    		"trace": "enable"
    	}' -k -i
	```

	```bash tab='Response'
    {"message":"Enabled tracing for ('HTTPEP')"}
	```
	
### GET APIs

-	**Resource**: `/apis`

	**Description**: Retrieves a list of available APIs.

	**Example**:

	```bash tab='Request'
	curl -X GET "https://localhost:9164/management/apis" -H "accept: application/json" -H "Authorization: Bearer TOKEN" -k -i
	```

	```bash tab='Response'
	{
	    "count": 2,
	    "list": [
		{
		    "name": "api",
		    "url": "http://localhost:8290/test"
		},
		{
		    "name": "helloApi",
		    "url": "http://localhost:8290/api"
		}
	    ]
	}
	```

	??? note "Search for an API by name"
		You can also search for an API by name. To do that, use the following example cURL command.

		```bash tab='Request'
		curl -X GET "https://localhost:9164/management/apis?searchKey=hello" -H "accept: application/json" -H "Authorization: Bearer $AccessToken" -k -i

		```

		```base tab='Response'
		{
			"count": 1,
			"list": [{
				"tracing": "disabled",
				"name": "HelloRestApi",
				"url": "http://localhost:8285/hellorest"
			}]
		}

		```	

-	**Resource**: `/apis?apiName={api}`

	**Description**: Retrieves information related to a specified API.

### ENABLE/DISABLE MESSAGING TRACING for APIs

-	**Resource**: `/apis`

	**Description**: Enable or disable message tracing for a specified API.

	**Example**:

    ```bash tab='Request'
		curl -X POST \
    	  https://localhost:9164/management/apis \
    	  -H 'authorization: Bearer TOKEN' \
    	  -H 'content-type: application/json' \
    	  -d '{
    		"name": "helloApi",
    		"trace": "enable"
    	}' -k -i
	```

	```bash tab='Response'
    {"message":"Enabled tracing for ('helloApi')"}
	```
	
### GET SEQUENCES

-	**Resource**: `/sequences`

	**Description**: Retrieves a list of available sequences.

	**Example**:

	```bash tab='Request'
	curl -X GET "https://localhost:9164/management/sequences" -H "accept: application/json" -H "Authorization: Bearer TOKEN" -k -i
	```

	```bash tab='Response'
	{
	    "count": 3,
	    "list": [
		{
		    "tracing": "disabled",
		    "stats": "disabled",
		    "name": "fault"
		},
		{
		    "container": "[ Deployed From Artifact Container: helloCompositeApplication ] ",
		    "tracing": "disabled",
		    "stats": "disabled",
		    "name": "sequenceForSampler"
		},
		{
		    "tracing": "disabled",
		    "stats": "disabled",
		    "name": "main"
		}
	    ]
	}
	```

	??? note "Search for a Sequence by name"
		You can also search for a Sequence by name. To do that, use the following example cURL command.

		```bash tab='Request'
		curl -X GET "https://localhost:9164/management/sequences?searchKey=hello" -H "accept: application/json" -H "Authorization: Bearer $AccessToken" -k -i

		```

		```base tab='Response'
		{
			"count": 2,
			"list": [{
				"tracing": "disabled",
				"stats": "disabled",
				"name": "Hello"
			}, {
				"tracing": "disabled",
				"stats": "disabled",
				"name": "helloworld"
			}]

		}

		```

-	**Resource**: `/sequences?sequenceName={sequence}`

	**Description**: Retrieves information related to a specified sequence.


### ENABLE/DISABLE MESSAGE TRACING for SEQUENCES

-	**Resource**: `/sequences`

	**Description**: Enable or disable message tracing for a specified sequence.

	**Example**:

    ```bash tab='Request'
		curl -X POST \
    	  https://localhost:9164/management/sequences \
    	  -H 'authorization: Bearer TOKEN' \
    	  -H 'content-type: application/json' \
    	  -d '{
    		"name": "helloSequence",
    		"trace": "enable"
    	}' -k -i
	```

	```bash tab='Response'
    {"message":"Enabled tracing for ('helloSequence')"}
	```
	
### GET LOCAL ENTRIES

-	**Resource**: `/local-entries`

	**Description**: Retrieves a list of available local entries.

	**Example**:

	```bash tab='Request'
	curl -X GET "https://localhost:9164/management/local-entries" -H "accept: application/json" -H "Authorization: Bearer TOKEN" -k -i
	```

	```bash tab='Response'
	{
	    "count": 2,
	    "list": [
		{
		    "name": "testEntry1",
		    "type": "Inline Text"
		},
		{
		    "name": "testentry2",
		    "type": "Inline XML"
		}
	    ]
	}
	```

	??? note "Search for a Local Entry by name"
		You can also search for a Local Entry by name. To do that, use the following example cURL command.

		```bash tab='Request'
		curl -X GET "https://localhost:9164/management/local-entries?searchKey=hello" -H "accept: application/json" -H "Authorization: Bearer $AccessToken" -k -i

		```

		```base tab='Response'
		{
			"count": 2,
			"list": [{
				"name": "HelloLocalEntry",
				"type": "Inline Text",
				"value": "0.1"
			}, {
				"name": "helloSERVER"
				"type": "Inline Text",
				"value": "0.5"
			}]
		}

		```

-	**Resource**: `/local-entries?name={entryName}`

	**Description**: Retrieves information related to a specified entry.

### GET TASKS

-	**Resource**: `/tasks`

	**Description**: Retrieves a list of available tasks.

	**Example**:

	```bash tab='Request'
	curl -X GET "https://localhost:9164/management/tasks" -H "accept: application/json" -H "Authorization: Bearer TOKEN" -k -i
	```

	```bash tab='Response'
	{
	    "count": 1,
	    "list": [
		{
		    "name": "testTask"
		}
	    ]
	}
	```

	??? note "Search for a Task by name"
		You can also search for a Task by name. To do that, use the following example cURL command.

		```bash tab='Request'
		curl -X GET "https://localhost:9164/management/tasks?searchKey=hello" -H "accept: application/json" -H "Authorization: Bearer $AccessToken" -k -i

		```

		```base tab='Response'
		{
			"count": 1,
			"list": [{
				"name": "HelloScheduledTask"
			}]
		}

		```

-	**Resource**: `/tasks?taskName={taskName}`

	**Description**: Retrieves information related to a specified task.

### GET MESSAGE STORES

-	**Resource**: `/message-stores`

	**Description**: Retrieves a list of available message stores.

	**Example**:

	```bash tab='Request'
	curl -X GET "https://localhost:9164/management/message-stores" -H "accept: application/json" -H "Authorization: Bearer TOKEN" -k -i
	```

	```bash tab='Response'
	{
	    "count": 2,
	    "list": [
		{
		    "size": 0,
		    "name": "testMessageStore",
		    "type": "in-memory-message-store"
		},
		{
		    "size": 0,
		    "name": "jdbc_sample_store",
		    "type": "jdbc-message-store"
		}
	    ]
	}
	```

	??? note "Search for a Message Store by name"
		You can also search for a Message Store by name. To do that, use the following example cURL command.

		```bash tab='Request'
		curl -X GET "https://localhost:9164/management/message-stores?searchKey=hello" -H "accept: application/json" -H "Authorization: Bearer $AccessToken" -k -i

		```

		```base tab='Response'
		{
			"count": 1,
			"list": [{
				"size": 0,
				"name": "HelloMessageStore",
				"type": "in-memory-message-store"
			}]

		}

		```

-	**Resource**: `/message-stores?name={messageStore}`

	**Description**: Retrieves information related to a specified message store.

### GET MESSAGE PROCESSORS   

-	**Resource**: `/message-processors`

	**Description**: Retrieves a list of available message processors.

	**Example**:

	```bash tab='Request'
	curl -X GET "https://localhost:9164/management/message-processors" -H "accept: application/json" -H "Authorization: Bearer TOKEN" -k -i
	```

	```bash tab='Response'
	{
	    "count": 2,
	    "list": [
		{
		    "name": "testMessageProcessor",
		    "type": "Scheduled-message-forwarding-processor",
		    "status": "active"
		},
		{
		    "name": "TestSamplingProcessor",
		    "type": "Sampling-processor",
		    "status": "active"
		}
	    ]
	}
	```

	??? note "Search for a Message Processor by name"
		You can also search for a Message Processor by name. To do that, use the following example cURL command.

		```bash tab='Request'
		curl -X GET "https://localhost:9164/management/message-processors?searchKey=hello" -H "accept: application/json" -H "Authorization: Bearer $AccessToken" -k -i

		```

		```base tab='Response'
		{
			"count": 1,
			"list": [{
				"name": "HelloMessageProcessor",
				"type": "Scheduled-message-forwarding-processor",
				"status": "active"
			}]
		}

		```

-	**Resource**: `/message-processors?name={messageProcessors}`

	**Description**: Retrieves information related to a specified message processor.

### ACTIVATE/DEACTIVATE MESSAGE PROCESSORS

-	**Resource**: `/message-processors`

	**Description**: Used to activate or deactivate a specific message processor.

	**Example**:

	```bash
	curl -X POST \
	  https://localhost:9164/management/message-processors \
	  -H 'authorization: Bearer Token
	  -H 'content-type: application/json' \
	  -d '{
		"name": "testMessageProcessor",
		"status": "inactive"
	}'
	```

### GET INBOUND ENDPOINTS

-	**Resource**: `/inbound-endpoints`

	**Description**: Retrieves a list of available inbound endpoints.

	**Example**:

	```bash tab='Request'
	curl -X GET "https://localhost:9164/management/inbound-endpoints" -H "accept: application/json" -H "Authorization: Bearer TOKEN" -k -i
	```

	```bash tab='Response'
	{
	    "count": 1,
	    "list": [
		{
		    "protocol": "http",
		    "name": "HTTPIEP"
		}
	    ]
	}
	```

	??? note "Search for an Inbound Endpoint by name"
		You can also search for an Inbound Endpoint by name. To do that, use the following example cURL command.

		```bash tab='Request'
		curl -X GET "https://localhost:9164/management/inbound-endpoints?searchKey=hello" -H "accept: application/json" -H "Authorization: Bearer $AccessToken" -k -i

		```

		```base tab='Response'
		{
			"count": 1,
		    "list": [
    		{
        		"protocol": "http",
        		"name": "HelloHTTPIEP"
    		}
    		]
		}

		```

-	**Resource**: `/inbound-endpoints?inboundEndpointName={inboundEndpoint}`

	**Description**: Retrieves information related to a specified inbound endpoint.

### ENABLE/DISABLE MESSAGE TRACING for INBOUND ENDPOINTS

-	**Resource**: `/inbound-endpoints`

	**Description**: Enable or disable message tracing for a specified inbound-endpoint.

	**Example**:

    ```bash tab='Request'
		curl -X POST \
    	  https://localhost:9164/management/inbound-endpoints \
    	  -H 'authorization: Bearer TOKEN' \
    	  -H 'content-type: application/json' \
    	  -d '{
    		"name": "HTTPIEP",
    		"trace": "enable"
    	}' -k -i
	```

	```bash tab='Response'
    {"message":"Enabled tracing for ('HTTPIEP')"}
	```
	
### GET CONNECTORS

-	**Resource**: `/connectors`

	**Description**: Retrieves a list of available connectors.

	**Example**:

	```bash tab='Request'
	curl -X GET "https://localhost:9164/management/connectors" -H "accept: application/json" -H "Authorization: Bearer TOKEN" -k -i
	```

	```bash tab='Response'
	{
	    "count": 2,
	    "list": [
		{
		    "package": "org.wso2.carbon.connector",
		    "name": "fileconnector",
		    "description": "wso2 file connector",
		    "status": "enabled"
		},
		{
		    "package": "org.wso2.carbon.connector",
		    "name": "gmail",
		    "description": "WSO2 Gmail connector library",
		    "status": "enabled"
		}
	    ]
	}
	```

	??? note "Search for a Connector by name"
		You can also search for a Connector by name. To do that, use the following example cURL command.

		```bash tab='Request'
		curl -X GET "https://localhost:9164/management/connectors?searchKey=csv" -H "accept: application/json" -H "Authorization: Bearer $AccessToken" -k -i

		```

		```base tab='Response'
		{
			"count": 1,
			"list": [{
				"package": "org.wso2.carbon.module.csv",
				"name": "CSV",
				"description": "WSO2 CSV Module",
				"status": "enabled"
			}]
		}

		```

### GET TEMPLATES

-	**Resource**: `/templates`

	**Description**: Retrieves a list of available templates.

	**Example**:

	```bash tab='Request'
	curl -X GET "https://localhost:9164/management/templates" -H "accept: application/json" -H "Authorization: Bearer TOKEN" -k -i
	```

	```bash tab='Response'
	{
	    "sequenceTemplateList": [
		{
		    "name": "testSequenceTemplate"
		}
	    ],
	    "endpointTemplateList": [
		{
		    "name": "endpointTemplate"
		}
	    ]
	}
	```

	??? note "Search for a Template by name"
		You can also search for a Template by name. To do that, use the following example cURL command.

		```bash tab='Request'
		curl -X GET "https://localhost:9164/management/templates?searchKey=hello" -H "accept: application/json" -H "Authorization: Bearer $AccessToken" -k -i

		```

		```base tab='Response'
		{
			"count": 1,
			"list": [{
				"Parameters": [{
					"defaultValue": "",
					"name": "message",
					"mandatory": false
				}],
				"configuration": "<template xmlns=\"http://ws.apache.org/ns/synapse\" name=\"HelloTemplate\"><parameter name=\"message\" isMandatory=\"false\" defaultValue=\"\"/><sequence><log level=\"custom\"><property name=\"GREETING_MESSAGE\" expression=\"$func:message\"/><\/log><\/sequence><\/template>",
				"name": "HelloTemplate",
				"type": "sequence"
			}]
		}

		```

-	**Resource**: `/templates?type=TYPE`

	**Description**: Retrieves a list of available templates of a given type. Supported template types are as follows.
	1. endpoint
	2. sequence

	**Example**:

	```bash tab='Request'
	curl -X GET "https://localhost:9164/management/templates?type=sequence" -H "accept: application/json" -H "Authorization: Bearer TOKEN" -k -i
	```

	```bash tab='Response'
	{
	    "count": 1,
	    "list": [
		{
		    "name": "testSequenceTemplate"
		}
	    ]
	}
	```

-	**Resource**: `/templates?type={type}&name={template}`

	**Description**: Retrieves information related to a specific template. However this requires the template type to be included in the
	request as a query parameter in addition to the template name.

	**Example**:

	```bash tab='Request'
	curl -X GET "https://localhost:9164/management/templates?type=sequence&name=testSequenceTemplate" -H "accept: application/json" -H "Authorization: Bearer TOKEN" -k -i
	```

	```bash tab='Response'
	{
	    "Parameters": [],
	    "configuration": "<template xmlns=\"http://ws.apache.org/ns/synapse\" name=\"testSequenceTemplate\"><sequence/></template>",
	    "name": "testSequenceTemplate"
	}
	```

### ENABLE/DISABLE MESSAGE TRACING for SEQUENCE TEMPLATES

-	**Resource**: `/templates`

	**Description**: Enable or disable message tracing for a specified sequence template.

	**Example**:

    ```bash tab='Request'
		curl -X POST \
    	  https://localhost:9164/management/templates \
    	  -H 'authorization: Bearer TOKEN' \
    	  -H 'content-type: application/json' \
    	  -d '{
    		"name": "testSequenceTemplate",
    		"type": "sequence",
    		"trace": "enable"
    	}' -k -i
	```

	```bash tab='Response'
    {"message":"Enabled tracing for ('testSequenceTemplate')"}
	```
	
### GET SERVER INFORMATION

-	**Resource**: `/server`

	**Description**: Retrieves information related to the micro integrator server instance.

	**Example**:

	```bash tab='Request'
	curl -X GET "https://localhost:9164/management/server" -H "accept: application/json" -H "Authorization: Bearer TOKEN" -k -i
	```

	```bash tab='Response'
	{
	    "productVersion": "1.1.0",
	    "repositoryLocation": "/Users/Sachith/IdeaProjects/micro-integrator-public/distribution/target/wso2mi-1.1.0-SNAPSHOT/repository/deployment/client/",
	    "osVersion": "10.14",
	    "javaVersion": "1.8.0_171",
	    "workDirectory": "/Users/Sachith/IdeaProjects/micro-integrator-public/distribution/target/wso2mi-1.1.0-SNAPSHOT/tmp/work",
	    "carbonHome": "/Users/Sachith/IdeaProjects/micro-integrator-public/distribution/target/wso2mi-1.1.0-SNAPSHOT",
	    "javaVendor": "Oracle Corporation",
	    "osName": "Mac OS X",
	    "productName": "WSO2 Micro Integrator",
	    "javaHome": "/Library/Java/JavaVirtualMachines/jdk1.8.0_171.jdk/Contents/Home/jre"
	}
	```

### SHUTDOWN SERVER

-	**Resource**: `/server`

	**Description**: Shutdown the micro integrator server instance forcefully.

	**Example**:

	```bash tab='Request'
		curl -X PATCH \
    	  https://localhost:9164/management/server \
    	  -H 'authorization: Bearer TOKEN' \
    	  -H 'content-type: application/json' \
    	  -d '{
    		"status": "shutdown"
    	}' -k -i
	```

  	```bash tab='Response'
  	{
	"Message":"The server will start to shutdown."
	}
  	```

### SHUTDOWN SERVER GRACEFULLY

-	**Resource**: `/server`

	**Description**: Shutdown the micro integrator server instance gracefully.

	**Example**:

	```bash tab='Request'
		curl -X PATCH \
    	  https://localhost:9164/management/server \
    	  -H 'authorization: Bearer TOKEN' \
    	  -H 'content-type: application/json' \
    	  -d '{
    		"status": "shutdownGracefully"
    	}' -k -i
	```

  	```bash tab='Response'
  	{
	"Message":"The server will start to shutdown gracefully."
	}
  	```

### RESTART SERVER

-	**Resource**: `/server`

	**Description**: Restart the micro integrator server instance forcefully.

	**Example**:

	```bash tab='Request'
		curl -X PATCH \
    	  https://localhost:9164/management/server \
    	  -H 'authorization: Bearer TOKEN' \
    	  -H 'content-type: application/json' \
    	  -d '{
    		"status": "restart"
    	}' -k -i
	```

  	```bash tab='Response'
  	{
	"Message":"The server will start to restart."
	}
  	```

### RESTART SERVER GRACEFULLY

-	**Resource**: `/server`

	**Description**: Restart the micro integrator server instance gracefully.

	**Example**:

	```bash tab='Request'
		curl -X PATCH \
    	  https://localhost:9164/management/server \
    	  -H 'authorization: Bearer TOKEN' \
    	  -H 'content-type: application/json' \
    	  -d '{
    		"status": "restartGracefully"
    	}' -k -i
	```

  	```bash tab='Response'
  	{
	"Message":"The server will start to restart gracefully."
	}
  	```

### GET DATA SERVICES

-	**Resource**: `/data-services`

	**Description**: Retrieves a list of all data services deployed.

	**Example**:

	```bash tab='Request'
	curl -X GET "https://localhost:9164/management/data-services" -H "accept: application/json" -H "Authorization: Bearer         TOKEN" -k -i
	```

	```bash tab='Response'
	{
	    "count": 1,
	    "list": [
		{
		    "name": "StudentDataService",
		    "wsdl1_1": "http://Sachiths-MacBook-Pro.local:8290/services/StudentDataService?wsdl",
		    "wsdl2_0": "http://Sachiths-MacBook-Pro.local:8290/services/StudentDataService?wsdl2"
		}
	    ]
	}
	```

	??? note "Search for a Data Service by name"
		You can also search for a Data Service by name. To do that, use the following example cURL command.

		```bash tab='Request'
		curl -X GET "https://localhost:9164/management/data-services?searchKey=hello" -H "accept: application/json" -H "Authorization: Bearer $AccessToken" -k -i

		```

		```base tab='Response'
		{
			"count": 2,
			"list": [{
				"name": "HelloDataService",
				"wsdl1_1": "http://localhost:8285/services/HelloDataService?wsdl",
				"wsdl2_0": "http://localhost:8285/services/HelloDataService?wsdl2"
			}]
		}

		```

-	**Resource**: `/data-services?dataServiceName={dataservice}`

	**Description**: Retrieves information related to a specific data service.

	**Example**:

	```bash
	curl -X GET "https://localhost:9164/management/data-services?dataServiceName=StudentDataService" -H "accept:          application/json" -H "Authorization: Bearer TOKEN" -k -i
	```

### GET DATA SOURCES
-	**Resource**: `/data-sources`

	**Description**: Retrieves a list of all data sources deployed.

	**Example**:
	
	```bash tab='Request'
	curl -X GET "https://localhost:9164/management/data-sources" -H "accept: application/json" -H "Authorization: Bearer         TOKEN" -k -i
	```
	
	```bash tab='Response'
	{"count":1,"list":[{"name":"MySQLConnection","type":"RDBMS"}]}
	```

	??? note "Search for a Data Source by name"
		You can also search for a Data Source by name. To do that, use the following example cURL command.

		```bash tab='Request'
		curl -X GET "https://localhost:9164/management/data-sources?searchKey=carbon" -H "accept: application/json" -H "Authorization: Bearer $AccessToken" -k -i

		```

		```base tab='Response'
		{
			"count": 1,
			"list": [{
				"name": "WSO2CarbonDB",
				"type": "RDBMS"
			}]
		}

		```

-	**Resource**: `/data-sources?name={datasource}`

	**Description**: Retrieves information related to a specific data source.

	**Example**:

	```bash tab='Request'
	curl -X GET "https://localhost:9164/management/data-sources?name=MySQLConnection" -H "accept:          application/json" -H "Authorization: Bearer TOKEN" -k -i
	```
	
	```bash tab='Response'
    {
	"configuration":"<configuration><driverClassName>com.mysql.jdbc.Driver</driverClassName><url>jdbc:mysql://localhost:3307/AccountDetails</url><username>root</username><password>root</password></configuration>",
	"driverClass":"com.mysql.jdbc.Driver",
	"name":"MySQLConnection",
	"description":"MySQL Connection",
	"type":"RDBMS",
	"url":"jdbc:mysql://localhost:3307/AccountDetails",
	"status":"ACTIVE"
	}
	```

### GET LOG LEVEL

-	**Resource**: `/logging?loggerName={logger}`

	**Description**: Retrieves information related to a specific logger.

	**Example**:

	```bash tab='Request'
	curl -X GET "https://localhost:9164/management/logging?loggerName=org-apache-coyote" -H "accept: application/json" -H 	      "Authorization: Bearer Token" -k
	```

	```bash tab='Response'
	{
      	"loggerName": "org-apache-coyote",
      	"level":"WARN",
      	"componentName":"org.apache.coyote"
    	}
	```

	??? note "Search for a Logger by name"
		You can also search for a Logger by name. To do that, use the following example cURL command.

		```bash tab='Request'
		curl -X GET "https://localhost:9164/management/logging?searchKey=carbon" -H "accept: application/json" -H "Authorization: Bearer $AccessToken" -k -i

		```

		```base tab='Response'
		{
			"count": 1,
			"list": [{
				"level": "WARN",
				"componentName": "org.wso2.carbon.apacheds",
				"loggerName": "org-wso2-carbon-apacheds"
			}]
		}

		```

### UPDATE ROOT LOG LEVEL

-	**Resource**: `/logging`

	**Description**: Updates the log level of root logger.

	**Example**:

	```bash tab='Request'
	curl -X PATCH \
      	https://localhost:9164/management/logging \
      	-H 'authorization: Bearer Token' \
      	-H 'content-type: application/json' \
      	-d '{
        "loggerName": "rootLogger",
        "loggingLevel": "WARN"
    	}' -k
	```

	```bash tab='Response'
	{
        "message": "Successfully updated rootLogger.level to WARN"
    	}
	```

### UPDATE LOG LEVEL

-	**Resource**: `/logging`

	**Description**: Updates the log level of a specific logger.

	**Example**:

	```bash tab='Request'
	curl -X PATCH \
      	https://localhost:9164/management/logging \
      	-H 'authorization: Bearer Token' \
      	-H 'content-type: application/json' \
      	-d '{
        "loggerName": "org-apache-hadoop-hive",
        "loggingLevel": "DEBUG"
    	}' -k
	```

	```bash tab='Response'
	{
        "message": "Successfully updated logger.org-apache-hadoop-hive.level to DEBUG"
    }
	```
	
### ADD NEW LOGGER

-	**Resource**: `/logging`

	**Description**: Add a new logger.

	**Example**:

	```bash tab='Request'
	curl -X PATCH \
      	https://localhost:9164/management/logging \
      	-H 'authorization: Bearer Token' \
      	-H 'content-type: application/json' \
      	-d '{
              "loggerName": "synapse-api",
              "loggingLevel": "DEBUG",
              "loggerClass":"org.apache.synapse.rest.API"
            }' -k
	```

	```bash tab='Response'
	{
	  "message":"Successfully added logger for ('synapse-api') with level DEBUG for class org.apache.synapse.rest.API"
	}
	```
	
### GET CORRELATION LOGGING CONFIGURATION STATUS

-	**Resource**: `/configs?configName=correlation`

	**Description**: Retrieves correlation log configuration status.

	**Example**:

	```bash tab='Request'
	curl -X GET "https://localhost:9164/management/configs?configName=correlation" -H "accept: application/json" -H "Authorization: Bearer Token" -k
	```

	```bash tab='Response'
	{   
	    "configName": "correlation",
	    "configs": {
			“enabled” : “false”
		   	}
	}

	```	

	??? note "Search for a log files by name"
		You can also search for a log file by name. To do that, use the following example cURL command.

		```bash tab='Request'
		curl -X GET "https://localhost:9164/management/logs?searchKey=carbon" -H "accept: application/json" -H "Authorization: Bearer $AccessToken" -k -i

		```

		```base tab='Response'
		{
			"count": 3,
			"list": [{
				"Size": "36.1 KB",
				"FileName": "wso2carbon.log"
			}, {
				"Size": "12.7 KB",
				"FileName": "wso2carbon-09-08-2022.log"
			}, {
				"Size": "0 B",
				"FileName": "wso2carbon-trace-messages.log"
			}]
		}

		```


### ENABLE/DISABLE CORRELATION LOGGING DURING RUNTIME

-	**Resource**: `/configs`

	**Description**: Enable or disable correlation logging in a running server.

	**Example**:

	```bash tab='Request'
	curl -X PUT \
	    "https://localhost:9164/management/configs/" \
	    -H "accept: application/json" -H "authorization: Bearer Token"    -H 'content-type: application/json' \
	    -d '{
	    "configName": "correlation",
	    "configs": {"enabled" : "true"}
	    }' -k -i
	```

	```bash tab='Response'
	{   
	    "message": "Successfully Updated Correlation Logs Status"
	}

	```	


### GET TRANSACTION COUNT

-	**Resource**: `/transactions/count`

	**Description**: Retrieves the transaction count for the current month.

	**Example**:

  	```bash tab='Request'
  	curl -X GET "https://localhost:9164/management/transactions/count" -H "accept: application/json" -H "Authorization: Bearer TOKEN" -k -i
  	```

  	```bash tab='Response'
  	{
  	    "Month": 6,
  	    "Year": 2020,
  	    "RequestCount": 74087714
  	}
  	```

-	**Resource**: `/transactions/count?year={year}&month={month}`

	**Description**: Retrieves the transaction count for the specified year and month.

    **Example**:

  	```bash tab='Request'
  	curl -X GET "https://localhost:9164/management/transactions/count?year=2020&month=5" -H "accept: application/json" -H "Authorization: Bearer TOKEN" -k -i
  	```

  	```bash tab='Response'
     {
  	    "Month": 5,
  	    "Year": 2020,
  	    "TransactionCount": 25074026
  	 }
  	```

### GET TRANSACTION REPORT DATA

-	**Resource**: `/transactions/report?start={start}&end={end}`

	**Description**: Retrieves the transaction report for the specified period. Generates the transaction report at the `<MI_HOME>/tmp` directory.

	**Example**:

  	```bash tab='Request'
  	curl -X GET "https://localhost:9164/management/transactions/report?start=2020-01&end=2020-05" -H "accept: application/json" -H "Authorization: Bearer TOKEN" -k -i
  	```

  	```bash tab='Response'
  	{
     "TransactionCountData": [[col1, col2, col3, col4],[val1, val2, val3, val4]]
    }
  	```

-	**Resource**: `/transactions/report?start={start}`

	**Description**: Retrieves the transaction report for data starting from the specified date. Generates the transaction report at the `<MI_HOME>/tmp` directory.

	**Example**:

    ```bash tab='Request'
  	 curl -X GET "https://localhost:9164/management/transactions/report?start=2020-01" -H "accept: application/json" -H "Authorization: Bearer TOKEN" -k -i
    ```

    ```bash tab='Response'
  	 {
  	  "TransactionCountData": [[col1, col2, col3, col4],[val1, val2, val3, val4]]
  	 }
  	```

### GET REGISTRY DIRECTORY DATA

-	**Resource**: `/registry-resources?path={registry path}`

	**Description**: Retrieves files and folders under the given parent folder with their media type and properties.

	**Example**:

  	```bash tab='Request'
  	curl -X GET \ 
	"https://localhost:9164/management/registry-resources?path=registry/config/testFolder" \
    -H "accept: application/json" \
    -H "Authorization: Bearer TOKEN" -k -i
  	```

  	```bash tab='Response'
  	{
		"count":2,
		"list":
		[
			{
				"name":"name1",
				"mediaType":"type1",
				"properties":[]
			},
    		{
				"name":"name2",
				"mediaType":"type2",
				"properties":
				[
					{
						"name":"prop1",
						"value":"val1"
					}
				]
			}
		]
	}
  	```

-	**Resource**: `/registry-resources?path={registry path}&expand={true}`

	**Description**: Retrieves a nested JSON containing all the files and folders under the given parent folder.

	**Example**:

  	```bash tab='Request'
  	curl -X GET \ 
	"https://localhost:9164/management/registry-resources?path=registry/config/testFolder&expand=true" \
    -H "accept: application/json" \
    -H "Authorization: Bearer TOKEN" -k -i
  	```

  	```bash tab='Response'
  	{
		"name":"testFolder",
		"files":
		[
			{
				"name":"test-text.txt",
				"files":[],
				"type":"text/plain"
			},
			{
				"name":"testSubFolder",
				"files":
				[
					{
						"name":"test-xml.xml",
						"files":[],
						"type":"text/xml"
					}
				],
				"type":"directory"
			}
		],
		"type":"directory"
	}
  	```

### GET REGISTRY CONTENT

-	**Resource**: `/registry-resources/content?path={registry path}`

	**Description**: Retrieves content of a registry as text.

	**Example**:

  	```bash tab='Request'
	curl -X GET \ 
	"https://localhost:9164/management/registry-resources/content?path=registry/config/testFolder/test-xml.xml" \
    -H "accept: application/json" \
    -H "Authorization: Bearer TOKEN" -k -i
  	```

  	```bash tab='Response'
	<?xml version="1.0" encoding="UTF-8"?>
	<endpoint name="sampleEP" xmlns="http://ws.apache.org/ns/synapse">
    <address uri="http://localhost:9000/updatedServices">
        <suspendOnFailure>
            <initialDuration>-1</initialDuration>
            <progressionFactor>1</progressionFactor>
        </suspendOnFailure>
        <markForSuspension>
            <retriesBeforeSuspension>5</retriesBeforeSuspension>
        </markForSuspension>
    </address>
	</endpoint>
  	```

	??? note "Search for a Registry Resource by name"
		You can also search for a Registry Resource by name. To do that, use the following example cURL command. A nested search is possible here to find files inside directories.

		```bash tab='Request'
		curl -X GET "https://localhost:9164/management/registry-resources?path=registry/config&searchKey=test-text" -H "accept: application/json" -H "Authorization: Bearer $AccessToken" -k -i

		```

		```base tab='Response'
		{
			"list": {
				"name": "config",
				"files": [{
					"name": "testFolder",
					"files": [{
						"name": "test-text.txt",
						"files": [],
						"type": "testMediaType"
					}],
					"type": "directory"
				}],
				"type": "directory"
			}
		}

		```


### ADD A REGISTRY RESOURCE

-	**Resource**: `/registry-resources/content?path={registry path}&mediaType={media type}`

	**Description**: Adds a new registry resource.

	!!! note
		Only admin users can add new registry resources.

		Use `multipart/form-data` as in `Request 2` to add binary files as registry resources.
		
		Change `Content-Type` header according to the payload.

	**Example**:

  	```bash tab='Request 1'
	curl -X POST \ 
	"https://localhost:9164/management/registry-resources/content?path=registry/config/testFolder/test-xml.xml&mediaType=application/xml" \
    -H "accept: application/json" \
    -H "Content-Type: application/xml" \
    -H "Authorization: Bearer TOKEN" \
    -d '<?xml version="1.0" encoding="UTF-8"?>
	<endpoint name="initialEP" xmlns="http://ws.apache.org/ns/synapse">
    <address uri="http://localhost:9000/services">
        <suspendOnFailure>
            <initialDuration>-1</initialDuration>
            <progressionFactor>1</progressionFactor>
        </suspendOnFailure>
        <markForSuspension>
            <retriesBeforeSuspension>5</retriesBeforeSuspension>
        </markForSuspension>
    </address>
	</endpoint>' -k -i
  	```

	```bash tab='Request 2'
	curl -X POST \ 
	"https://localhost:9164/management/registry-resources/content?path=registry/config/testFolder/test-pdf.pdf&mediaType=application/pdf" \
    -H "accept: application/json" \
    -H "Content-Type: multipart/form-data" \
    -H "Authorization: Bearer TOKEN" \
    -F 'file=@samplePdf.pdf' -k -i
  	```

  	```bash tab='Response'
	{
		"message": "Successfully added the registry resource"
	}
  	```

### MODIFY REGISTRY RESOURCE

-	**Resource**: `/registry-resources/content?path={registry path}`

	**Description**: Modifies the content of an existing registry resource.

	!!! note
		Only admin users can modify registry resources.
		
		Change `Content-Type` header according to the payload.

		Changes done to the registry resources will be updated to the cache after the predefined `cachableDuration` time period.

	**Example**:

  	```bash tab='Request 1'
	curl -X PUT \ 
	"https://localhost:9164/management/registry-resources/content?path=registry/config/testFolder/test-xml.xml" \
    -H "accept: application/json" \
    -H "Content-Type: application/xml" \
    -H "Authorization: Bearer TOKEN" \
    -d '<?xml version="1.0" encoding="UTF-8"?>
	<endpoint name="updatedEP" xmlns="http://ws.apache.org/ns/synapse">
    <address uri="http://localhost:9000/updatedServices">
        <suspendOnFailure>
            <initialDuration>-1</initialDuration>
            <progressionFactor>1</progressionFactor>
        </suspendOnFailure>
        <markForSuspension>
            <retriesBeforeSuspension>5</retriesBeforeSuspension>
        </markForSuspension>
    </address>
	</endpoint>' -k -i
  	```

	```bash tab='Request 2'
	curl -X PUT \ 
	"https://localhost:9164/management/registry-resources/content?path=registry/config/testFolder/test-pdf.pdf" \
    -H "accept: application/json" \
    -H "Content-Type: multipart/form-data" \
    -H "Authorization: Bearer TOKEN" \
    -F 'file=updatedPdf.pdf' -k -i
  	```

  	```bash tab='Response'
	{
		"message": "Successfully modified the registry resource"
	}
  	```

### DELETE A REGISTRY RESOURCE

-	**Resource**: `/registry-resources/content?path={registry path}`

	**Description**: Deletes a registry resource.

	!!! note
		Only admin users can delete registry resources.

	**Example**:

  	```bash tab='Request'
	curl -X DELETE \ 
	"https://localhost:9164/management/registry-resources/content?path=registry/config/testFolder/test-xml.xml" \
    -H "accept: application/json" \
    -H "Authorization: Bearer TOKEN" -k -i
  	```

  	```bash tab='Response'
	{
		"message": "Successfully deleted the registry resource"
	}
  	```

### GET PROPERTIES OF A REGISTRY RESOURCE

-	**Resource**: `/registry-resources/properties?path={registry path}`
	
	**Description**: Retrieves all the properties of a registry resource.

	**Example**:

  	```bash tab='Request'
	curl -X GET \ 
	"https://localhost:9164/management/registry-resources/properties?path=registry/config/testFolder/test-text.txt" \
    -H "accept: application/json" \
    -H "Authorization: Bearer TOKEN" -k -i
	```

  	```bash tab='Response'
	{
		"count":2,
		"list":
		[
			{
				"name":"prop1"
				,"value":"val1"
			},
			{
				"name":"prop2",
				"value":"val2"
			}
		]
	}
  	```

-	**Resource**: `/registry-resources/properties?path={registry path}&name={property name}`

	**Description**: Retrieves the value of a property.

	**Example**:

  	```bash tab='Request'
	curl -X GET \ 
	"https://localhost:9164/management/registry-resources/properties?path=registry/config/testFolder/test-text.txt&name=prop1" \
    -H "accept: application/json" \
    -H "Authorization: Bearer TOKEN" -k -i
	```

  	```bash tab='Response'
	{
		"prop1":"val1"
	}
  	```

### ADD PROPERTIES TO A REGISTRY RESOURCE

-	**Resource**: `/registry-resources/properties?path={registry path}`

	**Description**: Adds properties to a registry resource. If the input payload consists an existing property name, property value will be modified.

	!!! note
		Only admin users can add properties to a registry resource.

		New properties should be in a JSON array with JSON objects for each property.

	**Example**:

  	```bash tab='Request'
	curl -X POST \ 
	"https://localhost:9164/management/registry-resources/properties?path=registry/config/testFolder/test-text.txt" \
    -H "accept: application/json" \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer TOKEN" \
    -d '[
		{
			"name":"prop1",
			"value":"val1"
		},
		{
			"name":"prop2",
			"value":"val2"
		}
	]' -k -i
	```

  	```bash tab='Response'
	{
		"message": "Successfully added the registry property"
	}
  	```

### DELETE A PROPERTY FROM A REGISTRY RESOURCE

-	**Resource**: `/registry-resources/properties?path={registry path}&name={property name}`

	**Description**: Deletes a property from a registry resource.

	!!! note
		Only admin users can delete properties from a registry resource.

	**Example**:

  	```bash tab='Request'
	curl -X DELETE\
	"https://localhost:9164/management/registry-resources/properties?path=registry/config/testFolder/test-text.txt&name=prop1" \
    -H "accept: application/json" \
    -H "Authorization: Bearer TOKEN" -k -i
	```

  	```bash tab='Response'
	{
		"message": "Successfully deleted the registry property"
	}
  	```

### GET METADATA OF A REGISTRY RESOURCE

-	**Resource**: `/registry-resources/properties?path={registry path}`

	**Description**: Retrieves the media type of a registry resource.

	**Example**:

  	```bash tab='Request'
	curl -X GET\ 
	"https://localhost:9164/management/registry-resources/metadata?path=registry/config/testFolder/test-text.txt" \
    -H "accept: application/json" \
    -H "Authorization: Bearer TOKEN" -k -i
	```

  	```bash tab='Response'
	{
		"name":"test-text.txt",
		"mediaType":"text/plain"
	}
  	```
