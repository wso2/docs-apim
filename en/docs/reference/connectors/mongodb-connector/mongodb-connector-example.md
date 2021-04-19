# MongoDB Connector Example

The MongoDB Connector can be used to perform CRUD operations in the local database as well as in MongoDB Atlas (cloud version of MongoDB).

## What you&#39;ll build

This example explains how to use MongoDB Connector to insert and find documents from a MongoDB database.

The sample API given below demonstrates how the MongoDB connector can be used to connect to the MongoDB Server and perform **insert many** and **find** operations on it.

- `/insertmany`: The user sends a request payload that includes the connection information, collection name, and the documents to be inserted. This request is sent to the integration runtime by invoking the MongodbConnector API. This will insert the documents into the MongoDB database.

    <p><img src="{{base_path}}/assets/img/integrate/connectors/mongodb-conn-1.png" title="Insert many function" width="800" alt="Insert many function" /></p>

- `/find`: The user sends the request payload containing the connection information, collection name, and the find query. This request is sent to the integration runtime by invoking the MongodbConnector API. Once the API is invoked, it returns the documents matching the find query.

    <img src="{{base_path}}/assets/img/integrate/connectors/mongodb-conn-2.png" title="Find function" width="800" alt="Find function"/>

If you do not want to configure this yourself, you can simply [get the project](#get-the-project) and run it.

## Before you begin

If you want to connect to MongoDB Atlas, follow the steps mentioned below to get the connection string.

1. In the Clusters view, click **Connect** for the cluster to which you want to connect.

2. Click **Choose a connection method**.

3. Click **Connect your application**.

4. Select Java from the **Driver** menu.

5. Select the correct driver version from the **Version** menu.

6. Clear the **Include full driver code example** check box to get the connection string.

## Configure the connector in WSO2 Integration Studio

Follow these steps to set up the Integration Project and the Connector Exporter Project.

{!reference/connectors/importing-connector-to-integration-studio.md!}

## Creating the Integration Logic

1.  Create a new integration project named `MongodbConnector`. Be sure to enable a Connector Exporter.

    <img src="{{base_path}}/assets/img/integrate/connectors/mongodb-conn-3.png" title="Create project" width="500" alt="Create project"/>

2.  Right-click the created Integration Project and select, -> **New** -> **Rest API** to create the REST API.

    <img src="{{base_path}}/assets/img/integrate/connectors/adding-an-api.png" title="Adding a Rest API" width="800" alt="Adding a Rest API"/>

3.  Provide the API name as `MongoConnector` and the API context as `/mongodbconnector`.

4.  First, create the `/insertmany` resource. This API resource inserts documents into the MongoDB database.<br/>
    Right-click on the API Resource and go to the **Properties** view. Let's use a URL template called `/insertmany` as there are two API resources inside a single API. The method is `Post`.

    <img src="{{base_path}}/assets/img/integrate/connectors/mongodb-conn-4.png" title="Adding the API resource." width="800" alt="Adding the API resource."/>

5.  Drag the 'insertMany' operation of the MongoDB Connector to the Design view as shown below.

    <img src="{{base_path}}/assets/img/integrate/connectors/mongodb-conn-5.png" title="Adding the insert many operation." width="800" alt="Adding the insert many operation."/>

6.  Create a connection from the Properties view by clicking the '+' icon as shown below.

    Following values can be provided when connecting to the MongoDB database. <br/>

    - Connection Name - connectionURI
    - Connection Type - URI
    - Connection URI - mongodb+srv://server.example.com/?connectTimeoutMS=300000&amp;authSource=aDifferentAuthDB
    - Database - TestDatabase

    <img src="{{base_path}}/assets/img/integrate/connectors/mongodb-conn-6.png" title="Adding the connection." width="800" alt="Adding the connection."/>

7.  After the connection is successfully created, you can select the new connection from the 'Connection' menu in the properties view.

    <img src="{{base_path}}/assets/img/integrate/connectors/mongodb-conn-7.png" title="Selecting the connection." width="800" alt="Selecting the connection."/>

8.  Next, provide JSON expressions for the following two properties. These expressions will retrieve the respective values from the JSON request payload.

    - Collection - json-eval($.collection)
    - Documents - json-eval($.documents)

9.  Drag the [Respond Mediator](https://ei.docs.wso2.com/en/latest/micro-integrator/references/mediators/respond-Mediator/) to the canvas. This returns the response message to the client (after inserting documents) as shown below.

    <img src="{{base_path}}/assets/img/integrate/connectors/mongodb-conn-8.png" title="Adding the respond mediator." width="800" alt="Adding the respond mediator."/>

10. Create the next API resource (which is `/find`) by dragging another API resource to the Design view. This API resource will find all the documents matching the find query given by the user. This will also be a `POST` request.

11. Drag the find operation of the Email Connector to the Design view as shown below.

12. Select 'connectionURI' as the connection from the 'Connection' menu in the properties view.

13. Next, provide JSON expressions for the following two properties. These expressions will retrieve the respective values from the JSON request payload.

    - Collection - json-eval($.collection)
    - Query - json-eval($.query)

14. Drag the [Respond Mediator](https://ei.docs.wso2.com/en/latest/micro-integrator/references/mediators/respond-Mediator/) to the canvas. This returns the response message to the client (after retrieving documents) as shown below.

15. You can find the complete API XML configuration below. You can go to the source view and copy paste the following config.

```
<?xml version="1.0" encoding="UTF-8"?>
<api context="/mongodbconnector" name="MongodbConnector" xmlns="http://ws.apache.org/ns/synapse">
    <resource methods="POST" uri-template="/insertmany">
        <inSequence>
            <mongodb.insertMany configKey="connectionURI">
                <collection>{json-eval($.collection)}</collection>
                <documents>{json-eval($.documents)}</documents>
                <ordered>True</ordered>
            </mongodb.insertMany>
            <respond/>
        </inSequence>
        <outSequence/>
        <faultSequence/>
    </resource>
    <resource methods="POST" uri-template="/find">
        <inSequence>
            <mongodb.find configKey="connectionURI">
                <collection>{json-eval($.collection)}</collection>
                <query>{json-eval($.query)}</query>
            </mongodb.find>
            <respond/>
        </inSequence>
        <outSequence/>
        <faultSequence/>
    </resource>
</api>
```

{!reference/connectors/exporting-artifacts.md!}

## Get the project

You can download the ZIP file and extract the contents to get the project code.

<a href="{{base_path}}/assets/attachments/connectors/mongodbconnector.zip">
    <img src="{{base_path}}/assets/img/integrate/connectors/download-zip.png" width="200" alt="Download ZIP">
</a>

## Deployment

Follow these steps to deploy the exported CApp to the integration runtime.

{!reference/connectors/deploy-capp.md!}

??? note "Click here for instructions on removing the iterative mongodb server logs"
Add the configuration below to **remove** the iterative `org.mongodb.driver.cluster` server logs;

    1.  Add the following logger to the `log4j2.properties` file in the `<PRODUCT_HOME>/conf` folder.

        ```xml
    	logger.org-mongodb-driver-cluster.name = org.mongodb.driver.cluster
    	logger.org-mongodb-driver-cluster.level = WARN
        ```

    2.  Then, add `org-mongodb-driver-cluster` to the list of `loggers`.

!!! Prerequisite 1. Download the Mongo java driver from [here](https://repo1.maven.org/maven2/org/mongodb/mongo-java-driver/3.11.2/mongo-java-driver-3.11.2-javadoc.jar).

    2. Add the driver to the `<PRODUCT_HOME>/dropins` folder.

    3. Restart the server.

## Testing

### Insert Many Operation

1.  Create a file named `insertmany.json` with the following payload:

    ```json
    {
    	"collection": "TestCollection",
    	"documents": [
    		{
    			"name": "Jane Doe",
    			"_id": "123"
    		},
    		{
    			"name": "John Doe",
    			"_id": "1234"
    		},
    		{
    			"name": "Jane Doe",
    			"_id": "12345"
    		}
    	]
    }
    ```

2.  Invoke the API as shown below using the curl command.

    !!! Info
    The Curl application can be downloaded from [here](https://curl.haxx.se/download.html).

    ```bash
    curl -H "Content-Type: application/xml" --request POST --data @insertmany.json http://localhost:8290/mongodbconnector/insertmany
    ```

    **Expected Response** : You should get a response as given below and the data will be added to the database.

    ```json
    {
    	"InsertManyResult": "Successful"
    }
    ```

### Find Operation

!!! Note
In order to find documents by ObjectId, the find query payload should be in the following format:

    ```json
    {
        "query": {
            "_id": {
                "$oid": "6011b180007ce60ab2ad74a5"
            }
        }
    }
    ```

1.  Create a file called `find.json` with the following payload.

    ```json
    {
    	"collection": "TestCollection",
    	"query": {
    		"name": "Jane Doe"
    	}
    }
    ```

2.  Invoke the API using the curl command shown below.

    !!! Info
    Curl Application can be downloaded from [here](https://curl.haxx.se/download.html).

    ```bash
    curl -H "Content-Type: application/xml" --request POST --data @find.json http://localhost:8290/mongodbconnector/find
    ```

    **Expected Response** : You should get a response similar to the one given below.

    ```json
    [
    	{
    		"_id": "123",
    		"name": "Jane Doe"
    	},
    	{
    		"_id": "12345",
    		"name": "Jane Doe"
    	}
    ]
    ```

## What's Next

- You can deploy and run your project on Docker or Kubernetes. See the instructions in [Running the Micro Integrator on Containers](../../../../setup/installation/run_in_containers).
- To customize this example for your own scenario, see [MongoDB Connector Configuration](mongodb-connector-config.md) documentation for all operation details of the connector.
