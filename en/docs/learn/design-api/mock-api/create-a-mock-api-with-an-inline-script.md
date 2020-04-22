# Creating a Prototype API with Mock Payload Generated Inline Scripts

Prototype implementation in WSO2 API Manager gives users the ability to prototype APIs with inline scripts for testing purposes and as an early promotion. This allows subscribers to try out and test APIs without subscriptions or monetizations, allowing them to provide feedback to improve APIs. Publishers can use this to make changes to the APIs requested by users. Prototype implementation is now equipped with mock payload generation based on the API definition. Users can now prototype an API using the inbuilt javascript engine without having to manually write the javascript implementation for each resource.

Let's create a prototyped API with mock response payloads, deploy it as a prototype, and invoke it using the API Console, which is integrated in the API Developer Portal.

For this we will use the following swagger : https://petstore.swagger.io/v2/swagger.json

## Step 1 - Create a Prototype API with Mock Response Payloads

1. Click CREATE NEW API, and click I Have an Existing REST API.

   [![Create API options]({{base_path}}/assets/img/learn/create-api-existing-rest-api-link.png)]({{base_path}}/assets/img/learn/create-api-existing-rest-api-link.png)

2. Upload the OpenAPI URL or OpenAPI File and click NEXT.

   [![Filled create api form]({{base_path}}/assets/img/learn/create-api-form-swagger-petstore-filled.png)]({{base_path}}/assets/img/learn/create-api-form-swagger-petstore-filled.png)
    
3. Provide the API name, context, and version. Click CREATE.

   [![Filled create api form for existing]({{base_path}}/assets/img/learn/create-api-using-openapi-url-filled.png)]({{base_path}}/assets/img/learn/create-api-using-openapi-url-filled.png)
    
You are directed to the API overview page.

4. Click Endpoints to navigate to the Endpoints page.

5. Select Prototype Implementation as the endpoint type, and click ADD.

   [![Selecting Prototype Implementation to add]({{base_path}}/assets/img/learn/create-api-prototype-endpoint-add-swagger-petstore.png)]({{base_path}}/assets/img/learn/create-api-prototype-endpoint-add-swagger-petstore.png)

   You will be directed to the Endpoints page.
    
   [![List of endpoints in Inline script page]({{base_path}}/assets/img/learn/create-api-prototype-endpoint-page-swagger-petstore.png)]({{base_path}}/assets/img/learn/create-api-prototype-endpoint-page-swagger-petstore.png)

6. Clicking and expanding any of the methods which contains a sample/mock payload will show the inline script which has been generated.

   [![Generated inline script]({{base_path}}/assets/img/learn/create-api-prototype-generated-script.png)]({{base_path}}/assets/img/learn/create-api-prototype-generated-script.png)

The example response defined in the swagger is set as the mock response payload. The generated inline scripts can then be modified by the user. 

    ``` 
    var response200json = [ {                             // Mock response payload stored as a variable
      "id" : 0,
      "category" : {
        "id" : 0,
        "name" : "string"
      },
      "name" : "string",
      "photoUrls" : [ "string" ],
      "tags" : [ {
        "id" : 0,
        "name" : "string"
      } ],
      "status" : "available"
    } ]                                                 
    
    mc.setProperty('CONTENT_TYPE', 'application/json');  // Set the content type of the payload to the message context 
    mc.setPayloadJSON(response200json);                  // Set the new payload to the message context
    ```
    
7. Lets manually modify the inline script of “/pet/{petId}” to set a path parameter entered by the user to a variable that will satisfy a condition and set a response accordingly.

      !!! tip
   
        RESET button appears once a change is mood to the script. When pressed the script will revert back to the originally generated script.
        


   [![Modified inline script]({{base_path}}/assets/img/learn/create-api-prototype-generated-script-modified.png)]({{base_path}}/assets/img/learn/create-api-prototype-generated-script-modified.png)
   
   

    ```
    // **GENERATED CODE** //
    
    var response200json = [ {                            // Mock response payload stored as a variable
      "id" : 0,
      "category" : {
        "id" : 0,
        "name" : "string"
      },
      "name" : "string",
      "photoUrls" : [ "string" ],
      "tags" : [ {
        "id" : 0,
        "name" : "string"
      } ],
      "status" : "available"
    } ]                                                 
    
    // **MANUALLY ADDED CODE** //
    
    if (mc.getProperty('uri.var.petId') == 1) {          // Get the path parameter 'petID' to check the condition
      response200json = {
        "id" : 1,
        "category" : {
          "id" : 1,
          "name" : "Dog"
        },
        "name" : "doggie",
        "photoUrls" : [ "string" ],
        "tags" : [ {
          "id" : 1,
          "name" : "German Sheperd"
        } ],
        "status" : "available"
      }
    }
    
    mc.setProperty('CONTENT_TYPE', 'application/json');  // Set the content type of the payload to the message context 
    mc.setPayloadJSON(response200json);                  // Set the new payload to the message context

    ```
    
### Inline Script Methods  
    
The following table shows the mc. methods that can be used to invoke functions in the inline script. With these functions, it is possible to access the Synapse predefined in a script variable named mc. The mc variable represents an implementation of the MessageContext, named ScriptMessageContext.java, which contains the following methods that can be accessed within the script as mc.methodName.
    
| Return? | Method Name                        | Description                                                                                                                                                    |
|---------|------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Yes     | getPayloadXML()                    | This gets an XML representation of SOAP Body payload.                                                                                                          |
| No      | setPayloadXML(payload)             | This sets the SOAP body payload from XML.                                                                                                                      |
| Yes     | getEnvelopeXML()                   | This gets the XML representation of the complete SOAP envelope.                                                                                                |
| No      | setTo(reference)                   | This is used to set the value which specifies the receiver of the message.                                                                                     |
| Yes     | setFaultTo(reference)              | This is used to set the value which specifies the receiver of the faults relating to the message.                                                              |
| No      | setFrom(reference)                 | This is used to set the value which specifies the sender of the message.                                                                                       |
| No      | setReplyTo(reference)              | This is used to set the value which specifies the receiver of the replies to the message.                                                                      |
| Yes     | getPayloadJSON()                   | This gets the JSON representation of a SOAP Body payload.                                                                                                      |
| No      | setPayloadJSON( payload )          | This sets the JSON representation of a payload obtained via the `             getPayloadJSON()            ` method and sets it in the current message context. |
| Yes     | getProperty(name)                  | This gets a property from the current message context.                                                                                                         |
| No      | setProperty(key, value)            | This is used to set a property in the current message context. The previously set property values are replaced by this method.                                 |
    
    
8. Click SAVE to save the API.

   [![Save button Inline scripts page]({{base_path}}/assets/img/learn/create-api-prototype-click-save.png)]({{base_path}}/assets/img/learn/create-api-prototype-click-save.png)

## Step 2 - Deploy the API as a prototype

1. Click Lifecycle to navigate to the Lifecycle page.

2. Click DEPLOY AS A PROTOTYPE to deploy the API as a prototype.

   [![Lifecycle page]({{base_path}}/assets/img/learn/create-api-prototype-lc-page-petstore.png)]({{base_path}}/assets/img/learn/create-api-prototype-lc-page-petstore.png)

## Step 3 - Invoke the API

1. Click View in Dev Portal to navigate to the API Developer Portal after the API is deployed.

2. Click Try Out to navigate to the API Console

   [![Devportal overview]({{base_path}}/assets/img/learn/create-api-prototype-dev-portal-overview-petstore.png)]({{base_path}}/assets/img/learn/create-api-prototype-dev-portal-overview-petstore.png)

3. Expand any method and click Try it out.

   [![Tryout click]({{base_path}}/assets/img/learn/create-api-prototype-tryout-click.png)]({{base_path}}/assets/img/learn/create-api-prototype-tryout-click.png)

4. Give the value for the parameter and click Execute to invoke the API.

   Note that the payload that you gave as a JSON/XML output appears in the response for each respective parameter provided.

    i). For petId : “ 0 ” :

   [![Tryout for petid0]({{base_path}}/assets/img/learn/create-api-prototype-tryout-execute-petid0.png)]({{base_path}}/assets/img/learn/create-api-prototype-tryout-execute-petid0.png)
 
   Response payload defined in the generated script is returned.
   
   [![Response for petid0]({{base_path}}/assets/img/learn/create-api-prototype-execute-response-petid0.png)]({{base_path}}/assets/img/learn/create-api-prototype-execute-response-petid0.png)

    ii). For petId : “ 1 ” :

   [![Tryout for petid1]({{base_path}}/assets/img/learn/create-api-prototype-tryout-execute-petid1.png)]({{base_path}}/assets/img/learn/create-api-prototype-tryout-execute-petid1.png)

   Response payload defined in the manually modified script is returned.

   [![Response for petid1]({{base_path}}/assets/img/learn/create-api-prototype-execute-response-petid1.png)]({{base_path}}/assets/img/learn/create-api-prototype-execute-response-petid1.png)
   
   
You have successfully created an API with inline script, deployed it as a prototype, and invoked it via the integrated API Console.

An API can also be prototyped by moving the API to the PROTOTYPED state by changing the API lifecycle state and providing the prototype endpoints.

For more information, see the [Deploy and Test Prototype APIs](deploy-and-test-mock-apis.md) tutorial.

!!! info
    Related Guides
    
    - [Create and Publish an API]({{base_path}}/learn/design-api/create-api/create-a-rest-api/)
    
    - [Create a WebSocket API]({{base_path}}/learn/design-api/create-api/create-a-websocket-api/)

    - [Create an API from an Open API definition]({{base_path}}//learn/design-api/create-api/create-a-rest-api-from-a-swagger-definition/)

