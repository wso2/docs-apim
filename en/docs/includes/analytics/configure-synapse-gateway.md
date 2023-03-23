
Follow the instructions below to publish analytics data to the analytics cloud via the API Gateway:

1. Open the `<API-M_HOME>/repository/conf/deployment.toml` file and update the `[apim.analytics]` config segment as follows:

     ```toml
     [apim.analytics]
     enable = true
     config_endpoint = "https://analytics-event-auth.choreo.dev/auth/v1"
     auth_token = "<use token that you generate>"
     ```

      <div class="admonition note">
      <p class="admonition-title">Note</p>
      <ul><li><p>This is the basic configuration that you need to publish analytics data to the analytics cloud.</p></li>
      <li>If you need to change the following default values of the Worker Thread Count, Queue Size or Client Flushing Delay, see the <a href="https://apim.docs.wso2.com/en/4.2.0/api-analytics/gateways/configure-synapse-gateway/#advanced-configurations">Advanced configurations</a>.
      <table>
      <tr>
      <th><b>Parameter</b></th>
      <th><b>Default Value</b></th>
      </tr>
      <tr>
      <td><code>worker.thread.count</code></td>
      <td> 1 thread</td>
      </tr>
      <tr>
      <td><code>queue.size</code></td>
      <td>20000 requests</td></tr>
      <tr>
      <td><code>client.flushing.delay</code></td>
      <td>10 seconds</td>
      </tr>
      </table>
      </li>
      </ul>
      </div>

2. Enter the on-premise token, which you obtained via the Choreo Portal in the **Register your environment** step, as the Auth token field.
   
3. Restart the API Gateway.
