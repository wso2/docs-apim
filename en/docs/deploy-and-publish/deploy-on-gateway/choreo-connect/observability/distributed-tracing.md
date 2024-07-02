# Distributed Tracing

Performance issues, errors, and exceptions are unfortunate events that may occur in a production environment. In order to identify such an event, observing the production environment is essential. Choreo Connect provides the ability to observe how the requests are handled via an OpenTelemetry based distributed tracing implementation. By connecting Choreo Connect to one of the supported distributed tracing systems, users are able to easily debug and identify production issues.

Supported distributed tracing systems,

- Jaeger
- Zipkin
- Azure Application Insights

## Configure Distributed Tracing

!!! note
    If you are trying out tracing capabilities of Choreo Connect and do not have an actual deployment of Jaeger or Zipkin, you can start Choreo Connect together with Jaeger/Zipkin by adding one of the below containers to product docker-compose file.

    ```yaml tab="Jaeger"
    jaeger:
      image: jaegertracing/all-in-one:1.27
      environment:
        - COLLECTOR_ZIPKIN_HOST_PORT=9411
      ports:
        - "5775:5775"
        - "16686:16686"
        - "14268:14268"
    ```

    ```yaml tab="Zipkin"
    zipkin:
      image: openzipkin/zipkin
      container_name: zipkin
      ports:
        - "9411:9411"
    ```

### Jaeger

When using **Jaeger** for tracing, the format is same as for **Zipkin** to publish spans from Choreo Connect. Therefore, the tracer type is configured as `zipkin`. Follow these steps to configure Choreo Connect with Jaeger.

1. Set following environment variable to `jaeger` container/pod.
    ```
    COLLECTOR_ZIPKIN_HOST_PORT=9411
    ```

1. {!includes/deploy/cc-configuration-file.md!}

1. Add the following configuration.  
    ```toml
    [tracing]
      enabled = true
      type = "zipkin"
      [tracing.configProperties]
        host = "jaeger"
        port = "9411"
        endpoint = "/api/v2/spans"
        instrumentationName = "CHOREO-CONNECT"
        maximumTracesPerSecond = "2"
        maxPathLength = "256"
    ``` 

1. Start Choreo Connect.
1. [Create and Deploy an API]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/getting-started/quick-start-guide-docker-with-apim).
1. Invoke the newly created API and open Jaeger UI to view the traces. Navigate to `http://localhost:16686` if you have updated the Docker Compose file with an instance of Jaeger as mentioned at the beginning.

You will be able to browse through the request traces and expand each trace to view complete trace details.

![Jaeger Trace]({{base_path}}/assets/img/deploy/mgw/trace-jaeger.png)

### Zipkin

Follow these steps to configure WSO2 Choreo Connect with Zipkin.

1. {!includes/deploy/cc-configuration-file.md!}

1. Add the following configuration.

    ```toml
    [tracing]
      enabled = true
      type = "zipkin"
      [tracing.configProperties]
        host = "zipkin"
        port = "9411"
        endpoint = "/api/v2/spans"
        instrumentationName = "CHOREO-CONNECT"
        maximumTracesPerSecond = "2"
        maxPathLength = "256"
    ``` 

1. Start Choreo Connect.
1. [Create and Deploy an API]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/getting-started/quick-start-guide/quick-start-guide-docker-with-apim/).
1. Invoke the newly create API and open Zipkin UI to view the traces. Navigate to `http://localhost:9411` if you have updated the Docker Compose file with an instance of Zipkin as mentioned at the beginning.
1. Filter traces by `serviceName=choreo_connect` query.

You will be able to see all traces. Detailed trace view will look like below.

![Zipkin Trace]({{base_path}}/assets/img/deploy/mgw/trace-zipkin.png)

### Azure Application Insights

Follow these steps to configure WSO2 Choreo Connect with Azure Application Insights.

1. First you need to obtain the `ConnectionString` from the Azure portal.
    * Log in to the Azure portal.
    * Copy the `Connection String` from the overview page of `Application Insights` resource. E.g., 
    ```
    InstrumentationKey=ab71943f-xxxx-xxxx-xxxx-fb2eb69ae11d;IngestionEndpoint=https://region.applicationinsights.azure.com/
    ```
1. {!includes/deploy/cc-configuration-file.md!}

1. Add the following configuration.

    ```toml tab="Configuration"
    [tracing]
      enabled = true
      type = "azure"
      [tracing.configProperties]
        connectionString = {APPLICATIONINSIGHTS_CONNECTION_STRING}
        instrumentationName = "CHOREO-CONNECT"
        maximumTracesPerSecond = "2"
    ```
    
    ```toml tab="Example"
    [tracing]
      enabled = true
      type = "azure"
      [tracing.configProperties]
        connectionString = "InstrumentationKey=ab71943f-xxxx-xxxx-xxxx-fb2eb69ae11d;IngestionEndpoint=https://xxxxxx.applicationinsights.azure.com/"
        instrumentationName = "CHOREO-CONNECT"
        maximumTracesPerSecond = "2"
    ```

1. Start Choreo Connect.
1. [Create and Deploy an API]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/getting-started/quick-start-guide/quick-start-guide-docker-with-apim/).
1. Invoke the newly created API. 
1. Now open "Azure Application Insights" Trasaction search window and select `Dependency` for `Event types` filter  
    ![Azure Trace Filter]({{base_path}}/assets/img/deploy/mgw/trace-azure-filter.png)

You will be able to see all traces. Detailed trace view will look like below.

![Azure Trace]({{base_path}}/assets/img/deploy/mgw/trace-azure.png)