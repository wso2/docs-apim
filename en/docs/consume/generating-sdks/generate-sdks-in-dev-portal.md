# Generate SDKs in the Developer Portal

A Software Development Kit (SDK) is a set of software development tools that allows you to create applications for a specific platform. If an API consumer wants to create an application, they can generate a client-side SDK for a supported language/framework and use it to write a software application to consume the subscribed APIs. 

## Downloading SDKs from the Developer Portal

Follow the instructions below to generate and download client-side SDKs via the Developer Portal:

1.  Sign in to the WSO2 API Developer Portal.

     (`https://<hostname>:<port>/devportal`)

2. Click on the API for which you want to generate a client-side SDK (e.g., `PizzaShackAPI`).

     [![API Overview]({{base_path}}/assets/img/consume/select-api-dev-portal.png)]({{base_path}}/assets/img/consume/select-api-dev-portal.png)
 
3.  Click **SDKs**. 

     The default SDKs that you can download appear. 

     [![Default SDKs]({{base_path}}/assets/img/consume/default-sdks.png)]({{base_path}}/assets/img/consume/default-sdks.png)
    
4.  Click **Download** to download the required SDK. 

     This downloads the ZIP archive of the SDK.

     <a href="{{base_path}}/assets/img/learn/download-sdk.png"><img src="{{base_path}}/assets/img/learn/download-sdk.png" alt="Download SDK" title="Download SDK" width="80%" /></a>    
    
##  Configuring supported languages for SDK generation

By default, **Android, Java, JavaScript**, and **JMeter** the SDKs that are available to be downloaded via the Developer Portal in WSO2 API Manager (WSO2 API-M). In addition to the latter mentioned SDKs, WSO2 API Manager also supports SDK generation for the following languages. **Scala, C-Sharp (C#), Dart, Flash, Groovy, Node.js (NodeJs), Perl, PHP, Python, Ruby, Swift, Clojure, AsyncScala, CsharpDotNet2**.

Follow the instructions below to configure the languages available for SDK generation:

1.  Open `<API-M_HOME>/repository/conf/deployment.toml` file.

2.  Add the following configuration to specify the required languages.

    ```toml
    [apim.sdk]
    supported_languages = ["android", "java", "scala", "csharp", "dart", "flash", "groovy", "javascript"]
    ```
    
3.  [Restart the server]({{base_path}}/install-and-setup/install/installing-the-product/running-the-api-m/) to apply the configuration changes.
