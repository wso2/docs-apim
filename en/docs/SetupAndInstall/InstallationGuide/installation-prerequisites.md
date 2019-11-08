# Installation Prerequisites

Prior to installing WSO2 API Manager, make sure that the appropriate prerequisites are available. Verify that the computer has the supported operating system and development platforms before starting the installation.

### System requirements

<html>
<table>
<tr>
<td>
Physical </td>
<td>
<ul><li>   3 GHz Dual-core Xeon/Opteron (or latest)</li>
<li>4 GB RAM (2 GB for JVM and 2 GB for the operating system)</li>
<li>10 GB free disk space</li>
<li>  ~ Recommended minimum - 2 Cores. For high concurrencies and better performances - 4 Cores.

Disk space is based on the expected storage requirements that are calculated by considering the file uploads and the backup policies. For example, if three WSO2 product instances are running in a single machine, it requires a 4 GHz CPU, 8 GB RAM (2 GB for the operating system and 6 GB (2 GB for each WSO2 product instance)) and 30 GB of free space.
</td>
</tr>
<tr>
<td>
Virtual Machine (VM) </td>
<td>
<ul>
<li>  2 compute units minimum (each unit having 1.0-1.2 GHz Opteron/Xeon processor)</li>
<li>
  4 GB RAM</li>
  <li>
10 GB free disk space</li>
<li>One CPU unit for the operating system and one for JVM.</li>
</ul>
<p>
Three WSO2 product instances running would require VM of 4 compute units, 8 GB RAM, and 30 GB free space.
</p>
<p>~ 512 MB heap size. This is generally sufficient to process typical SOAP messages but the requirements vary with larger message sizes and  the number of messages processed concurrently.</p>
</td>
</tr>
<tr>
<td>EC2 </td>
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
Operating systems\
Databases
</td>
<td>

<ul><li>  If you are using the product installer to install the product, by default, WSO2 API-M is installed with <b>OpenJDK</b>, which allows you to run the product as soon as it is installed.

     
     <div class="admonition note">
     <p class="admonition-title">Note</p>
     <p>
     To use a different JDK,  point the <b>JAVA_HOME</b> environment variable to the new JDK. Make sure your JDK version is <a href="https://docs.wso2.com/display/compatibility/Tested+Operating+Systems+and+JDKs">compatible with the WSO2 product</a>.</p>
     </div> 
     

    
</li>
<li>
<p>If you are using the product's binary distribution to install the product (instead of the product installer), install JDK. Make sure your JDK version is  <a href="https://docs.wso2.com/display/compatibility/Tested+Operating+Systems+and+JDKs">compatible with the WSO2 product</a>.</p>
</li>
<li><p>All WSO2 Carbon-based products are generally compatible with most common DBMSs. The embedded H2 database is suitable for development, testing, and some production environments. For most enterprise production environments, however, we recommend you use an industry-standard RDBMS such as Oracle, PostgreSQL, MySQL, MS SQL, etc. For more information, see <a href="../../../SetupAndInstall/SettingUpDatabases/overview/">Working with Databases</a>. Additionally, we do not recommend the H2 database as a user store.</p>
</li>
<li><p>
It is <b>not recommended to use Apache DS</b> in a production environment due to scalability issues. Instead, use an LDAP like OpenLDAP for user management.</p></li>
<li><p>On a production deployment, it is recommended that WSO2 products are installed on latest releases of RedHat Enterprise Linux or Ubuntu Server LTS.</p></li>
<li>
<p>For environments that WSO2 products are tested with, see 
<a href="https://docs.wso2.com/display/compatibility/Compatibility+of+WSO2+Products">Compatibility of WSO2 Products</a>.</p></li>
<li><p>
If you have difficulty in setting up any WSO2 product in a specific platform or database, please <a href="http://wso2.com/support/">contact us</a>.</p>
</li>
</ul>
</td></tr></table></html>

## Required applications

The following applications are required for running WSO2 API Manager and its samples.

<html>
<table>
<tr>
<th>Application
</th>

<th>Purpose
</th>
<th>Version
</th>
<th>Download Links
</th>

</tr>

<tr>
<td>
<b>Apache Ant</b>
</td>
<td>
<ul>
<li>
    <p>  To compile and run the product samples in <code>
    &lt;APIM_HOME&gt;/samples</code>.</p>
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
<b>Web Browser</b>
</td><td>
<ul><li>  To access the <a href="../../../SetupAndInstall/InstallationGuide/running-the-product/">Management Console</a>. The Web browser must be JavaScript enabled to take full advantage of the Management console.
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