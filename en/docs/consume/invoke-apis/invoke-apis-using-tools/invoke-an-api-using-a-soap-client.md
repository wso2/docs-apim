# Invoke an API using a SOAP Client

You can use any SOAP client to **invoke an API** . We use the SOAP UI in this example.

The examples here uses the `PhoneVerification` API, which is created in section [Expose a SOAP service as a REST API]({{base_path}}/learn/tutorials/expose-a-soap-service-as-a-rest-api/) .

Let's invoke the `PhoneVerification` API using a SOAP client.

1.  Sign in to the Developer Portal and click an API that you want to invoke (e.g., `PhoneVerification` ).
2.  The API's **Overview** page opens. Select an application (e.g., `DefaultApplication` ), with an available tier and subscribe to the API.

    ![]({{base_path}}/assets/img/learn/subscribe-phone-verification.png)

3.  Click the **Applications** menu, open the default application using which you subscribed to the API, and generate a production key.

    ![]({{base_path}}/assets/img/learn/generate-keys-production-default.png)

4.  Copy the access token to the clipboard as you need it later to invoke the API.

5.  Download the SOAP UI installation that suits your operating system from <https://www.soapui.org/downloads/soapui.html> and open its console.
6.  In the SOAP UI, right click on the **Projects** menu and create a new SOAP project.
    ![]({{base_path}}/assets/attachments/103332601/103332592.png)
7.  Give your API's WSDL and click **OK** .
    In this case, the WSDL is as follows: <http://ws.cdyne.com/phoneverify/phoneverify.asmx?wsdl>
    ![]({{base_path}}/assets/attachments/103332601/103332596.png)
8.  The WSDL defines two operations. Let's work with `CheckPhoneNumber` . Double click on `Request 1` . Then, click the **Header** tab and add an authorization header to your request by clicking on the add icon.
    ![]({{base_path}}/assets/attachments/103332601/103332595.png)
9.  Give the value of the Authorization header in the following format: `Bearer <the-access-token-you-copied-in-step4>          `
    ![]({{base_path}}/assets/attachments/103332601/103332594.png)

10. Add the following dummy values and submit the request.

    1.  Change the endpoint with the production URL of the API.
        You can copy the production URL from the API's **Overview** tab in the Developer Portal (i.e., It is `https://localhost:8243/phoneverify/1.0.0` for the `PhoneVerification` API). Append the resources to the end of the URL, if any. The resource is `/CheckPhoneNumber` for the `PhoneVerification` API that we use here.

    2.  In the SOAP request, change the parameters, which are PhoneNumber and LicenseKey.

        |                 |                                        |
        |-----------------|----------------------------------------|
        | **PhoneNumber** | Give a dummy phone number E.g., 123456 |
        | **LicenseKey**  | Give 0 for testing purpose             |

        ![]({{base_path}}/assets/attachments/103332601/103332589.png)

    Note the result on the right-hand side panel. As you gave a dummy phone number in this example, you get the result as invalid.
    ![]({{base_path}}/assets/attachments/103332601/103332590.png)

11. Add the following values and submit the request:

    1.  Maintain the same endpoint that you used in the previous step.

    2.  In the SOAP request, change the parameters, which are PhoneNumber and LicenseKey.

        |                 |                                              |
        |-----------------|----------------------------------------------|
        | **PhoneNumber** | Give a proper phone number E.g., 18006785432 |
        | **LicenseKey**  | Give 0 for testing purpose                   |

    Note the result on the right-hand side panel. As you gave a valid phone number in this example, you get the result as valid.
    ![]({{base_path}}/assets/attachments/103332601/103332591.png)

You have now successfully invoked an API using a SOAP client.

!!! info
    You can treat the Admin Services APIs as if they were back-end server APIs, and get all the benefits of API management for the admin services as well.

    Do the following to expose WSO2 API Manager Admin Services with OAUTH2.0.

    1.  Create a SOAP API for an admin service in the Publisher.
    2.  Add backend admin credentials for basic auth in the **Endpoints** tab in publisher.
    3.  Publish the app with a scope protecting access - use the admin role for your scope.

    Admins can then subscribe to the app and invoke it using OAUTH2.0 security.


