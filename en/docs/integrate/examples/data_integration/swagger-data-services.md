# Using Swagger Documents of RESTful Data Services

When RESTful resources are added to the data service, the Micro Integrator generates a corresponding swagger 3.0 (OpenApi) definition automatically. You can access this Swagger document by suffixing the service URL with `?swagger.json` or `?swagger.yaml` as shown below.

-   JSON format

    ```bash
    http://localhost:8290/services/<data-service name>?swagger.json
    ```

-   YAML format

    ```bash
    http://localhost:8290/services/<data-service name>?swagger.yaml
    ```

This example demonstrates how a custom Swagger definition is published for a RESTful data service. 
    
## Synapse configuration

Following is a sample data service configuration with a custom Swagger definition. See the instructions on how to [build and run](#build-and-run) this example.

!!! Note
    The custom Swagger file (JSON file) is saved to the Micro Integrator's registry. The `publishSwagger` element in the data service configuration specifies the registry path. In this example, we are storing the Swagger definition in the <b>governance</b> registry as shown below.

```xml
<data enableBatchRequests="true" name="RDBMSDataService" serviceGroup="" serviceNamespace="">
    <description/>
    <query id="GetEmployeeDetails" useConfig="Datasource">
        <sql>select EmployeeNumber, FirstName, LastName, Email, Salary from Employees where EmployeeNumber=:EmployeeNumber</sql>
        <param name="EmployeeNumber" paramType="SCALAR" sqlType="STRING"/>
        <result element="Employees" rowName="Employee">
            <element column="EmployeeNumber" name="EmployeeNumber" xsdType="xs:string"/>
            <element column="FirstName" name="FirstName" xsdType="xs:string"/>
            <element column="LastName" name="LastName" xsdType="xs:string"/>
            <element column="Email" name="Email" xsdType="xs:string"/>
            <element column="Salary" name="Salary" xsdType="xs:string"/>
        </result>
    </query>
    <config id="Datasource">
        <property name="org.wso2.ws.dataservice.user">root</property>
        <property name="org.wso2.ws.dataservice.password"/>
        <property name="org.wso2.ws.dataservice.protocol">jdbc:mysql://localhost:3306/Employees</property>
        <property name="org.wso2.ws.dataservice.driver">com.mysql.jdbc.Driver</property>
        <property name="org.wso2.ws.dataservice.minpoolsize"/>
        <property name="org.wso2.ws.dataservice.maxpoolsize"/>
        <property name="org.wso2.ws.dataservice.validation_query"/>
    </config>
    <query id="AddEmployeeDetails" useConfig="Datasource">
        <sql>insert into Employees (EmployeeNumber, FirstName, LastName, Email, Salary) values(:EmployeeNumber,:FirstName,:LastName,:Email,:Salary)</sql>
        <param name="EmployeeNumber" paramType="SCALAR" sqlType="STRING"/>
        <param name="FirstName" paramType="SCALAR" sqlType="STRING"/>
        <param name="LastName" paramType="SCALAR" sqlType="STRING"/>
        <param name="Email" paramType="SCALAR" sqlType="STRING"/>
        <param name="Salary" paramType="SCALAR" sqlType="STRING"/>
    </query>
    <query id="UpdateEmployeeDetails" useConfig="Datasource">
        <param name="EmployeeNumber" paramType="SCALAR" sqlType="STRING"/>
        <sql>update Employees set FirstName=:FirstName, LastName=:LastName, Email=:Email, Salary=:Salary where EmployeeNumber=:EmployeeNumber</sql>
        <param name="FirstName" paramType="SCALAR" sqlType="STRING"/>
        <param name="LastName" paramType="SCALAR" sqlType="STRING"/>
        <param name="Email" paramType="SCALAR" sqlType="STRING"/>
        <param name="Salary" paramType="SCALAR" sqlType="STRING"/>
    </query>
    <resource method="GET" path="Employee/{EmployeeNumber}">
        <call-query href="GetEmployeeDetails">
            <with-param name="EmployeeNumber" query-param="EmployeeNumber"/>
        </call-query>
    </resource>
    <resource method="POST" path="Employee">
        <call-query href="AddEmployeeDetails">
            <with-param name="EmployeeNumber" query-param="EmployeeNumber"/>
            <with-param name="FirstName" query-param="FirstName"/>
            <with-param name="LastName" query-param="LastName"/>
            <with-param name="Email" query-param="Email"/>
            <with-param name="Salary" query-param="Salary"/>
        </call-query>
    </resource>
    <resource method="PUT" path="Employee">
        <call-query href="UpdateEmployeeDetails">
            <with-param name="EmployeeNumber" query-param="EmployeeNumber"/>
            <with-param name="FirstName" query-param="FirstName"/>
            <with-param name="LastName" query-param="LastName"/>
            <with-param name="Email" query-param="Email"/>
            <with-param name="Salary" query-param="Salary"/>
        </call-query>
    </resource>
</data>
```

## Build and run

Create the artifacts:

1. [Set up WSO2 Integration Studio]({{base_path}}/integrate/develop/installing-wso2-integration-studio).
2. [Create an integration project]({{base_path}}/integrate/develop/create-integration-project) with a <b>Registry Resources</b> module and a <b>Composite Exporter</b>.
3. [Create a Data Service project]({{base_path}}/integrate/develop/create-data-services-configs) inside the integration project.
4. To create the data service with the above configurations:
    - Download the Swagger file: [custom_data_service_swagger.yaml](https://github.com/wso2-docs/WSO2_EI/blob/master/samples-rest-apis/simple_petstore.yaml).
    - Follow the instructions on [creating a data service]({{base_path}}/integrate/develop/creating-artifacts/data-services/creating-data-services).

5. [Deploy the artifacts]({{base_path}}/integrate/develop/deploy-artifacts) in your Micro Integrator.


Copy the following URLs to your browser to see the Swagger documents of your RESTful data service:

- `http://localhost:8290/services/<data-service name>?swagger.json`
- `http://localhost:8290/services/<data-service name>?swagger.yaml`
