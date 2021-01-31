# VFS Parameters

When you implement an integration use case that requires file processing, you can use the following VFS parameters in your [proxy service]({{base_path}}/integrate/develop/creating-artifacts/creating-a-proxy-service) artifact.

!!! Info
    The VFS transport is enabled and configured for the Micro Integrator by default, which allows you to run VFS use cases without any server configurations. Read about the [VFS transport]({{base_path}}/install-and-setup/transport_configurations/configuring-transports/#configuring-the-vfs-transport).

{!reference/synapse-properties/pull/proxy-service-add-properties-pull.md!}

See [Creating a Proxy Service]({{base_path}}/integrate/develop/creating-artifacts/creating-a-proxy-service) for instructions.

## Service-Level Parameters

<table>
   <thead>
      <tr>
         <th>
          Parameter
         </th>
         <th>
          Description
         </th>
      </tr>
   </thead>
   <tbody>
      <tr>
         <td id="vfs-transport-file_url">
            transport.vfs.FileURI
         </td>
         <td>
            <div class="content-wrapper">
               The URI of the location of your files. This should be the source location of the files (if you are configuring the Micro Integrator to read files) or the destination of the files (if you are configuring the Micro Integrator to send files). You can specify connection-level parameters on the URL (see <a href="#vfs-url-parameters">VFS URL parameters</a> below).</p>
               When you need to access the absolute path of the URL, you can define the URL with <code>sftpPathFromRoot</code> as shown below. Also, note that <a href="#vfs-transport-avoid_permissions">transport.vfs.AvoidPermissionCheck</a> is a mandatory parameter for this URL when SFTP is used.
               <div class="code panel pdl" style="border-width: 1px;">
                  <div class="codeContent panelContent pdl">
                     <div class="sourceCode" id="cb1" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence">
                        <pre class="sourceCode java"><code class="sourceCode java"><span id="cb1-1"><a href="#cb1-1"></a>&lt;parameter name=<span class="st">&quot;transport.vfs.FileURI&quot;</span>&gt;sftp:<span class="co">//[ username[: password]@] hostname[: port][ absolute-path]?sftpPathFromRoot=true;transport.vfs.AvoidPermissionCheck=true&lt;/parameter&gt;</span></span></code></pre>
                     </div>
                  </div>
               </div>
            </div>
            You need to specify a valid file URI in the following form: <code>file://path</code>.
         </td>
      </tr>
      <tr>
         <td>
           transport.vfs.ContentType
         </td>
         <td>
            Content type of the files processed by the transport. To specify the encoding, follow the content type with a semi-colon and the character set. For example: <code>parameter name="transport.vfs.ContentType“text/plain;charset=UTF-32/parameter</code>.</br></br>
            When writing a file, you can set a different encoding with the <code>CHARACTER_SET_ENCODING</code> property: <code>property name="CHARACTER_SET_ENCODING" value="UTF-8" scope="axis2" type="STRING"/</code>.</br>
            Specify a valid content type. For example, <code>text/xml</code>. You can specify the encoding after the content type, such as <code>text/plain;charset=UTF-32</code>.
         </td>
      </tr>
      <tr>
         <td>
            transport.vfs.FileNamePattern
         </td>
         <td>
            If the VFS listener should process only a subset of the files available at the specified file URI location, use this parameter to select those files by name using a regular expression. Specify a regular expression. For example: <code>*\.xml</code>.
         </td>
      </tr>
      <tr>
         <td>
          transport.PollInterval
         </td>
         <td>
            The polling interval for the transport receiver to poll the file URI location. The value is expressed in seconds unless you add "ms" for milliseconds. For example, "2" or "2000ms" to specify 2 seconds. Specify a positive integer.
         </td>
      </tr>
      <tr>
         <td>
           transport.vfs.ActionAfterProcess
         </td>
         <td>
           Whether to move, delete or take no action on the files after the transport has processed them. Possible values are <code>MOVE</code>, <code>DELETE</code>, or <code>NONE</code>. The default value is <code>DELETE</code>.
         </td>
      </tr>
      <tr>
         <td>
            transport.vfs.ActionAfterFailure
         </td>
         <td>
            Whether to move, delete or take no action on the files if a failure occurs. Possible values are <code>MOVE</code>, <code>DELETE</code>, or <code>NONE</code>. The default value is <code>DELETE</code>.
         </td>
      </tr>
      <tr>
         <td>
            transport.vfs.MoveAfterProcess
         </td>
         <td>
            Where to move the files after processing if **ActionAfterProcess** is MOVE. This parameter is required if the <b>ActionAfterProcess</b> is <code>MOVE</code>.
         </td>
      </tr>
      <tr>
         <td>
            transport.vfs.MoveAfterFailure
         </td>
         <td>
            Where to move the files after processing if **ActionAfterFailure** is MOVE. This parameter is required if the <b>ActionAfterFailure</b> is <code>MOVE</code>.
         </td>
      </tr>
      <tr>
         <td>
            transport.vfs.ReplyFileURI
         </td>
         <td>
           The location where reply files should be written by the transport.
         </td>
      </tr>
      <tr>
         <td>
            transport.vfs.ReplyFileName
         </td>
         <td>
            The name for reply files written by the transport. The default value is <code>response.xml</code>.
         </td>
      </tr>
      <tr>
         <td>
           transport.vfs.MoveTimestampFormat
         </td>
         <td>
            The pattern/format of the timestamps added to file names as prefixes when moving files. Specify a valid <a href="http://docs.oracle.com/javase/7/docs/api/java/text/SimpleDateFormat.html">timestamp pattern</a>. For example, <code>yyyy-MM-dd'T'HH:mm:ss.SSSZ</code>.
         </td>
      </tr>
      <tr>
         <td>
            transport.vfs.Streaming
         </td>
         <td>
            Whether files should be transferred in streaming mode, which is useful when transferring large files. The default setting is <code>false</code>.
         </td>
      </tr>
      <tr>
         <td>
            transport.vfs.ReconnectTimeout
         </td>
         <td>
            Reconnect timeout value in seconds to be used in case of an error when transferring files. Specify a positive integer. The default values is <code>30</code> seconds.
         </td>
      </tr>
      <tr>
         <td>
            transport.vfs.MaxRetryCount
         </td>
         <td>
            Maximum number of retry attempts to carry out in case of errors. Specify a positive integer. The default values is <code>3</code>.
         </td>
      </tr>
      <tr>
         <td>
           transport.vfs.Append
         </td>
         <td>
            When writing the response to a file, whether the response should be appended to the response file instead of overwriting the file. This value should be defined as a query parameter in the out/reply file URI. For example:<br />
               <code>vfs:file:///home/user/test/out?transport.vfs.Append=true</code><br />
            or,
            <code>parameter name="transport.vfs.ReplyFileURI"file:///home/user/test/out?transport.vfs.Append=true/parameter</code>.<br />
            By default, the parameter is set to <code>false</code> (the response file will be completely overwritten).
         </td>
      </tr>
      <tr>
         <td>
            transport.vfs.MoveAfterFailedMove
         </td>
         <td>
           Where to move the failed file.
         </td>
      </tr>
      <tr>
         <td>
            transport.vfs.FailedRecordsFileName
         </td>
         <td>
            The name of the file that maintains the list of failed files. Example file name: vfs-move-failed-records.properties.
         </td>
      </tr>
      <tr>
         <td>
            transport.vfs.FailedRecordsFileDestination
         </td>
         <td>
            Where to store the failed records file.
         </td>
      </tr>
      <tr>
         <td>
            transport.vfs.MoveFailedRecordTimestampFormat
         </td>
         <td>
            Entries in the failed records file include the name of the file that failed and the timestamp of its failure. This property configures the time stamp format. Specify a valid <a href="http://docs.oracle.com/javase/7/docs/api/java/text/SimpleDateFormat.html">timestamp pattern</a>. For example, <code>yyyy-MM-dd'T'HH:mm:ss.SSSZ</code>. By default, the parameter is set to <code>dd-MM-yyyy HH:mm:ss</code>.
         </td>
      </tr>
      <tr>
         <td>
            transport.vfs.FailedRecordNextRetryDuration
         </td>
         <td>
           The time in milliseconds to wait before retrying the move task. Specify a positive integer. The default value is <code>3000</code> miliseconds.
         </td>
      </tr>
      <tr>
         <td>
            transport.vfs.Locking
         </td>
         <td>
            By default, file locking is enabled in the VFS transport. This parameter lets you configure the locking behavior on a per service basis. You can also disable locking globally by specifying the parameter at the receiver level and selectively enable locking only for a set of services. The setting is enabled by default.
         </td>
      </tr>
      <tr>
         <td>transport.vfs.FileProcessCount
         </td>
         <td>This setting allows you to throttle the VFS listener by processing files in batches. Specify the number of files you want to process in each batch. Specify a positive integer such as <code>10</code>.</br></br>
          <b>Note</b>: If you specify the <code>transport.vfs.FileProcessCount</code> parameter, you do not need to specify the <code>transport.vfs.FileProcessInterval</code> parameter in a configuration, and vice versa. These two parameters cannot be used at the same time.</td>
      </tr>
      <tr>
         <td>transport.vfs.FileProcessInterval
         </td>
         <td>The interval in milliseconds between two file processes. Specify a positive integer, such as <code>10</code></td>
      </tr>
      <tr>
         <td>transport.vfs.ClusterAware</td>
         <td>Whether VFS coordination support is enabled in a clustered deployment or not. By default, this setting is set to <code>false</code>.</td>
      </tr>
      <tr>
         <td>transport.vfs.FileSizeLimit</td>
         <td>Only file sizes that are less than or equal to the defined limit are processed. Specify the file size in bytes. The default value is <code>-1</code>(unlimited file size).</td>
      </tr>
      <tr>
         <td>transport.vfs.AutoLockReleaseInterval</td>
         <td>
            The timeout value for stale locks where the VFS transport will ignore those file locks once the defined time period is reached. The time period is calculated from the time the lock is created to the time you attempt to access it. If you need stale locks to never timeout provide -1 as the timeout value. Specify the time in miliseconds. The default value is <code>20000</code>.
         </td>
      </tr>
      <tr>
         <td>transport.vfs.SFTPIdentities</td>
         <td>Location of the private key.</td>
      </tr>
      <tr>
         <td>transport.vfs.SFTPIdentityPassPhrase</td>
         <td>Passphrase of the private key.</td>
      </tr>
      <tr>
         <td>transport.vfs.SFTPUserDirIsRoot</td>
         <td>If the SFTP user directory should be treated as root. By default, this parameter is set to <code>true</code>.</td>
      </tr>
      <tr>
         <td>transport.vfs.ResolveHostsDynamically</td>
         <td>
            Whether hostnames should be resolved at the time of deployment or whether it is necessary to resolve hostnames dynamically at runtime. By default hostnames are resolved at the time of deployment. If you want to resolve hostnames at runtime, set this parameter to <code>true</code>.
            <b>Note</b>: Resolving hostnames at runtime is only possible for the Server Message Block (SMB) protocol. </br>
            By default, this setting is <code>false</code>.
         </td>
      </tr>
      <tr>
         <td>
            transport.vfs.DistributedLock
         </td>
         <td>
            This applies only in cluster deployments. Set to <code>true</code> if you need to avoid multiple servers trying to process the same file simultaneously.
         </td>
      </tr>
      <tr>
         <td>
          transport.vfs.DistributedTimeout
         </td>
         <td>
            The timeout period in seconds for the distributed lock. Specify a positive integer, such as <code>10</code>.
         </td>
      </tr>
      <tr>
         <td>
          transport.vfs.AutoLockRelease
         </td>
         <td>
            Set to <code>true</code> if you need to release locking in order to avoid files not being processed due to faulty locking. This works together with the <code>transport.vfs.AutoLockReleaseInterval</code> and <code>transport.vfs.LockReleaseSameNode</code> parameters.
         </td>
      </tr>
      <tr>
         <td>
          transport.vfs.LockReleaseSameNode
         </td>
         <td>Set to <code>true</code> if you need to release the locks only accrued by the same worker node.<br />
            If this is set to <code>false</code>, locks accrued by other nodes will be released according to the value specified in <code>transport.vfs.AutoLockReleaseInterval</code>. By default, this setting is <code>true</code>.
         </td>
      </tr>
      <tr>
         <td>transport.vfs.FileSortAttribute</td>
         <td>The attribute by which the files should be sorted and processed. The possible values are <code>NONE</code>, <code>Size</code>, or <code>Lastmodifiedtimestamp</code>.</td>
      </tr>
      <tr>
         <td>transport.vfs.FileSortAsscending</td>
         <td>
            The sort order to sort and process the files. If set to <code>true</code>, files will be sorted in ascending order based on the attribute you specify in <code>transport.vfs.FileSortAttribute</code>. By default, this setting is <code>true</code>.
         </td>
      </tr>
      <tr>
         <td>transport.vfs.CreateFolder</td>
         <td>
            Set to <code>true</code> to create a folder if a folder does not exist when moving files. By default, this setting is <code>false</code>.
         </td>
      </tr>
      <tr>
         <td>transport.vfs.SubFolderTimestampFormat</td>
         <td>
            The pattern/format of the timestamps added to the folder structure when moving files. You need to set <code>transport.vfs.CreateFolder</code> to <code>true</code> in order to specify a value for this parameter. Specify a valid <a href="http://docs.oracle.com/javase/7/docs/api/java/text/SimpleDateFormat.html">timestamp pattern</a>. For example, <code>yyyy-MM-dd'T'HH:mm:ss.SSSZ</code>.
         </td>
      </tr>
      <tr>
         <td>transport.vfs.Build</td>
         <td>
            Set to <code>true</code> if you need to build the content inside the file before injecting the file to the mediation engine. If there is a build error, the file will not be injected to the mediation engine. By default, this setting is <code>false</code>.
         </td>
      </tr>
   </tbody>
</table>

The following service-level parameters are required for Inbound Endpoints.

<table>
   <tr>
    <th>
      Parameter
    </th>
    <th>
      Description
    </th>
  </tr>
   <tbody>
      <tr>
         <td>interval</td>
         <td>The time duration in milliseconds between two file scans that checks for updates.</td>
      </tr>
      <tr>
         <td>sequential</td>
         <td>Files will be processed sequentially when this parameter is set to true.</td>
      </tr>
      <tr>
         <td>coordination</td>
         <td>
            <p>This should be true for clustered deployments in order to prevent two nodes from retrieving the same file.</p>
         </td>
      </tr>
   </tbody>
</table>

### VFS URL Parameters

When you use the [transport.vfs.FileURI](#vfs-transport-file_url) parameter, you can set connection-specific VFS parameters as URL query parameters. For example, to use SFTP with SSL, you could specify the URL as shown below. Note that [transport.vfs.AvoidPermissionCheck](#vfs-transport-avoid_permissions) is a mandatory parameter for this URL when SFTP is used.

```bash
<parameter name="transport.vfs.FileURI">vfs:ftps://test:test123@10.200.2.63/vfs/in?vfs.ssl.keystore=/home/user/openssl/keystore.jks&amp;vfs.ssl.truststore=/home/user/openssl/vfs-truststore.jks&amp;vfs.ssl.kspassword=importkey&amp;vfs.ssl.tspassword=wso2vfs&amp;vfs.ssl.keypassword=importkey;transport.vfs.AvoidPermissionCheck=true</parameter>
```
<table>
   <thead>
      <tr>
         <th>
           Parameter
         </th>
         <th>
           Description
         </th>
      </tr>
   </thead>
   <tbody>
      <tr>
         <td id="vfs-transport-avoid_permissions">
            transport.vfs.AvoidPermissionCheck
         </td>
         <td>
            <b>Be sure</b> to set this parameter to <strong>true</strong> for an SFTP connection. This is because (by default) the VFS transport checks whether the user has permission to access the location of the files (the source location or the destination). However, since the system is reading files in an external server through the SFTP connection, this permission check is not required and should be avoided.
         </td>
      </tr>
      <tr>
         <td>
           vfs.passive
         </td>
         <td>
           Enable FTP passive mode. This is required when the FTP client and server are not in the same network. By default, this setting is <code>false</code>.
         </td>
      </tr>
      <tr>
         <td>transport.vfs.Append</td>
         <td>
            If a file with same name exists, this parameter tells whether to create a new file and write content or append content to existing file. By default, this setting is <code>false</code>.
         </td>
      </tr>
      <tr>
         <td>vfs.protection</td>
         <td>
            Set data channel protection level using FTP PROT command. Possible values are as follows:
            <ul>
               <li>C - Clear</li>
               <li>S - Safe(SSL protocol only)</li>
               <li>E - Confidential(SSL protocol only)</li>
               <li>P - Private</li>
            </ul>
            The default value is <code>C</code>.
         </td>
         <td>
      </tr>
      <tr>
         <td>vfs.ssl.keystore</td>
         <td>Private key store to use for mutual SSL. Your keystore must be signed by a certificate authority. For more information, see <a href="index">http://docs.oracle.com/cd/E19509-01/820-3503/ggfen/index.html</a>. Possible value: String (Path of keystore).</td>
      </tr>
      <tr>
         <td>vfs.ssl.kspassword</td>
         <td>Private key store password.</td>
      </tr>
      <tr>
         <td>vfs.ssl.keypassword</td>
         <td>Private key password</td>
      </tr>
      <tr>
         <td>vfs.ssl.truststore</td>
         <td>Trust store to use for SFTP</td>
      </tr>
      <tr>
         <td>vfs.ssl.tspassword</td>
         <td>Trust store password</td>
      </tr>
      <tr>
         <td>transport.vfs.CreateFolder</td>
         <td>If the directory does not exists create and write the file. The default setting is <code>false</code>.</td>
      </tr>
      <tr>
         <td>transport. vfs.SendFileSynchronously</td>
         <td>
            Whether to send files synchronously to the file host. When this parameter is set to <code>true</code>, files will be sent one after another to the file host. This synchronous write can be configured on a per host basis. The default setting is <code>false</code>.
         </td>
      </tr>
   </tbody>
</table>

## Configuring a Proxy Server over FTP and SFTP

Proxy server specific parameters can be set as URL query parameters. For example, to use Proxy over FTP, you could specify the URL as follows:

```bash
ftp://username:password@127.0.0.1/home/wso2/res?proxyServer=127.0.0.1&proxyPort=3128&proxyUsername=proxyuser&proxyPassword=proxyPass&timeout=2500&retryCount=3
```

Following are the URL parameters you can set:

<table>
   <thead>
      <tr>
         <th>
            Parameter
         </th>
         <th>
            Description
         </th>
      </tr>
   </thead>
   <tbody>
      <tr>
         <td>
            <p>proxyServer</p>
         </td>
         <td>
            The IP address of the proxy server. Possible value: <code>127.0.0.1</code>. This parameter is set to <code>false</code> by default.
         </td>
      </tr>
      <tr>
         <td>
            <p>proxyPort</p>
         </td>
         <td>The port number on which the proxy server is listening for requests. Possible value: <code>1328</code>. This parameter is set to <code>false</code> by default.</td>
      </tr>
      <tr>
         <td>proxyType</td>
         <td>
            The proxy server type. This can either be <code>HTTP</code> or <code>SOCKS</code>. The default is <code>SOCKS</code>.
            <b>Note</b>: In a configuration, if the proxy server type is not specified or an unknown proxy server type is specified, the <code>proxyType</code> will be considered as <code>HTTP</code>.
         </td>
      </tr>
      <tr>
         <td>
            proxyUsername
         </td>
         <td>The user name of the proxy server.</td>
      </tr>
      <tr>
         <td>
            proxyPassword
         </td>
         <td>The password of the proxy server.</td>
      </tr>
      <tr>
         <td>
           timeout
         </td>
         <td>
            The connection timeout in milliseconds. Possible value: <code>1000</code>. The default value is <code>5000</code>.
         </td>
      </tr>
      <tr>
         <td>
           retryCount
         </td>
         <td>The number of retry attempts in case of a connection timeout. Possible value: <code>3</code>. The default value is <code>5</code>.</td>
      </tr>
   </tbody>
</table>
