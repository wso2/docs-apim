# Create a New API Version

A new **API version** is created when you want to change a published API's behavior, authentication mechanism, [resources](https://docs.wso2.com/display/AM260/Key+Concepts#KeyConcepts-APIresources) , [throttling tiers](https://docs.wso2.com/display/AM260/Setting+Throttling+Limits) , target audiences etc. It is not recommended to modify a published API that has subscribers plugged to it.

After creating a new version, you typically deploy it as a prototype for early promotion. A prototype can be used for testing, without subscription, along with the published versions of the API. After a period of time during which the new version is used in parallel with the older versions, the prototyped API can be published and its older versions can be deprecated.

!!! note
The example here uses the PhoneVerification API, which you created in the [Create and Publish an API](https://docs.wso2.com/display/AM260/Create+and+Publish+an+API) section.


The steps below show you how to create a new version of an existing API.

1.  Sign in to the WSO2 API Publisher.
`https://<hostname>:9443/publisher         `
    Refer **step 1** of [Create and Publish an API](https://docs.wso2.com/display/AM260/Create+and+Publish+an+API) to sign in to the Publisher.
2.  Click on the API name that corresponds to the API for which you want to create a new version (e.g., `PhoneVerification 1.0.0` ).
    The API opens.
3.  Click **Create New Version** .
    ![Create New Version button]({{base_path}}/assets/attachments/103328571/103328574.png)

4.  Enter a version number, select the default version option, and click **Done** .
    The **APIS** page opens.
    ![Create New API Version]({{base_path}}/assets/attachments/103328571/103328576.png)

        !!! tip
    -   The **Default Version** option means that you make this version the default in a group of different versions of the API. A default API can be invoked without specifying the version number in the URL. For example, if you mark http://host:port/youtube/ 2.0 as the default version when the API has 1.0 and 3.0 versions as well, requests made to [http://host:port/youtube/](http://hostport) get automatically routed to version 2.0.

    -   If you mark any version of an API as the default, two API URLs are listed in its **Overview** tab in the API Store. One URL is with the version and the other is without. You can invoke a default version using both URLs.

        If you mark an unpublished API as the default, the previous default published API is used as the default until the new default API is published (or prototyped).


5.  Click the **Edit** icon of the new API version to edit it.
    ![View New API Version]({{base_path}}/assets/attachments/103328571/103328575.png)

6.  Do the required modifications to the API.
    For example, let's assume that the POST method is redundant, and let's delete it from the resource that we added to the API at the time it was created.
    ![Update New API Version]({{base_path}}/assets/attachments/103328571/103328573.png)
        !!! note
    There is a known issue in API Manager 2.2.0 which is when creating a new version of an API with the SOAP Endpoint, it cannot be modified and saved with the existing WSDL endpoint set. Therefore, as a workaround, edit the API and change the existing WSDL endpoint to the correct WSDL endpoint before doing other modifications to the new version of the API.

    ![Known Error can not update existing WSDL endpoint]({{base_path}}/assets/attachments/103328571/103328572.png)

7.  Click **Save** once the edits are done.

!!! tip
**Tip** : By default, only the latest version of an API is shown in the API Store. If you want to display multiple versions, set the `<DisplayMultipleVersions>` element to `true` in the `<API-M_HOME>/repository/conf/api-manager.xml` file, and restart the server.


You have created a new version of an API. In the next tutorial, let's learn how to [deploy this API as a prototype](_Deploy_and_Test_Mock_APIs_) and test it with its older versions.
