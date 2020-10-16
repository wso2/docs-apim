# Installation Prerequisites

Before installing WSO2 API Manager, make sure that the appropriate prerequisites are available. Verify that the computer has a supported operating system and development platforms before starting the installation.

## System requirements

<html>
<table>
<tr>
<td><p>Physical</p></td>
<td>
<ul><li>3 GHz Dual-core Xeon/Opteron (or latest)</li>
<li>4 GB RAM (2 GB for JVM and 2 GB for the operating system)</li>
<li>10 GB free disk space</li>
<li>  ~ Recommended minimum - 2 Cores. For high concurrencies and better performances - 4 Cores.

Disk space is based on the expected storage requirements that are calculated by considering the file uploads and the backup policies. For example, if three WSO2 product instances are running in a single machine, it requires a 4 GHz CPU, 8 GB RAM (2 GB for the operating system and 6 GB (2 GB for each WSO2 product instance)) and 30 GB of free space.</li></ul>
</td>
</tr>
<tr>
<td>
<p>Virtual Machine (VM)</p> </td>
<td>
<ul>
<li>2 compute units minimum (each unit having 1.0-1.2 GHz Opteron/Xeon processor)</li>
<li>
  4 GB RAM</li>
  <li>
10 GB free disk space</li>
<li>One CPU unit for the operating system and one for JVM.</li>
</ul>
<p>
Three WSO2 product instances running would require VM of 4 compute units, 8 GB RAM, and 30 GB free space.
</p>
<p>~ 512 MB heap size. This is generally sufficient to process typical SOAP messages but the requirements vary with larger message sizes and  the number of messages processed concurrently.</p>
</td>
</tr>
<tr>
<td><p>EC2</p> </td>
<td>

-   1 c5.large instance to run one WSO2 product instance.

Three WSO2 product instances can be run in 1 EC2 Extra-Large instance. Based on the I/O performance of the c5.large instance, it is recommended to run multiple instances in a larger instance (c5.xlarge).
</td></tr>
</table>
</html>

## Environment compatibility

<html> 
<table>
<tr>
<td>
<p>Operating systems\
Databases</p>
</td>
<td>
<ul><li>If you are using the product installer to install the product, by default, WSO2 API-M is installed with <b>OpenJDK</b>, which allows you to run the product as soon as it is installed.

<div class="admonition note">
<p class="admonition-title">Note</p>
<p>
To use a different JDK,  point the <b>JAVA_HOME</b> environment variable to the new JDK. Make sure your JDK version is <a href="{{base_path}}/install-and-setup/setup/reference/product-compatibility/#tested-operating-systems-and-jdks">compatible with the WSO2 product</a>.</p>
</div> 
     
</li>
<li>
<p>If you are using the product's binary distribution to install the product (instead of the product installer), install JDK. Make sure your JDK version is <a href="{{base_path}}/install-and-setup/setup/reference/product-compatibility/#tested-operating-systems-and-jdks">compatible with the WSO2 product</a>.</p>
</li>
<li><p>All WSO2 Carbon-based products are generally compatible with most common DBMSs. The embedded H2 database is suitable for development, testing, and some production environments. For most enterprise production environments. However, WSO2 recommends that you use an industry-standard RDBMS such as Oracle, PostgreSQL, MySQL, MS SQL, etc. For more information, see <a href="{{base_path}}/install-and-setup/setup/setting-up-databases/overview/">Working with Databases</a>. Additionally, WSO2 does not recommend the H2 database as a user store.</p>
</li>
<li><p>
It is <b>not recommended to use Apache DS</b> in a production environment due to scalability issues. Instead, use an LDAP like OpenLDAP for user management.</p></li>
<li><p>On a production deployment, it is recommended that WSO2 products are installed on the latest releases of RedHat Enterprise Linux or Ubuntu Server LTS.</p></li>
<li>
<p>For environments that WSO2 products are tested with, see 
<a href="{{base_path}}/install-and-setup/setup/reference/product-compatibility/#tested-wso2-products">Compatibility of WSO2 Products</a>.</p></li>
<li><p>
If you have difficulty in setting up any WSO2 product in a specific platform or database, please <a href="http://wso2.com/support/">contact us</a>.</p>
</li>
</ul>
</td></tr></table></html>

## Database storage requirements

<html>
<table>
<tr>
<th rowspan="2"><strong>DB Type</strong></th>
<th colspan="2"><strong>Minimum storage required for databases</strong></th>
</tr>
<tr>
<th><strong>AM Database</strong></th>
<th><strong>Shared Database</strong></th>
</tr>
<tr>
<td><strong>MySQL</strong></td>
<td>1 GB</td>
<td>1 GB</td>
</tr>
<tr>
<td><strong>Oracle</strong></td>
<td>1 GB</td>
<td>1 GB</td>
</tr>
<tr>
<td><strong>MSSQL</strong></td>
<td>1 GB</td>
<td>1 GB</td>
</tr>
<tr>
<td><strong>Oracle RAC</strong></td>
<td>1 GB</td>
<td>1 GB</td>
</tr>
<tr>
<td><strong>PostgreSQL</strong></td>
<td>1 GB</td>
<td>1 GB</td>
</tr>
<tr>
<td><strong>IBM DB2</strong></td>
<td>1 GB</td>
<td>1 GB</td>
</tr>
<tr>
<td><strong>MariaDB</strong></td>
<td>1 GB</td>
<td>1 GB</td>
</tr>
</table>
</html>

## Required applications

The following applications are required for running WSO2 API Manager and its samples.

<html>
<table>
<tr>
<th> <b> Application </b> </th>
<th> <b>Purpose</b> </th>
<th> <b>Version</b> </th>
<th> <b>Download Links</b> </th>
</tr>
<tr>
<td>
<p><b>Apache Ant</b></p>
</td>
<td>
<ul>
<li>
    <p>  To compile and run the product samples in <code>
        &lt;API-M_HOME&gt;/samples</code>.</p>
</li>
</ul>
</td>
<td>
<p>
1.7.0 or later
</p>
</td>
<td>
<p>
 <a href="http://ant.apache.org/">Apache Ant</a> </td>
 </p>
</tr>
<tr>
<td>
<p><b>Web Browser</b></p>
</td><td>
<ul><li>  To access the <a href="{{base_path}}/install-and-setup/install/running-the-product/">Management Console</a>. The Web browser must be JavaScript enabled to take full advantage of the Management console.
</li></ul>
<div class="admonition note">
     <p class="admonition-title">Note</p>
     <p>
     On Windows Server 2003, you must not go below the medium security level in Internet Explorer 6.x.</p>
     </div> 
 </td>
 <td>
 </td>
 <td>
 </td>
 </tr>
 </table>
 </html>
