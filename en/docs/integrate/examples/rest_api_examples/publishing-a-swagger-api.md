# Publishing a Custom Swagger Document

When you create a REST API, a default Swagger definition is automatically
generated. You can access this Swagger document by suffixing the API URL
with `?swagger.json` or `?swagger.yaml`. See [Using Swagger Documents]({{base_path}}/integrate/develop/advanced-development/using-swagger-for-apis) for more information.

This example demonstrates how a custom Swagger definition is published for a REST API. 
    
## Synapse configuration
Following is a sample REST API configuration with a custom Swagger definition. See the instructions on how to [build and run](#build-and-run) this example.

!!! Note
    The custom Swagger file that you use for generating the API is saved to the Micro Integrator's registry. The `publishSwagger` element in the REST API configuration specifies the registry path. In this example, we are storing the Swagger definition in the <b>governance</b> registry as shown below.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<api context="/v2" name="SwaggerPetstore" publishSwagger="/_system/governance/swagger_files/simple_petstore.yaml" xmlns="http://ws.apache.org/ns/synapse">
    <resource methods="POST" url-mapping="/pet">
        <inSequence>
            <!--This is generated API skeleton.-->
            <!--Business Logic Goes Here-->
            <payloadFactory media-type="json">
                <format>{"Response" : "Sample Response"}</format>
                <args/>
            </payloadFactory>
            <loopback/>
        </inSequence>
        <outSequence>
            <respond/>
        </outSequence>
        <faultSequence/>
    </resource>
    <resource methods="GET" url-mapping="/pet/findByStatus">
        <inSequence>
            <!--This is generated API skeleton.-->
            <!--Business Logic Goes Here-->
            <payloadFactory media-type="json">
                <format>{"Response" : "Sample Response"}</format>
                <args/>
            </payloadFactory>
            <loopback/>
        </inSequence>
        <outSequence>
            <respond/>
        </outSequence>
        <faultSequence/>
    </resource>
</api>
```

## Build and run

Create the artifacts:

1. [Set up WSO2 Integration Studio]({{base_path}}/integrate/develop/installing-wso2-integration-studio).
2. [Create an integration project]({{base_path}}/integrate/develop/create-integration-project) with the modules listed below: 
    - <b>Config</b> project
    - <b>Registry</b> project
    - <b>Composite Application</b> project.
3. To create the REST API with the above configurations:
    - Download the Swagger file: [simple_petstore.yaml](https://github.com/wso2-docs/WSO2_EI/blob/master/samples-rest-apis/simple_petstore.yaml).
    - Follow the instructions on [creating a REST API]({{base_path}}/integrate/develop/creating-artifacts/creating-an-api).

4. [Deploy the artifacts]({{base_path}}/integrate/develop/deploy-artifacts) in your Micro Integrator.

Copy the following URLs to your browser to see the Swagger documents of your API:

- `http://localhost:8290/SwaggerPetstore?swagger.json`
- `http://localhost:8290/SwaggerPetstore?swagger.yaml`