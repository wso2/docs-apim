# Microsoft Azure Storage Connector Example

Given below is a sample scenario that demonstrates how to work with container and blob operations using the WSO2 Microsoft Azure Storage Connector.

## What you'll build

This example demonstrates how to use Microsoft Azure Storage connector to:

1. Create a container (a location for storing employee details) in Microsoft Azure Storage account.
2. Retrieve information about the created containers.
3. Upload text or binary employee details (blob) in to the container.
4. Retrieve information about the uploaded employee details(blob).
5. Remove uploaded employee details (blob).
6. Remove created container.

All six operations are exposed via an API. The API with the context `/resources` has six resources  

* `/createcontainer` : Creates a new container in the Microsoft Azure Storage account with the specified container name for store employee details.
* `/listcontainer` : Retrieve information about the created containers from the Microsoft Azure Storage account.
* `/adddetails`: Upload text or binary employee data (blob) and stored into the specified container.
* `/listdetails` : Retrieve information about the added employee deta (blobs).
* `/deletedetails` : Remove added employee data from the specified text or binary employee data (blob).
* `/deletecontainer` : Remove created container in the Microsoft Azure Storage account.

For more information about these operations, please refer to the [Microsoft Azure Storage connector reference guide]({{base_path}}/reference/connectors/microsoft-azure-storage-connector/microsoft-azure-storage-reference/).

> **Note**: Before invoking the API, you need to create a **Storage Account** in **Microsoft Azure Storage account**. See [Azure Storage Configuration]({{base_path}}/reference/connectors/microsoft-azure-storage-connector/microsoft-azure-storage-configuration/) documentation for more information.

The following diagram shows the overall solution. The user creates a container, stores some text or binary employee data (blob) into the container, and then receives it back. To invoke each operation, the user uses the same API. 

<img src="{{base_path}}/assets/img/integrate/connectors/ms-azure-storage-connector.png" title="Microsoft Azure Storage Connector" width="800" alt="Microsoft Azure Storage Connector"/>

If you do not want to configure this yourself, you can simply [get the project](#get-the-project) and run it.

## Configure the connector in WSO2 Integration Studio

Follow these steps to set up the ESB Solution Project and the Connector Exporter Project.

{!reference/connectors/importing-connector-to-integration-studio.md!}

1. Right click on the created Integration Project and select, -> **New** -> **Rest API** to create the REST API.

2. Specify the API name as `MSAzureStorage` and API context as `/resources`. You can go to the XML configuration of the API (source view) and copy the following configuration.

   ```xml
   <?xml version="1.0" encoding="UTF-8"?>
   <api context="/resources" name="MSAzureStorage" xmlns="http://ws.apache.org/ns/synapse">
       <resource methods="POST" url-mapping="/createcontainer">
           <inSequence>
               <property expression="json-eval($.accountName)" name="accountName" scope="default" type="STRING"/>
               <property expression="json-eval($.accountKey)" name="accountKey" scope="default" type="STRING"/>
               <property expression="json-eval($.containerName)" name="containerName" scope="default" type="STRING"/>
               <msazurestorage.init>
                   <accountName>eiconnectortest</accountName>
                   <accountKey>bWt69gFpheoD6lwVsMgeV5io2/KxlXK1KUcod68PhzuV1xHxje0LBD4Bd+y+ESAOlH5BTAfvdDG5q4Hhg==</accountKey>
               </msazurestorage.init>
               <msazurestorage.createContainer>
                   <containerName>{$ctx:containerName}</containerName>
               </msazurestorage.createContainer>
               <log level="full">
                   <property name="Container created" value="Container created"/>
               </log>
               <respond/>
           </inSequence>
           <outSequence/>
           <faultSequence/>
       </resource>
       <resource methods="POST" url-mapping="/listcontainer">
           <inSequence>
               <property expression="json-eval($.accountName)" name="accountName" scope="default" type="STRING"/>
               <property expression="json-eval($.accountKey)" name="accountKey" scope="default" type="STRING"/>
               <msazurestorage.init>
                   <accountName>eiconnectortest</accountName>
                   <accountKey>bWt69gFpheoD6lwVsMgeV5io2/KxlXK1KUcod68PhzuV1xHxje0LBD4Bd+y+ESAOlH5BTAfvdDG5q4Hhg==</accountKey>
               </msazurestorage.init>
               <msazurestorage.listContainers/>
               <log level="full">
                   <property name="List containers" value="List containers"/>
               </log>
               <respond/>
           </inSequence>
           <outSequence/>
           <faultSequence/>
       </resource>
       <resource methods="POST" url-mapping="/adddetails">
           <inSequence>
               <property expression="json-eval($.accountName)" name="accountName" scope="default" type="STRING"/>
               <property expression="json-eval($.accountKey)" name="accountKey" scope="default" type="STRING"/>
               <property expression="json-eval($.containerName)" name="containerName" scope="default" type="STRING"/>
               <property expression="json-eval($.fileName)" name="fileName" scope="default" type="STRING"/>
               <property expression="json-eval($.filePath)" name="filePath" scope="default" type="STRING"/>
               <msazurestorage.init>
                   <accountName>eiconnectortest</accountName>
                   <accountKey>bWt69gFpheoD6lwVsMgeV5io2/KxlXK1KUcod68PhzuV1xHxje0LBD4Bd+y+ESAOlH5BTAfvdDG5q4Hhg==</accountKey>
               </msazurestorage.init>
               <msazurestorage.uploadBlob>
                   <containerName>{$ctx:containerName}</containerName>
                   <filePath>{$ctx:filePath}</filePath>
                   <fileName>{$ctx:fileName}</fileName>
               </msazurestorage.uploadBlob>
               <log level="full">
                   <property name="Uploaded emplyee details" value="Uploaded emplyee details"/>
               </log>
               <respond/>
           </inSequence>
           <outSequence/>
           <faultSequence/>
       </resource>
       <resource methods="POST" url-mapping="/listdetails">
           <inSequence>
               <property expression="json-eval($.accountName)" name="accountName" scope="default" type="STRING"/>
               <property expression="json-eval($.accountKey)" name="accountKey" scope="default" type="STRING"/>
               <property expression="json-eval($.containerName)" name="containerName" scope="default" type="STRING"/>
               <msazurestorage.init>
                   <accountName>eiconnectortest</accountName>
                   <accountKey>bWt69gFpheoD6lwVsMgeV5io2/KxlXK1KUcod68PhzuV1xHxje0LBD4Bd+y+ESAOlH5BTAfvdDG5q4Hhg==</accountKey>
               </msazurestorage.init>
               <msazurestorage.listBlobs>
                   <containerName>{$ctx:containerName}</containerName>
               </msazurestorage.listBlobs>
               <log level="full">
                   <property name="List uploaded emplyee details" value="List uploaded emplyee details"/>
               </log>
               <respond/>
           </inSequence>
           <outSequence/>
           <faultSequence/>
       </resource>
       <resource methods="POST" url-mapping="/deletedetails">
           <inSequence>
               <property expression="json-eval($.accountName)" name="accountName" scope="default" type="STRING"/>
               <property expression="json-eval($.accountKey)" name="accountKey" scope="default" type="STRING"/>
               <property expression="json-eval($.containerName)" name="containerName" scope="default" type="STRING"/>
               <property expression="json-eval($.fileName)" name="fileName" scope="default" type="STRING"/>
               <msazurestorage.init>
                   <accountName>eiconnectortest</accountName>
                   <accountKey>bWt69gFpheoD6lwVsMgeV5io2/KxlXK1KUcod68PhzuV1xHxje0LBD4Bd+y+ESAOlH5BTAfvdDG5q4Hhg==</accountKey>
               </msazurestorage.init>
               <msazurestorage.deleteBlob>
                   <containerName>{$ctx:containerName}</containerName>
                   <fileName>{$ctx:fileName}</fileName>
               </msazurestorage.deleteBlob>
               <log level="full">
                   <property name="Delete selected employee details" value="Delete selected employee details"/>
               </log>
               <respond/>
           </inSequence>
           <outSequence/>
           <faultSequence/>
       </resource>
       <resource methods="POST" url-mapping="/deletecontainer">
           <inSequence>
               <property expression="json-eval($.accountName)" name="accountName" scope="default" type="STRING"/>
               <property expression="json-eval($.accountKey)" name="accountKey" scope="default" type="STRING"/>
               <property expression="json-eval($.containerName)" name="containerName" scope="default" type="STRING"/>
               <msazurestorage.init>
                   <accountName>eiconnectortest</accountName>
                   <accountKey>bWt69gFpheoD6lwVsMgeV5io2/KxlXK1KUcod68PhzuV1xHxje0LBD4Bd+y+ESAOlH5BTAfvdDG5q4Hhg==</accountKey>
               </msazurestorage.init>
               <msazurestorage.deleteContainer>
                   <containerName>{$ctx:containerName}</containerName>
               </msazurestorage.deleteContainer>
               <log level="full">
                   <property name="Delete selected container" value="Delete selected container"/>
               </log>
               <respond/>
           </inSequence>
           <outSequence/>
           <faultSequence/>
       </resource>
   </api>
   
   ```
**Note**: Please modify the following properties of the configuration as applicable.

* As `accountKey` use the access key obtained from setting up the Microsoft Azure Storage account.
* As `accountName` get the name of created **Storage Account** inside the Microsoft Azure Storage account.
    
Now we can export the imported connector and the API into a single CAR application. CAR application is the one we are going to deploy to server runtime. 
   
{!reference/connectors/exporting-artifacts.md!}

## Get the project

You can download the ZIP file and extract the contents to get the project code.

<a href="{{base_path}}/assets/attachments/connectors/ms-azure-connector.zip">
    <img src="{{base_path}}/assets/img/integrate/connectors/download-zip.png" width="200" alt="Download ZIP">
</a>

!!! tip
    You may need to update the value of the credentials and make other such changes before deploying and running this project.

## Deployment

Follow these steps to deploy the exported CApp in the integration runtime. 

{!reference/connectors/deploy-capp.md!}

## Testing

Invoke the API as shown below using the curl command. Curl Application can be downloaded from [here](https://curl.haxx.se/download.html).

1. Creating a new container in Microsoft Azure Storage for store employee details.
 
   **Sample request**

    `curl -v POST -d {"containerName":"employeedetails"} "http://localhost:8290/resources/createcontainer" -H "Content-Type:application/json"`

   **Expected Response**
    
     `{
        "success": true
      }`
    
2. Retrieve information about the created containers.    
   
   **Sample request**
    
    `curl -v POST -d {} "http://localhost:8290/resources/listcontainer" -H "Content-Type:application/json"`
   
   **Expected Response**
   
     It will retrieve all the existing container names.
     
     `{
         "result":{
            "container":[
               "employeedetails",
               "employeefinancedetails"
            ]
         }
      }`

3. Upload text or binary employee data (blob).

   **Sample request**
   
     `curl -v POST -d {"containerName": "employeedetails","fileName": "sample.txt","filePath": "/home/kasun/Documents/MSAZURESTORAGE/sample.txt"} "http://localhost:8290/resources/adddetails" -H "Content-Type:application/json"`
   
     **Please note :** /home/kasun/Documents/MSAZURESTORAGE/sample.txt should be a valid path to a text file containing employee information.
    
   **Expected Response**
     
     `{
          "success": true
      }`
 
4. Retrieve information about the uploaded text or binary employee data (blob).

   **Sample request**
     
     `curl -v POST -d {"containerName": "employeedetails"} "http://localhost:8290/resources/listdetails" -H "Content-Type:application/json"`

   **Expected Response**
   
     It will retrieve the uploaded text or binary name and the file path.
     
     `{
          "result": {
              "blob": "http://eiconnectortest.blob.core.windows.net/employeedetails/sample.txt"
          }
      }`

5. Remove uploaded employee details (blob).

   **Sample request**
   
     `curl -v POST -d {"containerName": "employeedetails","fileName": "sample.txt"} "http://localhost:8290/resources/deletedetails" -H "Content-Type:application/json"`
 
   **Expected Response**
    
     `{
          "success": true
      }`

6. Remove created container.

   **Sample request**
     
     `curl -v POST -d {"containerName": "employeedetails"} "http://localhost:8290/resources/deletecontainer" -H "Content-Type:application/json"`
 
   **Expected Response**
     
     `{
          "success": true
      }`

## What's next

* You can deploy and run your project on Docker or Kubernetes. See the instructions in [Running the Micro Integrator on Containers]({{base_path}}/install-and-setup/installation/run_in_containers).
