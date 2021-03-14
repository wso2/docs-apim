# Invoke an API using the Integrated API Console

WSO2 API Manager has an integrated API Console, which allows you to visualize the API contract and interact with API's resources without being aware of the backend logic.

Let's see how to use the API Console in the Developer Portal to invoke an API.

!!! Note
    You can only try out HTTPS-based APIs via the API Console because the Developer Portal runs on HTTPS.


The examples here use the `PizzaShack` REST API, which was created in [Create a REST API]({{base_path}}/learn/design-api/create-api/create-a-rest-api/).

1. Sign in to the WSO2 Developer Portal (`https://<hostname>:9443/devportal`) and click an API (e.g., `PizzaShack`).

2. Subscribe to the API (e.g., `PizzaShack` 1.0.0) using an application and an available throttling policy.

    [![Subscribe to an API]({{base_path}}/assets/img/learn/subscribe-to-api.png)]({{base_path}}/assets/img/learn/subscribe-to-api.png)

3. Click **Applications** and then click on the application that you used to subscribe to the API. Click **Production Keys** and click **Generate keys** to generate a production key.

     [![Generate production keys]({{base_path}}/assets/img/learn/generate-keys-production.png)]({{base_path}}/assets/img/learn/generate-keys-production.png)

    !!! tip
        **Production and Sandbox Tokens**

        To generate keys for the Sandbox endpoint, go to the **Sandbox Keys** tab. For more information, see [Maintaining Separate Production and Sandbox Gateways]({{base_path}}/learn/api-gateway/maintaining-separate-production-and-sandbox-gateways/#multiple-gateways-to-handle-production-and-sandbox-requests-separately).

    !!! tip
        **JWT tokens**

        As the application is self-contained (JWT), **copy the generated access token** before proceeding to the next step. 


4. Click **APIs**, and click on the API that you need to invoke. 

5. Click **Test** under the resources section of the API.

    [![API console test button]({{base_path}}/assets/img/learn/api-console-test-button.png)]({{base_path}}/assets/img/learn/api-console-test-button.png)

    The OpenAPI UI (API Console) to test the PizzaShack API appears.

6.  Enter the copied access token in the **Authorization** field.

     [![]({{base_path}}/assets/img/learn/copy-access-token.png)]({{base_path}}/assets/img/learn/copy-access-token.png)

7. Expand the GET method and click **Try it out**. Click **Execute**.
 
     [![API console execute]({{base_path}}/assets/img/learn/api-console-execute.png)]({{base_path}}/assets/img/learn/api-console-execute.png)

    !!! Note "Troubleshooting"
        If you **cannot invoke the API's HTTPS endpoint** (this causes the **SSLPeerUnverified exception**), it could be because the security certificate issued by the server is not trusted by your browser. To resolve this issue, access the HTTPS endpoint directly from your browser and accept the security certificate.
        
        If WSO2 API Manager has a **certificate signed by a Certificate Authority** (CA), the HTTPS endpoints should work out-of-the-box.

Note the successful response for the API invocation.

[![API response]({{base_path}}/assets/img/learn/api-response.png)]({{base_path}}/assets/img/learn/api-response.png)

You have now successfully invoked an API using the Open API Console

## Invoke an API deployed on a cloud cluster

!!! Attention "Before You Begin"
    You need to have an API published to a cloud cluster in order to invoke the API as follows. For instructions on how to publish an API to a cloud cluster in PrivateJet Mode, see [Publish an API to a Cloud Cluster in PrivateJet Mode]({{base_path}}/learn/design-api/publish-api/publish-an-api-to-a-cloud-cluster-in-privatejet-mode/).

1. Sign in to the WSO2 Developer Portal (`https://<hostname>:9443/devportal`) and click on the API that you deployed on a cloud cluster. 

    !!! Note
        You can find the accessURL that corresponds the API under **Gateway Environments**.
   
    [![Developer Portal - Overview]({{base_path}}/assets/img/learn/privatejet-mode/devportal.png)]({{base_path}}/assets/img/learn/privatejet-mode/devportal.png)
   
2. Subscribe to the API using an application and an available throttling policy.

    [![Subscribe to an API]({{base_path}}/assets/img/learn/subscribe-to-api.png)]({{base_path}}/assets/img/learn/subscribe-to-api.png)

3.  Click **Applications**, click on the application that you used to subscribe to the API. Click the **Production Keys** tab and click **Generate keys** to generate a production key.

    [![Generate production keys]({{base_path}}/assets/img/learn/generate-keys-production.png)]({{base_path}}/assets/img/learn/generate-keys-production.png)

    !!! tip
        **Production and Sandbox Tokens**

        To generate keys for the Sandbox endpoint, go to the **Sandbox Keys** tab. For more information, see [Maintaining Separate Production and Sandbox Gateways]({{base_path}}/learn/api-gateway/maintaining-separate-production-and-sandbox-gateways/#multiple-gateways-to-handle-production-and-sandbox-requests-separately).

    !!! tip
        **JWT tokens**

        As the application is self-contained (JWT), **copy the generated access token** before proceeding to the next step. 
    
4. Click **Try Out** to navigate to the API Console.
    
5. Select the Gateway as **configured container management cluster**.
    
    [![Developer Portal - Try Out gateway selection]({{base_path}}/assets/img/learn/privatejet-mode/tryout-console-gateway-selection.png)]({{base_path}}/assets/img/learn/privatejet-mode/tryout-console-gateway-selection.png)
    
6. Expand a method and click **Try it out**. Click **Execute**.
    
    [![API console execute]({{base_path}}/assets/img/learn/api-console-execute.png)]({{base_path}}/assets/img/learn/api-console-execute.png)
        
## Get a test key to invoke an API

When you want to test out the process of invoking an API resource, you can easily get a test key from the API console rather than going back to the Applications page and generating a key. Click **Try Out** to navigate to the API Console, click on the `GET TEST KEY` button to generate a test key.

[![Get test key]({{base_path}}/assets/img/learn/get-test-key.png)]({{base_path}}/assets/img/learn/get-test-key.png)

!!! tip

    TEST KEY will be generated with default scopes attached to the API. If you need to generate a token with specific scopes, go to the application view and generate a token.
