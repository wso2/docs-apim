!!! info "New in 4.6.0 — Moesif-powered WSO2 Analytics replaces Choreo Analytics for enhanced insights and observability."

# Moesif Analytics

This guide outlines the steps required to integrate **Moesif Analytics** with **WSO2 API Manager**. The integration enables you to collect and publish API analytics data to the **Moesif dashboard**, providing insights into API usage, traffic trends, and error tracking.

<div style="text-align:center;">
  <a href="{{base_path}}/assets/img/analytics/moesif/moesif-data-flow.png">
    <img src="{{base_path}}/assets/img/analytics/moesif/moesif-data-flow.png" alt="Moesif integration diagram">
  </a>
</div>

### Analytics Data Flow

The Moesif integration captures both **successful** and **failed** API invocations in WSO2 API Manager and publishes them to your Moesif dashboard in near real-time. This allows for powerful analytics and monitoring capabilities.

This section will cover necessary steps to integrate Moesif analytics with WSO2 API Manager.

### Step 1: Set Up Your Moesif Account

#### 1.1 Create an Account and Log In

1. Go to [Moesif’s official website for WSO2 API Manager](https://www.moesif.com/wrap/basic?onboard=true)  
2. Sign up for a new account or log in to your existing account.
3. Follow the onboarding wizard to get the Moesif Key.
4. Copy the **Moesif API Key** from the **API Keys** section.

!!! note
    For more detailed instructions and advanced configuration options, refer to the official [Moesif Documentation](https://www.moesif.com/docs).

### Step 2 - Configure WSO2 API Manager

To enable Moesif analytics in WSO2 APIM, you need to update the `deployment.toml` configuration file.

#### Step 2.1 - Configuring the deployment.toml file.

To enable the WSO2 API Manager default analytics which is based on Moesif, specify the `type` as `moesif`. Open the `<APIM-HOME>/repository/conf` directory. Edit the `apim.analyics` configuration in the `deployment.toml` file with the following configuration.

```toml
[apim.analytics]
enable = true
type = "moesif"

[apim.analytics.properties]
moesifKey = "<Key>"
moesif_base_url = "https://api.moesif.com"
send_headers = false
```
Configuration Parameters:

| **Name**           | **Description**      | **Default Value** | **Possible Data Types**	| **Optional** |
|--------------------|----------------------|-------------------|-----------------------|--------------|
| enable             | Enable/Disable Analytics. | true              | Boolean               | Yes          |
| type               | Type of Analytics platform. | moesif            | String            | Yes         |
| moesifKey         | Moesif API Key.      | -                 |  String                | No           |
| moesif_base_url   | Base URL of Moesif API. | https://api.moesif.com | String            | Yes          |
| send_headers      | Whether to send request and response headers to Moesif. | false | Boolean               | Yes          |


!!! Danger "Masking Sensitive Information"
    Ensure that you **do not** expose your Moesif API Key in public repositories or logs, as it can lead to unauthorized access to your analytics data.
    
    **Massking Sensative Information**

    WSO2 Analytics data may contain PII (Personally Identifiable Information) such as user IP addresses and user name. Also when `send_headers` is set to `true`, request and response headers may contain sensitive information. To comply with data privacy regulations and protect user privacy, it is recommended to mask or anonymize such sensitive information before sending it to Moesif. You can configure the masking options in the `deployment.toml` file as shown below:
    
    ```toml
    [apim.analytics.mask]
    "userIp" = "IPV4"
    "userName" = "EMAIL"
    "userId" = "EMAIL"
    "userAgent" = "STRING"
    "applicationOwner" = "EMAIL"
    response_headers = ["Header1", "Header2"]
    request_headers = ["Header1", "Header2"]
    ```

    | **Name** | **Description** | **Accepted Values** |
    |-----------|-----------------|---------------------|
    | userIp | Defines the format used to capture and store the user's IP address in analytics records. | IPV4, IPV6 |
    | userName | Specifies the format of the username field used for analytics or identification. | EMAIL, STRING |
    | userId | Identifies how the user ID is represented in analytics data. | EMAIL, STRING |
    | userAgent | Represents the type of the user agent string recorded from the client request. | STRING |
    | applicationOwner | Specifies the format of the application owner's identifier used for analytics or identification. | EMAIL, STRING |
    | response_headers | List of response headers to be captured for analytics or logging purposes. | Header keys as strings |
    | request_headers | List of request headers to be captured for analytics or logging purposes. | Header keys as strings |

    Masking Options
    
    - **IPV4**: Masks the 3rd octet of an IPv4 address (e.g., 192.168.***.98).
    - **IPV6**: Masks the 4th, 5th, 6th and 7th segments of an IPv6 address (e.g., 2001:0db8:85a3:****:****:****:****:7334).
    - **EMAIL**: Masks the local part of an email address (e.g., *****@gmail.com).
    - **STRING**: Masks the entire string value (e.g., "JohnDoe" becomes "*****").
    

!!! note
    Following are the details that are available on analytics log events: 

    `apim_event_response` -  This event will be triggered for each successful API invocation. When a API associated backend returns an error    response still it will be logged through this event.

    | **Parameter** | **Type** | **Description** |
    |----------------|-----------|-----------------|
    | apiCreator | String | Username of the API creator. |
    | apiCreatorTenantDomain | String | Tenant domain under which the API was created. |
    | apiId | String (UUID) | Unique identifier of the API. |
    | apiMethod | String | HTTP method used in the request (e.g., GET, POST). |
    | apiName | String | Name of the API being invoked. |
    | apiResourceTemplate | String | Resource path template for the API. |
    | apiType | String | Type of the API (e.g., HTTP, SOAP, GRAPHQL). |
    | apiVersion | String | Version of the API. |
    | applicationId | String (UUID) | Unique identifier of the invoking application. |
    | applicationName | String | Name of the invoking application. |
    | applicationOwner | String | Owner of the invoking application. |
    | backendLatency | Number | Time taken by the backend service to respond (in ms). |
    | correlationId | String (UUID) | Unique identifier used to trace the request across components. |
    | destination | String | Backend endpoint URL to which the request was sent. |
    | eventType | String | Type of event (e.g., request, response). |
    | gatewayType | String | Type of API Gateway handling the request (e.g., SYNAPSE, CHOREO). |
    | keyType | String | Key type used for invoking the API (e.g., SANDBOX, PRODUCTION). |
    | userName | String | Authenticated username of the API invoker. |
    | proxyResponseCode | Number | HTTP response code returned by the gateway. |
    | regionId | String | Identifier of the gateway region where the API was invoked. |
    | requestMediationLatency | Number | Latency introduced by mediation at the request flow (in ms). |
    | requestTimestamp | String (ISO 8601) | Timestamp when the API request was initiated. |
    | responseCacheHit | Boolean | Indicates whether the response was served from cache. |
    | responseLatency | Number | Total latency for the response (in ms). |
    | responseMediationLatency | Number | Latency introduced by mediation at the response flow (in ms). |
    | targetResponseCode | Number | HTTP response code received from the backend service. |
    | userAgent | String | User agent string of the client (e.g., Chrome). |
    | userIp | String | IP address of the client invoking the API. |
    | commonName | String | Common name extracted from certificate (if applicable). |
    | responseContentType | String | Content type of the API response. |
    | subType | String | Subtype of the API event (e.g., DEFAULT). |
    | isEgress | Boolean | Indicates whether the event occurred on the egress path. |
    | apiContext | String | Context path of the API. |
    | responseSize | Number | Size of the API response payload (in bytes). |
    | requestHeaders | Object | Map of request headers sent to the backend. |
    | responseHeaders | Object | Map of response headers received from the backend. |
    | vendorName | String | Name of the AI vendor (e.g., OpenAI). |
    | vendorVersion | String | Version of the AI vendor API. |
    | model | String | Model identifier used (e.g., gpt-3.5-turbo). |
    | promptTokens | Number | Number of tokens used for the input prompt. |
    | completionTokens | Number | Number of tokens used for the AI’s generated response. |
    | totalTokens | Number | Total tokens consumed in the request. |
    | hour | String | Hour of the request, for usage tracking or analytics. |


    apim_event_faulty - This event will be triggered for each failed and throttled API invocation
    

    | **Parameter**                | **Type**  | **Description**                                                      |
    |------------------------------|-----------|----------------------------------------------------------------------|
    | "apiCreator"                 | string    | The creator of the API.                                              |
    | "apiCreatorTenantDomain"     | string    | The tenant domain of the API creator.                                |
    | "apiId"                      | string    | Unique identifier of the API.                                        |
    | "apiMethod"                  | string    | The HTTP method used by the API (e.g., GET, POST).                   |
    | "apiName"                    | string    | The name of the API.                                                 |
    | "apiResourceTemplate"        | string    | The template of the API resource accessed.                           |
    | "apiType"                    | string    | The type of the API (e.g., HTTP, REST).                              |
    | "apiVersion"                 | string    | The version of the API.                                              |
    | "applicationId"              | string    | Unique identifier of the application that makes the API call.        |
    | "applicationName"            | string    | Name of the application that makes the API call.                     |
    | "applicationOwner"           | string    | Owner of the application that makes the API call.                    |
    | "backendLatency"             | long      | The time taken by the backend to process the request.                |
    | "correlationId"              | string    | Unique identifier for tracking API calls.                            |
    | "destination"                | string    | The backend URL to which the API call was redirected.                |
    | "eventType"                  | string    | The type of event.                                                   |
    | "gatewayType"                | string    | The type of the API gateway.                                         |
    | "keyType"                    | string    | Indicates whether the API key used was for SANDBOX or PRODUCTION.    |
    | "platform"                   | string    | Operating system was used to access the API.                         |
    | "properties"                 | object    | Properties of the event.                                             |
    | "apiContext"                 | string    | The context of the API call.                                         |
    | "userName"                   | string    | The username of the individual who made the API call.                |
    | "proxyResponseCode"          | int       | The HTTP response code returned by the API gateway.                  |
    | "regionId"                   | string    | The region identifier for the API call.                              |
    | "requestMediationLatency"    | int       | Time taken for request mediation.                                    |
    | "requestTimestamp"           | long      | Timestamp when the request was made.                                 |
    | "responseCacheHit"           | bool      | Indicates if the response was served from cache.                     |
    | "responseLatency"            | long      | Total time taken to respond to the request.                          |
    | "responseMediationLatency"   | long      | Time taken for response mediation.                                   |
    | "targetResponseCode"         | int       | The HTTP response code received from the backend target.             |
    | "userAgent"                  | string    | The user agent of the client making the API call.                    |
    | "userIp"                     | string    | The IP address of the user making the API call.                      |
    | "errorCode"                  | int       | The error code generated in a fault.                                 |
    | "errorMessage"               | string    | The error message associated with the fault.                         |
    | "errorType"                  | string    | The type of error (e.g., THROTTLED).                                 |
