# File Connector Reference

The following configurations allow you to work with the File Connector version 4.

## Connection configurations

The File connector can be used to deal with two types of file systems:

-   <b>Local File System</b>: A file system of the server where WSO2 EI is deployed.
-   <b>Remote File System</b>: A file system outside the server where WSO2 EI is deployed. There are few industry standard protocols established to expose a file system over TCP. Following protocols are supported by the File connector. 

    -   FTP
    -   FTPS
    -   SFTP
    
There are different connection configurations that can be used for the above protocols. They contain a common set of configurations and some additional configurations specific to the protocol.

<img src="../../../../assets/img/connectors/filecon-reference-22.png" title="types of file connections" width="800" alt="types of file connections"/>


!!! Note
    The File connector internally uses the [Apache VFS Library](https://commons.apache.org/proper/commons-vfs/). According to the selected connection type, the following VFS connection urls will be generated.

    ```bash tab='Local File'
    [file://] absolute-path
    file:///home/someuser/somedir
    file:///C:/Documents and Settings
    ```

    ```bash tab='FTP'
    ftp://[ username[: password]@] hostname[: port][ relative-path]
    ftp://myusername:mypassword@somehost/pub/downloads/somefile.tgz
    ```

    ```bash tab='FTPS'
    ftps://[ username[: password]@] hostname[: port][ absolute-path]
    ftps://myusername:mypassword@somehost/pub/downloads/somefile.tgz
    ``` 

    ```bash tab='SFTP'
    sftp://[ username[: password]@] hostname[: port][ relative-path]
    sftp://myusername:mypassword@somehost/pub/downloads/somefile.tgz
    ```

### Common configs to all connection types

<table>
    <tr>
        <th>Parameter Name</th>
        <th>Type</th>
        <th>Description</th>
        <th>Default Value</th>
        <th>Required</th>
    </tr>
    <tr>
        <td>
            Connection Name
        </td>
        <td>
            String
        </td>
        <td>
            A unique name to identify the connection.
        </td>
        <td>
            -
        </td>
        <td>
            Yes
        </td>
    </tr>
    <tr>
        <td>
            Connection Type
        </td>
        <td>
            String
        </td>
        <td>
            The protocol used for communicating with the file system.</br> 
            <b>Possible values</b>: 
            <ul>
                <li>
                    <b>Local</b>: Provides access to the files on the local physical file system.
                </li>
                <li>
                    <b>FTP</b>: Provides access to the files on an FTP server.
                </li>
                <li>
                    <b>FTPS</b>: Provides access to the files on an FTP server over SSL.
                </li>
                <li>
                    <b>SFTP</b>: Provides access to the files on an SFTP server (that is, an SSH or SCP server).
                </li>
            </ul>
        </td>
        <td>
            -
        </td>
        <td>
            Yes
        </td>
    </tr>
    <tr>
        <td>
            Working Directory
        </td>
        <td>
            String
        </td>
        <td>
            This is the working directory. The file paths in operations, which are associated with the connection, should be provided relative to this folder. </br>
            <b>Note</b>: As per <a href="https://commons.apache.org/proper/commons-vfs/filesystems.html#Local_Files">VFS documentation</a>, for windows, the working directory of local connections should be as follows: <code>/C:/Documents</code>.
        <td>
            Defaults to file system root.
        </td>
        <td>
            No
        </td>
    </tr>
    <tr>
        <td>
            File Locking Behaviour
        </td>
        <td>
            String
        </td>
        <td>
            Specify whether to acquire node-specific lock (Local) or cluster-wide lock (Cluster) when locks are acquired in read and write operations.</br>
            <ul>
                <li>
                    <b>Local</b></br>
                    When a lock is acquired, it is acquired within the context of file operations performed by that EI node only. Local lock acquired by some file operation on a particular EI node is not visible to the other EI nodes that may access the same file system.
                </li>
                <li>
                   <b>Cluster</b></br> 
                   When multiple EI nodes access the same file system performing read and write operations, you may use this behaviour. Here, when a file lock is acquired, it is visible to all file connector operations across the nodes. This is acquired by creating a <code>.lock</code> file in the same file system (for the file that is being accessed). The behaviour depends on the OS and the file system. Therefore, this feature may not work as intended in high-concurrent scenarios.
                </li>
            </ul>
            <b>Note</b>:</br>
            File locking is available for read and write operations. When enabled, a file specific lock is acquired before the operation and released after the operation. Parallel read/write operations are restricted when locking is enabled by a file operation.
        <td>
            Local
        </td>
        <td>
            Yes
        </td>
    </tr>
</table>

### Common remote connection configs

<table>
    <tr>
        <th>Parameter Name</th>
        <th>Type</th>
        <th>Description</th>
        <th>Default Value</th>
        <th>Required</th>
    </tr>
    <tr>
        <td>
            Host
        </td>
        <td>
            String
        </td>
        <td>
            Host name of the file server.
        </td>
        <td>
            -
        </td>
        <td>
            Yes
        </td>
    </tr>
    <tr>
        <td>
            Port
        </td>
        <td>
            Number
        </td>
        <td>
            The port number of the file server
        </td>
        <td>
            -
        </td>
        <td>
            Yes
        </td>
    </tr>
    <tr>
        <td>
            Username
        </td>
        <td>
            String
        </td>
        <td>
            User name used to connect with the file server.
        </td>
        <td>
            -
        </td>
        <td>
            No
        </td>
    </tr>
    <tr>
        <td>
            Password
        </td>
        <td>
            String
        </td>
        <td>
            Password to connect with the file server.
        </td>
        <td>
            -
        </td>
        <td>
            No
        </td>
    </tr>
    <tr>
        <td>
            User Directory Is Root
        </td>
        <td>
            Boolean
        </td>
        <td>
            If set to false (default), VFS will choose the file system's root as the VFS's root. If you want to have the user's home as the VFS root, then set this to 'true'.
        </td>
        <td>
            false
        </td>
        <td>
            No
        </td>
    </tr>
</table>

### FTP/FTPS-specific configs

<table>
    <tr>
        <th>Parameter Name</th>
        <th>Type</th>
        <th>Description</th>
        <th>Default Value</th>
        <th>Required</th>
    </tr>
    <tr>
        <td>
            Is Passive
        </td>
        <td>
            Boolean
        </td>
        <td>
            If passive mode is enabled, set this to 'true'.</br></br>
            <b>Note</b> the following about 'Active/Passive' mode:
            <ol>
                <li>
                    <b>Active Mode</b>: The client starts listening on a random port for incoming data connections from the server (the client sends the FTP command PORT to inform the server on which port it is listening). Nowadays, the client is typically behind a firewall (e.g. built-in Windows firewall) or NAT router (e.g. ADSL modem), unable to accept incoming TCP connections. The passive mode was introduced and is heavily used for this reason. 
                </li>
                <li>
                    <b>Passive Mode</b>: In the passive mode, the client uses the control connection to send a PASV command to the server and then receives a server IP address and server port number from the server, which the client then uses to open a data connection to the server IP address and server port number received.
                </li>
            </ol>
        </td>
        <td>
            true
        </td>
        <td>
            No
        </td>
    </tr>
    <tr>
        <td>
            FTP Connection Timeout
        </td>
        <td>
            Number
        </td>
        <td>
            Specify the timeout in milliseconds for the initial control connection.
        </td>
        <td>
            100000
        </td>
        <td>
            No
        </td>
    </tr>
    <tr>
        <td>
            FTP Socket Timeout
        </td>
        <td>
            Number
        </td>
        <td>
            Specify the socket timeout in milliseconds for the FTP client.
        </td>
        <td>
            150000
        </td>
        <td>
            No
        </td>
    </tr>
</table>

### FTPS-specific configs

<table>
    <tr>
        <th>Parameter Name</th>
        <th>Type</th>
        <th>Description</th>
        <th>Default Value</th>
        <th>Required</th>
    </tr>
    <tr>
        <td>
            KeyStore Path
        </td>
        <td>
            String
        </td>
        <td>
            The keystore path.
        </td>
        <td>
            -
        </td>
        <td>
            No
        </td>
    </tr>
    <tr>
        <td>
            KeyStore Password
        </td>
        <td>
            String
        </td>
        <td>
            The password to the keystore.
        </td>
        <td>
            -
        </td>
        <td>
            No
        </td>
    </tr>
    <tr>
        <td>
            TrustStore Path
        </td>
        <td>
            String
        </td>
        <td>
            The truststore path.
        </td>
        <td>
            -
        </td>
        <td>
            Yes
        </td>
    </tr>
    <tr>
        <td>
            TrustStore Password
        </td>
        <td>
            String
        </td>
        <td>
            The password to the truststore.
        </td>
        <td>
            -
        </td>
        <td>
            Yes
        </td>
    </tr>
    <tr>
        <td>
            Implicit Mode Enabled
        </td>
        <td>
            Boolean
        </td>
        <td>
            Set this to 'true' if <a href="https://en.wikipedia.org/wiki/FTPS#Implicit">implicit mode </a>is enabled.
            <ul>
                <li>
                    <b>Implicit</b>: The TLS ClientHello message should be initiated by client.
                </li>
                <li>
                    <b>Explicit</b>: The client must "explicitly request" security from an FTPS server.
                </li>
            </ul>
        </td>
        <td>
            false
        </td>
        <td>
            No
        </td>
    </tr>
    <tr>
        <td>
            Channel Protection Level
        </td>
        <td>
            String
        </td>
        <td>
            The FTP Data Channel protection level. Possible values: C,S,E,P.</br> 
            <b>Example</b>: Sends a “PROT P” command when implicit SSL is enabled.
        </td>
    </tr>
</table>

### SFTP connection configs

<table>
    <tr>
        <th>Parameter Name</th>
        <th>Type</th>
        <th>Description</th>
        <th>Default Value</th>
        <th>Required</th>
    </tr>
    <tr>
        <td>
            SFTP Connection Timeout
        </td>
        <td>
            Number
        </td>
        <td>
            The <b>Jsch</b> connection timeout in milli seconds.
        </td>
        <td>
            -
        </td>
        <td>
            No
        </td>
    </tr>
    <tr>
        <td>
            SFTP Session Timeout
        </td>
        <td>
            Number
        </td>
        <td>
            The <b>Jsch</b> session timeout in milli seconds.
        </td>
        <td>
            100000
        </td>
        <td>
           No
        </td>
    </tr>
    <tr>
        <td>
            Strict Host Key Check
        </td>
        <td>
            Boolean
        </td>
        <td>
            Specifies whether the Host key should be checked. If set to 'true', the connector (JSch) will always verify the public key (fingerprint) of the SSH/SFTP server.
        </td>
        <td>
            false
        </td>
        <td>
           No
        </td>
    </tr>
    <tr>
        <td>
            Private Key File
        </td>
        <td>
            String
        </td>
        <td>
            Path to the private key file.</br></br>
            <b>Note</b>: You can only use a key generated in a classic manner (<i>ssh-keygen -m PEM</i>).
        </td>
        <td>
            false
        </td>
        <td>
           No
        </td>
    </tr>
    <tr>
        <td>
            Private Key Passphrase
        </td>
        <td>
            String
        </td>
        <td>
            The passphrase of the private key. The security of a key (even if encrypted) is retained because it is not available to anyone else. You can specify the passphrase when generating keys.
        </td>
        <td>
            false
        </td>
        <td>
           No
        </td>
    </tr>
</table>

## Operations

The following operations allow you to work with the File Connector version 4. Click an operation name to see parameter details and samples on how to use it.

??? note "createDirectory"
    Creates a new folder in a provided directory path.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Type</th>
            <th>Description</th>
            <th>Default Value</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>
                File Connection
            </td>
            <td>
                String
            </td>
            <td>
                The name of the file connection configuration to use.
            </td>
            <td>
                -
            </td>
            <td>
                Yes
            </td>
        </tr>
        <tr>
            <td>
                Directory Path
            </td>
            <td>
                String
            </td>
            <td>
                The new directory path.
            </td>
            <td>
                -
            </td>
            <td>
                Yes
            </td>
        </tr>
    </table>

    **Response**

    ```xml
    <createDirectoryResult>
       <success>true</success>
    </createDirectoryResult>
    ```

??? note "checkExist"
    Check if a given file or folder exists.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Type</th>
            <th>Description</th>
            <th>Default Value</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>
                File Connection
            </td>
            <td>
                String
            </td>
            <td>
                The name of the file connection configuration to use.
            </td>
            <td>
                -
            </td>
            <td>
                Yes
            </td>
        </tr>
        <tr>
            <td>
                File/Folder Path
            </td>
            <td>
                String
            </td>
            <td>
                The new directory path that should be scanned.
            </td>
            <td>
                -
            </td>
            <td>
                Yes
            </td>
        </tr>
    </table>

    **Response**

    ```xml
    <checkExistResult>
       <success>true</success>
       <fileExists>true</fileExists>
    </checkExistResult>
    ```

??? note "compress"
    Archives a file or a directory.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Type</th>
            <th>Description</th>
            <th>Default Value</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>
                File Connection
            </td>
            <td>
                String
            </td>
            <td>
                The name of the file connection configuration to use.
            </td>
            <td>
                -
            </td>
            <td>
                Yes
            </td>
        </tr>
        <tr>
            <td>
                Folder/File To Compress
            </td>
            <td>
                String
            </td>
            <td>
                 The path to the folder that should be compressed.
            </td>
            <td>
                -
            </td>
            <td>
                Yes
            </td>
        </tr>
        <tr>
            <td>
                Targer File Path
            </td>
            <td>
                String
            </td>
            <td>
                 The path to the compressed file that will be created. If the file already exists, it is overwritten.
            </td>
            <td>
                -
            </td>
            <td>
                Yes
            </td>
        </tr>
        <tr>
            <td>
                Include Sub Directories
            </td>
            <td>
                Boolean
            </td>
            <td>
                Specifies whether the sub folders in the original folder should be included in the compressed file.
            </td>
            <td>
                true
            </td>
            <td>
                No
            </td>
        </tr>
    </table>

    **Response**

    ```xml
    <compressResult>
       <success>true</success>
       <NumberOfFilesAdded>16</NumberOfFilesAdded>
    </compressResult>
    ```

    **Error**

    ```xml
    <compressResult>
       <success>false</success>
       <code>700102</code>
       <detail>File or directory to compress does not exist</detail>
    </compressResult>
    ```

??? note "copy"
    Copies the file or folder specified by a source path to a target path. The source can be a file or a folder. If it is a folder, the copying is recursive. 

    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Type</th>
            <th>Description</th>
            <th>Default Value</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>
                File Connection
            </td>
            <td>
                String
            </td>
            <td>
                The name of the file connection configuration to use.
            </td>
            <td>
                -
            </td>
            <td>
                Yes
            </td>
        </tr>
        <tr>
            <td>
               Source Path
            </td>
            <td>
                String
            </td>
            <td>
                 The path to the file that should be copied. 
            </td>
            <td>
                -
            </td>
            <td>
                Yes
            </td>
        </tr>
        <tr>
            <td>
                Targer Path
            </td>
            <td>
                String
            </td>
            <td>
                 The location (folder) to which the file should be copied. </br>
                 If the target folder does not exist at the time of copy, a new folder is created.
            </td>
            <td>
                -
            </td>
            <td>
                Yes
            </td>
        </tr>
        <tr>
            <td>
                Source File Pattern
            </td>
            <td>
                String
            </td>
            <td>
                The file name pattern of the source file. Example: <i>[a-zA-Z][a-zA-Z]*.(txt|xml|jar)</i>
            </td>
            <td>
                -
            </td>
            <td>
                No
            </td>
        </tr>
        <tr>
            <td>
                Copy Including Source Parent
            </td>
            <td>
                Boolean
            </td>
            <td>
                Specify whether the parent folder should be copied from the file source along with the content. By default, only the content inside the folder will get copied.
            </td>
            <td>
                false
            </td>
            <td>
                No
            </td>
        </tr>
        <tr>
            <td>
                Overwrite Existing Files
            </td>
            <td>
                Boolean
            </td>
            <td>
                Specifies whether or not to overwrite the file if the same file already exists in the target destination.
            </td>
            <td>
                false
            </td>
            <td>
                No
            </td>
        </tr>
        <tr>
            <td>
                Rename To
            </td>
            <td>
                String
            </td>
            <td>
                The new name of the copied file.
            </td>
            <td>
                Original file name.
            </td>
            <td>
                No
            </td>
        </tr>
    </table>

    **Response**

    ```xml
    <copyFilesResult>
       <success>true</success>
    </copyFilesResult>
    ```

    **Error**

    ```xml
    <copyFilesResult>
       <success>false</success>
       <code>700103</code>
       <detail>Destination file already exists and overwrite not allowed</detail>
    </copyFilesResult>
    ```

??? note "move"
    Moves the file or folder specified by the source path to the target directory. The source can be a file or a folder. If it is a folder, the moving is recursive.
    
    The move operation can only move a file/folder within the same server. For example, you can move a file/folder from one local location to another local location, or from one remote location to another remote location on the same server. You cannot use the move operation to move a file/folder between different servers. If you want to move a file/folder from a local location to a remote location or vice versa, use the <b>copy</b> operation followed by <b>delete</b> operation.

    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Type</th>
            <th>Description</th>
            <th>Default Value</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>
                File Connection
            </td>
            <td>
                String
            </td>
            <td>
                The name of the file connection configuration to use.
            </td>
            <td>
                -
            </td>
            <td>
                Yes
            </td>
        </tr>
        <tr>
            <td>
               Source Path
            </td>
            <td>
                String
            </td>
            <td>
                 The path to the file that should be copied.
            </td>
            <td>
                -
            </td>
            <td>
                Yes
            </td>
        </tr>
        <tr>
            <td>
                Targer Path
            </td>
            <td>
                String
            </td>
            <td>
                 The location to which the file should be copied.
            </td>
            <td>
                -
            </td>
            <td>
                Yes
            </td>
        </tr>
        <tr>
            <td>
                Create Parent Directories
            </td>
            <td>
                Boolean
            </td>
            <td>
                Specifies whether the parent directory should be created if it doesn't already exist in the target folder.
            </td>
            <td>
                -
            </td>
            <td>
                No
            </td>
        </tr>
        <tr>
            <td>
                Include Parent
            </td>
            <td>
                Boolean
            </td>
            <td>
                Specify whether the parent folder should be copied from the file source along with the content.
            </td>
            <td>
                false
            </td>
            <td>
                No
            </td>
        </tr>
        <tr>
            <td>
                Overwrite Existing Files
            </td>
            <td>
                Boolean
            </td>
            <td>
                Specifies whether or not to overwrite the file if the same file already exists in the target destination.
            </td>
            <td>
                false
            </td>
            <td>
                No
            </td>
        </tr>
        <tr>
            <td>
                Rename To
            </td>
            <td>
                String
            </td>
            <td>
                The new name of the moved files.
            </td>
            <td>
                Original file name.
            </td>
            <td>
                No
            </td>
        </tr>
    </table>

    **Response**

    ```xml
    <moveFilesResult>
       <success>true</success>
    </moveFilesResult>
    ```

    **Error**

    ```xml
    <moveFilesResult>
       <success>false</success>
       <code>700103</code>
       <detail>Destination file already exists and overwrite not allowed</detail>
    </moveFilesResult>
    ```

??? note "read"
    Reads the content and metadata of a file at a given path. Metadata of the file is added as properties while content is set to the message body (or optionally to a message context property). 

    Known message properties representing file properties:

    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Type</th>
            <th>Description</th>
            <th>Default Value</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>
                FILE_LAST_MODIFIED_TIME
            </td>
            <td>
                DateTime
            </td>
            <td>
                The time at which the file was last modified.
            </td>
            <td>
                -
            </td>
            <td>
                Yes
            </td>
        </tr>
        <tr>
            <td>
               FILE_SIZE
            </td>
            <td>
                Number
            </td>
            <td>
                 The file size (in bytes).
            </td>
            <td>
                -
            </td>
            <td>
                Yes
            </td>
        </tr>
        <tr>
            <td>
                FILE_IS_DIR
            </td>
            <td>
                Boolean
            </td>
            <td>
                 Specifies whether a folder directory is represented as the file.
            </td>
            <td>
                false
            </td>
            <td>
                Yes
            </td>
        </tr>
        <tr>
            <td>
                FILE_PATH
            </td>
            <td>
                String
            </td>
            <td>
                The file path.
            </td>
            <td>
                -
            </td>
            <td>
                Yes
            </td>
        </tr>
        <tr>
            <td>
                FILE_URL
            </td>
            <td>
                String
            </td>
            <td>
                The VFS URL of the file.
            </td>
            <td>
                -
            </td>
            <td>
                Yes
            </td>
        </tr>
        <tr>
            <td>
                FILE_NAME
            </td>
            <td>
                String
            </td>
            <td>
                The file name or folder name.
            </td>
            <td>
                -
            </td>
            <td>
                Yes
            </td>
        </tr>
        <tr>
            <td>
                FILE_NAME_WITHOUT_EXTENSION
            </td>
            <td>
                String
            </td>
            <td>
                The file name without the extension.
            </td>
            <td>
                -
            </td>
            <td>
                Yes
            </td>
        </tr>
    </table>

    Important:

    -   When reading a folder, the first file that matches the pattern will be read first. Note that sub directories are not scanned. If you need to move or delete the file before reading the folder again, use the `FILE_NAME` context variable.
    -   The MIME type (content-type) of the message is determined by the file extension (i.e an XML file will be read as a message with the `application/xml` MIME type). However, users can force the MIME type by the `ContentType` parameter. Similarly, the `Encoding` parameter can be used to force the encoding.  
    -   You can set `EnableLock` to `true` to enable file system lock until the reading is completed and the stream is closed. 
    -   When large files are read, use `streaming=true`. Note that you need to first make necessary changes in the `deployment.toml`. The `ContentType` parameter also needs to be `application/binary`. Note that file reading modes are not applicable when streaming is set to `true`. The complete file is always streamed.

    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Type</th>
            <th>Description</th>
            <th>Default Value</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>
                File Connection
            </td>
            <td>
                String
            </td>
            <td>
                The name of the file connection configuration to use.
            </td>
            <td>
                -
            </td>
            <td>
                Yes
            </td>
        </tr>
        <tr>
            <td>
               File Path
            </td>
            <td>
                String
            </td>
            <td>
                 The path to the file that should be read.
            </td>
            <td>
                -
            </td>
            <td>
                Yes
            </td>
        </tr>
        <tr>
            <td>
                File Pattern
            </td>
            <td>
                String Regex
            </td>
            <td>
                 The file name pattern that should be matched when reading the file.
            </td>
            <td>
                All text files (<code>.*\.txt</code>)
            </td>
            <td>
                No
            </td>
        </tr>
        <tr>
            <td>
                Add Result To
            </td>
            <td>
                String
            </td>
            <td>
                Specify where to add the result of the file that is read.</br>
                <ul>
                    <li>
                        <b>Message Body</b>
                    </li>
                    <li>
                        <b>Message Property</b>: The payload that was in the message body before applying the <b>file read</b> operation will remain intact.
                    </li>
                </ul>
            </td>
            <td>
                -
            </td>
            <td>
                No
            </td>
        </tr>
        <tr>
            <td>
                Property Name
            </td>
            <td>
                String
            </td>
            <td>
                If <code>Add Result To==Message Property</code>, you need to specify this value. Result of the <b>file read</b> operation will be added as a <code>default</code> scope property by the specified name. This can now be accessed later in the flow.
            </td>
            <td>
                -
            </td>
            <td>
                No
            </td>
        </tr>
        <tr>
            <td>
                Read Mode
            </td>
            <td>
                String
            </td>
            <td>
                Available file reading modes: Read complete file, between lines, from line, upto line, single line, metadata only.
            </td>
            <td>
                Reads complete file.
            </td>
            <td>
                Yes
            </td>
        </tr>
        <tr>
            <td>
                Start Line Num
            </td>
            <td>
                Number
            </td>
            <td>
                Starts reading the file from the specified line.
            </td>
            <td>
                1
            </td>
            <td>
                No
            </td>
        </tr>
        <tr>
            <td>
                End Line Num
            </td>
            <td>
                Number
            </td>
            <td>
                Reads the file upto the specified line.
            </td>
            <td>
                Last line of file.
            </td>
            <td>
                No
            </td>
        </tr>
        <tr>
            <td>
                Specific Line number
            </td>
            <td>
                Number
            </td>
            <td>
                Specific line to read.
            </td>
            <td>
                When the reading mode is <code>SINGLE_LINE</code>.
            </td>
            <td>
                No
            </td>
        </tr>
        <tr>
            <td>
                MIMEType
            </td>
            <td>
                String
            </td>
            <td>
                Content type of the message set to the payload by this operation
            </td>
            <td>
                Determined by the file extension.
            </td>
            <td>
                No
            </td>
        </tr>
        <tr>
            <td>
                Encoding
            </td>
            <td>
                String
            </td>
            <td>
                Encoding of the message set to the payload by this operation.
            </td>
            <td>
                UTF-8
            </td>
            <td>
                No
            </td>
        </tr>
        <tr>
            <td>
                Enable Streaming
            </td>
            <td>
                Boolean
            </td>
            <td>
                Specifies whether or not streaming is used to read the file without any interpretation of the content.
            </td>
            <td>
                false
            </td>
            <td>
                No
            </td>
        </tr>
        <tr>
            <td>
                Enable Locking
            </td>
            <td>
                Boolean
            </td>
            <td>
                Specifies whether or not to lock the file.
            </td>
            <td>
                false
            </td>
            <td>
                No
            </td>
        </tr>
    </table>

    **Response**

    ```xml
    This is line one.
    This is line two.
    This is line three.
    This is line four.
    This is line five.
    This is line six.
    This is line seven.
    This is line eight.
    This lis line nine.
    This is line ten.
    ```

    **Full Log**

    ```bash
    [2020-10-06 06:01:44,083]  INFO {LogMediator} - {api:TestAPI} To: /filetest, MessageID: urn:uuid:7ab557c0-f9cb-4cf6-9c7b-f06a4640522a, Direction: request, message = After Read, FILE_LAST_MODIFIED_TIME = 10/06/2020 05:46:39, FILE_SIZE = 30, FILE_IS_DIR = false, FILE_NAME = test1.txt, FILE_PATH = /wso2/test, FILE_URL = file:///Users/hasitha/temp/file-connector-test/wso2/test/test1.txt, FILE_NAME_WITHOUT_EXTENSION = test1, Envelope: <?xml version='1.0' encoding='utf-8'?><soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"><soapenv:Body><text xmlns="http://ws.apache.org/commons/ns/payload">This is test1.txt file content</text></soapenv:Body></soapenv:Envelope>
    ```

    **Error**

    ```xml
    <readResult>
       <success>false</success>
       <code>700102</code>
       <detail>File or folder not found: file:///Users/hasitha/temp/file-connector-test/wso2/test/abcd.txt</detail>
    </readResult>
    ```

??? note "rename"
    Rename a file in a specified path. The new name cannot contain path separators. 

    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Type</th>
            <th>Description</th>
            <th>Default Value</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>
                File Connection
            </td>
            <td>
                String
            </td>
            <td>
                The name of the file connection configuration to use.
            </td>
            <td>
                -
            </td>
            <td>
                Yes
            </td>
        </tr>
        <tr>
            <td>
               Path
            </td>
            <td>
                String
            </td>
            <td>
                 The path to the file that should be renamed.
            </td>
            <td>
                -
            </td>
            <td>
                Yes
            </td>
        </tr>
        <tr>
            <td>
                Rename To
            </td>
            <td>
                String
            </td>
            <td>
                The file's new name.
            </td>
            <td>
                -
            </td>
            <td>
                Yes
            </td>
        </tr>
        <tr>
            <td>
                Overwrite Existing Files
            </td>
            <td>
                Boolean
            </td>
            <td>
                Specifies whether or not to overwrite the file in the target directory (if the same file exists).
            </td>
            <td>
                false
            </td>
            <td>
                No
            </td>
        </tr>
    </table>

    **Response**

    ```xml
    <renameFileResult>
       <success>true</success>
    </renameFileResult>
    ```

    **Error**

    ```xml
    <renameFileResult>
       <success>false</success>
       <code>700103</code>
       <detail>Destination file already exists and overwrite not allowed</detail>
    </renameFileResult>
    ```

??? note "delete"
    Deletes the files matching in a given directory.

    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Type</th>
            <th>Description</th>
            <th>Default Value</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>
                File Connection
            </td>
            <td>
                String
            </td>
            <td>
                The name of the file connection configuration to use.
            </td>
            <td>
                -
            </td>
            <td>
                Yes
            </td>
        </tr>
        <tr>
            <td>
               File/Directory Path
            </td>
            <td>
                String
            </td>
            <td>
                 The path to the file/folder that should be deleted.
            </td>
            <td>
                -
            </td>
            <td>
                Yes
            </td>
        </tr>
        <tr>
            <td>
                Pattern to Match Files
            </td>
            <td>
                String
            </td>
            <td>
                 The pattern that should be matched when listing files. This does not operate recursively on sub folders.
            </td>
            <td>
                All files.
            </td>
            <td>
                No
            </td>
        </tr>
    </table>

    **Response** 

    For a single file:

    ```xml
    <deleteFileResult>
       <success>true</success>
    </deleteFileResult>
    ```

    For a folder:

    ```xml
    <deleteFileResult>
       <success>true</success>
       <numOfDeletedFiles>5</numOfDeletedFiles>
    </deleteFileResult>
    ```

??? note "unzip"
    Unzip a specified file to a given location. If a folder with the same name exists, it is overwritten. 

    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Type</th>
            <th>Description</th>
            <th>Default Value</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>
                File Connection
            </td>
            <td>
                String
            </td>
            <td>
                The name of the file connection configuration to use.
            </td>
            <td>
                -
            </td>
            <td>
                Yes
            </td>
        </tr>
        <tr>
            <td>
               Zip File Path
            </td>
            <td>
                String
            </td>
            <td>
                 The path to the ZIP file that should be unzipped.
            </td>
            <td>
                -
            </td>
            <td>
                Yes
            </td>
        </tr>
        <tr>
            <td>
                Target Directory
            </td>
            <td>
                String
            </td>
            <td>
                 The location (folder) to which the ZIP file should be unzipped.
            </td>
            <td>
                -
            </td>
            <td>
                Yes
            </td>
        </tr>
    </table>

    **Response** 

    ```xml
    <unzipFileResult>
       <success>true</success>
       <zipFileContent>
           <test1.txt>extracted</test1.txt>
           <test2.txt>extracted</test2.txt>
           <hasitha--a1.txt>extracted</hasitha--a1.txt>
           <hasitha--a2.txt>extracted</hasitha--a2.txt>
           <hasitha--b--b2.txt>extracted</hasitha--b--b2.txt>
           <hasitha--b--b1.txt>extracted</hasitha--b--b1.txt>
           <hasitha--b--c--test1.txt>extracted</hasitha--b--c--test1.txt>
           <hasitha--b--c--c1.txt>extracted</hasitha--b--c--c1.txt>
       </zipFileContent>
    </unzipFileResult>
    ```

    **On Error** 

    ```xml
    <unzipFileResult>
       <success>false</success>
       <code>700102</code>
       <detail>File not found: file:///Users/hasitha/temp/file-connector-test/wso2/archievenew.zip</detail>
    </unzipFileResult>
    ```

    JSON equivalent:

    ```json
    {
       "unzipFileResult": {
           "success": false,
           "code": 700102,
           "detail": "File not found: file:///Users/hasitha/temp/file-connector-test/wso2/archievenew.zip"
       }
    }
    ```

??? note "splitFile"
    Splits a file into multiple smaller files.

    -   If the folder does not exist, it will be created.
    -   If the folder has files, they will be overwritten. 

    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Type</th>
            <th>Description</th>
            <th>Default Value</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>
                File Connection
            </td>
            <td>
                String
            </td>
            <td>
                The name of the file connection configuration to use.
            </td>
            <td>
                -
            </td>
            <td>
                Yes
            </td>
        </tr>
        <tr>
            <td>
               Path to the file to split
            </td>
            <td>
                String
            </td>
            <td>
                 The path to the file that should be split.
            </td>
            <td>
                -
            </td>
            <td>
                Yes
            </td>
        </tr>
        <tr>
            <td>
                Target Directory
            </td>
            <td>
                String
            </td>
            <td>
                 The path to the target folder where the new files should be created.
            </td>
            <td>
                -
            </td>
            <td>
                Yes
            </td>
        </tr>
        <tr>
            <td>
                Split Mode
            </td>
            <td>
                String
            </td>
            <td>
                 The split mode to use. The available options are as follows:</br>
                 <ul>
                    <li>ChunkSize</li>
                    <li>Linecount</li>
                    <li>XPATH Expression</li>
                 </ul>
            </td>
            <td>
                -
            </td>
            <td>
                Yes
            </td>
        </tr>
        <tr>
            <td>
                Chunk Size
            </td>
            <td>
                Number
            </td>
            <td>
                 If the <b>Split Mode</b> is 'Chunk Size', specify the chunk size (in bytes) into which the file should be split.
            </td>
            <td>
                -
            </td>
            <td>
                -
            </td>
        </tr>
        <tr>
            <td>
                Line Count
            </td>
            <td>
                Number
            </td>
            <td>
                 If the <b>Split Mode</b> is 'Line Count', specify the number of lines by which the original file should be split.
            </td>
            <td>
                -
            </td>
            <td>
                -
            </td>
        </tr>
        <tr>
            <td>
                XPATH Expression
            </td>
            <td>
                Number
            </td>
            <td>
                 If the <b>Split Mode</b> is 'XPATH Expression', specify the expression by which the file should be split. Only applies when splitting XML files.
            </td>
            <td>
                Chunk Size
            </td>
            <td>
                Yes
            </td>
        </tr>
    </table>

    **Response** 

    ```xml
    <splitFileResult>
       <success>true</success>
       <numberOfSplits>6</numberOfSplits>
    </splitFileResult>
    ```

    **On Error** 

    ```xml
    <splitFileResult>
       <success>false</success>
       <code>700107</code>
       <detail>Parameter 'xpathExpression' is not provided</detail>
    </splitFileResult>
    ```

??? note "listFiles"
    Lists all the files (that match the specified pattern) in the directory path.

    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Type</th>
            <th>Description</th>
            <th>Default Value</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>
                File Connection
            </td>
            <td>
                String
            </td>
            <td>
                The name of the file connection configuration to use.
            </td>
            <td>
                -
            </td>
            <td>
                Yes
            </td>
        </tr>
        <tr>
            <td>
               Directory Path
            </td>
            <td>
                String
            </td>
            <td>
                 The path to the directory from which files should be listed.
            </td>
            <td>
                -
            </td>
            <td>
                Yes
            </td>
        </tr>
        <tr>
            <td>
                Matching Pattern
            </td>
            <td>
                String
            </td>
            <td>
                 The file pattern that should be used to select files for listing.
            </td>
            <td>
                -
            </td>
            <td>
                No
            </td>
        </tr>
        <tr>
            <td>
                List Files in Sub Directories
            </td>
            <td>
                Boolean
            </td>
            <td>
                 List files from sub directories recursively.
            </td>
            <td>
                false
            </td>
            <td>
                No
            </td>
        </tr>
        <tr>
            <td>
                File Sort Attribute
            </td>
            <td>
               String
            </td>
            <td>
                 Files will get sorted and listed according to one of the follow: Name, Size, LastModifiedTime.
            </td>
            <td>
                Name
            </td>
            <td>
                No
            </td>
        </tr>
        <tr>
            <td>
                Sort Order
            </td>
            <td>
                String
            </td>
            <td>
                 The sorting order applicable to the <b>File Sort</b> attribute.</br>
                 <b>Possible Values</b>: Ascending, Descending.
            </td>
            <td>
                Ascending
            </td>
            <td>
                No
            </td>
        </tr>
    </table>

    **Response** 

    ```xml
    <listFilesResult>
       <success>true</success>
       <directory name="test">
           <file>.DS_Store</file>
           <directory name="aa"/>
           <file>abc.txt</file>
           <directory name="hasitha">
               <file>a1.txt</file>
               <file>a2.txt</file>
           </directory>
           <file>input.xml</file>
           <file>output.csv</file>
       </directory>
    </listFilesResult>
    ```

??? note "exploreZipFile"
    Explore the contents of a ZIP file in a specific location.

    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Type</th>
            <th>Description</th>
            <th>Default Value</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>
                File Connection
            </td>
            <td>
                String
            </td>
            <td>
                The name of the file connection configuration to use.
            </td>
            <td>
                -
            </td>
            <td>
                Yes
            </td>
        </tr>
        <tr>
            <td>
               Zip File Path
            </td>
            <td>
                String
            </td>
            <td>
                 The path to the ZIP file that should be explored.
            </td>
            <td>
                -
            </td>
            <td>
                Yes
            </td>
        </tr>
    </table>

    **Response** 

    ```xml
    <exploreZipFileResult>
       <success>true</success>
       <zipFileContent>
           <file>test1.txt</file>
           <file>test2.txt</file>
           <file>hasitha/a1.txt</file>
           <file>hasitha/a2.txt</file>
           <file>hasitha/b/b2.txt</file>
           <file>hasitha/b/b1.txt</file>
           <file>hasitha/b/c/test1.txt</file>
           <file>hasitha/b/c/c1.txt</file>
       </zipFileContent>
    </exploreZipFileResult>
    ```

    **On Error** 

    ```xml
    <exploreZipFileResult>
       <success>false</success>
       <code>700102</code>
       <detail>Zip file not found at path file:///Users/hasitha/temp/file-connector-test/wso2/test/archieve.zip</detail>
    </exploreZipFileResult>
    ```

??? note "mergeFiles"
    Merge the contents of multiple files in a folder to a single file.

    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Type</th>
            <th>Description</th>
            <th>Default Value</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>
                File Connection
            </td>
            <td>
                String
            </td>
            <td>
                The name of the file connection configuration to use.
            </td>
            <td>
                -
            </td>
            <td>
                Yes
            </td>
        </tr>
        <tr>
            <td>
               Source Directory Path
            </td>
            <td>
                String
            </td>
            <td>
                The path to the source folder containing the files that should be merged.
            </td>
            <td>
                -
            </td>
            <td>
                Yes
            </td>
        </tr>
        <tr>
            <td>
               Target File Path
            </td>
            <td>
                String
            </td>
            <td>
                Path to the folder that holds the merged file.
            </td>
            <td>
                -
            </td>
            <td>
                Yes
            </td>
        </tr>
        <tr>
            <td>
               File Pattern
            </td>
            <td>
                String
            </td>
            <td>
                The pattern that should be used for selecting the source files that should be merged.</br>
                <b>Example</b>: <code>[a-zA-Z][a-zA-Z]*.(txt|xml|jar)</code>.
            </td>
            <td>
                -
            </td>
            <td>
                No
            </td>
        </tr>
        <tr>
            <td>
               Write Mode
            </td>
            <td>
                String
            </td>
            <td>
                If the file already exists, this parameter will determine whether the existing file should be overwritten or appended during the merge.</br>
                Possible values are Ovewrite or Append.
            </td>
            <td>
                Overwrite
            </td>
            <td>
                Yes
            </td>
        </tr>
    </table>

    **Response** 

    ```xml
    <mergeFilesResult>
       <success>true</success>
       <detail>
           <numberOfMergedFiles>5</numberOfMergedFiles>
           <totalWrittenBytes>992</totalWrittenBytes>
       </detail>
    </mergeFilesResult>
    ```

    **On Error** 

    ```xml
    <mergeFilesResult>
       <success>false</success>
       <code>700102</code>
       <detail>Directory not found: file:///Users/hasitha/temp/file-connector-test/wso2/toMergesnsdfb</detail>
    </mergeFilesResult>
    ```

??? note "write"
    Writes content to a specified file.

    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Type</th>
            <th>Description</th>
            <th>Default Value</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>
                File Connection
            </td>
            <td>
                String
            </td>
            <td>
                The name of the file connection configuration to use.
            </td>
            <td>
                -
            </td>
            <td>
                Yes
            </td>
        </tr>
        <tr>
            <td>
               File Path
            </td>
            <td>
                String
            </td>
            <td>
                The path to the file that should be written (include file name and extension).
            </td>
            <td>
                -
            </td>
            <td>
                Yes
            </td>
        </tr>
        <tr>
            <td>
               Content/Expression
            </td>
            <td>
                String
            </td>
            <td>
                Static content or expression to evaluate content.
            </td>
            <td>
                The content will be fetched from the body ("$Body") of the incoming message.
            </td>
            <td>
                Yes
            </td>
        </tr>
        <tr>
            <td>
               MIME Type
            </td>
            <td>
                String
            </td>
            <td>
                The MIME type that will be applied in order to format the outgoing message.</br></br> Possible values: "Automatic","text/plain", "application/xml", "application/binary", "application/json", "text/xml".</br></br>
                If you don't want to change the MIME type of the message that has been mediated before this operation, use the default "Automatic" value. If the value is set to "application/binary", a binary file will get created with base-64 decoded content.
            </td>
            <td>
                Automatic
            </td>
            <td>
                Yes
            </td>
        </tr>
        <tr>
            <td>
               Write Mode
            </td>
            <td>
                String
            </td>
            <td>
                If the file already exists, this parameter will determine whether the existing file should be overwritten or appended. You can also specify if a new file should be created.</br>
                Possible values: Ovewrite, Append, Create New.
            </td>
            <td>
                Overwrite
            </td>
            <td>
                Yes
            </td>
        </tr>
        <tr>
            <td>
               Append New Line
            </td>
            <td>
                Boolean
            </td>
            <td>
                Specifies whether a new line should be added to the end of the file after the content is written.
            </td>
            <td>
                false
            </td>
            <td>
                Yes
            </td>
        </tr>
        <tr>
            <td>
               Encoding
            </td>
            <td>
                String
            </td>
            <td>
                Applied only when some static content or evaluated content is written.</br>
                <b>Possible Values</b>: US-ASCII, UTF-8, or UTF-16.
            </td>
            <td>
                UTF-8
            </td>
            <td>
                No
            </td>
        </tr>
        <tr>
            <td>
               Compress
            </td>
            <td>
                Boolean
            </td>
            <td>
                Specifies whether the content should be compressed after the content is written. Only available when the <b>Write Mode</b> is ‘Create New ‘or ‘OverWrite’.
            </td>
            <td>
                false
            </td>
            <td>
                No
            </td>
        </tr>
        <tr>
            <td>
               Enable Streaming
            </td>
            <td>
                Boolean
            </td>
            <td>
                Write file using the stream set to the message context.
            </td>
            <td>
                false
            </td>
            <td>
                No
            </td>
        </tr>
        <tr>
            <td>
               Enable Locking
            </td>
            <td>
                Boolean
            </td>
            <td>
                Specifies whether or not to lock the file during file write.</br></br>
                <b>Note</b>: If the connector is processing a file named 'xyz.xml', a file called 'xyz.xml.lock' is created to represent the lock (with the CREATE_NEW mode). Once the file connector operation is completed, the file is deleted. When you create the lock, you can set an expiry time as well. If the connector operation fails to create the file because it already exists, that means that another process is working on it. Then connector operation will fail and the application will have to retry. Information such as the servername and PID is written to the lock file, which may be important for debugging. 
            </td>
            <td>
                false
            </td>
            <td>
                No
            </td>
        </tr>
        <tr>
            <td>
                Add Result To
            </td>
            <td>
                String
            </td>
            <td>
                Specify where to add the result after writing the file.</br>
                <ul>
                    <li>
                        <b>Message Body</b>: The result will be added to the message property.
                    </li>
                    <li>
                        <b>Message Property</b>: The payload that was in the message body before applying the <b>file write</b> operation will remain intact.
                    </li>
                </ul>
            </td>
            <td>
                Message Body
            </td>
            <td>
                No
            </td>
        </tr>
        <tr>
            <td>
                Property Name
            </td>
            <td>
                String
            </td>
            <td>
                If the <b>Add Result To</b> attribute is set to "Message Property", specify a property name. The result of the file write operation will be added as a default scope property
                by the specified name. This property can be accessed later in the message flow. 
            </td>
            <td>
                -
            </td>
            <td>
                Yes (If <b>Add Restul To</b> is "Message Property")
            </td>
        </tr>
    </table>

    **Response** 

    ```xml
    <writeResult>
       <success>true</success>
       <writtenBytes>16</writtenBytes>
    </writeResult>
    ```

    **Error**

    ```xml
    <writeResult>
       <success>false</success>
       <code>700108</code>
       <detail>Target file already exists. Path = file:///Users/hasitha/temp/file-connector-test/copy/kandy/hasitha.txt</detail>
    </writeResult>
    ```
