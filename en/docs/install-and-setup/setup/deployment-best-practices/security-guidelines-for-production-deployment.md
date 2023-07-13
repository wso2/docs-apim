# Security Guidelines for Production Deployment

Given below are the common security guidelines for deploying a WSO2 API Manager in a **production environment**.

In addition, see the [production deployment checklist]({{base_path}}/install-and-setup/setup/deployment-best-practices/production-deployment-guidelines) and any other product-specific guidelines in the respective product's documentation.

-   [Runtime-level security](#runtime-level-security)
-   [OS-level security](#os-level-security)
-   [Network-level security](#network-level-security)

## Runtime-level security

Given below are the security guidelines for the API-M and Micro Integrator runtimes. Note that some of these guidelines are common to both runtimes, whereas some guidelines are runtime-specific.

### API-M runtime security

Given below are the security guidelines for the API-M runtime.

<table>
<thead>
<tr class="header">
<th><b>Guideline</b></th>
<th><b>Details</b></th>
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
</ul>
</td>
</tr>
<tr class="even">
<td><p>Change default keystores</p></td>
<td><p>Change the default key stores and create new keys for all the cryptographic operations. WSO2 products, by default, come with a self-signed SSL key. As these keys are public, it is recommended to configure your own keys for security purposes. Consider the following guidelines when creating the keystores:</p>
<ul>
<li><p>Select a key size of at least 2048 bits.</p></li>
<li><p>Use an SHA256 certificate.</p></li>
<li><p>Make sure that WSO2 default certificates do not exist in any of the keystores in your production environment. For example, be sure to delete the default public certificate in the default trust store that is shipped with the product.</p></li>
</ul>
<p>For more information on recommendations for using keystores in WSO2 
products, see <a href="{{base_path}}/install-and-setup/setup/security/configuring-keystores/keystore-basics/about-asymetric-cryptography/">About Asymmetric Cryptography</a>.<br />
For information on how to create and configure your own keys and keystores, see <a href="{{base_path}}/install-and-setup/setup/security/configuring-keystores/configuring-keystores-in-wso2-api-manager/">Creating New Keystores</a>.</p></td>
</tr>
<tr class="odd">
<td>Encrypt passwords in configuration files</td>
<td><p>WSO2 products use a tool called <strong>Secure Vault</strong> to encrypt the plain-text passwords in configuration files.</p>
<p>See <a href="{{base_path}}/install-and-setup/setup/security/logins-and-passwords/working-with-encrypted-passwords/">Encrypting Passwords in Configuration Files</a> for instructions.</p></td>
</tr>
<tr class="even">
<td><p>Change default ports</p>
<p><br />
</p></td>
<td><p>For information on all the default ports used by WSO2 API Manager, see <a href="{{base_path}}/install-and-setup/setup/reference/default-product-ports/">Default Product Ports</a>. For example, the default HTTPS port is 9443 and the HTTP port is 9763. In addition, Axis2 services are exposed over the following ports: 8243 and 8280.</p>
<p>For information on changing a default port, see <a href="{{base_path}}/install-and-setup/setup/deployment-best-practices/changing-the-default-ports-with-offset">Changing the Default Ports with Offset</a>.</p></td>
</tr>
<tr class="odd">
<td><p>Enable <strong>read-only access</strong> to external user stores (LDAPs etc.)</p></td>
<td><p>If your product runtimes are connecting to an external user store, such as Microsoft Active Directory for the purpose of reading and retrieving user information, be sure to enable read-only access to that user store.</p>
<p>
See <a href="{{base_path}}/administer/managing-users-and-roles/managing-user-stores/configure-primary-user-store/configuring-a-read-only-ldap-user-store/">Configuring a Read-Only LDAP User Store</a> for the API-M runtime.
</p>
</td>
</tr>
<tr class="even">
<td><p>Always communicate (with external user stores) over TLS</p></td>
<td><p>All connections from your WSO2 API Manager to external databases, userstores (LDAP), or other services, should be over TLS to ensure adequate network-level protection. Therefore, be sure to use external systems (user stores, databases) that are TLS-enabled.</p></td>
</tr>
<tr class="odd">
<td><p>Connect to data stores using a less privileged user</p></td>
<td><p>When connecting the server to external databases or user stores (LDAP), be sure to go through a user who does not have permission to change the data store's schema. Be sure not to use the root user of the data store because all permissions are generally granted to the root user.</p></td>
</tr>
<tr class="even">
<td><p>Configure strong HTTP(S) security</p></td>
<td>
  <p>To have strong transport-level security, disable SSL protocol versions and enable only TLS protocol 
versions: TLS 1, TLS 1.1, and TLS 1.2. This can be done by replacing the <code>sslProtocol = "TLS"</code> property with 
<code>sslEnabledProtocols="TLSv1,TLSv1.1,TLSv1.2"</code> under <code>[transport.https.sslHostConfig
.properties]</code> in the <code>deployment.toml</code> file. In addition, configure strong ciphers for 
<code>ThriftAuthenticationService</code>, Tomcat transport, and PassThrough transport in the <code>deployment.toml</code> file. See the
 following links for instructions:</p>
<ul>
  <li><a href="{{base_path}}/install-and-setup/setup/security/configuring-transport-level-security/">Configuring Transport Level Security</a></li>
  <li><a href="{{base_path}}/install-and-setup/setup/reference/supported-cipher-suites/">Supported Cipher Suites</a></li>
</ul>    
<div style="background-color:#ffffff; padding: 10px;">
<strong>Note :</strong>
<ul>
<li>When deciding on the TLS protocol and the ciphers, consider the compatibility with existing client applications. Imposing maximum security might cause functional problems with client applications.</li>
<li>Apply ciphers with 256 bit key length if you have applied the "Unlimited" strength policy. Note that an unlimited strength policy is recommended.</li>
<li>Also, consider the following factors when deciding on the ciphers:
<ul>
<li>DES/3DES are deprecated and should not be used.</li>
<li>MD5 should not be used due to known collision attacks.</li>
<li>RC4 should not be used due to analytical cryptographic attacks.</li>
<li>DSS is limited to a small 1024 bit key size.</li>
<li>Cipher-suites that do not provide Perfect Forward Secrecy/ Forward Secrecy (PFS/FS).</li>
<li>GCM based ciphers are recommended over CBC ciphers.</li>
</ul></li>
</ul>
</div>
</td>
</tr>
<tr class="odd">
<td><p>Remove weak ciphers for PassThrough transport</p></td>
<td>
<p>Remove any weak ciphers from the PassThrough transport and ensure that the server does not accept connections 
using those weak ciphers. For this, <code>PreferredCiphers</code> should be configured for the PassThrough transport in the <code>deployment.toml</code> file (stored in the <code>&lt;PRODUCT_HOME&gt;/repository/conf/</code> directory).
<p>For more information, see <a href="{{base_path}}/install-and-setup/setup/security/configuring-transport-level-security/">Configuring 
Transport Level Security</a>.</p>
</tr>
<tr class="even">
<td><p>Update the HTTP Response header &quot;Server&quot; value</p></td>
<td><p>By default, all WSO2 products pass &quot;WSO2 Carbon Server&quot; as the server value in HTTP headers when 
sending HTTP responses. This means that information about the WSO2 product stack is exposed through HTTP 
responses. It is recommended to change this by configuring the server name for relevant connectors via 
<code>deployment.toml</code>.
<p>For more information, see <a href="{{base_path}}/install-and-setup/setup/security/configuring-transport-level-security/">Configuring 
Transport Level Security</a>.</p>
</tr>
<tr class="odd">
<td><p>Enabling HTTP Strict Transport Security Headers (HSTS)</p></td>
<td><p>Be sure that HTTP Strict Transport Security (HSTS) is enabled for all the applications deployed in your server. This includes the management console, and any other web applications and/or Jaggery applications.</p>
<p>Note that (for WSO2 products based on Carbon 4.4.11 or later versions, which implies API-M 2.1.0 and newer) HSTS is disabled for the applications with which the product is shipped by default. This is because HSTS validation can interrupt the development processes by validating signatures of self-signed certificates.</p>
</tr>
<tr class="even">
<td><p>Preventing browser caching</p></td>
<td><p>If there are dynamic pages in your application with sensitive information, you need to prevent browser caching. This can be done by making sure that the applications deployed in your server return the relevant HTTP response headers.</p>
<p>Note that cache prevention headers are enabled for the applications with which the product is shipped by default. Therefore, you need to manually enable cache prevention headers only for all the new applications that you deploy in your server.</p>
</tr>
<tr class="odd">
<td><p>Increase Ephemeral Diffie-Hellman Key size</p></td>
<td><p>Before starting the server, open the product startup script (<code>api-manager.sh</code> in Linux and <code>api-manager.bat</code> in Windows) and enter the following with the other Java properties:</p>
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
<td><p>Before starting the server, open the product startup script (<code>api-manager.sh</code> in Linux and <code>api-manager.bat</code> in Windows) and enter the following with the other Java properties:</p>
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
<td><p>If your product is using Carbon Kernel 4.4.17 or a later version (which implies API-M 2.2.0 and newer), make 
sure that hostname verification is enabled in the product startup script (<code>api-manager.sh</code> in Linux and <code>api-manager.bat</code> in Windows) with the <strong>Strict</strong> mode. If it is not, you need to enable it as below:</p>
<div class="code panel pdl" style="border-width: 1px;">
<div class="codeContent panelContent pdl">
<pre class="java" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence"><code>-Dhttpclient.hostnameVerifier=Strict \</code></pre>
</div>
</div>
<p>In Carbon versions prior to 4.4.17, be sure that hostname verification is enabled by setting the following property to <code>false</code>.</p>
<div class="code panel pdl" style="border-width: 1px;">
<div class="codeContent panelContent pdl">
<pre class="java" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence"><code>-Dorg.wso2.ignoreHostnameVerification=false \</code></pre>
</div>
</div>
<p>For instructions, see <a href="{{base_path}}/install-and-setup/setup/security/enabling-hostname-verification/">Enabling HostName Verification</a>.</p></td>
</tr>
<tr class="even">
<td><p>Increase JSESSIONID length</p></td>
<td><div class="content-wrapper">
<p>If required, increase the session ID length by changing the <code>sessionIDLength</code> attribute of the session manager in the <code>context.xml</code> file (stored in the <code>&lt;PRODUCT_HOME&gt;/repository/conf/tomcat/context.xml</code> directory) as shown below. The default value is 16 bytes.</p>
<div class="code panel pdl" style="border-width: 1px;">
<div class="codeContent panelContent pdl">
<pre class="java" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence"><code>&lt;Manager className=&quot;org.wso2.carbon.webapp.mgt.CarbonTomcatSessionManager&quot; sessionIdLength=&quot;16&quot;&gt;&lt;/Manager&gt;</code></pre>
</div>
</div>
</div></td>
</tr>
<tr class="odd">
<td><p>Change default admin credentials</p>
<p><br />
</p></td>
<td><p>The Administrator account is configured by default. The default user name and password of the administrator account is &quot;admin&quot;. To change the administrator credentials, you need to first sign in to the management console of the API-M server as &quot;admin&quot;, and then use the <strong>Change Password</strong> option under <strong>Home-&gt;Configure-&gt;User Management-&gt;Users</strong> in the navigator.</p>
<p>For more information on how to change the password of the administrator in the API-M server, see <a href="{{base_path}}/install-and-setup/setup/security/logins-and-passwords/maintaining-logins-and-passwords/#change-the-super-admin-credentials">Changing the super admin credentials</a>.</p></td>
</tr>
<tr class="even">
<td><p>Restrict access to the management console</p>
<p><br />
</p></td>
<td><p>Make sure that the permission for signing into the management console is granted only to the users that need to use the management console. For example, the majority of users only need to login to the connected service providers via the WSO2 product. Therefore, such users should not have permission to log into the management console.</p>
<p>You need to make sure that only administrative users have access to the product's management console. Further, 
instead of granting all permission to one administrator, you can distribute the responsibilities among administrators by assigning different permissions for conducting various tasks.</p>
<p>For instructions, see <a href="{{base_path}}/administer/managing-users-and-roles/managing-user-roles/">Managing User Roles</a>.</p></td>
</tr>
<tr class="odd">
<td><p>Enable log rotation and monitoring</p>
<p><br />
</p></td>
<td><p>Ensure that you have a relevant log rotation scheme to manage logs. Log4J properties for WSO2 products can be 
configured in the <code>&lt;PRODUCT_HOME&gt;/repository/conf/log4j2.properties</code> file. Rollover based on a time period can be configured by changing the below configuration (Default value is 1 day).</p>
<code>appender.CARBON_LOGFILE.policies.time.interval = 1</code>
<p>You can also configure rollover based on log file size, and also it is possible to limit the number of backup 
files. For details on how to configure log rotation and manage log growth details in the API-M runtime, see <a href="{{base_path}}/administer/logging-and-monitoring/logging/managing-log-growth/">Managing log growth</a>.</p></td>
</tr>
<tr class="even">
<td><p>Prevent log forging</p></td>
<td><p>Log forging can be identified by appending a UUID to the log message. The conversion character '%u' can be 
used in the pattern layout to log a UUID. For example, the log pattern can be set as following for <code>AUDIT</code> 
logs so that the UUID is printed at the beginning of each log record.</p>
<code>appender.AUDIT_LOGFILE.layout.pattern = [%u] TID: [%tenantId] [%d] %5p {&#37;c} - %m%ex%n </code>
<p>For more information on configuring logging, see <a href="{{base_path}}/administer/logging-and-monitoring/logging/configuring-logging/">Setting up 
logging in API Manage</a>.</p></td>
</tr>
<tr class="odd">
<td><p>Set appropriate JVM parameters</p>
<p><br />
</p></td>
<td><p>The recommended JDK version is JDK 8 or 11. For more information, see <a 
href="{{base_path}}/install-and-setup/setup/reference/product-compatibility/#tested-operating-systems-and-jdks">Tested Operating Systems and JDKs</a>.</p>
<p>You do not need to set the Heap and Permgen values for the JVM from JDK 1.8 onwards as the <code>MaxPermSize</code> value has 
been removed from Hotspot JVM.</p>
</td>
</tr>
<tr class="even">
<td><p>Restrict outbound connections of Publisher node</p>
<p><br />
</p></td>
<td><p>In an API-M deployment, it is recommended to restrict outbound connections of the Control Plane node (which contains the Publisher) and only allow access to the internal nodes (only to the nodes that the Publisher portal is intended to communicate with) of the deployment. Therefore, even if a situation arises where privileged user credentials are exposed to a user with malicious intent, such users will not be able to exploit and perform any unintended network interactions.</p>
    <p>See the <a href="{{base_path}}/install-and-setup/setup/deployment-overview">API-M deployment</a> documentation for details.</p>
</td>
</tr>
<tr class="odd">
<td><p>Use a separate admin user account to login into the system</p>
<p><br />
</p></td>
<td><p>WSO2 recommends that you use two separate admin user accounts in production - one account for logging into the system and the other one as the system user doing configurations (for internal service communications).</p>
<p>For more information regarding admin user accounts, see <a href="{{base_path}}/reference/config-catalog/#super-admin-configurations">super admin configurations</a>.</p>
</td>
</tr>
<tr class="even">
<td><p>Defining callback URL regular expression</p>
<p><br />
</p></td>
<td><p>For password recovery, you can define a regular expression to validate the callback URL. The default configuration allows any callback URL. Note that if you are using the recovery option, it is highly recommended to define the regular expression that validates and only allows access to specific callback URLs.</p>
</td>
</tr>
</tr>
<tr class="odd">
<td><p>Configure client authentication</p>
<p><br />
</p></td>
<td><p>Client authentication is used to identify the application or client making a request to the WSO2 API Manager  REST APIs. By default, web applications provided with WSO2 API Manager use a set of default credentials for authentication. However, it is recommended to change these default credentials to enhance security. For more details see, <a href="{{base_path}}/install-and-setup/setup/deployment-best-practices/security-guidelines-for-production-deployment/#configure-client-authentication">Configure client authentication</a></p>
</td>
</tr>
</tbody>
</table>

### Micro Integrator runtime security

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
            <p>For information on all the default ports used by WSO2 API Manager, see <a href="{{base_path}}/install-and-setup/setup/reference/default-product-ports/">Default Product Ports</a>.</p>
            <p>For information on changing a default port, see <a href="{{base_path}}/install-and-setup/setup/deployment-best-practices/changing-the-default-ports-with-offset">Changing the Default Ports with Offset</a>.</p>
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
            <p>The recommended JDK version is JDK 11. See the <a href="{{base_path}}/install-and-setup/install/installation-prerequisites/">installation pre-requisites</a> for more information.</p>
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
<p>For information on the minimum software that your WSO2 product will need, see <a href="{{base_path}}/install-and-setup/install/installation-prerequisites/#system-requirements">Installation Prerequisites</a>.</p></td>
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
<p><strong>Note:</strong> This security guideline is only applicable to WSO2 API Manager.</p>

<p>In a production environment, there is a possibility for a deadlock or a database lock to occur when running a session 
data cleanup task in high load scenarios. To mitigate this, configure the following property to clean data in chunks.
 Configure this property in the <code&lt;IS_HOME&gt;/repository/conf/deployment.toml</code> file under
  <code>session_data</code> with the required chunk size. This value is in the number of records and depends on the database type and server capacity. It also depends on the amount of load generated by single sign-on (SSO). A higher value increases the chances of deadlocks and a lower value increases the time it takes for a cleanup.</p>
<pre class="java" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence"><code>[session_data]
cleanup.clean_expired_session_data_in_chunks_of = 8192</code></pre>
<p>For more information on configuring sessions in production, see <a href="https://is.docs.wso2.com/en/5.10
.0/learn/authentication-session-persistence/">Authentication Session Persistence</a> in the WSO2 API Manager 
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
<p>For the full list of ports in all WSO2 products, see <a href="{{base_path}}/install-and-setup/setup/reference/default-product-ports/">Default Product Ports</a>.</p></td>
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
<td>
<p><strong>Note:</strong>This security guideline is applicable to the API-M runtime.</p>
<p>Block the <code>/services</code> and <code>/carbon</code> contexts from the DMZ</p></td>
<td><p>Access to the &quot;/services&quot; and &quot;/carbon&quot; contexts should be blocked from the DMZ level (i.e., from the proxy server, load balancer and/or firewall).</p>
<ul>
<li>The &quot;/services&quot; context is used in WSO2 products to expose admin services. These admin services are used for performing administrative operations using SOAP requests.</li>
<li>The &quot;/carbon&quot; context is used in WSO2 products to expose the management console (administration console) of the product. The management console is a user interface for performing some of the administrative operations of a product.</li>
<li>In addition to the &quot;/services&quot; and &quot;/carbon&quot; contexts, be sure to expose only the required applications in your product to users beyond the DMZ level in your network.</li>
</ul>
<p><strong>Note:</strong> </p>
<p>It is recommended to use an allowlisting approach when allowing access to resources in your product from the DMZ level.</p>

</td>
</tr>
</tbody>
</table>


## Configure client authentication

Client authentication is used to identify the application or the client that is making the request. 
The web applications provided out of the box use a set of default credentials to authenticate with WSO2 API Manager  REST APIs that are marked as **secure** under the `ResourceAccessControl` tag of the `<APIM_HOME>/repository/conf/identity/identity.xml` file. 

Follow the steps below to change the default credentials.

1.  Shut the server down in case you have already started it. 

2.  Add the following configuration changes to the `<APIM_HOME>/repository/conf/deployment.toml` file.
    
    -   Add the `app_password` property and enter a preferred password as the value.
      
        ``` toml
        [identity.auth_framework.endpoint] 
        app_password="<value of preferred password>"
        ```  
        
    -   Add the `hash` property and enter the SHA-256 hash value of the `app_password` as the property value.

        ``` toml
        [account_recovery.endpoint.auth]
        hash="<SHA-256 hash of the newly added app_password property value>"
        ``` 
        
    - If the `authenticationendpoint` web app is hosted externally, follow the instructions given below.

        a.  Open the `EndpointConfig.properties` file found in the root of the `authenticationendpoint` folder. 

        b.   Change the `app.password` property value to the value added as `app_password` in the `deployment.toml` file. 

        c.   Do the same changes to the `EndpointConfig.properties` file located in the `<APIM_HOME>/repository/deployment/server/webapps/authenticationendpoint/WEB-INF/classes` directory.

    - If the `accountrecoveryendpoint` web app is hosted externally, follow the instructions given below. 

        a.   Open the `RecoveryEndpointConfig.properties` file found in the root of the `accountrecoveryendpoint` folder. 

        b.   Change the `app.password` property value to the value added as `app_password` in the `deployment.toml` file. 

        c.   Do the same changes to the `RecoveryEndpointConfig.properties` file located in the `<APIM_HOME>/repository/deployment/server/webapps/accountrecoveryendpoint/WEB-INF/classes` directory.
    
3.  Once these changes are configured, restart the server.
    
    - Linux/Unix : sh wso2server.sh
    - Windows : wso2server.bat