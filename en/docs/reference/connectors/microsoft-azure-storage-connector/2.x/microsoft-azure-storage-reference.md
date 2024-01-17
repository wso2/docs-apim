# Microsoft Azure Storage Connector Reference

The following operations allow you to work with the Microsoft Azure Storage Connector. Click an operation name to see parameter details and samples on how to use it.

---

## Initialize the connector

To use the Microsoft Azure Storage connector, you need to initialize the configuration before carrying out any other Microsoft Azure Storage operations.

To use the Microsoft Azure Storage connector, add the element in your configuration before carrying out any Azure Storage operations. This Microsoft Azure Storage configuration authenticates with Microsoft Azure Storage by Account access key or Client Credentials, which are used for every operation.

> **Note**: To work with the Microsoft Azure Storage connector, you need to have a Microsoft Azure account. If you do not have a Microsoft Azure account, go to [https://azure.microsoft.com/en-in/free/](https://azure.microsoft.com/en-in/free/) and create a Microsoft Azure account.

### Initialize using Account name and Access key

??? note "init"
    The init operation is used to initialize the connection to Microsoft Azure.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>accountName</td>
            <td>The name of the Azure storage account.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>accountKey</td>
            <td>The access key for the storage account.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>defaultEndpointsProtocol</td>
            <td>Type of the protocol(HTTP/HTTPS) to connect.</td>
            <td>No</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <msazurestorage.init>
        <accountName>{$ctx:accountName}</accountName>
        <accountKey>{$ctx:accountKey}</accountKey>
        <defaultEndpointsProtocol>{$ctx:defaultEndpointsProtocol}</defaultEndpointsProtocol>
    </msazurestorage.init>
    ```
    
---

### Initialize using Client Credentials

??? note "init"
    The init operation is used to initialize the connection to Microsoft Azure.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>accountName</td>
            <td>The name of the Azure storage account.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>clientId</td>
            <td>The client ID of the application.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>clientSecret</td>
            <td>The client secret of the application.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>tenantId</td>
            <td>The tenant ID of the application.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <msazurestorage.init>
        <accountName>{$ctx:accountName}</accountName>
        <clientId>{$ctx:clientId}</clientId>
        <clientSecret>{$ctx:clientSecret}</clientSecret>
        <tenantId>{$ctx:tenantId}</tenantId>
    </msazurestorage.init>
    ```
    
---

## Blobs

??? note "uploadBlob"
    The uploadBlob operation uploads a Blob file into the storage. See the [related API documentation](https://learn.microsoft.com/en-us/azure/storage/blobs/storage-quickstart-blobs-java) for more information.

    **Note**: Either `filePath` or `textContent` parameter is mandatory.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>containerName</td>
            <td>The name of the container.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>fileName</td>
            <td>The name of the file.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>filePath</td>
            <td>The path to a local file to be uploaded.</td>
            <td>No</td>
        </tr>
        <tr>
            <td>textContent</td>
            <td>Text content to be uploaded (without using a file).</td>
            <td>No</td>
        </tr>
        <tr>
            <td>blobContentType</td>
            <td>The Content-type of the file to be uploaded.</td>
            <td>No</td>
        </tr>
        <tr>
            <td>metadata</td>
            <td>The metadata of the blob.</td>
            <td>No</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <msazurestorage.uploadBlob>
        <containerName>{$ctx:containerName}</containerName>
        <fileName>{$ctx:fileName}</fileName>
        <filePath>{$ctx:filePath}</filePath>
        <blobContentType>{$ctx:fileContentType}</blobContentType>
        <metadata>{$ctx:metadata}</metadata>
    </msazurestorage.uploadBlob>
    ```
    
    **Sample request**

    ```json
    {
        "containerName": "sales",
        "fileName": "sample.json",
        "filePath": "/home/user/Pictures/a.json",
        "blobContentType": "application/json",
        "metadata": {
            "key1":"value1"
        }
    }
    ```

??? note "downloadBlob"
    The downloadBlob operation download the Blob content. See the [related API documentation](https://learn.microsoft.com/en-us/azure/storage/blobs/storage-quickstart-blobs-java) for more information.

    **Note**: By default, the content of the blob will be written to the HTTP response. The `destinationFilePath` parameter can be used to download it to local storage.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>containerName</td>
            <td>The name of the container.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>fileName</td>
            <td>The name of the file.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>destinationFilePath</td>
            <td>The local file path to download the blob. If the destination file already exists or if the file is not writable by the current user, an exception will be thrown.</td>
            <td>No</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <msazurestorage.downloadBlob>
        <containerName>{$ctx:containerName}</containerName>
        <fileName>{$ctx:fileName}</fileName>
    </msazurestorage.downloadBlob>
    ```
    
    **Sample request**

    ```json
    {
        "containerName": "sales",
        "fileName": "sample.txt"
    }
    ```

??? note "deleteBlob"
    The deleteBlob operation deletes a Blob file from the storage. See the [related API documentation](https://learn.microsoft.com/en-us/azure/storage/blobs/storage-quickstart-blobs-java) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>containerName</td>
            <td>The name of the container.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>fileName</td>
            <td>The name of the file.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <msazurestorage.deleteBlob>
        <containerName>{$ctx:containerName}</containerName>
        <fileName>{$ctx:fileName}</fileName>
    </msazurestorage.deleteBlob>
    ```
    
    **Sample request**

    ```json
    {
        "containerName": "sales",
        "fileName": "sample.txt"
    }
    ```

??? note "listBlobs"
    The listBlobs operation retrieves information about all Blobs in a container. See the [related API documentation](https://learn.microsoft.com/en-us/azure/storage/blobs/storage-quickstart-blobs-java) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>containerName</td>
            <td>The name of the container.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <msazurestorage.listBlobs>
        <containerName>{$ctx:containerName}</containerName>
    </msazurestorage.listBlobs>
    ```
    
    **Sample request**

    ```json
    {
        "containerName": "sales"
    }
    ```

---

## Containers

??? note "createContainer"
    The createContainer operation creates a container in the storage. See the [related API documentation](https://learn.microsoft.com/en-us/azure/storage/blobs/storage-quickstart-blobs-java) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>containerName</td>
            <td>The name of the container.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <msazurestorage.createContainer>
        <containerName>{$ctx:containerName}</containerName>
    </msazurestorage.createContainer>
    ```
    
    **Sample request**

    ```json
    {
        "containerName": "sales"
    }
    ```

??? note "deleteContainer"
    The deleteContainer operation deletes a container from the storage. See the [related API documentation](https://learn.microsoft.com/en-us/azure/storage/blobs/storage-quickstart-blobs-java) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>containerName</td>
            <td>The name of the container.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <msazurestorage.deleteContainer>
        <containerName>{$ctx:containerName}</containerName>
    </msazurestorage.deleteContainer>
    ```
    
    **Sample request**

    ```json
    {
        "containerName": "sales"
    }
    ```

??? note "listContainers"
    The listContainers operation retrieves information about all containers in the storage. See the [related API documentation](https://learn.microsoft.com/en-us/azure/storage/blobs/storage-quickstart-blobs-java) for more information.

    **Sample configuration**

    ```xml
    <msazurestorage.listContainers/>
    ```

## Metadata

??? note "listMetadata"
    The listMetadata operation list metadata for a given blob. See the [related API documentation](https://learn.microsoft.com/en-us/azure/storage/blobs/storage-quickstart-blobs-java) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>containerName</td>
            <td>The name of the container.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>fileName</td>
            <td>The name of the file.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <msazurestorage.listMetadata>
        <containerName>{$ctx:containerName}</containerName>
        <fileName>{$ctx:fileName}</fileName>
    </msazurestorage.listMetadata>
    ```
    
    **Sample request**

    ```json
    {
        "containerName": "sales",
        "fileName": "sample.txt"
    }
    ```

??? note "uploadMetadata"
    The uploadMetadata operation uploads a list of metadata for a given blob. See the [related API documentation](https://learn.microsoft.com/en-us/azure/storage/blobs/storage-quickstart-blobs-java) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>containerName</td>
            <td>The name of the container.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>fileName</td>
            <td>The name of the file.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>metadata</td>
            <td>The metadata of the blob.</td>
            <td>No</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <msazurestorage.uploadMetadata>
        <containerName>{$ctx:containerName}</containerName>
        <fileName>{$ctx:fileName}</fileName>
        <metadata>{$ctx:metadata}</metadata>
    </msazurestorage.uploadMetadata>
    ```
    
    **Sample request**

    ```json
    {
        "containerName": "sales",
        "fileName": "sample.json",
        "metadata": {
            "key1":"value1"
        }
    }
    ```

## Error codes related to Microsoft Azure Storage Connector

| Error code | Error message |
| -------- | ------- |
| 700701 | MS_AZURE_BLOB:CONNECTION_ERROR |
| 700702 | MS_AZURE_BLOB:INVALID_CONFIGURATION |
| 700703 | MS_AZURE_BLOB:MISSING_PARAMETERS |
| 700704 | MS_AZURE_BLOB:AUTHENTICATION_ERROR |
| 700705 | MS_AZURE_BLOB:FILE_ALREADY_EXISTS_ERROR |
| 700706 | MS_AZURE_BLOB:FILE_IO_ERROR |
| 700707 | MS_AZURE_BLOB:BLOB_STORAGE_ERROR |
| 700708 | MS_AZURE_BLOB:FILE_PERMISSION_ERROR |
| 700709 | MS_AZURE_BLOB:GENERAL_ERROR |

In addition to the above `ERROR_DETAIL` property will contain detail information about the error. For more information refer [Using Fault Sequences]({{base_path}}/integrate/examples/sequence_examples/using-fault-sequences/).