# Quick Start Guide

New to **WSO2 API Manager**? Not to worry, we'll guide you with the basics!

In this step-by-step guide, you’ll learn how to create, publish, and invoke an API using the Publisher and Developer Portals.

### Before you begin...

Choose a deployment option to start WSO2 API Manager.

=== "Run locally"

    Here's how you can download and run WSO2 API Manager locally:

    1. Install [Java SE Development Kit (JDK)](https://adoptium.net/temurin/releases/?arch=any&version=21) version **21** and set the `JAVA_HOME` environment variable.
    
        !!! tip
            For more information on setting the `JAVA_HOME` environment variable for different operating systems, see [Setup and Install]({{base_path}}/install-and-setup/install/installing-the-product/installing-api-m-runtime/#setting-up-java_home)

    2. Download WSO2 API-Manager.
        - [Open Source Distribution](https://github.com/wso2/product-apim/releases/tag/v4.4.0)
        - [WSO2 Official Distribution](https://wso2.com/api-manager/#)
    
    3. Extract the downloaded zip file.

    4. Navigate to the `<API-M_HOME>/bin` folder from your command line.
    
    4. To start WSO2 API Manager, execute the relevant command:

        === "On MacOS/Linux"
            ```bash
            sh api-manager.sh
            ```
        
        === "On Windows"
            ```bash
            api-manager.bat --run
            ```

=== "Run on Docker"

    Here's how you can run WSO2 API Manager using Docker:

    1. Install [Docker](https://docs.docker.com/get-docker/) if you haven't done so already.
    2. Pull and start WSO2 API Manager by executing the following command:

        ```bash
        docker run -it -p 9443:9443 -p 8243:8243 -p 8280:8280 wso2/wso2am:4.4.0
        ```

        !!! note

            - The `docker run` command will start WSO2 API Manager and expose the ports `9443`, `8243`, and `8280`.

### What you'll build

In this sample scenario, you'll implement the full lifecycle of an API using WSO2 API Manager.

<a href="{{base_path}}/assets/img/get_started/apim-qsg-diagram.png"><img src="{{base_path}}/assets/img/get_started/apim-qsg-diagram.png" width="60%"></a>

Here are the steps that we are going to follow:

- [Step 1: Create, Deploy and Publish an API](#step-1-create-deploy-and-publish-an-api)
- [Step 2: Subscribe to the API](#step-2-subscribe-to-the-api)
- [Step 3: Invoke the API](#step-3-invoke-the-api)

Let's get started...

### Step 1: Create, Deploy and Publish an API

Follow the instructions below to create, deploy and publish an API via the Publisher Portal of WSO2 API-M.

1. Navigate to the Publisher Portal.
   
     [https://localhost:9443/publisher](https://localhost:9443/publisher)
     
2. Sign in with **`admin/admin`** as the credentials.
                                                 
     [![Publisher portal home page]({{base_path}}/assets/img/get_started/api-publisher-home.png)]({{base_path}}/assets/img/get_started/api-publisher-home.png)

3. Next, let's create a mock REST service by navigating to [Mocky.io](https://designer.mocky.io/design). You can provide the following configuration in order to create a mock service.
    
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
     <td><code>https://run.mocky.io/v3/e42a76f0-95f3-4759-b658-dcc2b0c8bacd</code>
     </td>
     </tr>
     </table>
     
     [![Create an API]({{base_path}}/assets/img/get_started/api-create.png){: style="width:60%"}]({{base_path}}/assets/img/get_started/api-create.png)
        
6. Click **Create & Publish**.

     This will publish your first API on the Developer Portal as well as deploy it on the API Gateway. You now have an OAuth 2.0 secured REST API that is ready to be consumed.

<a name="subscribe"></a>

### Step 2: Subscribe to the API

Follow the instructions below to subscribe to the API via the Developer Portal of WSO2 API-M.

1. Navigate to the Developer Portal.

     [https://localhost:9443/devportal](https://localhost:9443/devportal)
    
     The published `HelloWorld` API is listed in the Developer Portal as shown below.

     [![Developer Portal home page]({{base_path}}/assets/img/get_started/dev-portal-landing-page.png)]({{base_path}}/assets/img/get_started/dev-portal-landing-page.png)

2. Click **Sign-In** and enter **`admin/admin`** as your credentials to sign in to the Developer Portal.

3. Once you click on the HelloWorld API, you will be redirected to  the API overview page. Then, go ahead and click on the **TRY OUT** button.

     [![API try out]({{base_path}}/assets/img/get_started/try-out.png)]({{base_path}}/assets/img/get_started/try-out.png)

     And with that, we have subscribed to the API using the `DefaultApplication`.

 **Voila!!!** You have now subscribed to the API and is ready for you to test out **HelloWorld** API.

<a name="invoke"></a>

### Step 3: Invoke the API

Follow the instructions below to invoke the created API.

1. Click on **Try Out** &rarr; **API Console** from the left menu. Then, click on **GET TEST KEY** to generate a test access token.

     [![Test API]({{base_path}}/assets/img/get_started/test-api.png)]({{base_path}}/assets/img/get_started/test-api.png)

2. **If this is the first time you are using the API test console** from your browser,  open a new tab and navigate to the [https://localhost:8243/](https://localhost:8243/) URL.

     This will prompt your browser to accept the certificate used by the API Gateway. This is required because by default the API Gateway uses a self-signed certificate that is not trusted by web browsers.
    
    !!! note

        This certificate that is used by the API Gateway is replaced when deploying the system in production.

3. Click on the `GET` resource of the API to expand the resource and Click **Try It Out**.
   
     [![GET resource]({{base_path}}/assets/img/get_started/expanded-get-resource.png)]({{base_path}}/assets/img/get_started/expanded-get-resource.png)

4. Click **Execute**.

     [![GET resource]({{base_path}}/assets/img/get_started/try-api.png)]({{base_path}}/assets/img/get_started/try-api.png)

     You should see the `{"hello" : "world"}` response from the API. 

     [![Successful response]({{base_path}}/assets/img/get_started/try-it-success.png)]({{base_path}}/assets/img/get_started/try-it-success.png)

__Congratulations!__ You have successfully created, deployed and published your first API. Thereon, we've subscribed to the API and invoked it.
