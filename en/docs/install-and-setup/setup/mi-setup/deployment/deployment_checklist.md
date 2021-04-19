# Production Deployment Guidelines

The requirements for deploying WSO2 products can change based on the deployment scenario and pattern. The recommendations in this topic are for general production use, assuming moderate load conditions. For situations where a high volume of traffic is expected and if there are large deployments, these guidelines may not be sufficient.

See [Troubleshooting in Production Environments]({{base_path}}/install-and-setup/setup/mi-setup/deployment/troubleshooting_deployment) for information on how to analyse production issues.

## Common Product Guidelines

Listed below are the common guidelines for making a WSO2 product ready for production.

<table>
   <thead>
      <tr class="header">
         <th>Guideline</th>
         <th>Details</th>
      </tr>
   </thead>
   <tbody>
      <tr class="odd">
         <td>Security hardening</td>
         <td>
            <div class="content-wrapper">
               <p>Guidelines for hardening the security of a WSO2 deployment in a production environment can be discussed under three high-level categories:</p>
               <ul>
                  <li>Product-level security</li>
                  <li>OS-level security</li>
                  <li>Network-level security<br />
                     <br />
                  </li>
               </ul>
               <div class="panel" style="border-width: 1px;">
                  <div class="panelHeader" style="border-bottom-width: 1px;">
                     <strong>Related links</strong>
                  </div>
                  <div class="panelContent">
                     <p>See <a href="#security-guidelines">Security Guidelines</a> for the detailed list of security-related recommendations.</p>
                  </div>
               </div>
            </div>
         </td>
      </tr>
      <tr class="even">
         <td>Hostname</td>
         <td>
            <div class="content-wrapper">
               By default, WSO2 products identify the hostname of the current machine through the Java API. However, this value sometimes yields erroneous results on some environments. Therefore, users are recommended to configure the hostname by setting the <code>HostName</code> parameter in the <code>deployment.toml</code> file.
               <div class="code panel pdl" style="border-width: 1px;">
                  <div class="codeContent panelContent pdl">
                     <div class="sourceCode" id="cb1" data-syntaxhighlighter-params="brush: xml; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: xml; gutter: false; theme: Confluence">
                        <pre class="sourceCode xml"><code class="sourceCode xml"><span id="cb1-1"><a href="#cb1-1"></a><span class="kw">[server]</br>hostname="localhost"</span></span></code></pre>
                     </div>
                  </div>
               </div>
               <p>To configure hostnames for WSDLs and endpoints, users are recommended to add the following parameter for the transport listener in the deployment.toml file.</p>
               <div class="code panel pdl" style="border-width: 1px;">
                  <div class="codeContent panelContent pdl">
                     <div class="sourceCode" id="cb2" data-syntaxhighlighter-params="brush: xml; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: xml; gutter: false; theme: Confluence">
                        <pre class="sourceCode xml"><code class="sourceCode xml"><span id="cb2-1"><a href="#cb2-1"></a><span class="kw">
[transport.http]</br>listener.wsdl_epr_prefix="$ref{server.hostname}"</span></span></code></pre>
                     </div>
                  </div>
               </div>
            </div>
         </td>
      </tr>
      <tr class="odd">
         <td>Registry and governance</td>
         <td>
            <div class="content-wrapper">
               <p>The H2 database-based registry is not available in the Micro Integrator. Instead, it has a <a href="{{base_path}}/install-and-setup/setup/mi-setup/deployment/file_based_registry">file system based registry</a>, which provides the same functionality.</p>
            </div>
         </td>
      </tr>
      <!--
      <tr class="even">
         <td>User stores</td>
         <td>
            <div class="content-wrapper">
               <p>WSO2 products offer three choices to store user details:</p>
               <ul>
                  <li>Using a database</li>
                  <li>Using an LDAP server</li>
                  <li>Using an Active Directory service</li>
               </ul>
               <p>The default is to use the embedded H2 database, with the user store schema. Like in the case of the registry database, you can switch to a database like Oracle, MySQL or MSSQL. You can point to an existing LDAP or an Active Directory to make use of existing user bases and grant access privileges for WSO2 products based on those user stores.</p>
               <div class="panel" style="border-width: 1px;">
                  <div class="panelHeader" style="border-bottom-width: 1px;">
                     <strong>Related links</strong>
                  </div>
                  <div class="panelContent">
                     <p>See <a href="https://docs.wso2.com/display/ADMIN44x/Configuring+User+Stores">Configuring User Stores</a> for more information on user stores, how they work, and how to configure them.</p>
                  </div>
               </div>
            </div>
         </td>
      </tr>
   -->
   <!--
      <tr class="odd">
         <td>Monitoring with JMX</td>
         <td>
            <div class="content-wrapper">
               <p>WSO2 Products supportJMXformonitoring. By default, JMX uses port 9999. You can configure this to the desired port by setting the JMX port parameter in the <code>               &lt;MI_HOME&gt;/conf/carbon.xml              </code> file.</p>
               <div class="code panel pdl" style="border-width: 1px;">
                  <div class="codeContent panelContent pdl">
                     <div class="sourceCode" id="cb3" data-syntaxhighlighter-params="brush: xml; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: xml; gutter: false; theme: Confluence">
                        <pre class="sourceCode xml"><code class="sourceCode xml"><span id="cb3-1"><a href="#cb3-1"></a><span class="kw">&lt;Ports&gt;</span></span>
<span id="cb3-2"><a href="#cb3-2"></a>    <span class="kw">&lt;JMX&gt;</span>9999<span class="kw">&lt;/JMX&gt;</span></span>
<span id="cb3-3"><a href="#cb3-3"></a><span class="kw">&lt;/Ports&gt;</span></span></code></pre>
                     </div>
                  </div>
               </div>
               <div class="panel" style="border-width: 1px;">
                  <div class="panelHeader" style="border-bottom-width: 1px;">
                     <strong>Related links</strong>
                  </div>
                  <div class="panelContent">
                     <p>See <a href="{{base_path}}/observe/mi-observe/jmx_monitoring">JMX-Based Monitoring</a> for information on monitoring WSO2 products using JMX.</p>
                  </div>
               </div>
            </div>
         </td>
      </tr>
   -->
      <tr class="even">
         <td>Tuning WSO2 products</td>
         <td>
            <div class="content-wrapper">
               <p>Most of the performance tuning recommendations are common to all WSO2 products. However, each WSO2 product may have additional guidelines for optimizing the performance of product-specific features.</p>
               <div class="panel" style="border-width: 1px;">
                  <div class="panelHeader" style="border-bottom-width: 1px;">
                     <strong>Related links</strong>
                  </div>
                  <div class="panelContent">
                     <div>
                        Read about <a href="{{base_path}}/install-and-setup/setup/mi-setup/performance_tuning/tuning_jvm_performance">tuning the JVM</a> and <a href="{{base_path}}/install-and-setup/setup/mi-setup/performance_tuning/network_os_performance">tuning the network and OS</a>.
                     </div>
                  </div>
               </div>
            </div>
         </td>
      </tr>
      <tr class="odd">
         <td>Firewalls</td>
         <td>
            <div class="content-wrapper">
               <p>The following ports must be accessed when operating within a firewall.</p>
               <ul>
                  <li>8290 - Default HTTP port used by the Micro Integrator for proxy services and APIs.</li>
                  <li>8253 - Default HTTPS port used by the Micro Integrator for proxy services and APIs.</li>
                  <li>9164 - Default HTTPS port used by the Micro Integrator <a href="{{base_path}}/observe/mi-observe/working-with-management-api">Management APIs</a>.</li>
               </ul>
            </div>
         </td>
      </tr>
      <tr class="even">
         <td>Proxy servers</td>
         <td>
            <div class="content-wrapper">
               <p>If the product is hosted behind a proxy such as ApacheHTTPD, users can configure products to use the proxy server by providing the following system properties at the start-up.</p>
               <div class="code panel pdl" style="border-width: 1px;">
                  <div class="codeContent panelContent pdl">
                     <div class="sourceCode" id="cb4" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence">
                        <pre class="sourceCode java"><code class="sourceCode java"><span id="cb4-1"><a href="#cb4-1"></a>-Dhttp.<span class="fu">proxyHost</span>=xxxx </span>
<span id="cb4-2"><a href="#cb4-2"></a>-Dhttp.<span class="fu">proxyPort</span>=xxxx</span></code></pre>
                     </div>
                  </div>
               </div>
               <p>Alternatively, this can be done by adding the following configurations in the deployment.toml file.</p>
               <div class="code panel pdl" style="border-width: 1px;">
                  <div class="codeContent panelContent pdl">
                     <div class="sourceCode" id="cb5" data-syntaxhighlighter-params="brush: xml; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: xml; gutter: false; theme: Confluence">
                        <pre class="sourceCode xml"><code class="sourceCode xml"><span id="cb5-1"><a href="#cb5-1"></a><span class="kw">[transport.http]</br>sender.proxy_host = "$ref{server.hostname}"</br>sender.proxy_port = 3128</span></span></code></pre>
                     </div>
                  </div>
               </div>
            </div>
         </td>
      </tr>
      <tr class="odd">
         <td>High availability</td>
         <td>
            <div class="content-wrapper">
               <p>In the cloud native deployment, high availability should be achieved via the container orchestration system ( Ex: Kubernetes ). There are builtin <a href="{{base_path}}/install-and-setup/setup/mi-setup/deployment/health_check/#basic-health-check">readiness and liveness probes</a> available in Micro Integrator. We can invoke the readiness probe as follows</p>
               <p><code>curl -X GET http://localhost:9201/healthz</code></p>
               <p>In a VM deployment, we can use a load balancer with multiple nodes as described <a href="{{base_path}}/install-and-setup/setup/mi-setup/deployment/deploying_wso2_ei">here</a> to achieve high availability.</p>
            </div>
         </td>
      </tr>
      <tr class="even">
         <td>Data backup and archiving</td>
         <td>For data backup and for archiving of data, use the functionality provided by the RDBMS.</td>
      </tr>
   </tbody>
</table>

## Security Guidelines

Given below are the common security guidelines for deploying a WSO2 product in a **production environment.**

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
         <td>
            <p>Apply security updates</p>
         </td>
         <td>
            <p>Micro Integrator security fixes can be taken from one of the following methods.</p>
            <ul>
                <li>Using WUM ( WSO2 Update Manager ) to get the latest fixes. Users with a <a href="https://wso2.com/subscription">subscription</a> can take the latest security fixes via the WUM security channel.</li>
                <li><a href="http://wso2.com/security-patch-releases">WSO2 Security Patch Release</a> page has all the security patches for the latest product versions. WSO2 does not issue patches publicly for older product versions. Community users are encouraged to use the latest product version to receive all the security fixes.
</li>           <li><a href="https://docker.wso2.com/tags.php?repo=wso2mi">WSO2 Docker repository</a> releases docker images with security fixes. Users with a <a href="https://wso2.com/subscription">subscription</a> can fetch these docker images.</li>
            </ul>
         </td>
      </tr>
      <tr class="even">
         <td>
            <p>Change default keystores</p>
         </td>
         <td>
            <p>Change the default key stores and create new keys for all the cryptographic operations. WSO2 products by default come with a self-signed SSL key. Since these keys are public, it is recommended to configure your own keys for security purposes. Consider the following guidelines when creating the keystores:</p>
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
            See <a href="{{base_path}}/install-and-setup/setup/mi-setup/security/creating_keystores">Creating New Keystores</a> for information on how to create and configure your own keys.
            </p>
         </td>
      </tr>
      <tr class="odd">
         <td>Encrypt passwords in configuration files</td>
         <td>
            <p>WSO2 products use a tool called <strong>Secure Vault</strong> to encrypt the plain-text passwords in configuration files.</p>
            <p>See <a href="{{base_path}}/install-and-setup/setup/mi-setup/security/encrypting_plain_text">Securing Passwords in Configuration Files</a> for instructions.</p>
         </td>
      </tr>
      <tr class="even">
         <td>
            <p>Change default ports</p>
            <p><br /></p>
         </td>
         <td>
            <p>All the default ports used by WSO2 products are listed in <a href="{{base_path}}/install-and-setup/setup/mi-setup/changing_default_ports">here</a>. For example, proxy services are exposed over the following ports: 8253 and 8290.</p>
            <p>To change a default port, update the <code>offset</code> element in the deployment.toml file as explained in <a href="{{base_path}}/install-and-setup/setup/mi-setup/changing_default_ports">Changing the Default Ports</a> .</p>
         </td>
      </tr>
      <!--
      <tr class="odd">
         <td>
            <p>Enable <strong>read-only access</strong> to external user stores (LDAPs etc.)</p>
         </td>
         <td>
            <p>If your WSO2 product is connecting to an external user store, such as Microsoft Active Directory, for the purpose of reading and retrieving user information, be sure to enable read-only access to that user store.</p>
            <p>For example, see <a href="https://docs.wso2.com/display/ADMIN44x/Configuring+a+Read-Only+LDAP+User+Store">Configuring a Read-Only LDAP User Store</a> under <a href="https://docs.wso2.com/display/ADMIN44x/Configuring+User+Stores">Configuring User Stores</a> for instructions.</p>
         </td>
      </tr>
   -->
      <tr class="even">
         <td>
            <p>Always communicate (with external user stores) over TLS</p>
         </td>
         <td>
            <p>All connections from your WSO2 product to external databases, userstores (LDAP), or other services, should be over TLS, to ensure adequate network-level protection. Therefore, be sure to use external systems (user stores, databases) that are TLS-enabled.</p>
         </td>
      </tr>
      <tr class="odd">
         <td>
            <p>Connect to data stores using a less privileged user</p>
         </td>
         <td>
            <p>When connecting the WSO2 product to external databases or user stores (LDAP), be sure to go through a user who does not have permission to change the data store's schema. Be sure not to use the root user of the data store because all permissions are generally granted to the root user.</p>
         </td>
      </tr>
      <tr class="even">
         <td>
            <p>Configure strong HTTP(S) security</p>
         </td>
         <td>
            <p>To have strong transport-level security, use TLS 1.2 and disable SSL, TLS 1.0 and 1.1. The TLS protocol and strong ciphers are configured for the passthrough transport in the <code>deployment.toml</code> file. See the following links for instructions:</p>
            <p><a href="{{base_path}}/install-and-setup/setup/mi-setup/transport_configurations/configuring-transports#configuring-transport-level-security">Configuring Transport-Level Security</a></p>
            <p>Note the following:</p>
            <ul>
               <li>When deciding on the TLS protocol and the ciphers, consider the compatibility with existing client applications. Imposing maximum security might cause functional problems with client applications.</li>
               <li>Apply ciphers with 256 bits key length if you have applied the Unlimited strength policy. Note that Unlimited strength policy is recommended.</li>
               <li>
                  Also, consider the following factors when deciding on the ciphers:
                  <ul>
                     <li>DES/3DES are deprecated and should not be used.</li>
                     <li>MD5 should not be used, due to known collision attacks.</li>
                     <li>RC4 should not be used, due to crypto-analytical attacks.</li>
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
            <p>See <a href="{{base_path}}/install-and-setup/setup/mi-setup/transport_configurations/configuring-transports/#disabling-weak-ciphers">Disabling weak ciphers</a> for instructions.</p>
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
            <p>Change default admin credentials</p>
            <p><br /></p>
         </td>
         <td>
            <p>Change the <code>deployment.toml</code> with following configuration to change the admin password</p>
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
         </td>
      </tr>
      <tr class="even">
         <td>
            <p>Enable log rotation and monitoring</p>
            <p><br /></p>
         </td>
         <td>
            <p>Ensure that you have a relevant log rotation scheme to manage logs. Log4J properties for Micro Integrator can be configured in the <code>              &lt;MI_HOME&gt;/conf/log4j2.properties             </code> file. To roll the <strong>wso2carbon.log</strong> based on size, <a href="{{base_path}}/install-and-setup/setup/mi-setup/observability/logs/managing_log_growth">this</a> guide can be used.</p>
            <p>See <a href="{{base_path}}/install-and-setup/setup/mi-setup/observability/logs/monitoring_logs">Monitoring Logs</a> for details on how to configure logging details in WSO2 products.</p>
         </td>
      </tr>
      <tr class="odd">
         <td>
            <p>Prevent Log Forging</p>
         </td>
         <td>
            <p>Log forging can be prevented by appending a UUID to the log message.</p>
            <p>Read about <a href="{{base_path}}/install-and-setup/setup/mi-setup/observability/logs/configuring_log4j_properties">configuring the log4j.properties file</a>.</p>
         </td>
      </tr>
      <tr class="even">
         <td>
            <p>Set appropriate JVM parameters</p>
            <p><br /></p>
         </td>
         <td>
            <p>The recommended JDK version is JDK 1.8 or 1.11. See the <a href="{{base_path}}/install-and-setup/install/install_prerequisites">installation pre-requisites</a> for more information.</p>
            <p><strong>Tip</strong>: To run the JVM with 2 GB (-Xmx2048m), you should ideally have about 4GB of memory on the physical machine.</p>
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
         <td>
            <p>Run WSO2 processes with a specific OS-level user</p>
         </td>
         <td>
            Use a separate OS-level user to run WSO2 products. Make sure that the user is only granted the permissions required for running the product for that particular user. Do not use the root/administrator user of your OS because the root/administrator is granted all privileges by default.
         </td>
      </tr>
      <tr class="even">
         <td>
            <p>Minimize software to avoid vulnerability</p>
         </td>
         <td>
            <p>Make sure that you only install the software/packages that are relevant to your WSO2 product's deployment. Also, continuously monitor the software that you install.</p>
            <p>See the <a href="{{base_path}}/install-and-setup/install/installation-prerequisites">Installation Prerequisites</a> to identify the minimum software your WSO2 product will need.</p>
         </td>
      </tr>
      <tr class="odd">
         <td>
            <p>Enable the Firewall</p>
         </td>
         <td>
            Enable a firewall at the OS level (for example, <a href="https://help.ubuntu.com/community/IptablesHowTo">iptables</a>). This will provide protection for inbound and outbound connections of your WSO2 product. Make sure that you only open the required outbound and inbound ports from the OS-level firewall.
         </td>
      </tr>
      <tr class="odd">
         <td>
            <p>Use Secure Shell(SSH)</p>
            <p><br /></p>
         </td>
         <td>
            <p>Use Secure Shell (SSH) when interacting with servers and executing commands. Adhere to the following best practices when you configure SSH:</p>
            <ul>
               <li>Change the default ssh port to a higher value.</li>
               <li>Disable the root or administrator.</li>
               <li>Enable login with user keys.</li>
               <li>Display a legal banner or a security banner with security warnings before SSH authentication.</li>
            </ul>
         </td>
      </tr>
      <tr class="even">
         <td>
            <p>Keep the system up-to-date</p>
         </td>
         <td>
            <p>If there are security updates available for the packages installed in your OS (including the Java runtime), be sure to perform the necessary testing in a staging environment, and then proceed to install them for your OS.</p>
         </td>
      </tr>
      <tr class="odd">
         <td>
            <p>Monitor user activities</p>
         </td>
         <td>
            Monitor the activities of your OS users. You can do this by enabling OS-level logs and by reviewing them regularly. You can also set up a centralized log monitoring system for this purpose.
         </td>
      </tr>
      <!--
      <tr class="even">
         <td>Session Data Cleanup</td>
         <td>
            <p><strong>Note:</strong> This security guideline is specific only to WSO2 Identity Server.</p>
            <p>In a production environment, there is a possibility for a deadlock/database lock to occur when running a session data cleanup task in high load scenarios. To mitigate this, configure the following property to clean data in chunks. Configure this property in the <code>              &lt;IS_HOME&gt;/repository/conf/identity/identity.xml             </code> file under <code>              &lt;SessionDataCleanUp&gt;             </code> with the required chunk size. This value is in the number of records and depends on the database type and server capacity. It also depends on the amount of load generated by single sign-on (SSO). A higher value increases the chances of deadlocks and a lower value increases the time it takes for a cleanup.</p>
            <p><br /></p>
            <div class="code panel pdl" style="border-width: 1px;">
               <div class="codeContent panelContent pdl">
                  <div class="sourceCode" id="cb1" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence">
                     <pre class="sourceCode java"><code class="sourceCode java"><span id="cb1-1"><a href="#cb1-1"></a>&lt;DeleteChunkSize&gt;<span class="dv">50000</span>&lt;/DeleteChunkSize&gt;</span></code></pre>
                  </div>
               </div>
            </div>
            <p>For more information on configuring sessions in production, see <a href="https://docs.wso2.com/display/identity-server/Authentication+Session+Persistence">Authentication Session Persistence</a> in the WSO2 Identity Server documentation.</p>
         </td>
      </tr>
   -->
      <tr class="odd">
         <td>
            <p>Make regular backups</p>
         </td>
         <td>
            <p>Make sure to backup important files and archive them continuously.</p>
            <p>See <a href="{{base_path}}/install-and-setup/setup/mi-setup/deployment/backup_recovery">Backup and Recovery Recommendations</a> for more information.</p>
         </td>
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
         <td>
            <p>Create a failover setup</p>
            <p><br /></p>
         </td>
         <td>
            <p>In the cloud native deployment, high availability should be achieved via the container orchestration system ( Ex: Kubernetes )</p>
            <p>In a VM deployment, there should be atleast two nodes with the failover configuration.</p>
         </td>
      </tr>
      <tr class="even">
         <td>
            <p>Maintain network level logging</p>
         </td>
         <td>
            <p>Be sure to maintain and monitor logs for your proxy servers, load balancers, and other network devices.</p>
         </td>
      </tr>
      <tr class="odd">
         <td>
            <p>Check open ports and services</p>
         </td>
         <td>
            <p>Periodically check for open ports using port scanning tools and make sure that only the necessary ports are open to both internal and external networks. Be sure that only the ports relevant to your WSO2 products are open for communication. If there are other ports started, be sure to monitor them.</p>
            <p>See the <a href="{{base_path}}/install-and-setup/setup/mi-setup/changing_default_ports">default ports</a> for more information.</p>
         </td>
      </tr>
      <tr class="even">
         <td>
            <p>Configure device-level security</p>
         </td>
         <td>
            <p>All your network devices should be periodically checked for anomalies. For example, you need to verify routing tables and firewall rules.</p>
            <p>Also, make sure that the default credentials are changed before the first use of those devices.</p>
         </td>
      </tr>
      <tr class="odd">
         <td>
            <p>Apply firmware updates</p>
         </td>
         <td>
            <p>Firmware updates for your network devices should be applied regularly.</p>
         </td>
      </tr>
   </tbody>
</table>

## Monitoring Transaction Counts

A **Transaction** in WSO2 Micro Integrator is typically defined as an inbound request (a request coming to the server). That is, any inbound request to a [REST API]({{base_path}}/integrate/develop/creating-artifacts/creating-an-api), [Proxy service]({{base_path}}/integrate/develop/creating-artifacts/creating-a-proxy-service), or [Inbound Endpoint]({{base_path}}/integrate/develop/creating-artifacts/creating-an-inbound-endpoint) is considered as one transaction.

However, when the Micro Integrator is configured as both the message producer and consumer to handle **asynchronous** messaging scenarios, the two requests (listening request and sending request) are considered as a single transaction.

If you need to track the number of transactions in your Micro Integrator deployment, you can enable the transaction counter component in each Micro Integrator instance of your deployment. Currently, the transaction counter is responsible for counting all requests received via the [HTTP Passthru]({{base_path}}/install-and-setup/setup/mi-setup/transport_configurations/configuring-transports/#configuring-the-httphttps-transport) and [JMS]({{base_path}}/install-and-setup/setup/mi-setup/transport_configurations/configuring-transports/#configuring-the-jms-transport) transports and for persisting the summary of the transaction count in a database for future use.

Follow the instructions given below.

### Enabling the Transaction Counter

Configure a relational database to persist transaction count information and then enable the **Transaction Counter** component from the `deployment.toml` file (stored in the `<MI_HOME>/conf` folder).

1.  Select the preferred database type from the  list given below and follow the relevant link to set up a database.

    - [Setting up a MySQL database]({{base_path}}/install-and-setup/setup/mi-setup/databases/setting-up-MySQL)
    - [Setting up an MSSQL database]({{base_path}}/install-and-setup/setup/mi-setup/databases/setting-up-MSSQL)
    - [Setting up an Oracle database]({{base_path}}/install-and-setup/setup/mi-setup/databases/setting-up-Oracle)
    - [Setting up a Postgre database]({{base_path}}/install-and-setup/setup/mi-setup/databases/setting-up-PostgreSQL)
    - [Setting up an IBM database]({{base_path}}/install-and-setup/setup/mi-setup/databases/setting-up-IBM-DB2)

2.  Once you have set up the database, verify that the `deployment.toml` file of your Micro Integrator contains the relevant datasource configurations:

    ```toml tab='MySQL'
    [[datasource]]
    id = "WSO2_TRANSACTION_DB"
    url= "jdbc:mysql://localhost:3306/transactiondb"
    username="root"
    password="root"
    driver="com.mysql.jdbc.Driver"
    pool_options.maxActive=50
    pool_options.maxWait = 60000
    pool_options.testOnBorrow = true
    ```

    ```toml tab='MSSQL'
    [[datasource]]
    id = "WSO2_TRANSACTION_DB"
    url= "jdbc:sqlserver://<IP>:1433;databaseName=transactiondb;SendStringParametersAsUnicode=false"
    username="root"
    password="root"
    driver="com.microsoft.sqlserver.jdbc.SQLServerDriver"
    pool_options.maxActive=50
    pool_options.maxWait = 60000
    pool_options.testOnBorrow = true
    ```

    ```toml tab='Oracle'
    [[datasource]]
    id = "WSO2_TRANSACTION_DB"
    url= "jdbc:oracle:thin:@SERVER_NAME:PORT/SID"
    username="root"
    password="root"
    driver="oracle.jdbc.OracleDriver"
    pool_options.maxActive=50
    pool_options.maxWait = 60000
    pool_options.testOnBorrow = true
    ```

    ```toml tab='PostgreSQL'
    [[datasource]]
    id = "WSO2_TRANSACTION_DB"
    url= "jdbc:postgresql://localhost:5432/transactiondb"
    username="root"
    password="root"
    driver="org.postgresql.Driver"
    pool_options.maxActive=50
    pool_options.maxWait = 60000
    pool_options.testOnBorrow = true
    ```

    ```toml tab='IBM DB'
    [[datasource]]
    id = "WSO2_TRANSACTION_DB"
    url="jdbc:db2://SERVER_NAME:PORT/transactiondb"
    username="root"
    password="root"
    driver="com.ibm.db2.jcc.DB2Driver"
    pool_options.maxActive=50
    pool_options.maxWait = 60000
    pool_options.testOnBorrow = true
    ```

3.  Add the parameters given below to the `deployment.toml` file and update the values.

    ```toml
    [transaction_counter]
    enable = true
    data_source = "WSO2_TRANSACTION_DB"
    update_interval = 2
    ```

    Parameters used above are explained below.

    <table>
    	<tr>
    		<th>Parameter</th>
    		<th>Description</th>
    	</tr>
    	<tr>
    		<td>
    			<code>enable</code>
    		</td>
    		<td>
    			This paramter is used for enabling the Transaction Counter. Default value if 'false'.
    		</td>
    	</tr>
    	<tr>
    		<td>
    			<code>data_source</code>
    		</td>
    		<td>
    			The ID of the datasource. This refers the datasource ID configured under the datasource configuration.
    		</td>
    	</tr>
    	<tr>
    		<td>
    			<code>update_interval</code>
    		</td>
    		<td>
    			The transaction count is stored in the database with an interval (specified by this parameter, which will be taken as the number of minutes) between the insert queries. The default update interval is one minute.
    		</td>
    	</tr>
    </table>

### Getting the Transaction Count

You can get the transaction count for a particular month or period. This data can be viewed or saved to a report. There are two ways to get transaction count data:

-  Start the [Micro Integrator CLI]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller) and use the [mi transaction]({{base_path}}/install-and-setup/setup/api-controller/managing-integrations/managing-integrations-with-ctl) option.

-  Directly access the [Management API resources]({{base_path}}/observe/mi-observe/working-with-management-api) and invoke the [/transaction/count]({{base_path}}/working-with-management-api/#get-transaction-count) and [/transaction/report]({{base_path}}/observe/mi-observe/working-with-management-api)/#get-transaction-report-data) resources.
