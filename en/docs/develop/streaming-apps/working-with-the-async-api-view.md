# Generating and Viewing AsyncAPI Definitions

This section covers how to generate, edit and view AsyncAPI definitions in the **Async API** view of Streaming Integrator Tooling.

## Accessing the Async API View

The Async API View is accessible only for Siddhi applications that have one or more sources/sinks of the `websocket-server`, `webhooks` or `sse` type.

To access the Async API View, open a Siddhi application that meets the criterion mentioned above and click **Async API View**.

[![Open Async API View]({{base_path}}/assets/img/streaming/working-with-async-api/open-async-api-view-button.png)]({{base_path}}/assets/img/streaming/working-with-async-api/open-async-api-view-button.png)

## Generating a new API definition

!!! note
    When you open the Async API view for a Siddhi application for which the  AsyncAPI is not yet generated, the **Generating Async API for Sinks and Sources** dialog box opens as shown below.

1. Click **Async API View**.

     The AsyncAPI Generation form appears.

     [![Async API View button]({{base_path}}/assets/img/streaming/working-with-async-api/open-async-api-view-button.png)]({{base_path}}/assets/img/streaming/working-with-async-api/open-async-api-view-button.png)

2. Enter the Streaming API related details.
    
    !!! note
        The AsyncAPI generation form appears because you did not provide any Streaming API related content for the `@App:asyncAPI` annotation when defining the Siddhi application.

     Let's add the following Streaming API information to create a WebSocket API based AsyncAPI definition.


    The fields in it are as follows:

    | **Field**             | **Description**                                                                         | **Sample Value**     |
    |-----------------------|-----------------------------------------------------------------------------------------|----------------------|
    | **Title**             | Specify a title for the API.                                                            | `SweetProductionApp` |
    | **Version**           | Specify a version for the API.                                                          | `1.0.0`              |
    | **Description**       | Enter a description for the API.                                                        | `Consumes events of sweet production` |
    | **Select Source or Sink type to Generate Async API**| Select the source or the sink from which you want to generate the API. | `websocket-server` |
    | **Sources**           | Select the stream from which the API should consume events as requests. | `SweetProductionStream` |

     [![Design View of Async API]({{base_path}}/assets/img/streaming/working-with-async-api/async-api-form.png)]({{base_path}}/assets/img/streaming/working-with-async-api/async-api-form.png)

3. Click **Generate Async API** to generate the AsyncAPI definition.

     ![Generate Async API button]({{base_path}}/assets/img/streaming/working-with-async-api/generate-async-api-view-button.png)

     After the Async API is generated, the AsyncAPI specifications will be visible in the **Async API View** as follows. The left panel shows the API definition in the code format, and the right panel shows it as a form.

     [![Generated Asyc API Definition]({{base_path}}/assets/img/streaming/working-with-async-api/async-api-spec-view.png)]({{base_path}}/assets/img/streaming/working-with-async-api/async-api-spec-view.png)

4. Add the generated AsynAPI definition to the Streaming backend.

     Click **Add Async API** to add the generated AsyncAPI definition to the Siddhi application.

     <a href="{{base_path}}/assets/img/streaming/working-with-async-api/add-async-api-button.png"><img src="{{base_path}}/assets/img/streaming/working-with-async-api/add-async-api-button.png" width="20%" alt="Add Async API"></a>

5. Click **Code View** to view the Siddhi application with the AsyncAPI definition that was generated and to edit it if required.

After you complete editing the AsyncAPI definition, you can export it to the Service Catalog of the API Manager to expose it as an API. For more details, see [Exposing a Stream as a Managed API]({{base_path}}/use-cases/streaming-usecase/exposing-stream-as-managed-api-in-service-catalog).

