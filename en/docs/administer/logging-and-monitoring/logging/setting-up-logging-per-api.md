---
template: templates/swagger.html
---
# Setting up logging per API in API Manager

!!! note
    The mentioned feature is available only as a WUM update and is effective from 19th September 2020 (2020-09-19).

In a production envrionment, having the feasbility to monitor the HTTP message flow for a given API is important in identifying issues in the HTTP message flow.

This feature enables logging API requests at four levels.


1. Request coming to the gateway from client (request-in>>)
2. Request leaving the gateway to backend (request-out<<)
3. Request coming to the gateway from backend (response-in>>)
4. Request leaving to the client from gateway (response-out<<)

Depending on the nature of the request, you can chose only to log headers, body or both.

A REST API secured with basic authentication is provided to enable/disable API logs at the run time. Only a user with admin priviledges is able to invoke the API.

??? info "Click here to see how to try out the APIs"
    Do the following to try out the REST APIs with your local instance of WSO2 API Manager.

       1. Expand the relevant API operation and click the **Try It Out** button.

       2. Fill in relevant sample values for the input parameters and click **Execute**.

           You will receive a sample curl command with the sample values you filled in.

       3. Input the header `Authorization: Basic {base64encoded(username:passwd)}`. Here the username and passwd should be a user with admin priviledges. 
           
       4. Add a `-k` header to the curl command and run the curl command on the terminal with a running instance of WSO2 API-M.

      Example curl command format is shown below for user with username **admin** & password **admin** retrieving the API logging details. You can find more details in the documentaion below.
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