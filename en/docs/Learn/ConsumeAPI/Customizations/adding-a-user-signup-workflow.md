# Adding a User Signup Workflow

This section explains how to attach a custom workflow to the user signup operation in the API Manager. First, see [Workflow Extensions](_Managing_Workflow_Extensions_) for information on different types of workflow executors.

-   [**Using WSO2 EI**](#UsingEI)
-   [**Using WSO2 BPS**](#UsingBPS)

!!! tip
**Before you begin** , if you have changed the API Manager's default user and role, make sure you do the following changes:
-   Change the credentials of the workflow configurations in the registry resource `_system/governance/apimgt/applicationdata/workflow-extensions.xml` .
-   Point the database that has the API Manager user permissions to EI.
-   Share any LDAPs, if exist.
-   Unzip the `<API-M>/business-processes/user-signup/UserApprovalTask-1.0.0.zip` file, update the role as follows in the `UserApprovalTask.ht` file, and ZIP the `UserApprovalTask.ht` folder.

    **Format**

    ``` java
        <htd:argument name="role">
            [new-role-name]
        </htd:argument>
    ```

#### Configuring the Business Process Server

1.  Download [WSO2 Enterprise Integrator](https://wso2.com/integration) .

2.  Set an offset of 2 to the default EI port in the `<EI_HOME>/wso2/business-process/conf/carbon.xml` file. This prevents port conflicts that occur when you start more than one WSO2 product on the same server. For more information, see [Changing the Default Ports with Offset](https://docs.wso2.com/display/AM260/Changing+the+Default+Ports+with+Offset) .

    ``` xml
        <Offset>2</Offset>
    ```

        !!! tip
    **Tip** : If you **change the EI port offset to a value other than 2 or run the API Manager and EI on different machines** (therefore, want to set the `hostname` to a different value than `localhost` ), you do the following:

    -   Search and replace the value 9765 in all the files (.epr) inside `<APIM_HOME>/business-processes` folder with the  new port (9763 + port offset).

        !!! note
    **Note:** Make sure that the port offset is updated in the following files as well. Note that the zipped files should be unzipped for you to be able to see the files

    -`<API-M_HOME>/business-processes/user-signup/HumanTask/UserApprovalTask-1.0.0.zip/UserApprovalTask.wsdl               `

    -`<API-M_HOME>/business-processes/user-signup/BPEL/UserSignupApprovalProcess_1.0.0.zip/UserApprovalTask.wsdl               `

`<API-M_HOME>/business-processes/user-signup/BPEL/UserSignupApprovalProcess_1.0.0.zip/WorkflowCallbackService.wsdl             `


3.  Open the `<EI_HOME>/wso2/business-process/conf/humantask.xml` file and `<EI_HOME>/wso2/business-process/conf/b4p-coordination-config.xml` file and set the `TaskCoordinationEnabled` property to true. For further information on this configuration see [Configuring Human Task Coordination](https://docs.wso2.com/display/BPS360/Configuring+Human+Task+Coordination) .

    ``` xml
        <TaskCoordinationEnabled>true</TaskCoordinationEnabled>
    ```

4.  Copy the following from the `<API-M_HOME>/business-processes/epr` folder to the `<EI_HOME>/wso2/business-process/repository/conf/epr` folder.

        !!! note
    -   If the `<EI_HOME>/wso2/business-process/repository/conf/epr` folder isn't there, please create it.

    -   Make sure to give the correct credentials in the `<EI_HOME>/wso2/business-process/repository/conf/epr` files.


    1.  Update the `<API-M_HOME>/business-processes/epr/UserSignupProcess.epr` file according to API Manager.

        ``` java
                <wsa:Address>https://localhost:8243/services/WorkflowCallbackService</wsa:Address>
        ```

    2.  Update the `<API-M_HOME>/business-processes/epr/UserSignupService.epr` file according to EI.

        ``` java
                    <wsa:Address>http://localhost:9765/services/UserApprovalService</wsa:Address>
        ```

5.  [Start the EI server](https://docs.wso2.com/display/EI640/Running+the+Product#RunningtheProduct-Startingtheserver) and log in to its management console ( `https://<Server Host>:9443+<port offset>/carbon` ).

        !!! warning
    If you are using Mac OS with High Sierra, you may encounter following warning when login into the Management console due to a compression issue exists in High Sierra SDK.

    ``` java
        WARN {org.owasp.csrfguard.log.JavaLogger} -  potential cross-site request forgery (CSRF) attack thwarted (user:<anonymous>, ip:xxx.xxx.xx.xx, method:POST, uri:/carbon/admin/login_action.jsp, error:required token is missing from the request)
    ```

    To avoid this issue open `<EI_HOME>/wso2/business-process/conf/tomcat/catalina-server.xml` and change the compression="on" to compression="off" in Connector configuration and restart the EI.


6.  Select **Add** under the **Processes** menu and upload the `<API-M_HOME>/business-processes/user-signup/BPEL/UserSignupApprovalProcess_1.0.0.zip` file to EI. This is the business process archive file.
    ![](/assets/attachments/103334709/103334710.png)7.  Select **Add** under the **Human Tasks** menu and upload the `<API-M_HOME>/business-processes/user-signup/HumanTask/UserApprovalTask-1.0.0.zip` file to EI. This is the human task archived file.

!!! tip
**Before you begin** , if you have changed the API Manager's default user and role, make sure you do the following changes:
-   Change the credentials of the workflow configurations in the registry resource `_system/governance/apimgt/applicationdata/workflow-extensions.xml` .
-   Point the database that has the API Manager user permissions to BPS.
-   Share any LDAPs, if exist.
-   Unzip the `<API-M>/business-processes/user-signup/UserApprovalTask-1.0.0.zip` file, update the role as follows in the `UserApprovalTask.ht` file, and ZIP the `UserApprovalTask.ht` folder.

    **Format**

    ``` java
        <htd:argument name="role">
            [new-role-name]
        </htd:argument>
    ```

#### Configuring the Business Process Server

1.  Download [WSO2 Business Process Server](http://wso2.com/products/business-process-server/) .

2.  Set an offset of 2 to the default BPS port in the `<BPS_HOME>/repository/conf/carbon.xml` file. This prevents port conflicts that occur when you start more than one WSO2 product on the same server. For more information, see [Changing the Default Ports with Offset](https://docs.wso2.com/display/AM260/Changing+the+Default+Ports+with+Offset) .

    ``` xml
        <Offset>2</Offset>
    ```

        !!! tip
    **Tip** : If you **change the BPS port offset to a value other than 2 or run the API Manager and BPS on different machines** (therefore, want to set the `hostname` to a different value than `localhost` ), you do the following:

    -   Search and replace the value 9765 in all the files (.epr) inside `<APIM_HOME>/business-processes` folder with the  new port (9763 + port offset).

        !!! note
    **Note:** Make sure that the port offset is updated in the following files as well. Note that the zipped files should be unzipped for you to be able to see the files

    -`<API-M_HOME>/business-processes/user-signup/HumanTask/UserApprovalTask-1.0.0.zip/UserApprovalTask.wsdl              `
    -`<API-M_HOME>/business-processes/user-signup/BPEL/UserSignupApprovalProcess_1.0.0.zip/UserApprovalTask.wsdl              `
    -`<API-M_HOME>/business-processes/user-signup/BPEL/UserSignupApprovalProcess_1.0.0.zip/WorkflowCallbackService.wsdl              `


3.  Open the `<BPS_HOME>/repository/conf/humantask.xml` file and `<BPS_HOME>/repository/conf/b4p-coordination-config.xml` file and set the `TaskCoordinationEnabled` property to true. For further information on this configuration see [Configuring Human Task Coordination](https://docs.wso2.com/display/BPS360/Configuring+Human+Task+Coordination) .

    ``` xml
        <TaskCoordinationEnabled>true</TaskCoordinationEnabled>
    ```

4.  Copy the following from the `<API-M_HOME>/business-processes/epr` folder to the `<BPS_HOME>/repository/conf/epr` folder.

        !!! note
    -   If the `<BPS_HOME>/repository/conf/epr` folder isn't there, please create it .
    -   Make sure to give the correct credentials in the `<BPS_HOME>/repository/conf/epr` files.


    -   Update the `<API-M_HOME>/business-processes/epr/UserSignupProcess.epr` file according to API Manager.

        ``` java
                <wsa:Address>https://localhost:8243/services/WorkflowCallbackService</wsa:Address>
        ```

    -   Update the `<API-M_HOME>/business-processes/epr/UserSignupService.epr` file according to BPS.

        ``` java
                    <wsa:Address>http://localhost:9765/services/UserApprovalService</wsa:Address>
        ```

5.  [Start the BPS server](https://docs.wso2.com/display/AM260/Running+the+Product#RunningtheProduct-Startingtheserver) and log in to its management console ( `https://<Server Host>:9443+<port offset>/carbon` ).

        !!! warning
    If you are using Mac OS with High Sierra, you may encounter following warning when login into the Management console due to a compression issue exists in High Sierra SDK.

    ``` java
        WARN {org.owasp.csrfguard.log.JavaLogger} -  potential cross-site request forgery (CSRF) attack thwarted (user:<anonymous>, ip:xxx.xxx.xx.xx, method:POST, uri:/carbon/admin/login_action.jsp, error:required token is missing from the request)
    ```

    To avoid this issue open `<BPS_HOME>/repository/conf/tomcat/catalina-server.xml` and change the compression="on" to compression="off" in Connector configuration and restart the BPS.


6.  Select **Add** under the **Processes** menu and upload the `<API-M_HOME>/business-processes/user-signup/BPEL/UserSignupApprovalProcess_1.0.0.zip` file to BPS. This is the business process archive file.
    ![](/assets/attachments/103334709/103334710.png)7.  Select **Add** under the **Human Tasks** menu and upload the `<API-M_HOME>/business-processes/user-signup/HumanTask/UserApprovalTask-1.0.0.zip` file to BPS. This is the human task archived file.

#### 
Configuring the API Manager

1.  Open the `<API-M_HOME>/repository/deployment/server/jaggeryapps/admin/site/conf/site.json` file and configure " `workFlowServerURL"` under " `workflows"` to point to the EI/BPS server (e.g. `"workFlowServerURL": "https://localhost:9445/services/"` )

#### Engaging the WS Workflow Executor in the API Manager

First, enable the user signup workflow **.**

1.  Log in to APIM management console ( `https://<Server Host>:9443/carbon` ) and select **Browse** under **Resources** .
    ![](/assets/attachments/103334709/103334713.png)
2.  Go to `/_system/governance/apimgt/applicationdata/workflow-extensions.xml` resource, disable the Simple Workflow Executor and enable WS Workflow Executor. Also specify the service endpoint where the workflow engine is hosted and the credentials required to access the said service via basic authentication (i.e., username/password based authentication).

    ``` html/xml
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
        !!! tip
    **Note** that all workflow process services of the EI/BPS run on port 9765 because you changed its default port (9763) with an offset of 2.


3.  Go to the API Store Web interface and sign up.
    It invokes the signup process and creates a Human Task instance that holds the execution of the BPEL until some action is performed on it.

4.  Note the message that appears if the BPEL is invoked correctly, saying that the request is successfully submitted.

5.  Log in to the Admin Portal ( `https://:9443/admin` ) and approve the user signup task. It resumes the BPEL process and completes the signup process.

6.  Go back to the API Store and see that the user is now registered.

    Whenever a user tries to sign up to the API Store, a request of the following format is sent to the workflow endpoint:

    ``` html/xml
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

    | Element                                            | Description                                                                                                                                                                                                                                                                                     |
    |----------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
    | userName                                           | The user name requested by the user                                                                                                                                                                                                                                                             |
    | `tenantDomain`| Domain to which the user belongs to                                                                                                                                                                                                                                                             |
    | `workflowExternalRef` | The unique reference against which a workflow is tracked. This needs to be sent from the workflow engine to the API Manager at the time of workflow completion.                                                                                                                                 |
    | callBackURL                                        | The URL to which the workflow completion request is sent by the workflow engine, at the time of workflow completion. This property is configured under the `callBackURL` property in the `workflow-extensions.xml registry` file. |


