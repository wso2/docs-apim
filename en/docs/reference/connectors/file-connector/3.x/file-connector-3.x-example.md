# File Connector Example

File Connector can be used to perform operations in the local file system as well as in a remote server such as FTP and SFTP. 

## What you'll build

This example explains how to use File Connector to create a file in the local file system and read the particular file. The user sends a payload specifying which content is to be written to the file. Based on that content, a file is created in the specified location. Then the content of the file can be read as an HTTP response by invoking the other API resource upon the existence of the file. 

It will have two HTTP API resources, which are `create` and `read`. 

* `/create `: The user sends the request payload which includes the location where the file needs to be saved and the content needs to be added to the file. This request is sent to the integration runtime by invoking the FileConnector API. It saves the file in the specified location with the relevant content. 

    <p><img src="{{base_path}}/assets/img/integrate/connectors/filecon-3.x/fileconnector-03.png" title="Adding a Rest API" width="800" alt="Adding a Rest API" /></p>

* `/read `: The user sends the request payload, which includes the location of the file that needs to be read. This request is sent to the integration runtime where the FileConnector API resides. Once the API is invoked, it first checks if the file exists in the specified location. If it exists, the content is read and response is sent to the user. If the file does not exist, it sends an error response to the user. 

    <img src="{{base_path}}/assets/img/integrate/connectors/filecon-3.x/fileconnector-02.png" title="Adding a Rest API" width="800" alt="Adding a Rest API"/>

If you do not want to configure this yourself, you can simply [get the project](#get-the-project) and run it.

## Configure the connector in WSO2 Integration Studio

Follow these steps to set up the Integration Project and the Connector Exporter Project. 

{!reference/connectors/importing-connector-to-integration-studio.md!} 

## Creating the Integration Logic

1. Right click on the created Integration Project and select, -> **New** -> **Rest API** to create the REST API. 
    <img src="{{base_path}}/assets/img/integrate/connectors/filecon-3.x/adding-an-api.png" title="Adding a Rest API" width="800" alt="Adding a Rest API"/>

2. Provide the API name as File Connector and the API context as `/fileconnector`.

3. First we will create the `/create` resource. Right click on the API Resource and go to **Properties** view. We use a URL template called `/create` as we have two API resources inside single API. The method will be `Post`. 
    <img src="{{base_path}}/assets/img/integrate/connectors/filecon-3.x/filecon-3.png" title="Adding the API resource." width="800" alt="Adding the API resource."/>

4. In this operation we are going to receive input from the user which is `filePath` and `inputContent`. 
    - filePath - location that the file is going to be created.
    - inputContent - what needs to be written to the file. 

5. The above two parameters are saved to properties. Drag and drop the Property Mediator onto the canvas in the design view and do as shown below. For further reference, you can read about the [Property mediator]({{base_path}}/reference/mediators/property-mediator/).
    <img src="{{base_path}}/assets/img/integrate/connectors/filecon-3.x/filecon-1.png" title="Adding a property" width="800" alt="Adding a property"/>

6. Add the another Property Mediator to get the InputContent value copied. Do the same as in the above step. 
    - property name: InputContent
    - Value Type: EXPRESSION
    - Value Expression: json-eval($.inputContent)

7. Drag and drop the create operation of the File Connector to the Design View as shown below. Set the parameter values as below. We use the property values that we added in step 4 and 5 in this step as `$ctx:filePath` and `$ctx:inputContent`.
    <img src="{{base_path}}/assets/img/integrate/connectors/filecon-3.x/file-con2.png" title="Adding createFile operation" width="800" alt="Adding createFile operation"/>

8. Add a Respond Mediator as the user needs to see the response. Now we are done with creating the first API resource, and it is displayed as shown below. 
    <img src="{{base_path}}/assets/img/integrate/connectors/filecon-3.x/filecon9.png" title="First API Resource" width="800" alt="First API Resource"/>

9. Create the next API resource, which is `/read`. From this we are going to read the file content from a user specified location. 

10. As described in step 3, drag and drop another API resource to the design view. Use the URL template as `/read`. The method will be POST. 
    <img src="{{base_path}}/assets/img/integrate/connectors/filecon-3.x/apiResource.png" title="Adding an API resource" width="800" alt="Adding an API resource"/>

11. In this operation, the user sends the file location as the request payload. It will be written to the property as we did in step 10. 
    <img src="{{base_path}}/assets/img/integrate/connectors/filecon-3.x/filecon4.png" title="Adding property mediator" width="800" alt="Adding property mediator"/>

12. Then we are going to check if the file actually exists in the specified location. We can use `isFileExists` operation of the File Connector. 
    <img src="{{base_path}}/assets/img/integrate/connectors/filecon-3.x/filecon5.png" title="Adding property mediator" width="800" alt="Adding property mediator"/>

13. Then we copy the `isFileExists` response to a property mediator. Add another property mediator and add values as shown below. 
    <img src="{{base_path}}/assets/img/integrate/connectors/filecon-3.x/filecon6.png" title="Adding property mediator" width="800" alt="Adding property mediator"/>

14. Based on its response, we decide if we read the file or print an error to the user. In this case, we use a Switch Mediator.
    <img src="{{base_path}}/assets/img/integrate/connectors/filecon-3.x/filecon7.png" title="Adding switch mediator" width="800" alt="Adding switch mediator"/>

15. Drag and drop the read operation to the **case** in the Switch mediator. In the default case log an error and drops the message. 
    <img src="{{base_path}}/assets/img/integrate/connectors/filecon-3.x/filecon8.png" title="switch mediator" width="800" alt="switch mediator"/>

 16. You can find the complete API XML configuration below. You can go to the source view and copy paste the following config. 

    ```
    <?xml version="1.0" encoding="UTF-8"?>
    <api context="/fileconnector" name="FileConnector" xmlns="http://ws.apache.org/ns/synapse">
        <resource methods="POST" uri-template="/create">
            <inSequence>
                <property expression="json-eval($.filePath)" name="source" scope="default" type="STRING"/>
                <property expression="json-eval($.inputContent)" name="inputContent" scope="default" type="STRING"/>
                <fileconnector.create>
                    <filePath>{$ctx:filePath}</filePath>
                    <inputContent>{$ctx:inputContent}</inputContent>
            </fileconnector.create>
                <respond/>
            </inSequence>
            <outSequence/>
            <faultSequence/>
        </resource>
        <resource methods="POST" uri-template="/read">
            <inSequence>
                <property expression="json-eval($.source)" name="source" scope="default" type="STRING"/>
                <fileconnector.isFileExist>
                    <source>{$ctx:source}</source>
                </fileconnector.isFileExist>
                <property expression="json-eval($.fileExist)" name="response" scope="default" type="STRING"/>
                <log level="custom">
                    <property expression="get-property('response')" name="responselog"/>
                </log>
                <switch source="get-property('response')">
                    <case regex="true">
                        <fileconnector.read>
                            <source>{$ctx:source}</source>
                        </fileconnector.read>
                        <respond/>
                    </case>
                    <default>
                        <log>
                            <property name="notext" value="&quot;File does not exist&quot;"/>
                        </log>
                        <drop/>
                    </default>
                </switch>
            </inSequence>
            <outSequence/>
            <faultSequence/>
        </resource>
    </api>

    ```

{!reference/connectors/exporting-artifacts.md!}


## Get the project

You can download the ZIP file and extract the contents to get the project code.

<a href="{{base_path}}/assets/attachments/connectors/filecon-3.x/fileconnector.zip">
    <img src="{{base_path}}/assets/img/integrate/connectors/download-zip.png" width="200" alt="Download ZIP">
</a>

## Deployment

Follow these steps to deploy the exported CApp in the integration runtime. 

{!reference/connectors/deploy-capp.md!}

## Testing

### File Create Operation

1. Create a file called data.json with the following payload. 
    ```
    {
        "filePath":"<file_path>/create.txt",
        "inputContent": "This is a test file"
    }
    ```
    > **Note**: When you configuring this `source` parameter in Windows operating system you need to set this property shown as `<source>C:\\Users\Kasun\Desktop\Salesforcebulk-connector\create.txt</source>`.
    
2. Invoke the API as shown below using the curl command. Curl Application can be downloaded from [here](https://curl.haxx.se/download.html).
    ```
    curl -H "Content-Type: application/json" --request POST --data @body.json http://10.100.5.136:8290/fileconnector/create
    ```
**Expected Response**: 
You should get a 'Success' response, and the file should be created in the specified location in the above payload. 

### File Read Operation

1. Create a file called data.json with the following payload. 
    ```
    {
        "source":"<file_path>/create.txt"
    }
    ```
2. Invoke the API as shown below using the curl command. Curl Application can be downloaded from [here](https://curl.haxx.se/download.html).
    ```
    curl -H "Content-Type: application/json" --request POST --data @body.json http://10.100.5.136:8290/fileconnector/read
    ```

**Expected Response**: 
You should get the following text returned. 

`
This is a test file.
`

## What's Next

* You can deploy and run your project on Docker or Kubernetes. See the instructions in [Running the Micro Integrator on Containers]({{base_path}}/install-and-setup/installation/run_in_containers).
* To customize this example for your own scenario, see [File Connector Configuration]({{base_path}}/reference/connectors/file-connector/3.x/file-connector-3.x-config) documentation for all operation details of the connector.
