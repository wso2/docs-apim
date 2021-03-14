# Sample Queries

Listed below are some complex <b>query</b> definitions that you may require when defining an RDBMS data service.

!!! Info
    For detailed instructions on defining a data service using WSO2 Integration Studio, see [Creating a Data Service]({{base_path}}/integrate/develop/creating-artifacts/data-services/creating-data-services).

## Calling a MySQL function

Assume you have the following MySQL function, which takes a string parameter and returns the same as output. 

!!! Note
    You need to create a database before executing the query.

```bash
create function myFunction(p_inparam varchar(20))
  returns varchar(20)
  begin
     declare output_text varchar(20);
     set output_text = p_inparam;
     return output_text;
  end
```

To call this function from the data service, create an RDBMS datasource (for your data service) that connects to the MySQL database, and then define a query with the following SQL statement:

```sql
select myFunction('WSAS') as ABC
```

<img src="{{base_path}}/assets/img/integrate/data-services/mysql-function-query-sql.png" width="700" alt="sql query of mysql function">

The complete data service configuration (.dbs file) will be as follows:

```xml
<data name="sqlfunctionService">
   <config id="mynew">
      <property name="driverClassName">com.mysql.jdbc.Driver</property>
      <property name="url">jdbc:mysql://localhost:3306/sample</property>
      <property name="username">root</property>
      <property name="password">root</property>
   </config>
   <query id="NewfunctionQuery" useConfig="mynew">
      <sql>select myFunction('WSAS') as ABC</sql>
      <result element="wsas" rowName="wsas">
         <element column="output_text" name="n_param" xsdType="string"/>
      </result>
      <param name="imparam" sqlType="STRING"/>
   </query>
   <operation name="functionop">
      <call-query href="NewfunctionQuery">
         <with-param name="imparam" query-param="imparam"/>
      </call-query>
   </operation>
</data>
```

## Calling an Oracle function

Assume you have the following Oracle stored function, which returns the total number of entries in a table:

```bash
CREATE OR REPLACE FUNCTION myfunction(ename IN VARCHAR, eid IN NUMBER) RETURN INTEGER
AS myCount INTEGER;
BEGIN
    INSERT INTO TEAMS values(eid, ename);
    SELECT COUNT(*) into myCount from TEAMS;
    RETURN myCount;
END;
/
```

Create a table before executing the query as follows:

```bash
CREATE TABLE TEAMS(id INTEGER, team VARCHAR(30));
```

To call this function from the data service, create an RDBMS datasource (for your data service) that connects to the Oracle database, and define a query as given below.

-  SQL statement:

      ```sql
      {call ?:=myfunction(?,?)}
      ```

      <img src="{{base_path}}/assets/img/integrate/data-services/oracle-function-query-sql.png" width="500" alt="sql query of oracle function">

-  Create three <b>Input</b> mappings as follows:

      ```xml
      <param name="totalTeams" sqlType="INTEGER" type="OUT" ordinal="1" />
      <param name="ename" sqlType="STRING" ordinal="2" />
      <param name="eid" sqlType="INTEGER" ordinal="3" />
      ```

      <img src="{{base_path}}/assets/img/integrate/data-services/oracle-function-input-mapping.png" width="500" alt="oracle function input parameters">

      The first input parameter carries the return value of the function. The other two are inputs to the function. Note that you must define an Input parameter with <b>OUT</b> type to get the result of the function (i.e., the first parameter in the query above).

-  Create an <b>Output</b> mapping:

      ```xml
      <result element="TotalTeams" rowName="">
         <element name="totalTeams" column="totalTeams" xsdType="xs:integer" />
      </result>
      ```

      <img src="{{base_path}}/assets/img/integrate/data-services/oracle-function-output-mapping.png" width="500" alt="oracle function output parameter">

      This output parameter gets the value as a result set from the data service.

For example, see the following data service configuration:

```xml
<data name="testOracleFunction">
   <config id="or">
      <property name="org.wso2.ws.dataservice.driver">oracle.jdbc.driver.OracleDriver</property>
      <property name="org.wso2.ws.dataservice.protocol">jdbc:oracle:thin:user/pwd@localhost:1521/XE</property>
      <property name="org.wso2.ws.dataservice.user">user</property>
      <property name="org.wso2.ws.dataservice.password">pwd</property>
   </config>
   <query id="q1" useConfig="or">
      <sql>{call ?:=myfunction(?,?)}</sql>
      <result element="TotalTeams" rowName="">
         <element name="totalTeams" column="totalTeams" xsdType="xs:integer" />
      </result>
      <param name="totalTeams" sqlType="INTEGER" type="OUT" ordinal="1" />
      <param name="ename" sqlType="STRING" ordinal="2" />
      <param name="eid" sqlType="INTEGER" ordinal="3" />
   </query>
   <operation name="op1">
      <call-query href="q1">
         <with-param name="ename" query-param="ename" />
         <with-param name="eid" query-param="eid" />
      </call-query>
   </operation>
</data>
```

## Defining a dynamic SQL query

Dynamic SQL queries allow you to change SQL queries (e.g., defining additional conditions in the SQL) in the runtime without changing the data service configuration. For this to work, you must specify the required SQL query statements (e.g., with WHERE clause) using the `QUERY_STRING` data type. These statements will be directed to the final SQL query during runtime.  

!!! Warning
	 Dynamic queries can lead to SQL injection attacks. Therefore, we recommend that the clients validate the values set using the `QUERY_STRING` data type during runtime.

The `QUERY_STRING` data type is available as an SQL type when creating Input mappings for queries:

<img src="{{base_path}}/assets/img/integrate/data-services/input-query-string.png" width="500" alt="add query string to input">

You can add the SQL query using the mapping name:

<img src="{{base_path}}/assets/img/integrate/data-services/dynamic-query.png" width="500" alt="dynamic query for data service">

For example, see the following data service configuration:

```xml
<data name="DynamicQuerySample" serviceNamespace="http://ws.wso2.org/dataservice/samples/rdbms_sample">
   <config id="default">
      <property name="driverClassName">org.h2.Driver</property>
      <property name="url">jdbc:h2:file:./samples/database/DATA_SERV_SAMP</property>
      <property name="username">wso2ds</property>
      <property name="password">wso2ds</property>
      <property name="minIdle">1</property>
      <property name="maxActive">10</property>
      <property name="autoCommit">false</property>
   </config>
   <query id="employeesSQL" useConfig="default">
      <sql>select * from Employees :filterQuery</sql>
      <result element="employees" rowName="employee">
         <element column="lastName" name="last-name" xsdType="string"/>
         <element column="firstName" name="first-name" xsdType="string"/>
         <element column="email" name="email" xsdType="string"/>
         <element column="salary" name="salary" xsdType="double"/>
      </result>
      <param name="filterQuery" sqlType="QUERY_STRING"/>
   </query>
   <query id="customerInCountrySQL" useConfig="default">
      <sql>select * from Customers where country = :country :filter</sql>
      <result element="customer-addresses" rowName="customer-address">
         <element column="customerNumber" name="customer-number" xsdType="integer"/>
         <element column="contactLastName" name="contact-last-name" xsdType="string"/>
         <element column="contactFirstName" name="contact-first-name" xsdType="string"/>
         <element column="addressLine1" name="address-line1" xsdType="string"/>
         <element column="addressLine2" name="address-line2" xsdType="string"/>
         <element column="city" name="city" xsdType="string"/>
         <element column="state" name="state" xsdType="string"/>
         <element column="postalCode" name="postal-code" xsdType="string"/>
         <element column="country" name="country" xsdType="string"/>
      </result>
      <param name="country" sqlType="STRING"/>
      <param name="filter" sqlType="QUERY_STRING"/>
   </query>
   <query id="insertUpdateQuery" useConfig="default">
      <sql>:query</sql>
      <param name="query" sqlType="QUERY_STRING"/>
   </query>
   <operation name="getEmployees">
      <call-query href="employeesSQL">
         <with-param name="filterQuery" query-param="filterQuery"/>
      </call-query>
   </operation>
   <operation name="getCustomersInCountry">
      <call-query href="customerInCountrySQL">
         <with-param name="country" query-param="country"/>
         <with-param name="filter" query-param="filter"/>
      </call-query>
   </operation>
   <operation name="insertUpdateOp">
      <call-query href="insertUpdateQuery">
         <with-param name="query" query-param="query"/>
      </call-query>
   </operation>
</data>
```