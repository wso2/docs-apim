
# AI based Recommendation System for the Developer portal

## API Marketplace

You must be  familiar with different marketplaces such as Ebay, Amazon or AliExpress. 
There are two types of users in these marketplaces. Sellers and Consumers. 
Sellers market their products in the marketplace by publishing details of the product and the price. 
Consumers consume these products after selecting the appropriate product based on their needs. 
This concept is equally valid for API domain. 

WSO2 API Manager Developer Portal is a marketplace for APIs. API publishers (Sellers) will publish their APIs 
through the Publisher and those APIs will be listed in the developer portal. Application Developers (Consumers) can 
login to the portal to choose and subscribe which APIs to leverage in their applications. The products in API 
marketplaces (APIs) are constantly updating with new features, new capabilities and new use cases. How successful are we, 
when marketing a new API or a new feature of an existing API to the correct audience, when there are thousands of APIs 
in the marketplace?

Solution-seeking App developers know that they want APIs for their application, but they aren’t sure what the best 
solution is for their needs. There are thousands of different APIs and the developer has to pick the APIs of interest 
by browsing through the APIs or searching with a particular information associated with the API. 

With this feature, we are addressing the two issues mentioned above.  

- Have a better visibility to the API and Find the best audience for the API, whom will be really interested in the
 APIs capabilities and use it in their applications.
- Recommending APIs based on the application developers interests and the application that they are creating.

Using AI technologies, this feature will analyze the behavior of the developer, application that he or she is 
developing and suggest a list of new APIs that are not subscribed by the user but might be useful for the project. 
In order to recommend effectively, there must be at least 20 APIs in the portal.

## Solution
Recommendation service is available as a SaaS service for all wso2 customers and secured via oauth2. If a specific 
customer requires to enable this feature, they will have to request a consumer key and secret via the wso2 support 
portal. Once the recommendations feature is activated, recommendation feature related events will be 
published to this recommendations API. The recommendation service analyzes all the information and runs through its 
algorithm to find the most suitable API recommendations for the logged-in user. These APIs will then be listed in the 
devportal similar to the following image.

![](../assets/img/api-recommendations.png)

## To API Publishers
If you want your API to be discovered by a larger audience, try to be descriptive when adding details of the API. 
Recommendation features analyze the API name, API description, context, resource path, resource descriptions, resource 
summary, tags and suggest the API in the developer portal. Meaningful descriptions with correct terminology will be 
picked first and recommended to the user.

## To API Subscribers
Recommendation feature will analyze the Application name, Application details when recommending APIs. Adding a 
detailed description about your application, it’s capabilities and the use case will be matched with the APIs that 
are currently available in the Developer portal. Also the feature will analyze the APIs that the user has previously 
viewed and the clicked tags when recommending an API. 

### How to enable the feature

Add the following configurations to the `<API-M_HOME>/repository/conf/deployment.toml` file and restart the server.

```
[apim.devportal.recommendations]
recommendations_api = "<Recommendations service provided by WSO2>"
consumer_key = "<Provided by the WSO2 APIM team>"
consumer_secret = "<Provided by the WSO2 APIM team>"
```

### Additional configurations
Only add the following configurations if you need to change the default behaviour.
```
max_recommendations = 10
wait_duration = 10
apply_for_all_tenants = false
```

- **max_recommendations**: Max recommendations displayed in the developer portal. (By default 6 APIs are displayed in
 the developer portal)
- **wait_duration**: Recommendations for users are requested from the API in 15 minutes intervals. If that interval
 needs to be changed, add the time in minutes.
- **apply_for_all_tenants**: In a multi tenant deployment, if recommendations feature is enabled, it will show
 recommendations in all the developer portals and if you need to apply the recommendation feature only for selected 
 tenants, add false here. 

### Enable recommendations feature only for a specific tenant

1. Add `apply_for_all_tenants = false` in deployment.toml under `[apim.devportal.recommendations]`
2. Start the WSO2 API Manager server.
3. Sign in to the WSO2 API-M Management Console as the tenant admin.
       `https://<hostname>:9443/carbon`
4. Click **Main**, navigate to **Resources**, and click **Browse**.
5. Enter the following path in **Location:** and click **Go**.
  `/_system/config/apimgt/applicationdata/tenant-conf.json`
  ![Resources page]({{base_path}}/assets/img/learn/tenant-config.png)
6. Change the following configuration in the tenant-conf.json file.  
    `"EnableRecommendation" : true`