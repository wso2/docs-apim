# Installation Prerequisites

Prior to installing any WSO2 Carbon based product, it is necessary to have the appropriate prerequisite software installed on your system. Verify that the computer has the supported operating system and development platforms before starting the installation.

### System requirements

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
<p>Three WSO2 product instances running would require VM of 4 compute units, 8 GB RAM, and 30 GB free space.<br />
~ 512 MB heap size. This is generally sufficient to process typical SOAP messages but the requirements vary with larger message sizes and  the number of messages processed concurrently.</p></td>
</tr>
<tr class="odd">
<td>EC2</td>
<td><ul>
<li>1 c5.large instance to run one WSO2 product instance.</li>
</ul>
<p>Three WSO2 product instances can be run in 1 EC2 Extra-Large instance. Based on the I/O performance of the c5.large instance, it is recommended to run multiple instances in a larger instance (c5.xlarge).</p></td>
</tr>
</tbody>
</table>

### Environment compatibility

<table>
<tbody>
<tr class="odd">
<td><p>Operating systems/<br />
Databases</p></td>
<td><div class="content-wrapper">
<ul>
<li><p>All WSO2 Carbon-based products are Java applications that can be run on <strong>any platform that is Oracle JDK 1.8 compliant</strong> . From API Manager 2.5.0 onwards, <strong>OpenJDK 8</strong> is supported as well.</p>
<p>!!! note</p>
<p>For more information on JDKs that WSO2 products are tested with, see <a href="https://docs.wso2.com/display/compatibility/Tested+Operating+Systems+and+JDKs">Tested Operating Systems and JDKs</a> .</p>
</p></li>
<li>All WSO2 Carbon-based products are generally compatible with most common DBMSs. The embedded H2 database is suitable for development, testing, and some production environments. For most enterprise production environments, however, we recommend you use an industry-standard RDBMS such as Oracle, PostgreSQL, MySQL, MS SQL, etc. For more information, see <a href="https://docs.wso2.com/display/AM260/Working+with+Databases">Working with Databases</a> . Additionally, we do not recommend the H2 database as a user store.</li>
<li>It is <strong>not recommended to use Apache DS</strong> in a production environment due to scalability issues. Instead, use an LDAP like OpenLDAP for user management.</li>
<li>On a production deployment, it is recommended that WSO2 products are installed on latest releases of RedHat Enterprise Linux or Ubuntu Server LTS.</li>
<li>For environments that WSO2 products are tested with, see <a href="https://docs.wso2.com/display/compatibility/Compatibility+of+WSO2+Products">Compatibility of WSO2 Products</a> .</li>
<li>To find out if this version of the product has issues running on your OS due to the JDK version, s ee <a href="https://docs.wso2.com/display/compatibility/Known+Incompatibilities">Known Incompatibilities</a> .</li>
<li>If you have difficulty in setting up any WSO2 product in a specific platform or database, please <a href="http://wso2.com/support/">contact us</a> .</li>
</ul>
</div></td>
</tr>
</tbody>
</table>

### Required applications

The following applications are required for running the API Manager and its samples or for building from the source code. Mandatory installs are marked with \*.

<table>
<thead>
<tr class="header">
<th><p>Application</p></th>
<th><p>Purpose</p></th>
<th><p>Version</p></th>
<th>Download Links</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p><strong>Java SE Development Kit (JDK)*</strong></p></td>
<td><ul>
<li>To launch the product as each product is a Java application.</li>
<li>To <a href="https://docs.wso2.com/display/AM260/Working+with+the+Source+Code">build the product from the source distribution</a> (both JDK and Apache Maven are required).</li>
<li>To run Apache Ant.</li>
</ul></td>
<td><div class="content-wrapper">
<ul>
<li>OpenJDK 8</li>
<li><p>Oracle JDK 1.8.*</p>
<p>!!! note</p>
<p>Important!</p>
<p>Some updates of JDK 1.8 (for example, <strong>JDK1.8.0_151</strong> ) are affected by a <a href="https://bugs.openjdk.java.net/browse/JDK-8189789">known issue</a> related to GZIP decoding. Until this issue is fixed, we recommend one of the following approaches:</p>
<ul>
<li>Use either <strong>JDK1.8.0_144</strong> or <strong>JDK1.8.0_077</strong> updates. We have verified that these versions are not affected by the <a href="https://bugs.openjdk.java.net/browse/JDK-8189789">known issue</a> .</li>
<li>Alternatively, you can disable GZIP decoding for your product by following the steps given below. This will ensure that your product is not affected by the <a href="https://bugs.openjdk.java.net/browse/JDK-8189789">known issue</a> .
<ol>
<li>Open the <code>                    catalina-server.xml                   </code> file from the <code>                    &lt;APIM_HOME&gt;/repository/conf/tomcat/                   </code> directory.</li>
<li><p>Set the <code>                     compression                    </code> parameter (under each of the connector configurations) to false as shown below:</p>
<div class="code panel pdl" style="border-width: 1px;">
<div class="codeContent panelContent pdl">
<pre class="java" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence"><code>compression=&quot;off&quot;</code></pre>
</div>
</div></li>
<li>Restart the server.</li>
</ol></li>
</ul>
</p></li>
</ul>
</div></td>
<td><div class="container">
<div class="line number1 index0 alt2">
<a href="http://java.sun.com/javase/downloads/index.jsp">http://java.sun.com/javase/</a>
</div>
<div class="line number1 index0 alt2">
<a href="http://java.sun.com/javase/downloads/index.jsp">downloads/index.jsp</a>
</div>
</div></td>
</tr>
<tr class="even">
<td><p><strong>Apache ActiveMQ</strong> <strong>JMS Provider</strong></p></td>
<td><ul>
<li>To enable the product's JMS transport and try out JMS samples. The ActiveMQ client libraries must be installed in the product's classpath before you can enable the JMS transport.</li>
</ul></td>
<td><p>5.5.0 or later<br />
<br />
If you use any other JMS provider (e.g., Apache Qpid), install any necessary libraries and/or components.</p></td>
<td><a href="http://activemq.apache.org" class="uri">http://activemq.apache.org</a></td>
</tr>
<tr class="odd">
<td><p><strong>Apache Ant</strong></p></td>
<td><ul>
<li>To compile and run the product samples in <code>               &lt;APIM_HOME&gt;/samples              </code> .</li>
</ul></td>
<td><p>1.7.0 or later</p></td>
<td><a href="http://ant.apache.org/">http://ant.apache.org</a></td>
</tr>
<tr class="even">
<td><p><strong>Apache Maven</strong></p></td>
<td><ul>
<li>To <a href="https://docs.wso2.com/display/AM260/Working+with+the+Source+Code">build the product from the source distribution</a> (both JDK and Apache Maven are required). If you are installing by downloading and extracting the binary distribution instead of building from the source code, you do <strong>not</strong> need to install Maven.</li>
</ul></td>
<td><p>3.0.*</p></td>
<td><div class="container">
<div class="line number1 index0 alt2">
<a href="http://maven.apache.org" class="uri">http://maven.apache.org</a>
</div>
</div></td>
</tr>
<tr class="odd">
<td><p><strong>Web Browser</strong></p></td>
<td><div class="content-wrapper">
<ul>
<li>To access the <a href="_Running_the_Product_">Management Console</a> . The Web browser must be JavaScript enabled to take full advantage of the Management console.</li>
</ul>
!!! note
<p>On Windows Server 2003, you must not go below the medium security level in Internet Explorer 6.x.</p>

</div></td>
<td><p><br />
</p></td>
<td><br />
</td>
</tr>
</tbody>
</table>

You are now ready to install. Click one of the following links for instructions:

-   [Installing on Linux or OS X](InstallingTheProduct/installing-on-linux-or-os-x.md)
-   [Installing on Solaris](InstallingTheProduct/installing-on-solaris.md)
-   [Installing on Windows](InstallationGuide/InstallingTheProduct/installing-on-windows.md)
-   [Installing as a Linux Service](InstallingTheProduct/installing-as-a-linux-service.md)
-   [Installing as a Windows Service](InstallingTheProduct/installing-as-a-windows-service.md)

