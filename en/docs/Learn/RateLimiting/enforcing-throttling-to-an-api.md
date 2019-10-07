# Enforcing Throttling to an API

**Throttling** allows you to limit the number of hits to an API during a given period, typically to protect your APIs from security attacks and your backend services from overuse, regulate traffic according to infrastructure limitations and to regulate usage for monetization. For information on different levels of throttling in WSO2 API Manager (WSO2 API-M), see [Throttling tiers](https://docs.wso2.com/display/AM260/Setting+Throttling+Limits) . !!! note
This tutorial uses the `PhoneVerification` API, which has one resource, GET and POST methods to access it and a throttling policy enforced.

**Before you begin** , follow the [Create and Publish an API](https://docs.wso2.com/display/AM260/Create+and+Publish+an+API) to create and publish the `PhoneVerification` API and then the [Subscribe to an API](https://docs.wso2.com/display/AM260/Subscribe+to+an+API) to subscribe to the API using the `Bronze` throttling tier.


After you created, published, and subscribed to the API, let's see how the API Gateway enforces throttling and resource access policies to the API.

1.  Sign in to the API Store and select the PhoneVerification API.
    Make sure to subscribe to the API as mentioned in the before you begin section.

    ![](/assets/attachments/97564951/97564954.png)
2.  Go to the Default Application, click the **Production Keys** tab and generate an access token.
    If you already have an access token for the application, you have to regenerate it after 1 hour.
    ![](/assets/attachments/97564951/97564958.png)
    Let's invoke this API.

3.  Click on the API, then go to its **API Console** tab.
    ![](/assets/attachments/97564951/97564957.png)
4.  Expand the GET method and click Try it out. Provide the required parameters and click **Execute** to invoke the API. For example,

    |                 |                            |
    |-----------------|----------------------------|
    | **PhoneNumber** | E.g., 18006785432          |
    | **LicenseKey**  | Give 0 for testing purpose |

    ![](/assets/attachments/97564951/97564953.png)
    Note the response that appears in the API Console. As we used a valid phone number in this example, the response returns as valid.
    ![](/assets/attachments/97564951/97564956.png)    Note that you subscribed to the API on the Bronze throttling tier. The Bronze tier allows you to make a 1000 calls to the API per minute. If you exceed your quota, you get a throttling error as shown below.
    ![](/assets/attachments/97564951/97564952.png)    Let's try to invoke the API using an unavailable resource name.

5.  Go to the API's **Overview** page in the API Store and get the API's URL.
    ![](/assets/attachments/97564951/97564955.png)
6.  Install [cURL](http://curl.haxx.se/download.html) or any other REST client.

7.  Go to the command-line invoke the API using the following cURL command.

    -   [**Format**](#Format)
    -   [**Command**](#Command)
    -   [**Response**](#Response)

    ``` java
        curl -k -H "Authorization :Bearer <access-token-in-step-3>" '<API's URL in step 5>/<API's-resource-name>?<parameter1>=<parameter1-value>&<parameter2>=<parameter2-value>'
    ```

    Note that the `PhoneVerification` API's resource name is **`CheckPhoneNumber               `** , but we use an undefined resource name as **`CheckPhoneNum               `** . Here's an example:

    ``` java
            curl -k -H "Authorization :Bearer 63cc9779d6557f4346a9a28b5cfd8b53" 'https://localhost:8243/phoneverify/1.0.0/CheckPhoneNum?PhoneNumber=18006785432&LicenseKey=0'
    ```

    Note that the call gets blocked by the API Gateway with a 'no matching resource' message. It doesn't reach your backend services as you are trying to access a REST resource that is not defined for the API.

    ``` java
            <am:fault xmlns:am="http://wso2.org/apimanager"><am:code>404</am:code><am:type>Status report</am:type><am:message>Runtime Error</am:message><am:description>No matching resource found for given API Request</am:description></am:fault>
    ```

You have seen how the API Gateway enforces throttling and resource access policies for APIs.


