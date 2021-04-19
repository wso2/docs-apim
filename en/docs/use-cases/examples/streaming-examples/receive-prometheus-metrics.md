# Receiving Prometheus Metrics

## Purpose:
This application demonstrates how to use prometheus-source to retrieve Prometheus metrics that are exported at an HTTP endpoint.

Pre-requisites:
1. The following steps must be executed to enable WSO2 SP to publish and retrieve events via Prometheus.
    1. Download and copy the prometheus client jars to the {WSO2SIHome}/lib directory as follows.
        1. Download the following jars from https://mvnrepository.com/artifact/io.prometheus and copy them to {WSO2SIHome}/lib directory.
            * simpleclient_common-0.5.0.jar
            * simpleclient-0.5.0.jar
		    * simpleclient_httpserver-0.5.0.jar
		    * simpleclient_pushgateway-0.5.0.jar
2. Start the editor WSO2 SP by giving this command in the terminal : sh editor.sh
3. Save this sample
"Siddhi App EnergyAlertApp successfully deployed" message would be shown in the console
4. Navigate to {WSO2SIHome}/samples/sample-clients/prometheus-client and run "ant" command as follows:
ant

## Executing the Sample:
1. Start the Siddhi application by clicking on 'Run'.
2. If the Siddhi application starts successfully, the following message is shown on the console
    * ReceivePrometheusMetrics.siddhi - Started Successfully!
    * PowerConsumptionStream has successfully connected at http://localhost:9080

## Note:
If you want to edit this application while it's running, stop the application, make your edits and save the application, and then start it again.

## Viewing the Results:
Messages similar to the following would be shown on the console.
```
- INFO {io.siddhi.core.stream.output.sink.LogSink} - HIGH POWER CONSUMPTION : Event{timestamp=1*********, data=[server001, F3Room2, **, **], isExpired=false}
- INFO {io.siddhi.core.stream.output.sink.LogSink} - HIGH POWER CONSUMPTION : Event{timestamp=1*********, data=[server002, F2Room2, **, **], isExpired=false}
```


```sql
@App:name("EnergyAlertApp")
@App:description("Use siddhi-io-prometheus retrieve and analyse Prometheus metrics in Siddhi")


@source(type='prometheus' , target.url='http://localhost:9080/metrics',metric.type='counter', metric.name='total_device_power_consumption_WATTS', scrape.interval='5',
@map(type='keyvalue'))
define stream devicePowerStream(deviceID string, roomID string, value int);

@sink(type='log', priority='WARN', prefix ='High power consumption')
define stream AlertStream (deviceID string, roomID string, initialPower int, finalPower int);

@sink(type='log', priority='WARN', prefix ='Logging purpose')
define stream LogStream (deviceID string, roomID string, power int);

@info(name='power increase pattern')
from every( e1=devicePowerStream ) -> e2=devicePowerStream[ e1.deviceID == deviceID and (e1.value + 5) <= value]
    within 1 min
select e1.deviceID, e1.roomID, e1.value as initialPower, e2.value as finalPower
insert into AlertStream;
```