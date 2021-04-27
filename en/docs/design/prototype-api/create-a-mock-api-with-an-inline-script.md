# Creating a Prototype API with Mock Payload Generated Inline Scripts

The prototype implementation in WSO2 API Manager gives users the ability to prototype APIs with inline scripts for testing purposes and as an early promotion. This allows subscribers to try out and test APIs without subscriptions or monetizations, allowing them to provide feedback to improve APIs. Publishers can use this to make changes to the APIs requested by users. The WSO2 API Manager prototype implementation allows you to generate a mock payload based on an API definition. You can prototype an API using the inbuilt JavaScript engine without having to manually write the JavaScript implementation for each resource.

Let's create a prototyped API with mock response payloads, deploy it as a prototype, and invoke it using the API Console, which is integrated into the Developer Portal.

For this let's use the following OpenAPI URL: `https://petstore3.swagger.io/api/v3/openapi.json`

## Step 1 - Create a prototype API with mock response payloads

1. Click **CREATE API** and click **Import Open API**.

    <a href="{{base_path}}/assets/img/learn/create-api-existing-rest-api-link.png"><img src="{{base_path}}/assets/img/learn/create-api-existing-rest-api-link.png" alt="importing open api"></a>

2. Upload the OpenAPI URL or OpenAPI File and click **Next**.

    <a href="{{base_path}}/assets/img/learn/create-api-using-openapi-url-filled.png"><img src="{{base_path}}/assets/img/learn/create-api-using-openapi-url-filled.png" alt="create api form for existing api"></a>
    
3. Provide the API name, context, and version. Thereafter, click **Create**.

    <a href="{{base_path}}/assets/img/learn/create-api-form-swagger-petstore-filled.png"><img src="{{base_path}}/assets/img/learn/create-api-form-swagger-petstore-filled.png" alt="provide api details"></a>
         
    Now you will be directed to the API overview page.

4. Click **Endpoints** to navigate to the Endpoints page and select **Prototype Implementation** as the endpoint type.

    <a href="{{base_path}}/assets/img/learn/create-api-prototype-endpoint-add-swagger-petstore.png"><img src="{{base_path}}/assets/img/learn/create-api-prototype-endpoint-add-swagger-petstore.png" alt="select prototype implementation"></a>

5. Click and expand any of the methods that contain a sample/mock payload to view the inline script that has been generated.

     [![Generated inline script]({{base_path}}/assets/img/learn/create-api-prototype-generated-script.png)]({{base_path}}/assets/img/learn/create-api-prototype-generated-script.png)

     The example response defined in the OpenAPI definition is set as the mock response payload. You can modify the generated inline scripts as required. 

      ``` 
      responses[200]["application/json"] = {              // Mock response payload stored as a variable
        "id" : 10,
        "name" : "doggie",
        "category" : {
          "id" : 1,
          "name" : "Dogs"
        },
        "photoUrls" : [ "string" ],
        "tags" : [ {
          "id" : 0,
          "name" : "string"
        } ],
        "status" : "available"
      };                                                 
      
      mc.setProperty('CONTENT_TYPE', 'application/json');  // Set the content type of the payload to the message context 
      mc.setPayloadJSON(response200json);                  // Set the new payload to the message context
      ```
    
6. Modify the inline script for `/pet/{petId}`.

     Set a path parameter entered by the user to a variable that will satisfy a condition and set a response accordingly.

    !!! tip
   
        The **RESET** button appears after a change is made to the script. When pressed, the script will revert back to the originally generated script.
        

     [![Modified inline script]({{base_path}}/assets/img/learn/create-api-prototype-generated-script-modified.png)]({{base_path}}/assets/img/learn/create-api-prototype-generated-script-modified.png)
   
   

      ```
      // **GENERATED CODE** //
      
      responses[200]["application/json"] = {                 // Mock response payload stored as a variable
        "id" : 10,
        "name" : "doggie",
        "category" : {
          "id" : 1,
          "name" : "Dogs"
        },
        "photoUrls" : [ "string" ],
        "tags" : [ {
          "id" : 0,
          "name" : "string"
        } ],
        "status" : "available"
      };                                                
      
      // **MANUALLY ADDED CODE** //
      
      if (mc.getProperty('uri.var.petId') == 1) {          // Get the path parameter 'petID' to check the condition
        responses[200]["application/json"] = {
          "id" : 1,
          "category" : {
            "id" : 1,
            "name" : "Dog"
          },
          "name" : "doggie",
          "photoUrls" : [ "https://www.google.com/search?q=pet+images&client=ubuntu&hs=NYm&channel=fs&tbm=isch&source=iu&ictx=1&fir=ZgS81JuMKfVpqM%252CF26KAcU9PVtkCM%252C_&vet=1&usg=AI4_-kQjTnWk4IVhQbkQmoFJ6zFxD1IynA&sa=X&ved=2ahUKEwjt7e2Rj9fsAhUg6XMBHTZBCuIQ9QF6BAgCEFc#imgrc=ZgS81JuMKfVpqM" ],
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
          
    The following table lists down the `mc.` methods that you can use to invoke functions in the inline script. You can use these functions to access the Synapse predefined in a script variable named `mc`. The `mc` variable represents an implementation of the `MessageContext`, named `ScriptMessageContext.java`, which contains the following methods, that you can access within the script as `mc.methodName`.
          
      | **Return?** | **Method Name**                        | **Description**                                                                                                                                                    |
      |---------|------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------|
      | Yes     | getPayloadXML()                    | This gets an XML representation of SOAP body payload.                                                                                                          |
      | No      | setPayloadXML(payload)             | This sets the SOAP body payload from XML.                                                                                                                      |
      | Yes     | getEnvelopeXML()                   | This gets the XML representation of the complete SOAP envelope.                                                                                                |
      | No      | setTo(reference)                   | This is used to set the value that specifies the receiver of the message.                                                                                     |
      | Yes     | setFaultTo(reference)              | This is used to set the value that specifies the receiver of the faults relating to the message.                                                              |
      | No      | setFrom(reference)                 | This is used to set the value that specifies the sender of the message.                                                                                       |
      | No      | setReplyTo(reference)              | This is used to set the value that specifies the receiver of the replies to the message.                                                                      |
      | Yes     | getPayloadJSON()                   | This gets the JSON representation of a SOAP Body payload.                                                                                                      |
      | No      | setPayloadJSON( payload )          | This sets the JSON representation of a payload obtained via the `             getPayloadJSON()            ` method and sets it in the current message context. |
      | Yes     | getProperty(name)                  | This gets a property from the current message context.                                                                                                         |
      | No      | setProperty(key, value)            | This is used to set a property in the current message context. The previously set property values are replaced by this method.                                 |
      
7. Click **SAVE** to save the API.

     <a href="{{base_path}}/assets/img/learn/create-api-prototype-click-save.png"><img src="{{base_path}}/assets/img/learn/create-api-prototype-click-save.png" alt="save inline scripts page"></a>

## Step 2 - Deploy the API as a prototype

1. Click **Lifecycle** to navigate to the Lifecycle page.

2. Click **Deploy as a Prototype** to deploy the API as a prototype.

    <a href="{{base_path}}/assets/img/learn/create-api-prototype-lc-page-petstore.png"><img src="{{base_path}}/assets/img/learn/create-api-prototype-lc-page-petstore.png" alt="deploy as prototype"></a>

## Step 3 - Invoke the API

1. Click **View in Dev Portal** to navigate to the Developer Portal after the API is deployed.

2. Click **Try Out** to navigate to the API Console.

     <a href="{{base_path}}/assets/img/learn/create-api-prototype-dev-portal-overview-petstore.png"><img src="{{base_path}}/assets/img/learn/create-api-prototype-dev-portal-overview-petstore.png" alt="try out prototype"></a>

3. Expand any method and click **Try it out**.

     [![Tryout click]({{base_path}}/assets/img/learn/create-api-prototype-tryout-click.png)]({{base_path}}/assets/img/learn/create-api-prototype-tryout-click.png)

4. Enter the value for the parameter and click **Execute** to invoke the API.

    !!! note 
        The payload that you gave as a JSON/XML output appears in the response for each respective parameter provided.

    1. For `petId : " 0 " `

         [![Tryout for petid0]({{base_path}}/assets/img/learn/create-api-prototype-tryout-execute-petid0.png)]({{base_path}}/assets/img/learn/create-api-prototype-tryout-execute-petid0.png)
 
        The response payload that is defined in the generated script is returned.
   
        [![Response for petid0]({{base_path}}/assets/img/learn/create-api-prototype-execute-response-petid0.png)]({{base_path}}/assets/img/learn/create-api-prototype-execute-response-petid0.png)

    2. For `petId : " 1 " `

        [![Tryout for petid1]({{base_path}}/assets/img/learn/create-api-prototype-tryout-execute-petid1.png)]({{base_path}}/assets/img/learn/create-api-prototype-tryout-execute-petid1.png)

        The response payload defined in the manually modified script is returned.

        [![Response for petid1]({{base_path}}/assets/img/learn/create-api-prototype-execute-response-petid1.png)]({{base_path}}/assets/img/learn/create-api-prototype-execute-response-petid1.png)
   
   
You have successfully created an API with an inline script, deployed it as a prototype, and invoked it via the integrated API Console.

An API can also be prototyped by moving the API to the `PROTOTYPED` state by changing the API lifecycle state and providing the prototype endpoints.

For more information, see the [Deploy and Test Prototype APIs]({{base_path}}/design/prototype-api/deploy-and-test-mock-apis) tutorial.

<div class="admonition info">
<p class="admonition-title">Related Guides</p>

<p>
    <ul>
    <li>Create and Publish an API
<ul>
          <li> <a href="{{base_path}}/deploy-and-publish/publish-on-dev-portal/publish-an-api">Create and Publish an API</a></li>

          <li> <a href="{{base_path}}/design/create-api/create-rest-api/create-a-rest-api">Create and Publish an API</a> </li>
    </ul>
    <li>
    <a href="{{base_path}}/design/create-api/create-a-websocket-api">Create a WebSocket API </a>
</li>
<li>
    <a href="{{base_path}}/design/create-api/create-rest-api/create-a-rest-api-from-a-swagger-definition">Create an API from an OpenAPI definition</a></li>
  </p>
  </div>
