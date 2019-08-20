# Managing Throttling

This section guides you through the following areas:

-   [IP Whitelisting](#ManagingThrottling-IPWhitelisting)
    -   [Creating the Advanced Throttling policy](#ManagingThrottling-CreatingtheAdvancedThrottlingpolicy)
    -   [Engage the policy with an API](#ManagingThrottling-EngagethepolicywithanAPI)
-   [Blacklisting requests](#ManagingThrottling-Blacklistingrequests)
    -   [Blacklisting PhoneVerification API](#ManagingThrottling-BlacklistingPhoneVerificationAPI)
-   [Custom throttling](#ManagingThrottling-Customthrottling)

### IP Whitelisting

IP whitelisting is a way of configuring a filter to extract a particular set of known IP addresses and grant the access to the given assets for requests comes from those IPs only. With introducing Advanced Throttling in WSO2 API Manager you can achieve IP whitelisting via the features provided by Traffic Manager. For this we are creating an Advanced Throttling policy and attach it to the API.

##### Creating the Advanced Throttling policy

1.  Login to the admin portal of WSO2 API Manager (https://&lt;ip\_address&gt;:9443/admin).
2.  Open **Throttling Policies** tab and navigate to **Advanced Throttling.**
3.  Click ADD NEW POLICY to add a new Throttling tier.
    ![](attachments/103335009/103335012.png)4.  Fill the details as below and click **Add Conditional Group** .
    ![](attachments/103335009/103335011.png)5.  Open the Conditional Group added and fill the details.

    | Property            | Value                                                                                                          |
    |---------------------|----------------------------------------------------------------------------------------------------------------|
    | IP Condition Policy | Checked                                                                                                        |
    | IP Condition Type   | Specific IP                                                                                                    |
    | IP Address          | <IP_Address_to_be_whitelisted> E.g. 193.100.3.106                                                              |
    | Invert Condition    | Checked (If Invert Condition check then condition only apply to the IPs which not mention in IP Address above) |
    | Request Count       | 0                                                                                                              |

    Following is a example configuration.

    ![](attachments/103335009/103335019.png)
        !!! note
    In above configuration we are whitelisting a Specific IP.

    You can whitelist a rang of IP as well by selecting **IP Range** for the IP Condition Type in the Conditional Group and specifying the range.

    ![](attachments/103335009/103335018.png){height="250"}


6.  Click **Save** .
    ![](attachments/103335009/103335017.png)    You have successfully created the policy. Now we should engage this policy to an API.

##### Engage the policy with an API

1.  Login to API Publisher https://:9443/publisher.
2.  Edit API and go to Manage tab.
3.  Enable **Apply to API** under **Advance Throttling Policies** and select the newly created Throttling policy.
    ![](attachments/103335009/103335016.png)4.  Save and Publish the API.
    Now the API will be accessible only by the IP specified in the throttling policy.

        !!! info
    Since it takes some time to deploy the policy, the first few requests from the IPs other than the white-listed IP/IPs will be passed through. After the policy is successfully deployed, non-white-listed IP access will be blocked.

        !!! note
    API-M Throttling is asynchronous. When you apply a new whitelisting condition, note that at least one request has to go through for the condition to be applied


### Blacklisting requests

By blacklisting requests, you can protect servers from common attacks and abuse by users. For example, if a malicious user misuses the system, all requests received from that particular user can be completely blocked. Tenant administrative users can block requests based on the following parameters:

-   Block calls to specific APIs
-   Block all calls from a given application
-   Block requests coming from a specific IP address
-   Block a specific user from accessing APIs

To blacklist a request,

1.  Log in to the Admin Portal using the URL `                       https://localhost:9443/admin                     ` and your admin credentials.
2.  Click **Black List** under the **Throttle Policies** section and click **Add Item** .
    ![](attachments/103335009/103335010.png)
Select the item to black list, enter a value and click **Blacklist** .
![](attachments/103335009/103335024.png)

!!! warning
Note that you have to use " **/** " always infront of the **${context}** value when blacklisting the APIs with API context. E.g. **/test/1.0.0.** The sample provided in the product does not include "/" due to a known issue.
!!! info
You can temporary on/off the blacklisting condition by enabling/disabling the **Condition status** that is auto enabled when a blacklisting condition is created.
![](attachments/103335009/103335013.png){height="250"}

##### Blacklisting PhoneVerification API

As described above you can blacklist requests for APIs, by Applications, to IP Addresses and for Users. Let's see how we can blacklist the requests come to the [PhoneVerification API](https://docs.wso2.com/display/AM2xx/Quick+Start+Guide#QuickStartGuide-PublishingtheAPI) that we published in Quick Start Guide.

1.  Log in to the Admin Portal using the URL `                                    https://localhost:9443/admin                                 ` and your admin credentials.
2.  Click **Black List** under the **Throttle Policies** section and click **Add Item** .
3.  Select **API Context** and provide the Context of PhoneVerification API with version as the **Value.**
    ![](attachments/103335009/103335014.png)4.  Click **Blacklist.**
5.  Now login to API Store using the URL `                       https://localhost:9443/s                      tore          ` and [invoke the API](https://docs.wso2.com/display/AM2xx/Quick+Start+Guide#QuickStartGuide-InvokingtheAPI) .
    You will see the following response.
    ![](attachments/103335009/103335015.png)
### Custom throttling

Custom throttling allows system administrators to define dynamic rules for specific use cases, which are applied globally across all tenants. When a custom throttling policy is created, it is possible to define any policy you like. The Traffic Manager acts as the global throttling engine and is based on the same technology as WSO2 Complex Event Processor (CEP), which uses the [Siddhi query language](https://docs.wso2.com/complex-event-processor/SiddhiQL+Guide+3.1) . Users are therefore able to create their own custom throttling policies by writing custom Siddhi queries. The specific combination of attributes being checked in the policy need to be defined as the key (also called the key template). The key template usually includes a predefined format and a set of predefined parameters. It can contain a combination of allowed keys separated by a colon (:), where each key must start with the prefix $. The following keys can be used to create custom throttling policies:

`          resourceKey, userId, apiContext, apiVersion, appTenant, apiTenant, appId         `
For example, the following sample custom policy allows the admin user to send 5 requests per minute to the Pizza Shack API.

**Key Template**

``` java
    $userId:$apiContext:$apiVersion
```

**Siddhi query**

``` java
    FROM RequestStream
    SELECT userId, ( userId == 'admin@carbon.super'  and apiContext == '/pizzashack/1.0.0' and apiVersion == '1.0.0') AS isEligible ,
    str:concat('admin@carbon.super',':','/pizzashack/1.0.0:1.0.0') as throttleKey
     
    INSERT INTO EligibilityStream;
    FROM EligibilityStream[isEligible==true]#window.time(1 min)
    SELECT throttleKey, (count(throttleKey) >= 5) as isThrottled group by throttleKey
    INSERT ALL EVENTS into ResultStream;
```

![](attachments/103335009/103335022.png)

As shown in the above Siddhi query, the throttle key must match the key template format. If there is a mismatch between the key template format and the throttle key, requests will not be throttled.
