# Publishing Consumed Events to Prometheus Metrics and Exposing then via HTTP

## Purpose:
This application demonstrates how to use siddhi-io-prometheus for publishing events through http server.

## Prerequisites:
1. The following steps must be executed to enable WSO2 SP to publish events to Prometheus
    1. Download Prometheus server 'prometheus-2.5.0' from here : https://prometheus.io/download/#prometheus
	   And extract the file in a preferred location.
	2. Open the prometheus.yml file from {prometheus} directory and add the following text under "scrape_configs:"
		" - job_name: 'server'
		    honor_labels: true
		    static_configs:
		    - targets: ['localhost:9080']"
        * you can replace values for 'localhost:9080' in targets according to your preferred host and port.
	      In that case, the 'server.url' option must be included in the Sink definition with the same host and port values.

    3. Download and copy the prometheus client jars to the {WSO2SIHome}/lib directory as follows.
        1. Download the following jars from https://mvnrepository.com/artifact/io.prometheus and copy them to {WSO2SIHome}/lib directory.
            * simpleclient_pushgateway-0.5.0.jar
            * simpleclient_common-0.5.0.jar
            * simpleclient-0.5.0.jar
		    * simpleclient_httpserver-0.5.0.jar
	4. Navigate to {prometheus} and start prometheus server using ' ./prometheus --config.file="prometheus.yml" ' command
2. Start the editor WSO2 SP by giving this command in the terminal : sh editor.sh
3. Save this sample

## Executing the Sample:
1. Start the Siddhi application by clicking on 'Run'
2. If the Siddhi application starts successfully, the following messages would be shown on the console,
    * PublishPrometheusMetricHTTPServer.siddhi - Started Successfully!
	* SweetProductionStream has successfully connected at http://localhost:9080

## Testing the Sample:
* Send events through the event simulator:
    1. Open the event simulator by clicking on the second icon or pressing Ctrl+Shift+I.
	2. In the Single Simulation tab of the panel, specify the values as follows:
        * Siddhi App Name  : PublishPrometheusMetricHTTPServer
        * Stream Name     : SweetProductionStream
    3. In the name and amount fields, enter 'toffees' and '55.4' respectively and then click Send to send the event.
    4. Send some more events as follows,
		    ['gingerbread', 72.3],
	 	    ['toffees', 32.4],
		    ['lollipop', 23.8].

## Viewing the Results:
1. See the output events through one or more of the following methods:
	* Open the url "http://localhost:9080/metrics" in your browser. The folllowing output will be displayed,
	    - "# HELP SweetProductionStream help for counter SweetProductionStream"
        - "# TYPE SweetProductionStream counter"
        - "SweetProductionStream{Name="gingerbread",} 72.3"
        - "SweetProductionStream{Name="lollipop",} 23.8"
        - "SweetProductionStream{Name="toffees",} 87.8""

2. Send http request to the endpoint "http://localhost:9090" to the running prometheus server using the curl command:
    1. Open a new terminal and issue the following command:
        * curl -X GET http://localhost:9090/
    2. If there is no error, the result will be shown on the terminal in JSON Format similar to the following :
```
{"status":"success",
"data":{
"resultType":"vector",
"result":[
{   "metric":{"Name":"gingerbread",
"__name__":"SweetProductionStream",
"instance":"localhost:9080",
"job":"server"},
"value":[1*********.***,"72.3"]
},
{   "metric":{"Name":"lollipop",
"__name__":"SweetProductionStream",
"instance":"localhost:9080",
"job":"server"},
"value":[1*********.***,"23.8"]
},
{   "metric":{"Name":"toffees",
"__name__":"SweetProductionStream",
"instance":"localhost:9080",
"job":"server"},
"value":[1*********.***,"87.8"]
}
]}
}
```

```sql
@App:name("PublishPrometheusMetrics")

@App:description('Publish consumed events to Prometheus metrics and expose them via http server.')


define stream FooStream(Name string, amount double);

@sink(type='log', priority='WARN', prefix ='received sweet products')
define stream LogStream(Name string, amount double);

@sink(type='prometheus' , job='SweetProduction', publish.mode='server', metric.type='counter', value.attribute = "amount", @map(type='keyvalue'))
define stream SweetProductionStream(Name string, amount double);

@info(name='Add-events')
from FooStream
select *
insert into SweetProductionStream;

@info(name='Log-events')
from FooStream
select *
insert into LogStream;
```