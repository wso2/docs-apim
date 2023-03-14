# Choreo Based Analytics Getting Started Guide

API Manager offers analytics as a cloud service. Therefore, you need to register with the analytics cloud in order to use API Manager Analytics. Follow the instructions below to get started with analytics:

## Step 1 - Sign in to Choreo

Follow the instructions below to sign in to Choreo.

1. Navigate to Choreo using the following URL. 
    
     <a href="https://console.choreo.dev/?apianalytics=true?utm_source=apim_docs">https://console.choreo.dev</a>.

2. Sign-in to Choreo.
   
    [![Choreo sign-in options]({{base_path}}/assets/img/observe/sign-in-choreo.png){: style="width:30%"}]({{base_path}}/assets/img/observe/sign-in-choreo.png)

## Step 2 - Register your environment

Follow the instructions below to register your on-premise environment:

1. Click on the user profile in the top right corner of the screen and select **Settings**.

     [![Settings Menu]({{base_path}}/assets/img/observe/settings-menu.png)]({{base_path}}/assets/img/observe/settings-menu.png)

2. If you are a member of multiple organizations, select the appropriate organization from the top left-hand corner. 
   
     For more information on handling users with role-based access control in organizations, see [Role-based Access Control for API Analytics]({{base_path}}/api-analytics/role-based-access-control).

     [![Org Selector]({{base_path}}/assets/img/observe/organization-selector.png)]({{base_path}}/assets/img/observe/organization-selector.png)

3. Select the **On-prem Keys** tab and click **Generate keys**.

     [![On-prem Key]({{base_path}}/assets/img/observe/on-prem-key.png)]({{base_path}}/assets/img/observe/on-prem-key.png)

4. Enter a suitable name for your environment (e.g., customer1-dev).

5. Click **Generate**.
   
      <div class="admonition info">
      <p class="admonition-title">Info</p>
      <p>The validity period of the key and the number of keys that you are allowed to generate vary based on the type of user as explained below:</p>
      <table>
      <tr>
      <th><b>User Type</b></th>
      <th><b>Descrption</b></th>
      <th><b>Validity Period</b></th>
      <th><b>Number of Keys Allowed</b></th>
      </tr>
      <tr>
      <td> Free user</td>
      <td> Refers to users who do not have a valid subscription for Choreo.</td>
      <td> 2 weeks</br>
      <p><b>NOTE:</b> The validity of the keys can be temporarily extended by <a href="https://wso2.com/contact/">contacting sales</a> and submitting a request.</p></td>
      <td> 3 keys</td>
      </tr>
      <tr>
      <td> Subscription customers</td>
      <td> Refers to users who have a valid subscription for Choreo.</td>
      <td> 1 year</td>
      <td> unlimited</td>
      </tr>
      </table>
      </div>

6. Copy the key that was generated before closing the dialog box.

## Step 3 - Configure the Gateway

API Analytics is delivered via the API Analytics Cloud. Therefore, the API Manager Gateway needs to be configured to publish analytics data into the cloud.

The Gateway configuration process varies based on the Gateway that you are using.

If your system connects to the service through a proxy server/firewall, you need to grant access to the following endpoints to access the Choreo Analytics Cloud service to publish data.

| Host                                             | Port | Protocol |
|--------------------------------------------------|------|----------|
| `analytics-prod-incoming.servicebus.windows.net` | 5671 | AMQP     |
| `analytics-prod-incoming.servicebus.windows.net` | 5672 | AMQP     |
| `analytics-event-auth.choreo.dev`                | 443  | HTTPS    |

### Basic configurations

{!includes/analytics/configure-synapse-gateway.md!}

### Advanced configurations

This section explains the additional configurations that you can carry out to fine-tune the analytics data publishing process. The following configurations are set to default values derived through testing by default. However, based on other factors, you may need to fine-tune these parameters.
  
#### Worker Thread Count

This property defines the number of threads that publish analytics data into the Analytics Cloud. The default value is one thread. One thread can serve up to 3200 requests per second with unrestricted internet bandwidth. In case a single thread is not enough to meet the load handled by your Gateway, you will encounter the following error message in Gateway logs. 

```
Event queue is full. Starting to drop analytics events.
```

If you get the above-mentioned error during an API invocation spike, then increase the `Queue Size` as explained in next section. However, if you are getting this error repeatedly, then you should increase the worker thread count as shown below.

```toml
[apim.analytics]
enable = true
config_endpoint = "https://analytics-event-auth.choreo.dev/auth/v1"
auth_token = “<use token that you generate>”
properties.'worker.thread.count' = 2
```    

#### Queue Size

This property denotes the number of analytics events that the Gateway keeps in-memory and uses to handle request bursts. The default value is set to 20000. As explained in the previous section, if you get the following error message in the Gateway logs during API invocation spikes, you should consider increasing queue size. 

```
Event queue is full. Starting to drop analytics events.
```

However, another factor that you should consider when increasing the queue size is the memory footprint. A single analytics publishing event is around 1 KB. Therefore, you should plan the capacity to not hinder the JVM heap. To tweak the property, add the configuration as shown below.

```toml
[apim.analytics]
enable = true
config_endpoint = "https://analytics-event-auth.choreo.dev/auth/v1"
auth_token = “<use token that you generate>”
properties.'queue.size' = 10000
```

#### Client Flushing Delay

This property denotes the guaranteed frequency (in milliseconds) that the analytics events will be published to the cloud. Currently, analytics events are batched before being sent. Once a given batch is full, it is published into the Analytics Cloud. However, under low throughput, there might be a slight delay for a batch to be filled. The **Client Flushing Delay** property is used when such delays happen. A separate publisher will publish the analytics events after every Client Flushing Delay if the Event Queue, mentioned above, is empty and also if none of the worker threads are currently publishing. By default, this is set to 10 seconds. To tweak the property, add the configuration as shown below.

```toml
[apim.analytics]
enable = true
config_endpoint = "https://analytics-event-auth.choreo.dev/auth/v1"
auth_token = “<use token that you generate>”
properties.'client.flushing.delay' = 15000
```

## Step 4 - View the Analytics Dashboards

Invoke APIs and open <a href="https://console.choreo.dev/insights/overview">Choreo Insights</a> to view the dashboards.

For more detailed information on the Choreo Insights dashboards and their usage, go to the [View API Insights](https://wso2.com/choreo/docs/insights/view-api-insights/) page of the Choreo documentation.

## What's Next?

Enterprises and companies who want to use the Choreo Insights collaboratively can utilize the organization concept in Choreo. For more information, see [Role-based Access Control for API Analytics]({{base_path}}/api-analytics/role-based-access-control).
