# Analytics for Choreo Connect
Choreo Connect Analytics provides reports, dashboards, statistics, and graphs for the APIs deployed on Choreo Connect.
WSO2 Choreo Connect has the capability to publish events to the Choreo platform in order to generate analytics. This page describes the feature and explains how the feature could be used to generate useful analytics in order to gain important insights into the APIs deployed on the Choreo Connect.

### Overview
WSO2 Choreo Connect supports publishing Real-Time events to an alaytics server (Choreo) using `gRPC` based approach. The following topics will discuss How the event publishing works and How we could configure Analytics for Choreo Connect.

### Architecture

### Configuring Analytics for Choreo Connect

The following steps will describe how to connfigure Choreo Connect Analytics with Choreo portal.

!!! note 
    Before you begin, make sure to go through [main configurations]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/configurations/configuration-overview/) and [Configurations for Analytics]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/configurations/analytics-configurations/) and familiar with the configurations.

##### STEP-1: Set up Analytics

To configure analytics with Choreo,

1. Sign up to [https://console.choreo.dev/login/](https://console.choreo.dev/login/).
2. Go to [https://console.choreo.dev/user-settings/onpremkeys](https://console.choreo.dev/user-settings/onpremkeys) and generate a on-prem-key.
3. Open the `docker-compose.yaml` file located in the `CHOREO-CONNECT_HOME/docker-compose/choreo-connect` or `CHOREO-CONNECT_HOME/docker-compose/choreo-connect-with-apim` based on your choice on the setup.

    !!! info
        Choreo Connect can be configured to pulish Analytics to Choreo cloud in [standalone mode]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/getting-started/quick-start-guide/quick-start-guide-docker/#step-3-start-choreo-connect) and [with control plane mode]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/getting-started/quick-start-guide/quick-start-guide-docker-with-apim/#step-3-start-choreo-connect-and-api-manager).

4. Find the environment variables section under the `enforcer` and change the below variables.

    ``` yaml
    environment:
        ...
        analytics_authURL=https://analytics-event-auth.choreo.dev/auth/v1
        analytics_authToken=<your-on-prem-key>
    ```

##### STEP-2: Try it out

Let's generate some traffic to see the Analytics in Choreo cloud.

1. Deploy your API - Follow [this]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/deploy-api/deploy-api-to-choreo-connect/) according to your setup.
2. Let's Invoke the API few times - [Invoke the API]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/deploy-api/deploy-api-to-choreo-connect/#invoke-the-api)


