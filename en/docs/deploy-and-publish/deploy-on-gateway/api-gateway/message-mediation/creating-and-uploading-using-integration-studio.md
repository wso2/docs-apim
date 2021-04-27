# Creating and Uploading using WSO2 Integration Studio

You can design all custom mediation policies using a tool such as WSO2 Integration Studio and then store the policy in the registry which can be later deployed to the Gateway.

Let's see how to create a custom mediation policy using the WSO2 Integration Studio and then deploy and use it in your APIs.
This custom policy adds a full trace log that gets printed when you invoke a particular API deployed in the Gateway.

1. Navigate to the Integration Studio page - <https://wso2.com/integration/integration-studio/>
2. Click **Download** to download the WSO2 Integration Studio based on your preferred platform (i.e., Mac, Windows, Linux).  
     *For example, if you are using a Ubuntu 64 bit computer you need to download, WSO2-Integration-Studio-7.1.0-linux-gtk-x86_64.tar.gz.*
3. Extract the downloaded archive of the Integration Studio to the desired location and run the **IntegrationStudio** application to start the tool.

    [![Integration Studio]({{base_path}}/assets/img/learn/api-gateway/message-mediation/integration-studio.png)]({{base_path}}/assets/img/learn/api-gateway/message-mediation/integration-studio.png)


    !!! tip
        To learn more about using WSO2 Integration Studio, see the [WSO2 Integration Studio](https://ei.docs.wso2.com/en/latest/micro-integrator/develop/WSO2-Integration-Studio/ documentation.

4. Click **ESB Project -> Create New** to create a new ESB solution project.
  
     [![Integration Project]({{base_path}}/assets/img/learn/api-gateway/message-mediation/integration-project.png)]({{base_path}}/assets/img/learn/api-gateway/message-mediation/integration-project.png)

5. Enter the **Project Name** as `TestProject` and click **Finish**. 

     You will be redirected to the following page.
  
     [![Composite App POM]({{base_path}}/assets/img/learn/api-gateway/message-mediation/composite-app-pom.png)]({{base_path}}/assets/img/learn/api-gateway/message-mediation/composite-app-pom.png)

6. Navigate to the directory path **TestProject -> TestProjectConfigs -> src -> main -> synapse-config -> sequences** in the **Project Explorer** 
window.
  
     [![Sequences]({{base_path}}/assets/img/learn/api-gateway/message-mediation/sequences.png)]({{base_path}}/assets/img/learn/api-gateway/message-mediation/sequences.png)

7. Right-click on the **sequences** directory and go to **New -> Sequence** to create a new sequence.  
    
     If you want to import an existing sequence, proceed with the **Import Sequence** option.
  
     [![Create a new sequence]({{base_path}}/assets/img/learn/api-gateway/message-mediation/create-new-sequence.png)]({{base_path}}/assets/img/learn/api-gateway/message-mediation/create-new-sequence.png)

8. Create a new sequence, provide the sequence name as `newSequence`, and click **Finish**.
  
     [![Create a new sequence]({{base_path}}/assets/img/learn/api-gateway/message-mediation/create-new-sequence-2.png)]({{base_path}}/assets/img/learn/api-gateway/message-mediation/create-new-sequence-2.png)

     Your sequence now appears on the Integration Studio console. 

9. Drag and drop a **Log Mediator** from the **Mediators** section, to your sequence and **Save** the `newSequence.xml` file.

     [![New sequence XML]({{base_path}}/assets/img/learn/api-gateway/message-mediation/newsequence-xml.png)]({{base_path}}/assets/img/learn/api-gateway/message-mediation/newsequence-xml.png)

10. Right-click on the created mediator, click **Show Properties View**, and enter the following values in the **Log Mediator**.
    
     `Log Level:  Full`
    
     [![Add sequence properties]({{base_path}}/assets/img/learn/api-gateway/message-mediation/add-sequence-properties.png)]({{base_path}}/assets/img/learn/api-gateway/message-mediation/add-sequence-properties.png)
  
11. Right-click on the sequence file (`newSequence.xml`), and go to **WSO2 registry -> Check in to WSO2 Registry**. 

     You will be prompted with the following dialog box.
  
     [![checkin to register]({{base_path}}/assets/img/learn/api-gateway/message-mediation/check-in-to-reg.png)]({{base_path}}/assets/img/learn/api-gateway/message-mediation/check-in-to-reg.png)

12. Enter the URL of the Publisher on the dialog box that appears. Click on the icon that appears on the right-top to open the **Registry Tree Browser**. 

13. Locate the path where the sequence needs to be added `(IN/OUT/FAULT)` from the **Registry Tree Browser**.  
  
     [![]({{base_path}}/assets/img/learn/api-gateway/message-mediation/reg-browser.png)]({{base_path}}/assets/img/learn/api-gateway/message-mediation/reg-browser.png)

14. Click **OK** and **Checkin**.

15. Navigate to the API Manager Management Console and click **Registry Browser** to verify whether the sequence was added successfully.
    
     [![API Manager Management Console]({{base_path}}/assets/img/learn/api-gateway/message-mediation/mgt-console-reg-browser.png)]({{base_path}}/assets/img/learn/api-gateway/message-mediation/mgt-console-reg-browser.png)
    
16. Sign in to the **API Publisher**. 

17. Click **CREATE API** and then design a new REST API to create an API.

     For more information, see [Create a REST API]({{base_path}}/design/create-api/create-rest-api/create-a-rest-api/).

18. Click on the created API and click **Runtime Configurations**.

19. Click the Edit icon [![Edit]({{base_path}}/assets/img/learn/api-gateway/message-mediation/edit-button.png)]({{base_path}}/assets/img/learn/api-gateway/message-mediation/edit-button.png) in the **Message Mediation** section under the **Request** sub-menu.  

20. In the **Select a Mediation Policy** pop-up, select **Common Policies**, and then select the newly added sequence (`newSequence`) from the sequence list. Finally, click **Select**.

    [![Select the mediation policy]({{base_path}}/assets/img/learn/api-gateway/message-mediation/select-mediation-policy.png)]({{base_path}}/assets/img/learn/api-gateway/message-mediation/select-mediation-policy.png)

21. If the API is not in `PUBLISHED` state, go to the **Lifecycle** tab, and click `REDEPLOY` to re-publish the API. 

22. Invoke the API using a valid subscription.

     You will see the following trace log in the server logs.

    ``` bash
    [2019-12-19 15:27:30,770]  INFO - LogMediator To: /test/1.0, MessageID: urn:uuid:042a64ab-590a-4128-bd99-ef6974893610, Direction: request, Envelope: <?xml version='1.0' encoding='utf-8'?><soapenv:Envelope xmlns:soapenv="http://www.w3.org/2003/05/soap-envelope"><soapenv:Body/></soapenv:Envelope
    ```
 
