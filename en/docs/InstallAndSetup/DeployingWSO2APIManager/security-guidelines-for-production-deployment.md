# Security Guidelines for Production Deployment

Given below are the common security guidelines for deploying a WSO2 product in a **production environment.**

Also, see the [production deployment guidelines](https://docs.wso2.com/display/ADMIN44x/Production+Deployment+Guidelines) and any other product-specific guidelines that might come in the respective product's documentation.

-   [WSO2 product-level security](#SecurityGuidelinesforProductionDeployment-WSO2product-levelsecurity)
-   [OS-level security](#SecurityGuidelinesforProductionDeployment-OS-levelsecurity)
-   [Network-level security](#SecurityGuidelinesforProductionDeployment-Network-levelsecurity)

### WSO2 product-level security

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
<td><p>Apply all the security patches relevant to your product version. If your WSO2 product version is supported by WSO2 Update Manager (WUM), you need to use WUM to get the latest fixes.</p>
<ul>
<li>If your WSO2 product is listed as a WUM-supported product <a href="http://wso2.com/update/">here</a> , follow the instructions in <a href="https://docs.wso2.com/display/updates/Getting+Started">Getting Started with WUM</a> .</li>
<li><p>If you are using an older WSO2 product version, which is not WUM-supported, you need to download the security patches relevant to your product from the <a href="http://wso2.com/security-patch-releases/">WSO2 Security Patch Release</a> page and apply them to your system manually. The instructions are given in <a href="https://docs.wso2.com/display/ADMIN44x/WSO2+Patch+Application+Process">WSO2 Patch Application Process</a> .</p></li>
</ul>
!!! note
<p><strong>Note the following:</strong></p>
<ul>
<li>WSO2 releases security patch notifications monthly via the Support Portal and the above mentioned <a href="http://wso2.com/security-patch-releases">WSO2 Security Patch Releases</a> page. However, for highly critical issues, patches are issued immediately to customers.</li>
<li>The <a href="http://wso2.com/security-patch-releases">WSO2 Security Patch Release</a> page has all the security patches for the latest product versions. WSO2 does not issue patches publicly for older product versions. Community users are encouraged to use the latest product version to receive all the security fixes.</li>
</ul>
</td>
</tr>
<tr class="even">
<td><p>Change default keystores</p></td>
<td><p>Change the default key stores and create new keys for all the cryptographic operations. WSO2 products by default come with a self-signed SSL key. Since these keys are public, it is recommended to configure your own keys for security purposes. Consider the following guidelines when creating the keystores:</p>
<ul>
<li><p>Select a key size of at least 2048 bits.</p></li>
<li><p>Use an SHA256 certificate.</p></li>
<li><p>Make sure that WSO2 default certificates do not exist in any of the keystores in your production environment. For example, be sure to delete the default public certificate in the default trust store that is shipped with the product.</p></li>
</ul>
<p>See the <a href="https://docs.wso2.com/display/ADMIN44x/Using+Asymmetric+Encryption#UsingAsymmetricEncryption-recommendations">recommendations for using keystores in WSO2 products</a> for information.<br />
See <a href="https://docs.wso2.com/display/ADMIN44x/Creating+New+Keystores">Creating New Keystores</a> for information on how to create and configure your own keys.</p></td>
</tr>
<tr class="odd">
<td>Encrypt passwords in configuration files</td>
<td><p>WSO2 products use a tool called <strong>Secure Vault</strong> to encrypt the plain-text passwords in configuration files.</p>
<p>See <a href="https://docs.wso2.com/display/ADMIN44x/Securing+Passwords+in+Configuration+Files">Securing Passwords in Configuration Files</a> for instructions.</p></td>
</tr>
<tr class="even">
<td><p>Change default ports</p>
<p><br />
</p></td>
<td><p>All the default ports used by WSO2 products are listed in <a href="https://docs.wso2.com/display/ADMIN44x/Default+Ports+of+WSO2+Products">Default Ports of WSO2 Products</a> . For example, the default HTTPS port is 9443 and the HTTP port is 9763. Also, Axis2 services are exposed over the following ports: 8243 and 8280.</p>
<p>To change a default port, update the <code>              &lt;Offset&gt;             </code> element in the <code>              carbon.             </code> xml file as explained in <a href="https://docs.wso2.com/display/ADMIN44x/Changing+the+Default+Ports">Changing the Default Ports</a> .</p></td>
</tr>
<tr class="odd">
<td><p>Enable <strong>read-only access</strong> to external user stores (LDAPs etc.)</p></td>
<td><p>If your WSO2 product is connecting to an external user store, such as Microsoft Active Directory, for the purpose of reading and retrieving user information, be sure to enable read-only access to that user store.</p>
<p>For example, see <a href="https://docs.wso2.com/display/ADMIN44x/Configuring+a+Read-Only+LDAP+User+Store">Configuring a Read-Only LDAP User Store</a> under <a href="https://docs.wso2.com/display/ADMIN44x/Configuring+User+Stores">Configuring User Stores</a> for instructions.</p></td>
</tr>
<tr class="even">
<td><p>Always communicate (with external user stores) over TLS</p></td>
<td><p>All connections from your WSO2 product to external databases, userstores (LDAP), or other services, should be over TLS, to ensure adequate network-level protection. Therefore, be sure to use external systems (user stores, databases) that are TLS-enabled.</p></td>
</tr>
<tr class="odd">
<td><p>Connect to data stores using a less privileged user</p></td>
<td><p>When connecting the WSO2 product to external databases or user stores (LDAP), be sure to go through a user who does not have permission to change the data store's schema. Be sure not to use the root user of the data store because all permissions are generally granted to the root user.</p></td>
</tr>
<tr class="even">
<td><p>Configure strong HTTP(S) security</p></td>
<td><p>To have strong transport-level security, use TLS 1.2 and disable SSL, TLS 1.0 and 1.1. The TLS protocol and strong ciphers are configured for an HTTP connector in the catalina <code>              -server.             </code> xml file (using the <code>              sslEnabledProtocols             </code> and <code>              ciphers             </code> attributes). See the following links for instructions:</p>
<ul>
<li><a href="https://docs.wso2.com/display/ADMIN44x/Configuring+Transport+Level+Security">Configuring Transport-Level Security</a></li>
<li><a href="https://docs.wso2.com/display/ADMIN44x/Supported+Cipher+Suites">Supported Cipher Suites</a></li>
</ul>
!!! note
<p>Note the following:</p>
<ul>
<li>When deciding on the TLS protocol and the ciphers, consider the compatibility with existing client applications. Imposing maximum security might cause functional problems with client applications.</li>
<li>Apply ciphers with 256 bits key length if you have applied the Unlimited strength policy. Note that Unlimited strength policy is recommended.</li>
<li>Also, consider the following factors when deciding on the ciphers:
<ul>
<li>DES/3DES are deprecated and should not be used.</li>
<li>MD5 should not be used, due to known collision attacks.</li>
<li>RC4 should not be used, due to crypto-analytical attacks.</li>
<li>DSS is limited to a small 1024 bit key size.</li>
<li>Cipher-suites that do not provide Perfect Forward Secrecy/ Forward Secrecy (PFS/FS).</li>
<li>GCM based ciphers are recommended over CBC ciphers.</li>
</ul></li>
</ul>
</td>
</tr>
<tr class="odd">
<td><p>Remove weak ciphers for PassThrough transport</p></td>
<td>!!! note
<p>Applicable only to products that use the PassThrough transport, such as WSO2 API Manager and WSO2 Enterprise Integrator (ESB profile).</p>

<p>Remove any weak ciphers from the PassThrough transport and ensure that the server does not accept connections using those weak ciphers. The PassThrough transport is configured using the <code>              axis2.             </code> xml file (stored in the <code>              &lt;PRODUCT_HOME&gt;/repository/conf/axis2/             </code> directory. You need to add the <code>              PreferredCiphers             </code> parameter under the &quot;Transport Ins (Listeners)&quot; section along with the list of relevant cipher suites.</p>
<p>See <a href="https://docs.wso2.com/display/ADMIN44x/Configuring+Transport+Level+Security">Configuring the PassThrough Transport</a> for instructions.</p></td>
</tr>
<tr class="even">
<td><p>Update the HTTP Response header &quot;Server&quot; value</p></td>
<td><p>By default, all WSO2 products pass &quot;WSO2 Carbon Server&quot; as the server value in HTTP headers when sending HTTP responses. This means that information about the WSO2 product stack will be exposed through HTTP responses. It is recommended to change this by configuring the server name in the <code>              catalina             </code> <code>              -server.             </code> xml file.</p>
<p>See <a href="https://docs.wso2.com/display/ADMIN44x/Configuring+Transport+Level+Security">Configuring Transport Level Security</a> for instructions.</p></td>
</tr>
<tr class="odd">
<td><p>Enabling HTTP Strict Transport Security Headers (HSTS)</p></td>
<td><p>Be sure that HTTP Strict Transport Security (HSTS) is enabled for all the applications deployed in your WSO2 server. This includes the management console, and any other web applications and/or Jaggery applications.</p>
<p>Note that (for products based on Carbon 4.4.11 or later versions) HSTS is disabled for the applications with which the product is shipped by default. This is because HSTS validation can interrupt the development processes by validating signatures of self-signed certificates.</p>
<p>See the topic on <a href="https://docs.wso2.com/display/ADMIN44x/Securing+Carbon+Applications#SecuringCarbonApplications-EnablingHTTPStrictTransportSecurity(HSTS)Headers">Enabling HTTP Strict Transport Security Headers</a> for instructions.</p></td>
</tr>
<tr class="even">
<td><p>Preventing browser caching</p></td>
<td><p>If there are dynamic pages in your application with sensitive information, you need to prevent browser caching. This can be done by making sure that the applications deployed in your server will return the relevant HTTP response headers.</p>
<p>Note that cache prevention headers are enabled for the applications with which the product is shipped by default. Therefore, you need to manually enable cache prevention headers only for all the new applications that you deploy in your server.</p>
<p>See the topic on <a href="https://docs.wso2.com/display/ADMIN44x/Securing+Carbon+Applications#SecuringCarbonApplications-Preventingbrowsercaching">Preventing browser caching</a> for instructions.</p></td>
</tr>
<tr class="odd">
<td><p>Increase Ephemeral Diffie-Hellman Key size</p></td>
<td><p>Before starting the server, open the product startup script ( <code>              wso2server.sh             </code> in Linux and <code>              wso2server.bat             </code> in Windows) and enter the following with the other Java properties:</p>
<div class="code panel pdl" style="border-width: 1px;">
<div class="codeContent panelContent pdl">
<pre class="java" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence"><code>-Djdk.tls.ephemeralDHKeySize=2048 \</code></pre>
</div>
</div></td>
</tr>
<tr class="even">
<td><p>Disable client-initiated renegotiation</p>
<p><br />
</p></td>
<td><p>Before starting the server, open the product startup script ( <code>              wso2server.sh             </code> in Linux and <code>              wso2server.bat             </code> in Windows) and enter the following with the other Java properties:</p>
<div class="code panel pdl" style="border-width: 1px;">
<div class="codeContent panelContent pdl">
<pre class="java" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence"><code>-Djdk.tls.rejectClientInitiatedRenegotiation=true \</code></pre>
</div>
</div></td>
</tr>
<tr class="odd">
<td><p>Enable HostName Verification</p>
<p><br />
</p></td>
<td><p>If your product is using Carbon Kernel 4.4.17 or a later version, make sure that hostname verification is enabled in the product startup script ( <code>              wso2server.sh             </code> in Linux and <code>              wso2server.bat             </code> in Windows) with the <strong>Strict</strong> mode. That is, you need to enable the following parameter:</p>
<div class="code panel pdl" style="border-width: 1px;">
<div class="codeContent panelContent pdl">
<pre class="java" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence"><code>-Dhttpclient.hostnameVerifier=Strict \</code></pre>
</div>
</div>
<p>In Carbon versions prior to 4.4.17, be sure that hostname verification is enabled by setting the following property to <code>              false             </code> .</p>
<div class="code panel pdl" style="border-width: 1px;">
<div class="codeContent panelContent pdl">
<pre class="java" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence"><code>-Dorg.wso2.ignoreHostnameVerification=false \</code></pre>
</div>
</div>
<p>See <a href="https://docs.wso2.com/display/ADMIN44x/Enabling+HostName+Verification">Enabling HostName Verification</a> for instructions.</p></td>
</tr>
<tr class="even">
<td><p>Enable additional XSS Protection</p></td>
<td><p>XSS attacks are prevented on the latest WSO2 products by default. This is due to output encoding of the displaying values. However, if additional protection is required, an input validation valve can be configured.</p>
<p>See <a href="https://docs.wso2.com/display/ADMIN44x/Mitigating+Cross+Site+Scripting+Attacks">Mitigating Cross Site Scripting Attacks</a> for instructions.</p></td>
</tr>
<tr class="odd">
<td><p>Increase JSESSIONID length</p></td>
<td><div class="content-wrapper">
<p>If required, increase the session ID length by changing the <code>               sessionIDLength              </code> attribute of the session manager in the <code>               context.xml              </code> file (stored in the <code>               &lt;PRODUCT_HOME&gt;/repository/conf/tomcat/context.xml              </code> directory) as shown below. The default value is 16 bytes.</p>
<div class="code panel pdl" style="border-width: 1px;">
<div class="codeContent panelContent pdl">
<pre class="java" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence"><code>&lt;Manager className=&quot;org.wso2.carbon.webapp.mgt.CarbonTomcatSessionManager&quot; sessionIdLength=&quot;16&quot;&gt;&lt;/Manager&gt;</code></pre>
</div>
</div>
</div></td>
</tr>
<tr class="even">
<td><p>Change default admin credentials</p>
<p><br />
</p></td>
<td><p>All WSO2 products have the Administrator account configured by default. The default user nameand password of the administrator account is &quot;admin&quot;. To change the administrator credentials, you need to first sign in tothe management console of the product as &quot;admin&quot;, and then use the <strong>Change Password</strong> option under <strong>Home-&gt;Configure-&gt;User Management-&gt;Users</strong> in the navigator.</p>
<p>See <a href="https://docs.wso2.com/display/ADMIN44x/Changing+a+Password">Changing a Password</a> for more information on how to change the password of the administrator.</p></td>
</tr>
<tr class="odd">
<td><p>Restrict access to the management console</p>
<p><br />
</p></td>
<td><p>Make sure that the permission for signing into the management console is granted only to the users that need to use the management console. For example, in products such as WSO2 Identity Server and WSO2 API Manager, the majority of users only need to login to the connected service providers via the WSO2 product. Therefore, such users should not have permission to log into the management console.</p>
<p>You can make sure that only administrative users have access to the product's management console. Further, instead of granting all permission to one administrator, you can distribute the responsibilities among administrators by assigning different permissions for conducting various tasks.</p>
<p>See <a href="https://docs.wso2.com/display/ADMIN44x/Managing+Users%2C+Roles+and+Permissions">Managing Users, Roles and Permissions</a> for instructions.</p></td>
</tr>
<tr class="even">
<td><p>Enable log rotation and monitoring</p>
<p><br />
</p></td>
<td><p>Ensure that you have a relevant log rotation scheme to manage logs. Log4J properties for WSO2 products can be configured in the <code>              &lt;PRODUCT_HOME&gt;/repository/conf/log4j.properties             </code> file. To roll the <strong>wso2carbon.log</strong> based on size, the following configurations can be used.</p>
<div class="code panel pdl" style="border-width: 1px;">
<div class="codeContent panelContent pdl">
<pre class="java" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence"><code>log4j.appender.CARBON_LOGFILE=org.apache.log4j.RollingFileAppender
log4j.appender.CARBON_LOGFILE=${carbon.home}/repository/logs/${instance.log}/wso2carbon${instance.log}.log
log4j.appender.CARBON_LOGFILE.MaxFileSize=1000KB
log4j.appender.CARBON_LOGFILE.MaxBackupIndex=10</code></pre>
</div>
</div>
<p>See <a href="https://docs.wso2.com/display/ADMIN44x/Monitoring+Logs">Monitoring Logs</a> for details on how to configure logging details in WSO2 products.</p></td>
</tr>
<tr class="odd">
<td><p>Prevent Log Forging</p></td>
<td><p>Log forging can be prevented by appending a UUID to the log message.</p>
<p>See <a href="https://docs.wso2.com/display/ADMIN44x/Monitoring+Logs">Monitoring Logs</a> for more information on configuring the log4j.properties file.</p></td>
</tr>
<tr class="even">
<td><p>Set appropriate JVM parameters</p>
<p><br />
</p></td>
<td><p>The recommended JDK version is JDK 1.7 or 1.8. See the <a href="https://docs.wso2.com/display/ADMIN44x/Production+Deployment+Guidelines#ProductionDeploymentGuidelines-installation_prerequisites">installation pre-requisites</a> for more information.</p>
<p>For JDK 1.7, set the appropriate Heap and Permgen values for the JVM based on your deployment scenario. These can be set in the <code>              &lt;PRODUCT_HOME&gt;/bin/wso2server.sh             </code> file. You do not need to set this in JDK 1.8 as the MaxPermSize value has been removed from Hotspot JVM.</p>
<div class="code panel pdl" style="border-width: 1px;">
<div class="codeHeader panelHeader pdl" style="border-bottom-width: 1px;">
<strong>For example</strong>
</div>
<div class="codeContent panelContent pdl">
<pre class="java" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence"><code>-Xms512m -Xmx2048m -XX:MaxPermSize=1024m</code></pre>
</div>
</div>
!!! tip
<p><strong>Tip</strong> : To run the JVM with 2 GB (-Xmx2048m), you should ideally have about 4GB of memory on the physical machine.</p>
</td>
</tr>
</tbody>
</table>

### OS-level security

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
<p>See the <a href="https://docs.wso2.com/display/ADMIN44x/Production+Deployment+Guidelines#ProductionDeploymentGuidelines-installation_prerequisites">Installation Prerequisites</a> to identify the minimum software your WSO2 product will need.</p></td>
</tr>
<tr class="odd">
<td><p>Enable the Firewall</p></td>
<td><p>Enable a firewall at the OS level (for example, <a href="https://help.ubuntu.com/community/IptablesHowTo">iptables</a> ). This will provide protection for inbound and outbound connections of your WSO2 product. Make sure that you only open the required outbound and inbound ports from the OS-level firewall.</p></td>
</tr>
<tr class="even">
<td>Restrict access to TCP ports used for clustering</td>
<td>Apply a firewall at host-level to disallow access to TCP ports used for clustering (port 4000, 4001, … by default) from unrecognized hosts. These ports should be accessible only from other members of the WSO2 product cluster.</td>
</tr>
<tr class="odd">
<td><p>Use Secure Shell(SSH)</p>
<p><br />
</p></td>
<td><p>Use Secure Shell (SSH) when interacting with servers and executing commands. Adhere to the following best practices when you configure SSH:</p>
<ul>
<li>Change the default ssh port to a higher value.</li>
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
<td>!!! note
<p><strong>Note:</strong> This security guideline is specific only to WSO2 Identity Server.</p>

<p>In a production environment, there is a possibility for a deadlock/database lock to occur when running a session data cleanup task in high load scenarios. To mitigate this, configure the following property to clean data in chunks. Configure this property in the <code>              &lt;IS_HOME&gt;/repository/conf/identity/identity.xml             </code> file under <code>              &lt;SessionDataCleanUp&gt;             </code> with the required chunk size. This value is in the number of records and depends on the database type and server capacity. It also depends on the amount of load generated by single sign-on (SSO). A higher value increases the chances of deadlocks and a lower value increases the time it takes for a cleanup.</p>
<p><br />
</p>
<div class="code panel pdl" style="border-width: 1px;">
<div class="codeContent panelContent pdl">
<pre class="java" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence"><code>&lt;DeleteChunkSize&gt;50000&lt;/DeleteChunkSize&gt;</code></pre>
</div>
</div>
<p>For more information on configuring sessions in production, see <a href="https://docs.wso2.com/display/identity-server/Authentication+Session+Persistence">Authentication Session Persistence</a> in the WSO2 Identity Server documentation.</p></td>
</tr>
<tr class="odd">
<td><p>Make regular backups</p></td>
<td><p>Make sure to backup important files and archive them continuously.</p>
<p>See <a href="https://docs.wso2.com/display/ADMIN44x/Production+Deployment+Guidelines#ProductionDeploymentGuidelines-backup_recovery">Backup and Recovery Recommendations</a> for more information.</p></td>
</tr>
</tbody>
</table>

### Network-level security

This section provides the list of security guidelines for configuring the network.

<table>
<thead>
<tr class="header">
<th>Guideline</th>
<th>Details</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p>Create a failover setup</p>
<p><br />
</p></td>
<td><p>When your WSO2 products are clustered, you need to regularly monitor the health of your server instances. For example, you need to monitor resource-level factors such as the server's resource utilization, response time anomalies, and the number of incoming network connections. Server monitoring will help you identify when additional server instances (failover instances) are required. You can also make decisions about network routing changes that you need to do in order to avoid server downtime.</p>
<ul>
<li>See <a href="https://docs.wso2.com/display/ADMIN44x/Key+Concepts">Deployment and Clustering/Key Concepts</a> for information on configuring failover.</li>
<li>See <a href="https://docs.wso2.com/display/ADMIN44x/Monitoring">Monitoring WSO2 products</a> for information on the monitoring options for WSO2 products.</li>
</ul></td>
</tr>
<tr class="even">
<td><p>Maintain network level logging</p></td>
<td><p>Be sure to maintain and monitor logs for your proxy servers, load balancers, and other network devices.</p></td>
</tr>
<tr class="odd">
<td><p>Check open ports and services</p></td>
<td><p>Periodically check for open ports using port scanning tools and make sure that only the necessary ports are open to both internal and external networks. Be sure that only the ports relevant to your WSO2 products are open for communication. If there are other ports started, be sure to monitor them.</p>
<p>See <a href="https://docs.wso2.com/display/ADMIN44x/Default+Ports+of+WSO2+Products">Default Ports of WSO2 Products</a> for the full list of ports in all WSO2 products.</p></td>
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
<tr class="even">
<td><p>Block the <code>              /services             </code> and <code>              /carbon             </code> contexts from the DMZ</p></td>
<td><p>Access to the &quot;/services&quot; and &quot;/carbon&quot; contexts should be blocked from the DMZ level (i.e., from the proxy server, load balancer and/or firewall).</p>
<ul>
<li>The &quot;/services&quot; context is used in WSO2 products to expose admin services. These admin services are used for performing administrative operations using SOAP requests.</li>
<li>The &quot;/carbon&quot; context is used in WSO2 products to expose the management console (administration console) of the product. The management console is a user interface for performing some of the administrative operations of a product.</li>
<li>In addition to the &quot;/services&quot; and &quot;/carbon&quot; contexts, be sure to expose only the required applications in your product to users beyond the DMZ level in your network.</li>
</ul>
<p><br />
</p>
!!! note
<p>It is recommended to use a whitelisting approach when allowing access to resources in your product from the DMZ level.</p>
</td>
</tr>
</tbody>
</table>


