# Publishing Events to Analytics Cloud

In order to view analytics, you need to publish events to the cloud and view it in a dashboard available in the analytics cloud. 

To publish events to analytics cloud, you need to configure WSO2 API Manager to enable analytics.

1. Enable analytics. Open `<APIM_HOME>/repository/conf/deployment.toml` and enable analytics as follows.

    ```toml
    [apim.analytics]
    enable = true
    ```

2. The analytics cloud config endpoint is required to publish events to cloud. You need to configure the auth_token property with an auth token. The config endpoint and auth token configurations are as follows.

    ```toml
    [apim.analytics]
    enable = true
    config_endpoint = "https://analytics-event-auth.st.choreo.dev/auth/v1"
    auth_token = “<use token that you generate>”
    ```

3. Restart the API Manager and try to invoke APIs.
