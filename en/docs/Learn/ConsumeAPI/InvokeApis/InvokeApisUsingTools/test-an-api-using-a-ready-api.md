# Test an API using a Ready! API

When an enterprise exposes its APIs for internal or external consumption, application developers (both internal and external) write applications using these exposed APIs. Before the API is embedded within an application, it needs to be tested in order to make sure that the API can be successfully adopted. SmartBear’s Ready API! is an API testing tool widely used for this purpose. The WSO2 API Manager plugin, developed in partnership with SmartBear, allows seamless integration between the two products allowing application developers to work with the Ready! API platform to test APIs exposed via WSO2 API Manager.

This tutorial explains how to integrate Ready! API with WSO2 API Manager and then test APIs that are exposed in the API Manager. It also explains how Ready! API can be used to generate OAuth 2.0 tokens with different grant types and the benefits this integration can bring to an application developer.

This tutorial uses the `PhoneVerification` API, which is created in Create and Publish an API .

### Installing the WSO2 API Manager plugin in Ready! API

!!! note
Ready! API supports WSO2 API Manager versions 1.8.0 onwards. Ready! API 1.7.0 has been used in this guide.


1.  Download and run [Ready! API](http://smartbear.com/product/ready-api/overview/) .
2.  Click the **Plugins** button shown below to open the Plugin Manager.
    ![](/assets/attachments/103333157/103333165.png)3.  Browse the plugin repository, locate the WSO2 API Manager plugin for Ready! API and click **Install/Upgrade Plugin** .
    ![](/assets/attachments/103333157/103333164.png)4.  Click **Yes** on the confirmation message that appears.

Let's test an API exposed via WSO2 API Manager.

### Testing APIs using Ready! API

1.  Run the WSO2 API Manager server.
2.  Run Ready! API if it's not already open.

        !!! tip
    If you are using a self-signed certificate with WSO2 API Manager, you need to explicitly configure Ready! API to trust this certificate. Click **File &gt; Preferences** and then select the **Internal Browser** tab. Select the **Trust the self-signed certificate** check box and click **OK** .
    ![](/assets/attachments/103333157/103333163.png)

3.  Start by creating a new project in Ready! API. Click **File &gt; New Project** .
    ![](/assets/attachments/103333157/103333162.png)
4.  In the **Description File** tab, select the **Import from WSO2 API Manager** option and click **Import** .
    ![](/assets/attachments/103333157/103333161.png)5.  On the dialog box that appears, enter the information of the API Store from which API information needs to be extracted and click **OK** .

        !!! tip
    It is possible to import APIs from tenant stores as well.


    |                     |                                 |
    |---------------------|---------------------------------|
    | Project Name        | API Manager Project             |
    | API Store URL       | <https://localhost:9443/store/> |
    | API Store User Name | admin                           |
    | API Store Password  | admin                           |
    | API Manager Version | 2.0.0                           |

    ![](/assets/attachments/103333157/103333160.png)

6.  Select one or more APIs from the list of APIs available in the API Store and click **OK** .
    ![](/assets/attachments/103333157/103333159.png)7.  Select an API (e.g. PhoneVerification) and expand the API to see all the HTTP verbs associated with it. Select the required HTTP verb (e.g. GET) to test the API.
    ![](/assets/attachments/103333157/103333158.png)8.  To add your own parameters, click the **Parameters** field and then click the **Plus** icon.
    ![](/assets/attachments/103333157/103333174.png)
9.  Enter the required information for the API (e.g. 18006785432 as the phone number).
10. Once all the required information is added for the API, you need to add the API OAuth 2.0 token to invoke the API. Click the **Auth** tab at the bottom of the screen.
    ![](/assets/attachments/103333157/103333175.png)
    You can either get a test access token from the API Store or use the inbuilt OAuth 2.0 access token generation option. In this example, the inbuilt token generation option is used.

    The inbuilt OAuth 2.0 access token generation option allows an access token to be generated with different grant types, which can be used to test the key generation process of WSO2 API Manager without requiring an application to perform the OAuth 2.0 key generation. This option can also be used in cases where you want to test access to different HTTP verbs and resource paths using different types of scopes and API keys.

11. In the **Auth** tab, click **Get Access Token** .
    ![](/assets/attachments/103333157/103333170.png)
12. On the dialog box that appears, enter the following information.

    ![](/assets/attachments/103333157/103333169.png)
    | Value                                    | Description                                                                                                                                                                                                                                                                                                                                                 |
    |------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
    | OAuth 2 Flow                             | You can choose from different grant types to generate your token. In this example, we have used the **Client Credentials Grant** type.                                                                                                                                                                                                                      |
    | Client Identification and  Client Secret | Get these values from the API Store. Browse to the application that the API being tested is subscribed to (e.g. DefaultApplication) and copy the values from the **Production Keys** tab.                                                                                                                                                                   |
    | Access Token URI                         | Provide the URL of the access token endpoint of the API Manager. By default, this URL is `https://localhost:9443/oauth2/token` . If you are using a componentized API manager deployment, the URI should point to the Key Manager component of the deployment. |
    | Scope                                    | Define the scope under which the token is generated. If you have not defined any scope restrictions when creating the API you can leave this blank.                                                                                                                                                                                                         |

13. Once done, click **Get Access Token** .
    ![](/assets/attachments/103333157/103333168.png)14. The access token is retrieved from the server.
    ![](/assets/attachments/103333157/103333167.png)15. Now you can invoke the API by sending the request. The response is displayed as shown below. If you encounter an error, make sure that the values given for the endpoint, resource and parameters are correct.
    ![](/assets/attachments/103333157/103333166.png)
You have successfully tested an API.

!!! note
To use the access token taken from the API Store,

1.  Login to the WSO2 API Manager Store and browse to the application that the API being tested is subscribed to (e.g. DefaultApplication).
2.  In the **Production** Keys tab, generate (or regenerate) a test access token and copy it.
    ![](/assets/attachments/103333157/103333173.png)
3.  Go back to the Ready! API, paste the access token for the API and send the request.
    ![](/assets/attachments/103333157/103333172.png)
4.  The response is displayed as shown below. If you encounter an error, make sure that the values given for the endpoint, resource and parameters are correct.
    ![](/assets/attachments/103333157/103333171.png)

