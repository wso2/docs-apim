# Configure the API Gateway

API Analytics is delivered via the API Analytics Cloud. Therefore, the API Manager Gateway needs to be configured to publish analytics data into the cloud.

## Basic configurations

{!includes/analytics/configure-synapse-gateway.md!}

## Advanced configurations

This section explains the additional configurations that you can carry out to fine-tune the analytics data publishing process. By default, the following configurations are set to default values that are derived through testing. However, based on other factors, there may be a need to fine-tune these parameters.
  
### Worker Thread Count

This property defines the number of threads that are publishing analytics data into the Analytics Cloud. The default value is one thread. One thread can serve up to 3200 requests per second with unrestricted internet bandwidth. In case a single thread is not enough to meet the load handled by your Gateway, you will encounter the following error message in Gateway logs. 

`Event queue is full. Starting to drop analytics events.`

If you get the above-mentioned error during an API invocation spike, then increase the 'Queue Size' as explained in next section. However, if you are getting this error repeatedly, then you should increase the worker thread count as shown below.

```toml
[apim.analytics]
enable = true
config_endpoint = "https://analytics-event-auth.choreo.dev/auth/v1"
auth_token = “<use token that you generate>”
properties.'worker.thread.count' = 2
```    

### Queue Size

This property denotes the number of analytics events that the Gateway keeps in-memory and uses to handle request bursts. The default value is set to 20000. As explained in the previous section, if you get the following error message in the Gateway logs during API invocation spikes, you should consider increasing queue size. 

`Event queue is full. Starting to drop analytics events.`

However, another factor that you should consider when increasing the queue size is the memory footprint. A single analytics publishing event is around 1 KB. Therefore, you should plan the capacity to not hinder the JVM heap. To tweak the property, add the configuration as shown below.

```toml
[apim.analytics]
enable = true
config_endpoint = "https://analytics-event-auth.choreo.dev/auth/v1"
auth_token = “<use token that you generate>”
properties.'queue.size' = 10000
```

### Client Flushing Delay

This property denotes the guaranteed frequency (in milliseconds) that the analytics events will be published to the cloud. Currently, analytics events are batched before being sent. Once a given batch is full, that batch will be published into the Analytics Cloud. However, under low throughput, it can take some time for a batch to be filled. In such cases, Client Flushing Delay will come into the picture. A separate publisher will publish the analytics events after every Client Flushing Delay if the Event Queue, which was mentioned above, is empty and also if none of the worker threads are currently publishing. By default, this is set to 10 seconds. To tweak the property, add the configuration as shown below.

```toml
[apim.analytics]
enable = true
config_endpoint = "https://analytics-event-auth.choreo.dev/auth/v1"
auth_token = “<use token that you generate>”
properties.'client.flushing.delay' = 15000
```
