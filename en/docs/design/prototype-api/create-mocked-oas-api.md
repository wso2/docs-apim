# Endpoint Mock Implementation using OpenAPI Specification examples

The WSO2 API Manager Mock Implementation allows you to generate a mock payload based on an API definition examples that will mock the API responses. 
You can prototype an API using example responses provided in the open API specification.

!!! note
    This is currently supported only for the Choreo Connect gateway

## Step 1 - Enable mock implementation as the endpoint

Follow the instructions below to enable mock response generation based on open API specification:

1. First of all, start the WSO2 API Manager server that includes the API Publisher component and create an API. 

2. Navigate to **API Configurations** and click **API Definition** to navigate to the API Definition page in the Publisher to edit the open API specification.

3. Click **edit** to add mock examples to required resources.

[![Edit api definition](/assets/img/learn/prototype-api/edit-api-definition.png)](/assets/img/learn/prototype-api/edit-api-definition.png)

{!includes/design/add-oas-example.md!}

4. After adding examples to the open api specification, click `Save`.

5. Navigate to **API Configurations** and click **Endpoints** to navigate to the Endpoints page in the Publisher.

6. Select **Mock Implementation** as the endpoint type and click **Add**. Then select the choreo Connect as the gateway type.

7. View the mock examples that would be for returned for each resource. If you need to modify the examples, you have to edit the API definition as in step 2 and 3.

8. Click `Save` the API to enable mock implementation with OAS examples.

-------

### Step 2 - Attach Business Plans

!!! note 
    - By default, from WSO2 API Manager 4.1.0 onwards, security is enabled for all the resources of the Prototype API. As a result, you need a subscription to invoke the API.
    - Skip this step if you have [disabled security](#disabling-security-for-prototype-apis) for all the resources in the API.

Follow the instructions below to attach Business Plans to the API.

1. Navigate to **Portal Configurations** and click **Subscriptions**.

2. Select the required Business Plans and click **Save**.

    [![Select Prototype API Business Plans]({{base_path}}/assets/img/learn/prototype-api/create-prototype-api-subscription.png)]({{base_path}}/assets/img/learn/prototype-api/create-prototype-api-subscription.png)

## Step 3 - Deploy the API

[Deploy the API]({{base_path}}/deploy-and-publish/deploy-on-gateway/deploy-api/deploy-an-api/) in order to make the API available in the respective Gateway.

## Step 4 - Optionally, test the API via the Publisher

If required, you can [test the REST type APIs via the Publisher Portal]({{base_path}}/design/create-api/create-rest-api/test-a-rest-api/).

## Step 5 - Publish the API as a Prototype

Follow the instructions below to publish the API to the Developer Portal as a Prototype:
Make sure to deploy the API only to the Choreo Connect gateways as this is supported only for Choreo connect as the gateway.

1. Navigate to **Publish** and click **Lifecycle** to navigate to the Lifecycle page in the Publisher.  
    
     - **When creating an API with the Mock Implementation**, you can only promote your API to the `Prototyped` state in the API lifecycle.
     
         [![Publish as prototype when using Mock Implementation]({{base_path}}/assets/img/learn/prototype-api/mock-impl-lifecycle.png)]({{base_path}}/assets/img/learn/prototype-api/mock-impl-lifecycle.png)

     - **When creating an API with an actual backend URL**, you will have the option to either promote your API to the `Prototyped` state or to the `Published` state in the API lifecycle.

         [![Publish as Prototype API when using backend URL]({{base_path}}/assets/img/learn/prototype-api/backend-url-lifecycle.png)]({{base_path}}/assets/img/learn/prototype-api/backend-url-lifecycle.png)

2. Click **Prototype** to publish the API as a Prototype API to the Developer Portal.

## Step 6 - Invoke the API

1. Click **View in Dev Portal** to navigate to the Developer Portal.

    !!! note 
        If you have enabled security for the prototype API, follow the [Subscribe to an API]({{base_path}}/consume/manage-subscription/subscribe-to-an-api/) guide to subscribe and obtain an access token to invoke the prototype API.

2. Click **Try Out** to navigate to the API Console.

3. If you have enabled security, you can either use the access token that you got from the above step or use the **GET TEST KEY** option.
     
    !!! note
        Skip this step if you have [disabled security for the API](#disabling-security-for-prototype-apis), and leave the **Access Token** field empty.

     [![Try out prototype]({{base_path}}/assets/img/learn/prototype-api/create-prototype-api-dev-portal-tryout-petstore.png)]({{base_path}}/assets/img/learn/prototype-api/create-prototype-api-dev-portal-tryout-petstore.png)

4. Expand any method and click **Try it out**.

     [![Click Try it out]({{base_path}}/assets/img/learn/prototype-api/create-api-prototype-tryout-click.png)]({{base_path}}/assets/img/learn/prototype-api/create-api-prototype-tryout-click.png)

5. click **Execute** to invoke the API.

   You can use `Prefer` header and `Accept` header to get different examples for a resource if multiple examples were defined for the resource.
   Using `Prefer` header you can specify which `code` and/or `example` should be returned as the response for the mock request.

