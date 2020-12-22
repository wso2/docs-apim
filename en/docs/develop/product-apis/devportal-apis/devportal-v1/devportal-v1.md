---
template: templates/swagger.html
---

??? Info "Note: Click to view"
    Do the following to try out the REST APIs with your local instance of WSO2 API Manager.
     
       1. Expand the relevant API operation and click the **Try It Out** button.

       2. Fill in relevant sample values for the input parameters and click **Execute**.

           You will receive a sample curl command with the sample values you filled in. 

       3. Add the `Authorization: Bearer <access-token>` header to the cURL command. You may refer to [Getting Started Guide]({{base_path}}/develop/product-apis/getting-started/guide-devportal-v1) to see how to  obtain an access token with required scopes.
       
       4. Add a `-k` header to the cURL command and run the cURL command on the terminal with a running instance of WSO2 API-M.   
     
<div id="swagger-ui"></div>
<script>
window.onload = function() {
  // Begin Swagger UI call region
  const ui = SwaggerUIBundle({
    url: "{{base_path}}/develop/product-apis/devportal-apis/devportal-v1/devportal-v1.yaml",
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
