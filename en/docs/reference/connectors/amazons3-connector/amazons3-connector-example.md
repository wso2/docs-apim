# Amazon S3 Connector Example 

The AmazonS3 Connector allows you to access the Amazon Simple Storage Service (Amazon S3) via the AWS [SDK](https://aws.amazon.com/sdk-for-java/).

## What you'll build

This example depicts how to use AmazonS3 connector to:

1. Create a S3 bucket (a location for storing your data) in Amazon cloud.
2. Upload a message into the created bucket as a text file.
3. Retrieve created text file back and convert into a message in the integration runtime.

All three operations are exposed via an API. The API with the context `/s3connector` has three resources:

* `/createbucket` - Once invoked, it will create a bucket in Amazon with the specified name
* `/addobject`  - The incoming message will be stored into the specified bucket with the specified name
* `/info` - Once invoked, it will read the specified file from the specified bucket and respond with the content of the file

Following diagram shows the overall solution. The user creates a bucket, stores some message into the bucket, and then receives it back.

To invoke each operation, the user uses the same API.

<img src="{{base_path}}/assets/img/integrate/connectors/amazon-s3-diagram.jpg" title="Overview of Amazon S3 use case" width="800" alt="Amazon S3 use case"/>

If you do not want to configure this yourself, you can simply [get the project](#get-the-project) and run it.

## Setting up the environment

Please follow the steps mentioned at [Setting up Amazon S3]({{base_path}}/reference/connectors/amazons3-connector/amazons3-connector-config) document in order to create a Amazon S3 account and obtain credentials you need to access the Amazon APIs. Keep them saved to be used in the next steps.

## Configure the connector in WSO2 Integration Studio

Follow these steps to set up the Integration Project and import AmazonS3 connector into it.

{!includes/reference/connectors/importing-connector-to-integration-studio.md!}

## Creating the Integration Logic

1. Specify the API name as `S3ConnectorTestAPI` and API context as `/s3connector`.

2. First we will create the `/createbucket` resource. This API resource will retrieve the bucket name from the incoming HTTP PUT request and create a bucket in Amazon S3. Right click on the API Resource and go to **Properties** view. We use a URL template called `/createbucket` as we have three API resources inside a single API. The method will be PUT.

    <img src="{{base_path}}/assets/img/integrate/connectors/s3-connector-2x/s3-connector-create-bucket-api.jpg" title="Adding the createbucket resource" width="800" alt="Amazon S3 use case"/>

3. Next drag and drop the 'createBucket' operation of the S3 Connector to the Design View as shown below. Here, you will receive the following inputs from the user.
    - bucketName - Name of the bucket

    <img src="{{base_path}}/assets/img/integrate/connectors/s3-connector-2x/s3-connector-drop-create-bucket.jpg" title="Adding the createbucket operation" width="800" alt="Amazon S3 use case"/>

4. Create a connection from the properties window by clicking on the '+' icon as shown below.

    <img src="{{base_path}}/assets/img/integrate/connectors/s3-connector-2x/s3-create-bucket-connection-configs.jpg" title="Creating a new connection" width="800" alt="Amazon S3 use case"/>

    In the popup window, the following parameters must be provided.

    - Connection Name - Unique name to identify the connection by.
    - Connection Type - Type of the connection that specifies the protocol to be used.
    - AWS Access Key ID - Access key associated with your Amazon user account.
    - AWS Secret Access Key - Secret Access key associated with your Amazon user account.
    - Region - Region that is used to select a regional endpoint to make requests.

    !!! note
        1. You can either define the credentials or allow the AWS SDK to manage the credentials. The SDK will look for AWS credentials in system/user environment variables or use the IAM role for authentication if the application is running in an EC2 instance.
        2. The [IAM role for authentication](https://docs.amazonaws.cn/en_us/AWSEC2/latest/UserGuide/iam-roles-for-amazon-ec2.html) is available only with Amazon S3 connector v2.0.2 and above.

    <img src="{{base_path}}/assets/img/integrate/connectors/s3-connector-2x/s3-connector-connection.jpg" title="Configuring a new connection" width="500" alt="Amazon S3 use case"/>

5. After the connection is successfully created, select the created connection as 'Connection' from the drop down menu in the properties window.

6. Next, configure the following parameters in the properties window,

    - Bucket Name - json-eval($.bucketName)
    - Bucket Region - Select a region from the drop-down menu. Here we are using us-east-2.

    <img src="{{base_path}}/assets/img/integrate/connectors/s3-connector-2x/s3-connector-create-bucket-config.jpg" title="Configuring create bucket operation" width="800" alt="Amazon S3 use case"/>

7. Drag and drop the [Respond Mediator]({{base_path}}/reference/mediators/respond-mediator/) to send back the response from creating the bucket as shown below.

    <img src="{{base_path}}/assets/img/integrate/connectors/s3-connector-2x/s3-connector-create-bucket-respond.jpg" title="Adding a respond mediator" width="800" alt="Amazon S3 use case"/>

8. Create the next API resource, which is `/addobject` by dragging and dropping another API resource to the design view. This API resource will retrieve information about the object from the incoming HTTP POST request such as the bucketName, objectKey and the file content and upload it to Amazon S3.

    <img src="{{base_path}}/assets/img/integrate/connectors/s3-connector-2x/s3-connector-add-object-api.jpg" title="Adding the addobject resource" width="800" alt="Amazon S3 use case"/>

9. Drag and drop the ‘putObject’ operation of the S3 Connector to the Design View. In the properties view, select the already created connection as 'Connection' from the drop down menu and provide the following expressions to the below properties,
    - Bucket Name - json-eval($.bucketName)
    - Object Key - json-eval($.objectKey)
    - File Content - json-eval($.message)

    <img src="{{base_path}}/assets/img/integrate/connectors/s3-connector-2x/s3-connector-put-object-config.jpg" title="Configuring put object operation" width="800" alt="Amazon S3 use case"/>

10. Drag and drop the [Respond Mediator]({{base_path}}/reference/mediators/respond-mediator/) to send back the response from uploading the object.

11. Create the next API resource, which is `/info` by dragging and dropping another API resource to the design view. This API resource will retrieve information from the incoming HTTP POST request such as the bucketName, objectKey and get the object from Amazon S3.

    <img src="{{base_path}}/assets/img/integrate/connectors/s3-connector-2x/s3-connector-info-api.jpg" title="Adding the info resource" width="800" alt="Amazon S3 use case"/>

12. Next drag and drop the ‘getObject’ operation of the S3 Connector to the Design View. In the properties view, select the already created connection as 'Connection' from the drop down menu and provide the following expressions to the below properties,

    - Bucket Name - json-eval($.bucketName)
    - Object Key - json-eval($.objectKey)

    <img src="{{base_path}}/assets/img/integrate/connectors/s3-connector-2x/s3-connector-get-object-config.jpg" title="Configuring get object operation" width="800" alt="Amazon S3 use case"/>

13. Finally, drag and drop the [Respond Mediator]({{base_path}}/reference/mediators/respond-mediator/) to send back the response from the getObject operation.

14. You can find the complete API XML configuration below. You can go to the source view and copy paste the following config.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<api context="/s3connector" name="S3ConnectorTestAPI" xmlns="http://ws.apache.org/ns/synapse">
    <resource methods="PUT" uri-template="/createbucket">
        <inSequence>
            <amazons3.createBucket configKey="AMAZON_S3_CONNECTION_1">
                <bucketName>{json-eval($.bucketName)}</bucketName>
                <bucketRegion>us-east-2</bucketRegion>
            </amazons3.createBucket>
            <respond/>
        </inSequence>
        <outSequence/>
        <faultSequence/>
    </resource>
    <resource methods="POST" uri-template="/addobject">
        <inSequence>
            <amazons3.putObject configKey="AMAZON_S3_CONNECTION_1">
                <bucketName>{json-eval($.bucketName)}</bucketName>
                <objectKey>{json-eval($.objectKey)}</objectKey>
                <fileContent>{json-eval($.message)}</fileContent>
            </amazons3.putObject>
            <respond/>
        </inSequence>
        <outSequence/>
        <faultSequence/>
    </resource>
    <resource methods="POST" uri-template="/info">
        <inSequence>
            <amazons3.getObject configKey="AMAZON_S3_CONNECTION_1">
                <bucketName>{json-eval($.bucketName)}</bucketName>
                <objectKey>{json-eval($.objectKey)}</objectKey>
            </amazons3.getObject>
            <respond/>
        </inSequence>
        <outSequence/>
        <faultSequence/>
    </resource>
</api>
```

**Note**:

* As `awsAccessKeyId` use the access key obtained from Amazon S3 setup and update the above API configuration.
* As `awsSecretAccessKey` use the secret key obtained from Amazon S3 setup and update the above API configuration.
* Note that `region`, `connectionName` and credentials are hard coded. Please change them as per the requirement.
* For more information please refer the [reference guide]({{base_path}}/reference/connectors/amazons3-connector/amazons3-connector-reference) for Amazon S3 connector.

Now we can export the imported connector and the API into a single CAR application. CAR application is the one we are going to deploy to server runtime.

{!includes/reference/connectors/exporting-artifacts.md!}

Now the exported CApp can be deployed in the integration runtime so that we can run it and test.

## Get the project

You can download the ZIP file and extract the contents to get the project code.

<a href="{{base_path}}/assets/attachments/connectors/s3-connector.zip">
    <img src="{{base_path}}/assets/img/integrate/connectors/download-zip.png" width="200" alt="Download ZIP">
</a>

!!! tip
    You may need to update the value of the access key and make other such changes before deploying and running this project.

## Deployment

Follow these steps to deploy the exported CApp in the integration runtime.

{!includes/reference/connectors/deploy-capp.md!}

## Testing

We can use Curl or Postman to try the API. The testing steps are provided for curl. Steps for Postman should be straightforward and can be derived from the curl requests.

### Creating a bucket in Amazon S3

1. Create a file called `data.json` with the following content. Note that the bucket region is `us-east-2`. If you need to create the bucket in a different region, modify the hard coded region of the API configuration accordingly.
    ```json
    {
        "bucketName":"wso2engineers"
    }
    ```
2. Invoke the API as shown below using the curl command. Curl Application can be downloaded from [here](https://curl.haxx.se/download.html).
    ```
    curl -H "Content-Type: application/json" --request PUT --data @data.json http://127.0.0.1:8290/s3connector/createbucket
    ```
**Expected Response**:

    You will receive a response like below containing the details of the bucket created.

    ```json
    {
        "createBucketResult": {
            "success": true,
            "Response": {
                "Status": "200:Optional[OK]",
                "Location": "http://wso2engineers.s3.amazonaws.com/"
            }
        }
    }
    ```

    Please navigate to [Amazon AWS S3 console](https://s3.console.aws.amazon.com/) and see if a bucket called `wso2engineers` is created. If you tried to create a bucket with a name that already exists, it will reply back with a message indicating the conflict.

    <img src="{{base_path}}/assets/img/integrate/connectors/amazons3-bucket.png" title="Creating Amazon S3 bucket" width="800" alt="Creating Amazon S3 bucket"/>

### Post a message into Amazon S3 bucket

1. Create a file called `data.json` with the following content.
    ```json
    {
        "bucketName":"wso2engineers",
        "objectKey":"Julian.txt",
        "message":"Julian Garfield, Software Engineer, Integration Group"
    }
    ```
2. Invoke the API as shown below using the curl command. Curl Application can be downloaded from [here](https://curl.haxx.se/download.html).
    ```
    curl -H "Content-Type: application/json" --request POST --data @data.json http://127.0.0.1:8290/s3connector/addobject
    ```
**Expected Response**:
    You will receive a response like below containing the details of the object created.

    ```json
    {
        "putObjectResult": {
            "success": true,
            "PutObjectResponse": {
                "ETag": "\"359a77e8b4a63a637df3e63d16fd0e34\""
            }
        }
    }
    ```
    Navigate to AWS S3 console and click on the bucket `wso2engineers`. You will note that a file has been created with the name `Julian.txt`.
    <img src="{{base_path}}/assets/img/integrate/connectors/amazons3-bucket-upload.jpg" title="Upload object to Amazon S3 bucket" width="800" alt="Upload object to Amazon S3 bucket"/>

### Read objects from Amazon S3 bucket

Now let us read the information on `wso2engineers` that we stored in the Amazon S3 bucket.

1. Create a file called data.json with the following content. It specifies which bucket to read from and what the filename is. This example assumes that the object is stored at root level inside the bucket. You can also read a object stored in a folder inside the bucket.

    ```json
    {
        "bucketName":"wso2engineers",
        "objectKey":"Julian.txt"
    }
    ```
2. Invoke the API as shown below using the curl command.  
    ```
    curl -H "Content-Type: application/json" --request POST --data @data.json http://127.0.0.1:8290/s3connector/info
    ```
**Expected Response**:
    You receive a response similar to the following. The `Content` element contains the contents of the file requested.

    !!! note
        The `Content` element is available only with Amazon S3 connector v2.0.1 and above.

    ```json
    {
        "getObjectResult": {
            "success": true,
            "GetObjectResponse": {
                "AcceptRanges": "bytes",
                "Content": "Julian Garfield, Software Engineer, Integration Group",
                "ContentLength": 45,
                "ContentType": "text/plain; charset=UTF-8",
                "DeleteMarker": false,
                "ETag": "\"359a77e8b4a63a637df3e63d16fd0e34\"",
                "LastModified": null,
                "metadata": null,
                "MissingMeta": 0,
                "PartsCount": 0,
                "TagCount": 0
            }
        }
    }
    ```

In this example Amazon S3 connector is used to perform operations with Amazon S3 storage. You can receive details of the errors that occur when invoking S3 operations using the S3 responses itself. Please read the [Amazon S3 connector reference guide]({{base_path}}/reference/connectors/amazons3-connector/amazons3-connector-reference) to learn more about the operations you can perform with the Amazon S3 connector.
