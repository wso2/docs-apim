# Product Compatibility

Given below are the compatibility details of the WSO2 API Manager (WSO2 API-M) 4.0.0 runtimes.

## API-M runtime compatibility

Given below is the tested compatibility of the API-M runtime of WSO2 API Manager 4.0.0.

#### Tested Operating Systems

As WSO2 API Manager is a Java application, you can generally run it on most operating systems. Listed below are the operating systems that have been tested with the API-M 4.0.0 runtime.

|**Operating System**|**Versions**|
|--------------------|------------|
|Windows             | 2016       |
|Ubuntu              | 18.04, 20.04 |
|Red Hat Enterprise Linux   | 7.0  |
|CentOS              | 7.4, 7.5    |
|Red Hat Enterprise Linux   | 7.0  |

#### Tested JDKs

The **WSO2 API-M** runtime has been tested with the following JDKs:

|**JDKS**            |**Versions**|
|--------------------|-----------|
|CorrettoJDK         | 8, 11     |
|AdoptOpenJDK        | 8, 11     |
|OpenJDK             | 8, 11     |
|CentOS              | 7.4, 7.5  |
|Oracle JDK          | 8, 11     |
|Temurin OpenJDK | 8 and 11 |

#### Tested DBMSs

The **WSO2 API-M** runtime is tested with the following databases:

|**DBMS**     |**Versions**|
|--------------|-----------|
|MySQL         | 5.7, 8    |
|Oracle        | 12c, 19c  |
|Microsoft SQL Server| 2017|
|PostgreSQL            |10 |

#### Tested WSO2 Products

The following is a list of other WSO2 products that have been tested with WSO2 API Manager 4.0.0.

- [WSO2 Enterprise Integrator 6.6.0](https://wso2.com/enterprise-integrator/6.6.0#)
- [WSO2 Identity Server 5.11.0](https://wso2.com/identity-and-access-management/#)

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
<td>API-M 4.0.0 GA</td>
<td>GA or update for WSO2 IS-5.10.0</td>
</tr>
<tr class="even">
<td>API-M-4.0.0 update</td>
<td>GA or updated for WSO2 IS-5.10.0</td>
</tr>
</tbody>
</table>

## Micro Integrator runtime compatibility

Given below is the tested compatibility of the Micro Integrator of WSO2 API Manager 4.0.0.

#### Tested Operating Systems

The **Micro Integrator** runtime is tested with the following operating systems:

|**Operating System**|**Versions**|
|--------------------|------------|
|Windows             | 2019       |
|Ubuntu              |18.04       |
|Red Hat Enterprise Linux |7.4, 8.2  |
|CentOS              |      7.5   |
|MacOS               | 10.15      |
|SUSE Linux          | 12         |

#### Tested JDKs

The **Micro Integrator** runtime is tested with the following JDKs:

| **JDKS**            |**Versions**|
|---------------------|------------|
| CorrettoJDK         | 8, 11      |
| AdoptOpenJDK        | 8, 11      |
| OpenJDK             | 11         |
| Oracle JDK          | 8, 11      |

#### Tested DBMSs

The **Micro Integrator** runtime is tested with the following databases:

|**DBMS**     |**Versions**|
|--------------|-----------|
|MySQL         | 5.7, 8    |
|Oracle        | 12c, 19c  |
|Microsoft SQL Server| 2017|
|PostgreSQL            |10 |

## Streaming Integrator compatibility

Given below is the tested compatibility of the Streaming Integrator of WSO2 API Manager 4.0.0.

#### Tested Operating Systems

The **Streaming Integrator** runtime is tested with the following operating systems:

|**Operating System**|**Versions**|
|--------------------|-----------|
|Windows             | 7<br/>10  |
|Ubuntu              |16.04<br/>17.04<br/>18.04|
|MacOS High Sierra   | |

#### Tested JDKs

The **Streaming Integrator** runtime is tested with the following JDKS:

|**JDK**             |**Version**    |
|--------------------|---------------|
|Oracle JDK          | 8 , 11        |
|OpenJDK             | 8 , 11        |

#### Tested DBMSs

The **Streaming Integrator** runtime is tested with the following databases:

|**DBMS**            |**Version**|
|--------------------|-----------|
|H2                  |1.4.187    |
|MySQL               |5.7        |
|Microsoft SQL Server|2017       |
|Oracle              |11.2.0.2-x |
|PostgreSQL          |9.6        |

#### Known Incompatibilities

Given below are the OS and JDK incompatibilities that WSO2 has come across while testing the Streaming Integrator runtime.

|**Operating System**|**Operating System Version**|**JDK Version**|
|--------------------|----------------------------|---------------|
|macOS High Sierra   |10.13.1 (17B1003)           |JDK1.8.0_20<br/>JDK1.8.0_144<br/>JDK1.8.0_152<br/>JDK1.8.0_162|
|macOS High Sierra   |10.13.2                     |JDK1.8.0_144<br/>JDK1.8.0_152|
|Ubuntu              |14.04                       |JDK1.8.0_151<br/>JDK1.8.0_152<br/>JDK1.8.0_161|
|Ubuntu              |16.04                       |JDK1.8.0_151<br/>JDK1.8.0_152<br/>JDK1.8.0_161<br/>JDK1.8.0_162|
