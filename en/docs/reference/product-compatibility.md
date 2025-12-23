# Product Compatibility

Given below are the compatibility details of the WSO2 API Manager (WSO2 API-M) 4.6.0 runtimes.

!!! Note
    Even though the tested operating systems are listed in compatibility sections for each product, ideally WSO2 products relies on the tested versions of the JDK.

## API-M runtime compatibility

Given below is the tested compatibility of the API-M runtime of WSO2 API Manager 4.6.0.

#### Tested Operating Systems

As WSO2 API Manager is a Java application, you can generally run it on most operating systems. Listed below are the operating systems that have been tested with the API-M 4.6.0 runtime.

|**Operating System**|**Versions**  |
|--------------------|--------------|
|Windows             | 2021         |
|Ubuntu              | 22.04 |
|Rocky Linux              | 9.3    |

#### Tested JDKs

The **WSO2 API-M** runtime has been tested with the following JDKs:

|**JDKS**            |**Versions**|
|--------------------|-----------|
|Temurin OpenJDK     | 11, 17, 21    |

#### Tested DBMSs

The **WSO2 API-M** runtime is tested with the following databases:

|**DBMS**     | **Versions**            |
|--------------|-------------------------|
|MySQL         | 5.7, 8, 8.4                  |
|Oracle        | 19c, 23c |
|Microsoft SQL Server| 2019, 2022        |
|PostgreSQL            | 16.2, 17       |

!!! warning
    When creating the database related to apim_db with MySQL 8.0, add **character set latin1** to avoid the MySQL Linux ERROR 1071 (42000).
    ```sh
    CREATE DATABASE <APIM_DATABASE_NAME> character set latin1;
    ```

#### WSO2 Product Compatibility Matrix

The following is a list of other WSO2 products and components that have been tested with WSO2 API Manager 4.6.0.

{!includes/compatibility-matrix.md!}

#### Compatible WSO2 Identity Servers (as Key Manager)

!!! Note 
    From API Manager 3.2.0 onwards, WSO2 Identity Server is not packaged as a Key Manager. A remote WSO2 Identity Server instance should be used as the Key Manager.

<table>
<thead>
<tr class="header" >
<th>WSO2 API-M</th>
<th>WSO2 IS-KM</th>
</tr>
</thead>
<tbody>
<tr class="even">
<td>API-M 4.6.0 GA</td>
<td>
GA or update for:
<ul>
<li>WSO2 IS-6.0.0/WSO2 IS-6.1.0</li>
<li>WSO2 IS-7.0.0 (Tenancy is not compatible)</li>
</ul>
</td>
</tr>
<tr class="even">
<td>API-M-4.6.0 update</td>
<td>GA or update for:
<ul>
<li>WSO2 IS-6.0.0/WSO2 IS-6.1.0</li>
<li>WSO2 IS-7.0.0 (tenancy is not compatible)</li>
<div class="admonition note">
      <p class="admonition-title">Note</p>
      <p>Role based authorization for WSO2 IS 7.x is supported from WSO2 IS 7.0.0.65 onwards</p>
</div>
</ul>
</tr>
</tbody>
</table>
