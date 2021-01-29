
# Introduction

The Streaming Integrator(SI) component of WSO2 API Manager is a streaming data processing server that integrates streaming data and takes action based on streaming data. The streaming integration capabilities of WSO2 API Manager are delivered via this runtime

WSO2 SI can be effectively used for:

- **Realtime ETL**: CDC for DBs, tailing files, scraping HTTP Endpoints, etc.
- **Work with streaming messaging systems**: It is fully compatible with Kafka and NATS, and provides advanced stream processing capabilities required to utilize the full potential of streaming data.
- **Streaming data Integration**: Allows you to treat all data sources as streams and connect them with any destination.
- **Execute complex integrations based on streaming data**: SI has native support to work hand-in-hand with WSO2 Micro integrator to trigger complex integration flows based on decisions derived via stateful stream processing logic.


!!! info "Try it out!"
    To try out each of the above use cases with the Streaming Integrator, see [Streaming Integrator Tutorials]({{base_path}}/use-cases/streaming-tutorials/tutorials-overview)

## Key Features

WSO2 SI is powered by [Siddhi.io](https://siddhi.io/), a well known cloud native open source stream processing engine. Siddhi allows you to write complex stream processing logic using an intuitive SQL-like language known as [SiddhiQL](https://siddhi.io/en/v5.1/docs/). You can perform the following actions on the fly using Siddhi queries and constructs.

- [**Extracting data from static sources in real time**]({{base_path}}/use-cases/streaming-usecase/extracting-data-from-static-sources-in-real-time).
- [**Loading and writing data**]({{base_path}}/use-cases/streaming-usecase/loading-and-writing-date) to databases, files and cloud based storages.
- [**Receiving data in transit**]({{base_path}}/use-cases/streaming-usecase/receiving-data-in-transit) from message brokers and data publishers.
- [**Publishing Data**]({{base_path}}/use-cases/streaming-usecase/publishing-data) via API in an asynchronous manner and publishing to message brokers and destinations. 
- [**Stream processing**]({{base_path}}/use-cases/streaming-usecase/processing-data) activities including cleansing, transforming, enriching correlating, and summarizing data.
- [**Performing real time ETL**]({{base_path}}/use-cases/streaming-usecase/performing-etl-tasks).
 
 ![Streaming Integrator/ Workflow]({{base_path}}/assets/img/streaming/streaming-integrator.png)

With 60+ prebuilt and well tested collection of connectors, WSO2 SI allows you to connect any data source with any destination regardless of the different protocols and data formats used by the different endpoints.

The SI Store API exposes aggregated and collected data streams to in-memory and persistence storages via a REST API, allowing you to execute queries and generate summarized information on demand.

Synapse integration flows deployed in [WSO2 Micro Integration(MI)](https://github.com/wso2/micro-integrator) can be executed directly by SI. This allows you to build robust data processing and integration pipelines by combining powerful stream processing and integration capabilities.

## Tooling

WSO2 SI is coupled with the [Streaming Integrator Tooling]({{base_path}}/develop/streaming-apps/streaming-integrator-studio-overview); a comprehensive streaming integration flow designer for [**developing**]({{base_path}}/develop/streaming-apps/creating-a-siddhi-application)) Siddhi applications
 by writing queries or via the drag-and-drop functionality, [**testing**]({{base_path}}/develop/streaming-apps/testing-a-siddhi-application) them thoroughly before using them in production, and then [**deploying**]({{base_path}}/develop/streaming-apps/deploying-streaming-applications) them in the SI server or [exporting them to be deployed as a K8 or a Docker image]({{base_path}}/develop/streaming-apps/exporting-siddhi-applications).



## Centralized and Decentralized Deployment

Being container-friendly by design with a small image size, low resource footprint, a startup time less than two seconds, etc., WSO2 SI can be easily deployed in VMs, Docker or K8s.

Its native support for Kubernetes with a [K8s Operator](https://siddhi.io/en/v5.1/docs/siddhi-as-a-kubernetes-microservice/) provides a convenient way to deploy SI on a K8s cluster with a single command, thereby eliminating the need for manual configurations.

Deploying SI as a highly available [minimum HA cluster]({{base_path}}/install-and-setup/setup/si-deployment/deploying-si-as-minimum-ha-cluster.md) allows you to achieve zero data loss with just two SI nodes.

!!! tip "What's Next"
    - [Streaming Integrator Quick Start Guide]({{base_path}}/get-started/quick-start-guide/streaming-qsg)<br/>
    - [Create Your First Streaming Solution]()

