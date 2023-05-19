# Security Guidelines for Production Deployment

Given below are the common security guidelines for deploying a WSO2 Micro Integrator in a **production environment**.

In addition, see the [production deployment checklist]({{base_path}}/install-and-setup/setup/deployment-best-practices/production-deployment-guidelines-mi) and any other product-specific guidelines in the respective product's documentation.

## Runtime-level security

Given below are the security guidelines for the Micro Integrator runtime.

<table>
   <thead>
      <tr class="header">
         <th>Guideline</th>
         <th>Details</th>
      </tr>
   </thead>
   <tbody>
      <tr class="odd">
         <td><p>Apply security updates</p></td>
        <td><p>Apply all the security patches relevant to your product version. Use WSO2 Updates to get the latest security patches.</p>
        <ul>
        <li>See <a href="https://updates.docs.wso2.com/en/latest/updates/overview/">WSO2 Updates</a> for details.</li>
        </ul>
        <p><strong>Note the following:</strong></p>
        <ul>
        <li>WSO2 releases security patch notifications monthly via the Support Portal. However, WSO2 issues patches immediately to customers if there are highly 
        critical issues.</li>
        <li>WSO2 does not issue patches publicly for older product versions. Community users are encouraged to use the 
        latest product version to receive all the security issues resolved until that particular product release.</li>
        <li><a href="https://docker.wso2.com/tags.php?repo=wso2mi">WSO2 Docker repository</a> releases docker images with security fixes. Users with a <a href="https://wso2.com/subscription">subscription</a> can fetch these docker images.</li>
        </ul>
        </td>
      </tr>
      <tr class="even">
         <td>
            <p>Change default keystores</p>
         </td>
         <td>
            <p>Change the default key stores and create new keys for all the cryptographic operations. WSO2 products, by default, come with a self-signed SSL key. Since these keys are public, it is recommended to configure your own keys for security purposes. Consider the following guidelines when creating the keystores:</p>
            <ul>
               <li>
                  <p>Select a key size of at least 2048 bits.</p>
               </li>
               <li>
                  <p>Use an SHA256 certificate.</p>
               </li>
               <li>
                  <p>Make sure that WSO2 default certificates do not exist in any of the keystores in your production environment. For example, be sure to delete the default public certificate in the default trust store that is shipped with the product.</p>
               </li>
            </ul>
            See <a href="{{base_path}}/install-and-setup/setup/mi-setup/security/creating_keystores/">Creating New Keystores</a> for information on how to create and configure your own keys.
            </p>
         </td>
      </tr>
      <tr class="odd">
         <td>Encrypt passwords in configuration files</td>
         <td>
            <p>WSO2 products use a tool called <strong>Secure Vault</strong> to encrypt the plain-text passwords in configuration files.</p>
            <p>See <a href="{{base_path}}/install-and-setup/setup/mi-setup/security/encrypting_plain_text/">Securing Passwords in Configuration Files</a> for instructions.</p>
         </td>
      </tr>
      <tr class="even">
         <td>
            <p>Change default ports</p>
            <p><br /></p>
         </td>
         <td>
            <p>For information on all the default ports used, see <a href="{{base_path}}/install-and-setup/setup/reference/default-product-ports-mi/">Default Product Ports</a>.</p>
            <p>For information on changing a default port, see <a href="{{base_path}}/install-and-setup/setup/deployment-best-practices/changing-the-default-ports-with-offset-mi">Changing the Default Ports with Offset</a>.</p>
        </td>
      </tr>
      <tr>
        <td>
            <p>Enable <strong>read-only access</strong> to external user stores (LDAPs etc.)</p>
        </td>
        <td>
            <p>If your product runtimes are connecting to an external user store for the purpose of reading and retrieving user information, be sure to enable read-only access to that user store.</p>
            <p>See <a href="{{base_path}}/install-and-setup/setup/mi-setup/user_stores/setting_up_a_userstore">Configuring a User Store</a> for the Micro Integrator runtime.</p>
        </td>
      </tr>
      <tr class="even">
         <td>
            <p>Always communicate (with external user stores) over TLS</p>
         </td>
         <td>
            <p>All connections from your server to external databases, userstores (LDAP), or other services, should be over TLS, to ensure adequate network-level protection. Therefore, be sure to use external systems (user stores, databases) that are TLS-enabled.</p>
         </td>
      </tr>
      <tr class="odd">
         <td>
            <p>Connect to data stores using a less privileged user</p>
         </td>
         <td>
            <p>When connecting the server to external databases or user stores (LDAP), be sure to go through a user who does not have permission to change the data store's schema. Be sure not to use the root user of the data store because all permissions are generally granted to the root user.</p>
         </td>
      </tr>
      <tr class="even">
         <td>
            <p>Configure strong HTTP(S) security</p>
         </td>
         <td>
            <p>To have strong transport-level security, use TLS 1.2 and disable SSL, TLS 1.0 and 1.1. The TLS protocol and strong ciphers are configured for the passthrough transport in the <code>deployment.toml</code> file. See the following links for instructions:</p>
            <p><a href="{{base_path}}/install-and-setup/setup/mi-setup/transport_configurations/configuring-transports/#configuring-transport-level-security">Configuring Transport-Level Security</a></p>
            <p>Note the following:</p>
            <ul>
               <li>When deciding on the TLS protocol and the ciphers, consider the compatibility with existing client applications. Imposing maximum security might cause functional problems with client applications.</li>
               <li>Apply ciphers with 256 bit key length if you have applied unlimited strength policy. Note that unlimited strength policy is recommended.</li>
               <li>
                  Also, consider the following factors when deciding on the ciphers:
                  <ul>
                     <li>DES/3DES are deprecated and should not be used.</li>
                     <li>MD5 should not be used due to known collision attacks.</li>
                     <li>RC4 should not be used due to crypto-analytical attacks.</li>
                     <li>DSS is limited to a small 1024 bit key size.</li>
                     <li>Cipher-suites that do not provide Perfect Forward Secrecy/ Forward Secrecy (PFS/FS).</li>
                     <li>GCM based ciphers are recommended over CBC ciphers.</li>
                  </ul>
               </li>
            </ul>
         </td>
      </tr>
      <tr class="odd">
         <td>
            <p>Remove weak ciphers for PassThrough transport</p>
         </td>
         <td>
            <p>Remove any weak ciphers from the PassThrough transport and ensure that the server does not accept connections using those weak ciphers. The PassThrough transport is configured using the <code>deployement.toml</code> file.
            <p>See <a href="{{base_path}}/install-and-setup/setup/mi-setup/transport_configurations/configuring-transports/#disabling-weak-ciphers">Disabling Weak Ciphers</a> for instructions.</p>
         </td>
      </tr>
      <tr class="odd">
         <td>
            <p>Increase Ephemeral Diffie-Hellman Key size</p>
         </td>
         <td>
            <p>Before starting the server, open the product startup script ( <code>           micro-integrator.sh             </code> in Linux and <code>              micro-integrator.bat             </code> in Windows) and enter the following with the other Java properties:</p>
            <div class="code panel pdl" style="border-width: 1px;">
               <div class="codeContent panelContent pdl">
                  <div class="sourceCode" id="cb1" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence">
                     <pre class="sourceCode java"><code class="sourceCode java"><span id="cb1-1"><a href="#cb1-1"></a>-Djdk.<span class="fu">tls</span>.<span class="fu">ephemeralDHKeySize</span>=<span class="dv">2048</span> \</span></code></pre>
                  </div>
               </div>
            </div>
         </td>
      </tr>
      <tr class="even">
         <td>
            <p>Disable client-initiated renegotiation</p>
            <p><br /></p>
         </td>
         <td>
            <p>Before starting the server, open the product startup script ( <code>              micro-integrator.sh             </code> in Linux and <code>              micro-integrator.bat             </code> in Windows) and enter the following with the other Java properties:</p>
            <div class="code panel pdl" style="border-width: 1px;">
               <div class="codeContent panelContent pdl">
                  <div class="sourceCode" id="cb2" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence">
                     <pre class="sourceCode java"><code class="sourceCode java"><span id="cb2-1"><a href="#cb2-1"></a>-Djdk.<span class="fu">tls</span>.<span class="fu">rejectClientInitiatedRenegotiation</span>=<span class="kw">true</span> \</span></code></pre>
                  </div>
               </div>
            </div>
         </td>
      </tr>
      <tr class="odd">
         <td>
            <p>Enable HostName Verification</p>
            <p><br /></p>
         </td>
         <td>
            <p>Make sure that hostname verification is enabled in the product startup script ( <code>              micro-integrator.sh             </code> in Linux and <code>              micro-integrator.bat             </code> in Windows) with the <strong>Strict</strong> mode. That is, you need to enable the following parameter:</p>
            <div class="code panel pdl" style="border-width: 1px;">
               <div class="codeContent panelContent pdl">
                  <div class="sourceCode" id="cb3" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence">
                     <pre class="sourceCode java"><code class="sourceCode java"><span id="cb3-1"><a href="#cb3-1"></a>-Dhttpclient.<span class="fu">hostnameVerifier</span>=Strict \</span></code></pre>
                  </div>
               </div>
            </div>
         </td>
      </tr>
      <tr class="even">
         <td>
            <p>Verify super admin credentials</p>
            <p><br /></p>
         </td>
         <td>
            <p>The user name and password of the super administrator of your Micro Integrator (the first administrator) is created by adding the following configuration to the <code>deployment.toml</code> file. When you go into production, be sure to manually check your user store and ensure that unwanted super admin records are removed.</p>
            <div class="code panel pdl" style="border-width: 1px;">
             <div class="codeContent panelContent pdl">
                <div class="sourceCode" id="cb6" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence">
                   <pre class="sourceCode java"><code class="sourceCode java"><span id="cb6-1"><a href="#cb6-1"></a>[super_admin]</span>
<span id="cb6-1"><a href="#cb6-1"></a>username = "admin"</span>
<span id="cb6-1"><a href="#cb6-1"></a>password = "admin"</span>
<span id="cb6-1"><a href="#cb6-1"></a>admin_role = "admin"</span>
<span id="cb6-1"><a href="#cb6-1"></a>create_admin_account = true</span></code></pre>
                </div>
             </div>
            </div>     
            <p> Note that you can easily use the management API to <b>add, update, and delete</b> admins and regular users in the user store. However, the super admin users created from the <code>deployment.toml</code> file should be managed manually.</p>
            <p>See the following topics for instructions to correctly create your administrators and other users in the Micro Integrator.</p>       
            <ul>
               <li><a href="{{base_path}}/install-and-setup/setup/mi-setup/user_stores/setting_up_a_userstore/">Configuring a User Store</a> for the Micro Integrator.</li>
               <li><a href="{{base_path}}/install-and-setup/setup/mi-setup/user_stores/managing_users/">Managing Users</a> for the Micro Integrator.</li>
            </ul>                   
         </td>
      </tr>
      <tr class="even">
         <td>
            <p>Enable log rotation and monitoring</p>
            <p><br /></p>
         </td>
         <td>
            <p>Ensure that you have a relevant log rotation scheme to manage logs. Log4J properties for Micro Integrator can be configured in the <code>              &lt;MI_HOME&gt;/conf/log4j2.properties             </code> file. To roll the <strong>wso2carbon.log</strong> based on size, <a href="{{base_path}}/administer/logging-and-monitoring/logging/managing-log-growth/">this</a> guide can be used.</p>
            <p>See <a href="{{base_path}}/observe/micro-integrator/classic-observability-logs/monitoring-logs/">Monitoring Logs</a> for details on how to configure logging details in WSO2 products.</p>
         </td>
      </tr>
      <tr class="odd">
         <td>
            <p>Prevent Log Forging</p>
         </td>
         <td>
            <p>Log forging can be prevented by appending a UUID to the log message.</p>
            <p>Read about <a href="{{base_path}}/observe/micro-integrator/classic-observability-logs/configuring-log4j2-properties/">configuring logs</a> in the Micro Integrator.</p>
         </td>
      </tr>
      <tr class="even">
         <td>
            <p>Set appropriate JVM parameters</p>
            <p><br /></p>
         </td>
         <td>
            <p>The recommended JDK version is JDK 11. See the <a href="{{base_path}}/install-and-setup/install/installation-prerequisites-mi/">installation pre-requisites</a> for more information.</p>
            <p><strong>Tip</strong>: To run the JVM with 2 GB (-Xmx2048m), you should ideally have about 4GB of memory on the physical machine.</p>
         </td>
      </tr>
   </tbody>
</table>

## OS-level security

This section provides the list of OS-level security guidelines for your production environment.

<table>
<thead>
<tr class="header">
<th>Guideline</th>
<th>Details</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p>Run WSO2 processes with a specific OS-level user</p></td>
<td><p>Use a separate OS-level user to run WSO2 products. Make sure that the user is only granted the permissions required for running the product for that particular user. Do not use the root/administrator user of your OS because the root/administrator is granted all privileges by default.</p></td>
</tr>
<tr class="even">
<td><p>Minimize software to avoid vulnerability</p></td>
<td><p>Make sure that you only install the software/packages that are relevant to your WSO2 product's deployment. Also, continuously monitor the software that you install.</p>
<p>For information on the minimum software that your WSO2 product will need, see <a href="{{base_path}}/install-and-setup/install/installation-prerequisites-mi/#system-requirements">Installation Prerequisites</a>.</p></td>
</tr>
<tr class="odd">
<td><p>Enable the Firewall</p></td>
<td><p>Enable a firewall at the OS level (for example, <a href="https://help.ubuntu.com/community/IptablesHowTo">iptables</a>). This will provide protection for inbound and outbound connections of your WSO2 product. Make sure that you only open the required outbound and inbound ports from the OS-level firewall.</p></td>
</tr>
<tr class="even">
<td>Restrict access to TCP ports used for clustering</td>
<td>Apply a firewall at the host-level to disallow access to TCP ports used for clustering (port 4000, 4001, … by default) from unrecognized hosts. These ports should be accessible only from other members of the WSO2 product cluster.</td>
</tr>
<tr class="odd">
<td><p>Use Secure Shell(SSH)</p>
<p><br />
</p></td>
<td><p>Use Secure Shell (SSH) when interacting with servers and executing commands. Adhere to the following best practices when you configure SSH:</p>
<ul>
<li>Change the default SSH port to a higher value.</li>
<li>Disable the root or administrator.</li>
<li>Enable login with user keys.</li>
<li>Display a legal banner or a security banner with security warnings before SSH authentication.</li>
</ul></td>
</tr>
<tr class="even">
<td><p>Keep the system up-to-date</p></td>
<td><p>If there are security updates available for the packages installed in your OS (including the Java runtime), be sure to perform the necessary testing in a staging environment, and then proceed to install them for your OS.</p></td>
</tr>
<tr class="odd">
<td><p>Monitor user activities</p></td>
<td><p>Monitor the activities of your OS users. You can do this by enabling OS-level logs and by reviewing them regularly. You can also set up a centralized log monitoring system for this purpose.</p></td>
</tr>
<tr class="even">
<td>Session Data Cleanup</td>
<td>
<div style="background-color:#ffffff; padding: 10px;">
<p><strong>Note:</strong> This security guideline is only applicable to WSO2 Identity Server.</p>

<p>In a production environment, there is a possibility for a deadlock or a database lock to occur when running a session 
data cleanup task in high load scenarios. To mitigate this, configure the following property to clean data in chunks.
 Configure this property in the <code&lt;IS_HOME&gt;/repository/conf/deployment.toml</code> file under
  <code>session_data</code> with the required chunk size. This value is in the number of records and depends on the database type and server capacity. It also depends on the amount of load generated by single sign-on (SSO). A higher value increases the chances of deadlocks and a lower value increases the time it takes for a cleanup.</p>
<pre class="java" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence"><code>[session_data]
cleanup.clean_expired_session_data_in_chunks_of = 8192</code></pre>
<p>For more information on configuring sessions in production, see <a href="https://is.docs.wso2.com/en/5.10
.0/learn/authentication-session-persistence/">Authentication Session Persistence</a> in the WSO2 Identity Server 
documentation.</p></div></td>
</tr>
<tr class="odd">
<td><p>Make regular backups</p></td>
<td><p>Make sure to back up important files and archive them continuously. For more information, see <a 
href="{{base_path}}/install-and-setup/setup/deployment-best-practices/backup-recovery">Backup and Recovery Recommendations</a>.</p></td>
</tr>
</tbody>
</table>

## Network-level security

This section provides a list of security guidelines for configuring the network.

<table>
<thead>
<tr class="header">
<th><b>Guideline</b></th>
<th><b>Details</b></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p>Create a failover setup</p>
<p><br />
</p></td>
<td>In the cloud native deployment, high-availability should be achieved via the container orchestration system (e.g., Kubernetes ). 
<p>In a VM deployment, there should be at least two nodes with the failover configuration. When your servers are clustered, you need to regularly monitor the health of your server instances. For example, you need to monitor resource-level factors such as the server's resource utilization, response time anomalies, and the number of incoming network connections. Server monitoring will help you identify when additional server instances (failover instances) are required. You can also make decisions about network routing changes that you need to do in order to avoid server downtime.</p>
</td>
</tr>
<tr class="even">
<td><p>Maintain network-level logging</p></td>
<td><p>Be sure to maintain and monitor logs for your proxy servers, load balancers, and other network devices.</p></td>
</tr>
<tr class="odd">
<td><p>Check open ports and services</p></td>
<td><p>Periodically check for open ports using port scanning tools and make sure that only the necessary ports are open to both internal and external networks. Be sure that only the ports relevant to your WSO2 products are open for communication. If there are other ports started, be sure to monitor them.</p>
<p>For the full list of ports in all WSO2 products, see <a href="{{base_path}}/install-and-setup/setup/reference/default-product-ports-mi/">Default Product Ports</a>.</p></td>
</tr>
<tr class="even">
<td><p>Configure device-level security</p></td>
<td><p>All your network devices should be periodically checked for anomalies. For example, you need to verify routing tables and firewall rules.</p>
<p>Also, make sure that the default credentials are changed before the first use of those devices.</p></td>
</tr>
<tr class="odd">
<td><p>Apply firmware updates</p></td>
<td><p>Firmware updates for your network devices should be applied regularly.</p></td>
</tr>
</tbody>
</table>
