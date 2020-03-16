# Customizing a Workflow Extension

Each workflow executor in the WSO2 API Manager is inherited from the **`org.wso2.carbon.apimgt.impl.workflow.WorkflowExecutor         `** abstract class, which has the following abstract methods:

-   **`execute          `** : contains the implementation of the workflow execution
-   **`complete          `** : contains the implementation of the workflow completion
-   **`getWorkflowType          `** : abstract method that returns the type of the workflow as a String
-   **`getWorkflowDetails(String workflowStatus          `** : abstract method that returns a list of `WorkflowDTO` objects. This method is not used at the moment and it returns null for the time being.

To customize the default workflow extension, you override the `execute()` and `complete()` methods with your custom implementation. For example, the following class is a sample implementation of the Subscription Creation workflow. It returns an email to an address provided through the configuration on each subscription creation:

``` java
    package org.wso2.sample.workflow;
    import java.util.List;
    import java.util.Properties;
    import javax.mail.Message;
    import javax.mail.MessagingException;
    import javax.mail.PasswordAuthentication;
    import javax.mail.Session;
    import javax.mail.Transport;
    import javax.mail.internet.InternetAddress;
    import javax.mail.internet.MimeMessage;
    import org.wso2.carbon.apimgt.api.APIManagementException;
    import org.wso2.carbon.apimgt.impl.APIConstants;
    import org.wso2.carbon.apimgt.impl.dao.ApiMgtDAO;
    import org.wso2.carbon.apimgt.impl.dto.SubscriptionWorkflowDTO;
    import org.wso2.carbon.apimgt.impl.dto.WorkflowDTO;
    import org.wso2.carbon.apimgt.impl.workflow.WorkflowConstants;
    import org.wso2.carbon.apimgt.impl.workflow.WorkflowException;
    import org.wso2.carbon.apimgt.impl.workflow.WorkflowExecutor;
    import org.wso2.carbon.apimgt.impl.workflow.WorkflowStatus;
    public class SubsCreationEmailSender extends WorkflowExecutor {
        private String adminEmail;
        private String emailAddress;
        private String emailPassword;
        @Override
        public List < WorkflowDTO > getWorkflowDetails(String arg0)
        throws WorkflowException {
            return null;
        }
        @Override
        public String getWorkflowType() {
            return WorkflowConstants.WF_TYPE_AM_SUBSCRIPTION_CREATION;
        }
        @Override
        public WorkflowResponse execute(WorkflowDTO workflowDTO) throws WorkflowException {
            SubscriptionWorkflowDTO subsCreationWFDTO = (SubscriptionWorkflowDTO) workflowDTO;
            Properties props = new Properties();
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.host", "smtp.gmail.com");
            props.put("mail.smtp.port", "587");
            Session session = Session.getInstance(props, new javax.mail.Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(emailAddress, emailPassword);
                }
            });
            try {
                Message message = new MimeMessage(session);
                message.setFrom(new InternetAddress(emailAddress));
                message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(adminEmail));
                message.setSubject("Subscription Creation");
                message.setText("Subscription created for API " + subsCreationWFDTO.getApiName() + " using Application " + subsCreationWFDTO.getApplicationName() + " by user " + subsCreationWFDTO.getSubscriber());
                Transport.send(message);
                System.out.println("Sent email to notify subscription creation");
                //Call the execute method of the parent class. This will create a reference for the
                //workflow execution in the database.
                super.execute(workflowDTO);
                //Set the workflow Status to APPROVED and Immediately complete the workflow since we
                //are not waiting for an external party to complete this.
                workflowDTO.setStatus(WorkflowStatus.APPROVED);
                complete(workflowDTO);
            } catch(MessagingException e) {
                e.printStackTrace();
                throw new WorkflowException(e.getMessage());
            } catch(Exception e) {
                e.printStackTrace();
                throw new WorkflowException(e.getMessage());
            }
            return new GeneralWorkflowResponse();
        }
        @Override
        public WorkflowResponse complete(WorkflowDTO workflowDTO) throws WorkflowException {
            workflowDTO.setUpdatedTime(System.currentTimeMillis());
            super.complete(workflowDTO);
            ApiMgtDAO apiMgtDAO = ApiMgtDAO.getInstance();
            try {
                apiMgtDAO.updateSubscriptionStatus(
                        Integer.parseInt(workflowDTO.getWorkflowReference()), APIConstants.SubscriptionStatus.UNBLOCKED);
            } catch(APIManagementException e) {
                throw new WorkflowException("Could not complete subscription creation workflow", e);
            }
            return new GeneralWorkflowResponse();
            }
        }
        public String getAdminEmail() {
            return adminEmail;
        }
        public void setAdminEmail(String adminEmail) {
            this.adminEmail = adminEmail;
        }
        public String getEmailAddress() {
            return emailAddress;
        }
        public void setEmailAddress(String emailAddress) {
            this.emailAddress = emailAddress;
        }
        public String getEmailPassword() {
            return emailPassword;
        }
        public void setEmailPassword(String emailPassword) {
            this.emailPassword = emailPassword;
        }
    }
```

Note the following regarding the above sample:

-   The **`execute()          `** method takes in a `WorkflowDTO` object ( `SubscriptionWorkflowDTO` class) that contains information about the subscription that is being created.
-   The `adminEmail` , `emailAddress` and `emailPassword` are private String variables with public **`getter          `** and **`setter          `** methods. The values for these variables are populated through the server configuration.
-   After sending the email, a call is made to the super class's **`execute()          `** method in order to create a reference entry in the database. This entry is generally used to look up the workflow when the workflow happens asynchronously (via a human approval).
-   The **`complete()          `** method contains the code to mark the subscription active. Until then, the subscription is in ON\_HOLD state.
-   In this sample, the **`complete()          `** method is called immediately to make the subscription active instantly. If the completion of your workflow happens asynchronously, you must not call the **`complete()          `** method from the **`execute()          `** method.
-   The `WorkflowException` is thrown to roll back the subscription in case of a failure.

!!! info
In a distributed setup, the custom workflows should be deployed in the Developer Portal node.


After the implementation of the class is done, follow the steps below to implement the new workflow extension in the API Manager:

1.  Compile the class and export it as a JAR file. Make sure you have the following JARs in the classpath before compilation.
    -   <API-M_HOME>/repository/components/plugins/org.wso2.carbon.apimgt.impl_6.1.66.jar

    -   <API-M_HOME>/repository/components/plugins/org.wso2.carbon.apimgt.api_6.1.66.jar

    -`javax.mail.jar` : see <https://java.net/projects/javamail/pages/Home> to download the JAR

2.  After exporting the JAR, copy it to `<API-M_HOME>/repository/components/lib` directory.
3.  Log in to APIM management console ( `https://<Server Host>:9443/carbon` ) and select **Browse** under **Resources.**
    **![]({{base_path}}/assets/attachments/103334715/103334716.png)**

4.  Go to the `/_system/governance/apimgt/applicationdata/workflow-extensions.xml` resource, disable the Simple Workflow Executor and enable the WS Workflow Executor. Also specify the service endpoint where the workflow engine is hosted and the credentials required to access the said service via basic authentication (i.e., username/password based authentication). For example:

    ``` xml
        <WorkFlowExtensions>
        ...
            <!--SubscriptionCreation executor="org.wso2.carbon.apimgt.impl.workflow.SubscriptionCreationSimpleWorkflowExecutor"/-->
            <SubscriptionCreation executor="org.wso2.sample.workflow.SubsCreationEmailSender">
               <Property name="adminEmail">to_user@email.com</Property>
               <Property name="emailAddress">from _user@email.com</Property>
               <Property name="emailPassword">from_user_password</Property>
            </SubscriptionCreation>
        ...
        </WorkFlowExtensions>
    ```

    Note that the `adminEmail` , `emailAddress` and `emailPassword` properties will be assigned to the appropriate variables defined in the class through the public **`setter           `** methods of those variables.

!!! note
If you use the same or similar sample to return an email, you must remove the `org.jaggeryjs.hostobjects.email_0.9.0.ALPHA4_wso2v1.jar` file from the `<API-M_HOME>/repository/components/plugins` directory. Removing it results in a `ClassNotFoundException` thrown at server startup, but it does not affect the server's functionality.


