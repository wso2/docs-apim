# Adding an API Subscription Workflow

This section explains how to attach a custom workflow to the API subscription operation in the API Manager. First, see [Workflow Extensions](_Managing_Workflow_Extensions_) for information on different types of workflows executors.

Attaching a custom workflow to API subscription enables you to add throttling tiers to an API that consumers cannot choose at the time of subscribing. Only admins can set these tiers to APIs. When a consumer subscribes to an API, he/she has to subscribe to an application in order to get access to the API. However, when API subscription workflow is enabled, when the consumer subscribes to an application, it initially is in the `On Hold` state, and he/she can not use the API, using its production or sandbox keys, until their subscription is approved.

!!! Note
    You will only need to configure either  **WSO2 EI** or **WSO2 BPS**. The WSO2 API Manager configuration will be common for both.

##Configuring WSO2 EI

!!! tip
    **Before you begin** , if you have changed the API Manager's default user and role, make sure you do the following changes:
    -   Point the database that has the API Manager user permissions to EI.
    -   Share any LDAPs, if exist.
    -   Unzip the `<API-M>/business-processes/subscription-creation/HumanTask/SubscriptionsApprovalTask-1.0.0.zip` file, update the role as follows in the `SubscriptionsApprovalTask.ht` file, and ZIP the `SubscriptionsApprovalTask-1.0.0` folder.

    ``` xml
            <htd:argument name="role">
                [new-role-name]
            </htd:argument>
    ```

1.  Download [WSO2 Enterprise Integrator](https://wso2.com/integration) .
2.  Set an offset of 2 to the default EI port in `<EI_HOME>/conf/carbon.xml` file. This prevents port conflicts that occur when you start more than one WSO2 product on the same server. For more information, see [Changing the Default Ports with Offset](https://docs.wso2.com/display/AM260/Changing+the+Default+Ports+with+Offset) .

    ``` xml
        <Offset>2</Offset>
    ```

    !!! tip
        **Tip** : If you change the EI **port offset to a value other than 2 or run the API Manager and EI on different machines** (therefore, want to set the `hostname` to a different value than `localhost` ), you do the following:

        -   Search and replace the value 9765 in all the files (.epr) inside the `<API-M_HOME>/business-processes` folder with the new port (9763 + port offset.)


3.  Open the `<EI_HOME>/wso2/business-process/conf/humantask.xml` file and `<EI_HOME>/wso2/business-process/conf/b4p-coordination-config.xml` file and set the `TaskCoordinationEnabled` property to true.

    ``` xml
        <TaskCoordinationEnabled>true</TaskCoordinationEnabled>
    ```

4.  Copy the following from `<API-M_HOME>/business-processes/epr` to `<EI_HOME>/wso2/business-process/repository/conf/epr` folder. If the `<EI_HOME>/wso2/business-process/repository/conf/epr` folder isn't there, Create it.

    !!! note
        Make sure to give the correct credentials in the `<EI_HOME>/wso2/business-process/repository/conf/epr` files.


    -   Update the `<API-M_HOME>/business-processes/epr/SubscriptionCallbackService.epr` file according to API Manager.

        ``` java
                <wsa:Address>https://localhost:8243/services/WorkflowCallbackService</wsa:Address>
        ```

    -   Update the `<API-M_HOME>/business-processes/epr/SubscriptionService.epr` file according to EI.

        ``` java
                    <wsa:Address>http://localhost:9765/services/SubscriptionService/ </wsa:Address>
        ```

5.  Start the EI server and sign in to its management console ( `https://<Server Host>:9443+<port offset>/carbon` ).

    !!! warning
        If you are using Mac OS with High Sierra, you may encounter following warning when login into the Management console due to a compression issue exists in High Sierra SDK.

        ``` java
            WARN {org.owasp.csrfguard.log.JavaLogger} -  potential cross-site request forgery (CSRF) attack thwarted (user:<anonymous>, ip:xxx.xxx.xx.xx, method:POST, uri:/carbon/admin/login_action.jsp, error:required token is missing from the request)
        ```

        To avoid this issue open `<EI_HOME>/conf/tomcat/catalina-server.xml` and change the compression="on" to compression="off" in Connector configuration and restart the EI.


6.  Select **Add** under the **Processes** menu and upload the `<API-M_HOME>/business-processes/subscription-creation/BPEL/SubscriptionApprovalWorkFlowProcess_1.0.0.zip` file to EI. This is the business process archive file.
        ![]({{base_path}}/assets/img/learn/learn-subscription-workflow-upload.png)

7.  Select **Add** under the **Human Tasks** menu and upload the `<API-M_HOME>/business-processes/subscription-creation/HumanTask/SubscriptionsApprovalTask-1.0.0.zip` file to EI. This is the human task archived file.


##Configuring WSO2 BPS

!!! tip
    **Before you begin** , if you have changed the API Manager's default user and role, make sure you do the following changes:
    -   Point the database that has the API Manager user permissions to BPS.
    -   Share any LDAPs, if exist.
    -   Unzip the `<API-M>/business-processes/subscription-creation/HumanTask/SubscriptionsApprovalTask-1.0.0.zip` file, update the role as follows in the `SubscriptionsApprovalTask.ht` file, and ZIP the `SubscriptionsApprovalTask-1.0.0` folder.

    ``` xml
        <htd:argument name="role">
            [new-role-name]
        </htd:argument>
    ```

1.  Download [WSO2 Business Process Server](http://wso2.com/products/business-process-server/) .
2.  Set an offset of 2 to the default BPS port in `<BPS_HOME>/repository/conf/carbon.xml` file. This prevents port conflicts that occur when you start more than one WSO2 product on the same server. For more information, see [Changing the Default Ports with Offset](https://docs.wso2.com/display/AM260/Changing+the+Default+Ports+with+Offset) .

    ``` xml
        <Offset>2</Offset>
    ```

    !!! tip
        **Tip** : If you change the BPS **port offset to a value other than 2 or run the API Manager and BPS on different machines** (therefore, want to set the `hostname` to a different value than `localhost` ), you do the following:

        -   Search and replace the value 9765 in all the files (.epr) inside the `<API-M_HOME>/business-processes` folder with the new port (9763 + port offset.)


3.  Open the `<BPS_HOME>/repository/conf/humantask.xm` file and `<BPS_HOME>/repository/conf/b4p-coordination-config.xml` file and set the `TaskCoordinationEnabled` property to true.

    ``` xml
        <TaskCoordinationEnabled>true</TaskCoordinationEnabled>
    ```

4.  Copy the following from `<API-M_HOME>/business-processes/eprto<BPS_HOME>/repository/conf/epr` folder. If the `<BPS_HOME>/repository/conf/epr` folder isn't there, please create it.

    !!! note
        Make sure to give the correct credentials in the `<BPS_HOME>/repository/conf/epr` files.
        
        -   Update the `<API-M_HOME>/business-processes/epr/SubscriptionCallbackService.epr` file according to API Manager.
        ```
        <wsa:Address>https://localhost:8243/services/WorkflowCallbackService</wsa:Address>
        ```

        -   Update the `<API-M_HOME>/business-processes/epr/SubscriptionService.epr` file according to BPS.
        ```
        <wsa:Address>http://localhost:9765/services/SubscriptionService/</wsa:Address>
        ```
5.  Start the BPS server and sign in to its management console ( `https://<Server Host>:9443+<port offset>/carbon` ).

    !!! warning
        If you are using Mac OS with High Sierra, you may encounter following warning when login into the Management console due to a compression issue exists in High Sierra SDK.

        ``` java
            WARN {org.owasp.csrfguard.log.JavaLogger} -  potential cross-site request forgery (CSRF) attack thwarted (user:<anonymous>, ip:xxx.xxx.xx.xx, method:POST, uri:/carbon/admin/login_action.jsp, error:required token is missing from the request)
        ```

        To avoid this issue open `<BPS_HOME>/repository/conf/tomcat/catalina-server.xml` and change the compression="on" to compression="off" in Connector configuration and restart the BPS.


6.  Select **Add** under the **Processes** menu and upload the 
`<API-M_HOME>/business-processes/subscription-creation/BPEL/SubscriptionApprovalWorkFlowProcess_1.0.0.zip` 
file to BPS. This is the business process archive file.
    ![]({{base_path}}/assets/img/learn/learn-subscription-workflow-upload.png)

7.  Select **Add** under the **Human Tasks** menu and upload the `<API-M_HOME>/business-processes/subscription-creation/HumanTask/SubscriptionsApprovalTask-1.0.0.zip` file to BPS. This is the human task archived file.

## Configuring the API Manager

Open the `<API-M_HOME>/repository/deployment/server/jaggeryapps/admin/site/conf/site.json` file and configure " `workFlowServerURL"` under " `workflows"` to point to the EI/BPS server (e.g. `"workFlowServerURL": "                   https://localhost:9445/services/                  "` )

#### Engaging the WS Workflow Executor in the API Manager

First, enable the API subscription workflow **.**

1.  Sign in to API Manager Management Console ( `https://<Server Host>:9443/carbon` ) and select **Browse** under **Resources** .

    ![]({{base_path}}/assets/img/learn/learn-subscription-workflow-browse.png)

2.  Go to the `/_system/governance/apimgt/applicationdata/workflow-extensions.xml` resource, disable the Simple Workflow Executor and enable WS Workflow Executor. Also specify the service endpoint where the workflow engine is hosted and the credentials required to access the said service via basic authentication (i.e., username/password based authentication).

    ``` 
        <WorkFlowExtensions>
        ...
            <SubscriptionCreation executor="org.wso2.carbon.apimgt.impl.workflow.SubscriptionCreationWSWorkflowExecutor">
                 <Property name="serviceEndpoint">http://localhost:9765/services/SubscriptionApprovalWorkFlowProcess/</Property>
                 <Property name="username">admin</Property>
                 <Property name="password">admin</Property>
                 <Property name="callbackURL">https://localhost:8243/services/WorkflowCallbackService</Property>
            </SubscriptionCreation>
        ...
    </WorkFlowExtensions>
    ```

    !!! tip
        **Note** that all workflow process services of the EI/BPS run on port 9765 because you changed its default port (9763) with an offset of 2.


        The application creation WS Workflow Executor is now engaged.


3.  Go to the API Devportal credentials page and subscribe to an API. It will trigger the API subscription process and create a Human Task instance that pauses the execution of the BPEL until some action is performed on it. After subscribing you will see the subscription status as ON_HOLD

     ![]({{base_path}}/assets/img/learn/workflow-subscription-onhold.png)

4.  Sign in to the Admin Portal ( `https://<Server Host>:9443/admin` ), list all the tasks for API subscription and click on start to approve the task. It resumes the BPEL process and completes the subscription process.

    ![]({{base_path}}/assets/img/learn/workflow-subscription-admin-entry.png)

    After approving go back to the API Devportal credentials page, the application status will be UNBLOCKED
     
    ![]({{base_path}}/assets/img/learn/workflow-subscription-complete.png)

5.  Go back to the API Devportal and see that the user is now subscribed to the API.

    Whenever a user tries to subscribe to an API, a request of the following format is sent to the workflow endpoint:

    ```
        <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"xmlns:wor="http://workflow.subscription.apimgt.carbon.wso2.org">
           <soapenv:Header/>
           <soapenv:Body>
              <wor:createSubscription>
                 <wor:apiName>sampleAPI</wor:apiName>
                 <wor:apiVersion>1.0.0</wor:apiVersion>
                 <wor:apiContext>/sample</wor:apiContext>
                 <wor:apiProvider>admin</wor:apiProvider>
                 <wor:subscriber>subscriber1</wor:subscriber>
                 <wor:applicationName>application1</wor:applicationName>
                 <wor:tierName>gold</wor:tierName>
                 <wor:workflowExternalRef></wor:workflowExternalRef>
                 <wor:callBackURL>?</wor:callBackURL>
              </wor:createSubscription>
           </soapenv:Body>
        </soapenv:Envelope>
    ```

    Elements of the above configuration are described below:

    | Element                                            | Description                                                                                                                                                                                                                                                                                     |
    |----------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
    | apiName                                            | Name of the API to which subscription is requested.                                                                                                                                                                                                                                             |
    | apiVersion                                         | Version of the API the user subscribes to.                                                                                                                                                                                                                                                      |
    | apiContext                                         | Context in which the requested API is to be accessed.                                                                                                                                                                                                                                           |
    | apiProvider                                        | Provider of the API.                                                                                                                                                                                                                                                                            |
    | subscriber                                         | Name of the user requesting subscription.                                                                                                                                                                                                                                                       |
    | applicationName                                    | Name of the application through which the user subscribes to the API.                                                                                                                                                                                                                           |
    | tierName                                           | Throttling tiers specified for the application.                                                                                                                                                                                                                                                 |
    | `workflowExternalRef` | The unique reference against which a workflow is tracked. This needs to be sent back from the workflow engine to the API Manager at the time of workflow completion.                                                                                                                            |
    | callBackURL                                        | The URL to which the Workflow completion request is sent to by the workflow engine, at the time of workflow completion. This property is configured in the `<callBackURL>` element in the `workflow-extensions.xml` registry file |


