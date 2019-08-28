# admin\_Extending the Identity Anonymization Tool

!!! warning
THE CONTENT ON THIS PAGE IS STILL A WORK IN PROGRESS.


If you want to include additional relational databases and log files from which you want to remove references to deleted user identities, you can extend the Identity Anonymization tool to include required relational databases and log files. It is also possible to extend the tool to remove references to deleted user identities from additional modules other than relational databases or log files.

The following topics provide detailed instructions on how you can extend the tool depending on your requirement:

!!! tip
Before you begin,

-   Check out the source of the Identity Anonymization tool from [here](https://github.com/wso2/identity-anonymization-tool) , and build the tool. For detailed instructions on how to build the tool, see [Building the Identity Anonymization tool](https://docs.wso2.com/display/ADMIN44x/Removing+References+to+Deleted+User+Identities+in+WSO2+Products) .
    Once you build the source you can extract the `           identity-anonymization-tool-SNAPSHOT          ` directory. The path to this directory will be referred to as `           <TOOL_HOME>          ` throughout this section.


-   [Extending the tool to remove references from additional relational databases](#admin_ExtendingtheIdentityAnonymizationTool-Extendingthetooltoremovereferencesfromadditionalrelationaldatabases)
-   [Extending the tool to remove references from additional log files](#admin_ExtendingtheIdentityAnonymizationTool-Extendingthetooltoremovereferencesfromadditionallogfiles)
-   [Extending the tool to remove references from additional modules other than relational databases or log files](#admin_ExtendingtheIdentityAnonymizationTool-Extendingthetooltoremovereferencesfromadditionalmodulesotherthanrelationaldatabasesorlogfiles)

### Extending the tool to remove references from additional relational databases

Follow the steps below if you want to extend the Identity Anonymization tool to include an additional relational database from which you want to remove references to deleted user identities:

1.  Create a new directory in `           <TOOL_HOME>/conf/sql/          ` , with an appropriate name based on the relational database table from which you want to remove references.

        !!! tip
    If there is an existing directory that serves this purpose, you should use the existing directory instead of creating a new directory.


    For example, if you want to remove references to deleted user identities in a relational database where customer information is stored, yo can create a directory named customer.

2.  Create an SQL file that includes the required commands, and save the file with an appropriate name in the directory that you created in step 1.

        !!! tip
    Ensure that the file is saved with the `           .sql          ` extension.


    The SQL statements should either be UPDATE or DELETE statements. The following variables can be used to replace respective values at the time of execution.

    | Variable                                         | Value to replace                                                        |
    |--------------------------------------------------|-------------------------------------------------------------------------|
    | `               pseudonym              `         | The pseudonym that should be used to replace a deleted user's identity. |
    | `               username              `          | The user name that should be replaced with the pseudonym.               |
    | `               user_store_domain              ` | The user store domain.                                                  |
    | `               tenant_domain              `     | The tenant domain.                                                      |

    Following is a sample SQL statement that can be used:

    ``` sql
        UPDATE IDN_ASSOCIATED_ID
        SET USER_NAME = `pseudonym`
        WHERE USER_NAME = `username`
            AND DOMAIN_NAME = `user_store_domain`
            AND TENANT_ID = (SELECT UM_ID
                             FROM UM_TENANT
                             WHERE UM_DOMAIN_NAME = `tenant_domain`
                             ORDER BY UM_ID DESC LIMIT 1)
    ```

        !!! info
    Note

    When you run the Identity Anonymization tool to remove references to a deleted user’s identity from relational databases, there can be instances where a user name is stored in different forms in databases. For example, a user name can be stored as `           user1          ` or `           user1@wso2.com          ` or `           PRIMARY/user1          ` . To handle such scenarios, you need to assign a query type to each sql query used with the Identity Anonymization tool, create a `           sql.properties          ` file corresponding to the sql query, and then specify the query type in the properties file as follows:

        !!! tip
    For example, if the sql file is `           customer-access-token.sql          ` , then the corresponding properties file would be `           customer-access-token.sql.properties          ` .


    `           type=<Query-Type>          `

    For example, `           type=DOMAIN_APPENDED          `

    Following are the query types that you can use together with the description of each query type:

    <table>
    <thead>
    <tr class="header">
    <th>Query type</th>
    <th>Description</th>
    </tr>
    </thead>
    <tbody>
    <tr class="odd">
    <td><code>               DOMAIN_SEPARATED              </code></td>
    <td>You can use this query type when the query refers to a user name that is not appended with any domain name (i.e., when a user name is not appended with a user store domain name or tenant domain name such as <code>               user1              </code> ).<br />
    This is the default query type. Therefore, you do not need to define this query type in a properties file. All queries without a <code>               sql.properties              </code> file uses this query type by default.</td>
    </tr>
    <tr class="even">
    <td><code>               DOMAIN_APPENDED              </code></td>
    <td>You can use this query type when the query refers to a user name that is appended with a user store domain name as follows:<br />
    <code>               PRIMARY/user1              </code> .</td>
    </tr>
    <tr class="odd">
    <td><code>               TENANT_APPENDED              </code></td>
    <td>You can use this query type when the query refers to a user name that is appended either with a tenant domain such as <code>               user1@wso2.com              </code> , or with a super tenant domain (carbon.super) such as <code>               user2@carbon.super              </code> .</td>
    </tr>
    <tr class="even">
    <td><code>               TENANT_SPECIFIC_APPENDED              </code></td>
    <td>You can use this query type when the query refers to a user name that is appended with the tenant domain, but not in instances where the super tenant domain such as <code>               user1@wso2.com              </code> or <code>               user2              </code> is used.</td>
    </tr>
    </tbody>
    </table>


3.  Provide a datasource definition in the `           <TOOL_HOME>/conf/datasources          ` directory to map the directory that you created (i.e., `           <TOOL_HOME>/conf/sql/customer          ` ) in step 1.
    Following is a sample datasource definition:

    ``` java
        <datasources-configuration>
          <datasources>
              <datasource>
                  <name>customer</name>
                  <description>The datasource used for customer</description>
                  <definition type="RDBMS">
                      <configuration>
                          <url>jdbc:h2:file:WSO2CARBON_DB</url>
                          <url>jdbc:mysql://localhost:3306/userdb</url>
                          <username>root</username>
                          <password>root</password>
                          <driverClassName>com.mysql.jdbc.Driver</driverClassName>
                          <maxActive>50</maxActive>
                          <maxWait>60000</maxWait>
                          <testOnBorrow>true</testOnBorrow>
                          <validationQuery>SELECT 1</validationQuery>
                          <validationInterval>30000</validationInterval>
                          <defaultAutoCommit>false</defaultAutoCommit>
                      </configuration>
                  </definition>
              </datasource>
          </datasources>
        </datasources-configuration>
    ```

    Here, the datasource name `           <name>customer</name>          ` maps to the directory that you created in step 1. This datasource can be reused by any of the scripts provided within the `           <TOOL_HOME>/conf/sql/customer          ` directory .

        !!! note
    The Identity Anonymization tool does not support JNDI. Therefore, i f there are JNDI configuration sections, be sure to remove those.


4.  Add the corresponding JDBC driver into the `          <TOOL_HOME>/          lib         ` directory if it is not already added.

### Extending the tool to remove references from additional log files

Follow the steps below if you want to extend the Identity Anonymization tool to include an additional log file from which you want to remove references to deleted user identities:

1.  Open the `           <TOOL_HOME>/conf/config.json          ` file, go to the `           directories          ` section, and add a new directory entry. You need to specify the following details when adding a new directory entry:

    -   `            dir           ` : The directory where the regex replacement patterns are defined. The specified directory can have multiple RegEx pattern files.
    -   `            type           ` : &lt;deprecated&gt;
    -   `            processor           ` : The name of the processor.
    -   `            log-file-path           ` : The directory where the log files are located.
    -   `            log-file-name-regex           ` : The regular expression to filter log files. Specify this when there are rolling log files, where you have to define which files needs processing with the specified replacement logic.

2.  Open the `           <TOOL_HOME>/conf/patterns.xml          ` file, and define required patterns using regular expressions to find and replace references to a deleted user's identity. Following are the variable that you can use in a regular expression:

    | Variable           | Description                                                                       |
    |--------------------|-----------------------------------------------------------------------------------|
    | ${userstoreDomain} | Replaces the user store domain name of a deleted user with a specified pseudonym. |
    | ${username}        | Replaces the user name of a deleted user with a specified pseudonym.              |
    | ${tenantId}        | Replaces the tenant ID of a deleted user with a specified pseudonym .             |
    | ${tenantDomain}    | Replaces the tenant domain of a deleted user.                                     |

    Following is a sample pattern that you can define in the `           <TOOL_HOME>/conf/patterns.xml          ` file:

    ``` java
        <patterns xmlns="patterns.xsd" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                  xsi:schemaLocation="patterns.xsd">
          <pattern key="pattern4">
              <detectPattern> (.)*(Initiator : )(.)*${username}</detectPattern>
              <replacePattern>${username}</replacePattern>
          </pattern>
      ...

    </patterns>
    ```
    Here, the `           <detectPattern>          ` element contains the pattern to detect in log file entries. The `           <replacementPattern>          ` element contains the variable that should be replaced with the pseudonym.

### Extending the tool to remove references from additional modules other than relational databases or log files

Follow the steps below if you want to extend the tool to include additional modules other than relational databases or log files:

1.  Import the following maven dependency:

    ``` java
        <dependency>
        <groupId>org.wso2.carbon.privacy</groupId>
        <artifactId>org.wso2.carbon.privacy.forgetme.api</artifactId>
        </dependency>
    ```

2.  Implement the `          ForgetMeInstruction         ` interface and the `          InstructionReader         ` interface. Keep the following in mind when you implement the interfaces:
    -   The `            ForgetMeInstruction           ` interface that you implement should contain a single execution of a single artifact. For example, a single log file or a single datasource that can be processed with a single instruction.
    -   The `            InstructionReader           ` interface should generate a list of instructions related to a given artifact type in the `            config           ` directory. With regard to RDBMS, the `            InstructionReader           ` interface is responsible for treating a single sql file as a single instruction.

        -   Make sure you specify a distinctive name for the result of `               getType()              ` . This will be the name of the processor.

            ``` java
                        public String getType() {return MY_PROCESOR_NAME;}
            ```

                !!! tip
        An instruction is considered to be atomic. i.e., An instruction should either be completely processed or should not be processed at all.


3.  Foolow the steps below to register the `          InstructionReader         ` interface with the Java 8 SPI (Service Provider Interface).
    1.  Create the `            META-INF/services/org.wso2.carbon.privacy.forgetme.api.runtime.InstructionReader           ` in the resource directory, which will be packed inside the JAR.
    2.  Add the fully qualified class name of the implementation of `             InstructionReader            ` inside the SPI file.

        ``` java
                org.wso2.carbon.privacy.forgetme.logs.instructions.LogFileInstructionReader
        ```

4.  Compile and build the JAR.

5.  Add the pre-built jar to the `          <TOOL_HOME>/lib         ` directory.
    Alternatively, you can build your own distribution of the tool and include it in the product itself.

