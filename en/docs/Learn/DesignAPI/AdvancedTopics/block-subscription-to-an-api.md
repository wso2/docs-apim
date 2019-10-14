# Block Subscription to an API

An API publisher **blocks subscription** to an API as a way of disabling access to it and managing its usage and monetization . A subscription blocking can be temporary or permanent. There is an unblocking facility to allow API invocations back.

You block APIs by subscriptions. That is, a given user is blocked access to a given API that s/he has subscribed to using a given application. If a user is subscribed to two APIs using the same application and you block access to only one of the APIs, s/he can still continue to invoke the other APIs that s/he subscribed to using the same application. Also, s/he can continue to access the same API subscribed to using different applications.

!!! info
API level subscription blocking is useful to control only the subscriptions created for a specific API by a user. If you want to block all API requests from a specific application/user/specific IP address or to a specific API, you can use [request blacklisting](_Managing_Throttling_) .


Blocking can be done at two levels:

-   **Block production and sandbox access** : API access is blocked with both production and sandbox keys.
-   **Block production access only** : Allows sandbox access only. This is useful when you want to fix and test an issue in an API. Rather than blocking all access, you can block production access only, allowing the developer to fix and test it.

!!! warning
When [API Gateway](Key-Concepts_103328852.html#KeyConcepts-APIGateway) caching is enabled (it is enabled by default), even after blocking a subscription, consumers might still be able to access APIs until the cache expires, which happens approximately every 15 minutes. Likewise, the API Gateway cache applies even when an API is unblocked.

!!! note
See the following topics for the descriptions on the concepts that you need to know when you block subscriptions to an API:

-   [Applications](Key-Concepts_103328852.html#KeyConcepts-Applications)
-   [Throttling](Key-Concepts_103328852.html#KeyConcepts-Throttlingtiers)
-   [Access tokens](Key-Concepts_103328852.html#KeyConcepts-Accesstokens)


1.  Create two APIs.
    1.  Sign in to the WSO2 API Publisher.
    2.  Create two APIs by the names `TestAPI1` and `TestAPI2` and publish them to the WSO2 API Store.
        For more information, see [Create and Publish an API](_Create_and_Publish_an_API_) .
        ![]({{base_path}}/assets/attachments/103332508/103332500.png)
2.  Subscribe to both the APIs.
    1.  Sign in to the WSO2 API Store and click **APIS** .
        Note that the two APIs are visible in the APIs page.
    2.  Subscribe to both APIs using the same application.
        You can use the default application or create your own.
        ![]({{base_path}}/assets/attachments/103332508/103332495.png)
    3.  Click the **View Subscriptions** button when prompted.
        The **Subscriptions** tab opens.

    4.  Click the **Production Keys** tab and click **Generate Keys** to create an application access token.
        If you have already generated an access token before, click **Re-generate** to renew the token.
        ![]({{base_path}}/assets/attachments/103332508/103332496.png)

3.  Invoke both APIs using the access token you received in the previous step.

    -   [**Format**](#Format)
    -   [**Example**](#Example)
    -   [**Response**](#Response)

    The following is the [cURL](http://curl.haxx.se/download.html) command format.

    **Command**

    ``` java
        curl -k -H "Authorization: Bearer <access_token>" '<API_URL>'
    ```

    **Command**

    ``` java
            curl -k -H "Authorization :Bearer 5fe40a53-2db6-3693-a9a9-bfccaaa5707d" 'https://localhost:8243/TestAPI1/1.0.0/CheckPhoneNumber?PhoneNumber=18006785432&LicenseKey=0'
    ```

    The placeholders mentioned in the format cURL command are replaced as follows:

    -`<access_token>` : Give the token generated in [step 2 (d)](#BlockSubscriptiontoanAPI-step2.d) .
    -`<API_URL>` : Go to the API's **Overview** tab in the API Store and copy the production URL and append the payload to it.

    ``` java
            <?xml version="1.0" encoding="utf-8"?>
            <PhoneReturn xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://ws.cdyne.com/PhoneVerify/query">
              <Company>Toll Free</Company>
              <Valid>true</Valid>
              <Use>Assigned to a code holder for normal use.</Use>
              <State>TF</State>
              <RC />
              <OCN />
              <OriginalNumber>18006785432</OriginalNumber>
              <CleanNumber>8006785432</CleanNumber>
              <SwitchName />
              <SwitchType />
              <Country>United States</Country>
              <CLLI />
              <PrefixType>Landline</PrefixType>
              <LATA />
              <sms>Landline</sms>
              <Email />
              <AssignDate>Unknown</AssignDate>
              <TelecomCity />
              <TelecomCounty />
              <TelecomState>TF</TelecomState>
              <TelecomZip />
              <TimeZone />
              <Lat />
              <Long />
              <Wireless>false</Wireless>
              <LRN />
    ```

    You have subscribed to two APIs and invoked them successfully. Let's block one subscription and see the outcome.

4.  Block an API.
    1.  Sign back in to the API Publisher.
    2.  Click **API** and click on the API that you need to block.
        In this case, click on the `TestAPI1` API.
    3.  Click **Subscriptions** to navigate to the managed subscription section.
        ![]({{base_path}}/assets/attachments/103332508/103332497.png)

    4.  Click **Block** .
        Note that the **Block** link immediately turns to **Unblock** , allowing you to activate the subscription back at any time.

5.  Invoke the APIs to test the blocked API.

    1.  Sign back in to the API Store.
    2.  Invoke the two APIs ( `TestAPI1` and `TestAPI2` ) again as mentioned in [step 3](#BlockSubscriptiontoanAPI-step3) .

                !!! tip
        You might have to **regenerate the access token** for the respective application that you subscribed the APIs to (for example in this case it will be `DefaultApplication)` if the access token expiration time (1 hour by default) has passed since the last time you generated it.


        Note that you can invoke `TestAPI2` again, but when you invoke `TestAPI1` , it gives a message that the requested API is temporarily blocked. Neither the API publisher nor any subscriber can invoke the API until the block is removed.

                !!! warning
        When [Gateway caching](Key-Concepts_103328852.html#KeyConcepts-APIGateway) is enabled, which is the case by default, the subscription blocking will take place only after the token cache expires (the default token cache expiry time is 15min). However, if the token is regenerated after the API is blocked, then the API will be blocked immediately.


        **Response when invoking TestAPI1**

        ``` java
                <ams:fault xmlns:ams="http://wso2.org/apimanager/security">
                   <ams:code>900907</ams:code>
                   <ams:message>The requested API is temporarily blocked</ams:message>
                   <ams:description>Access failure for API: /TestAPI1/1.0.0, version: 1.0.0 status: (900907) - The requested API is temporarily blocked</ams:description>
                </ams:fault>
        ```

    If you click **Applications** in the API Store, and select the application that you used to subscribe to the API, the details of the blocked subscription appears.

    ![]({{base_path}}/assets/attachments/103332508/103332498.png)

6.  Unblock the API.

    1.  Go back to the API Publisher.
    2.  Click on the respective API
        In this case click `TestAPI1 1.0.0` .
    3.  Click **Subscriptions** and click **Unblock** corresponding to the respective subscription.
        Make sure to click on the subscription that corresponds to the correct Application.

    If you invoke `TestAPI1` again, you will notice that you can invoke the API as usual.

        !!! warning
    When [Gateway caching](Key-Concepts_103328852.html#KeyConcepts-APIGateway) is enabled, which is the case by default, the subscription unblocking will take place only after the token cache expires (the default token cache expiry time is 15min). However, if the token is regenerated after the API is unblocked, then the API will be unblocked immediately.


You have subscribed to two APIs, blocked subscription to one and tested that you cannot invoke the blocked API.
