# Quick Start Guide

## Before you begin....

!!! Attention
    1. Install [Oracle Java SE Development Kit (JDK)](http://java.sun.com/javase/downloads/index.jsp) version 11.\* or 1.8.\* and set the `JAVA_HOME` environment variable. For more information on setting the `JAVA_HOME` environment variable for different operating systems, see [Setup and Install]({{base_path}}/InstallAndSetup/InstallationGuide/InstallingTheProduct/InstallingTheBinary/installing-on-linux-or-os-x/).
    2. [Download the latest version of WSO2 API Manager](https://wso2.com/api-management/).
    3. Start WSO2 API Manager by navigating to the `<API-M_HOME>/bin` directory using the command-line and execute the following command `wso2server.bat --run` (for Windows) or `sh wso2server.sh` (for Linux.)

This guide walks you through the following 3 scenarios.

1. Creating and publishing an API via the API Publisher Portal.
2. Subscribing to the API via the Developer Portal and generating keys.
3. Invoking the API with the generated keys.

Finally, this guide takes a look at how you can create an API using the API controller, which is a command line tool to create and publish APIs.

 Let's get started...

### Working with the WSO2 API Manager UIs

#### Step 1 - Create and publish an API

Follow the instructions below to create a publish an API via the API Publisher Portal.

1. Navigate to the API Publisher Portal [https://localhost:9443/publisher](https://localhost:9443/publisher) and sign in with **`admin/admin`** as the credentials.
                                                 
    [![]({{base_path}}/assets/img/get_started/api_publisher_home.png)]({{base_path}}/assets/img/get_started/api_publisher_home.png)

2. Create an API.

     Use either one of the following options to create an API.

     - To __avoid creating an API from scratch__ -

         1. Click **DEPLOY SAMPLE API**.

             This publishes a pre-created sample API with an accessible endpoint.  

            !!! Note
         
                This option is only available as long as there are no APIs created in the system.
    
         2. Skip the following steps and move to [Step 2 - Subscribe to the API]({{base_path}}/GettingStarted/quick-start-guide/#Step+2+-+Subscribe+to+the+API). 

     - To __create an API from scratch__ - 
         
         Let's use a mock REST service for this purpose.
 
         1. Navigate to [https://www.mocky.io/](https://www.mocky.io/) on your web browser. 
             
             A mock service with a JSON response `{"hello": "world"}`  is provided by default on the landing page of the site. Let's use the service URL (`https://www.mocky.io/v2/5185415ba171ea3a00704eed`) that appears in the mock service.

             [![]({{base_path}}/assets/img/get_started/Mocky_io.png)]({{base_path}}/assets/img/get_started/Mocky_io.png)
         
         2. Optionally, to test this service, copy the service URL [https://www.mocky.io/v2/5185415ba171ea3a00704eed](https://www.mocky.io/v2/5185415ba171ea3a00704eed) and navigate to it on a new browser. You should see the following JSON message.
            
             `{"hello": "world"}`
    
4. Click **Create New API** and then click **Design a new REST API**.
   
    [![]({{base_path}}/assets/img/get_started/design_new_rest_api.png)]({{base_path}}/assets/img/get_started/design_new_rest_api.png)


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
     <td><code>http://www.mocky.io/v2/5185415ba171ea3a00704eed</code>
      <div class="admonition note">
      <p class="admonition-title">Note</p>
      <p><b>Use the HTTP protocol</b> because to use HTTPS you need to import the <code>mocky.io</code> certificate  
        into WSO2 API Manager</p>
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
     
     ![[]({{base_path}}/assets/img/get_started/api_create.png)]({{base_path}}/assets/img/get_started/api_create.png)
        
6. Click **Create & Publish**. 

     This will publish your first API on the Developer Portal as well as deploy it on the API Gateway. You now have an OAuth2.0 secured REST API that is ready to be consumed.

#### Step 2 - Subscribe to the API

Follow the instructions below to subscribe to the API and generate the keys via the Developer Portal.

1. Navigate to the Developer Portal.

     [https://localhost:9443/devportal](https://localhost:9443/devportal)
    
     The published `HelloWorld` API is listed in the Developer Portal as shown below.

     [![]({{base_path}}/assets/img/get_started/dev_portal_landing_page.png)]({{base_path}}/assets/img/get_started/dev_portal_landing_page.png)

2. Click **Sign-In** and enter **`admin/admin`** as your credentials to sign in to the Developer Portal.

3. Click on the API thumbnail to view the overview of the API. 

     [![]({{base_path}}/assets/img/get_started/api_overview.png)]({{base_path}}/assets/img/get_started/api_overview.png)
 
4. Register an OAuth2.0 application.

    1. Click **Key Generation Wizard**. 
    
         This wizard walks you through 5 steps that will register an OAuth2.0 application which you will use to consume the `HelloWorld` API.  

         [![]({{base_path}}/assets/img/get_started/key_gen_wizard.png)]({{base_path}}/assets/img/get_started/key_gen_wizard.png)


    2.  Create the OAuth2.0 application.
    
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

         [![]({{base_path}}/assets/img/get_started/key_gen_wizard_1.png)]({{base_path}}/assets/img/get_started/key_gen_wizard_1.png)

     3. Subscribe the application to the API.  
        
         This subscribes the `Greetings` application to the `HelloWorld` API on the selected Business Plan. Click **Next** without changing any of the default values.

         [![]({{base_path}}/assets/img/get_started/key_gen_wizard_2.png)]({{base_path}}/assets/img/get_started/key_gen_wizard_2.png)

     4. Generate the credentials for the **Greetings** OAuth2.0 application. 
     
         The Grant Types define the various protocols, which will be allowed by the system, from which your application will be allowed to request tokens. Click **Next** without changing any of the default values.

         [![]({{base_path}}/assets/img/get_started/key_gen_wizard_3.png)]({{base_path}}/assets/img/get_started/key_gen_wizard_3.png)

     5. Generate a test access token for the 'Greetings' application to access the 'HelloWorld' API. 
     
         This step allows you to specify the validity period for the token and its permissions (scopes). Click **Next** without changing any of the default values.

         [![]({{base_path}}/assets/img/get_started/key_gen_wizard_4.png)]({{base_path}}/assets/img/get_started/key_gen_wizard_4.png)

     6. Click copy, as shown below, to copy the generated test access token to the clipboard.

         [![]({{base_path}}/assets/img/get_started/key_gen_wizard_5.png)]({{base_path}}/assets/img/get_started/key_gen_wizard_5.png)
    
     7.  Click **Finish**.

 **Voila!!!** You can now test the 'HelloWorld' API with the OAuth2.0 token that you just generated. 
 
#### Step 3 - Invoke the API

Follow the instructions below to invoke the previously created API with the generated keys.

1. Click **Try Out**. 

     The resources of the API are listed. 

2. Paste the access token that you previously copied in the **Access Token** field.  

    [![]({{base_path}}/assets/img/get_started/test_api.png)]({{base_path}}/assets/img/get_started/test_api.png) 

3. __If this is the first time you are using the API test console__ from your browser,  open a new tab and navigate to the [https://localhost:8243/](https://localhost:8243/) URL. 

     This will prompt your browser to accept the certificate used by the API Gateway. This is required because by default the API Gateway uses a self-signed certificate that is not trusted by web browsers. Note that this certificate is replaced when deploying the system in production.

4. Click on the `GET` resource of the API to expand the resource. 

5. Click **Try It Out**, which is the button on the right. Then click **Execute**.  

     [![]({{base_path}}/assets/img/get_started/try_api.png)]({{base_path}}/assets/img/get_started/try_api.png)

     You should see the `{"hello" : "world"}` response from the API.  

     [![]({{base_path}}/assets/img/get_started/try_it_success.png)]({{base_path}}/assets/img/get_started/try_it_success.png)

__Congratulations!__ You have successfully created your first API, subscribed to it through an OAuth2.0 application, obtained an access token for testing, and invoked your API with the access token.  

### Working with the command line tool - API Controller (apictl)  

Let's look at how you can use the CI/CD command line tool for APIs (API Controller) to develop and deploy an API on WSO2 API Manager.   

#### Step 1 - Download and setup the API Controller

1. Download the latest version of the API Controller based your operating system from [https://wso2.com/api-management/tooling/](https://wso2.com/api-management/tooling/). 

2. Extract the ZIP to a preferred location. 

     This location will be referred to as the `apictl` directory.   

3. Use the command line tool to navigate to the `apictl` directory.  

     Execute the following command to view the available operations.

     ``` bash
     ./apictl --help
     ```   

4. Point the API Controller to the instance of API Manager in which you want to deploy APIs. 

     Execute the following command to add an environment. 
     
     <div class="admonition note">
     <p class="admonition-title">Note</p>
     <p>It is assumed that WSO2 API Manager is run locally (localhost) using the default ports. </p>
     </div>  
   
     ``` bash
     ./apictl add-env -e dev --registration https://localhost:9443/client-registration/v0.15/register --apim  https://localhost:9443 --token https://localhost:8243/token
     ```

     On successfully executing this command, you should see the following message.
     
     `Successfully added environment 'dev'`

#### Step 2 - Create an API
       
1. Initialize an API project by providing a name for the project. 

     Let's use the command below to create an API named `PetstoreAPI`.  This creates a folder named `PetstoreAPI` in your current directory.

       ```bash
       ./apictl init PetstoreAPI --oas https://petstore.swagger.io/v2/swagger.json
       ``` 
    
     Use the following command to view the various options related to initializing a project. 

       ```bash
       ./apictl init --help
       ```

2. Open and explore the `PetstoreAPI` folder with an IDE (e.g., VSCode). Navigate to `Meta-information` 
   directory. Open the `api.yaml` file. 
   
     Alternatively, You can use a text editor to open this file as well.
   
     Change the values of the attributes `status` and `productionUrl` as shown below and save the file. 
       
     `status: PUBLISHED`  
     `productionUrl: http://petstore.swagger.io/v2`  
           
    !!! Info

        - Changing the default lifecycle status of the API from `CREATED` to `PUBLISHED`, will deploy    
        the API directly to the Developer Portal and API Gateway, when you push this API to WSO2 API Manager in 
        the following step. 
        - If you want to push this API to the Publisher Portal only, the status should be `CREATED`.    

#### Step 3 - Publish the API

1. Navigate back to the `apictl` directory. Execute the command below to push the API to WSO2 API Manager. 

    !!! Info
        If this is the first time you are using the API Controller you will be prompted to enter your account credentials on API Manager. You can enter your credentials as **`admin/admin`**. 

       ```bash
       ./apictl import-api --file ./PetstoreAPI --environment dev -k 
       ```

     You should now see your API deployed successfully on WSO2 API Manager. 

2. You can browse the Developer Portal or the Publisher Portal to view the API details. 
     
     You can consume the API as explained in the following sections.

     - [Subscribe to the API through the Developer Portal and generate keys](#subscribe-to-the-api-through-the-developer-portal-and-generate-keys) 

     - [Invoke the API with the generated keys](#invoke-the-api-with-the-generated-keys)  