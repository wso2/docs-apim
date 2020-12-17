# Microsoft Azure Storage Connector Reference

The following operations allow you to work with the Microsoft Azure Storage Connector. Click an operation name to see parameter details and samples on how to use it.

---

## Initialize the connector

To use the Microsoft Azure Storage connector, add the <msazurestorage.init> element in your configuration before carrying out any other Microsoft Azure Storage operations.

> **Note**: To work with the Microsoft Azure Storage connector, you need to have a Microsoft Azure account. If you do not have a Microsoft Azure account, go to [https://azure.microsoft.com/en-in/free/](https://azure.microsoft.com/en-in/free/) and create a Microsoft Azure account.

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
    </table>

    **Sample configuration**

    ```xml
    <msazurestorage.init>
        <accountName>{$ctx:accountName}</accountName>
        <accountKey>{$ctx:accountKey}</accountKey>
    </msazurestorage.init>
    ```
    
---

### Blobs

??? note "uploadBlob"
    The uploadBlob operation uploads a Blob file into the storage. See the [related API documentation](https://docs.microsoft.com/en-us/azure/storage/blobs/storage-java-how-to-use-blob-storage) for more information.
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
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <msazurestorage.uploadBlob>
        <containerName>{$ctx:containerName}</containerName>
        <fileName>{$ctx:fileName}</fileName>
        <filePath>{$ctx:filePath}</filePath>
    </msazurestorage.uploadBlob>
    ```
    
    **Sample request**

    ```json
    {
        "accountName": "test",
        "accountKey": "=gCetnaQlvsXQG4PnlXxxxxXXXXsW37DsDKw5rnCg==",
        "containerName": "sales",
        "fileName": "sample.txt",
        "filePath": "/home/user/Pictures/a.txt"
    }
    ```

??? note "deleteBlob"
    The deleteBlob operation deletes a Blob file from the storage. See the [related API documentation](https://docs.microsoft.com/en-us/azure/storage/blobs/storage-java-how-to-use-blob-storage) for more information.
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
        "accountName": "test",
        "accountKey": "=gCetnaQlvsXQG4PnlXxxxxXXXXsW37DsDKw5rnCg==",
        "containerName": "sales",
        "fileName": "sample.txt"
    }
    ```

??? note "listBlobs"
    The listBlobs operation retrieves information about all Blobs in a container. See the [related API documentation](https://docs.microsoft.com/en-us/azure/storage/blobs/storage-java-how-to-use-blob-storage) for more information.
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
        "accountName": "test",
        "accountKey": "=gCetnaQlvsXQG4PnlXxxxxXXXXsW37DsDKw5rnCg==",
        "containerName": "sales"
    }
    ```

---

### Containers

??? note "createContainer"
    The createContainer operation creates a container in the storage. See the [related API documentation](https://docs.microsoft.com/en-us/azure/storage/containers/storage-java-how-to-use-container-storage) for more information.
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
        "accountName": "test",
        "accountKey": "=gCetnaQlvsXQG4PnlXxxxxXXXXsW37DsDKw5rnCg==",
        "containerName": "sales"
    }
    ```

??? note "deleteContainer"
    The deleteContainer operation deletes a container from the storage. See the [related API documentation](https://docs.microsoft.com/en-us/azure/storage/containers/storage-java-how-to-use-container-storage) for more information.
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
        "accountName": "test",
        "accountKey": "=gCetnaQlvsXQG4PnlXxxxxXXXXsW37DsDKw5rnCg==",
        "containerName": "sales"
    }
    ```

??? note "listContainers"
    The listContainers operation retrieves information about all containers in the storage. See the [related API documentation](https://docs.microsoft.com/en-us/azure/storage/containers/storage-java-how-to-use-container-storage) for more information.

    **Sample configuration**

    ```xml
    <msazurestorage.listContainers/>
    ```
    
    **Sample request**

    ```json
    {
        "accountName": "test",
        "accountKey": "=gCetnaQlvsXQG4PnlXxxxxXXXXsW37DsDKw5rnCg==",
    }
    ```