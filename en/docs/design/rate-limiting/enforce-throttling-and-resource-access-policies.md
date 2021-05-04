# Enforce Throttling and Resource Access Policies

**Throttling** allows you to limit the number of hits to an API during a given period, typically to protect your APIs from security attacks and your backend services from overuse, regulate traffic according to infrastructure limitations and to regulate usage for monetization. For information on different levels of throttling in WSO2 API Manager (WSO2 API-M), see [Throttling tiers](_Setting_Throttling_Limits_) .

!!! note
    This tutorial uses the `PizzaShack` API, which has  GET and POST methods to access it and a throttling policy enforced.

    **Before you begin** , follow the [Create and Publish an API]({{base_path}}/create-api/create-rest-api/create-a-rest-api/) to create and publish the `PizzaShack` API and then the [Subscribe to an API]({{base_path}}/consume/invoke-apis/invoke-apis-using-tools/invoke-an-api-using-the-integrated-api-console/) to subscribe to the API using the `Bronze` throttling tier.


After you created, published, and subscribed to the API, let's see how the API Gateway enforces throttling and resource access policies to the API.

1.  Sign in to the Developer portal and select the PizzaShack API.
    Go to the subscriptions tab and make sure we have subscribed to an application or if not subscribe.
    [![Subscribed Applications]({{base_path}}/assets/img/learn/learn-throttling-isapplication-subscribed.png)]({{base_path}}/assets/img/learn/learn-throttling-isapplication-subscribed.png)

2.  Go to the Applications tab and go in to the Default Application, click the **Production Keys** tab and generate an access token. If you already have an access token for the application, you have to regenerate it after 1 hour. Copy the access token after it has been generated.
    [![Generate-keys]({{base_path}}/assets/img/learn/learn-throttling-generate-keys.png)]({{base_path}}/assets/img/learn/learn-throttling-generate-keys.png)

    Let's invoke this API.

3.  Click on the API, then go to its **Try Out** tab. Enter the copied access token.
    [![Tryout]({{base_path}}/assets/img/learn/learn-throttling-tryout.png)]({{base_path}}/assets/img/learn/learn-throttling-tryout.png)

4.  Expand the GET method and click Try it out. Provide the required parameters and click **Execute** to invoke the API. For example,

    |                 |                            |
    |-----------------|----------------------------|
    | **OrderID** | E.g., 7fd574cc-49e7-4491-973c-08214b2c64fc         |

    [![Query]({{base_path}}/assets/img/learn/learn-throttling-enter-query.png)]({{base_path}}/assets/img/learn/learn-throttling-enter-query.png)

     Note the response that appears in the API Console. As we used a valid order id in this example, the response returns a correct order details.
    [![Query response]({{base_path}}/assets/img/learn/learn-throttling-query-response.png)]({{base_path}}/assets/img/learn/learn-throttling-query-response.png)
    
    Note that you subscribed to the API on the Bronze throttling tier. The Bronze tier allows you to make a 1000 calls to the API per minute. If you exceed your quota, you get a throttling error as shown below.
    [![Error response]({{base_path}}/assets/img/learn/learn-throttling-error-response.png)]({{base_path}}/assets/img/learn/learn-throttling-error-response.png)
