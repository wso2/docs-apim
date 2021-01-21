# Exposing a Carbon Datasource as a Data Service

A Carbon datasource is an RDBMS or a custom datasource created using the
Micro Integrator. You can simply use
that as the datasource for a data service. A Carbon datasource is
persistent, and can be used whenever required.

## Synapse configurations

Given below is the data service configuration you need to build. See the instructions on how to [build and run](#build-and-run) this example.

-	**Carbon** datasource

	```xml
	<datasource>
	    <name>rdbms_datasource_mysql</name>
	    <description>MySQL Connection</description>
	    <jndiConfig useDataSourceFactory="false">
	        <name>MysqlConJNDI1</name>
	    </jndiConfig>
	    <definition type="RDBMS">
	        <configuration>
	            <driverClassName>com.mysql.jdbc.Driver</driverClassName>
	            <url>jdbc:mysql://localhost:3306/Employees</url>
	            <username>username</username>
	            <password>password</password>
	        </configuration>
	    </definition>
	</datasource>
	```

-	**Data service**

	```xml
	<data name="RDBMSDataService_3" transports="http https local">
	   <config enableOData="false" id="Datasource">
	      <property name="carbon_datasource_name">rdbms_datasource_mysql</property>
	   </config>
	   <query id="GetEmployeeDetails" useConfig="Datasource">
	      <sql>select EmployeeNumber, FirstName, LastName, Email, Salary from Employees where EmployeeNumber=:EmployeeNumber</sql>
	      <result element="Entries" rowName="Entry">
	         <element column="EmployeeNumber" name="EmployeeNumber" xsdType="string"/>
	         <element column="FirstName" name="FirstName" xsdType="string"/>
	         <element column="LastName" name="LastName" xsdType="string"/>
	         <element column="Email" name="Email" xsdType="string"/>
	         <element column="Salary" name="Salary" xsdType="string"/>
	      </result>
	      <param name="EmployeeNumber" sqlType="STRING"/>
	   </query>
	   <operation name="GetEmployeeOp">
	      <call-query href="GetEmployeeDetails">
	         <with-param name="EmployeeNumber" query-param="EmployeeNumber"/>
	      </call-query>
	   </operation>
	   <resource method="GET" path="Employee/{EmployeeNumber}">
	      <call-query href="GetEmployeeDetails">
	         <with-param name="EmployeeNumber" query-param="EmployeeNumber"/>
	      </call-query>
	   </resource>
	</data>
	```

## Build and run

Create the artifacts:

1. [Set up WSO2 Integration Studio]({{base_path}}/integrate/develop/installing-wso2-integration-studio).
2.  Download the JDBC driver for MySQL from [here](http://dev.mysql.com/downloads/connector/j/) and copy it to the `MI_TOOLING_HOME/Contents/Eclipse/runtime/microesb/lib/` (for MacOS) or 
`MI_TOOLING_HOME/runtime/microesb/lib/` (for Windows) directory. 

    !!! Note
        If the driver class does not exist in the relevant folders when you create the datasource, you will get an exception such as `Cannot load JDBC driver class com.mysql.jdbc.Driver`.
        
3. [Create a Datasource project]({{base_path}}/integrate/develop/create-datasources) and then [create a datasource]({{base_path}}/integrate/develop/creating-artifacts/data-services/creating-datasources).
4. [Create a Data Service project]({{base_path}}/integrate/develop/create-data-services-configs) and then [create the data service]({{base_path}}/integrate/develop/creating-artifacts/data-services/creating-data-services) with the configurations given above.
5. [Deploy the artifacts]({{base_path}}/integrate/develop/deploy-artifacts) in your Micro Integrator. 

The service can be invoked in REST-style via curl (
[http://curl.haxx.se](http://curl.haxx.se/) ). Shown below is the curl
command to invoke the GET resource:

```bash
curl -X GET http://localhost:8290/services/RDBMSDataService_3.HTTPEndpoint/Employee/3
```

This generates a response as follows.

```bash
<Entries xmlns="http://ws.wso2.org/dataservice"><Entry><EmployeeNumber>3</EmployeeNumber><FirstName>Will</FirstName><LastName>Smith</LastName><Email>will@google.com</Email><Salary>15500.0</Salary></Entry><Entry><EmployeeNumber>3</EmployeeNumber><FirstName>Will</FirstName><LastName>Smith</LastName><Email>will@google.com</Email><Salary>15500.0</Salary></Entry><Entry><EmployeeNumber>3</EmployeeNumber><FirstName>Will</FirstName><LastName>Smith</LastName><Email>will@google.com</Email><Salary>15500.0</Salary></Entry></Entries>
```
