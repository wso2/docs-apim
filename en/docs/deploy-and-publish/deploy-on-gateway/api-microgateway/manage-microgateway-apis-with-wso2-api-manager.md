# Manage Microgateway APIs with WSO2 API Manager

[WSO2 API Manager]({{apim_path}}) can be used as  management plane for the APIs deployed in microgateway. Publisher portal of WSO2 API manager can maintain all the details about the API and also keep track of the lifecyle states of the APIs deployed in microgateways.

The developer portal of API Manager can be used for API discovery purposes for application developers . Developer portal is the market place where application developers can search and use APIs exposed in microgateway.

The open API definition used to deploy the API in microgateway can be used to create the API in WSO2 API Manager as well. [APICTL]({{apim_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller/) (WSO2 API Controller) is a CLI tool to migrate APIs among different environments of WSO2 API manager.  This CLI tool can be used to import the API deployed in microgateway to API manager using the same open API definition.

1.  Assume Microgateway is deployed using an open API definition, and WSO2 API manager is installed and running properly. And also the API contoller is also installed your development environment.

2.  Follow the [Importing APIs Via Dev First Approach]({{apim_path}}/install-and-setup/setup/api-controller/importing-apis-via-dev-first-approach/) , in order to import the API from open API definition to WSO2 API manager
3.  Once API is successfullty imported to WSO2 API Manager. Navigate to the developer portal ( <https://localhost:9443/devportal> ). You can see the imported API is listed under the APIs. [Subscribe to the API]({{apim_path}}/consume/manage-subscription/subscribe-to-an-api/#subscribe-to-an-api) and [generate access tokens]({{apim_path}}/consume/manage-application/generate-keys/generate-api-keys/#generate-application-keys).
4.  Now you can invoke the API through the Microgateway using the generated tokens.

