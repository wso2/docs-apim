# Installation Prerequisites

WSO2 API Manager contains multiple runtimes. Before installing the runtimes, be sure that the appropriate prerequisites are fulfilled.

## Environment compatibility

Listed below are the OS and database requirements.

<html> 
<table>
<tr>
<td>
<p>Operating systems\
Databases</p>
</td>
<td>
<ul>
<li>
<p>Install a JDK version that is <a href="{{base_path}}/install-and-setup/setup/reference/product-compatibility/#tested-operating-systems-and-jdks">compatible with this product version</a>.</p>
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
If you have difficulty in setting up any WSO2 product in a specific platform or database, please <a href="https://wso2.com/subscription/">contact us</a>.</p>
</li>
</ul>
</td></tr></table></html>

## System requirements

Check the following system requirements for the API-M and Micro Integrator runtimes.

<table>
<tr> 
<th><b>Type</b></th>
<th> <b>Requirement</th>
</tr>
  <tr>
    <td>
      <b>Docker</b>
    </td>
    <td>
      <ul>
        <li>
          <code>~512</code> MB heap size for one Micro Integrator instance. This is generally sufficient for processing typical SOAP messages. However, the requirements vary with larger message sizes and the number of messages processed concurrently.
        </li>
        <li>
          1 GB memory for a Docker container.
        </li>
        <li>
          Minimum 0.5 core per Micro Integrator Docker instance.
        </li>
      </ul>
    </td>
  </tr>
  <tr>
    <td>
      <b>Virtual Machine (VM)/Physical</b>
    </td>
    <td>
      <ul>
        <li>
          Minimum 0.5 core (1.0-1.2 GHz Opteron/Xeon processor).
        </li>
        <li>
          1 GB RAM for JVM.
        </li>
        <li>
          <code>~512</code> MB heap size. This is generally sufficient for processing typical SOAP messages. However, the requirements vary with larger message sizes and the number of messages processed concurrently.
        </li>
      </ul>
    </td>
  </tr>
</table>
