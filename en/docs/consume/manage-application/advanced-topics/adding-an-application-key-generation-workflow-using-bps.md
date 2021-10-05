# Adding an Application Key Generation Workflow

This section explains as to how you can attach a custom workflow to the **application registration** operation in the API Manager. 

[Application creation]({{base_path}}/consume-api/manage-application/advanced-topics/adding-an-application-creation-workflow) and **Application registration** are different workflows. After an application is created, you can subscribe to available APIs, but you get the consumer key/secret and access tokens only after registering the application. There are two types of registrations with regard to an application: production and sandbox. The following are the situations in which you need to change the default application registration workflow:

-  To only issue sandbox keys when creating production keys is deferred until testing is complete.
-  To restrict untrusted applications from creating production keys. You allow only the creation of sandbox keys.
-  To make API subscribers go through an approval process before creating any type of access token.

!!! tip
    **Before you begin**, if you have changed the API Manager's default user and role, make sure you do the following changes:

    1.  Change the credentials of the workflow configurations in the registry resource `_system/governance/apimgt/applicationdata/workflow-extensions.xml`.

        a. Sign in to the Management Console of WSO2 API Manager in <https://localhost:9443/carbon>.

        b. Click **Main** --> **Resources** --> **Browse**.

        c. Go to `/_system/governance/apimgt/applicationdata/workflow-extensions.xml` location in the registry browser.
        
        d. Click **Edit as text** to open the `workflow-extensions.xml` file.
        
          [![Edit view of workflow-extensions file]({{base_path}}/assets/img/learn/application-registration-wf-config.png)]({{base_path}}/assets/img/learn/application-registration-wf-config.png)

        e. Uncomment the following two sections and change the credentials of API Manager's default user credentials you have given.

        !!! warning
            It is assumed in the following configuration that WSO2 EI is running with offset 2. If you are running WSO2 EI in a different offset change the ports that correspond to the **serviceEndpoint** properties in the following configuration according to the changed port offset.

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

         a. Copy the following datasource configuration in the `<API-M_HOME>/repository/conf/datasources/master-datasources.xml` file:
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
            MySQL is used to configure the datasources in this documentation. You can configure this based on the database that you are using. For more information, see the [Working with Database]({{base_path}}/install-and-setup/setting-up-databases/overview/).


        b. Change the datasource to point the WSO2UM\_DB by changing the realm configuration in the `<API-M_HOME>/repository/conf/user-mgt.xml` file as shown below.
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

        c. Do the configuration described in (a) and (b) in the `<EI_HOME>/wso2/business-process/conf/datasources/master-datasources.xml` and in the `<EI_HOME>/wso2/business-process/conf/user-mgt.xml` file respectively.

    3.  Share any LDAPs, if they exist.
    4.  Unzip the `<API-M>/business-processes/application-registration/HumanTask/ApplicationRegistrationTask-1.0.0.zip` file, update the role as follows in the `ApplicationRegistrationTask.ht` file, and ZIP the `ApplicationRegistrationTask-1.0.0` folder.

        **Format**

        ``` java
        <htd:argument name="role">
            [new-role-name]
        </htd:argument>
        ```

    5.  Restart the WSO2 API Manager server.


## Step 1 - Configure the Business Process server

1.  Download [WSO2 Enterprise Integrator](https://wso2.com/enterprise-integrator/6.5.0).
2.  Set an offset of 2 to the default EI port in the `<EI_HOME>/wso2/business-process/conf/carbon.xml` file. This prevents port conflicts that occur when you start more than one WSO2 product on the same server. For more information, see [Changing the Default Ports with Offset]({{base_path}}/install-and-setup/deploying-wso2-api-manager/changing-the-default-ports-with-offset/).

    ``` java
    <Offset>2</Offset>
    ```

    !!! tip
        - If you run the API Manager and EI on different machines, set the `hostname` to a different value than `localhost`.
        - If you change the EI **port offset to a value other than 2 or run the API Manager and EI on different machines**, do the following:
             - Search and replace the value 9765 in all the files (.epr) inside `<APIM_HOME>/business-processes` folder with the new port (9763 + port offset.)


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

5.  Start the BPS server and sign in to its Management Console (`https://<Server Host>:9443+<port offset>/carbon`).

    !!! warning
        If you are using Mac OS with High Sierra, you may encounter the following warning when you sign in to the Management console due to a compression issue that exists in High Sierra SDK.

        ``` java
        WARN {org.owasp.csrfguard.log.JavaLogger} -  potential cross-site request forgery (CSRF) attack thwarted (user:<anonymous>, ip:xxx.xxx.xx.xx, method:POST, uri:/carbon/admin/login_action.jsp, error:required token is missing from the request)
        ```

        To avoid this issue open the `<EI_HOME>/repository/conf/tomcat/catalina-server.xml` file and change `compression="on"` to `compression="off"` in Connector configuration and restart the EI.

6.  Sign in to the Management console of WSO2 EI.

7.  Click **Main** --> **Processes** --> **Add** --> **BPEL** and upload the `<API-M_HOME>/business-processes/application-registration/BPEL/ApplicationRegistrationWorkflowProcess_1.0.0.zip` file to EI. This is the business process archive file.

     [![Upload BPEL package]({{base_path}}/assets/img/learn/add-registration-wf-bpel.png)]({{base_path}}/assets/img/learn/add-registration-wf-bpel.png)

8.  Click **Main** --> **Processes** --> **Human Tasks** --> **Add** and upload the `<APIM_HOME>/business-processes/application-registration/HumanTask/ApplicationRegistrationTask-1.0.0.zip` file to EI.    

     This is the human task archived file.
     
     [![Add the human task archived file]({{base_path}}/assets/img/learn/add-registration-wf-humantask.png)]({{base_path}}/assets/img/learn/add-application-wf-humantask.png)

## Step 2 - Configure WSO2 API Manager

Open the `<API-M_HOME>/repository/deployment/server/jaggeryapps/admin/site/conf/site.json` file and configure the value for `workFlowServerURL` under the `workflows` section to point to the EI/BPS server (e.g., `"workFlowServerURL": "https://localhost:9445/services/"`)

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

## Step 3 - Engage the WS Workflow executor in the API Manager

First, enable the application registration workflow.

1.  Start WSO2 API Manager and sign in to the APIM management console (`https://<Server Host>:9443/carbon`).

2. Click **Main** --> **Resources** --> **Browse**.

     <a href="{{base_path}}/assets/img/learn/add-application-wf-browse.png"><img src="{{base_path}}/assets/img/learn/add-application-wf-browse.png" width="250" height="100"/></a>

2.  Go to the `/_system/governance/apimgt/applicationdata/workflow-extensions.xml` resource, disable the Simple Workflow Executor and enable WS Workflow Executor as described in the tip provided at the start of this documentation if you haven't done so already.

    ``` xml
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


3.  Sign in to the API Developer Portal (<https://localhost:9443/devportal>) as a Developer Portal user and open the application with which you subscribed to the API.

    !!! note
        If you do not have an API already created and an Application subscribed to it, follow [Create a REST API]({{base_path}}/design/create-api/create-rest-api/create-a-rest-api/), [Publish an API]({{base_path}}/deploy-and-publish/publish-on-dev-portal/publish-an-api/), and [Subscribe to an API]({{base_path}}/consume/manage-subscription/subscribe-to-an-api) to create an API and subscribe to it.


4.  Click **Applications**, **Production Keys**, and **Generate Keys**.
    
     It invokes the `ApplicationRegistrationWorkFlowProcess.bpel` that is bundled with the `ApplicationRegistrationWorkflowProcess_1.0.0.zip` file and creates a HumanTask instance that holds the execution of the BPEL process until some action is performed on it.

     [ ![Generate keys for an application]({{base_path}}/assets/img/learn/add-registration-wf-generate-keys.png) ]({{base_path}}/assets/img/learn/add-registration-wf-generate-keys.png)


     Note that a message appears saying that the request is successfully submitted when the BPEL is invoked correctly.

5.  Sign in to the Admin Portal (`https://<Server Host>:9443/admin`) with admin credentials and list all the tasks for application registrations. 

6. Click **Start** to start the Human Task and then change its state. 

7. Click **Approve** and **Complete** to complete the task.

     This resumes the BPEL process and completes the registration.

    [![]({{base_path}}/assets/img/learn/add-registration-wf-approval.png)]({{base_path}}/assets/img/learn/add-registration-wf-approval.png)

7.  Navigate back to the API Developer Portal and view your application.

     It shows the application access token, consumer key and consumer secret.



After the registration request is approved, the keys are generated by invoking the `APIKeyMgtSubscriber` service hosted in Key Manager nodes. Even when the request is approved, the key generation can fail if this service becomes unavailable. To address such failures, you can configure to trigger key generation at a time Key Manager nodes become available again. Given below is the message used to invoke the BPEL process:
    ``` xml
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