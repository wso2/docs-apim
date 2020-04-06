# AI-based Recommendations for the Developer Portal

## API Marketplace

Different marketplaces such as eBay, Amazon, or AliExpress exist. There are two types of users in these marketplaces. Sellers and Consumers. Sellers market their products in the marketplace by publishing details of the product and the respective price. While consumers consume these products after selecting the appropriate product based on their needs. The API domain possesses a similar concept. 

The Developer Portal in WSO2 API Manager is a marketplace for APIs. API Publishers (Sellers) will publish their APIs through the Publisher, and those APIs will be listed in the Developer Portal. application developers (Consumers) can sign in to the portal to choose and subscribe to as to which APIs to leverage in their applications. The products in API marketplaces (APIs) are constantly being updated with new features, new capabilities, and new use cases. How successful are you, when marketing a new API or a new feature of an existing API to the correct audience, when there are thousands of APIs in the marketplace?

Solution-seeking App developers know that they want APIs for their application, but they are not sure as to what the best solution is for their needs. There are thousands of different APIs, and the developer has to pick the APIs of interest by browsing through the APIs or searching for APIs using particular information associated with the API. 

## The solution

As a result, WSO2 API Manager has introduced Artificial Intelligence (AI) based recommendations for the Developer Portal. This feature addresses the latter mentioned issues by: 

- Providing better visibility for the API and finding the best audience for the API, so that the users will be very interested in the API's capabilities and use the APIs in their applications.
- Recommending APIs based on the application developers' interests and the application that they are creating.

    Using AI technologies, the recommendation system for the Developer Portal analyzes the behavior of the developers and applications that they are developing and suggests a list of new APIs that they have not subscribed to but which might be useful to the users for their project. There should be at least 20 APIs in the Developer Portal to be able to recommend APIs effectively.

The AI-based recommendations for the Developer Portal uses a specialized recommendation engine to process recommendation related events and produce recommendations. WSO2 will host and maintain this engine and provide access for all WSO2 customers as a service (SaaS) secured via OAuth2. If a specific customer requires this feature, they need to request a consumer key and secret from WSO2 via the WSO2 support portal. 

After the recommendations feature is activated, the recommendation feature related events will be published to this service. The recommendation engine analyzes all the information and runs through its algorithm to find the most suitable API recommendations for the user who is currently signed in to the Developer Portal. These APIs will then be listed in the Developer Portal, similar to the following image.

[![API recommendations]({{base_path}}/assets/img/learn/api-recommendations.png)]({{base_path}}/assets/img/learn/api-recommendations.png)

The following are the recommendation related events that are sent to the recommendations service:

-  **Publisher**

    The following are the API details that are sent from the Publisher. 

    API Name, Description, tags, resource paths. 
    
    WSO2 does not be store information that is in the description, tags, or resource path as it is. Instead, it will break the data down into meaningful keywords and only save the keywords.

- **Developer Portal**

    The following are the details that are sent from the Developer Portal.  
  
      - The name and description of the application that was created by the user. 
      - The clicked APIs and tags of a user. 
  
          The user name is anonymized, and an ID is used to store information. The ID to the name mapping is stored in the WSO2 API Manager database. Therefore, the recommendation server will not have access to this mapping.

### Responsibility of API publishers
If you want your API to be discovered by a larger audience, try to be descriptive when adding details with regard to the API. The recommendation engine analyzes the API name, API description, context, resource path, resource descriptions, resource summary, tags, and suggests the API in the Developer Portal. Meaningful descriptions with correct terminology will be picked first and recommended to the user.

### Responsibility of API subscribers
The recommendation engine will analyze the application name, application details when recommending APIs. Add a detailed description about your application. The recommendation engine will match the capabilities of the application and the use case will be matched with the APIs that are currently available in the Developer Portal. In addition, the recommendation engine will analyze the APIs that the user has previously viewed and the tags that the user has clicked when recommending an API. 

## Enabling recommendations for the Developer Portal

1. Add the following configurations in the `<API-M_HOME>/repository/conf/deployment.toml` file 

      ```
      [apim.devportal.recommendations]
      recommendations_api = "<Recommendations service provided by WSO2>"
      consumer_key = "<Provided by the WSO2 APIM team>"
      consumer_secret = "<Provided by the WSO2 APIM team>"
      ```

2.  If the server is already running, restart the server.

## Changing the default behavior of recommendations

Optionally, if you need to change the default behavior (i.e., the maximum number of recommendations, the wait duration, and whether the configuration is applicable to all the tenants or not) based on your requirements, follow the instructions below:

1. Navigate to the `<API-M_HOME>/repository/conf/deployment.toml` file.

2. Based on your requirement add the following configurations under `[apim.devportal.recommendations]`.

    !!! info

        If you do not define any of the following configurations, the default configurations will get automatically applied.

      ```
      max_recommendations = 10
      wait_duration = 10
      apply_for_all_tenants = false
      ```

    - **max_recommendations**: Max recommendations displayed in the Developer Portal. By default, 6 APIs are displayed in the Developer Portal.
    - **wait_duration**: Recommendations for users are requested from the API in 15 minutes intervals. If you need to change that interval, include this configuration and add the time in minutes.
    - **apply_for_all_tenants**: If the recommendations feature is enabled in a multi-tenant deployment, it will show recommendations in all the Developer Portals. If you need to apply the recommendation feature only for selected tenants, add `false` here. 

2.  If the server is already running, restart the server.

## Enabling recommendations only for a specific tenant

1. Navigate to the `<API-M_HOME>/repository/conf/deployment.toml` file.

2. Add the following configuration under the `[apim.devportal.recommendations]`.

      ```
      [apim.devportal.recommendations]
      apply_for_all_tenants = false
      ```

3. Start the WSO2 API Manager server.

    If you have already started the API-M server, restart it.

3. Sign in to the WSO2 API-M Management Console as the tenant admin.

      `https://<hostname>:9443/carbon`

4. Click **Main** --> **Resources** --> **Browse**.

5. Enter the following path in **Location:** and click **Go**.

      `/_system/config/apimgt/applicationdata/tenant-conf.json`
    
    ![Resources page]({{base_path}}/assets/img/learn/tenant-config.png)

6. Change the following configuration in the `tenant-conf.json` file.  

    `"EnableRecommendation" : true`