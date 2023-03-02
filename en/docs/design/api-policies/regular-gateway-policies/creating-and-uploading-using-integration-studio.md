# Creating and Uploading Custom Mediation Policies using WSO2 Integration Studio

You can design all custom mediation policies using a tool such as WSO2 Integration Studio and then store the policy in the registry, which can be later deployed to the Gateway.

Let's see how to create a custom mediation policy using the WSO2 Integration Studio and then deploy and use it in your APIs.
This custom policy adds a full trace log that gets printed when you invoke a particular API deployed in the Gateway.

1. Navigate to the Integration Studio page - <https://wso2.com/integration/integration-studio/>

2. Click **Download** to download the WSO2 Integration Studio based on your preferred platform (i.e., Mac, Windows, Linux).

      *For example, if you are using a Ubuntu 64-bit computer you need to download, WSO2-Integration-Studio-8.1.0-linux-gtk-x86_64.tar.gz.*

3. Extract the downloaded archive of the Integration Studio to the desired location and run the **IntegrationStudio** application to start the tool.

      [![Integration Studio]({{base_path}}/assets/img/learn/api-gateway/message-mediation/integration-studio.png)]({{base_path}}/assets/img/learn/api-gateway/message-mediation/integration-studio.png)

    !!! tip
        To learn more about using WSO2 Integration Studio, see the [WSO2 Integration Studio]({{base_path}}/integrate/develop/wso2-integration-studio/) documentation.

4. Click **Window -> Perspective -> Open Perspective -> Other** to get the Perspective options.
  
      [![Perspective Path]({{base_path}}/assets/img/learn/api-gateway/message-mediation/open-perspective.png)]({{base_path}}/assets/img/learn/api-gateway/message-mediation/open-perspective.png)

5. Select **WSO2 APIManager** from the perspective list and click **Open**.
  
      [![APIM Perspective]({{base_path}}/assets/img/learn/api-gateway/message-mediation/apim-perspective.png)]({{base_path}}/assets/img/learn/api-gateway/message-mediation/apim-perspective.png)

      You will be redirected to the following page.

     [![APIM Perspective View]({{base_path}}/assets/img/learn/api-gateway/message-mediation/apim-perspective-view.png)]({{base_path}}/assets/img/learn/api-gateway/message-mediation/apim-perspective-view.png)

6. Click on the Login icon. 
   
      The Add Registry dialog box appears.
  
     [![Login]({{base_path}}/assets/img/learn/api-gateway/message-mediation/login.png)]({{base_path}}/assets/img/learn/api-gateway/message-mediation/login.png)

7. Enter the URL of the Publisher, Username and Password and click **OK**.

    [![Checkin to register]({{base_path}}/assets/img/learn/api-gateway/message-mediation/checkin.png)]({{base_path}}/assets/img/learn/api-gateway/message-mediation/checkin.png)

8. Locate the path where the sequence needs to be added `(IN/OUT/FAULT)` from the **Registry Tree Browser**.

    [![Locate Path]({{base_path}}/assets/img/learn/api-gateway/message-mediation/registry-path.png)]({{base_path}}/assets/img/learn/api-gateway/message-mediation/registry-path.png)
    
9.  Click **Create** and create a new sequence, provide the sequence name as `newSequence`, and click **Finish**.
  
     [![Create a new sequence]({{base_path}}/assets/img/learn/api-gateway/message-mediation/create-sequence.png)]({{base_path}}/assets/img/learn/api-gateway/message-mediation/create-sequence.png)

     Your sequence now appears on the Integration Studio Editor. 

10. Drag and drop a **Log Mediator** from the **Mediators** section, to your sequence and **Save** the `newSequence.xml` file.

     [![New sequence XML]({{base_path}}/assets/img/learn/api-gateway/message-mediation/newsequence-log-xml.png)]({{base_path}}/assets/img/learn/api-gateway/message-mediation/newsequence-log-xml.png)

11. Right-click on the created mediator, click **Show Properties View**, and enter the following values in the **Log Mediator**.
    
     `Log Level:  Full`

12. Right-click on the sequence file (`newSequence.xml`), and click **Commit file**.
  
     [![push to register]({{base_path}}/assets/img/learn/api-gateway/message-mediation/commit-to-reg.png)]({{base_path}}/assets/img/learn/api-gateway/message-mediation/commit-to-reg.png)

13. Click **Yes** and push the changes into the remote registry.

14. Click **Ok** and acknowledge the successful message popped up.

    [![Success]({{base_path}}/assets/img/learn/api-gateway/message-mediation/success-message.png)]({{base_path}}/assets/img/learn/api-gateway/message-mediation/success-message.png)

15. Navigate to the API Manager Management Console and click **Resources** > **Browser**, under the **Main** section to access the Registry Browser and to verify whether the sequence was added successfully.
    
     [![API Manager Management Console]({{base_path}}/assets/img/learn/api-gateway/message-mediation/mgt-console-reg-browser.png)]({{base_path}}/assets/img/learn/api-gateway/message-mediation/mgt-console-reg-browser.png)
    
16. Sign in to the **API Publisher**. 

17. Click **Create API** and then create a new REST type API.

     For more information, see [Create a REST API]({{base_path}}/design/create-api/create-rest-api/create-a-rest-api/).

18. Click on the created API and click **Runtime Configurations**.

19. Click the Edit icon [![Edit]({{base_path}}/assets/img/learn/api-gateway/message-mediation/edit-button.png)]({{base_path}}/assets/img/learn/api-gateway/message-mediation/edit-button.png) in the **Message Mediation** section under the **Request** sub-menu.  

20. In the **Select a Mediation Policy** pop-up, select **Common Policies**, and then select the newly added sequence (`newSequence`) from the sequence list. Finally, click **Select**.

    [![Select the mediation policy]({{base_path}}/assets/img/learn/api-gateway/message-mediation/select-mediation-policy.png)]({{base_path}}/assets/img/learn/api-gateway/message-mediation/select-mediation-policy.png)

21. If the API is not in `PUBLISHED` state, go to the **Lifecycle** tab, and click `REDEPLOY` to re-publish the API. 

22. Invoke the API using a valid subscription.

     You will see the following trace log in the server logs.

    ``` bash
    [2021-09-28 15:27:30,770]  INFO - LogMediator To: /test/1.0, MessageID: urn:uuid:042a64ab-590a-4128-bd99-ef6974893610, Direction: request, Envelope: <?xml version='1.0' encoding='utf-8'?><soapenv:Envelope xmlns:soapenv="http://www.w3.org/2003/05/soap-envelope"><soapenv:Body/></soapenv:Envelope
    ```
