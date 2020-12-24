# Message Tracing

Message Tracing refers to the process of identifying each message flow of each of the transactions that go through the 
Gateway. You can do message tracing on WSO2 API Manager by installing the Message Tracer feature that has been 
specifically developed for WSO2 products. You can use the Message Tracer to derive  logging, auditing, and debugging 
related information with regard to message content and it’s direction. The Message Tracer is a part of carbon-analytics 
and it is built into WSO2 API Manager.

!!! warning
    It is not recommended to enable tracing in production environments as it generates a large number of events that reduces the performance of the analytics profile. Therefore, tracing should only be enabled in development environments.

## Configuring message tracing

Follow the steps below to configure the Message Tracer in API Manager to dump trace events to WSO2 APIM logs, which 
can be viewed via the terminal or the `wso2carbon` log file.

1.  Start the WSO2 API Manager server.
2.  Sign in to the WSO2 APIM Management Console (<https://localhost:9443/carbon>).
3.  Click **Message Tracing**, which is under the **Configure** tab, to navigate to the Message Tracing Configurations.
4.  Select the following options to enable message tracing and click **Update**.

    | Configuration                     | Description                                                                          |
    |-----------------------------------|--------------------------------------------------------------------------------------|
    | Dump Message Content              | Enable Message tracing for the Content of the Message as well.                       |
    | Enable Logging                    | Enable Logging in the available logging handler in order to log the tracing message. |

    [![Message tracing]({{base_path}}/assets/img/learn/message-traceronly.png)]({{base_path}}/assets/img/learn/message-traceronly.png)
    
5.  Add an event publisher to log the trace messages in the APIM the `wso2carbon` log file.

    1.  Go to **Main &gt; Event &gt; Publishers** and click **Add Event Publisher**.
        [![Add event publisher option]({{base_path}}/assets/img/learn/add-event-publisher.png)]({{base_path}}/assets/img/learn/add-event-publisher.png)
    2.  In Create a New Event Publisher page, add the following details and click **Add Event Publisher**.

        <table>
            <thead>
                <tr class="header">
                    <th>Property</th>
                    <th>Value</th>
                </tr>
            </thead>
            <tbody>
                <tr class="odd">
                    <td>Event Publisher Name</td>
                    <td>message_tracer_logger_publisher</td>
                </tr>
                <tr class="even">
                    <td>Event Source</td>
                    <td>DAS_MESSAGE_TRACE:1.0.0</td>
                </tr>
                <tr class="odd">
                    <td>Stream Attributes</td>
                    <td>
                        <div class="admonition note">
                            <p class="admonition-title">Keep default values</p>
                        </div>
                    </td>
                </tr>
                <tr class="even">
                    <td>Output Event Adapter Type</td>
                    <td>logger</td>
                </tr>
                <tr class="odd">
                    <td>Message Format</td>
                    <td>text</td>
                </tr>
            </tbody>
        </table>

        Leave the **Unique Identifier** field blank.
        
        [![Add a Event Publisher]({{base_path}}/assets/img/learn/message_tracer_logger_publisher.png)]({{base_path}}/assets/img/learn/message_tracer_logger_publisher.png)

After enabling message tracing, dump message content, and logging, you will see a log message similar to the following 
on the API Console/terminal for events such as API invocation etc.

``` java
[2018-07-17 17:42:41,140]  INFO - LoggerEventAdapter Unique ID: sample,
Event: meta_request_url:/sam/1.0/sd,
meta_host:172.18.0.1:9763,
meta_server:WSO2 API Manager,
correlation_activity_id:2835113514075786856680,
service_name:__SynapseService,
operation_name:mediate,
message_direction:IN,
soap_body:<soapenv:Body xmlns:soapenv="http://www.w3.org/2003/05/soap-envelope"/>,
soap_header:<soapenv:Header xmlns:soapenv="http://www.w3.org/2003/05/soap-envelope"/>,
timestamp:1531829561138,
status:success,
username:,
transport-header-Host:172.18.0.1:8243,
transport-header-activityID:2835113514075786856680,
transport-header-User-Agent:curl/7.47.0,
transport-header-Accept:application/json,
transport-header-Authorization:Bearer ac48a3a7-9dd3-3461-a785-cbdf8c3a414c
[2018-07-17 17:42:41,140]  INFO - HandlerUtils Massage Info: Transaction id=2835113514075786856680  Message direction=IN  Server name=172.18.0.1:9763  Timestamp=1531829561138  Service name=__SynapseService  Operation Name=mediate
[2018-07-17 17:42:42,245]  INFO - LoggerEventAdapter Unique ID: sample,
Event: meta_request_url:,
meta_host:172.18.0.1:9763,
meta_server:WSO2 API Manager,
correlation_activity_id:2835113514075786856680,
service_name:__SynapseService,
operation_name:mediate,
message_direction:OUT,
soap_body:<soapenv:Body xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"><jsonObject><hello>world</hello></jsonObject></soapenv:Body>,
soap_header:<soapenv:Header xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"/>,
timestamp:1531829562245,
status:success,
username:,
transport-header-Via:1.1 vegur,
transport-header-activityID:2835113514075786856680,
transport-header-Content-Type:application/json,
transport-header-Date:Tue, 17 Jul 2018 12:12:41 GMT,
transport-header-Connection:keep-alive,
transport-header-Access-Control-Allow-Methods:GET,
transport-header-Access-Control-Allow-Origin:*,
transport-header-Access-Control-Allow-Headers:authorization,Access-Control-Allow-Origin,Content-Type,SOAPAction,
transport-header-Server:Cowboy,
transport-header-Content-Length:17
[2018-07-17 17:42:42,248]  INFO - HandlerUtils Massage Info: Transaction id=2835113514075786856680  Message direction=OUT  Server name=172.18.0.1:9763  Timestamp=1531829562245  Service name=__SynapseService  Operation Name=mediate
```
