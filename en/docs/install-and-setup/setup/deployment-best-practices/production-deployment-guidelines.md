# Production Deployment Guidelines

The requirements for deploying WSO2 products can change based on the deployment scenario and pattern. The 
recommendations in this topic are for general production use, assuming moderate load conditions. For situations where
 a high volume of traffic is expected and if there are large deployments, these guidelines may not be sufficient. See
  [Troubleshooting in Production Environments]({{base_path}}/troubleshooting/admin-troubleshooting-in-production-environments) for
  information on how to obtain and analyze information to solve production issues. The following are the topics addressed in this section. The 
  following are the topics addressed in this section.
------------------------------------------------------------------------

-   [Installation Prerequisites](#installation-prerequisites) 
-   [Installing the WSO2 Product](#installing-the-wso2-product) 
-   [Running the Product](#running-the-product) 
-   [Tuning Parameters](#tuning-parameters) 
-   [Common Guidelines and Checklist](#common-guidelines-and-checklist) 
-   [Backup and Recovery Recommendations](#backup-and-recovery-recommendations)

------------------------------------------------------------------------

## Installation Prerequisites

Prior to installing any WSO2 Carbon-based product, it is necessary to have the appropriate hardware and software for running the product.

### System Requirements

<table>
<tbody>
<tr class="odd">
<td>Physical</td>
<td><ul>
<li>3 GHz Dual-core Xeon/Opteron (or latest)</li>
<li>4 GB RAM (2 GB for JVM and 2 GB for the operating system)</li>
<li>10 GB free disk space</li>
<li>~ Recommended minimum - 2 Cores. For high concurrencies and better performances - 4 Cores.</li>
</ul>
<p>Disk space is based on the expected storage requirements that are calculated by considering the file uploads and the backup policies. For example, if three WSO2 product instances are running in a single machine, it requires a 4 GHz CPU, 8 GB RAM (2 GB for the operating system and 6 GB (2 GB for each WSO2 product instance)) and 30 GB of free space.</p></td>
</tr>
<tr class="even">
<td>Virtual Machine (VM)</td>
<td><ul>
<li>2 compute units minimum (each unit having 1.0-1.2 GHz Opteron/Xeon processor)</li>
<li>4 GB RAM</li>
<li>10 GB free disk space</li>
<li>One CPU unit for the operating system and one for JVM.</li>
</ul>
<p>Three WSO2 product instances running would require VM of 4 compute units, 8 GB RAM, and 30 GBfree space.<br />
~ 512 MB heap size. This is generally sufficient to process typical SOAP messages but the requirements vary with larger message sizes and the number of messages processed concurrently.</p></td>
</tr>
<tr class="odd">
<td>EC2</td>
<td><ul>
<li>One c5.large instance to run one WSO2 product instance.</li>
</ul></td>
</tr>
<tr class="even">
<td>Cassandra data nodes</td>
<td><ul>
<li>4 core processors</li>
<li>8 GB RAM</li>
</ul>
<p>For more information, see the <a href="http://www.datastax.com/documentation/cassandra/1.2/cassandra/architecture/architecturePlanningHardware_c.html">Cassandra documentation on hardware recommendations for enterprise implementations</a> .</p></td>
</tr>
</tbody>
</table>

### Environment compatibility

-   If you are using the product installer to install the product, by default, WSO2 API-M is installed with OpenJDK, 
which allows you to run the product as soon as it is installed. If you are using the product's binary distribution to
 install the product (instead of the product installer), install JDK. Make sure your JDK version is compatible with 
 the WSO2 product.

!!! tip
    To use a different JDK, point the **`JAVA_HOME`** environment variable to the new JDK. Make sure your JDK version is [compatible with the WSO2 product](https://docs.wso2.com/display/compatibility/Tested+Operating+Systems+and+JDKs).


-   All WSO2 products are generally compatible with most common DBMSs. The embedded H2 database is suitable for development, testing, and some production environments. For most enterprise production environments, however, we recommend you use an industry-standard RDBMS such as Oracle, PostgreSQL, MySQL, MS SQL, etc. For more information, see [Working with Databases](https://docs.wso2.com/display/ADMIN44x/Working+with+Databases) in the Administration Guide. Also, we do not recommend the H2 database as a user store.
-   It is **not recommended to use Apache DS** in a production environment due to scalability issues. Instead, use an LDAP like OpenLDAP for user management.
-   On a production deployment, it is recommended that WSO2 products are installed on latest releases of RedHat Enterprise Linux or Ubuntu Server LTS.
-   For environments that WSO2 products are tested with, see [Compatibility of WSO2 Products](https://docs.wso2.com/display/compatibility/Compatibility+of+WSO2+Products) .
-   If you have difficulty in setting up any WSO2 product in a specific platform or database, contact us .

------------------------------------------------------------------------

## Installing the WSO2 Product

Given below is how to install a WSO2 product:

### Download and Install the Product

If the installation [prerequisites](#installation-prerequisites) are satisfied, follow the steps below:

1.  Go to the [product page](https://wso2.com/api-management/) and download the product installer (click **Installer pkg** ).

!!! tip
    Note that there are several options for installing the product in various environments. Use the available links for more information on each option.


2.  Double-click to open the installation wizard, which will guide you through the installation. When you finish, the product will be installed and ready for use.

### Access the HOME Directory

Let's call the installation location of your product as the **&lt;PRODUCT\_HOME&gt;** directory. This is located in a place specific to your OS as shown below:

| OS      | Home directory                                                                                       |
|---------|------------------------------------------------------------------------------------------------------|
| Mac OS  | `/Library/WSO2/<PRODUCT_NAME>/<VERSION>`|
| Windows | `C:\Program Files\WSO2\<PRODUCT_NAME>/<VERSION>             \` |
| Ubuntu  | `/usr/lib/wso2/<PRODUCT_NAME>/<VERSION>`|
| CentOS  | `/usr/lib64/<PRODUCT_NAME>/<VERSION>`|

### Uninstalling the Product

To remove an already installed product, follow the instructions below:

| OS      | Instructions                                                                                                                                                                                                                              |
|---------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Mac OS  | Open a terminal and run the following command as the root user: <br>```` sudo bash /Library/WSO2/<PRODUCT_NAME>/<VERSION>/uninstall.sh ```` |                                                                                                                                                                    
| Windows | Go to the **Start Menu -&gt; Programs -&gt; WSO2 -&gt; Uninstall &lt;PRODUCT\_NAME\_VERSION&gt;** or search **Uninstall &lt;PRODUCT\_NAME\_VERSION&gt;** and click the shortcut icon. This will uninstall the product from your computer. |
| Ubuntu  | Open a terminal and run the following command: <br>````sudo apt-get purge <PRODUCT_DISTRIBUTION_NAME>````                                                       
| CentOS  | Open a terminal and run the following command: <br>````sudo yum remove <PRODUCT_DISTRIBUTION_NAME>-x86_64 ````                                                                                                                                                                                                                                             
                                                                                                                                                                                                                                  
### Setting System Properties

If you need to set additional system properties when the server starts, you can take the following approaches:

-   **Set the properties from a script** . Setting your system properties in the product's startup script (wso2server.sh
  for Linux and wso2server.bat for Windows), is ideal because it ensures that you set the properties every time you 
  start the server. To avoid having to modify the script each time you upgrade, the best approach is to create your own startup script that wraps the WSO2 startup script and adds the properties you want to set, rather than editing the WSO2 startup script directly.

    !!! note
        Be sure to set the system properties `org.opensaml.httpclient.https.disableHostnameVerification` and `httpclient.hostnameVerifier`
         in the the product's startup script file to as follows. This setting will enable hostname verification of 
         HTTP requests and responses in the Carbon server, and thereby avoid security issues in production environments. 
         For more information, see [Enabling HostName Verification]({{base_path}}/administer/product-security/enabling-hostname-verification/).

```  
    -Dorg.opensaml.httpclient.https.disableHostnameVerification=false \
    -Dhttpclient.hostnameVerifier=Strict \
```

-   **Set the properties from an external registry** 

    If you want to access properties from an external registry, you could create Java code that reads the properties at runtime from that registry. Be sure to store sensitive data such as username and password to connect to the registry in a property file instead of in the Java code and secure the properties file with the [secure vault](https://docs.wso2.com/display/ADMIN44x/Carbon+Secure+Vault+Implementation) .

!!! note    
    When using SUSE Linux, it ignores `/etc/resolv.conf` and only looks at the `/etc/hosts` file. This means that the server will throw an exception on startup if you have not specified anything besides localhost. To avoid this error, add the following line above `127.0.0.1 localhost` in the `/etc/hosts` file: `<ip_address><machine_name> localhost`


You are now ready to run the product.

------------------------------------------------------------------------

## Running the product

To run WSO2 products, you start the product server at the command line. You can then run the Management Console application to configure and manage the product.

### Before you begin

-   When you move into a production environment, it is recommended to grant restricted access to the management 
console. See [Securing Carbon Applications](https://docs.wso2.com/display/ADMIN44x/Securing+Carbon+Applications) for instructions.
-   The `config-validation.xml` file in the `<PRODUCT_HOME>/repository/conf/etc` directory contains a list of 
recommended system parameters, which are validated against your system when the server starts. See [Configuring 
config-validation.xml](https://docs.wso2.com/display/ADMIN44x/Configuring+config-validation.xml) for details on 
modifying these parameters before starting the server.
-   The Management Console uses the default [HTTP-NIO transport](https://docs.wso2.com/display/ADMIN44x/HTTP-NIO+Transport), of which the configurations are reflected in the `catalina-server.xml` 
file in the `<PRODUCT_HOME>/repository/conf/tomcat` directory. According to the new depolyment.toml based configuration model, to
 change the configurations in this file, please add the below configurations with appropriate values in 
 `<PRODUCT_HOME>/repository/conf/deployment.toml` file.
 
??? Note "Click to view the configurations"
    ````
    [transport.http.properties]
    port = 9763
    redirectPort = 9443
    bindOnInit = false
    maxHttpHeaderSize = 8192
    acceptorThreadCount = 2
    maxThreads = 250
    minSpareThreads = 50
    disableUploadTimeout = false
    connectionUploadTimeout = 120000
    maxKeepAliveRequests = 200
    acceptCount = 200
    server = "WSO2 Carbon Server"
    compression = "on"
    compressionMinSize = 2048
    noCompressionUserAgents = "gozilla, traviata"
    compressibleMimeType = "text/html,text/javascript,application/x-javascript,application/javascript,application/xml,text/css,application/xslt+xml,text/xsl,image/gif,image/pg,image/jpeg"
    URIEncoding = "UTF-8"
    
    [transport.https.properties]
    port = 9443
    bindOnInit = false
    maxHttpHeaderSize = 8192
    acceptorThreadCount = 2
    maxThreads = 250
    minSpareThreads = 50
    disableUploadTimeout = false
    enableLookups = false
    connectionUploadTimeout = 120000
    maxKeepAliveRequests = 200
    acceptCount = 200
    server = "WSO2 Carbon Server"
    compression = "on"
    scheme = "https"
    secure = true
    SSLEnabled = true
    compressionMinSize = 2048
    noCompressionUserAgents = "gozilla, traviata"
    compressibleMimeType = "text/html,text/javascript,application/x-javascript,application/javascript,application/xml,text/css,application/xslt+xml,text/xsl,image/gif,image/jpg,image/jpeg"
    URIEncoding = "UTF-8"
    
    [transport.https.sslHostConfig.properties]
    protocols = "+TLSv1,+TLSv1.1,+TLSv1.2"
    sslProtocol = "TLS"
    certificateVerification = false
    ````
 
These configurations has to be set properly for the management console to be accessible.

-   As explained in the [installation prerequisites](#installation-prerequisites) , the default product installation uses OpenJDK. Therefore, you don't require a different JDK. However, if you have set up Oracle JDK or IBM JDK, be sure to apply the following settings to your product distribution.

    -   [**Oracle JDK**](#cc08b6aaf09742a7b6389db09f3e3b36)
    -   [**IBM JDK**](#944559bca1c0464fa8a12ec742f9cd07)

    Some updates of JDK 1.8 (for example, **JDK1.8.0\_151** ) are affected by a [known issue](https://bugs.openjdk.java.net/browse/JDK-8189789) related to GZIP decoding. Until this issue is fixed, we recommend that you disable GZIP decoding for your product by following the steps given below. This will ensure that your product is not affected by the [known issue](https://bugs.openjdk.java.net/browse/JDK-8189789) .

    1.  Open the `deployment.toml` file from the `<PRODUCT_HOME>/repository/conf/` directory.
    2.  Set the `compression` parameter (under each of the above described HTTP-NIO transport connector 
    configurations:  [transport.http.properties] and [transport.https.properties]) 
    to false as shown below:

        ````
        [transport.http.properties]
        compression="off"
        ````
        ````
        [transport.http.properties]
        compression="off"
        ````

    3.  Restart the server.

    If you are using IBM JDK 1.8, change the value of the `org.owasp.csrfguard.PRNG.Provider` property to ' `IBMJCE` ' in the `Owasp.CsrfGuard.Carbon.properties` file. This file is stored in the `<PRODUCT_HOME>/repository/conf/security` / directory.

### Starting the Product Profiles

When a WSO2 product starts, it starts all components, features and related artifacts bundled with it. Multi-profile 
support allows you to run the product on a selected profile so that only the features specific to that profile along 
with common features start up with the server. For more on product-profiles please refer 
[Product Profiles]({{base_path}}/install-and-setup/deploying-wso2-api-manager/distributed-deployment/product-profiles
/#product-profiles).

### Stopping the Server

To stop the server, press **Ctrl+C** in the command window, or click the **Shutdown/Restart** link in the navigation pane in the Management Console.

### Running Recommendations for Security

The following are security related recommendations to be followed when running the product.

-   **Running as a different user** : For security reasons, it's recommended to run the product as an unprivileged user. After adding a user to the system, apply your organizational security policies to that user.
-   **Running on a different port** : If you want to run on a different port, like port 80, the recommended way is to add a port forwarding rule from your firewall.
-   **Running as a Unix daemon** : You have the option of running each product as a standard Unix service. You can start, stop, and restart the WSO2 product instances as follows.
`# sh bin/wso2server.sh [start | stop | restart]         `

------------------------------------------------------------------------

## Tuning Parameters

-   The latency numbers (~50ms) are based on a two datacenter setup with a high-speed network connection. With the default configuration, you might notice intermittent behavior, so it is important to tune the system.
-   It is not recommended to use Metrics for system monitoring (JVM, CPU, etc.) in a production deployment. You can use external monitoring tools for this purpose.

------------------------------------------------------------------------

## Common Guidelines and Checklist

The following table lists out the common guidelines and details pertaining to them. These are common to all products and are followed for making an installed WSO2 product ready for production.

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
<td><div class="content-wrapper">
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
<p>See <a href="https://docs.wso2.com/display/ADMIN44x/Security+Guidelines+for+Production+Deployment">Security Guidelines for Production Deployment</a> for the detailed list of security-related recommendations.</p>
</div>
</div>
</div></td>
</tr>
<tr class="even">
<td>Hostname</td>
<td><div class="content-wrapper">
<p>By default, WSO2 products identify the hostname of the current machine through the Java API. However, this value 
sometimes yields erroneous results on some environments. Therefore, users are recommended to configure the hostname 
by setting the <code>hostname</code> parameter in the <code> &lt;PRODUCT_HOME&gt;/repository/conf/deployment.toml</code> file.</p>
````
[server]
hostname = "test.wso2.com"
````
<div class="panel" style="border-width: 1px;">
<div class="panelHeader" style="border-bottom-width: 1px;">
<strong>Related links</strong>
</div>
<div class="panelContent">
<ul>
<li>See the topics on changing hostnames shown below:
<ul>
<li>
<a href="{{base_path}}/install-and-setup/deploying-wso2-api-manager/changing-the-default-ports-with-offset">Setting up hostnames and ports</a>
</li>
<li>
<a href="{{base_path}}/install-and-setup/deploying-wso2-api-manager/changing-the-hostname">Changing the hostname</li>
</ul></li>
<li>See <a href="https://docs.wso2.com/display/ADMIN44x/Working+with+Transports">Working with Transports</a> for information on transports in WSO2 products.</li>
</ul>
</div>
</div>
</div></td>
</tr>
<tr class="odd">
<td>Registry and governance</td>
<td><div class="content-wrapper">
<p>All WSO2 products make use of an instance of a registry to store configurations. The registry uses a database as the persistent storage. By default, the registry uses an embedded H2 database.</p>
<p>This embedded database might yield a lower performance and is less reliable compared to a standard database like MySQL when there are a large number of deployed artifacts. Hence, you should look at associated trade-offs, and we recommend that you switch to a database like Oracle, MySQL or MSSQL.</p>
<p>Moreover, it is worth noting that the default setup does not include database backup procedures. The production setup should obviously need to have regular database backup procedures configured.</p>
<p>When the registry database is pointed to a remote database, multiple running instances of the same product can boot up and run against the same configuration stored in the registry. This, in turn, helps with governance.</p>
<div class="panel" style="border-width: 1px;">
<div class="panelHeader" style="border-bottom-width: 1px;">
<strong>Related links</strong>
</div>
<div class="panelContent">
<p>See <a href="http://wso2.org/library/tutorials/2010/04/sharing-registry-space-across-multiple-product-instances">here</a> for more information on sharing a registry space across multiple WSO2 product instances.</p>
</div>
</div>
<strong>Solr based indexing</strong>
<p>API Manager has a Solr based indexing mechanism and it is not recommended to share the Solr directory <code>&lt;PRODUCT_HOME&gt;/solr/data/</code> between the Developer Portal and Publisher servers. You need to have seperate Solr directories for each of the servers.</p>
</div></td>
</tr>
<tr class="even">
<td>User stores</td>
<td><div class="content-wrapper">
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

<p>See <a href="{{base_path}}/administer/product-administration/managing-users-and-roles
/managing-user-stores/configure-primary-user-store/configuring-the-primary-user-store/">Configuring Primary User 
Store</a> and <a href="{{base_path}}/administer/product-administration/managing-users-and-roles/managing-user-stores
/configuring-secondary-user-stores/">Configuring Secondary User Stores</a> for more information on user stores, how 
they work, and how to configure them.</p>
</div>
</div>
</div></td>
</tr>
<tr class="odd">
<td>Monitoring with JMX</td>
<td><div class="content-wrapper">
<p>WSO2 Products supportJMXformonitoring. By default, JMX uses port 9999. You can configure this to the desired port 
by adding the JMX port parameter in the <code> &lt;PRODUCT_HOME&gt;/repository/conf/deployment.toml</code> file</p> as below

````
 [monitoring.jmx]
 rmi_registry_port = 9999
 rmi_server_port = 11111
```` 
<div class="panel" style="border-width: 1px;">
<div class="panelHeader" style="border-bottom-width: 1px;">
<strong>Related links</strong>
</div>
<div class="panelContent">
<p>Please refer <a href="{{base_path}}/administer/product-administration/monitoring/jmx-based-monitoring/#configuring-jmx-in-a-wso2-product">JMX-Based Monitoring</a> for 
information on monitoring WSO2 products using JMX.</p>
</div>
</div>
</div></td>
</tr>
<tr class="even">
<td>Tuning WSO2 products</td>
<td><div class="content-wrapper">
<p>Most of the performance tuning recommendations are common to all WSO2 products. However, each WSO2 product may have additional guidelines for optimizing the performance of product-specific features.</p>
<div class="panel" style="border-width: 1px;">
<div class="panelHeader" style="border-bottom-width: 1px;">
<strong>Related links</strong>
</div>
<div class="panelContent">
<div>
<ul>
<li>See <a href="{{base_path}}/install-and-setup/performance-tuning-and-test-results/tuning-performance">Performance 
Tuning</a> for the WSO2 API Manager related guidelines.</li>
<li>For performance tuning guidelines that are specific to each product, go to the product documentation for each 
product listed below and search for performance tuning guidelines.<br />
<br />
Listed below are the main WSO2 products:</li>
</ul>
</div>
<ul>
<li><ul>
<li><a href="http://docs.wso2.com/api-manager/">API Manager</a></li>
<li><a href="http://docs.wso2.com/data-analytics-server">Data Analytics Server</a></li>
<li><a href="http://docs.wso2.com/enterprise-integrator">Enterprise Integrator</a> profiles
<ul>
<li>ESB profile</li>
<li>Business Process Management profile</li>
<li>Message Broker profile</li>
<li>Analytics profile</li>
<li>Micro Integrator profile</li>
</ul></li>
<li><a href="http://docs.wso2.com/iot-server">IOT Server</a></li>
<li><a href="http://docs.wso2.com/identity-server">Identity Server</a></li>
<li><a href="http://docs.wso2.com/enterprise-service-bus">Enterprise Service Bus</a></li>
</ul></li>
</ul>
<p>The following are now legacy products of WSO2:</p>
<ul>
<li><ul>
<li><a href="http://docs.wso2.com/application-server/">Application Server</a></li>
<li><a href="http://docs.wso2.com/business-rules-server">Business Rules Server</a></li>
<li><a href="http://docs.wso2.com/enterprise-mobility-manager">Enterprise Mobility Manager</a></li>
<li><a href="http://docs.wso2.com/enterprise-store">Enterprise Store</a></li>
<li><a href="http://docs.wso2.com/governance-registry">Governance Registry</a></li>
</ul></li>
</ul>
</div>
</div>
</div></td>
</tr>
<tr class="odd">
<td>Firewalls</td>
<td><div class="content-wrapper">
<p>The following ports must be accessed when operating within a firewall. Please note that these configurations are 
required to be configured in <code>&lt;PRODUCT_HOME&gt;/repository/conf/deployment.toml</code> file, eventhought they 
are reflected in the below mentioned config files, according to the new configuration model introduced with APIM 3.0
 .0 onwards.</p>
<ul>
<li>9443 - Used by the management console and services that use the servlet transport, and is reflected in the <code>
                &lt;PRODUCT_HOME&gt;/repository/conf/tomcat/catalina-server.xml               </code> file.</li>
<li>9763 - Used by the services that use servlet transport, and is reflected in the <code>                &lt;PRODUCT_HOME&gt;/repository/conf/tomcat/catalina-server.xml               </code> file.</li>
<li>9999 - Used for JMX monitoring, reflected in the <code>                &lt;PRODUCT_HOME&gt;/repository/conf/carbon.xml               </code> file.</li>
<li>8280 - Default HTTP port used by ESB for proxy services, and is reflected in the <code>                &lt;PRODUCT_HOME&gt;/repository/conf/axis2/axis2.xml               </code> file.</li>
<li>8243 - Default HTTPS port used by ESB for proxy services, and is reflected in the <code>                &lt;PRODUCT_HOME&gt;/repository/conf/axis2/axis2.xml               </code> file.</li>
</ul>
<div class="panel" style="border-width: 1px;">
<div class="panelHeader" style="border-bottom-width: 1px;">
<strong>Related links</strong>
</div>
<div class="panelContent">
<p>See <a href="{{base_path}}/administer/product-configurations/default-product-ports/">Default Product Ports</a> for
 a list of common and product-specific ports used by WSO2 products.</p>
</div>
<div class="panelHeader" style="border-bottom-width: 1px;">
<strong>Firewall between Traffic Manager and Gateway</strong>
</div>
<p>If you have a firewall between the Traffic Manager and the Gateway, you need to configure the heartbeat value to keep the JMS connection alive. To configure this open the <code>&lt;PRODUCT_HOME&gt;/repository/conf/advanced/qpid-config.xml</code> file and set the heartbeat value to a non zero value as shown below.</p>
<div class="codeContent panelContent pdl">
```
<heartbeat>
  <delay>60</delay>
  <timeoutFactor>2.0</timeoutFactor>
</heartbeat>
```
</div>
</div>
</div></td>
</tr>
<tr class="even">
<td>Proxy servers</td>
<td><div class="content-wrapper">
<p>If the product is hosted behind a proxy such as ApacheHTTPD, users can configure products to use the proxy server by providing the following system properties at the start-up.</p>
<div class="code panel pdl" style="border-width: 1px;">
<div class="codeContent panelContent pdl">
<pre class="java" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence"><code>-Dhttp.proxyHost=xxxx 
-Dhttp.proxyPort=xxxx</code></pre>
</div>
</div>
</div></td>
</tr>
<tr class="odd">
<td>High availability</td>
<td><div class="content-wrapper">
<p>For high availability, WSO2 API Manager can be run on a cluster. Hazelcast clustering is disabled in WSO2 API 
Manager (WSO2 APIM) by default, because you 
can successfully deploy WSO2 API Manager without Hazelcast. </p>
<div class="panel" style="border-width: 1px;">
<div class="panelContent">
</div>
</div>
</div></td>
</tr>
<tr class="even">
<td>Data backup and archiving</td>
<td>For data backup and for archiving of data, use the functionality provided by the RDBMS.</td>
</tr>
</tbody>
</table>

------------------------------------------------------------------------

## Backup and Recovery Recommendations

None of the WSO2 products persist data in the file systems or retain or generate artifacts. By default, we only store log files in the file system and data and artifacts in the databases and the repository.

### What You Should Backup

1.  **Database backups** :
    -   Back up of all the databases defined in `<PRODUCT_HOME>/repository/conf/datasources/master-datasources.xml` .
    -   Back up any other databases configured in any files in the `<PRODUCT_HOME>/repository/conf/datasources` directory.
2.  **Artifact backups** :
    This includes hot-deployment artifacts, web applications, synapse files, tenant directories, etc. Back up of the `<PRODUCT_HOME>/repository` directory periodically. The frequency of the back ups depends on your usage. For example, if you are creating or updating APIs daily, take this backup daily.
3.  **WSO2 product instance backups** :
    A one-time-only backup that you take of the entire server directory. This includes all the configuration files, logs, server extensions, and deployment artifacts for both tenants and super tenants. This back up is ideally done when the server is ready to be deployed in a production environment.

### Backup recommendations

We recommend that you use a proper artifact management system such as **[Puppet](https://puppet.com/)** to back up and manage your artifacts before deploying them in the WSO2 Carbon runtime. Also, use the **[WSO2 Update Manager (WUM)](https://docs.wso2.com/display/ADMIN44x/Updating+WSO2+Products)** tool , which is a command-line utility that allows you to get the latest updates ( bug fixes and security fixes ) of a particular product release.
    ![managing your artifacts using a configuration management system]({{base_path}}/assets/img/administer/configuration-mgmt-system.png)
**Diagram** : managing your artifacts using a configuration management system
     
### Recovery Recommendations

Be sure to determine the following depending on your business-continuity requirements:

-   **Recovery Point Objective (RPO)** : Up to what points are you to recover. This is determined by the latest, known, good point.
-   **Recovery Time Objective (RTO)** : How long does it take to recover to the RPO.
-   **Backup Frequency** : How frequently you should take backups. If your RPO is one day, your backup frequency should be daily.
-   **Disaster Recovery Site** : The place where the latest copy of your backup is. This can be from a different shelf in your data center to a completely different geographical location.

We also recommend the following:

1.  Align your artifact deployment and recovery processes.
2.  Schedule disaster recovery drills to test the recoverability of the system.
3.  Test your artifacts in an environment that is identical to the production environment before deploying them into production.

### Recovery Strategy

The following steps include how to recover your setup using the backups:

1.  Recover the hot-deployment artifacts by replacing the `<PRODUCT_HOME>/repository` directory with the backed up copy.
2.  Recover the entire WSO2 product by directly replacing the existing WSO2 server directory in the production setup with the backup server directory. This will ensure that all the files, logs, and configurations made to the product do not need to be redone.
3.  To recover the databases, follow the recovery strategy recommended by the databases you are using. For information on supported and tested databases, see [Tested Database Management Systems](https://docs.wso2.com/display/compatibility/Tested+DBMSs) .


