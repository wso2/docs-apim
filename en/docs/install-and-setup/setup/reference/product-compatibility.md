# Product Compatibility

<div class="admonition note">
<p class="admonition-title">Note</p>
<p>The following compatibility details are with regard to the following products.
<ul>
<li><b>WSO2 API Manager (WSO2 API-M) 3.2.0</b></li>
<li><b>WSO2 API-M Analytics 3.2.0.</b></li>
</ul></p>
</div>

## Tested Operating Systems and JDKs

As WSO2 API Manager and WSO2 API-M Analytics is a Java application, you can generally run WSO2 API-M and WSO2 API-M Analytics on most operating systems. 

The following is the list of tested JDKs.

<table>
<tbody>
<tr>
<th>Supported JDK versions</th>
<td>
<ul>
<li>CorrettoJDK 8, 11</li>
<li>AdoptOpenJDK 8, 11</li>
<li>OpenJDK 8, 11</li>
<li>Oracle JDK 8, 11</li>
<li>Temurin OpenJDK 8 and 11</li>
</ul>
</td>
</tr>
<tr>
<th>Supported Operating Systems</th>
<td>
<ul>
<li>Ubuntu 18.04, 20.04</li>
<li>CentOS 7.4, 7.5</li>
<li>Red Hat Enterprise Linux 8.3</li>
<li>SUSE Linux 12</li>
<li>Windows Server 2016</li>
<li>Windows Server 2019</li>
</ul>
</td>
</tr>
</tbody>
</table>

## Tested DBMSs

WSO2 API Manager and WSO2 API-M Analytics support the following DBMSs.

<html>
<ul>
<li>MySQL 5.7, 8</li>
<li>Oracle 12c, 19c</li>
<li>Microsoft SQL Server 2017</li>
<li>PostgreSQL 10, 13.2</li>
</ul>
</html>

## Tested Web Browsers

-   Google Chrome 69
-   Firefox 62.0.2

## Tested WSO2 Products

- [WSO2 Enterprise Integrator 6.6.0](https://wso2.com/enterprise-integrator/6.6.0#)
- [WSO2 Identity Server 5.10.0](https://wso2.com/identity-and-access-management/previous-releases/)

## Compatible WSO2 Identity Server as the Key Managers

<table>
<thead>
<tr class="header" >
<th>WSO2 API-M</th>
<th>WSO2 IS-KM</th>
</tr>
</thead>
<tbody>
<tr class="even">
<td>API-M 3.2.0 GA</td>
<td>GA or WUM update for WSO2 IS-5.10.0</td>
</tr>
<tr class="even">
<td>API-M-3.2.0 WUM update</td>
<td>GA or WUM update for WSO2 IS-5.10.0</td>
</tr>
</tbody>
</table>

!!! note 
    From API Manager 3.2.0 onwards, the prepackaged WSO2 Identity Server as a Key Manager is removed and WSO2 Identity Server should be used as the key Manager.
