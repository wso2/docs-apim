# Enforce Throttling and Resource Access Policies

**Throttling** allows you to limit the number of hits to an API during a given period, typically to protect your APIs from security attacks and your backend services from overuse, regulate traffic according to infrastructure limitations and to regulate usage for monetization. For information on different levels of throttling in WSO2 API Manager (WSO2 API-M), see [Throttling tiers](_Setting_Throttling_Limits_) .

!!! note
    This tutorial uses the `PhoneVerification` API, which has one resource, GET and POST methods to access it and a throttling policy enforced.

    **Before you begin** , follow the [Create and Publish an API](../../../learn/tutorials/create-and-publish-an-api) to create and publish the `PhoneVerification` API and then the [Subscribe to an API](../../../learn/tutorials/subscribe-to-an-api/) to subscribe to the API using the `Bronze` throttling tier.


After you created, published, and subscribed to the API, let's see how the API Gateway enforces throttling and resource access policies to the API.

1.  Sign in to the Devportal and select the PhoneVerification API.
    Go to the credentials tab and make sure we have subscribed to an application or if not subscribe.
    ![]({{base_path}}/assets/img/learn/learn-throttling-isapplication-subscribed.png)

2.  Go to the Applications tab and go in to the Default Application, click the **Production Keys** tab and generate an access       token. If you already have an access token for the application, you have to regenerate it after 1 hour. Copy the access         token after it has been generated
    ![]({{base_path}}/assets/img/learn/learn-throttling-generate-keys.png)

    Let's invoke this API.

3.  Click on the API, then go to its **Try Out** tab. Enter the copied access token.
    ![]({{base_path}}/assets/img/learn/learn-throttling-tryout.png)

4.  Expand the GET method and click Try it out. Provide the required parameters and click **Execute** to invoke the API. For example,

    |                 |                            |
    |-----------------|----------------------------|
    | **PhoneNumber** | E.g., 18006785432          |
    | **LicenseKey**  | Give 0 for testing purpose |

    ![]({{base_path}}/assets/img/learn/learn-throttling-enter-query.png)

     Note the response that appears in the API Console. As we used a valid phone number in this example, the response returns as valid.
    ![]({{base_path}}/assets/img/learn/learn-throttling-query-response.png)
    Note that you subscribed to the API on the Bronze throttling tier. The Bronze tier allows you to make a 1000 calls to the API per minute. If you exceed your quota, you get a throttling error as shown below.
    ![]({{base_path}}/assets/img/learn/learn-throttling-error-response.png)