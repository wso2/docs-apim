# Configure API Gateway
As explained in the [overview section]({{base_path}}/observe/api-manager-analytics/overview-of-api-analytics/), API Manager Analytics is delivered via API Manager Analytics cloud. Hence, API
 Manager Gateway needs to be configured to publish analytics data into the cloud.
 
 This documentation is structured into two sections where the 'Basic Configuration' section explains the bare minimal settings
  needed to enable analytics, while 'Advanced Configuration' section explains additional advanced configurations that
   are needed to fine-tune the analytics data publishing.
   
## Basic configuration

To publish analytics data to analytics cloud, you need to follow below steps.

1. Open `<APIM_HOME>/repository/conf/deployment.toml` and uncomment the following config segment.

    ```toml
    [apim.analytics]
    enable = true
    config_endpoint = "https://analytics-event-auth.choreo.dev/auth/v1"
    auth_token = “<use token that you generate>”
    ```

2. Fill the auth token field with the on-premise token that you obtained via the Analytics Portal. If you have not obtained the key,
 please follow 
 [this]({{base_path}}/observe/api-manager-analytics/configure-analytics/register-for-analytics) 
 documentation on how to obtain a token.

3. Restart the API Manager, invoke APIs, and log into the Analytics Portal to view dashboards. Refer 
[this]({{base_path}}/observe/api-manager-analytics/analytics-pages/analytics-pages-overview) 
documentation to
 get more details about available dashboards and their usage.
 
## Advanced Configurations
 This section will explain the additional configurations you can make to fine tune the analytics data publishing
 . Each of these configurations are set to a default value derived through testing. However, based on other
  factors there may be a need to fine tune these parameters.
  
### Worker Thread Count
This property denotes the number of threads that are publishing analytics data into analytics cloud. Default value is
 one thread. One thread can serve up to 3200 requests per second with unrestricted internet bandwidth. In case
  a single thread is not enough to meet the load handled by your Gateway, you will encounter an error that indicates '**Event queue is full
  . Starting to drop analytics events.**' error message in Gateway logs. If you get this error during an API
   invocation spike then please increase the 'Queue Size' as explained in next section. However, if you are getting
    that error repeatedly then you should increase the worker thread count as shown below.
   
```toml
[apim.analytics]
enable = true
config_endpoint = "https://analytics-event-auth.choreo.dev/auth/v1"
auth_token = “<use token that you generate>”
properties.'worker.thread.count' = 2
```    

### Queue Size
This property denotes the number of analytics events Gateway keeps in-memory and used to handle request bursts
. Default value is set to 20000. As explained in the previous section if you observe '**Event queue is full
. Starting to drop analytics events.**' error message in Gateway logs during API invocation spikes you should
 consider increasing queue size. However, another factor you should consider when increasing queue size is the memory
  foot print. Single analytics publishing event is around 1 KB. Hence you should plan the capacity to not hinder the
   JVM heap. To tweak the property, add the configuration as shown below.
```toml
[apim.analytics]
enable = true
config_endpoint = "https://analytics-event-auth.choreo.dev/auth/v1"
auth_token = “<use token that you generate>”
properties.'queue.size' = 10000
```
### Client Flushing Delay
This property denotes the guaranteed frequency analytics events will be published to the cloud in milliseconds.
. Currently analytics
 events are batched before sending. Once a given batch is full that batch will be published into Analytics Cloud
 . However under low throughput, it can take sometime for a batch to be filled. In such cases Client Flushing Delay
  will come into picture. Separate publisher will publish analytics events once every Client Flushing Delay if Event
   Queue mentioned above is empty and none of the worker threads are currently publishing. By default this is set to
    10 seconds. To tweak the property, add the configuration as shown below.
```toml
[apim.analytics]
enable = true
config_endpoint = "https://analytics-event-auth.choreo.dev/auth/v1"
auth_token = “<use token that you generate>”
properties.'client.flushing.delay' = 15000
```
