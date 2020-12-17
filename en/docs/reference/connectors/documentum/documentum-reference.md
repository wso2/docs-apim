# Documentum Connector Reference

The following operations allow you to work with the Documentum Connector. Find an operation name to see parameter details and samples on how to use it.

??? note "Create Folder"
    The Create Folder operation enables you to create a new folder in Documentum.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>repos</td>
            <td>The name of the root repository being created in Documentum. For example, doctest.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>objectcodeID</td>
            <td>The Documentum Object Code ID for the parent folder. For example, "0c0277b68002952c"</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>foldername</td>
            <td>The Folder name to be given which is user Specific. For example, “Sample123”</td>
            <td>Yes.</td>
        </tr>
    </table>

    **Sample request**

    ```json
    {
        "repos":"doctest",
        "objectcodeID":"0c0277b68002952c",
        "foldername":" Sample123"
    }
    ```

??? note "Find Folder"
    The Find Folder operation is used to find the folder.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>repos</td>
            <td>The name of the root repository being created in Documentum. For example, doctest.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>folderObjectID</td>
            <td>The Folder object ID of the Documentum to find. For example, “0b0277b680048998”</td>
            <td>Yes.</td>
        </tr>
    </table>

    **Sample request**

    ```json
    {
        "repos":"doctest",
        "folderObjectID":"0b0277b680048998"
    }
    ```

??? note "Delete Folder"
    The Delete Folder operation is used to delete the folder.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>repos</td>
            <td>The name of the root repository being created in Documentum. For example, doctest.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>folderObjectID</td>
            <td>The Folder object ID of the documentum to be deleted. For example, “0b0277b680048998”</td>
            <td>Yes.</td>
        </tr>
    </table>

    **Sample request**

    ```json
    {
        "repos":"doctest",
        "folderObjectID":"0b0277b680048998"
    }
    ```

??? note "Create Document"
    The Create Document operation enables you to create a new document in Documentum.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>repos</td>
            <td>The name of the root repository being created in Documentum. For example, doctest.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>FolderID</td>
            <td>The Documentum object ID of the folder where the document has to be created. For example, "0b0277b68004e7de"</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>object_name</td>
            <td>The name of the document which is user specific. For example, “TestDoc1”</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>a_content_type</td>
            <td>The content type of the document(pdf,gif,csv,png,etc.). For example, "pdf"</td>
            <td>Yes.</td>
        </tr>
    </table>

    **Sample request**

    ```json
    {
        "repos":"doctest",
        "folderID":"0b0277b68004e7de",
        "object_name":"TestingJul24",
        "a_content_type":"pdf"
    }
    ```

??? note "Find Document"
    The Find Document operation enables you to find an existing document in Documentum.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>repos</td>
            <td>The name of the root repository being created in Documentum. For example, doctest.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>FolderID</td>
            <td>The documentum object ID of the document to find . For example, "0b0277b68004e7de"</td>
            <td>Yes.</td>
        </tr>
    </table>

    **Sample request**

    ```json
    {
        "repos":"doctest",
        "folderID":"0b0277b68004e7de",
    }
    ```

??? note "Delete Document"
    The Delete Document operation enables you to delete an existing document in Documentum.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>repos</td>
            <td>The name of the root repository being created in Documentum. For example, doctest.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>FolderID</td>
            <td>The documentum object ID of the document to be deleted. For example, "0b0277b68004e7de"</td>
            <td>Yes.</td>
        </tr>
    </table>

    **Sample request**

    ```json
    {
        "repos":"doctest",
        "folderID":"0b0277b68004e7de",
    }
    ```

??? note "Add Content to Document"
    The Add Content to Document operation enables you to add some content into a document in Documentum.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>repos</td>
            <td>The name of the root repository being created in Documentum. For example, doctest.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>objectID</td>
            <td>The documentum Object ID of the document where the content to be added. For example, "090277b68002952c"</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>format</td>
            <td>The format of the present document(pdf,gif,png,csv,etc..). For example, "pdf".</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>overwrite</td>
            <td>Whether to Overwrite the content in the document. For example, "true" or "false".</td>
            <td>Yes.</td>
        </tr>
    </table>

    **Sample request**
    
    Click the form data in Postman and enter the key value as indicated below and attach the file to be uploaded.
    
    <table>
        <tr>
            <th>Key</th>
            <th>Value</th>
        </tr>
        <tr>
            <td>request File</td>
            <td>file123.pdf</td>
        </tr>
    </table>

??? note "Create Content Full Document"
    The Create Content Full Document operation is used to create a document with content in Documentum.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>repos</td>
            <td>The name of the root repository being created in Documentum. For example, doctest.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>objectID</td>
            <td>The documentum Folder Object ID where the document to be created. For example, "090277b68002952c"</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>format</td>
            <td>The format of the document(png,gif,pdf,csv,etc..). For example, "pdf".</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>count</td>
            <td>The no of the documents added to the content. For example, "1" or "2".</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>primary</td>
            <td>To make all data as primary content of the document. For example, "true" or "false".</td>
            <td>Yes.</td>
        </tr>
    </table>

    **Sample request**
    
    Click the form data in Postman and enter the key value as indicated below and attach the file to be uploaded.
    
    <table>
        <tr>
            <th>Key</th>
            <th>Value</th>
        </tr>
        <tr>
            <td>objects Text</td>
            <td>{"properties”: {"r_object_type":"dm_document","object_name": "TestDoc"}}</td>
        </tr>
        <tr>
            <td>content1 File</td>
            <td>document.pdf</td>
        </tr>
    </table>

??? note "Get Document Content"
    The Get Document Content operation is used to get content from the document.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>repos</td>
            <td>The name of the root repository being created in Documentum. For example, doctest.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>documentObjectID</td>
            <td>The documentum object ID of the document to get content. For example, "090277b6800600a3"</td>
            <td>Yes.</td>
        </tr>
    </table>

    **Sample request**

    ```json
    {
        "repos":"doctest",
        "documentObjectID":"090277b6800600a3"
    }
    ```

??? note "Create Cabinet"
    The Create Cabinet operation is used to create the cabinet.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>repos</td>
            <td>The name of the root repository being created in Documentum. For example, doctest.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>object_name</td>
            <td>The name of the cabinet to be created which is user specific. For example, "TestCabinet6"</td>
            <td>Yes.</td>
        </tr>
    </table>

    **Sample request**

    ```json
    {
        "repos":"doctest",
        "object_name":"TestCabinet6"
    }
    ```

??? note "Find Cabinet"
    The Find Cabinet operation is used to find the cabinet.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>repos</td>
            <td>The name of the root repository being created in Documentum. For example, doctest.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>cabinateObjectID</td>
            <td>The documentum object ID of the cabinet to find. For example, "0c0277b68004dbc1"</td>
            <td>Yes.</td>
        </tr>
    </table>

    **Sample request**

    ```json
    {
        "repos":"doctest",
        "cabinateObjectID":"0c0277b68004dbc1"
    }
    ```

??? note "Delete Cabinet"
    The Delete Cabinet operation is used to delete the cabinet.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>repos</td>
            <td>The name of the root repository being created in Documentum. For example, doctest.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>cabinateObjectID</td>
            <td>The documentum object ID of the cabinet to be deleted. For example, "0c0277b68004dbc1"</td>
            <td>Yes.</td>
        </tr>
    </table>

    **Sample request**

    ```json
    {
        "repos":"doctest",
        "cabinateObjectID":"0c0277b68004dbc1"
    }
    ```

??? note "Get Cabinets"
    The Get Cabinets operation is used to retrieve all the cabinets.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>repos</td>
            <td>The name of the root repository being created in Documentum which list all child cabinets. For example, doctest.</td>
            <td>Yes.</td>
        </tr>
    </table>

    **Sample request**

    ```json
    {
        "repos":"doctest"
    }
    ```

??? note "Create ACL"
    The Create ACL operation enables you to create an ACL in Documentum.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>repos</td>
            <td>The name of the root repository being created in Documentum. For example, doctest.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>object_name</td>
            <td>The name of the ACL to be created which is user specific. For example, "Testacl8"</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>description</td>
            <td>The description of the ACL for details. For example, "TestaclonJul8".</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>owner_name</td>
            <td>The name of the Application admin/other privilege to be applied on the new ACL. For example, "appowner".</td>
            <td>Yes.</td>
        </tr>
    </table>

    **Sample request**
    
    ```json
    {
        "repos":"doctest",
        "object_name":"Testacl8",
        "description": "TestaclJul8",
        "owner_name": "appowner"
    }
    ```

??? note "Apply ACL"
    The Apply ACL operation is used to apply ACL in Documentum.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>repos</td>
            <td>The name of the root repository being created in Documentum. For example, doctest.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>objectID</td>
            <td>The documentum odject ID of the docuement where ACL has to be applied. For example, "Testacl8"</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>acl_name</td>
            <td>The name of the ACL to be applied. For example, "TestaclJul8".</td>
            <td>Yes.</td>
        </tr>
    </table>

    **Sample request**
    
    ```json
    {
        "repos":"doctest",
        "objectID":"0b0277b680043127",
        "acl_name":"Testacl8"
    }
    ```

??? note "Delete ACL"
    The Delete ACL operation is used to delete an ACL in Documentum.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>repos</td>
            <td>The name of the root repository being created in Documentum. For example, doctest.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>aclObjectID</td>
            <td>The ACL documentum object ID of the object(folder/document/cabinet) to be removed. For example, "450277b680001d42"</td>
            <td>Yes.</td>
        </tr>
    </table>

    **Sample request**
    
    ```json
    {
        "repos":"doctest",
        "aclObjectID":"450277b680001d42"
    }
    ```

??? note "Get All ACL"
    The Get All ACL operation is used to retrieve all ACL in Documentum.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>repos</td>
            <td>The name of the root repository being created in Documentum which list all ACL's created under that. For example, doctest.</td>
            <td>Yes.</td>
        </tr>
    </table>

    **Sample request**
    
    ```json
    {
        "repos":"doctest",
    }
    ```

??? note "Get Current Version"
    The Get Current Version operation is used to get all the versions in Documentum.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>repos</td>
            <td>The name of the root repository being created in Documentum. For example, doctest.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>chronical_id</td>
            <td>The documentum chronical object ID of the document. For example, "090277b680053e99"</td>
            <td>Yes.</td>
        </tr>
    </table>

    **Sample request**
    
    ```json
    {
        "repos":"doctest",
        "chronical_id":"090277b680053e99"
    }
    ```

??? note "Delete Version"
    The Delete Version operation is used to delete a version in Documentum.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>repos</td>
            <td>The name of the root repository being created in Documentum. For example, doctest.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>chronical_id</td>
            <td>The documentum chronical object ID of the document version to be deleted. For example, "090277b680053e99"</td>
            <td>Yes.</td>
        </tr>
    </table>

    **Sample request**
    
    ```json
    {
        "repos":"doctest",
        "chronical_id":"090277b680053e99"
    }
    ```

??? note "Find Sys Object"
    The Find Sys Object operation is used to find the system object in Documentum.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>repos</td>
            <td>The name of the root repository being created in Documentum. For example, doctest.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>objectID</td>
            <td>The documentum object ID of any kind of object to find. For example, "090277b680047c89"</td>
            <td>Yes.</td>
        </tr>
    </table>

    **Sample request**
    
    ```json
    {
        "repo":"doctest",
        "objectID":"090277b680047c89"
    }
    ```
