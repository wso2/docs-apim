# Generating and Viewing Asynchronous API Definitions

This section covers how to generate, edit and view asynchronous API definitions in the **Async API** view of Streaming Integrator Tooling.

## Accessing the Async API View

The Async API View is accessible only for Siddhi applications that have one or more sources/sinks of the `websocket-server`, `webhooks` or `sse` type.

To access the Async API View, open a Siddhi application that meets criterion mentioned above and click **Async API View**.

![Open Async API View](({{base_path}}/assets/img/streaming/working-with-async-api/open-async-api-view-button.png)

## Generating a new API definition

When you open the Async API view for a Siddhi application for which the asynchronous API is not yet generated, the **Generating Async API for Sinks and Sources** dialog box opens as shown below.

![Generating Async API for Sinks and Sources]({{base_path}}/assets/img/streaming/working-with-async-api/async-api-form.png)

The fields in it are as follows:

| **Field**             | **Description**                                                                         | **Sample Value**     |
|-----------------------|-----------------------------------------------------------------------------------------|----------------------|
| **Title**             | Specify a title for the API.                                                            | `SweetProductionApp` |
| **Version**           | Specify a version for the API.                                                          | `1.0.0`              |
| **Description**       | Enter a description for the API.                                                        | `Consumes events of sweet production` |
| **Select Source or Sink type to Generate Async API**| Select the source or the sink from which you want to generate the API. | `websocket-server` |
| **Sources**           | Select the stream from which the API should consume events as requests. | `SweetProductionStream` |

Once you enter values for the fields, click **Generate Async API**.

Then the API generated is displayed as shown in the sample below:

![Generated Asyc API Definition]({{base_path}}/assets/img/streaming/working-with-async-api/generated-async-api.png)

The left panel shows the API definition in the code format, and the right panel shows it as a form.

Once you complete editing the asynchronous API definition, you can export it to the Service Catalog of the API Manager to expose it as an API. For more details, see [Creating and Publishing Asynchronous APIs]({{base_path}}/use-cases/streaming-usecase/exposing-stream-as-managed-api-in-service-catalogue).

