# Create a Prototype API with an Inline Script

Generally, you would need to create APIs with inline scripts for testing purposes. You can deploy a new API or a new version of an existing API as a prototype. Thereby, this provides subscribers an early implementation of the API that they can try out and test without a subscription or monetization, and provide feedback to improve the API. After a period of time, the publishers can make changes that the users requested and publish the API.

Let's create a prototyped API with an inline script, deploy it as a prototype, and invoke it using the API Console, which is integrated in the API Developer Portal.

## Step 1 - Create a Prototype API with Inline Script

1.  Sign in to the API Publisher using `admin` as the username and password.

     `https://<hostname>:9443/publisher` 
     
     Example: `https://localhost:9443/publisher`

2.  Click **CREATE API**, and click **Design a new REST API**. 

    [![Create API options]({{base_path}}/assets/img/learn/create-api-design-rest-api-link.png)]({{base_path}}/assets/img/learn/create-api-design-rest-api-link.png)
   
3.  Provide the API name, context, and version. Click **CREATE**. 
     
     For this example, provide the following values.

    |||
    |------|-------------|
    |Name|Location_API|
    |Context|/location|
    |Version|1.0.0|

    [![Filled create api form]({{base_path}}/assets/img/learn/create-api-form-filled.png)]({{base_path}}/assets/img/learn/create-api-form-filled.png)
    
    You are directed to the API Overview page.
    
4. Click **Resources** to navigate to the **Resources** page.
   
     Select the **HTTP Verb**, provide the **URI Pattern** and click on **+** to add a new resource.
    
    | | |
    |------|-------------|
    |HTTP Verb|GET|
    |URI Pattern|/{town}|
    
    [![]({{base_path}}/assets/img/learn/create-api-add-resource.png)]({{base_path}}/assets/img/learn/create-api-add-resource.png)
    
    !!! tip

        After the new Resource is added, delete the default Resources (/\*) by clicking on the Delete Button \[1\] of
         each resource. Or select all the resources at once by clicking on **Select all for Delete** \[2\] button.
      
    [![]({{base_path}}/assets/img/learn/create-api-delete-resource.png)]({{base_path}}/assets/img/learn/create-api-delete-resource.png)
      

5. Expand the newly added resource.
   
     Note that the path parameter named `town` is set in the **Parameters** section.

    [![]({{base_path}}/assets/img/learn/create-api-resource-parameter-view.png)]({{base_path}}/assets/img/learn/create-api-resource-parameter-view.png)

    !!! tip

        To specify multiple parameters in the API resource, separate the parameters with a forward slash in the URI Pattern.
    
        ``` js
            {param1}/{param2}
        ```
        
5. Click **SAVE** to save the API.

6. Click **Endpoints** to navigate to the **Endpoints** page.

7. Select **Prototype Implementation** in the Prototype Endpoint card, which is in the **Select an Endpoint Type to Add** page, and click **ADD**. 

     Note that this page has been prompted because no endpoints have been added to the API yet.
 
    [![]({{base_path}}/assets/img/learn/create-api-prototype-endpoint-add.png)]({{base_path}}/assets/img/learn/create-api-prototype-endpoint-add.png)

    You will be directed to the endpoints page.
    
    [![]({{base_path}}/assets/img/learn/create-api-prototype-endpoint-page.png)]({{base_path}}/assets/img/learn/create-api-prototype-endpoint-page.png)

    !!! note

        The inline JavaScript engine does not provide support for SOAP APIs. If you opt for the endpoint implementation method instead of inline, you need to provide an endpoint to a prototype API. For example, `<http://ws.cdyne.com/phoneverify/phoneverify.asmx>`

6.  Expand the `GET` method and enter the following as the script. 

     This script reads the payload that the user sends with the API request and returns it as a JSON value. The value **mc** is the message context.

    ``` java
    mc.setProperty('CONTENT_TYPE', 'application/json'); // Set the content type of the payload to the message context
    var town = mc.getProperty('uri.var.town');          // Get the path parameter 'town' and store in a variable
    mc.setPayloadJSON('{ "Town" : "'+town+'"}');        // Set the new payload to the message context.
    ```

    [![]({{base_path}}/assets/img/learn/create-api-prototype-script-added.png)]({{base_path}}/assets/img/learn/create-api-prototype-script-added.png)
    
7. Click **SAVE** to save the API.

## Step 2 - Deploy the API as a prototype
    
1. Click **Lifecycle** to navigate to the **Lifecycle** page.
2. Click **DEPLOY AS A PROTOTYPE** to deploy the API as a prototype.
        
        [![]({{base_path}}/assets/img/learn/create-api-prototype-lc-page.png)]({{base_path}}/assets/img/learn/create-api-prototype-lc-page.png) 
 
## Step 3 - Invoke the API

1. Click **View in Dev Portal** to navigate to the API Developer Portal after the API is deployed.

     !!! tip

        You can invoke prototyped APIs without signing in to the API Developer Portal or subscribing to the API. The purpose of a prototype API is to advertise and provide an early implementation of the API for users to test.

     The Location API opens in the Developer Portal. 

2.  Click **Try Out** to navigate to the API Console.

     [![]({{base_path}}/assets/img/learn/create-api-prototype-dev-portal-overview.png)]({{base_path}}/assets/img/learn/create-api-prototype-dev-portal-overview.png)

3. Expand the `GET` method, click **Try it out**. 

4. Give any value for the town (e.g., London) and click **Execute** to invoke the API.

     [![]({{base_path}}/assets/img/learn/create-api-prototype-tryout-execute.png)]({{base_path}}/assets/img/learn/create-api-prototype-tryout-execute.png)

     Note that the payload that you gave as a JSON output appears in the response.

     [![]({{base_path}}/assets/img/learn/create-api-prototype-execute-response.png)]({{base_path}}/assets/img/learn/create-api-prototype-execute-response.png)

You have successfully created an API with inline script, deployed it as a prototype, and invoked it via the integrated API Console.


An API can also be prototyped by moving the API to the `PROTOTYPED` state by changing the API lifecycle state and providing the prototype endpoints. 

For more information, see the [Deploy and Test Prototype APIs](deploy-and-test-mock-apis.md) tutorial.

!!! info
    Related Guides
    
    - [Create and Publish an API]({{base_path}}/learn/design-api/create-api/create-a-rest-api/)
    
    - [Create a WebSocket API]({{base_path}}/learn/design-api/create-api/create-a-websocket-api/)

    - [Create an API from an Open API definition]({{base_path}}//learn/design-api/create-api/create-a-rest-api-from-a-swagger-definition/)


