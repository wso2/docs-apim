# Using the Management API

The Management API of WSO2 Micro Integrator is an internal REST API, which was introduced to substitute
the **admin services** that were available in WSO2 EI 6.x.x.

The [Micro Integrator dashboard]({{base_path}}/observe/mi-observe/working-with-monitoring-dashboard) communicates with this service to
obtain administrative information of the server instance and to perform various administration tasks. If you are not using the dashboard, you can directly access the [resources](#accessing-api-resources) of the management API by following the instructions given below.

## Securely invoking the API
The management API is secured using JWT authentication by default. Therefore, when you directly access the management API, you must first acquire a JWT token with your valid username and password.

!!! Tip
    See [Securing the Management API](../../setup/security/securing_management_api) for information on configuring **users**, **JWT authentication**, and other security options for the management API.

### Getting a JWT token

Follow the steps given below to acquire the JWT token.

1.	First, encode your username:password in Basic Auth format (encoded in base64). For example, use the default `admin:admin` credentials.
2.	Invoke the `/login` resource of the API with your encoded credintials as shown below.
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
     When the default JWT security handler is engaged, all the management API resources except `/login` is protected by JWT auth. Therefore, it is necessary to send the token as a bearer token when invoking the API resources.

```bash
curl -X GET "https://localhost:9164/management/inbound-endpoints" -H "accept: application/json" -H "Authorization: Bearer %AccessToken%”
```

### Log out from management API

Invoke the `/logout` resource to revoke the JWT token you used for [invoking the api resource](#invoking-an-api-resource).

```bash
curl -X GET "https://localhost:9164/management/logout" -H "accept: application/json" -H "Authorization: Bearer TOKEN" -k -i
```

## Accessing API resources

The management API has multiple resources to provide information regarding the deployed artifacts as well as the server itself.

### GET USERS

-	**Resource**: `/users`

	**Description**: Retrieves a list of all users stored in an [external user store](../../setup/user_stores/setting_up_a_userstore).

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

-	**Resource**: `/users/{user_id}`

	**Description**: Retrieves information related to a specified user stored in the [external user store](../../setup/user_stores/setting_up_a_userstore).

	**Example**:

  	```bash tab='Request'
  	curl -X GET "https://localhost:9164/management/users/user1" -H "accept: application/json" -H "Authorization: Bearer %AccessToken%" -k -i
  	```

    ```bash tab='Response'
    {
      userid: “user1”,
      isAdmin: true/false,
      roles :
      [
           role1,
          role2,
      ]
    }
    ```

-	**Resource**: `/users/pattern=”*”&role=admin`

	**Description**: Retrieves information related to user names (stored in an [external user store](../../setup/user_stores/setting_up_a_userstore)) that match a specific pattern and user role.

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

	**Description**: Adds a user to the [external user store](../../setup/user_stores/setting_up_a_userstore). Note that only admin users can create other users with admin access.

	**Example**:

    First create the following JSON file with user details as shown below. Note that this new user is granted the admin role.

    ```json
    {
     "userId":"user4",
     "password":"pwd1",
     "isAdmin":"true"
    }
    ```

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

	**Description**: Removes a user from the [external user store](../../setup/user_stores/setting_up_a_userstore). Note that only admin users can remove other users with admin access.

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

	**Description**: This operation provides you a list of available Applications.

	**Example**:

	```bash tab='Request'
	curl -X GET "https://localhost:9164/management/applications" -H "accept: application/json" -H "Authorization: Bearer TOKEN" -k -i
	```

	```bash tab='Response'
	{
	  "count": 1,
	  "list": [
	    {
	      "name": "SampleServicesCompositeApplication",
	      "version": "1.0.0"
	    }
	  ]
	}
	```

-	**Resource**: `/applications?carbonAppName={appname}`

	**Description**: Retrieves information related to a specified carbon application.

	**Example**:
	```
	curl -X GET "https://localhost:9164/management/applications?carbonAppName=HelloCApp" -H "accept: application/json" -H "Authorization: Bearer TOKEN" -k -i
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

	**Description**: Retrieves a list of available apis.

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

-	**Resource**: `/apis?apiName={api}`

	**Description**: Retrieves information related to a specified api.

### ENABLE/DISABLE MESSAGING TRACING for APIs

-	**Resource**: `/apis`

	**Description**: Enable or disable message tracing for a specified api.

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

-	**Resource**: `/data-services?dataServiceName={dataservice}`

	**Description**: Retrieves information related to a specific data service.

	**Example**:

	```bash
	curl -X GET "https://localhost:9164/management/data-services?dataServiceName=StudentDataService" -H "accept:          application/json" -H "Authorization: Bearer TOKEN" -k -i
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
