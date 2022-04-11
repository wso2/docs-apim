# Mock Implementation with Choreo Connect

This Mock Implementation allows you to generate mock responses based on examples provided in the OpenAPI specification and directly get the response. For non-default cases, the exact response can be requested using the `Prefer` and `Accept` headers.

!!! important
    This is currently supported only when [Choreo Connect]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/getting-started/choreo-connect-overview/) is used as the Gateway.

## Step 1 - Create the interface of the API

Follow the instructions below to enable mock response generation based on the OpenAPI specification:

1. Start the WSO2 API Manager server with Choreo Connect as the gateway.

2. Open API Publisher in the browser and create a REST API with the following values. 

    | **Field**    | **Value**                        |
    |----------|-------------------------------------|
    | Name     | SwaggerPetstore                     |
    | Context  | v3                                 |
    | Version  | 1.0.6                               |
    | Endpoint | Leave the endpoint field empty. |

## Step 2 - Implement the API

### Update the OpenAPI Specification

1. Navigate to **API Definition** under **API Configurations** to view the OpenAPI specification.

2. Click **edit** to add mock examples to required resources.

    [![Edit api definition]({{base_path}}/assets/img/learn/prototype-api/mock-impl-edit-api-definition.png)]({{base_path}}/assets/img/learn/prototype-api/mock-impl-edit-api-definition.png)

    Replace the default resources with the resource definitions given below.

3. Add response examples to OpenAPI Specification.    

{!includes/design/add-oas-example.md!}


5. After adding examples to the OpenAPI specification, remember to click **Update Content** and **Save**.

### Change the Endpoint Type

6. Navigate to **Endpoints** under **API Configurations**.

7. Select **Mock Implementation** as the endpoint type by clicking **Add**. 

8. Select Choreo Connect as the gateway type. 

9. Click **proceed** if a dialog box appears to disregard "mock endpoint implementation scripts". 

10. View the mock examples that would be returned for each resource. If you need to modify the examples, you have to edit the API definition as mentioned before.

11. Click **Save** to enable mock implementation with OAS examples.


{!includes/design/invoke-prerelease-api.md!}

## Step 6 - Invoke the API

1. Click **View in Dev Portal** to navigate to the Developer Portal.

    !!! note 
        If you have enabled security for the prototype API, follow the [Subscribe to an API]({{base_path}}/consume/manage-subscription/subscribe-to-an-api/) guide to subscribe and obtain an access token to invoke the prototype API.

2. Click **Try Out** to navigate to the API Console.

3. If you have enabled security, you can either use the access token that you got from the above step or use the **GET TEST KEY** option.
     
    !!! note
        Skip this step if you have [disabled security for the API]({{base_path}}/design/api-security/api-authentication/disable-security/), and leave the **Access Token** field empty.

     [![Try out prototype]({{base_path}}/assets/img/learn/prototype-api/create-prototype-api-dev-portal-tryout-petstore.png)]({{base_path}}/assets/img/learn/prototype-api/create-prototype-api-dev-portal-tryout-petstore.png)

4. Expand any method and click **Try it out**.

     [![Click Try it out]({{base_path}}/assets/img/learn/prototype-api/create-api-prototype-tryout-click.png)]({{base_path}}/assets/img/learn/prototype-api/create-api-prototype-tryout-click.png)

5. Click **Execute** to invoke the API.

    - You can use the `Prefer` header and the `Accept` header to get different examples for a resource if multiple examples were defined for the resource.

    - Use the `Prefer` header to specify which `code` and/or `example` should be returned as the response for the mock request.

