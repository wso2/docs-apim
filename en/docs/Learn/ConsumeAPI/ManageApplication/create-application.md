# Create Application

#### Overview

An application is a logical collection of APIs. An application is primarily used to decouple the consumer from the APIs. It allows you to:

-   Generate and use a single key for multiple APIs
-   Subscribe multiple times to a single API with different tiers/Service Level Agreement (SLA) levels

You subscribe to APIs through an application. Applications are available at different SLA levels and have application-level throttling tiers engaged in them. A throttling tier determines the maximum number of calls you can make to an API during a given period of time.

The API Manager comes with a pre-created default application, which allows unlimited access by default. You can also [create](https://docs.wso2.com/display/AM260/Subscribe+to+an+API) your own

#### **Create Applications**

1.  Sign in to the WSO2 API Store ( `           https://<hostname>:9443/store          ` ).

2.  Click the **Applications** menu and click **Add Application** to create a new application.

3.  Enter the name as TestApp and select the per token quota as 50PerMin for the application and click **Add** .

