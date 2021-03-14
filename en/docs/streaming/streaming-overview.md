# Streaming Overview

Streaming Integrator component integrates streaming data sources such as Kafka, IBM MQ and exposes the streams as Websocket, Webhooks, and SSE APIs in API Manager. The applications can connect to the streaming endpoints deployed in the streaming integrator via the API Manager to consume and publish data to the underlying streaming platforms.

## Get Started with Streaming

<table>
    <tr>
        <td>
            <a href="{{base_path}}/get-started/quick-start-guide/streaming-qsg">Quick Start with Streaming</a>
        </td>
        <td>
            <a href="{{base_path}}/streaming/getting-started/getting-started-guide-overview">Develop your First Streaming Solution</a>
        </td>
        <td>
            <a href="{{base_path}}/streaming/streaming-key-concepts">Key Concepts of Streaming</a>
        </td>
        <td>
            <a href="{{base_path}}/use-cases/streaming-tutorials/tutorials-overview">Streaming Tutorials</a>
        </td>
    </tr>
</table>

## Streaming APIs

The Streaming Integrator component consumes APIs via transports such as Websocket, Webhooks, and SSE, and exposes the requests in a streaming manner to make that data available to applications that cannot consume APIs. Similarly, it uses the same transports to publish streaming data via APIs in an asynchronous manner.

## Learn Integration

### Streaming Capabilities

The following are the main use cases of WSO2 Streaming Integrator.

<table>
    <tr>
        <td>
            <a href="{{base_path}}/use-cases/streaming-usecase/message-routing-overview">Extracting Data from Static Sources in Real Time</a>
        </td>
        <td>
            <a href="{{base_path}}/use-cases/streaming-usecase/receiving-data-in-transit">Receiving Data in Transit</a>
        </td>
        <td>
            <a href="{{base_path}}/use-cases/streaming-usecase/loading-and-writing-date">Loading and Writing Data</a>
        </td>
        <td>
            <a href="{{base_path}}/use-cases/streaming-usecase/publishing-data-to-event-stream-consumers">Publishing Data</a>
        </td>
    </tr>
    <tr>
        <td>
            <a href="{{base_path}}/use-cases/streaming-usecase/processing-data">Stream Processing</a>
        </td>
        <td>
            <a href="{{base_path}}/use-cases/streaming-usecase/handling-errors">Handling Errors</a>
        </td>
        <td>
            <a href="{{base_path}}/use-cases/streaming-usecase/performing-etl-tasks">Performing ETL Operations</a>
        </td>
    </tr>
</table>

### Management and Observability

<table>
    <tr>
        <td>
            <a href="{{base_path}}/observe/si-observe/setting-up-grafana-dashboards">Monitoring Streaming Integrator</a>
        </td>
    </tr>
</table>

### DevOps and Administration

<table>
    <tr>
        <td>
            <a href="{{base_path}}/install-and-setup/install/installing-the-product/installing-si-in-vm">Streaming Integrator Installation</a>
        </td>
        <td>
            <a href="{{base_path}}/install-and-setup/setup/si-deployment/deployment-guide">Streaming Integrator Deployment</a>
        </td>
    </tr>
</table>

### Streaming Tutorials

The streaming tutorials walk you through the main capabilities and features of WSO2 Streaming Integrator, and help you understand how to build an Streaming applications.

<table>
    <tr>
        <td>
            <ul>
                <li><a href="{{base_path}}/use-cases/streaming-tutorials/performing-real-time-etl-with-mysql">Performing Real-time Change Data Capture with MySQL</a></li>
                <li><a href="{{base_path}}/use-cases/streaming-tutorials/performing-real-time-etl-with-files">Performing Real-time ETL with Files</a></li>
                <li><a href="{{base_path}}/use-cases/streaming-tutorials/creating-etl-application-via-tooling">Creating an ETL Application via SI Tooling</a></li>
                <li><a href="{{base_path}}/use-cases/streaming-tutorials/working-with-kafka">Working with Kafka</a></li>
                <li><a href="{{base_path}}/use-cases/streaming-tutorials/creating-business-rules-templates">Working with Business Rules</a></li>
            </ul>
        </td>
        <td>
            <ul>
                <li><a href="{{base_path}}/use-cases/streaming-tutorials/integrating-stores">Integrating Stores</a></li>
                <li><a href="{{base_path}}/use-cases/streaming-tutorials/exposing-processed-data-as-api">Exposing Processed Data as API</a></li>
                <li><a href="{{base_path}}/use-cases/streaming-tutorials/handling-requests-with-errors">Error Handling with Data Streams</a></li>
                <li><a href="{{base_path}}/use-cases/streaming-tutorials/triggering-integrations-via-micro-integrator">Triggering Integration Flows</a></li>
                <li><a href="{{base_path}}/use-cases/streaming-tutorials/running-si-with-docker-and-kubernetes">Running the Streaming Integrator in Containerized Environments</a></li>
            </ul>
        </td>
    </tr>
</table>
</tr>