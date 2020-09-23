---
template: templates/swagger.html
---
# Setting up logging per API in API Manager

!!! note
    You need to get the [latest product updates for your product]({{base_path}}/administer/updating-wso2-api-manager/) to use this feature in the current version of WSO2 API-M. This feature is available as a product update in WSO2 API-M 3.1.0 from September 19, 2020 onwards.

    !!! warning
        Note that you can deploy updates in a production environment only if you have a valid subscription with WSO2. Read more about [WSO2 Updates](https://wso2.com/updates).

In a production environment, having the feasibility to monitor the HTTP message flow for a given API is important in identifying issues in the HTTP message flow.

This feature enables logging API requests at four levels.

1. Requests coming to the Gateway from the client (**request-in>>**).
2. Requests leaving the Gateway to the backend (**request-out<<**).
3. Requests coming to the Gateway from the backend (**response-in>>**).
4. Requests leaving to the client from the Gateway (**response-out<<**).

Depending on the nature of the request, you can choose only to log the headers or the body, or you can choose to log both the header and the body.

A REST API secured with basic authentication is provided to enable/disable API logs at the run time. Only a user with admin privileges is able to invoke the API.

??? info "Click here to see how to try out the APIs"
    Do the following to try out the REST APIs with your local instance of WSO2 API Manager.

       1. Expand the relevant API operation and click the **Try It Out** button.

       2. Fill in relevant sample values for the input parameters and click **Execute**.

           You will receive a sample cURL command with the sample values you filled in.

       3. Input the header `Authorization: Basic {base64encoded(username:password)}`. 
       
         Here the username and password should be a user with admin privileges. 
           
       4. Add a `-k` header to the cURL command and run the cURL command on the terminal with a running instance of WSO2 API-M.

      The format of a sample cURL command is shown below for a user with the username **admin** & password **admin** retrieving the API logging details. You can find more details in the documentation below.
      ```
      curl -X GET "https://localhost:9443/api/am/gateway/v0.9/api-logging" -H "Authorization: Basic YWRtaW46YWRtaW4=" -H "Content-Type: application/json"
      ```


<div id="swagger-ui"></div>
<script>
window.onload = function() {
  // Begin Swagger UI call region
  const ui = SwaggerUIBundle({
    url: "{{base_path}}/administer/logging-and-monitoring/logging/gw-api.yaml",
    dom_id: '#swagger-ui',
    deepLinking: true,
    validatorUrl: null,
    presets: [
      SwaggerUIBundle.presets.apis,
      SwaggerUIStandalonePreset
    ],
    plugins: [
      SwaggerUIBundle.plugins.DownloadUrl
    ],
    layout: "StandaloneLayout"
  })
  // End Swagger UI call region

  window.ui = ui
}
</script>
