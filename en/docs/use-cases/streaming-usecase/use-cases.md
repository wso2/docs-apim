# Use Cases

WSO2 Streaming Integrator receives input data, processes it and presents an output as shown in the diagram below.

![Streaming Integrator Use cases](../images/use-cases-overview/use-cases-overview.png)

As shown in the diagram above, WSO2 Streaming Integrator first extracts/receives input data, processes them and then presents the output by publishing/loading/writing it. You can perform supporting activities such as error handling, performing queries via API and analyzing metrics.

### Extracting/receiving data

WSO2 Streaming Integrator can extract static data from sources such as databases, files, and cloud storages, as well as receive data in transit from data publishers and messaging systems.

For more information, see the following guides:

- [Extracting Data from Static Sources in Real Time](../guides/extracting-data-from-static-sources-in-real-time.md)
- [Receiving Data in Transit](../guides/receiving-data-in-transit.md)

### Processing data

The different types of processing activities that can be performed by WSO2 Streaming Integrator are as follows:

 - Cleansing data
 
 - Transforming data
 
 - Enriching data
 
 - Aggregating data
 
 - Correlating data
 
For more information about the above processing activities, see [Processing Data](../guides/processing-data.md)


### Publishing/loading/writing data

Once the received data is processed, the output can be stored in a database, written in a file and/or saved in a cloud storage to be saved in a static manner. Alternatively, it can be published to a destination via a messaging system or a data publisher.

For more information about how the output is published, see the following topics:

- [Loading and Writing Data](loading-and-writing-date.md)
- [Publishing Data](publishing-data-to-event-stream-consumers.md)


### Supporting tasks

The following guides cover the supporting tasks that can be performed by WSO2 Streaming Integrator when processing Streaming Data.

- [Error Handling](handling-errors.md)

- [Metrics (Monitoring )](../admin/monitoring-si-performance-via-grafana.md)

- [Query API](../ref/store-APIs.md)
 