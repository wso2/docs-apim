#Generate SDKs in Developer Portal

A software development kit (SDK) is a set of software development tools that allows to create applications for a specific platform. If an API consumer wants to create an application, they can generate a client side SDK for a supported language/framework and use it to write a software application to consume the subscribed APIs. 

## Download SDK from Dev Portal

Following are the steps to generate and download client-side SDKs via API Dev Portal.

1.  Sign in to the WSO2 API Developer Portal ( `https://<hostname>:<port>/devportal` ) and click on the API you want to generate a client-side SDK (e.g., `PizzaShackAPI` ) 

    <a href="{{base_path}}/assets/img/Learn/select-api-dev-portal.png" ><img src="{{base_path}}/assets/img/Learn/select-api-dev-portal.png" alt="API Overview" title="API Overview" width="70%" /></a>
 
2.  Navigate to SDK tab. Then you will find SDKs which are available to download by default. 

    <a href="{{base_path}}/assets/img/Learn/default-sdks.png" ><img src="{{base_path}}/assets/img/Learn/default-sdks.png" alt="API Overview" title="API Overview" width="70%" /></a>
    
3.  Click on the **Download** button to download the required SDK. Then the zip archive of the SDK will be downloaded. 

    <a href=    "{{base_path}}/assets/img/Learn/download-sdk.png" ><img src="{{base_path}}/assets/img/Learn/download-sdk.png" alt="API Overview" title="API Overview" width="70%" /></a>    
    
##  Configuring supported languages for SDK generation

By default, **android, java, javascript** and **jmeter** SDKs are available to be downloaded via dev portal. In addition to that API Manager supports SDK generation for following languages too. **scala, csharp, dart, flash, groovy, nodejs, perl, php, python, ruby, swift, clojure, asyncScala, csharpDotNet2**.

Follow the below steps to configure the languages available for SDK generation.

1.  Open `<API-M_HOME>/repository/conf/deployment.toml` file.

2.  Add following configuration, specifying the required languages.

    ```toml
    [apim.sdk]
    supported_languages = "android, java, scala, csharp, dart, flash, groovy, javascript"
    ```
    
3.  [Restart the server]({{base_path}}/InstallAndSetup/InstallationGuide/running-the-product/) to get the configuration changes applied.
