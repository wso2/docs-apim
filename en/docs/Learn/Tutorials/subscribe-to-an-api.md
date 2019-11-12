# Subscribe to an API

You __subscribe__ to a published API before using it in your applications. Subscription enables you to receive access tokens and be authenticated to invoke the API.

!!! note
    See the following topics for a description of the concepts that you need to know when subscribing to an API:

    -   [API visibility and subscription availability](_Key_Concepts_)
    -   [Applications](_Key_Concepts_)
    -   [Application-level throttling](_Key_Concepts_)
    -   [Access tokens](_Key_Concepts_)


The examples here use the `PhoneVerification` REST API, which is created in the section [Create and Publish an API](/Learn/Tutorials/create-and-publish-an-api).

1\.  Sign in to the WSO2 API Developer Portal ( `https://<hostname>:<port>/devportal` ) and click on an API (e.g., `PhoneVerification 1.0.0` ) to open it.

  ![](../../assets/img/Learn/developer-portal-subscriptions.png)

  In the API overview page, You will have two methods to subscribe an API to an application.You can subscribe to current API choosing an existing application or you can follow a wizard to start from the scratch.In the API Manager 3.0.0, We have introduced a __KEY GENERATION WIZARD__ to guide you through the process of creating and configure application, generate application keys and access token, and finally navigate to try out page.

!!! tip
    In a [multi-tenanted](https://docs.wso2.com/display/AM210/Configuring+Multiple+Tenants) WSO2 API Manager setup, you can access any tenant's Developer Portal using the URL `http://<hostname>:<port>/devportal?tenant=<tenant_name>` .

2\.  We will try the __KEY GENERATION WIZARD__ in this tutorial\.Click on the __KEY GENERATION WIZARD__ button to start the key generation wizard.

3\.  In the first step, Provide an application name which is mandatory and enter a description about the application(Optional).
    ![App create](../../assets/img/Learn/subscribing-application-create-wizard.png)
    Note that ,Default token type is JWT. If you want to change the token type to Oauth, Select __Oauth__ from the __Token Type__ dropdown and click __NEXT__ to continue

4\.  In the second step, You can select throttling policy for the subscription.
    ![](../../assets/img/Learn/application-subscription-key-gen-wizard-2nd-step.png)
    Click on the __Throttling Policy__ dropdown ans select a throttling policy.
    After selecting a policy, Click __NEXT__ to continue.

5\. In the third step (__Generate Keys__),You can choose grant types which needs to be allowed for this application.You may select the grant types for __PRODUCTION__ and __SANDBOX__ environments.
    ![](../../assets/img/Learn/application-subscription-key-gen-wizard-3rd-step.png)

!!! note
    By default, the __Client Credentials__ grant type is used to generate the access token. Make sure the Client Credentials grant type is selected when generating keys from the UI. For more information on how to generate supported grant types of WSO2 API Manager, see [Token API](_Token_API_).

!!! note
    If you have a supported callback URL that sends a callback to a specific server or program soon after your application request is sent, you can specify it under the **Callback URL** field.
    Click __NEXT__ after selecting the required grant types.
    Application key and secret will be generated, When you click next.

6\.  In this step, You can provide the access token validity period and set of scopes.By default, validity period is set to one hour. If you set a minus value (e.g., -1), the token never expires.
    ![](../../assets/img/Learn/application-subscription-key-gen-wizard-4th-step.png)

!!! tip
    Access Tokens with specific Scopes

    Access tokens can be generated for specific scopes. A scope acts as a limiting factor on what API resources can be accessed using a token. To generate an access token corresponding to a scope, use the drop down menu under **Scopes** and select the required scope parameter.

!!! note
    If you are using WSO2 Identity Server 5.9.0 as the Key Manager for your API Manager deployment, Clicking __NEXT__ will result in the creation of a [Service Provider](https://is.docs.wso2.com/en/5.9.0/learn/adding-and-configuring-a-service-provider/) in the Identity Server.

    Click __NEXT__ to generate an access token

7\. Now you have successfully create an application and subscribe your application to the `PhoneVerification` API. You can use this token to invoke all APIs that you subscribe to using the same application.
    ![](../../assets/img/Learn/subscribing-api-last-step.png)

8\. Next invoke the API with generated token in the previous step.

9\. Install [cURL](http://curl.haxx.se/download.html) if it is not already installed.

!!! info
    cURL comes by default in some operating systems. You can also use a REST client instead.

10\. Open the command line and execute the following cURL command:

-  [**Format**](#8cc4809c0c3348c58f05f30bf00c7800)

    ``` java
        curl -k -H "Authorization: Bearer <access_token>" -v '<api_url>'
    ```

-  [**Example**](#99180db1a6f047a5beadbfb6b25e8fa2)
        ``` java
            curl -k -H "Authorization :Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsIng1dCI6IlpqUm1ZVE13TlRKak9XVTVNbUl6TWpnek5ESTNZMkl5TW1JeVkyRXpNamRoWmpWaU1qYzBaZz09In0.eyJhdWQiOiJodHRwOlwvXC9vcmcud3NvMi5hcGltZ3RcL2dhdGV3YXkiLCJzdWIiOiJhZG1pbkBjYXJib24uc3VwZXIiLCJhcHBsaWNhdGlvbiI6eyJvd25lciI6ImFkbWluIiwidGllciI6IjEwUGVyTWluIiwibmFtZSI6InNhbXBsZSBhcHBsaWNhdGlvbiIsImlkIjo5OSwidXVpZCI6bnVsbH0sInNjb3BlIjoiYW1fYXBwbGljYXRpb25fc2NvcGUgZGVmYXVsdCIsImlzcyI6Imh0dHBzOlwvXC9rbm5lY3QubGs6NDQzXC9vYXV0aDJcL3Rva2VuIiwidGllckluZm8iOnsiR29sZCI6eyJzdG9wT25RdW90YVJlYWNoIjp0cnVlLCJzcGlrZUFycmVzdExpbWl0IjowLCJzcGlrZUFycmVzdFVuaXQiOm51bGx9fSwia2V5dHlwZSI6IlBST0RVQ1RJT04iLCJzdWJzY3JpYmVkQVBJcyI6W3sic3Vic2NyaWJlclRlbmFudERvbWFpbiI6ImNhcmJvbi5zdXBlciIsIm5hbWUiOiJQaG9uZVZlcmlmaWNhdGlvbiIsImNvbnRleHQiOiJcL3Bob25ldmVyaWZ5XC8xLjAuMCIsInB1Ymxpc2hlciI6ImFkbWluIiwidmVyc2lvbiI6IjEuMC4wIiwic3Vic2NyaXB0aW9uVGllciI6IkdvbGQifV0sImNvbnN1bWVyS2V5IjoiVnBacDdBUXFIbEJqMjhhMzBUcmZNd0ZzOGY0YSIsImV4cCI6MTU3Mjg3MTYxNiwiaWF0IjoxNTcyODY4MDE2LCJqdGkiOiIyMDNiZDMxNS0zMDY0LTQ4NTEtYTQ5Ni0yNzJmOWUzNjU3M2QifQ.DoV_IfxOarj85JbdL_s77mwQK4pa6g0TS8VHdaRGeG6s1sJS4KVeMjG9wGXQIFEpHi5Mu7cOcyUCZjzZ8-s5OQ9ecQwzPPfGUabPqYwz4GARqtxKtUsKlFwSehx_LuRIUrKx5-Qh9zb_Kwu5YFu8UKLSsEeAi_IIrUBOFU7Y7cfubj-WaQTjZSMsWQpUDPoowbK0uKHWD0CQqcWMzSCHzI8Up9OjEbTs2Es_Kb2y5GTXrNcckOTlplMuU4ecS5AybDRs5zv5vciw2Rqpxo-ZIe1C7YGjNHSILql60VJ0MNqSGlyQqo-5ZQqQSt3TBxp7C2izdk2-mKQdiX1WbwtS2w" 'https://localhost:8243/phoneverify/1.0.0/CheckPhoneNumber?PhoneNumber=18006785432&LicenseKey=0'
        ```

-  [**Output**](#9c9d5499436444b9ab906c5eff942963)
        ```xml
            <?xml version="1.0" encoding="UTF-8"?>
            <PhoneReturn xmlns="http://ws.cdyne.com/PhoneVerify/query" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
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
                <AssignDate />
                <TelecomCity />
                <TelecomCounty />
                <TelecomState>TF</TelecomState>
                <TelecomZip />
                <TimeZone />
                <Lat />
                <Long />
                <Wireless>false</Wireless>
            </PhoneReturn>
        ```


In the above example, the placeholders mentioned in the cURL command format are replaced as follows:

-   **&lt;access token&gt;** : Give the test token generated in step 8.
-   **&lt;API URL&gt;** : Click the respective API, in this case, PhoneVerification - 1.0.0. When the API's **Overview** tab appears in the API Developer Portal, copy the production URL and append the required query params to it.
    For example, <https://localhost:8243/phoneverify/1.0.0/CheckPhoneNumber?PhoneNumber=18006785432&LicenseKey=0>

The above example is made up as follows:
`<API-endpoint>/<resource>?<query-parameter-1>=<query-parameter-1-value>&<query-parameter-2>=<query-parameter-2-value>                  `

!!! info
    Troubleshooting

    If you get an error that states "Invalid Credentials", carryout the following steps to overcome the error. This error is a result of the access token expiring. The default validity period of the access token is 1 hour.

    To Re-generate the access token:

    1. Click **Credentials** in the API details page,

    <img src="../../../assets/img/Learn/subscribing-api-generate-token-from-credentials-page.png" width="400" />

    2. click on the respective application under the __View Credentials__ section, which in this case is Sample Application,

    <img src="../../../assets/img/Learn/subscribing-api-generate-token-from-credentials-page-2.png" width="400" />

    3. click **GENERATE ACCESS TOKEN** ,

    <img src="../../../assets/img/Learn/subscribing-api-generate-token-from-credentials-page-3.png" width="400" />

    4. Provide token validity period and scopes,
    You can update the token validity period in the **Access token validity period** text box so that the access token is valid for a longer period, or you can even set a minus value (e.g., -1) so that the token never expires, and click **GENERATE** to generate an access token.

    <img src="../../../assets/img/Learn/subscribing-api-generate-token-from-credentials-page-4.png" width="400" />


11\. Similarly, invoke the POST method using the following cURL command:

-   [**Format**](#5b14b8ba8f8e4280ba7e2a64fec68e24)
    ``` java
        curl -k -H "Authorization :Bearer <access token>" --data "PhoneNumber=<phone_number>&LicenseKey=<license_key>" <api_url>
    ```
-   [**Example**](#193f3dd827ff430da56f6e0a66dcda8b)
    ``` java
            curl -k -H "Authorization :Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsIng1dCI6IlpqUm1ZVE13TlRKak9XVTVNbUl6TWpnek5ESTNZMkl5TW1JeVkyRXpNamRoWmpWaU1qYzBaZz09In0.eyJhdWQiOiJodHRwOlwvXC9vcmcud3NvMi5hcGltZ3RcL2dhdGV3YXkiLCJzdWIiOiJhZG1pbkBjYXJib24uc3VwZXIiLCJhcHBsaWNhdGlvbiI6eyJvd25lciI6ImFkbWluIiwidGllciI6IjEwUGVyTWluIiwibmFtZSI6InNhbXBsZSBhcHBsaWNhdGlvbiIsImlkIjo5OSwidXVpZCI6bnVsbH0sInNjb3BlIjoiYW1fYXBwbGljYXRpb25fc2NvcGUgZGVmYXVsdCIsImlzcyI6Imh0dHBzOlwvXC9rbm5lY3QubGs6NDQzXC9vYXV0aDJcL3Rva2VuIiwidGllckluZm8iOnsiR29sZCI6eyJzdG9wT25RdW90YVJlYWNoIjp0cnVlLCJzcGlrZUFycmVzdExpbWl0IjowLCJzcGlrZUFycmVzdFVuaXQiOm51bGx9fSwia2V5dHlwZSI6IlBST0RVQ1RJT04iLCJzdWJzY3JpYmVkQVBJcyI6W3sic3Vic2NyaWJlclRlbmFudERvbWFpbiI6ImNhcmJvbi5zdXBlciIsIm5hbWUiOiJQaG9uZVZlcmlmaWNhdGlvbiIsImNvbnRleHQiOiJcL3Bob25ldmVyaWZ5XC8xLjAuMCIsInB1Ymxpc2hlciI6ImFkbWluIiwidmVyc2lvbiI6IjEuMC4wIiwic3Vic2NyaXB0aW9uVGllciI6IkdvbGQifV0sImNvbnN1bWVyS2V5IjoiVnBacDdBUXFIbEJqMjhhMzBUcmZNd0ZzOGY0YSIsImV4cCI6MTU3Mjg3MTYxNiwiaWF0IjoxNTcyODY4MDE2LCJqdGkiOiIyMDNiZDMxNS0zMDY0LTQ4NTEtYTQ5Ni0yNzJmOWUzNjU3M2QifQ.DoV_IfxOarj85JbdL_s77mwQK4pa6g0TS8VHdaRGeG6s1sJS4KVeMjG9wGXQIFEpHi5Mu7cOcyUCZjzZ8-s5OQ9ecQwzPPfGUabPqYwz4GARqtxKtUsKlFwSehx_LuRIUrKx5-Qh9zb_Kwu5YFu8UKLSsEeAi_IIrUBOFU7Y7cfubj-WaQTjZSMsWQpUDPoowbK0uKHWD0CQqcWMzSCHzI8Up9OjEbTs2Es_Kb2y5GTXrNcckOTlplMuU4ecS5AybDRs5zv5vciw2Rqpxo-ZIe1C7YGjNHSILql60VJ0MNqSGlyQqo-5ZQqQSt3TBxp7C2izdk2-mKQdiX1WbwtS2w" --data "PhoneNumber=18006785432&LicenseKey=0" https://localhost:8243/phoneverify/1.0.0/CheckPhoneNumber
    ```
-   [**Output**](#e15276bc5ec84915941b7b10ffe3bf46)

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
                <AssignDate />
                <TelecomCity />
                <TelecomCounty />
                <TelecomState>TF</TelecomState>
                <TelecomZip />
                <TimeZone />
                <Lat />
                <Long />
                <Wireless>false</Wireless>
            </PhoneReturn>
    ```

You have subscribed to an API and invoked it.

!!! tip
    **To unsubscribe from an API** , Select the API that you need to unsubscribe then go to the **Credentials** page of that API.
    Locate the application that you want to unsubscribe this API. And click on the **UNSUBSCRIBE** button.

    <img src="../../../assets/img/Learn/subscribing-api-generate-token-from-credentials-page-5.png" width="400" />

    If you unsubscribe from an API and then resubscribe with a different tier, it takes approximately 15 minutes for the tier change to be reflected. This is because the older tier remains in the cache until it is refreshed periodically by the system.
