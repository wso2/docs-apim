# Moesif Analytics Integration Guide

This guide outlines the steps required to integrate **Moesif Analytics** with **WSO2 API Manager**. The integration enables you to collect and publish API analytics data to the **Moesif dashboard**, providing insights into API usage, traffic trends, and error tracking.

!!! Note
    Moesif Analytics integration is supported starting from WSO2 API Manager 4.2.0 Update Level 180 and onwards. Ensure that you are using a compatible update level of WSO2 API Manager 4.2.0.
    Refer to this [guide]({{base_path}}/administer/updating-wso2-api-manager/) to update your WSO2 API Manager to the required or latest update level.

<a href="{{base_path}}/assets/img/analytics/moesif/moesif-data-flow.png"><img src="{{base_path}}/assets/img/analytics/moesif/moesif-data-flow.png" alt="Moesif integration diagram"></a>

### Analytics Data Flow

The Moesif integration captures both **successful** and **failed** API invocations in WSO2 API Manager and publishes them to your Moesif dashboard in near real-time. This allows for powerful analytics and monitoring capabilities.

This section will cover necessary steps to integrate Moesif analytics with WSO2 API Manager.

### Step 1: Set Up Your Moesif Account

#### 1.1 Create an Account and Log In

1. Go to [Moesif’s official website](https://www.moesif.com/)  
2. Sign up for a new account or log in to your existing account.

#### 1.2 Create a New Application

1. Once logged in, create a **new App** from the "Get Started" page.  
2. Follow the setup steps and click **Next**.  
3. You’ll be presented with an **Application ID**. Copy this ID as it will be used in the WSO2 configuration.

!!! note
    For more detailed instructions and advanced configuration options, refer to the official [Moesif Documentation](https://www.moesif.com/docs).

### Step 2 - Configure WSO2 API Manager

To enable Moesif analytics in WSO2 APIM, you need to update the `deployment.toml` configuration file.

#### Step 2.1 - Configuring the deployment.toml file.

The Choreo based analytics will be enabled by default. Specify the `type` as `moesif` to enable Moesif analytics as shown below. Open the `<APIM-HOME>/repository/conf/deployment.toml` file and edit the `apim.analytics` configuration as shown below.

```toml
[apim.analytics]
enable = true
type = "moesif"

[apim.analytics.properties]
moesifKey = "MOESIF_APPLICATION_ID"
```

!!! important
    Replace `MOESIF_APPLICATION_ID` with the actual Application ID copied from Step 1.2.

#### Step 2.2 - Configuring a proxy (optional)

If your network requires outbound connections to pass through a proxy, configure WSO2 API Manager to publish Moesif analytics through that proxy.

1. Ensure that your API Manager installation includes the update level 226 or above to enable the Moesif proxy support. See [Updating WSO2 API Manager]({{base_path}}/administer/updating-wso2-api-manager/) for instructions on applying updates.
2. Add the following properties to the existing `[apim.analytics.properties]` section in `<APIM-HOME>/repository/conf/deployment.toml`. Keep `[apim.analytics]` enabled with `type = "moesif"`. Replace the placeholders with your Moesif Application ID and proxy details.

    ```toml
    [apim.analytics.properties]
    moesifKey = "<moesif_key>"
    moesif_proxy_enable = true
    proxy_config_host = "<proxy_host>"
    proxy_config_port = "<proxy_port>"
    proxy_config_protocol = "http"
    # Optional, if the proxy requires authentication
    proxy_config_username = "<username>"
    proxy_config_password = "<password>"
    ```

    Specify the proxy hostname or IP address without a protocol prefix. Set `proxy_config_port` to a quoted port number between `1` and `65535`. The `proxy_config_protocol` property specifies the protocol used to connect to the proxy and defaults to `http` when omitted or blank.

    If the proxy requires authentication, provide both `proxy_config_username` and `proxy_config_password`. Otherwise, omit both properties.

3. Restart WSO2 API Manager to apply the configuration.
4. Invoke an API and verify that its analytics events appear in your Moesif dashboard. You can also check the API Manager logs for the message `Moesif analytics publishing is configured to use the proxy` to confirm that the proxy configuration was applied.

!!! note
    `moesif_proxy_enable` defaults to `false`. Set it to `true` to enable proxy support for Moesif. The `proxy_config_enable` property does not enable the Moesif proxy. To return to direct connectivity, set `moesif_proxy_enable = false` and restart API Manager.

For parameter descriptions and defaults, see [API-M Analytics - Moesif configurations]({{base_path}}/reference/config-catalog/#api-m-analytics-moesif-configurations).

!!! note
    Following are the details that are available on analytics log events: 

    `apim_event_response` -  This event will be triggered for each successful API invocation. When an API associated backend returns an error response, it will be logged through this event.

    ```
    apim_event_response:
    {
        "apiCreator": "admin",
        "apiCreatorTenantDomain": "carbon.super",
        "apiId": "43d030dc-427f-4678-98e3-87b7d9882b5f",
        "apiMethod": "GET",
        "apiName": "SampleAPI",
        "apiResourceTemplate": "/*",
        "apiType": "HTTP",
        "apiVersion": "1.0.0",
        "applicationId": "2d6c54b0-7c7d-4b50-83dc-e6ae6f88962e",
        "applicationName": "DefaultApplication",
        "applicationOwner": "admin",
        "backendLatency": 13,
        "correlationId": "79ed20c3-55b1-434a-adf6-eea25e2d09c3",
        "destination": "http://xxx.xxx.xxx.xx:8281/services/sampleAPIBackend",
        "eventType": "response",
        "gatewayType": "SYNAPSE",
        "keyType": "SANDBOX",
        "userName":"admin@carbon.super"
        "proxyResponseCode": 202,
        "regionId": "default",
        "requestMediationLatency": 54,
        "requestTimestamp": "2022-01-20T03:34:36.451Z",
        "responseCacheHit": false,
        "responseLatency": 73,
        "responseMediationLatency": 6,
        "targetResponseCode": 202,
        "userAgent": "Chrome",
        "userIp": "xxx.xx.xx.xx",
        "properties": {
            "commonName": "N/A",
            "responseContentType": "application/json; charset=UTF-8",
            "subType": "DEFAULT",
            "isEgress": false,
            "apiContext": "/api1/2.0.0",
            "responseSize": 133,
            "userName": "admin@carbon.super"
        }
    }
    ```

    apim_event_faulty - This event will be triggered for each failed and throttled API invocation
    
    ```
    apim_event_faulty:
    {
        "apiCreator": "admin",
        "apiCreatorTenantDomain": "carbon.super",
        "apiId": "43d030dc-427f-4678-98e3-87b7d9882b5f",
        "apiName": "SampleAPI",
        "apiType": "HTTP",
        "apiVersion": "1.0.0",
        "apiMethod": "GET",
        "apiResourceTemplate": "/publish"
        "applicationId": "0b5ccc91-30e2-4ee5-9355-d1698075c028",
        "applicationName": "SampleApp3",
        "applicationOwner": "admin",
        "correlationId": "ccf2196f-9db8-429b-aaae-98f4c6edf6d7",
        "errorCode": 900803,
        "errorMessage": "APPLICATION_LEVEL_LIMIT_EXCEEDED",
        "errorType": "THROTTLED",
        "eventType": "fault",
        "gatewayType": "SYNAPSE",
        "keyType": "PRODUCTION",
        "proxyResponseCode": 429,
        "regionId": "default",
        "requestTimestamp": "2022-02-01T04:18:48.023Z",
        "responseCacheHit": false,
        "targetResponseCode": -1,
         "properties": {
            "commonName": "N/A",
            "responseContentType": "application/json; charset=UTF-8",
            "subType": "DEFAULT",
            "isEgress": false,
            "apiContext": "/api1/2.0.0",
            "responseSize": 133,
            "userName": "admin@carbon.super"
        }
    }
    ```
    

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

### Dashboards

Users can create a variety of dashboards in Moesif using the analytics data published from the WSO2 API Gateway. The sample dashboard below illustrates API usage segmented by different users.

<a href="{{base_path}}/assets/img/analytics/moesif/sample-dashboard-img.png"><img src="{{base_path}}/assets/img/analytics/moesif/sample-dashboard-img.png" alt="Sample Moesif dashboard diagram"></a>