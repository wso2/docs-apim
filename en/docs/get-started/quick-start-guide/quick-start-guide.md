# Quick Start Guide

## Design Your First API

This section is a step-by-step guide to create, publish, and invoke an API using the WSO2 API Manager's publisher and store user interfaces.

### Before you begin...

<p>   <ol><li>Install <a href="http://java.sun.com/javase/downloads/index.jsp">Oracle Java SE Development Kit (JDK)</a> version 11 or 1.8 and set the <code>JAVA_HOME</code> environment variable. For more information on setting the <code>JAVA_HOME</code> environment variable for different operating systems, see <a href="{{base_path}}/install-and-setup/install/installing-the-product/installing-the-binary/installing-on-linux-or-os-x/">Setup and Install</a>.</li>
<li><a href="https://wso2.com/api-management/">Download the version 3.2.0 of WSO2 API Manager</a>.</li>
<li>Start WSO2 API Manager by navigating to the <code><API-M_HOME>/bin</code> directory using the command-line and execute the following command <code>wso2server.bat --run</code> (for Windows) or <code>sh wso2server.sh</code> (for Linux.)</li></ol>
</p>

### Objectives

1. Creating and publishing an API via the API Publisher.
2. Subscribing to the API via the Developer Portal and generating keys.
3. Invoking the API with the generated keys.

 Let's get started...

### Step 1 - Create and publish an API

Follow the instructions below to create and publish an API via the API Publisher.

1. Navigate to the API Publisher [https://localhost:9443/publisher](https://localhost:9443/publisher) and sign in with **`admin/admin`** as the credentials.
                                                 
    [![API Publisher home page]({{base_path}}/assets/img/get_started/api_publisher_home.png)]({{base_path}}/assets/img/get_started/api_publisher_home.png)

2. Create an API.

     Let's use a mock REST service to create the API from scratch.
 
     A mock service with a JSON response `{"hello": "world"}`  is provided by default when you use the service URL as (`http://run.mocky.io/v2/5185415ba171ea3a00704eed`) that appears in the [https://designer.mocky.io/](https://designer.mocky.io/) mock service. Note that we are using the HTTP protocol instead of HTTPS.

     - Optionally, to test this service, copy the service URL [http://run.mocky.io/v2/5185415ba171ea3a00704eed](http://run.mocky.io/v2/5185415ba171ea3a00704eed) and navigate to it on a new browser. You should see the following JSON message.
            
         `{"hello": "world"}`
    
4. Click **Create New API** and then click **Design a new REST API**.
   
    [![Design a new REST API]({{base_path}}/assets/img/get_started/design_new_rest_api.png)]({{base_path}}/assets/img/get_started/design_new_rest_api.png)


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
      <p><b>Use the HTTP protocol</b> because to use HTTPS you need to import the [https://designer.mocky.io/](https://designer.mocky.io/) certificate into WSO2 API Manager.</p>
      </div> 
     </td>
     </tr>
     <tr> 
     <th>Business Plan(s)
     </th>
     <td>Gold, Bronze
     </td>
     </tr>
     </table>
     
     ![[Create an API]({{base_path}}/assets/img/get_started/api_create.png)]({{base_path}}/assets/img/get_started/api_create.png)
        
6. Click **Create & Publish**.

     This will publish your first API on the Developer Portal as well as deploy it on the API Gateway. You now have an OAuth2.0 secured REST API that is ready to be consumed.

<a name="subscribe"></a>

### Step 2 - Subscribe to the API

Follow the instructions below to subscribe to the API and generate the keys via the Developer Portal.

1. Navigate to the Developer Portal.

     [https://localhost:9443/devportal](https://localhost:9443/devportal)
    
     The published `HelloWorld` API is listed in the Developer Portal as shown below.

     [![Developer Portal home page]({{base_path}}/assets/img/get_started/dev_portal_landing_page.png)]({{base_path}}/assets/img/get_started/dev_portal_landing_page.png)

2. Click **Sign-In** and enter **`admin/admin`** as your credentials to sign in to the Developer Portal.

3. Click on the API thumbnail to view the overview of the API.

     [![API overview]({{base_path}}/assets/img/get_started/api_overview.png)]({{base_path}}/assets/img/get_started/api_overview.png)
 
4. Register an OAuth2.0 application.

    1. Click **Subscribe** on the **Subscriptions** card.
    [![Subscription Card]({{base_path}}/assets/img/get_started/subscription_card.png)]({{base_path}}/assets/img/get_started/subscription_card.png)
    
    2. Click **Subscription & Key Generation Wizard**
    
         This wizard walks you through 5 steps that will register an OAuth2.0 application which you will use to consume the `HelloWorld` API.

         [![Key generation wizard]({{base_path}}/assets/img/get_started/key_gen_wizard.png)]({{base_path}}/assets/img/get_started/key_gen_wizard.png)

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
         <tr> 
         <th>Token Type
         </th>
         <td>JWT
         </td>
         </tr>
         </table>

         [![Wizard - Create application]({{base_path}}/assets/img/get_started/key_gen_wizard_1.png)]({{base_path}}/assets/img/get_started/key_gen_wizard_1.png)

     3. Subscribe the application to the API.
        
         This subscribes the `Greetings` application to the `HelloWorld` API on the selected Business Plan. Click **Next** without changing any of the default values.

         [![Wizard - Subscribe to new application]({{base_path}}/assets/img/get_started/key_gen_wizard_2.png)]({{base_path}}/assets/img/get_started/key_gen_wizard_2.png)

     4. Generate the credentials for the **Greetings** OAuth2.0 application.
     
         The Grant Types define the various protocols, which will be allowed by the system, from which your application will be allowed to request tokens. Click **Next**.

         [![Wizard - Generate Keys]({{base_path}}/assets/img/get_started/key_gen_wizard_3.png)]({{base_path}}/assets/img/get_started/key_gen_wizard_3.png)

     5. Generate a test access token for the 'Greetings' application to access the 'HelloWorld' API.
     
         This step allows you to specify the validity period for the token and its permissions (scopes). Click **Next** without changing any of the default values.

         [![Wizard - Generate Access Token]({{base_path}}/assets/img/get_started/key_gen_wizard_4.png)]({{base_path}}/assets/img/get_started/key_gen_wizard_4.png)

     6. Click copy, as shown below, to copy the generated test access token to the clipboard.

         [![Wizard - Copy Access Token]({{base_path}}/assets/img/get_started/key_gen_wizard_5.png)]({{base_path}}/assets/img/get_started/key_gen_wizard_5.png)
    
     7.  Click **Finish**.

 **Voila!!!** You can now test the 'HelloWorld' API with the OAuth2.0 token that you just generated.

<a name="invoke"></a>

### Step 3 - Invoke the API

Follow the instructions below to invoke the previously created API with the generated keys.

1. Click **Try Out**.

     The resources of the API are listed.

2. Paste the access token that you previously copied in the **Access Token** field.

    [![Paste the access token]({{base_path}}/assets/img/get_started/test_api.png)]({{base_path}}/assets/img/get_started/test_api.png)

3. **If this is the first time you are using the API test console** from your browser,  open a new tab and navigate to the [https://localhost:8243/](https://localhost:8243/) URL.

     This will prompt your browser to accept the certificate used by the API Gateway. This is required because by default the API Gateway uses a self-signed certificate that is not trusted by web browsers.
    
    !!! note

        This certificate that is used by the API Gateway is replaced when deploying the system in production.

4. Click on the `GET` resource of the API to expand the resource.

5. Click **Try It Out** and then click **Execute**.

     [![GET resource]({{base_path}}/assets/img/get_started/try_api.png)]({{base_path}}/assets/img/get_started/try_api.png)

     You should see the `{"hello" : "world"}` response from the API. 

     [![Successful response]({{base_path}}/assets/img/get_started/try_it_success.png)]({{base_path}}/assets/img/get_started/try_it_success.png)

__Congratulations!__ You have successfully created your first API, subscribed to it through an OAuth2.0 application, obtained an access token for testing, and invoked your API with the access token.
 
## Automate API Development and Deployment

Let's look at how you can use the CI/CD command line tool for APIs (API Controller) to develop and deploy an API on WSO2 API Manager.

### Before you Begin...

1. Download API Controller version 4.0.0(or the latest of the 4.x family) based your operating system from [https://wso2.com/api-management/tooling/](https://wso2.com/api-management/tooling/) from under the **Dev-Ops Tooling** section.

2. Extract the ZIP to a preferred location.

     This location will be referred to as the `apictl` directory.

3. Use the command line tool to navigate to the `apictl` directory.

    !!!warn
        From API Manager Tooling 3.1.0 version onwards, the names of
        the endpoints have been modified and this causes changing the 
        syntax in `/home/<user>/.wso2apictl/main_config.yaml` file. If
        you have an older file, you'll get an error while executing the 
        apictl commands due to this. To avoid that, backup and remove 
        `/home/<user>/.wso2apictl/main_config.yaml` file and reconfigure 
        the environments using new commands as explained below.

     Execute the following command to view the available operations.

     ``` bash
     ./apictl --help
     ```   

4. Point the API Controller to the instance of API Manager in which you 
    want to deploy APIs.

    Execute the following command to add an environment.
     
    !!!note
        It is assumed that WSO2 API Manager is run locally 
         (localhost) using the default ports.
    
    ``` bash
    ./apictl add env dev \
            --apim https://localhost:9443 \
            --token https://localhost:8243/token 

    ```
     
    !!!info
         **Flags:**

        - Required :     
        `--apim` : API Manager endpoint for the environments  

        - Optional :      
            `--admin` : Admin endpoint for the environment 
            `--token` : Token endpoint for the environment 
            `--registration` : Registration endpoint for the environment                   
            `--publisher` : Publisher endpoint for the environment 
            `--devportal` : DevPortal endpoint for the environment
   
    !!!note
        `apictl add-env` command has been depcrecated from the API Controller 4.0.0 onwards. Instead use `apictl add env` as shown above. For further information please refer [Add an environment]({{base_path}}/learn/api-controller/getting-started-with-wso2-api-controller/#add-an-environment).  

     On successfully executing this command, you should see the following message.
     
     `Successfully added environment 'dev'`

### Step 1 - Create an API

1. Initialize an API project by providing a name for the project.

     Let's use the command below to create an API named `PetstoreAPI`. This creates a folder named `PetstoreAPI` in your current directory.

       ```bash
       ./apictl init PetstoreAPI --oas https://apim.docs.wso2.com/en/3.2.0/assets/attachments/get_started/petstore.json
       ```

     On successfully executing this command, you should see the following message.

     ``` text
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
     
     2. Navigate to the `Meta-information` directory and open the `api.yaml` file.

    !!! tip

        Alternatively, You can use a text editor to open this file as well.
   
     3. Change the value of the following attribute and save the file.

        ```   
        status: PUBLISHED
        sandboxUrl: http://petstore.swagger.io/v2
        ```

        !!! Note

            - Make sure that there are no spaces in-between the values that correspond to the `context` and `contextTemplate` attributes in the `api.yaml` file.
            - Changing the default lifecycle status of the API from `CREATED` to `PUBLISHED`, will deploy the API directly to the Developer Portal and API Gateway, when you push this API to WSO2 API Manager in the following step.
            - If you want to push this API to the Publisher only, the status should be `CREATED`.

### Step 2 - Publish the API

1. Push the API to WSO2 API Manager.

     Navigate back to the `apictl` directory and execute the following command:

    !!! Info

        If you are working with a specific environment for the first time, you will be prompted to enter your account credentials on WSO2 API Manager. You can use the default admin credentials as **`admin/admin`**.

     ``` bash
     ./apictl import api --file ./PetstoreAPI --environment dev -k 
     ```

    !!!note
        `apictl import-api` command has been depcrecated from the API Controller 4.0.0 onwards. Instead use `apictl import api` as shown above. For further information please refer [Import an API Project]({{base_path}}/learn/api-controller/importing-apis-via-dev-first-approach/#import-an-api-project).  

     You should now see your API deployed successfully on WSO2 API Manager.

2. Browse the API Publisher and the Developer Portal to view the API details.

     - [https://localhost:9443/publisher](https://localhost:9443/publisher)

         [![API in the Publisher]({{base_path}}/assets/img/get_started/qsg-publisher.png)]({{base_path}}/assets/img/get_started/qsg-publisher.png)

     - [https://localhost:9443/devportal](https://localhost:9443/devportal)

         [![API in the Developer Portal]({{base_path}}/assets/img/get_started/qsg-devportal.png)]({{base_path}}/assets/img/get_started/qsg-devportal.png)

    <div class="admonition note">
    <p class="admonition-title">Note</p>
    <p>You can consume the API as explained in the following sections.</p>

    <ul>
    <li>
    <a href="#subscribe">Subscribe to the API via the Developer Portal and generate keys</a> </li>
    <li>
    <a href="#invoke">Invoke the API with the generated keys</a> </li>
    </ul>
    </div> 

   [![PetStore response]({{base_path}}/assets/img/get_started/qsg-petstore-response.png)]({{base_path}}/assets/img/get_started/qsg-petstore-response.png)