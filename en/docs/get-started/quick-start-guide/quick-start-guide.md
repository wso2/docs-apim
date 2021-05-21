# Quick Start Guide - API Proxy

This section is a step-by-step guide to create, publish, and invoke an API using the **WSO2 API Manager (WSO2 API-M)** Publisher and Developer Portal.

### Before you begin...

1. Install [Oracle Java SE Development Kit (JDK)](http://java.sun.com/javase/downloads/index.jsp) version 11 or 1.8 and set the `JAVA_HOME` environment variable.
   For more information on setting the `JAVA_HOME` environment variable for different operating systems, see [Setup and Install]({{base_path}}/install-and-setup/install/installing-the-product/installing-api-m-runtime/).
2. [Download version 4.0.0 of WSO2 API-M](https://wso2.com/api-management/).
3. Start WSO2 API-M by navigating to the `<API-M_HOME>/bin` directory using the command-line and execute the following command `api-manager.bat --run` (for Windows) or `sh api-manager.sh` (for Linux).

### What you'll build

1. Creating and publishing an API via the Publisher Portal of WSO2 API-M.
2. Subscribing to the API via the Developer Portal of WSO2 API-M and generating keys.
3. Invoking the API with the generated keys.

 Let's get started...

### Step 1 - Create and publish an API

Follow the instructions below to create and publish an API via the Publisher Portal of WSO2 API-M.

1. Navigate to the Publisher Portal [https://localhost:9443/publisher](https://localhost:9443/publisher) and sign in with **`admin/admin`** as the credentials (The below home screen will be displayed).
                                                 
    [![Publisher portal home page]({{base_path}}/assets/img/get_started/api-publisher-home.png)]({{base_path}}/assets/img/get_started/api-publisher-home.png)

2. Create an API.

     Let's use a mock REST service to create a REST API from scratch.
 
     A mock service with a JSON response `{"hello": "world"}`  is provided by default when you use the service URL as (`http://run.mocky.io/v2/5185415ba171ea3a00704eed`) that appears in the [https://designer.mocky.io/](https://designer.mocky.io/) mock service. Note that we are using the HTTP protocol instead of HTTPS.

     - Optionally, to test this service, copy the service URL [http://run.mocky.io/v2/5185415ba171ea3a00704eed](http://run.mocky.io/v2/5185415ba171ea3a00704eed) and navigate to it on a new browser. You should see the following JSON message.
            
         `{"hello": "world"}`
    
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
     <td><code>http://run.mocky.io/v2/5185415ba171ea3a00704eed</code>
      <div class="admonition note">
      <p class="admonition-title">Note</p>
      <p><b>Use the HTTP protocol</b> because to use HTTPS you need to import the [https://designer.mocky.io/](https://designer.mocky.io/) certificate into WSO2 API-M.</p>
      </div> 
     </td>
     </tr>
     </table>
     
     ![[Create an API]({{base_path}}/assets/img/get_started/api-create.png)]({{base_path}}/assets/img/get_started/api-create.png)
        
6. Click **Create & Publish**.

     This will publish your first API on the Developer Portal as well as deploy it on the API Gateway. You now have an OAuth2.0 secured REST API that is ready to be consumed.

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
 
4. Register an OAuth2.0 application.

    1. Click **Subscriptions** on the left menu bar of the screen.
    
        [![Subscription Card]({{base_path}}/assets/img/get_started/subscriptions-menu.png)]({{base_path}}/assets/img/get_started/subscriptions-menu.png)
    
    2. Click **SUBSCRIPTION & KEY GENERATION WIZARD** in the above screen.
    
         This wizard walks you through 5 steps that will register an OAuth2.0 application which you will use to consume the `HelloWorld` API.

         [![Key generation wizard]({{base_path}}/assets/img/get_started/key-gen-wizard.png)]({{base_path}}/assets/img/get_started/key-gen-wizard.png)

    3.  Create the OAuth2.0 application.
    
         Enter the application name, and click **Next** without changing any of the other default values. 

         <table>
         <tr> 
         <th>
         Application Name
         </th>
         <td>
         Greetings
         </td>
         </tr>
         <tr> 
         <th>Per Token Quota
         </th>
         <td>50PerMin
         </td>
         </tr>
         </table>

         [![Wizard - Create application]({{base_path}}/assets/img/get_started/key-gen-wizard-1.png)]({{base_path}}/assets/img/get_started/key-gen-wizard-1.png)

     3. Subscribe the application to the API.
        
         This subscribes the `Greetings` application to the `HelloWorld` API on the selected Business Plan. Click **Next** without changing any of the default values.

         [![Wizard - Subscribe to new application]({{base_path}}/assets/img/get_started/key-gen-wizard-2.png)]({{base_path}}/assets/img/get_started/key-gen-wizard-2.png)

     4. Generate the credentials for the **Greetings** OAuth2.0 application.
     
         The Grant Types define the various protocols, which will be allowed by the system, from which your application will be allowed to request tokens. Click **Next**.

         [![Wizard - Generate Keys]({{base_path}}/assets/img/get_started/key-gen-wizard-3.png)]({{base_path}}/assets/img/get_started/key-gen-wizard-3.png)

     5. Generate a test access token for the **Greetings** application to access the **HelloWorld** API.
     
         This step allows you to specify the permissions (scopes) for the token. Click **Next** without changing any of the default values.

         [![Wizard - Generate Access Token]({{base_path}}/assets/img/get_started/key-gen-wizard-4.png)]({{base_path}}/assets/img/get_started/key-gen-wizard-4.png)

     6. Click the **copy** icon, as shown below, to copy the generated test access token to the clipboard.

         [![Wizard - Copy Access Token]({{base_path}}/assets/img/get_started/key-gen-wizard-5.png)]({{base_path}}/assets/img/get_started/key-gen-wizard-5.png)
    
     7.  Click **Finish**.

 **Voila!!!** You can now test the **HelloWorld** API with the OAuth2.0 token that you just generated.

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

5. Then click **Execute**.

     [![GET resource]({{base_path}}/assets/img/get_started/try-api.png)]({{base_path}}/assets/img/get_started/try-api.png)

     You should see the `{"hello" : "world"}` response from the API. 

     [![Successful response]({{base_path}}/assets/img/get_started/try-it-success.png)]({{base_path}}/assets/img/get_started/try-it-success.png)

__Congratulations!__ You have successfully created your first API, subscribed to it through an OAuth2.0 application, obtained an access token for testing, and invoked your API with the access token.
 
## Automate API development and deployment

Let's look at how you can use **WSO2 API Controller (apictl)** which is the command-line tool to move APIs, 
API Products, and Applications across WSO2 API-M environments and to perform CI/CD operations. 
(For more information, see [Getting Started with WSO2 API Controller (apictl)]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller/))

### Before you begin...

1. Download the apictl version 4.0.0 (or the latest of the 4.x family) based your operating system from [https://wso2.com/api-management/tooling/](https://wso2.com/api-management/tooling/) from under the **Dev-Ops Tooling** section.

2. Extract the ZIP to a preferred location.

     This location will be referred to as the `apictl` directory.

3. To use the command line tool to navigate to the `apictl` directory.

    !!!warn
        If you have previously used an apictl old version, 
        backup and remove the `/home/<user>/.wso2apictl` directory 
        and reconfigure the environments using the commands as explained below.
        
     Execute the following command to view the available operations.

     ``` bash
     ./apictl --help
     ```   

4. Point the apictl to the instance of WSO2 API-M in which you want to deploy APIs.

    Execute the following command to add an environment.
     
    !!!note
        It is assumed that WSO2 API-M is run locally (localhost) using the default ports.
    
    ``` bash
    ./apictl add env dev \
             --apim https://localhost:9443
    ```

     For more information on adding environments using different flag combinations,
     see [Add an environment]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller/#add-an-environment).
   
     On successfully executing this command, you should see the following message.

    ``` bash
    Default token endpoint 'https://localhost:9443/oauth2/token' is added as the token endpoint
    Successfully added environment 'dev'
    ```

### Step 1 - Create an API

1. Initialize an API project by providing a name for the project.

     Let's use the command below to create an API named `PetstoreAPI`. This creates a folder named `PetstoreAPI` in your current directory.

       ```bash
       ./apictl init PetstoreAPI --oas https://apim.docs.wso2.com/en/4.0.0/assets/attachments/get_started/petstore.json
       ```

     On successfully executing this command, you should see the following message.

     ```bash
     Initializing a new WSO2 API Manager project in <your-directory-path>/PetstoreAPI
     Project initialized
     Open README file to learn more
     ```   
    
    !!! note

        Use the following command to view the various options related to initializing a project.

        ```bash
        ./apictl init --help
        ```

2. Update the `api.yaml` file.

     1. Open and explore the `PetstoreAPI` folder with an IDE (e.g., VSCode). 
     
     2. Open the `api.yaml` file. (Alternatively, You can use a text editor to open this file as well.)
   
     3. Change the values of the following attributes as shown below and save the file.

        ```text   
        lifeCycleStatus: PUBLISHED
        ```

        ```text
        production_endpoints:
            url: https://petstore.swagger.io/v2
        sandbox_endpoints:
            url: https://petstore.swagger.io/v2
        ```

        !!! Note

            - Make sure that there are no spaces in-between the `context` value in the `api.yaml` file.
            - Changing the default lifecycle status of the API from `CREATED` to `PUBLISHED`, will deploy the API directly to the Developer Portal and API Gateway, when you push this API to WSO2 API-M in the following step.
            - If you want to push this API to the Publisher Portal only, the status should be `CREATED`.

### Step 2 - Publish the API

1. Push the API to WSO2 API-M.

     Navigate back to the `apictl` directory and execute the following command:

    !!! Info

        If you are working with a specific environment for the first time, you will be prompted to enter your account credentials on WSO2 API-M. You can use the default admin credentials as **`admin/admin`**.

     ``` bash
     ./apictl import api --file ./PetstoreAPI --environment dev
     ```
   
     You should now see your API deployed successfully on WSO2 API-M.

2. Browse the Publisher and the Developer Portals to view the API details.

     - [https://localhost:9443/publisher](https://localhost:9443/publisher)

         [![API in the Publisher]({{base_path}}/assets/img/get_started/qsg-publisher.png)]({{base_path}}/assets/img/get_started/qsg-publisher.png)

     - [https://localhost:9443/devportal](https://localhost:9443/devportal)

         [![API in the Developer Portal]({{base_path}}/assets/img/get_started/qsg-devportal.png)]({{base_path}}/assets/img/get_started/qsg-devportal.png)

### Step 3 - Invoke the API

1. Generate an access token using apictl.

    Navigate back to the `apictl` directory and execute the following command:

     ``` bash
     ./apictl get keys -e dev -n SwaggerPetstore -v 1.0.0 -r admin
     ```
   
    You will get an access token that can be used to invoke your API. (For more information on generating keys using apictl, 
    see [Get keys for an API/API Product]({{base_path}}/install-and-setup/setup/api-controller/ci-cd-with-wso2-api-management/#g-get-keys-for-an-apiapi-product).)

2. Invoke the API

    Execute the below cURL command to invoke the resource `GET /pet` of your API. 
    (Make sure to enter the access token that you recieved earlier as the `Bearer` in thee request)

    ```bash
    curl -H "Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUz....RWrACAUNSFBpxz1lRLqFlDiaVJAg" https://localhost:8243/SwaggerPetstore/1.0.0/pet/5 -k
    ```

     You will receive the below response.
   
     ```bash
     {"id":5,"category":{"id":5,"name":"jimmy"},"name":"jimmy","photoUrls":[],"tags":[{"id":5,"name":"jimmy"}],"status":"pending"}
     ```

    !!!note
        Alternatively, you can consume the API as explained in the following sections 
        using the WSO2 API-M Developer Portal.
        
         - [Subscribe to the API via the Developer Portal and generate keys](#subscribe)
         - [Invoke the API with the generated keys](#invoke)

    [![PetStore response]({{base_path}}/assets/img/get_started/qsg-petstore-response.png)]({{base_path}}/assets/img/get_started/qsg-petstore-response.png)
   
