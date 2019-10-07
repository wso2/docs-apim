# Adding an Application Key Generation Workflow

This section explains how to attach a custom workflow to the **application registration** operation in the API Manager. First, see [Workflow Extensions](https://docs.wso2.com/display/SHAN/Managing+Workflow+Extensions) for information on different types of workflow executors.

#### Introduction to Application registration (Key generation) workflow

[Application creation](https://docs.wso2.com/display/SHAN/Adding+an+Application+Creation+Workflow) and **Application registration** are different workflows. After an application is created, you can subscribe to available APIs, but you get the consumer key/secret and access tokens only after registering the application. There are two types of registrations that can be done to an application: production and sandbox. You change the default application registration workflow in situations such as the following:

1.  To issue only sandbox keys when creating production keys is deferred until testing is complete.
2.  To restrict untrusted applications from creating production keys. You allow only the creation of sandbox keys.
3.  To make API subscribers go through an approval process before creating any type of access token.

-   [**Using WSO2 EI**](#UsingEI)
-   [**Using WSO2 BPS**](#UsingBPS)

!!! tip
**Before you begin** , if you have changed the API Manager's default user and role, make sure you do the following changes:
1.  Change the credentials of the workflow configurations in the registry resource `_system/governance/apimgt/applicationdata/workflow-extensions.xml` .
    a. Login to the Management console of WSO2 API Manager in <https://localhost:9443/carbon> .
    b. Click on browse under Resources in left Navigation under Main tab.
    c. Go to `/_system/governance/apimgt/applicationdata/workflow-extensions.xml` location in registry browser and open the workflow-extensions.xml clicking **Edit as text** .
    ![](/assets/attachments/103334690/103334695.png)    d. Uncomment the following two sections and change the credentials of API Manager's default user credentials you have given.

        !!! warning
    This configuration is provided assuming that WSO2 EI is running with offset 2. If you are running WSO2 EI in a different offset change the port of **serviceEndpoint** properties in following configuration according to the changed port offset.


    ``` java
        <ProductionApplicationRegistration executor="org.wso2.carbon.apimgt.impl.workflow.ApplicationRegistrationWSWorkflowExecutor">
            <Property name="serviceEndpoint">http://localhost:9765/services/ApplicationRegistrationWorkFlowProcess/</Property>
            <Property name="username">admin</Property>
            <Property name="password">admin</Property>
            <Property name="callbackURL">https://localhost:8248/services/WorkflowCallbackService</Property>
        </ProductionApplicationRegistration>
    <SandboxApplicationRegistration executor="org.wso2.carbon.apimgt.impl.workflow.ApplicationRegistrationWSWorkflowExecutor">
        <Property name="serviceEndpoint">http://localhost:9765/services/ApplicationRegistrationWorkFlowProcess/</Property>
        <Property name="username">admin</Property>
        <Property name="password">admin</Property>
        <Property name="callbackURL">https://localhost:8248/services/WorkflowCallbackService</Property>
    </SandboxApplicationRegistration>
    ```
        !!! note
    Make sure to comment out the existing `ProductionApplicationRegistration` and `SandboxApplicationRegistration` executors as shown below.

    ``` java
        <!--ProductionApplicationRegistration executor="org.wso2.carbon.apimgt.impl.workflow.ApplicationRegistrationSimpleWorkflowExecutor"/-->
        <!--SandboxApplicationRegistration executor="org.wso2.carbon.apimgt.impl.workflow.ApplicationRegistrationSimpleWorkflowExecutor"/-->
    ```


2.  Point the database that has the API Manager user permissions to EI.
    In this step you need to share the user store database in WSO2 API Manager with WSO2 EI.

    a. Copy the following datasource configuration in `<API-M_HOME>/repository/conf/datasources/master-datasources.xml` :

    ``` java
        <datasource> <name>WSO2UM_DB</name>
         <description>The datasource used by user manager</description>
         <jndiConfig>
           <name>jdbc/WSO2UM_DB</name>
         </jndiConfig>
         <definition type="RDBMS">
           <configuration>
             <url>jdbc:mysql://userdb.mysql-wso2.com:3306/userdb?autoReconnect=true</url>
             <username>user</username>
             <password>password</password>
             <driverClassName>com.mysql.jdbc.Driver</driverClassName>
             <maxActive>50</maxActive>
             <maxWait>60000</maxWait>
             <testOnBorrow>true</testOnBorrow>
             <validationQuery>SELECT 1</validationQuery>
             <validationInterval>30000</validationInterval>
           </configuration>
         </definition>
        </datasource>
    ```

        !!! note
    We are using MySQL to configure the datasources in this documentation. You can configure this according to the database you are using. F or more information, see the [Setting up the Physical Database](https://docs.wso2.com/display/ADMIN44x/Setting+up+the+Physical+Database) section in the WSO2 Administration documentation.


    b. Change the datasource to point the WSO2UM\_DB by changing the realm configuration in `<API-M_HOME>/repository/conf/user-mgt.xml` as shown below.

    ``` java
        <UserManager>
            <Realm>
                <Configuration>
                    ....
                    <Property name="dataSource">jdbc/WSO2UM_DB</Property>
                </Configuration>
                    ....
            <Realm>
        <UserManager>
    ```

    c. Do the configuration described in (a) and (b) in `<EI_HOME>/wso2/business-process/conf/datasources/master-datasources.xml` and `<EI_HOME>/wso2/business-process/conf/user-mgt.xml` respectively.

3.  Share any LDAPs, if exist.
4.  Unzip the `<API-M>/business-processes/application-registration/HumanTask/ApplicationRegistrationTask-1.0.0.zip` file, update the role as follows in the `ApplicationRegistrationTask.ht` file, and ZIP the `ApplicationRegistrationTask-1.0.0` folder.

    **Format**

    ``` java
            <htd:argument name="role">
                [new-role-name]
            </htd:argument>
    ```

5.  Restart the API Manager server.


#### Configuring the Business Process Server

1.  Download [WSO2 Enterprise Integrator](https://wso2.com/integration) .
2.  Set an offset of 2 to the default EI port in the `<EI_HOME>/wso2/business-process/conf/carbon.xml` file. This prevents port conflicts that occur when you start more than one WSO2 product on the same server. For more information, see [Changing the Default Ports with Offset](https://docs.wso2.com/display/AM260/Changing+the+Default+Ports+with+Offset) .

    ``` xml
        <Offset>2</Offset>
    ```

        !!! tip
    **Tip** : If you change the EI **port offset to a value other than 2 or run the API Manager and EI on different machines** (therefore, want to set the `hostname` to a different value than `localhost` ), you do the following:

    -   Search and replace the value 9765 in all the files (.epr) inside `<APIM_HOME>/business-processes` folder with the new port (9763 + port offset.)


3.  Open the `<EI_HOME>/wso2/business-process/conf/humantask.xml` file and the `<EI_HOME>/wso2/business-process/conf/b4p-coordination-config.xml` file and set the `TaskCoordinationEnabled` property to true.

    ``` xml
        <TaskCoordinationEnabled>true</TaskCoordinationEnabled>
    ```

4.  Copy the following from the `<API-M_HOME>/business-processes/epr` folder to the `<EI_HOME>/wso2/business-process/conf/epr` folder.

        !!! note
    -   If the `<EI_HOME>/wso2/business-process/conf/epr` folder does not exist, create it.

    -   Make sure you give the correct credentials in the `<EI_HOME>/wso2/business-process/conf/epr` files.


    -   Update the `<API-M_HOME>/business-processes/epr/RegistrationCallbackService.epr` file according to API Manager.

        ``` java
                <wsa:Address>https://localhost:8243/services/WorkflowCallbackService</wsa:Address>
        ```

    -   Update the `<API-M_HOME>/business-processes/epr/RegistrationService.epr` file according to EI.

        ``` java
                    <wsa:Address>http://localhost:9765/services/ApplicationRegistration</wsa:Address>
        ```

5.  Start the BPS server and log in to its management console ( `https://<Server Host>:9443+<port offset>/carbon` ).

        !!! warning
    If you are using Mac OS with High Sierra, you may encounter following warning when login into the Management console due to a compression issue exists in High Sierra SDK.

    ``` java
        WARN {org.owasp.csrfguard.log.JavaLogger} -  potential cross-site request forgery (CSRF) attack thwarted (user:<anonymous>, ip:xxx.xxx.xx.xx, method:POST, uri:/carbon/admin/login_action.jsp, error:required token is missing from the request)
    ```

    To avoid this issue open `<EI_HOME>/repository/conf/tomcat/catalina-server.xml` and change the compression="on" to compression="off" in Connector configuration and restart the EI.


6.  Log into Management console of WSO2 EI, select **Add &gt; BPEL** under the **Processes** menu and upload the `<APIM_HOME>/business-processes/application-registration/BPEL/ApplicationRegistrationWorkflowProcess_1.0.0.zip file` to EI. This is the business process archive file.
    ![](/assets/attachments/103334690/103334694.png)7.  Select **Add** under the **Human Tasks** menu and upload the `<APIM_HOME>/business-processes/application-registration/HumanTask/ApplicationRegistrationTask-1.0.0.zip` file to EI. This is the human task archived file.
    ![](/assets/attachments/103334690/103334693.png)
!!! tip
**Before you begin** , if you have changed the API Manager's default user and role, make sure you do the following changes:
1.  Change the credentials of the workflow configurations in the registry resource `_system/governance/apimgt/applicationdata/workflow-extensions.xml` .
    a. Login to the Management console of WSO2 API Manager in <https://localhost:9443/carbon> .
    b. Click on browse under Resources in left Navigation under Main tab.
    c. Go to `/_system/governance/apimgt/applicationdata/workflow-extensions.xml` location in registry browser and open the workflow-extensions.xml clicking **Edit as text** .
    ![](/assets/attachments/103334690/103334695.png)    d. Uncomment the following two sections and change the credentials of API Manager's default user credetials you have given.

        !!! warning
    This configuration is provided assuming that WSO2 BPS is running with offset 2. If you are running WSO2 BPS in a different offset change the port of **serviceEndpoint** properties in following configuration according to the changed port offset.


    ``` java
        <ProductionApplicationRegistration executor="org.wso2.carbon.apimgt.impl.workflow.ApplicationRegistrationWSWorkflowExecutor">
            <Property name="serviceEndpoint">http://localhost:9765/services/ApplicationRegistrationWorkFlowProcess/</Property>
            <Property name="username">admin</Property>
            <Property name="password">admin</Property>
            <Property name="callbackURL">https://localhost:8248/services/WorkflowCallbackService</Property>
        </ProductionApplicationRegistration>
    <SandboxApplicationRegistration executor="org.wso2.carbon.apimgt.impl.workflow.ApplicationRegistrationWSWorkflowExecutor">
        <Property name="serviceEndpoint">http://localhost:9765/services/ApplicationRegistrationWorkFlowProcess/</Property>
        <Property name="username">admin</Property>
        <Property name="password">admin</Property>
        <Property name="callbackURL">https://localhost:8248/services/WorkflowCallbackService</Property>
    </SandboxApplicationRegistration>
    ```
        !!! note
    Make sure to comment out the existing `ProductionApplicationRegistration` and `SandboxApplicationRegistration` executors as shown below.

    ``` java
        <!--ProductionApplicationRegistration executor="org.wso2.carbon.apimgt.impl.workflow.ApplicationRegistrationSimpleWorkflowExecutor"/-->
        <!--SandboxApplicationRegistration executor="org.wso2.carbon.apimgt.impl.workflow.ApplicationRegistrationSimpleWorkflowExecutor"/-->
    ```


2.  Point the database that has the API Manager user permissions to BPS.
    In this step you need to share the user store database in WSO2 API Manager with WSO2 BPS.

    a. Copy the following datasource configuration in `<API-M_HOME>/repository/conf/datasources/master-datasources.xml` :

    ``` java
        <datasource> <name>WSO2UM_DB</name>
         <description>The datasource used by user manager</description>
         <jndiConfig>
           <name>jdbc/WSO2UM_DB</name>
         </jndiConfig>
         <definition type="RDBMS">
           <configuration>
             <url>jdbc:mysql://userdb.mysql-wso2.com:3306/userdb?autoReconnect=true</url>
             <username>user</username>
             <password>password</password>
             <driverClassName>com.mysql.jdbc.Driver</driverClassName>
             <maxActive>50</maxActive>
             <maxWait>60000</maxWait>
             <testOnBorrow>true</testOnBorrow>
             <validationQuery>SELECT 1</validationQuery>
             <validationInterval>30000</validationInterval>
           </configuration>
         </definition>
        </datasource>
    ```

        !!! note
    We are using MySQL to configure the datasources in this documentation. You can configure this according to the database you are using. Refer [Setting up the Physical Database](https://docs.wso2.com/display/ADMIN44x/Setting+up+the+Physical+Database) for more information.


    b. Change the datasource to point the WSO2UM\_DB by changing the realm configuration in `<API-M_HOME>/repository/conf/user-mgt.xml` as shown below.

    ``` java
        <UserManager>
            <Realm>
                <Configuration>
                    ....
                    <Property name="dataSource">jdbc/WSO2UM_DB</Property>
                </Configuration>
                    ....
            <Realm>
        <UserManager>
    ```

    c. Do the configuration described in (a) and (b) in `<BPS_HOME>/repository/conf/datasources/master-datasources.xml` and `<BPS_HOME>/repository/conf/user-mgt.xml` respectively.

3.  Share any LDAPs, if exist.
4.  Unzip the `<API-M>/business-processes/application-registration/HumanTask/ApplicationRegistrationTask-1.0.0.zip` file, update the role as follows in the `ApplicationRegistrationTask.ht` file, and ZIP the `ApplicationRegistrationTask-1.0.0` folder.

    **Format**

    ``` java
            <htd:argument name="role">
                [new-role-name]
            </htd:argument>
    ```

5.  Restart the API Manager server.


#### Configuring the Business Process Server

1.  Download [WSO2 Business Process Server](http://wso2.com/products/business-process-server/) .
2.  Set an offset of 2 to the default BPS port in the `<BPS_HOME>/repository/conf/carbon.xml` file. This prevents port conflicts that occur when you start more than one WSO2 product on the same server. For more information, see [Changing the Default Ports with Offset](https://docs.wso2.com/display/AM260/Changing+the+Default+Ports+with+Offset) .

    ``` xml
        <Offset>2</Offset>
    ```

        !!! tip
    **Tip** : If you change the BPS **port offset to a value other than 2 or run the API Manager and BPS on different machines** (therefore, want to set the `hostname` to a different value than `localhost` ), you do the following:

    -   Search and replace the value 9765 in all the files (.epr) inside `<APIM_HOME>/business-processes` folder with the new port (9763 + port offset.)


3.  Open the `<BPS_HOME>/repository/conf/humantask.xml` file and the `<BPS_HOME>/repository/conf/b4p-coordination-config.xml` file and set the `TaskCoordinationEnabled` property to true.

    ``` xml
        <TaskCoordinationEnabled>true</TaskCoordinationEnabled>
    ```

4.  Copy the following from the `<API-M_HOME>/business-processes/epr` folder to the `<BPS_HOME>/repository/conf/epr` folder.
    If the `<BPS_HOME>/repository/conf/epr` folder does not exist, create it.

        !!! note
    Make sure you give the correct credentials in the `<BPS_HOME>/repository/conf/epr` files.


    -`RegistrationService.epr              `
    -`RegistrationCallbackService.epr              `

5.  HERE [Start the BPS server](https://docs.wso2.com/display/AM220/Running+the+Product#RunningtheProduct-Startingtheserver) and log in to its management console ( `https://<Server Host>:9443+<port offset>/carbon` ).

        !!! warning
    If you are using Mac OS with High Sierra, you may encounter following warning when login into the Management console due to a compression issue exists in High Sierra SDK.

    ``` java
        WARN {org.owasp.csrfguard.log.JavaLogger} -  potential cross-site request forgery (CSRF) attack thwarted (user:<anonymous>, ip:xxx.xxx.xx.xx, method:POST, uri:/carbon/admin/login_action.jsp, error:required token is missing from the request)
    ```

    To avoid this issue open `<BPS_HOME>/repository/conf/tomcat/catalina-server.xml` and change the compression="on" to compression="off" in Connector configuration and restart the BPS.


6.  Log into Management console of WSO2 BPS, select **Add &gt; BPEL** under the **Processes** menu and upload the `<APIM_HOME>/business-processes/application-registration/BPEL/ApplicationRegistrationWorkflowProcess_1.0.0.zip file` to BPS. This is the business process archive file.
    ![](/assets/attachments/103334690/103334694.png)7.  Select **Add** under the **Human Tasks** menu and upload the `<APIM_HOME>/business-processes/application-registration/HumanTask/ApplicationRegistrationTask-1.0.0.zip` file to BPS. This is the human task archived file.
    ![](/assets/attachments/103334690/103334693.png)
#### 
Configuring the API Manager

Open the `<API-M_HOME>/repository/deployment/server/jaggeryapps/admin/site/conf/site.json` file and configure the " `workFlowServerURL"` under " `workflows"` to point to the EI/BPS server (e.g. `"workFlowServerURL": "                   https://localhost:9445/services/                  "` )

``` java
    {
      .....
      "context": "/admin",
      "request_url": "READ_FROM_REQUEST",
      "tasksPerPage": 10,
      "allowedPermission": "/permission/admin/manage/apim_admin",
      "workflows": {
        "workFlowServerURL": "https://localhost:9445/services/",
      }
      .....
    }
```

#### Engaging the WS Workflow Executor in the API Manager

First, enable the application registration workflow.

1.  Start WSO2 API Manager and login to the APIM management console ( `https://<Server Host>:9443/carbon` ) and select **Browse** under **Resources** .
    ![](/assets/attachments/103334690/103334700.png)
2.  Go to the `/_system/governance/apimgt/applicationdata/workflow-extensions.xml` resource, disable the Simple Workflow Executor and enable WS Workflow Executor as described in the tip provided at the start of this documentation if you haven't done already.

    ``` html/xml
            <WorkFlowExtensions>
            ...
                <ProductionApplicationRegistration executor="org.wso2.carbon.apimgt.impl.workflow.ApplicationRegistrationWSWorkflowExecutor">
                    <Property name="serviceEndpoint">http://localhost:9765/services/ApplicationRegistrationWorkFlowProcess/</Property>
                    <Property name="username">admin</Property>
                    <Property name="password">admin</Property>
                    <Property name="callbackURL">https://localhost:8248/services/WorkflowCallbackService</Property>
                </ProductionApplicationRegistration>
            ...   
                <SandboxApplicationRegistration executor="org.wso2.carbon.apimgt.impl.workflow.ApplicationRegistrationWSWorkflowExecutor">
                    <Property name="serviceEndpoint">http://localhost:9765/services/ApplicationRegistrationWorkFlowProcess/</Property>
                    <Property name="username">admin</Property>
                    <Property name="password">admin</Property>
                    <Property name="callbackURL">https://localhost:8248/services/WorkflowCallbackService</Property>
                </SandboxApplicationRegistration>
            ...
            </WorkFlowExtensions>
    ```

        !!! tip
    **Note** that all workflow process services of the EI/BPS run on port 9765 because you changed its default port (9763) with an offset of 2.


3.  Log into the API Store ( <https://localhost:9443/store> ) as a Store user and open the application with which you subscribed to the API.

        !!! note
    If you do not have an already created API and an Application subscribed to it, follow [Create and Publish an API](https://docs.wso2.com/display/AM260/Create+and+Publish+an+API) and upto step 8 of [Subscribe to an API](https://docs.wso2.com/display/AM260/Subscribe+to+an+API) to create an API and subscribe to it.


4.  In the **Production Keys** tab of the Application, click the **Generate Keys** button.
    It invokes the `ApplicationRegistrationWorkFlowProcess.bpel` that is bundled with the `ApplicationRegistrationWorkflowProcess_1.0.0.zip` file and creates a HumanTask instance that holds the execution of the BPEL process until some action is performed on it.
    ![](/assets/attachments/103334690/103334692.png)
5.  Note that a message appears saying that the request is successfully submitted if the BPEL was invoked correctly.

6.  Log in to the Admin Portal ( `https://<Server Host>:9443/admin` ) with admin credentials and list all the tasks for application registrations. Click **Start** to start the Human Task and then change its state. Once you select **Approve** and click **Complete** the task, it resumes the BPEL process and completes the registration.

    ![](/assets/attachments/103334690/103334691.png){height="250"}

7.  Go back to the API Store and view your application.

    It shows the application access token, consumer key and consumer secret.
    After the registration request is approved, keys are generated by invoking the `APIKeyMgtSubscriber` service hosted in Key Manger nodes. Even when the request is approved, key generation can fail if this service becomes unavailable. To address such failures, you can configure to trigger key generation at a time Key Manager nodes become available again. Given below is the message used to invoke the BPEL process:

    ``` html/xml
        <applicationregistrationworkflowprocessrequest xmlns:wor="http://workflow.application.apimgt.carbon.wso2.org"
         xmlns="http://workflow.application.apimgt.carbon.wso2.org">
           <applicationname>NewApp5</applicationname>
           <applicationtier>Unlimited</applicationtier>
           <applicationcallbackurl></applicationcallbackurl>
           <applicationdescription></applicationdescription>
           <tenantdomain>carbon.super</tenantdomain>
           <username>admin</username>
           <workflowexternalref>4a20749b-a10d-4fa5-819b-4fae5f57ffaf</workflowexternalref>
           <callbackurl>https://localhost:8243/services/WorkflowCallbackService</callbackurl>
           <keytype>PRODUCTION</keytype>
        </applicationregistrationworkflowprocessrequest>
    ```


