# Subscribe to an API

You **subscribe** to a published API before using it in your applications. Subscription enables you to receive access tokens and be authenticated to invoke the API.

!!! note
See the following topics for a description of the concepts that you need to know when subscribing to an API:

-   [API visibility and subscription availability](_Key_Concepts_)
-   [Applications](_Key_Concepts_)
-   [Application-level throttling](_Key_Concepts_)
-   [Access tokens](_Key_Concepts_)


The examples here use the `PhoneVerification` REST API, which is created in the section [Create and Publish an API](_Create_and_Publish_an_API_) .

1.  Sign in to the WSO2 API Store ( `https://<hostname>:9443/store` ) and click on an API (e.g., `PhoneVerification 1.0.0` ) to open it.

        !!! tip
    In a [multi-tenanted](https://docs.wso2.com/display/AM210/Configuring+Multiple+Tenants) WSO2 API Manager setup, you can access any tenant's store using the URL `http://<hostname>:<port>/store?tenant=<tenant_name>` .


2.  Note the subscription options for the REST API.
    ![](attachments/103327837/103327823.png)

3.  Click the **Applications** menu and click **Add Application** to create a new application.
    ![](attachments/103327837/103327822.png)

4.  Enter the name as TestApp and select the per token quota as 50PerMin for the application and click **Add** .
    ![](attachments/103327837/103327821.png)
5.  Click **APIs** and click the PhoneVerification API to view the API's subscription options.
6.  Select the application that you just created, a tier, and click **Subscribe** .
    ![](attachments/103327837/103327820.png)
7.  Click the **View Subscriptions** button when prompted.
    The **Subscriptions** tab opens.

8.  Click the **Production Keys** tab.

        !!! note
    If you have a supported callback URL that sends a callback to a specific server or program soon after your application request is sent, you can specify it under the **Callback URL** field in the **Production Keys** tab.


    ![](attachments/103327837/103327819.png)

9.  Click **Generate Keys** to create an application access token. You can use this token to invoke all APIs that you subscribe to using the same application.

        !!! tip
    You can set a token validity period in the **Access token validity period** text box. By default, it is set to one hour. If you set a minus value (e.g., -1), the token never expires.

        !!! info
    By default, the Client Credentials grant type is used to generate the access token. Make sure the Client Credentials grant type is selected when generating keys from the UI. For more information on how to generate supported grant types of WSO2 API Manager, see [Token API](_Token_API_) .

        !!! tip
    Access Tokens with specific Scopes

    Access tokens can be generated for specific scopes. A scope acts as a limiting factor on what API resources can be accessed using a token. To generate an access token corresponding to a scope, use the drop down menu under **Scopes** and select the required scope parameter.

        !!! note
    If you are using WSO2 Identity Server 5.6.0 as the Key Manager for your API Manager deployment, generating keys will result in the creation of a [Service Provider](https://docs.wso2.com/display/IS560/Configuring+a+Service+Provider) in the Identity Server.


10. Install [cURL](http://curl.haxx.se/download.html) if it is not already installed.

        !!! info
    cURL comes by default in some operating systems. You can also use a REST client instead.


    1.  Open the command line and execute the following cURL command:

        -   [**Format**](#8cc4809c0c3348c58f05f30bf00c7800)
        -   [**Example**](#99180db1a6f047a5beadbfb6b25e8fa2)
        -   [**Output**](#9c9d5499436444b9ab906c5eff942963)

        ``` java
                curl -k -H "Authorization: Bearer <access_token>" -v '<api_url>'
        ```

        ``` java
                    curl -k -H "Authorization :Bearer 3dfafa3a-b1e3-3550-8a25-88e4b4fe2fb3" 'https://localhost:8243/phoneverify/1.0.0/CheckPhoneNumber?PhoneNumber=18006785432&LicenseKey=0'
        ```

        In the above example, the placeholders mentioned in the cURL command format are replaced as follows:

        -   **&lt;access token&gt;** : Give the test token generated in step 8. Click **Applications** , click on the respective application, which in this case is TestApp, click **Production Key** , and click **copy button** to copy the access token.

                        !!! warning
            Make sure you have updated the flash plugin in your web browser in order to get the **copy button** working.


            ![](attachments/103327837/103327825.png)

        -   **&lt;API URL&gt;** : Click the respective API, in this case, PhoneVerification - 1.0.0. When the API's **Overview** tab appears in the API Store, copy the production URL and append the required query params to it.
            For example, <https://localhost:8243/phoneverify/1.0.0/CheckPhoneNumber?PhoneNumber=18006785432&LicenseKey=0>
            The above example is made up as follows:
`<API-endpoint>/<resource>?<query-parameter-1>=<query-parameter-1-value>&<query-parameter-2>=<query-parameter-2-value>                  `

            ![](attachments/103327837/103327824.png)

        Note the result `<Valid>true</Valid>` that appears in the command line.

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

                !!! info
        Troubleshooting

        If you get an error that states "Invalid Credentials", carryout the following steps to overcome the error. This error is a result of the access token expiring. The default validity period of the access token is 1 hour.

        1.  You can update the token validity period in the **Access token validity period** text box so that the access token is valid for a longer period, or you can even set a minus value (e.g., -1) so that the token never expires.

        2.  Re-generate the access token.
            Click **Applications** , click the respective application (i.e., TestApp), click **Production Keys** , and click **Re-generate** . Thereafter, use the new access token when running the cURL commands.


11. Similarly, invoke the POST method using the following cURL command:

    -   [**Format**](#5b14b8ba8f8e4280ba7e2a64fec68e24)
    -   [**Example**](#193f3dd827ff430da56f6e0a66dcda8b)
    -   [**Output**](#e15276bc5ec84915941b7b10ffe3bf46)

    ``` java
        curl -k -H "Authorization :Bearer <access token>" --data "PhoneNumber=<phone_number>&LicenseKey=<license_key>" <api_url>
    ```

    ``` java
            curl -k -H "Authorization :Bearer 3dfafa3a-b1e3-3550-8a25-88e4b4fe2fb3" --data "PhoneNumber=18006785432&LicenseKey=0" https://localhost:8243/phoneverify/1.0.0/CheckPhoneNumber
    ```

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
**To unsubscribe from an API** , click the **Applications** menu and click **View** next to the application used for the subscription. Go to the **Subscriptions** tab, locate the API, and click the **Unsubscribe** link associated with it.
![](attachments/103327837/103327818.png)

If you unsubscribe from an API and then resubscribe with a different tier, it takes approximately 15 minutes for the tier change to be reflected. This is because the older tier remains in the cache until it is refreshed periodically by the system.


