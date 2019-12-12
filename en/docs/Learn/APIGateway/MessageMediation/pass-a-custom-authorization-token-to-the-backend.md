# Pass a Custom Authorization Token to the Backend

!!! note
    
    This tutorial uses the WSO2 API Manager Tooling Plug-in .


When you send an API request to the backend, you pass a token in the Authorization header of the request. The API Gateway uses this token to authorize access, and then drops it from the outgoing message.  If you wish to use a different (or a custom generated) authorization token than the application generated access token, you can use it as a token exchange mechanism in mediation logic of the API. In this tutorial, we explain how to pass a custom authorization token that is different to the authorization token generated for the application.

**In this tutorial** , you have a sample JAX-RS backend and it always expects 1234 as the authorization token. In your API request, you pass the token that is generated in the `Authorization` header, and 1234 in a `Custom` header. The mediation extension you write extracts the value of the `Custom` header, and sets it as the `Authorization` header before sending it to the backend.

Here's a summary:

`Client (headers: Authorization, custom) -> Gateway (drop: Authorization, convert: custom->Authorization) -> Backend                     `

Let's get started.

1.  Download and install the WSO2 API Manager Tooling Plug-in if you have not done so already. Open Eclipse by double clicking the `Eclipse.app` file inside the downloaded folder.

2.  Click **Window &gt; Open Perspective &gt; Other** to open the Eclipse perspective selection window. Alternatively, click the **Open Perspective** icon shown below at the top right corner.

    [![](../../../assets/img/Learn/eclipse-open-perspective.png)](../../../assets/img/Learn/eclipse-open-perspective.png)

3.  On the dialog box that appears, click **WSO2 APIManager** and click **OK** .
    [![](../../../assets/img/Learn/eclipse-open-apim.png)](../../../assets/img/Learn/eclipse-open-apim.png)
4.  On the APIM perspective, click the **Login** icon as shown below.
    [![](../../../assets/img/Learn/eclipse-login.png)](../../../assets/img/Learn/eclipse-login.png)
5.  On the dialog box that appears, enter the URL, username and password (by default `admin` ) of the Publisher server.
    [![](../../../assets/img/Learn/eclipse-login-to-apim-registry.png)](../../../assets/img/Learn/eclipse-login-to-apim-registry.png)
6.  On the tree view that appears, expand the folder structure of the existing API.
7.  Right-click on the `in` sequence folder and click **Create** to create a new `in` sequence.
    [![](../../../assets/img/Learn/eclipse-create-in-seq.png)](../../../assets/img/Learn/eclipse-create-in-seq.png)
8.  Name the sequence `TokenExchange`.
    [![](../../../assets/img/Learn/token-exchange-seq.png)](../../../assets/img/Learn/token-exchange-seq.png)

9.  Your sequence now appears on the APIM perspective. From under the **Mediators** section, drag and drop a **Property** mediator to your sequence and give the following values to the mediator.

        !!! tip
    **Tip** : The **Property Mediator** has no direct impact on a message, but rather on the message context flowing through [Synapse](https://docs.wso2.com/display/EI611/Synapse+Configuration+Reference) . For more information, see [Property Mediator](https://docs.wso2.com/display/EI650/Property+Mediator) in the WSO2 EI documentation.


    The following property mediator is used to assign the Custom transport level property to another property called **Custom**.

    |                   |                                     |
    |-------------------|-------------------------------------|
    | Property Name     | New Property                        |
    | New Property Name | Custom                              |
    | Value Type        | EXPRESSION                          |
    | Value Expression  | get-property('transport', 'Custom') |

    [![](../../../assets/img/Learn/eclipse-token-exchange-property.png)](../../../assets/img/Learn/eclipse-token-exchange-property.png)

10. Similarly, add another **Property** mediator to your sequence and give the following values to the mediator. This property mediator is used to construct a transport level property called **Authorization** and assign itself the value of the Custom property created above.

    |                   |                        |
    |-------------------|------------------------|
    | Property Name     | New Property           |
    | New Property Name | Authorization          |
    | Value Type        | EXPRESSION             |
    | Value Expression  | get-property('Custom') |
    | Property Scope    | transport              |

    [![](../../../assets/img/Learn/eclipse-token-exchange-property.png)](../../../assets/img/Learn/eclipse-token-exchange-property.png)

11. Add a third **Property** mediator to your sequence and give the following values to the mediator. This property mediator is used to remove the **Custom** property from the transport level.

    |                   |              |
    |-------------------|--------------|
    | Property Name     | New Property |
    | New Property Name | Custom       |
    | Property Action   | remove       |
    | Property Scope    | transport    |

    [![](../../../assets/img/Learn/eclipse-token-exchange-property.png)](../../../assets/img/Learn/eclipse-token-exchange-property.png)

12. Save the sequence.

13. Right-click on the sequence and click **Commit File** to push the changes to the Publisher server.
    ![](/assets/img/Learn/eclipse-commit-file.png)

    Let's create a new API and engage the sequence you created to it.

14. Log in to the API Publisher, Create a new REST API with the information given in the table below.

    | Field         | Sample value         |
    |---------------|----------------------|
    | Name          | TestCustomHeader     |
    | Context       | /testcustomheader               |
    | Version       | 1.0.0                |
    | Business Plan | Gold                 |

    ![](../../../assets/img/Learn/test-custom-header-api.png)

15. Go to the **Resources** tab, and note wildcard resource (/\*) has already been added.
    ![](../../../assets/img/Learn/test-custom-header-resources.png)
16. The **Endpoints** tab. give the information in the table below to add producti0on and sandbox endpoints.

    | Field               | Sample value                                                                                                                                                       |
    |---------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------|
    | Endpoint type       | HTTP/REST endpoint                                                                                                                                                      |
    | Production endpoint | `http://wso2cloud-custom-auth-header-sample-1-0-0.wso2apps.com/custom-auth-header/validate-header` |
    | Sandbox endpoint    | `http://wso2cloud-custom-auth-header-sample-1-0-0.wso2apps.com/custom-auth-header/validate-header`|

    ![](../../../assets/img/Learn/add-rest-endpoint.png)

    ![](../../../assets/img/Learn/test-custom-header-api-endpoints.png)

17. Navigate to the **Runtime Configurations** tab, enable the `Message Mediation` in Request flow. Engage the `In` sequence that you created earlier and click **Save** .
    ![](../../../assets/img/Learn/token-exchange-seq-upload.png)

        !!! note
    In Flow, Out Flow and Fault Flow represent the custom In, Out and Fault sequences attached to the API by the user other than the default sequence definition of the API.


18. Go to **Lifecycle** tab, click **Publish** to publish the API.
    ![](../../../assets/img/Learn/test-custom-header-api-publish.png)

    Let's subscribe to the API and invoke it.

19. Log in to the API Developer Portal (https://localhost:9443/devportal) and subscribe to the API using an available application and the Gold tier. Or you may create a new application and subscribe to the api.

    ![](../../../assets/img/Learn/subscribe-with-default-app.png)

20. Go to the **Credentials** tab and click on `PROD KEYS`. 
21. Click **Generate Keys** to create an application access token.

    ![](../../../assets/img/Learn/custom-header-api-key-generation.png)

22. Install any REST client in your machine. We use [cURL](http://curl.haxx.se/download.html) here.
23. Go to the command line, and invoke the API using the following cURL command. In this command, you pass the token that the backend expects, i.e., 1234, in the **`Custom`** header with the authorization token that the system generates in the **`Authorization`** header.

    ``` java
        curl -H "Authorization: Bearer <access token>" -H "Custom: Bearer 1234" <API URL>
    ```

    Note the following:

    -   **&lt;access token&gt;** is the token that you got in step 20.
    -   **&lt;API URL&gt;** appears on the API's **Overview** page in the API Store. Copy the HTTP endpoint. If you select the HTTPs endpoint, be sure to run the cURL command with the -k option.

    Here's an example:

    ``` java
            curl -k -H "Authorization: Bearer 2e25097b2b3fbbfb44f5642fa8a495a1" -H "Custom: Bearer 1234" https://localhost:8243/test/1.0.0
    ```

24. Note the response that you get in the command line. According to the sample backend used in this tutorial, you get the response as "Request Received."
    [![](../../../assets/img/Learn/custom-header-response.png)](../../../assets/img/Learn/custom-header-response.png)

In this tutorial, you passed a custom token that the backend expects along with the system-generated Authorization token, and invoked an API successfully by swapping the system's token with your custom token.
