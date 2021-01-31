# Filtering Responses by User Role

When you work with data services, you can control access to sensitive
data for specific user roles. This facility is called **Role-based
content filtering**. It filters data where specific data sections are
only accessible to a given type of users.

## Define user role-based result filtering

Follow the steps below to filter a data service according to a specific user role.

1. [Secure the dataservice]({{base_path}}/integrate/develop/creating-artifacts/data-services/securing-data-services) using `UsernameToken` for user authentication.
2. Add `requiredRoles` attribute to the output mapping with the comma separated list of user roles.
    ```xml
    <query id="getEmployeesQuery" useConfig="datasource">
      <sql>select EmployeeNumber,FirstName,Email from Employees</sql>
      <result element="Elements" rowName="Element">
         <element column="EmployeeNumber" name="EmployeeNumber" requiredRoles="admin, role1" xsdType="string"/>
         <element column="FirstName" name="FirstName"/>
         <element column="Email" name="Email" requiredRoles="admin"/>
      </result>
    </query>
    ``` 

## Extend role-based filtering via a custom authorization provider

In the Micro Integrator, you can filter content to specific user roles by taking roles from
the [user store](../../../setup/user_stores/setting_up_a_userstore) connected to the server. However, this extension provides
the flexibility for you to develop data services by plugging in a
mechanism to provide those role details from any preferred external
source (e.g., third party identity provider, JWT token etc.). Hence, in
data integration scenarios where data needs to be filtered based on the
user who requests those data, follow the steps given below to plug in a custom
authorization provider.

1.  Create a Java project and create a Java class (e.g.
    `           SampleAuthProvider          ` ), which extends the
    `           org.wso2.micro.integrator.dataservices.core.auth.AuthorizationProvider          `
    interface and add the below methods.

    <table>
      <tr>
        <th>
          Parameter
        </th>
        <th>
          Description
        </th>
      </tr>
      <tr>
        <td>
          <code>String getUsername(MessageContext msgContext) </code>
        </td>
        <td>
          This should return the user name from the message context, which contains all the HTTP request details. 
        </td>
      </tr>
      <tr>
        <td>
          <code>String[] getUserRoles(MessageContext msgContext)</code>
        </td>
        <td>
          This should return the roles of the user returned from the <code>getUsername</code> method. This can be extracted from a JWT, a third party Identity provider etc.
        </td>
      </tr>
      <tr>
        <td>
          <code>void init(Map<String, String> authorizationProps)</code>
        </td>
        <td>
          This initializes the auth provider. For example, if you are using a third-party identity provider to retrieve roles, you can pass the required parameters (such as endpoint URLs and tokens) to the provider through this method and do the required initializations within this method.
        </td>
      </tr>
    </table>

    **SampleAuthProvider Class**

    ```java
    public class SampleAuthProvider implements AuthorizationProvider {
        public String[] getUserRoles(MessageContext messageContext) throws DataServiceFault {
            String[] roles = {"user", "manager"};
            return roles;
        }    

        public String[] getAllRoles() throws DataServiceFault {
            String[] roles = {"admin", "client", "user", "manager"};
            return roles;
        }

        public String getUsername(MessageContext messageContext) throws DataServiceFault {
            return "saman";
        }

        public void init(Map<String, String> map) throws DataServiceFault {

        }
    }
    ```

2.  Build the project and place the JAR file in the
    `           <MI_HOME>/lib/          ` directory.

3.  Create the data service.

    !!! Tip
        When creating the data service;

        -   Use the **Authorization Provider
            Class** that you created above.     
        -   When adding the output mapping, select the user roles out of the
            ones you defined when creating the Java class.   

When you invoke the data service you created, you will view a response
as shown in the example below.

!!! Info
    Since the sample Java class above returns hard-coded `         “{“user”, “manager”}”        ` roles, the response below returns only the rows those roles can view.
    ```xml
    <Persons xmlns="https://localhost:9443/carbon/ds/addQuery.jsp?queryId=query1">
       <Person>
          <PersonID>4</PersonID>
          <FirstName>john</FirstName>
          <Address>12, seren street, TN</Address>
       </Person>
       <Person>
          <PersonID>1</PersonID>
          <FirstName>Tom</FirstName>
          <Address>34, baker str, London</Address>
       </Person>
       <Person>
          <PersonID>2</PersonID>
          <FirstName>Jack</FirstName>
          <Address>324, Vale str, PN</Address>
       </Person>
       <Person>
          <PersonID>3</PersonID>
          <FirstName>Allan</FirstName>
          <Address>23, St str, NW</Address>
       </Person>
    </Persons>
    ```

You can extend this functionality to extract the required roles from the JWT
tokens or invoke third-party identity providers to fetch roles for role-based filtering in data services.
