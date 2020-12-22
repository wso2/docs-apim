# Invoke an API using the Integrated API Console

WSO2 API Manager has an integrated API Console, which allows you to visualize the API contract and interact with API's resources without being aware of the backend logic.

The API Console generates interactive and consumer-focused documentation for API Contracts which are compliant with OpenAPI specification. OpenAPI specification-compliant APIs help you to make interactive documentation, client SDK generation and more discoverability using [Swagger UI](https://github.com/swagger-api/swagger-ui). The Swagger UI has JSON code and its UI facilitates easier code indentation, keyword highlighting, and shows syntax errors on the fly. You can add resource parameters, summaries, and descriptions to your APIs using the Swagger UI.

For more information also, see the [OpenAPI specification, version 2.0](https://github.com/swagger-api/swagger-spec/blob/master/versions/2.0.md) and [OpenAPI specification, version 3.0](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/3.0.3.md).

Let's see how to use the API Console in the Developer Portal to invoke an API.

!!! Note
    You can only try out HTTPS based APIs via the API Console because the Developer Portal runs on HTTPS.


The examples here use the `PizzaShack` REST API, which was created in [Create a REST API]({{base_path}}/learn/design-api/create-api/create-a-rest-api/) .

1.  Sign in to the WSO2 Develeoper Portal (`https://<hostname>:9443/devportal`) and click an API (e.g., `PizzaShack` ).

2.  Subscribe to the API (e.g., `PizzaShack` 1.0.0) using an application and an available tier.

    ![]({{base_path}}/assets/img/learn/subscribe-to-api.png)

3.  On the **Applications** menu, open the application you used to subscribe to the API. Click the **Production Keys** tab and click **Generate keys** to generate a production key.

    ![]({{base_path}}/assets/img/learn/generate-keys-production.png)

    !!! tip
        **Production and Sandbox Tokens**

        To generate keys for the Sandbox endpoint, go to the **Sandbox Keys** tab. For more details, see [Maintaining Separate Production and Sandbox Gateways]({{base_path}}/learn/api-gateway/maintaining-separate-production-and-sandbox-gateways/#multiple-gateways-to-handle-production-and-sandbox-requests-separately).

    !!! tip
        **JWT vs Oauth tokens**

        If the application you are using for this example is self-contained(JWT), then **copy the generated access token** before proceeding to the next step. If the application is of oauth type, then the swagger console will be automatically populated with the generated token in the authorization field. 


4.  On the **APIs** menu, select the API that you want to invoke. When the API opens, click on **Test** button under resources section.

    ![]({{base_path}}/assets/img/learn/api-console-test-button.png)

5. This will open the swagger UI(API Console) to test the PizzaShack API. Copy the generated access token to the Authorization field as depicted in the following figure.

    ![]({{base_path}}/assets/img/learn/copy-access-token.png)


6.  Expand the GET method and click Try it out. Then click on execute as follows.
 
    ![]({{base_path}}/assets/img/learn/api-console-execute.png)


    !!! Note
        **Troubleshooting**

        If you **cannot invoke the API's HTTPS endpoint** (this causes the **SSLPeerUnverified exception** ), it could be because the security certificate issued by the server is not trusted by your browser. To resolve this issue, access the HTTPS endpoint directly from your browser and accept the security certificate.
        
        If the API Manager has a **certificate signed by a Certificate Authority** (CA), the HTTPS endpoints should work out of the box.


    Note the successful response for the API invocation. 

    ![]({{base_path}}/assets/img/learn/api-response.png)

You have now successfully invoked an API using the Swagger API Console.
