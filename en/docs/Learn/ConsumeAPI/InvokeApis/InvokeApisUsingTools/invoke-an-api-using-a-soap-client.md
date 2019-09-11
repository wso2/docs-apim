# Invoke an API using a SOAP Client

You can use any SOAP client to **invoke an API** . We use the SOAP UI in this example.

!!! note
See the following topics for a description of the concepts that you need to know when invoking an API:

-   [Applications](Key-Concepts_103328852.html#KeyConcepts-Applications)
-   [Throttling](Key-Concepts_103328852.html#KeyConcepts-Throttling)
-   [Access tokens](Key-Concepts_103328852.html#KeyConcepts-Accesstokens)


The examples here use the `PhoneVerification` API, which is created in section [Create and Publish an API](_Create_and_Publish_an_API_) .

Let's invoke the `PhoneVerification` API using a SOAP client.

1.  Sign in to the API Store and click an API that you want to invoke (e.g., `PhoneVerification` ).
2.  The API's **Overview** page opens. Select an application (e.g., `DefaultApplication` ), the **Bronze tier** and subscribe to the API.
    ![](attachments/103332601/103332597.png)
3.  Click the **Applications** menu, open the default application using which you subscribed to the API, and generate a production key.
    ![](attachments/103332601/103332593.png)
4.  Copy the access token to the clipboard as you need it later to invoke the API.

        !!! warning
    Make sure the flash plug-in of your web browser is updated in order to get the **copy button** in the Store UI working.


5.  Download the SOAP UI installation that suits your operating system from <https://www.soapui.org/downloads/soapui.html> and open its console.
6.  In the SOAP UI, right click on the **Projects** menu and create a new SOAP project.
    ![](attachments/103332601/103332592.png)
7.  Give your API's WSDL and click **OK** .
    In this case, the WSDL is as follows: <http://ws.cdyne.com/phoneverify/phoneverify.asmx?wsdl>
    ![](attachments/103332601/103332596.png)
8.  The WSDL defines two operations. Let's work with `CheckPhoneNumber` . Double click on `Request 1` . Then, click the **Header** tab and add an authorization header to your request by clicking on the add icon.
    ![](attachments/103332601/103332595.png)
9.  Give the value of the Authorization header in the following format: `Bearer <the-access-token-you-copied-in-step4>          `
    ![](attachments/103332601/103332594.png)

10. Add the following dummy values and submit the request.

    1.  Change the endpoint with the production URL of the API.
        You can copy the production URL from the API's **Overview** tab in the API Store (i.e., It is `https://localhost:8243/phoneverify/1.0.0` for the `PhoneVerification` API). Append the resources to the end of the URL, if any. The resource is `/CheckPhoneNumber` for the `PhoneVerification` API that we use here.

    2.  In the SOAP request, change the parameters, which are PhoneNumber and LicenseKey.

        |                 |                                        |
        |-----------------|----------------------------------------|
        | **PhoneNumber** | Give a dummy phone number E.g., 123456 |
        | **LicenseKey**  | Give 0 for testing purpose             |

        ![](attachments/103332601/103332589.png)

    Note the result on the right-hand side panel. As you gave a dummy phone number in this example, you get the result as invalid.
    ![](attachments/103332601/103332590.png)

11. Add the following values and submit the request:

    1.  Maintain the same endpoint that you used in the previous step.

    2.  In the SOAP request, change the parameters, which are PhoneNumber and LicenseKey.

        |                 |                                              |
        |-----------------|----------------------------------------------|
        | **PhoneNumber** | Give a proper phone number E.g., 18006785432 |
        | **LicenseKey**  | Give 0 for testing purpose                   |

    Note the result on the right-hand side panel. As you gave a valid phone number in this example, you get the result as valid.
    ![](attachments/103332601/103332591.png)

You have invoked an API using a SOAP client.

!!! info
You can treat the Admin Services APIs as if they were back-end server APIs, and get all the benefits of API management for the admin services.

Do the following WSO2 API Manager to expose SOAP APIs with OAUTH2.0.

1.  Create a SOAP API for an admin service in the Publisher.
2.  Add backend admin credentials for basic auth in the **Implement** page.
3.  Publish the app with a scope protecting access - use the admin role for your scope.

Admins can then subscribe to the app and invoke it using OAUTH2.0 security.


