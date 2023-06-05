# Best practices for working with endpoints

- Do not use anonymous endpoints. Always use [named endpoints]({{base_path}}/reference/synapse-properties/endpoint-properties). As anynymous endpoints have auto-generated names in the synapse
  configuration, it is difficult to identify which endpoint is causing
  the error in case of an error.

- Configure timeout settings appropriately. Timeout configurations are
  required before you go into production with the system.

  The diagram below illustrates the typical message flow when a proxy
  service is involved in a client-server communication. The two
  connectores, `Client to Proxy connection` and
  `Proxy to Backend connection`  are two
  separate connections that do not depend on each other. Even if one
  connections times out, the other is unaffected.  

<a href="{{base_path}}/assets/img/reference/typical-message-flow.png"><img src="{{base_path}}/assets/img/reference/typical-message-flow.png" width=500></a> 

  Here are the important timeout parameters you should configure
  before going into production:

  <table>
  <thead>
  <tr class="header">
  <th>Parameter</th>
  <th>Description</th>
  <th>Configuration File</th>
  <th>Default Value</th>
  <th>Recommended Value</th>
  </tr>
  </thead>
  <tbody>
  <tr class="odd">
  <td><code>[transport.http] 
  socket_timeout = 180000                
  </code></td>
  <td>The socket timeout of the <a href="{{base_path}}/install-and-setup/setup/mi-setup/transport_configurations/">Passthrough</a> http/https transport sender and listener. You can find the <a href="{{base_path}}/install-and-setup/setup/mi-setup/transport_configurations/">passthru-http.properties</a> file in the <code>&lt;EI_HOME&gt;/conf</code> directory.</td>
  <td><code>deployment.toml</code></td>
  <td>180000</td>
  <td>180000</td>
  </tr>
  <tr class="even">
  <td>Endpoint timeout</td>
  <td><div class="content-wrapper">
  <p>The timeout parameter that you should configure at the endpoint level. You can configure timeout values as required for specific endpoints.</p>
  <p>Here's a sample endpoint configuration that is configured with timeout parameters. Here, <code>&lt;duration&gt;</code> is the timeout value, and <code>&lt;responseAction&gt;</code> is the action to be taken on timeout. In this example, it is invoking the <code>FaultSequence</code> .</p>
  <div class="code panel pdl" style="border-width: 1px;">
  <div class="codeContent panelContent pdl">
  <div class="sourceCode" id="cb1" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence"><pre class="sourceCode java"><code class="sourceCode java"><span id="cb1-1"><a href="#cb1-1"></a>&lt;endpoint&gt;</span>
  <span id="cb1-2"><a href="#cb1-2"></a>&lt;address uri=<span class="st">&quot;http://localhost:8281/services/SimpleStockQuoteService&quot;</span>&gt;</span>
  <span id="cb1-3"><a href="#cb1-3"></a>&lt;timeout&gt;</span>
  <span id="cb1-4"><a href="#cb1-4"></a>&lt;duration&gt;<span class="dv">120000</span>&lt;/duration&gt;</span>
  <span id="cb1-5"><a href="#cb1-5"></a>&lt;responseAction&gt;fault&lt;/responseAction&gt;</span>
  <span id="cb1-6"><a href="#cb1-6"></a>&lt;/timeout&gt;</span>
  <span id="cb1-7"><a href="#cb1-7"></a>&lt;/address&gt;</span>
  <span id="cb1-8"><a href="#cb1-8"></a>&lt;/endpoint&gt;</span></code></pre></div>
  </div>
  </div>
      <p>Follow the formula <code>Socket Timeout &gt; max(Global endpoint timeout, Timeout of individual endpoints)</code> , and make sure that you set the <code>http.socket.timeout</code> to a value higher than all other endpoint timeout values.</p>
  </div></td>
  <td>Endpoint configuration files</td>
  <td>synapse.global_timeout_interval</td>
  <td>Depends on the use case, Typically 120000</td>
  </tr>
  <tr class="odd">
  <td><code>[mediation]
            synapse.global_timeout_interval = "120000" </code></td>
  <td><div class="content-wrapper">
  <p>Global timeout value for endpoints. Can be overwritten by individual endpoint timeout values.</p>
  <p>Synapse, which is the underlying mediation engine of WSO2 Micro Integrator, is a complete asynchronous messaging engine that does not block its worker threads on network I/O. Instead, it registers a call-back for a particular request and returns the threads without waiting for a response. When a response is available, the registered call-back is used to correlate it with the relevant request so that further processing can be done.<br />
  If the backend server does not respond, it is required to clear the registered call-backs after a particular <em>duration</em> to prevent possible memory leaks. This <em>duration</em> is set via a timer task called <code>TimeoutHandler</code> . The <code>synapse.global_timeout_interval</code> parameter represents the <em>duration</em> that a call-back should be kept in the call-back store.</p>
      <p>If you have configured a timeout value at the endpoint level, the global timeout value is not taken into consideration for that endpoint. For all the other endpoints that do not have a timeout value configured, the global value is considered as the timeout value.</p>

  <p>You can configure the <code>synapse.global_timeout_interval</code> parameter in the <code>&lt;MI_HOME&gt;/conf/deployment.toml</code> file. The default value is 120 seconds. If you want to support endpoint timeout values that are greater than 120 seconds, set the <code>synapse.global_timeout_interval</code> to a value more than 120 seconds. However, the need to set such large timeout values for endpoints is extremely unlikely.</p>
  </div></td>
  <td><code>deployment.toml</code></td>
  <td>120000</td>
  <td>120000</td>
  </tr>
  <tr class="even">
  <td><code>[synapse_properties]
            synapse.timeout_handler_interval = "15000"
    </code></td>
  <td>Duration between two <code>TimeoutHandler</code> executions.The <code>TimeoutHandler              </code> is executed every 15 seconds by default. Therefore, the time that call-backs get cleared can deviate up to 15 seconds from the configured value.<br />
  You can configure the <code>TimeoutHandler</code> execution interval by specifying a required value for <code>synapse.timeout_handler_interval</code> in the <code>&lt;MI_HOME&gt;/conf/deployment.toml</code> file.</td>
  <td><code>deployment.toml</code></td>
  <td>15000</td>
  <td>15000</td>
  </tr>
  </tbody>
  </table>

- Set the socket timeout value and individual endpoint timeout values
  appropriately. Use this formula to set timeout values:

    `Socket Timeout > max(Global endpoint timeout Timeout of individual endpoints)`

- Be sure to set proper values to advanced configuration parameters,
  although they are optional.  
  The happy path should work with the default values, but you might
  encounter issues in production when the system does not follow the
  happy path. For example, if you use the default configurations and
  as an error occurs in your sequence, the endpoint gets suspended
  immediately and subsequent messages to that endpoint get rejected
  without being sent to the backend service. This might not be the
  expected behaviour in every use case. Therefore, it is important to
  perform [endpoint error handling]({{base_path}}/reference/synapse-properties/endpoint-properties/#endpoint-error-handling-properties)
  based on the use case.

- Use the [HTTP endpoint]({{base_path}}/install-and-setup/setup/mi-setup/transport_configurations/configuring-transports)
  for RESTful service invocations. The HTTP endpoint is especially
  designed to make RESTful service integration easy. For example, it
  supports `url-templates` , which is an option
  to set the http method.

- For RESTful service integration, use either [REST APIs]({{base_path}}/reference/synapse-properties/rest-api-properties)
  or HTTP endpoints. You can use REST APIs to expose an integration
  solution as a RESTful service, and use HTTP endpoints to logically
  represent a RESTful backend service.
