# Product Startup Options

Given below are the options that are available when starting a WSO2 product. The product startup scripts are stored in the `<PRODUCT_HOME>/bin/` directory. When you execute the startup script, you can pass a system property by appending it next to the start-up script as shown below.

``` java
    sh api-manager.sh -<startup option>
```

For example:

``` java
    ./api-manager.sh -Dsetup (In Linux)
    api-manager.bat -Dsetup (In Windows)
```

Listed below are some general options that can be used for starting the server.

| Startup Option      | Description                                                                                         |
|---------------------|-----------------------------------------------------------------------------------------------------|
| -start              | Starts the Carbon server using "nohup" in the background. This option is not available for Windows. |
| -stop               | Stops the Carbon server process. This option is not available for Windows.                          |
| -restart            | Restarts the Carbon server process. This option is not available for windows.                       |
| -cleanRegistry      | Cleans the registry space. **Caution:** All registry data will be lost.                             |
| -debug &lt;port&gt; | Starts the server in remote debugging mode. The remote debugging port should be specified.          |
| -version            | Shows the version of the product that you are running.                                              |
| -help               | Lists all the available commands and system properties.                                             |

Listed below are some system properties that can be used when starting the server.

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<thead>
<tr class="header">
<th>Startup Options</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>-DosgiConsole=[port]</td>
<td>Starts the Carbon server with the Equinox OSGi console. If the optional 'port' parameter is provided, a telnet port will be opened.</td>
</tr>
<tr class="even">
<td>-DosgiDebugOptions=[options-file]</td>
<td>Starts the Carbon server with OSGi debugging enabled. Debug options are loaded from the <code>             &lt;PRODUCT_HOME&gt;/repository/conf/etc/osgi-debug.options            </code> .</td>
</tr>
<tr class="odd">
<td>-Dsetup</td>
<td>Cleans the registry and other configurations, recreates DB, re-populates the configuration and starts the server. <strong>Note:</strong> It is not recommended to use this option in a production environment. Instead, you can manually run the DB scripts directly in the database.</td>
</tr>
<tr class="even">
<td>-DworkerNode</td>
<td><p>Starts the product as a worker node, which means the front-end features of your product will not be enabled.</p>
!!! note
<p>Note that from Carbon 4.4.1 onwards, you can also start the worker profile by setting the following system property to 'true' in the product startup script before the script is executed.</p>
<div class="code panel pdl" style="border-width: 1px;">
<div class="codeContent panelContent pdl">
<pre class="java" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence"><code>-DworkerNode=false</code></pre>
</div>
</div>
</td>
</tr>
<tr class="odd">
<td>-DserverRoles=&lt;roles&gt;</td>
<td>A comma separated list of roles used in deploying Carbon applications.</td>
</tr>
<tr class="even">
<td>-Dprofile=&lt;profileName&gt;</td>
<td>Starts the server with the specified profile, e.g., worker profile.</td>
</tr>
<tr class="odd">
<td>-Dtenant.idle.time=&lt;time&gt;</td>
<td>If a tenant is idle for the specified time, the tenant will be unloaded. The default tenant idle time is 30 minutes. This is required in clustered setups, which has master and worker nodes.</td>
</tr>
</tbody>
</table>


