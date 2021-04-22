# Block Subscription to an API

An API publisher can **block subscription** to an API as a way of disabling access to it and managing its usage and monetization. Subscription blocking can be temporary or permanent. There is an unblocking facility to allow API invocations again.

You can block APIs by subscription by blocking access to a respective user to access a specific API that they had subscribed to using a particular application. If a user has subscribed to two APIs, using the same application, and you block access to only one of the APIs, the respective user can continue to invoke the other API that they had previously subscribed to using the same application. In addition, the user can continue to access the same API subscribed to using different applications.

!!! info
    API level subscription blocking is useful to control only the subscriptions created for a specific API by a user. If you want to block all API requests from a specific application/user/specific IP address or to a specific API, you can use [request denylisting]({{base_path}}/design/rate-limiting/access-control/#denying-requests).


Blocking can be done at two levels:

-   **Block production and sandbox access**: API access is blocked with both production and sandbox keys.
-   **Block production access only**: Allows sandbox access only. This is useful when you want to fix and test an issue in an API. Rather than blocking all access, you can block production access only, allowing the developer to fix and test it.

  <html>
  <div class="admonition warning">
  <p class="admonition-title">Warning</p>
  <p>When <a href="{{base_path}}/getting-started/overview/#api-gateway">API Gateway</a> caching is enabled (it is enabled by default), even after blocking a subscription, consumers might still be able to access APIs until the cache expires, which happens approximately every 15 minutes. Likewise, the API Gateway cache applies even when an API is unblocked.</p>
  </div> 
  
  <div class="admonition note">
  <p class="admonition-title">Note</p>
  <p>See the following topics for the descriptions on the concepts that you need to know when you block subscriptions to an API:
  <ul>
    <li><a href="{{base_path}}/getting-started/key-concepts/#application">Applications</a></li>
    <li><a href="{{base_path}}/getting-started/key-concepts/#rate-limits">Rate Limiting</a></li>
    <li> <a href="{{base_path}}/getting-started/key-concepts/#access-token">Access tokens</a></li></ul>
    </p>
  </div> 
  </html>

1.  Create two APIs.
     1.  Sign in to WSO2 API Publisher.

     2.  Create two APIs and publish them to WSO2 API Developer Portal.

         `https://<hostname>:9443/devportal` 

         (e.g., `https://localhost:9443/devportal`). 

         <html>
         <div class="admonition tip"> 
         <p class="admonition-title">Tip</p>
         <p>For more information, see [Create and Publish an API]({{base_path}}/design/create-api/create-rest-api/create-a-rest-api/).</p>
         </div>
         </html>
         
         [![Block subscription for two APIs]({{base_path}}/assets/img/learn/two-apis-for-block-subscription.png)]({{base_path}}/assets/img/learn/two-apis-for-block-subscription.png)

2.  Subscribe to both the APIs.
     1.  Sign in to WSO2 API Developer Portal and click **APIs**.

         Note that the two APIs are visible in the APIs page.

     2.  Subscribe to both APIs using the same application.

         You can use the default application or create your own.

         [![Have the same application for two APIs]({{base_path}}/assets/img/learn/same-application-for-two-apis.png)]({{base_path}}/assets/img/learn/same-application-for-two-apis.png)
         
         You can see the APIs that you have subscribed to and the **Status** as **unblocked**.

         [![Same application subscribed for two APIs]({{base_path}}/assets/img/learn/same-application-subscribed-for-two-apis.png)]({{base_path}}/assets/img/learn/same-application-subscribed-for-two-apis.png)
        
     3.  Generate keys and obtain an access token for application.
       
3.  Invoke both the APIs using the access token you received in the previous step.
     
      <html>
      <div class="admonition tip"> 
      <p class="admonition-title">Tip</p>
      <p>For more information, see  [Consume an API]({{base_path}}/consume/invoke-apis/invoke-apis-using-tools/invoke-an-api-using-the-integrated-api-console/).</p>
      </div>
      </html>

     [![Response when you have the same application for two APIs]({{base_path}}/assets/img/learn/same-application-for-two-apis-response.png)]({{base_path}}/assets/img/learn/same-application-for-two-apis-response.png)

     The following is the [cURL](http://curl.haxx.se/download.html) command format for PhoneVerification API.
     
     **Command**
 
     ``` java
     curl -X GET "https://localhost:8243/phoneverify/1.0.0/CheckPhoneNumber?PhoneNumber=18006785432&LicenseKey=0" -H "accept: application/json" -H "Authorization: Bearer <access-token>"
     ```

     You can invoke the **PizzaShackAPI** with the same token.
     You have subscribed to two APIs and invoked them successfully. Let's block one subscription and see the outcome.

4.  Block an API.

     1.  Sign in to the API Publisher.

     2.  Click **API** and click on the API that you need to block.

         In this case, click on the `PhoneVerification` API.

     3.  Go to **Portal Configurations** and click **Subscriptions** to navigate to the managed subscription section.

         <a href="{{base_path}}/assets/img/learn/subscriptions-menu.png" alt="subscriptions menu"><img src="{{base_path}}/assets/img/learn/subscriptions-menu.png" width=250></a>

     4. Click **Block All**.

        [![Have the same application for two APIs and block all subscriptions]({{base_path}}/assets/img/learn/same-application-subscribed-for-two-apis-and-blocked.png)]({{base_path}}/assets/img/learn/same-application-subscribed-for-two-apis-and-blocked.png)
        
       <html>
       <div class="admonition tip"> 
       <p class="admonition-title">Tip</p>
       <p>You can choose **Block Production Only** instead of **Block All**. In addition, you can unblock the subscriptions that you have previously blocked by clicking **Unblock**.</p>
       </div>
       </html>

5.  Invoke the APIs to test the blocked API.

    1. Sign in to the Developer Portal.

    2. Invoke the two APIs (`PizzaShackAPI` and `PhoneVerification`) again.

         <html>
         <div class="admonition tip">
         <p class="admonition-title">tip</p>
         <p>If the access token expiration time (1 hour by default) has passed since the last time you generated it, you might have to <b>regenerate the access token</b> for the respective application that you subscribed the APIs to (for example in this case it will be `NewApplication)`. </p>
         </div>
         </html>

         Note that you can invoke `PizzaShackAPI` again, but when you invoke `PhoneVerification`, it gives a message that the requested API is temporarily blocked. Neither the API publisher nor any subscriber can invoke the API until the block is removed.

         <html>
         <div class="admonition warning">
         <p class="admonition-title">Warning</p>
         <p>When [Gateway caching]({{base_path}}/getting-started/overview/#api-gateway) is enabled, which is the case by default, the subscription blocking will take place only after the token cache expires (the default token cache expiry time is 15min). However, if the token is regenerated after the API is blocked, then the API will be blocked immediately.</p>
         </div>
         </html>


        **Response when invoking PhoneVerification**

        ``` json
        {
            "code": "900907",
            "message": "The requested API is temporarily blocked",
            "description": "User is NOT authorized to access the Resource. API Subscription validation failed."
        }
        ```

        [![Have the same application for two APIs and block response]({{base_path}}/assets/img/learn/same-application-subscribed-for-two-apis-and-blocked-response.png)]({{base_path}}/assets/img/learn/same-application-subscribed-for-two-apis-and-blocked-response.png)
        
     If you click **Applications** in the Developer Portal, and select the application that you used to subscribe to the API, the details of the blocked subscription appears.

     [![Same application subscribed for two APIs and combined subscription]({{base_path}}/assets/img/learn/same-application-subscribed-for-two-apis-and-combined-subscription.png)]({{base_path}}/assets/img/learn/same-application-subscribed-for-two-apis-and-combined-subscription.png)

6.  Unblock the API.

     1.  Go back to the API Publisher.

         `https://<hostname>:9443/publisher` 

         (e.g., `https://localhost:9443/publisher`). 

     2.  Click on the respective API.

         In this case, click `PhoneVerification`.

     3.  Go to **Portal Configurations** and click on **Subscriptions** and click **Unblock** corresponding to the respective subscription.

         Make sure to click on the subscription that corresponds to the correct application.

         If you invoke `PhoneVerification` again, you will notice that you can invoke the API as usual.

         <html>
         <div class="admonition warning">
         <p class="admonition-title">Warning</p>
         <p>When [Gateway caching]({{base_path}}/getting-started/overview/#api-gateway) is enabled, which is the case by default, the subscription unblocking will take place only after the token cache expires (the default token cache expiry time is 15min). However, if the token is regenerated after the API is unblocked, then the API will be unblocked immediately.</p>
         </div>
         </html>

You have subscribed to two APIs, blocked subscription to one and tested that you cannot invoke the blocked API.
