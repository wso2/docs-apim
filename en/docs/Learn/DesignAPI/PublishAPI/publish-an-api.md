# Publish an API

**API Publishing** is the process of making the API visible in the API Store and available for subscription. An API  in the lifecycle state CREATED will have the  API metadata added to the API Store, but not deployed to the API Gateway and therefore, it  is not visible to subscribers in the API Store. An **API Publisher** can publish the API  which will in turn deploy the API on the API Gateway and change the API lifecycle state to PUBLISHED.

Follow the steps below to learn how to publish an API from the WSO2 API Manager.

1.  Sign in to the API Publisher `https://<hostname>:9443/publisher` (e.g., `https://localhost:9443/publisher` ). Upon signing in, the list of APIs in the API Publisher is listed.

    !!! note
            In order to demonstrate how to publish an API, the PhoneVerificationAPI, version 2.0.0, is used.


2.  Click on an API in the created state .When the API opens go to its **Lifecycle** tab and click **Publish** .
    The check boxes mean the following:
    -   **Require re-subscription when publish the API** : Invalidates current user subscriptions, forcing users to subscribe again. 
    -   **Deprecate old versions after publish the API** : If selected, any prior versions of the API that are published will be set to the DEPRECATED state automatically.
3.  Go to the API Store ( `https://<hostname>:9443/devportal)` using your browser and note that the API ( `PhoneVerification 2.0.0` API) which was in the CREATED state is visible under the **APIs** listing.


