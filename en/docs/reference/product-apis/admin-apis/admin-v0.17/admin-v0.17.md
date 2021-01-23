---
template: templates/swagger.html
---

!!! warning
    - The Admin v0.17 REST APIs will be deprecated in the next WSO2 API Manager release.
    - **[WSO2 recommends that you use the Admin v1 REST APIs]({{base_path}}/develop/product-apis/admin-apis/admin-v1/admin-v1)** as it is up to date and has support for the latest WSO2 API Manager 3.2.0 features with regard to the Admin Portal.

??? Info "Click here to see how to try out the APIs"
    Do the following to try out the REST APIs with your local instance of WSO2 API Manager

       1. Expand the relevant API operation and click the **Try It Out** button.

       2. Fill in relevant sample values for the input parameters and click **Execute**.

           You will receive a sample curl command with the sample values you filled in.
           
       3. Add a `-k` header to the curl command and run the curl command on the terminal with a running instance of WSO2 API-M.

<div id="swagger-ui"></div>
<script>
window.onload = function() {
  // Begin Swagger UI call region
  const ui = SwaggerUIBundle({
    url: "{{base_path}}/reference/product-apis/admin-apis/admin-v0.17/admin-v0.17.yaml",
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
