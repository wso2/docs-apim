# Adding a User Signup Workflow

This section explains how to attach a custom workflow to the user signup operation in the API Manager. 

!!! note
    You can either use the **Entreprise Integrator(EI)** or the **Business Process Server(BPS)** for the business process tasks with API Manager during the Workflow configuration process.

!!! tip
    **Before you begin** , if you have changed the API Manager's default user and role, make sure you do the following changes :

    1.   Change the credentials of the workflow configurations in the registry resource `_system/governance/apimgt/applicationdata/workflow-extensions.xml` .
    2.   Point the database that has the API Manager user permissions to Enterprise Integrator(EI)/Business Process Server(BPS).
    3.   Share any LDAPs, if exist.
    4.   Unzip the `<API-M>/business-processes/user-signup/UserApprovalTask-1.0.0.zip` file, update the role as follows in the `UserApprovalTask.ht` file, and ZIP the `UserApprovalTask.ht` folder.

    **Format**

    ``` java
        <htd:argument name="role">
            [new-role-name]
        </htd:argument>
    ```

#### Configuring the Enterprise Integrator

!!! note
    Follow this sub section, only if you will be using the **Entreprise Integrator(EI)** for the business process tasks. If not please refer the sub section for [Configuring the Business Process Server.](/learn/consume-api/customizations/adding-a-user-signup-workflow/#configuring-the-business-process-server)

1.  Download [WSO2 Enterprise Integrator](https://wso2.com/integration).

2.  Make sure that an offset of 2 is added to the default EI port in the `<EI_HOME>/wso2/business-process/conf/carbon.xml` file. This prevents port conflicts that occur when you start more than one WSO2 product on the same server. For more information, see [Changing the Default Ports with Offset](/reference/guides/changing-the-default-ports-with-offset).

    ``` xml
    <Offset>2</Offset>
    ```

    !!! tip
        If you **change the EI port offset to a value other than 2 or run the API Manager and EI on different machines** (therefore, want to set the `hostname` to a different value than `localhost` ), you do the following :

        -   Search and replace the value 9765 in all the files (.epr) inside `<API-M_HOME>/business-processes` folder with the  new port (9763 + port offset).

        !!! note
            **Note:** Make sure that the port offset is updated in the following files as well. Note that the zipped files should be unzipped for you to be able to see the files

            -`<API-M_HOME>/business-processes/user-signup/HumanTask/UserApprovalTask-1.0.0.zip/UserApprovalTask.wsdl`

            -`<API-M_HOME>/business-processes/user-signup/BPEL/UserSignupApprovalProcess_1.0.0.zip/UserApprovalTask.wsdl`

            -`<API-M_HOME>/business-processes/user-signup/BPEL/UserSignupApprovalProcess_1.0.0.zip/WorkflowCallbackService.wsdl`


3.  Open the `<EI_HOME>/wso2/business-process/conf/humantask.xml` file and `<EI_HOME>/wso2/business-process/conf/b4p-coordination-config.xml` file and set the `TaskCoordinationEnabled` property to true. For further information on this configuration see [Configuring Human Task Coordination](https://docs.wso2.com/display/BPS360/Configuring+Human+Task+Coordination) .

    ``` xml
    <TaskCoordinationEnabled>true</TaskCoordinationEnabled>
    ```

4.  Copy the following 2 files from the `<API-M_HOME>/business-processes/epr` folder to the `<EI_HOME>/wso2/business-process/repository/conf/epr` folder.

    - `<API-M_HOME>/business-processes/epr/UserSignupProcess.epr`
    - `<API-M_HOME>/business-processes/epr/UserSignupService.epr`

    !!! note
        -   If the `<EI_HOME>/wso2/business-process/repository/conf/epr` folder isn't there, please create it.

        -   Make sure to give the correct credentials in the `<EI_HOME>/wso2/business-process/repository/conf/epr` files.

    1.  Update the `<API-M_HOME>/business-processes/epr/UserSignupProcess.epr` file according to the port offset configured in API Manager. (Default port 8243).

        ```java
        <wsa:Address>https://localhost:8243/services/WorkflowCallbackService</wsa:Address>
        ```

    2.  Update the `<API-M_HOME>/business-processes/epr/UserSignupService.epr` file according to the port offset of EI. (Default port 9763 + 2).

        ```java
        <wsa:Address>http://localhost:9765/services/UserApprovalService</wsa:Address>
        ```

5.  [Start the EI server](https://docs.wso2.com/display/EI650/Running+the+Product#RunningtheProduct-Startingtheserver) and log in to its management console ( `https://<Server-Host>:9443+<port-offset>/carbon` ).

    <div class="admonition warning">
        <p class="admonition-title">Warning</p>
        <p>If you are using Mac OS with High Sierra, you may encounter following warning when logging into the Management console due to a compression issue that exists in High Sierra SDK.</p>
        <p>`WARN {org.owasp.csrfguard.log.JavaLogger} -  potential cross-site request forgery (CSRF) attack thwarted (user:<anonymous>, ip:xxx.xxx.xx.xx, method:POST, uri:/carbon/admin/login_action.jsp, error:required token is missing from the request)`
        </p>
        <p>To avoid this issue open `<EI_HOME>/wso2/business-process/conf/tomcat/catalina-server.xml` and change the compression="on" to compression="off" in Connector configuration and restart the EI.</p>
    </div>

6.  Select **BPEL** under the **Processes** > **Add** menu and upload the `<API-M_HOME>/business-processes/user-signup/BPEL/UserSignupApprovalProcess_1.0.0.zip` file to EI. This is the business process archive file.

    ![Add BPEL to EI]({{base_path}}/assets/img/learn/bpel-upload-signup-workflow.png)
    
7. Select **Add** under the **Human Tasks** menu and upload the `<API-M_HOME>/business-processes/user-signup/HumanTask/UserApprovalTask-1.0.0.zip` file to EI. This is the human task archived file.

    ![Add Human Task to EI]({{base_path}}/assets/img/learn/add-human-task-signup.png)

#### Configuring the Business Process Server

!!! note
    Follow this sub section, only if you will be using the **Business Process Server(BPS)** for the business process tasks. If not please refer the sub section for [Configuring the Entreprise Integrator.](/learn/consume-api/customizations/adding-a-user-signup-workflow/#configuring-the-enterprise-integrator)

1.  Download [WSO2 Business Process Server](http://wso2.com/products/business-process-server/) .

2.  Set an offset of 2 to the default BPS port in the `<BPS_HOME>/repository/conf/carbon.xml` file. This prevents port conflicts that occur when you start more than one WSO2 product on the same server. For more information, see [Changing the Default Ports with Offset](/reference/guides/changing-the-default-ports-with-offset).

    ``` xml
    <Offset>2</Offset>
    ```

!!! tip
    If you **change the BPS port offset to a value other than 2 or run the API Manager and BPS on different machines** (therefore, want to set the `hostname` to a different value than `localhost` ), you do the following:

    -   Search and replace the value 9765 in all the files (.epr) inside `<API-M_HOME>/business-processes` folder with the  new port (9763 + port offset).

    !!! note
        **Note:** Make sure that the port offset is updated in the following files as well. Note that the zipped files should be unzipped for you to be able to see the files

        -`<API-M_HOME>/business-processes/user-signup/HumanTask/UserApprovalTask-1.0.0.zip/UserApprovalTask.wsdl`

        -`<API-M_HOME>/business-processes/user-signup/BPEL/UserSignupApprovalProcess_1.0.0.zip/UserApprovalTask.wsdl`

        -`<API-M_HOME>/business-processes/user-signup/BPEL/UserSignupApprovalProcess_1.0.0.zip/WorkflowCallbackService.wsdl`

3.  Open the `<BPS_HOME>/repository/conf/humantask.xml` file and `<BPS_HOME>/repository/conf/b4p-coordination-config.xml` file and set the `TaskCoordinationEnabled` property to true. For further information on this configuration see [Configuring Human Task Coordination](https://docs.wso2.com/display/BPS360/Configuring+Human+Task+Coordination) .

    ``` xml
    <TaskCoordinationEnabled>true</TaskCoordinationEnabled>
    ```

4.  Copy the following 2 files from the `<API-M_HOME>/business-processes/epr` folder to the `<BPS_HOME>/repository/conf/epr` folder.

    - `<API-M_HOME>/business-processes/epr/UserSignupProcess.epr`
    - `<API-M_HOME>/business-processes/epr/UserSignupService.epr`

    !!! note
        -   If the `<BPS_HOME>/repository/conf/epr` folder isn't there, please create it .
        -   Make sure to give the correct credentials in the `<BPS_HOME>/repository/conf/epr` files.


    1.   Update the `<API-M_HOME>/business-processes/epr/UserSignupProcess.epr` file according to API Manager.

        ```java
        <wsa:Address>https://localhost:8243/services/WorkflowCallbackService</wsa:Address>
        ```

    2.   Update the `<API-M_HOME>/business-processes/epr/UserSignupService.epr` file according to BPS.

        ```java
        <wsa:Address>http://localhost:9765/services/UserApprovalService</wsa:Address>
        ```

5.  [Start the BPS server](https://docs.wso2.com/display/AM260/Running+the+Product#RunningtheProduct-Startingtheserver) and log in to its management console ( `https://<Server-Host>:9443+<port-offset>/carbon` ).

    <div class="admonition warning">
        <p class="admonition-title">Warning</p>
        <p>If you are using Mac OS with High Sierra, you may encounter following warning when login into the Management console due to a compression issue exists in High Sierra SDK.</p>
        <p>`WARN {org.owasp.csrfguard.log.JavaLogger} -  potential cross-site request forgery (CSRF) attack thwarted (user:<anonymous>, ip:xxx.xxx.xx.xx, method:POST, uri:/carbon/admin/login_action.jsp, error:required token is missing from the request)`</p>
        <p>To avoid this issue open `<BPS_HOME>/repository/conf/tomcat/catalina-server.xml` and change the compression="on" to compression="off" in Connector configuration and restart the BPS.</p>
    </div>

6.  Select **BPEL** under the **Processes** > **Add** menu and upload the `<API-M_HOME>/business-processes/user-signup/BPEL/UserSignupApprovalProcess_1.0.0.zip` file to BPS. This is the business process archive file.

    ![Add BPEL to BPS]({{base_path}}/assets/img/learn/bpel-upload-signup-workflow.png)
    
7.  Select **Add** under the **Human Tasks** menu and upload the `<API-M_HOME>/business-processes/user-signup/HumanTask/UserApprovalTask-1.0.0.zip` file to BPS. This is the human task archived file.

    ![Add Human Task to BPS]({{base_path}}/assets/img/learn/add-human-task-signup.png)

#### Configuring the API Manager

1.  Open the `<API-M_HOME>/repository/deployment/server/jaggeryapps/admin/site/conf/site.json` file and configure **workFlowServerURL** under **workflows** to point to the EI/BPS server (e.g. `"workFlowServerURL": "https://localhost:9445/services/"` )

!!! note
    When enabling the workflow, make sure to **import the certificate** of API Manager into the client-truststore of the EI/BPS server and also import the certificate of EI/BPS into the client-truststore of API Manager.

    Paths to the directory containing the client-truststore of each product are :

        1. API-M - '<API-M_HOME>/repository/resources/security'
        2. EI - '<EI_HOME>/wso2/business-process/repository/resources/security'
        3. BPS - '<BPS_HOME>/repository/resources/security'

#### Engaging the WS Workflow Executor in the API Manager

1.  Log in to API-M management console ( `https://<Server-Host>:9443/carbon` ) and select **Browse** under **Resources**.

    ![Browse resources]({{base_path}}/assets/img/learn/browse-resources.png)

2.  Go to `/_system/governance/apimgt/applicationdata/workflow-extensions.xml` resource, disable the **Simple Workflow Executor** and enable **WS Workflow Executor**. Also specify the service endpoint where the workflow engine is hosted and the credentials required to access the said service via basic authentication (i.e., username/password based authentication).

    ```html/xml
        <WorkFlowExtensions>
        ...
            <UserSignUp executor="org.wso2.carbon.apimgt.impl.workflow.UserSignUpWSWorkflowExecutor">
                 <Property name="serviceEndpoint">http://localhost:9765/services/UserSignupProcess/</Property>
                 <Property name="username">admin</Property>
                 <Property name="password">admin</Property>
                 <Property name="callbackURL">https://localhost:8243/services/WorkflowCallbackService</Property>
            </UserSignUp>
        ...
    </WorkFlowExtensions>
    ```
    !!! info
        All workflow process services of the EI/BPS run on port 9765 because you changed its default port (9763) with an offset of 2.

3.  Go to the Developer Portal Web interface of API Manager and sign up / register as a new user.
<html>
    <body>
        <div>
            <img src="{{base_path}}/assets/img/learn/register-now.png" alt="Register now option" width="600"/>
        </div>
    </body>
</html>
    It invokes the signup process and creates a Human Task instance that holds the execution of the BPEL until some action is performed on it.

4.  Note the message that appears if the BPEL is invoked correctly, saying that the request is successfully submitted.

5.  Log in to the [Admin Portal](`https://localhost:9443/admin`) (`https://<Server-Host>:9443/admin`) of API Manager giving the admin username and password.

6.  Navigate to **Tasks** > **User Creation** and approve the user signup task listed. This will resume the BPEL process and complete the signup process.

7.  Go back to the Developer Portal and see that the user is now registered.

Whenever a user tries to sign up to the Developer Portal, a request of the following format is sent to the workflow endpoint:

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:wor="http://workflow.subscription.apimgt.carbon.wso2.org">
    <soapenv:Header />
    <soapenv:Body>
        <wor:registerUser xmlns:wor="http://workflow.registeruser.apimgt.carbon.wso2.org">
            <wor:userName>sampleuser</wor:userName>
            <wor:tenantDomain>foo.com</wor:tenantDomain>
            <wor:workflowExternalRef>c0aad878-278c-4439-8d7e-712ee71d3f1c</wor:workflowExternalRef>
            <wor:callbackURL>https://localhost:8243/services/WorkflowCallbackService</wor:callBackURL>
        </wor:registerUser>
    </soapenv:Body>
</soapenv:Envelope>
```

Elements of the above configuration are described below:

| Element                                              | Description                                                                                                      |                                                                                                                                                                              
|----------------------------------------------------  |-------------------------------------------------------------------------------------------------------------------|
|`userName`                                            | The user name requested by the user                                                                               |
|`tenantDomain`                                        | Domain to which the user belongs to                                                                               |
|`workflowExternalRef`                                 | The unique reference against which a workflow is tracked. This needs to be sent from the workflow engine to the API Manager at the time of workflow completion.                                                                                                                                |
|`callBackURL`                                         | The URL to which the workflow completion request is sent by the workflow engine, at the time of workflow completion. This property is configured under the `callBackURL` property in the `workflow-extensions.xml registry` file.                                                               |
