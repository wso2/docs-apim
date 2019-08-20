# Invoke an API using the Integrated API Console

WSO2 API Manager (WSO2 API-M) has an integrated Swagger UI, which is part of the Swagger project.

[Swagger](http://swagger.io/) is a 100% open source, standard, language-agnostic specification and a complete framework for describing, producing, consuming, and visualizing RESTful APIs, without the need of a proxy or third-party services. Swagger allows consumers to understand the capabilities of a remote service without accessing its source code and interacts with the service with a minimal amount of implementation logic. Swagger helps describe a service in the same way that interfaces describe lower-level programming code.

The [Swagger UI](https://github.com/swagger-api/swagger-ui) is a dependency-free collection of HTML, JavaScript, and CSS that dynamically generate documentation from a Swagger-compliant API. Swagger-compliant APIs give you interactive documentation, client SDK generation and more discoverability. The Swagger UI has JSON code and its UI facilitates easier code indentation, keyword highlighting, and shows syntax errors on the fly. You can add resource parameters, summaries, and descriptions to your APIs using the Swagger UI.

For more information also, see the [Swagger 2.0 specification](https://github.com/swagger-api/swagger-spec/blob/master/versions/2.0.md) .

Let's see how to use the API Console in the Store to invoke an API.

!!! note
See the following topics for a description of the concepts that you need to know when invoking an API:

-   [Applications](_Key_Concepts_)
-   [Throttling](_Key_Concepts_)
-   [Access tokens](_Key_Concepts_)
-   [Cross-origin resource sharing](_Key_Concepts_) - This is needed only if you have the **API Store and Gateway in different ports** or you want to invoke an API with **inline endpoints** .

!!! warning
You can only try out HTTPS based APIs via the API Console because the API Store runs on HTTPS.


The examples here use the `         PhoneVerification        ` REST API, which was created in [Create and Publish an API](_Create_and_Publish_an_API_) .

1.  Sign in to the WSO2 API Store and click an API (e.g., `           PhoneVerification          ` ).
    `           https://<hostname>:9443/store          `

2.  Subscribe to the API (e.g., `           PhoneVerification          ` 1.0.0) using the **default application** and an available tier.
    ![](attachments/103327857/103327843.png)

3.  On the **Applications** menu, open the default application you used to subscribe to the API. Click the **Production Keys** tab and click **Generate keys** to generate a production key.
    ![](attachments/103327857/103327842.png)

        !!! tip
    Production and Sandbox Tokens

    To generate keys for the Sandbox endpoint, go to the **Sandbox Keys** tab. For more details, see [Maintaining Separate Production and Sandbox Gateways](_Maintaining_Separate_Production_and_Sandbox_Gateways_) .


4.  On the **APIs** menu, select the API that you want to invoke. When the API opens, go to its **API Console** tab.
    ![](attachments/103327857/103327841.png)
    If you have subscribed to an application, the retrieved access token value appears automatically as the **Authorization Bearer Token.
    **

        !!! tip
    Documentation

    The **Documentation** tab contains any relevant [documents that are attached](_Add_API_Documentation_) to the API.

    ![](attachments/103327857/103327844.png)


5.  Expand the GET method and click Try it out. Provide the required parameters and click **Execute.** For example,

    |                   |                                                                                                                                                                                                                                           |
    |-------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
    | **PhoneNumber**   | E.g., 18006785432                                                                                                                                                                                                                         |
    | **LicenseKey**    | Give 0 for testing purpose                                                                                                                                                                                                                |
    | **Authorization** | The API console is automatically populated by the access token that you generated in [step 3](#InvokeanAPIusingtheIntegratedAPIConsole-step3) after subscribing to the API.                                                               
      The token is prefixed by the string "Bearer" as per the OAuth bearer token profile. [OAuth security](_Key_Concepts_) is enforced on all published APIs. If the application key is invalid, you get a 401 Unauthorized response in return.  |

    ![](attachments/103327857/103327840.png)

        !!! info
    Troubleshooting

    If you **cannot invoke the API's HTTPS endpoint** (this causes the **SSLPeerUnverified exception** ), it could be because the security certificate issued by the server is not trusted by your browser. To resolve this issue, access the HTTPS endpoint directly from your browser and accept the security certificate.

    If the API Manager has a **certificate signed by a** **Certificate Authority** (CA), the HTTPS endpoints should work out of the box.


    Note the response for the API invocation. As we used a valid phone number in this example, the response is valid.

    ![](attachments/103327857/103327839.png)

You have invoked an API using the Swagger API Console.
