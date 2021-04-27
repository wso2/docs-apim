# Create an API from an Open API Definition

An OpenAPI definition is a format that describes REST APIs. 

Follow the instructions below to create a REST API using an Open API definition for an existing API.

## Create an API using the basic flow

1. Sign in to the WSO2 API Publisher.

     `https://<hostname>:9443/publisher` (e.g., `https://localhost:9443/publisher`).

    <html><div class="admonition note">
      <p class="admonition-title">Note</p>
      <p>The <b>CREATE API</b> button will only appear if the user who has signed in has the creator role permission.</p>
      </div>
    </html>

2. Click **CREATE API** and then click **I have an existing REST API**.

    [![Create an API]({{base_path}}/assets/img/learn/import-open-api.png)]({{base_path}}/assets/img/learn/import-open-api.png)

3. Select one of the following options:

	* **OpenAPI URL** - If you select this option, you need to provide an endpoint URL.
	* **OpenAPI Archive/File** - If you select this option, click **Browse** and upload either an individual Open API definition or an archive that has an Open API definition with external <a href="https://Swagger.io/docs/specification/using-ref/" target="_blank">file references</a>.

    <html><div class="admonition note">
    <p class="admonition-title">Note</p>
    <p>
    You need to upload an archive if you have remote references in your API definition. If it is a single Swagger file without remote references it can be imported directly, without zipping. 
    When uploading an OpenAPI archive, the master Swagger file should be named as **swagger.yaml**/**swagger.json**. 
    If not, the validation will fail at the point of API creation. Referenced files can be named independently.
    </p>
    </div>
    </html>
    
    !!! tip
        The Swagger definitions should be placed under one root folder and zipped.    
   
        **Sample folder structures**
    
        ```
            -masterFolder
              ---Swagger.json
              ---reference.json
              ---add.json
        ```
        ```
            -masterFolder
              ---Swagger.json
              ---schemes
                 ---pet.json
              ---add.json
        ```

        In the above sample, every Swagger definition is placed inside one root folder namely `masterFolder`.

4.  Select **OpenAPI URL** and provide `http://petstore.swagger.io/v2/swagger.json` as the URL. Click **NEXT**.

     [![Create a REST API using swagger definition]({{base_path}}/assets/img/learn/create-rest-api-using-swagger-def-form1.jpg)]({{base_path}}/assets/img/learn/create-rest-api-using-swagger-def-form1.jpg)

5.  Edit the information as given below and click **CREATE**.

     | Field   | Sample value |
     |---------|--------------|
     | Name    | SwaggerPetstore     |
     | Context | /v2          |
     | Version | 1.0.5        |
 
     [![Create a REST API using swagger definition]({{base_path}}/assets/img/learn/create-rest-api-using-swagger-def-form2.png)]({{base_path}}/assets/img/learn/create-rest-api-using-swagger-def-form2.png)

     The Petstore API overview page appears.

     [![]({{base_path}}/assets/img/learn/overviewpage-rest-api-creating-by-swagger-def.png)]({{base_path}}/assets/img/learn/overviewpage-rest-api-creating-by-swagger-def.png)

### Resources
   
Click **Resources** to navigate to the resources page. 

You will notice that all the API resources are created automatically when the OpenAPI URL is specified.
   
[![]({{base_path}}/assets/img/learn/resource-of-pet-store-api.png)]({{base_path}}/assets/img/learn/resource-of-pet-store-api.png)

### API Definition

1. Click **API Definition** and click **Edit** to remove the security headers. 

     This is required to invoke the API in the Developer Portal using the OpenAPI UI.
    
     [![]({{base_path}}/assets/img/learn/edit-api-definition-pet-store.png)]({{base_path}}/assets/img/learn/edit-api-definition-pet-store.png)


2. Remove the `petstore_auth` tag related configuration that appears under the `security` tag from the `/pet` POST resource given below. 

    !!! note
        Do not remove the `default` tag related configuration that appears under the `security` tag.

     **OpenAPI - Post resource**

    ``` java
    security:
        - petstore_auth:
            - 'write:pets'
            - 'read:pets'
        - default:
            - 'write:pets'
            - 'read:pets'
    ```

3.  Remove the security `pet/{petId}` GET resource given below:

     **OpenAPI - Get resource**

    ``` java
            //remove the following code snippet
    security:
            - api_key: []
    ```
4.  After removing the security tags, click **Update Contents** to save the changes.
     
     [![]({{base_path}}/assets/img/learn/update-content-pet-store.png)]({{base_path}}/assets/img/learn/update-content-pet-store.png)

### Endpoints

1. Navigate to the **Endpoints** page.

2. Enter the information shown below.

     | Field               | Sample value                                          |
     |---------------------|-------------------------------------------------------|
     | Endpoint type       | HTTP/REST endpoint                                    |
     | Production endpoint | http://petstore.swagger.io/v2/                        |
     | Sandbox endpoint    | Let's only work with the production endpoint for this sample. Therefore, uncheck the sandbox endpoint option. |

     <html>
     <img src="{{base_path}}/assets/img/learn/endpoint-menu.png" width="200">
     </html>

3. Click **SAVE**.

     [![]({{base_path}}/assets/img/learn/add-endpoint-configuration-for-pet-store-api.png)]({{base_path}}/assets/img/learn/add-endpoint-configuration-for-pet-store-api.png)

### Runtime Configuration

Click **Runtime** to navigate to the runtime configurations that correspond to the API.
     
The Transport Level Security defines the transport protocol on which the API is exposed.
     
<html>
<img src="{{base_path}}/assets/img/learn/runtime-config-menu.png" width="200">
</html>

<html>
    <img src="{{base_path}}/assets/img/learn/transport-level-security-pet-store.png" height="400" width="700">
    </html>

<html><div class="admonition note">
    <p class="admonition-title">Note</p>
    <p> Both HTTP and HTTPS transports are selected by default. It is able to limit the API availability to only one transport (e.g., HTTPS) by clearing the checkbox of the other transport.</p>
    </div>
    </html>

<html><div class="admonition note">
    <p class="admonition-title">Note</p>
    <p> Transport Level Security defines the transport protocol on which the API is exposed. When creating a new API by using a Swagger or Open API definition, these transport security schemes can be defined using  <b>“x-wso2- transports”</b>and <b>"x-wso2-mutual-ssl”</b>extensions.</p>
        ```yaml
        x-wso2-mutual-ssl: "optional"
        x-wso2-transports: 
            - "https"
            - “http”
        ```
</div></html>

## Subscriptions

1. Click **Subscriptions**.

     <html>
     <img src="{{base_path}}/assets/img/learn/subscriptions-menu.png" width="200">
     </html>

2. Select **Gold** and **Silver** as the Bussiness plans.

     <html><div class="admonition note">
     <p class="admonition-title">Note</p>
     <p> The API can be available at different levels of the service. They allow you to limit the number of successful hits to an API during a given period of time.</p>
     </div>
     </html>

3. Click **SAVE**

    [![]({{base_path}}/assets/img/learn/add-bussiness-plans-for-pet-store-api.png)]({{base_path}}/assets/img/learn/add-bussiness-plans-for-pet-store-api.png)


Now, a REST API from an Open API Definition has been created and configured successfully. 

Next, publish the API, for more information, see [Publish an API]({{base_path}}/deploy-and-publish/publish-on-dev-portal/publish-an-api).
