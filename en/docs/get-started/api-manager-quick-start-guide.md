# Quick Start Guide - API Management

New to WSO2 API Manager? No worries; we'll guide you through the basics!

In this step-by-step guide, you’ll learn how to create, publish, and invoke an API using the Publisher Portal and Developer Portal.

### Before you begin...

Chose a deployment option to start WSO2 API Manager.

=== "Docker"

    Run WSO2 API Manager using Docker

    1. Install [Docker](https://docs.docker.com/get-docker/) 
    2. Pull and Start WSO2 API Manager using the following command.

       ```bash
       docker run -it -p 9443:9443 -p 8243:8243 -p 8280:8280 wso2/wso2am:4.4.0
       ```

    !!! note

        - The `docker run` command will start WSO2 API Manager and expose the ports `9443`, `8243`, and `8280`.
        - The default admin credentials for WSO2 API Manager are `admin/admin`.

=== "Direct"
    
    Download and run WSO2 API Manager manually

    1. Install [Java SE Development Kit (JDK)](https://adoptium.net/temurin/releases/?arch=any&version=21) version 21 and set the `JAVA_HOME` environment variable.
    For more information on setting the `JAVA_HOME` environment variable for different operating systems.
    
    !!! note

        Refer to the [Setup and Install]({{base_path}}/install-and-setup/install/installing-the-product/installing-api-m-runtime/#setting-up-java_home) for a step-by-step guide on configuring Java.

    2. Download WSO2 API-Manager
        - [Open Source Distribution](https://github.com/wso2/product-apim/releases/tag/v4.4.0)
        - [WSO2 Official Distribution](https://wso2.com/api-manager/#)
    
    3. Start WSO2 API-M by navigating to the `<API-M_HOME>/bin` directory using the command-line and execute the following command.
        
        === "Windows"

            ```
            api-manager.bat --run
            ```
        === "Unix"

            ```
            sh api-manager.sh
            ```

### What you'll build

In this sample scenario, you implement a full lifecycle of an API using WSO2 API Manager.

<a href="{{base_path}}/assets/img/get_started/apim-qsg-diagram.png"><img src="{{base_path}}/assets/img/get_started/apim-qsg-diagram.png" width="60%"></a>

1. Creating and publishing an API via the Publisher Portal of WSO2 API-M.
2. Deploy the API in a Gateway environment.
3. Publish the API in the Developer Portal.
2. Subscribing to the API via the Developer Portal of WSO2 API-M and generating keys.
3. Invoking the API with the generated keys.

 Let's get started...

### Step 1 - Create and publish an API

Follow the instructions below to create and publish an API via the Publisher Portal of WSO2 API-M.

1. Navigate to the Publisher Portal.
   
     [https://localhost:9443/publisher](https://localhost:9443/publisher)
     
2. Sign in with **`admin/admin`** as the credentials.
                                                 
     [![Publisher portal home page]({{base_path}}/assets/img/get_started/api-publisher-home.png)]({{base_path}}/assets/img/get_started/api-publisher-home.png)

3. Create a mock REST service.

    Let's use a mock REST service to create a REST API from scratch. 
    
    Navigate to the [Mocky.io](https://designer.mocky.io/design) website and create a mock service by providing following configurations.
    
    | Field                   | Value                 |
    | ----------------------- |-----------------------|
    | `HTTP Status`           | 200 - OK              |
    | `Response Content Type` | application/json      |
    | `Charset`               | UTF-8                 |
    | `HTTP Response Body`    | `{"hello": "world"}`  |

    Finally click **Generate My HTTP Response** to save and generate the mock service url.

    
4. Select **REST API** from the home screen and then click **Start From Scratch**.
   
    [![Design a new REST API]({{base_path}}/assets/img/get_started/design-new-rest-api.png)]({{base_path}}/assets/img/get_started/design-new-rest-api.png)


5. Enter the API details.

    <table>
    <tr> 
     <th>
     Name
     </th>
     <td>
     HelloWorld
     </td>
     </tr>
     <tr> 
     <th>Context
     </th>
     <td><code>/hello</code>
     </td>
     </tr>
     <tr> 
     <th>Version
     </th>
     <td>1.0.0
     </td>
     </tr>
     <tr> 
     <th>Endpoint
     </th>
     <td><code>https://run.mocky.io/v3</code>
      <div class="admonition note">
      <p class="admonition-title">Note</p>
      <p><b>Use the HTTP protocol</b> because to use HTTPS you need to import the mock json server's certificate into WSO2 API-M.</p>
      </div> 
     </td>
     </tr>
     </table>
     
     [![Create an API]({{base_path}}/assets/img/get_started/api-create.png){: style="width:60%"}]({{base_path}}/assets/img/get_started/api-create.png)
        
6. Click **Create & Publish**.

     This will publish your first API on the Developer Portal as well as deploy it on the API Gateway. You now have an OAuth 2.0 secured REST API that is ready to be consumed.

<a name="subscribe"></a>

### Step 2 - Subscribe to the API

Follow the instructions below to subscribe to the API and generate the keys via the Developer Portal of WSO2 API-M.

1. Navigate to the Developer Portal.

     [https://localhost:9443/devportal](https://localhost:9443/devportal)
    
     The published `HelloWorld` API is listed in the Developer Portal as shown below.

     [![Developer Portal home page]({{base_path}}/assets/img/get_started/dev-portal-landing-page.png)]({{base_path}}/assets/img/get_started/dev-portal-landing-page.png)

2. Click **Sign-In** and enter **`admin/admin`** as your credentials to sign in to the Developer Portal.

3. Click on the API thumbnail to view the overview of the API.

     [![API overview]({{base_path}}/assets/img/get_started/api-overview.png)]({{base_path}}/assets/img/get_started/api-overview.png)
 
4. Register an OAuth 2.0 application.

    1. Click **Subscriptions** on the left menu bar of the screen.
    
        [![Subscription Card]({{base_path}}/assets/img/get_started/subscriptions-menu.png)]({{base_path}}/assets/img/get_started/subscriptions-menu.png)
    
    2. Click **SUBSCRIPTION & KEY GENERATION WIZARD** in the above screen.
    
         This wizard walks you through 5 steps that will register an OAuth 2.0 application which you will use to consume the `HelloWorld` API.

<a name="invoke"></a>

### Step 3 - Invoke the API

Follow the instructions below to invoke the previously created API with the generated keys.

1. Click **Try Out** on the left menu bar.

     The resources of the API will be listed.

2. Paste the access token that you previously copied in the **Access Token** field.

    [![Paste the access token]({{base_path}}/assets/img/get_started/test-api.png)]({{base_path}}/assets/img/get_started/test-api.png)

3. **If this is the first time you are using the API test console** from your browser,  open a new tab and navigate to the [https://localhost:8243/](https://localhost:8243/) URL.

     This will prompt your browser to accept the certificate used by the API Gateway. This is required because by default the API Gateway uses a self-signed certificate that is not trusted by web browsers.
    
    !!! note

        This certificate that is used by the API Gateway is replaced when deploying the system in production.

4. Click on the `GET` resource of the API to expand the resource and Click **Try It Out**.
   
     [![GET resource]({{base_path}}/assets/img/get_started/expanded-get-resource.png)]({{base_path}}/assets/img/get_started/expanded-get-resource.png)

5. Click **Execute**.

     [![GET resource]({{base_path}}/assets/img/get_started/try-api.png)]({{base_path}}/assets/img/get_started/try-api.png)

     You should see the `{"hello" : "world"}` response from the API. 

     [![Successful response]({{base_path}}/assets/img/get_started/try-it-success.png)]({{base_path}}/assets/img/get_started/try-it-success.png)

__Congratulations!__ With that, you've created, deployed, and published your first API. Next, you subscribed to it and put it to the test. Your journey with WSO2 API Manager has officially begun!
