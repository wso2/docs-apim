# Deploying a REST API with a Mock Implementation

In addition to exposing an existing backend implementation as an API, Choreo Connect is also capable of responding to HTTP requests even without a backend. By changing the endpoint type to **Mock Implementation**, you can make Choreo Connect read the examples you have provided in the OpenAPI Definition and respond to each HTTP request accordingly. While it supports default responses, you can also request specific responses using the HTTP headers `Prefer` and `Accept`.

!!! note 
	This guide currently only provides the steps to deploy via WSO2 API manager. It will soon be updated to include the steps for standalone mode.

## Step 1 - Create a REST API

Follow the exact steps used when you create a regular REST API as described [here]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/deploy-api/deploy-rest-api-in-choreo-connect/).

## Step 2 - Implement the API

### Step 2.1 - Update the OpenAPI Specification

1. Navigate to **API Definition** under **API Configurations** to view the OpenAPI specification.

2. Click **edit** to add mock examples to required resources.

    [![Edit api definition]({{base_path}}/assets/img/learn/prototype-api/mock-impl-edit-api-definition.png)]({{base_path}}/assets/img/learn/prototype-api/mock-impl-edit-api-definition.png)

    Replace the default resources with the resource definitions given below.

3. Add response examples to OpenAPI Specification.    

{!includes/design/add-oas-example.md!}


5. After adding examples to the OpenAPI specification, remember to click **Update Content** and **Save**.

### Step 2.2 - Change the Endpoint Type

6. Navigate to **Endpoints** under **API Configurations**.

7. Select **Mock Implementation** as the endpoint type by clicking **Add**. 

8. Select Choreo Connect as the gateway type. 

9. Click **proceed** if a dialog box appears to disregard "mock endpoint implementation scripts". 

10. View the mock examples that would be returned for each resource. If you need to modify the examples, you have to edit the API definition as mentioned before.

11. Click **Save** to enable mock implementation with OAS examples.


## Step 3 - Deploy the API

Deploy the API from the **Deployments** tab from the left menu.

## Step 4 - Invoke the API

{! ./includes/obtain-jwt.md !}
{! ./includes/invoke-api-with-jwt.md !}

## See Also

- [Mock Implementation with Choreo Connect]({{base_path}}/design/prototype-api/create-mocked-oas-api.md)
- [Prototyped APIs (Pre-Released APIs)]({{base_path}}/design/prototype-api/overview.md)
- [Enforcer Test Key (JWT)]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/security/generate-a-test-jwt)
