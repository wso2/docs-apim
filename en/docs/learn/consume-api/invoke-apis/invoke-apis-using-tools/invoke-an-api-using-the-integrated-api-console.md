# Invoke an API using the Integrated API Console

WSO2 API Manager (WSO2 API-M) has an integrated Swagger UI, which is part of the Swagger project.

[Swagger](http://swagger.io/) is a 100% open source, standard, language-agnostic specification and a complete framework for describing, producing, consuming, and visualizing RESTful APIs, without the need of a proxy or third-party services. Swagger allows consumers to understand the capabilities of a remote service without accessing its source code and interacts with the service with a minimal amount of implementation logic. Swagger helps describe a service in the same way that interfaces describe lower-level programming code.

The [Swagger UI](https://github.com/swagger-api/swagger-ui) is a dependency-free collection of HTML, JavaScript, and CSS that dynamically generate documentation from a Swagger-compliant API. Swagger-compliant APIs give you interactive documentation, client SDK generation and more discoverability. The Swagger UI has JSON code and its UI facilitates easier code indentation, keyword highlighting, and shows syntax errors on the fly. You can add resource parameters, summaries, and descriptions to your APIs using the Swagger UI.

For more information also, see the [Swagger 2.0 specification](https://github.com/swagger-api/swagger-spec/blob/master/versions/2.0.md) .

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
        **JWT tokens**

        Since the application is self-contained(JWT), then **copy the generated access token** before proceeding to the next step. 


4.  On the **APIs** menu, select the API that you want to invoke. When the API opens, click on **Test** button under resources section.

    ![]({{base_path}}/assets/img/learn/api-console-test-button.png)

5. This will open the OpenAPI UI(API Console) to test the PizzaShack API. Copy the generated access token to the Authorization field as depicted in the following figure.

    ![]({{base_path}}/assets/img/learn/copy-access-token.png)


6.  Expand the GET method and click Try it out. Then click on execute as follows.
 
    ![]({{base_path}}/assets/img/learn/api-console-execute.png)


    !!! Note
        **Troubleshooting**

        If you **cannot invoke the API's HTTPS endpoint** (this causes the **SSLPeerUnverified exception** ), it could be because the security certificate issued by the server is not trusted by your browser. To resolve this issue, access the HTTPS endpoint directly from your browser and accept the security certificate.
        
        If the API Manager has a **certificate signed by a Certificate Authority** (CA), the HTTPS endpoints should work out of the box.


    Note the successful response for the API invocation. 

    ![]({{base_path}}/assets/img/learn/api-response.png)

You have now succesfully invoked an API using the Open API Console.


## Invoke an API deployed on a cloud cluster

!!! attention "Before You Begin"
    1. You need to have an API published to a cloud cluster in order to invoke the API as follows. Follow the document [Publish an API to a Cloud Clouster in PrivateJet Mode](learn/design-api/publish-api/publish-an-api-to-a-cloud-cluster-in-privatejet-mode/) to learn how to publish an API to a cloud cluster in privatejet mode.

1. Sign in to the WSO2 Develeoper Portal (`https://<hostname>:9443/devportal`) and click an API which was deployed on a cloud cluster. **Note**  that the accessURL of the API can be found under Gateway Environments..
   
    ![Developer portal - Overview]({{base_path}}/assets/img/learn/privatejet-mode/devportal.png)
   
2.  Subscribe to the API using an application and an available tier.

    ![]({{base_path}}/assets/img/learn/subscribe-to-api.png)

3.  On the **Applications** menu, open the application you used to subscribe to the API. Click the **Production Keys** tab and click **Generate keys** to generate a production key.

    ![]({{base_path}}/assets/img/learn/generate-keys-production.png)

    !!! tip
        **Production and Sandbox Tokens**

        To generate keys for the Sandbox endpoint, go to the **Sandbox Keys** tab. For more details, see [Maintaining Separate Production and Sandbox Gateways]({{base_path}}/learn/api-gateway/maintaining-separate-production-and-sandbox-gateways/#multiple-gateways-to-handle-production-and-sandbox-requests-separately).

    !!! tip
        **JWT tokens**

        Since the application is self-contained(JWT), then **copy the generated access token** before proceeding to the next step. 
    
4. Click **Try Out** to navigate to the API Console.
    
5. Select the gateway as **configured container management cluster**.
    
    ![Developer portal - Try Out gateway selection]({{base_path}}/assets/img/learn/privatejet-mode/tryout-console-gateway-selection.png)
    
6. Expand a method and click Try it out. Then click on execute as follows.
    
    ![]({{base_path}}/assets/img/learn/api-console-execute.png)
        
    