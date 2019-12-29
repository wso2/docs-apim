# Creating and Uploading using WSO2 Integration Studio

From APIM-3.0.0 onwards you can design all custom mediation policies using a tool such as the WSO2 Integration Studio 
and then store the policy in the Gateway's registry.

Let's see how to create a custom mediation policy using the WSO2 Integration Studio and then deploy and use it in your APIs.
This custom policy adds a full trace log which is getting printed when you invoke a particular API deployed in the Gateway.

1.  Navigate to the Integration Studio page - <https://wso2.com/integration/integration-studio/>
2.  Click **Download** button according to your preferred platform (i.e., Mac, Windows, Linux).  
*For example if you are using ubuntu 64 bit computer you need to download, WSO2-Integration-Studio-7.0.0-linux-gtk-x86_64.tar.gz.*
3.  Extract the downloaded archive of the Integration Studio to the desired location and run the IntegrationStudio application to start the tool.

    ![]({{base_path}}/assets/img/Learn/integration-studio.png)


    !!! tip
        To learn more about using WSO2 Integration Studio, visit [here](https://ei.docs.wso2.com/en/latest/micro-integrator/develop/WSO2-Integration-Studio/).

4.  Click **ESB Project -> Create New** to create a new ESB Solution Project.
  
    ![]({{base_path}}/assets/img/Learn/esb-solution-project.png)

5.  Provide **Project Name** as `TestProject` and click **Finish**. Then you will be redirected to the following page.
  
    ![]({{base_path}}/assets/img/Learn/composite-app-pom.png)

6.  Navigate to the directory path **TestProject -> src -> main -> synapse-config -> sequences** in **Project Explorer** 
window.
  
    ![]({{base_path}}/assets/img/Learn/sequences.png)

7.  Right-Click on **sequences** directory and go to **New -> Sequence** to create a new sequence.  
    If you want to import existing sequence proceed with **Import Sequence** option.
  
    ![]({{base_path}}/assets/img/Learn/create-new-sequence.png)

8.  Create new sequence and provide sequence name `newSequence` and click **Finish**.
  
    ![]({{base_path}}/assets/img/Learn/create-new-sequence-2.png)

9.  Your sequence now appears on the Integration Studio console.   
    From under the **Mediators** section, drag and drop a **Log Mediator** to your sequence and give the following values 
    to the **Log Mediator** and **Save** the file `newSequence.xml`.

    `Log Category: INFO`  
    `Log Level:  Full`   
  
    ![]({{base_path}}/assets/img/Learn/newsequence-xml.png)

10. Right click the sequence file `newSequence.xml`, and goto **WSO2 registry -> Check in to WSO2 Registry**. You will be
prompted with the following dialog box.
  
    ![]({{base_path}}/assets/img/Learn/check-in-to-reg.png)

11. On the dialog box that appears, enter the URL of the `WSO2 Publisher Portal` and click the Right top icon to open the **Registry Tree Browser**. 

12. From **Registry Tree Browser**, locate the path where the sequence is needed to be added `(IN/OUT/FAULT)`.  
  
    ![]({{base_path}}/assets/img/Learn/reg-browser.png)

13. Then click **OK** and **CheckIn**.

14. After that you can check **Registry Browser** in **WSO2 Management Console** to verify whether the sequence is successfully added.
    
    ![]({{base_path}}/assets/img/Learn/mgt-console-reg-browser.png)
    
15. Log in to the **API Publisher Portal**. 

16. Click **CREATE API** and then **Design a new REST API** to create an API by following the steps in .

17. Go to the created API and from the Left Menu, go to **Runtime Configurations**.

18. Select Edit option in the **Message Mediation** section under **Request** menu.   
    *You can do this for Request, Response and/or Fault message flows.*

    ![]({{base_path}}/assets/img/Learn/select-mediation-policy.png)

    ![]({{base_path}}/assets/img/Learn/test-api.png)

19. In the Select a Mediation Policy popup, select **Common Policies** and select the newly added `newSequence` from the 
sequence list. Then, click **Select**.


20. Finally, save the API and change the lifecycle to `Published` state or redeploy the API from **LifeCycle** left menu. 

21. When you invoke the API using a valid subscription, you can see the following trace log in the server logs.

    ``` bash
    [2019-12-19 13:55:11,887]  INFO - LogMediator TRACE = API Mediation Policy
    ```