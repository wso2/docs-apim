# Create a New API Version

You need to create a new **API version** when you want to change a published API's behavior,
authentication mechanism, resources, [throttling tiers]({{base_path}}/learn/rate-limiting/introducing-throttling-use-cases/), target audiences, etc. WSO2 does not recommend to modify a published API that has subscribers plugged into it.

After creating a new version, you typically deploy it as a prototype for early promotion.
A prototype can be used for testing, without a subscription, along with the published versions of the API. After a period of time of using the new version of the API in parallel with the older versions, you can publish the prototyped API and deprecate the older versions.

!!! note
    The example here uses the PizzaShack API, which you created in the
    [Create a REST API]({{base_path}}/learn/design-api/create-api/create-a-rest-api/) section and Published in the [Publish an API]({{base_path}}/learn/design-api/publish-api/publish-an-api/) section.

Follow the instructions below to create a new version of an existing API:

1.  Sign in to the WSO2 API Publisher.
     
     `https://<hostname>:9443/publisher` 
     
     Create and publish an API. For more information, see [Create a REST API]({{base_path}}/learn/design-api/create-api/create-a-rest-api/) and [Publish an API]({{base_path}}/learn/design-api/publish-api/publish-an-api/).

2.  Navigate to the API listing page, and click on the API for which you want to create a new version (e.g., `PhoneVerification 2.0.0`). 
                                        
3.  Click **Create New Version**.
     
     [![Create New Version button]({{base_path}}/assets/img/learn/create-new-version-button.png)]({{base_path}}/assets/img/learn/create-new-version-button.png)

4.  Enter a version number and click **Create**. 

     [![Create New API Version]({{base_path}}/assets/img/learn/create-new-api-version.png)]({{base_path}}/assets/img/learn/create-new-api-version.png)

     You are redirected to the API **Overview** page. 

!!! note
    For more details on the default version, see [Backward Compatibility]({{base_path}}/learn/design-api/api-versioning/backward-compatibility/) section.

!!! note
    By default, only the latest version of an API is shown in the Developer Portal. If you want to display multiple versions, add/change the following configuration in the `<API-M_HOME>/repository/conf/deployment.toml` file, and restart the server.
    ``` toml
       [apim.devportal]
       display_multiple_versions = true
    ```

You have created a new version of an API. In the next tutorial, let's learn how to
[publish the new version and deprecate old API versions]({{base_path}}/learn/design-api/api-versioning/deprecate-the-old-version/).

