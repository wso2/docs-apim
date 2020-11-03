# Installation Prerequisites

Prior to installing WSO2 Micro Integrator, make sure that the appropriate prerequisites are fulfilled.

## System requirements

<table>
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

## Environment compatibility

- The Micro Integrator is installed with **OpenJDK** by default, which allows you to run the product as soon as it is installed.
- To use a different JDK, point the `JAVA_HOME` environment variable to the new JDK. Make sure your JDK version is compatible with the WSO2 product.
- It is not recommended to use Apache DS in a production environment due to scalability issues. Instead, use an LDAP like OpenLDAP as your user store. 
- If you have difficulty in setting up the Micro Integrator in a specific platform or database, [contact us](https://wso2.com/contact/).

## Tested Environments

<table>
    <tr>
        <th>JDK</th>
        <th>Operating Systems</th>
        <th>RDBMS</th>
    </tr>
    <tr>
        <td>
            <ul>
                <li>
                OpenJDK 8
                </li>
                <li>
                OpenJDK 11
                </li>
                <li>
                CorrettoJDK 8
                </li>
                <li>
                AdoptOpenJDK 8
                </li>
                <li>
                AdoptOpenJDK 11
                </li>
                <li>
                Oracle JDK 8
                </li>
            </ul>
        </td>
        <td>
            <ul>
                <li>
         Ubuntu 18.04
                </li>
                <li>
         SUSE Linux 12
                </li>
                <li>
         Windows 2019
                </li>
                <li>
         MacOS 10.15
                </li>
                <li>
         CentOS 7.5
                </li>
                <li>
         RHEL-7.4
                </li>
            </ul>
        </td>
        <td>
            <ul>
                <li>
           Microsoft SQL Server 2017
                </li>
                <li>
           MySql 8.0
                </li>
                <li>
           MariaDB 10.5
                </li>
                <li>
           PostgreSQL 12.2
                </li>
                <li>
           DB2 11.5
                </li>
                <li>
           Oracle 19c
                </li>
                <li>
           Oracle 12c
                </li>
            </ul>
        </td>
    </tr>
</table>
