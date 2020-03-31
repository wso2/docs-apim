# Deprecate the Old Version

You **publish an API** to make it available for subscription in the API Store. If you set up multiple tenants, your tenant store will be visible to other tenants as well. Therefore, users of the other tenants can view the APIs that are published in your default API Store. This allows you to advertise your APIs to a wider audience. Although the APIs that are published in your tenant store are visible to the users of other tenant stores, they need to sign in to your tenant store in order to subscribe and use them.

!!! note
For more details on the API lifecycle stages, see [API lifecycle](https://docs.wso2.com/display/AM260/Key+Concepts#KeyConcepts-APIlifecycle) .


The steps below show you how to publish an API to its default API Store:

1.  Sign in to the WSO2 API Publisher as a user who has the publisher role assigned to themselves.
`https://<hostname>:9443/publisher         `
2.  Click on the API that you prototyped in the previous tutorial (e.g., `PhoneVerification 2.0.0` ).
    ![Select the PhoneVerification 2.0.0 API]({{base_path}}/assets/attachments/103328593/103328597.png)
3.  Click **GO TO OVERVIEW** .

4.  Go to the API's **Lifecycle** tab and click **Publish** .

        !!! info
    The **Lifecycle** tab is only visible to users with publisher privileges.


    ![Publish the PhoneVerification 2.0.0 prototyped API]({{base_path}}/assets/attachments/103328593/103328595.png)
        !!! tip
    -   Leave the **Requires Re-Subscription** check box cleared if you want all users who are subscribed to the older version of the API to be automatically subscribed to the new version. If not, they need to subscribe to the new version again.

    -   You can choose to deprecate old versions of this API at this stage by selecting the **Deprecate Old Versions** check box.


    The API is now published to the default API Store.

5.  Sign in to the default Store and click on the APIs menu to see the API that you just published listed there.
6.  Go back to the WSO2 API Publisher and click the API that you want to deprecate (e.g., `PhoneVerification 1.0.0` ).

7.  Go to the API's **Lifecycle** tab and click **Deprecate** .
    ![Deprecate the PhoneVerification 1.0.0 API]({{base_path}}/assets/attachments/103328593/103328594.png)    The API is now deprecated.

8.  Go back to the WSO2 API Store, click the **Applications** menu, click on **TestApp** to open the TestApp application, which you used to [subscribe to the API](https://docs.wso2.com/display/AM260/Subscribe+to+an+API) . Click on the **Subscriptions** tab to view the deprecated API.
    The subscriptions made to the older API versions should be deprecated now.

    ![View the deprecated and published API in the subscriber list]({{base_path}}/assets/attachments/103328593/103328596.png)
        !!! tip
    When an API is deprecated, new subscriptions are disabled (you cannot see the subscription options), and existing subscribers can continue to use the API as usual until it is eventually retired.


You have published an API to the API Store and deprecated its previous versions.
