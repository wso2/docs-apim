# Quick Start Guide

#### Before you begin....

!!! attention
        1.  Install [Oracle Java SE Development Kit (JDK)](http://java.sun.com/javase/downloads/index.jsp) version 11.\* or 1.8.\* and set the `JAVA_HOME` environment variable. Refer [Setup and Install]({{base_path}}/SetupAndInstall/InstallationGuide/InstallingTheProduct/installing-on-linux-or-os-x/) documentation to set `JAVA_HOME` environment variable for different operating systems
        2.  [Download the latest version of WSO2 API Manager](https://wso2.com/api-management/install/) .
        3.  Start WSO2 API Manager by navigating to the `<API-M_HOME>/bin` directory using the command-line and execute the following command `wso2server.bat` (for Windows) or `wso2server.sh` (for Linux.)

#### What's in store?

In this guide, we will walk you through the following 3 scenarios.

1. Create and publish an API from the API publisher portal.
2. Subscribe to the API through the developer portal and generate keys.
3. Invoke the APIs with the generated keys.

Finally, let's take a look at how we can create an API using the API controller, which is a command line tool to create and publish APIs.


 Let's get started....
#### __Create and publish an API__ from the API publisher portal.

1. Open the API publisher portal [https://localhost:9443/publisher](https://localhost:9443/publisher) and login with **`admin/admin`** credentials. This will take you to the following page.
                                                 
    ![]({{base_path}}/assets/img/get_started/api_publisher_home.png)

2. If you want to __avoid creating an API from scratch__, you can publish a pre-created sample API with an 
    accessible endpoint via the  'Deploy Sample API' option.  

    __Note__  that this option is only available as long as there are no APIs created in the system.
    
    You can skip the following steps and jump to the next section, [subscribe to the API through the developer portal and generate keys](https://apim.docs.wso2.com/en/latest/GettingStarted/quick-start-guide/#creating-and-deploying-an-api-from-the-publisher-portal). 

3. If you chose to __create an API from scratch__, let's use a mock REST service.
 
    * Open [https://www.mocky.io/](https://www.mocky.io/) on your web browser. A mock service with a 
        JSON response `{"hello": "world"}`  is provided by default on the landing page of the site. We 
        will be using the service URL (`https://www.mocky.io/v2/5185415ba171ea3a00704eed`) which is shown 
        in the mock service.

     ![]({{base_path}}/assets/img/get_started/Mocky_io.png)
         
    * Optionally, to test this service, copy the service URL 
        [https://www.mocky.io/v2/5185415ba171ea3a00704eed](https://www.mocky.io/v2/5185415ba171ea3a00704eed) on a new browser and navigate to it. You 
        should see a JSON message saying 
            
            `{"hello": "world"}`. 
    
4. On the API Publisher Portal, click on the `Create New API` dropdown and choose the `Design a new REST API` option.
   
    ![]({{base_path}}/assets/img/get_started/design_new_rest_api.png)


5. Fill in the following details in the form that appears. Use the URL we obtained at step3 from mocky.io as the endpoint.

     
    ![]({{base_path}}/assets/img/get_started/api_create.png)  
         
    !!! important
        __Use the http protocol__ since using https for mocky.io requires importing its certificate  
        into API Manager 
        
6. Click on the `Create & Publish` button once done. This will publish your first API on the developer portal as well as deploy it on the API gateway. You now have an OAuth2.0 secured REST API that is ready to be consumed.

#### Subscribe to the API through the developer portal and generate keys

1. Open the developer portal [https://localhost:9443/devportal](https://localhost:9443/devportal). The published `HelloWorld` API should be listed on the developer portal as shown below.

    ![]({{base_path}}/assets/img/get_started/dev_portal_landing_page.png)

2. Click the `Sign-In` button on the top right corner to Sign-In to the developer portal with    **`admin/admin`** credentials.

3. Click on the API thumbnail to view the overview of the API. 
    ![]({{base_path}}/assets/img/get_started/api_overview.png)  
 
4. Click on the `Key Generation Wizard` button found on the `API Credentials` card. The wizard will walk you through 5 steps that will register an OAuth2.0 application which we will be used to consume the `HelloWorld` API.  

    ![]({{base_path}}/assets/img/get_started/key_gen_wizard.png)


3.  The first step will create an OAuth2.0 application. Enter `Greetings` as the application name. Keep the default values for the rest of the fields and click on the `Next` button.

    ![]({{base_path}}/assets/img/get_started/key_gen_wizard_1.png)  

4.  The second step will subscribe the `Greetings` application to the `HelloWorld` API on a selected Business Plan. Keep the default values and click on the `Next` button.  

    ![]({{base_path}}/assets/img/get_started/key_gen_wizard_2.png)  

5. The third step generates the credentials for the 'Greetings' OAuth2.0 application. The `Grant Types` are the various protocols which will be allowed by the system for your application to request tokens from. Keep the default values proceed to the fourth step by clicking on the `Next` button.  

    ![]({{base_path}}/assets/img/get_started/key_gen_wizard_3.png)  

6. In the fourth step we generate a test access token for the 'Greetings' application to access the 'HelloWorld' API. This step allows us to specify the validity period for the token and its permissions (scopes). Keep the default values and click on the `Next` button.  

    ![]({{base_path}}/assets/img/get_started/key_gen_wizard_4.png)  

7. We are now at the 5th and final step of the Key Generation Wizard. The generated test access token is available to copy. Click the button next to the text box displaying the token to copy the token to clipboard. Click on the `Finish` button.  

    ![]({{base_path}}/assets/img/get_started/key_gen_wizard_5.png)  

 __Voila!!!__  We can now test the 'HelloWorld' API with the OAuth2.0 token we just generated. 
 
 
#### Invoke the API with the generated keys.

1. Click on `Try Out` on the left hand side menu. The resources of the API will be listed. 

2. Paste the copied token in the `Access Token` field, next to the word `Authorization Bearer` as shown below.  

    ![]({{base_path}}/assets/img/get_started/test_api.png)  

3. __If this is the first time you are using the API test console__ from your browser,  open a new tab and navigate to the URL [https://localhost:8243/](https://localhost:8243/). This will prompt  your browser to accept the certificate used by the API gateway. This is required because by default the API gateway uses a self-signed certificate that is not trusted by web browsers. Note that this certificate is replaced when deploying the system in production.

4. Click on the `GET` resource of the API to expand the resource. 

5. Click on the `Try it out` button on the right. Then click on the `Execute` button.  

    ![]({{base_path}}/assets/img/get_started/try_api.png)  

11. You should see the `{"hello" : "world"}` response from the API.  

    ![]({{base_path}}/assets/img/get_started/try_it_success.png)  

12. __Congratulations!__ You have successfully created your first API, subscribed to it through an OAuth2.0 application, obtained an access token for testing and invoked your API with the access token.  

#### Creating and deploying an API using the command line tool - API controller (apictl)  

In this section let's look at how we can use the CI/CD command line tool for APIs (API Controller) to develop and deploy an API on API Manager.   

1. Download the latest version of the API controller based your operating system from [https://wso2.com/api-management/tooling/](https://wso2.com/api-management/tooling/). 

2. Extract the zip to a preferred location. This location will be referred to as the `apictl` directory.   

3. Use the command line tool to navigate to the `apictl` directory.  Execute the following command  to 
   see the operations available.
   ``` bash
   ./apictl --help
   ```   
4. Point the API controller to the instance of API Manager on which you want to deploy APIs in. Execute
   the following command to add an environment. Note that it is assumed that the API Manager is run 
   locally (localhost) using default ports.  
   
       ```bash
       ./apictl add-env -e dev --registration https://localhost:9443/client-registration/v0.15/register --apim  https://localhost:9443 --token https://localhost:8243/token
       ```
      On successfully executing the command, you should see the message `Successfully added environment 
      'dev'`
       
5. Next, initialize an API project by giving a name for the project. We will use the command below to create an API named `PetstoreAPI`.  This will create a folder named `PetstoreAPI` in your current directory.

       ```bash
       ./apictl init PetstoreAPI --oas https://petstore.swagger.io/v2/swagger.json
       ``` 
    
    Use the following command to see the various options of initializing a project. 
       ```bash
       ./apictl init --help
       ```

6. Open and explore the `PetstoreAPI` folder with an IDE (ex: VSCode). Navigate to `Meta-information` 
   directory. Open the `api.yaml` file. Alternatively, You can use a text editor to open this file as 
   well.
   
       Change the values of the attributes `status` and `productionUrl` as shown below and save the file. 
       
           `status: PUBLISHED`  
           `productionUrl: http://petstore.swagger.io/v2`  
           
    !!! info   
        Changing the default lifecycle status of the API from `CREATED` to `PUBLISHED`, will deploy    
        the API directly to the developer portal and API gateway, when we push this API to API Manager in 
        the following step. If you want to push this to the API publishing portal only, leave the status 
        as `CREATED`.    
        
6. Navigate back to the `apictl` directory. Execute the command below to push the API to API Manager. If this is the first time you are using the API controller you will be prompted to enter credentials of your account on API Manager. You can enter **`admin/admin`**.  
       ```bash
       ./apictl import-api --file ./PetstoreAPI --environment dev -k 

       ```

7. You should now see your API deployed successfully on API Manager. You can browse the developer portal or the API publisher portal to view its details. The API can be consumed as explained in sections [Subscribe to the API through the developer portal and generate keys](#subscribe-to-the-api-through-the-developer-portal-and-generate-keys) and [Invoke the API with the generated keys](#invoke-the-api-with-the-generated-keys)  