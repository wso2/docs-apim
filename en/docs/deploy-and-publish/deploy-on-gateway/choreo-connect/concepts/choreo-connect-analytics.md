# Analytics for Choreo Connect
Choreo Connect Analytics provides reports, dashboards, statistics, and graphs for the APIs deployed on Choreo Connect.
WSO2 Choreo Connect has the capability to publish events to the Choreo Analytics Cloud in order to generate analytics. This page describes the concepts behind publishing analytics events from Choreo Connect.

### Overview
Choreo Connect supports publishing Analytics as Real-Time events to Choreo Analytics Cloud. 

### Architecture

Following diagram shows the process flow of a success request in Choreo Connect with Analytics enabled.

[![Choreo Connect Analytics Architecture]({{base_path}}/assets/img/deploy/mgw/choreo-connect-analytics-architecture.png)]({{base_path}}/assets/img/deploy/mgw/choreo-connect-analytics-architecture)

There are two main components related to internal gRPC request for sending `StreamAccessLogsMessage` from `router` to `enforcer`. The latter mentioned two components, which are used to collect analytics data, are explained in the following sections.

1. gRPC Access Logger
2. gRPC Event Listener

#### gRPC Access Logger

gRPC Access Logger in the router will be activated only if we enable analytics and which is triggered after the backend response came back to the `router` (after step 5 in above diagram). 
This will send `StreamAccessLogsMessage` to the `enforcer` with `dynamic_metadata` for collecting Analytics data at the `enforcer`.

#### gRPC Event Listener

gRPC Event Listener in the `enforcer` will be activated only if we enable analytics and it is listening for gRPC Access Logger.
This will process the `StreamAccessLogsMessage` and publish analytics using the `ChoreoAnalyticsPublisher` client.

!!! note
    In case of a request failure (i.e. authentication failure at `enforcer`) it will publish the events after the failure at `enforcer` (after step 2) and the `StreamAccessLogsMessage` will be ignored in such a case.
