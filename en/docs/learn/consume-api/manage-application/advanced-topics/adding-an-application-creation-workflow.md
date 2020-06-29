# Adding an Application Creation Workflow

This section explains as to how you can attach a custom workflow to the application creation operation in WSO2 API Manager (WSO2 API-M).

Attaching a custom workflow to application creation allows you to control the creation of applications within the Developer Portal by allowing to approve or reject the request for application creation. An application is the entity that holds a set of subscribed  API's that would be accessed by a authorization key specified for that particular application. Therefore, controlling the creation of these applications would be a decision based on the organization's requirements. 

Example usecase:

-   Review the information that corresponds to an application by a specific reviewer before the application is created.
-   The application creation would be offered as a paid service.
-   The application creation should be allowed only to users who are in a specific role.


## Engage the Approval Workflow Executor in API Manager

First enable the approve workflow executor for application creation.

1.  Sign in to WSO2 API-M Management Console (`https://<Server-Host>:9443/carbon`).

2. Click **Main** --> **Resources** --> **Browse**.

    <a href="{{base_path}}/assets/img/learn/wf-extensions-browse.png"><img src="{{base_path}}/assets/img/learn/wf-extensions-browse.png" width="250" height="100"/></a>
    
3.  Go to the `/_system/governance/apimgt/applicationdata/workflow-extensions.xml` resource, disable the Simple Workflow Executor, and enable **Approval Workflow Executor** for application creation.

    ``` xml
    <WorkFlowExtensions>
        <!--ApplicationCreation executor="org.wso2.carbon.apimgt.impl.workflow.ApplicationCreationSimpleWorkflowExecutor"-->
        <ApplicationCreation executor="org.wso2.carbon.apimgt.impl.workflow.ApplicationCreationApprovalWorkflowExecutor">
    </WorkFlowExtensions>
    ```

    The application creation Approve Workflow Executor is now engaged.

4.  Create an application via the Developer Portal.
    
    1. Sign in to the Developer Portal.

         (`https://localhost:9443/devportal`)

    2. Click **Applications** --> **ADD NEW APPLICATION** and create a new application.
                  
         Note that the **Status** field of the application states **INACTIVE** (Waiting for approval)

         [![Application status is INACTIVE - Waiting for approval]({{base_path}}/assets/img/learn/application-creation-inactive.png) ]({{base_path}}/assets/img/learn/application-creation-inactive.png)

4.  Sign in to the Admin Portal (`https://localhost:9443/admin`), list all the tasks for application creation  from **Tasks** --> **Application Creation** and approve or reject the task. 
     
     [![Approve tasks]({{base_path}}/assets/img/learn/application-creation-pending-request.png)]({{base_path}}/assets/img/learn/application-creation-pending-request.png)


5.  Go back to the **Applications** page in the WSO2 Developer Portal and see the created application.

    Check whether the status is updated to **ACTIVE** or **REJECTED**.

    Elements of the above configuration are described below:

    | Element                                                           | Description                                                                                                                                                                                                                       |
    |-------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
    | applicationName                                                   | Name of the application the user creates.                                                                                                                                                                                         |
    | applicationTier                                                   | Throttling tier of the application.                                                                                                                                                                                               |
    | applicationCallbackUrl                                            | When the OAuth2 Authorization Code grant type is applied, this is the endpoint on which the callback needs to happen after the user is authenticated. This is an attribute of the actual application registered on the Developer Portal. |
    | applicationDescription                                            | Description of the application                                                                                                                                                                                                    |
    | tenantDomain                                                      | Tenant domain associated with the application (domain of the user creating the application).                                                                                                                                      |
    | userName                                                          | Username of the user creating the application.                                                                                                                                                                                    |
    | `workflowExternalRef` | The unique reference against which a workflow is tracked. This needs to be sent back from the workflow engine to the API Manager at the time of workflow completion.                                                              |
    | callBackURL                                                       | This property is configured in the `<callBackURL>` element in the `workflow-extensions.xml` registry file.                                                          |


