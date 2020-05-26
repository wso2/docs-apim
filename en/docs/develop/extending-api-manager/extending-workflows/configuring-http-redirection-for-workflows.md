# Configuring HTTP Redirection for Workflows

This section walks you through how to redirect to a third party entity using the redirect URL as part of a custom workflow extension. For example, consider an API Manager user publishes an API and wants to make that API a chargeable API. If there are no payment details of the subscriber, that subscriber is forwarded to a third party entity that handles the payment detail collection etc.

-   [Writing the custom workflow executor](#writing-the-custom-workflow-executor)
-   [Deploying the custom workflow executor](#deploying-the-custom-workflow-executor)
-   [Using the workflow](#using-the-workflow)
-   [Invoking the API Manager](#invoking-the-api-manager)

Each workflow executor in the WSO2 API Manager is inherited from the **`org.wso2.carbon.apimgt.impl.workflow.WorkflowExecutor         `** abstract class, which has the following abstract methods:

-   **`execute          `** : contains the implementation of the workflow execution
-   **`complete          `** : contains the implementation of the workflow completion
-   **`getWorkflowType          `** : abstract method that returns the type of the workflow as a String
-   **`getWorkflowDetails(String workflowStatus)          `** : abstract method that returns a list of `WorkflowDTO` objects. This method is not used at the moment and it returns null for the time being.

To customize the default workflow extension, you override the **`execute()         `** and **`complete()         `** methods with your custom implementation.

### Writing the custom workflow executor

1.  Extend the **`WorkflowExecutor          `** class found in the **`org.wso2.carbon.apimgt.impl.workflow          `** package.
2.  Upon extension of the **`WorkflowExecutor          `** class, override the **`complete()          `** and **`execute()          `** methods.
3.  The **`execute()          `** method is the first method called by API Manager. Call the **`super.execute          `** method inside the `execute()` method to add the workflow entry to the database.
4.  In the **`execute()`** method define the callback URL, RedirectUrl, workflowRefId, and RedirectConfirmationMsg. The callback URL should ideally be an open endpoint accepting workflow reference ID as a parameter. Once the endpoint is invoked, it should in-turn invoke the Admin REST APIs callback method ({{base_path}}/develop/product-apis/admin-v1/#/Workflows%20(Individual)/post_workflows_update_workflow_status). Note that the Admin REST API resources require authentication before invocation.
                                                                                      httpworkflowResponse.setRedirectConfirmationMsg
5.  Create a response of type **`WorkflowResponse           `** . For HTTP responses, WSO2 API Manager has an inbuilt object named **`HttpWorkflowResponse           `** found at `org.wso2.carbon.apimgt.api.WorkflowResponse` . When creating the HTTP workflow response object, specify the additional parameters and the redirect URL. The usage of these parameters are listed below.

    <table>
    <colgroup>
    <col width="33%" />
    <col width="33%" />
    <col width="33%" />
    </colgroup>
    <thead>
    <tr class="header">
    <th><p>Parameter</p></th>
    <th><p>Mandatory</p></th>
    <th><p>Description</p></th>
    </tr>
    </thead>
    <tbody>
    <tr class="odd">
    <td><p>Redirect URL</p></td>
    <td><p>Yes</p></td>
    <td><p>The URL that API Manager will redirect the user to upon workflow execution.</p></td>
    </tr>
    <tr class="even">
    <td>Redirect Confirmation Message</td>
    <td>No</td>
    <td>A redirection notification can be specified for a notification to appear at the point of redirecting. By default, this is set to a null value so the text must be specified in order for the notification to appear.</td>
    </tr>
    <tr class="odd">
    <td><p>Additional Parameters</p></td>
    <td><p>Yes</p></td>
    <td><p>If you need to redirect back to the API Manager, call the workflow call back service to complete the workflow. To invoke this service, set the callback URL and the workflow reference ID in the additional parameters. These parameters are sent to the third party entity by query parameters.</p></td>
    </tr>
    </tbody>
    </table>

6.  Implement the **`complete()           `** method, which the third party entity invokes to complete the workflow. Update the workflow status with the workflow status received by the third party entity.

7.  A sample implementation of a custom workflow executor is shown below:

    ``` java
        package org.wso2.sample.workflow;
        /*
        *  Copyright (c) 2015, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
        *
        *  WSO2 Inc. licenses this file to you under the Apache License,
        *  Version 2.0 (the "License"); you may not use this file except
        *  in compliance with the License.
        *  You may obtain a copy of the License at
        *
        *    ttp://www.apache.org/licenses/LICENSE-2.0
        *
        * Unless required by applicable law or agreed to in writing,
        * software distributed under the License is distributed on an
        * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
        * KIND, either express or implied.  See the License for the
        * specific language governing permissions and limitations
        * under the License.
        */
    import org.wso2.carbon.apimgt.api.APIManagementException;
    import org.wso2.carbon.apimgt.api.WorkflowResponse;
    import org.wso2.carbon.apimgt.impl.APIConstants;
    import org.wso2.carbon.apimgt.impl.dao.ApiMgtDAO;
    import org.wso2.carbon.apimgt.impl.dto.WorkflowDTO;
    import org.wso2.carbon.apimgt.impl.workflow.*;

    import java.util.List;

    /**
    * The lib class
    */
    public class SubscriptionCreationSampleWorkflowExecutor extends WorkflowExecutor {



       @Override
       public String getWorkflowType() {
           return WorkflowConstants.WF_TYPE_AM_SUBSCRIPTION_CREATION;
       }

       @Override
       public List<WorkflowDTO> getWorkflowDetails(String workflowStatus) throws WorkflowException {
           return null;
       }
       /**
        * This method executes subscription creation simple workflow and return workflow response back to the caller
        *
        * @param workflowDTO  The WorkflowDTO which contains workflow contextual information related to the workflow

        * @return workflow response back to the caller
        * @throws WorkflowException Thrown when the workflow execution was not fully performed
        */
       @Override
       public WorkflowResponse execute(WorkflowDTO workflowDTO) throws WorkflowException {
           super.execute(workflowDTO);

           HttpWorkflowResponse httpworkflowResponse = new HttpWorkflowResponse();
           httpworkflowResponse.setRedirectUrl("http://google.lk");
           httpworkflowResponse.setAdditionalParameters("CallbackUrl", "");
           httpworkflowResponse.setAdditionalParameters("workflowRefId" , workflowDTO.getExternalWorkflowReference());
           httpworkflowResponse.setRedirectConfirmationMsg("you will be redirected to http://google.lk");
           return httpworkflowResponse;

       }

       /**
        * This method completes subscription creation simple workflow and return workflow response back to the caller
        *
        * @param workflowDTO  The WorkflowDTO which contains workflow contextual information related to the workflow
        * @return workflow response back to the caller
        * @throws WorkflowException
        */
       @Override
       public WorkflowResponse complete(WorkflowDTO workflowDTO) throws WorkflowException {
           workflowDTO.setUpdatedTime(System.currentTimeMillis());
           super.complete(workflowDTO);
           log.info("Subscription Creation [Complete] Workflow Invoked. Workflow ID : " + workflowDTO.getExternalWorkflowReference() + "Workflow State : "+ workflowDTO.getStatus());
           ApiMgtDAO apiMgtDAO = new ApiMgtDAO();
           if(WorkflowStatus.APPROVED.equals(workflowDTO.getStatus())){
             try {
                   apiMgtDAO.updateSubscriptionStatus(Integer.parseInt(workflowDTO.getWorkflowReference()),
                           APIConstants.SubscriptionStatus.UNBLOCKED);
               } catch (APIManagementException e) {
                   log.error("Could not complete subscription creation workflow", e);
                   throw new WorkflowException("Could not complete subscription creation workflow", e);
               }
           }else if(WorkflowStatus.REJECTED.equals(workflowDTO.getStatus())){
               try {
                   apiMgtDAO.updateSubscriptionStatus(Integer.parseInt(workflowDTO.getWorkflowReference()),
                           APIConstants.SubscriptionStatus.REJECTED);
               } catch (APIManagementException e) {
                   log.error("Could not complete subscription creation workflow", e);
                   throw new WorkflowException("Could not complete subscription creation workflow", e);
               }
           }
          return new GeneralWorkflowResponse();

       }
    }
    ```
### Deploying the custom workflow executor

1.  Once you have written the custom workflow executor, compile it to a `.jar` file.
2.  Place the `.jar` file in the `<APIM_HOME>/repository/components/lib` directory and restart the server.

### Using the workflow

1.  Log in to API Manager Management Console ( `https://<Server Host>:9443/carbon` ) and select **Browse** under **Resources** .
2.  Navigate to the `/_system/governance/apimgt/applicationdata/workflow-extensions.xml` resource and disable the simple workflow executor.
3.  Add and enable the implemented executor.
4.  Specify the service endpoint where the workflow engine is hosted and the credentials required to access the service, via basic authentication (i.e., username/password based authentication).
5.  An example configuration is shown below:

    ``` xml
        <WorkFlowExtensions>
        ...
            <SubscriptionCreation executor="org.wso2.sample.workflow.SubscriptionCreationSampleWorkflowExecutor">
         </SubscriptionCreation>
        ...
        </WorkFlowExtensions>
    ```

### Invoking the API Manager

To invoke the API Manager from a third party entity, see [Invoking the API Manager from the BPEL Engine](invoking-the-api-manager-from-the-bpel-engine) .
