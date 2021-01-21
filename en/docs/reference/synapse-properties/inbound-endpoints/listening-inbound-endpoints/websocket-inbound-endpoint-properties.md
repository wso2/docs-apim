# Websocket Inbound Endpoint
## Introduction

The WebSocket Inbound protocol is based on the <a href="http://tools.ietf.org/html/rfc6455">Websocket protocol</a> and allows full-duplex message mediation.

## Syntax

```xml tab='Websocket'
<inboundEndpoint name="WebSocketListenerEP" onError="fault" protocol="ws" sequence="TestIn" suspend="false" xmlns="http://ws.apache.org/ns/synapse">
  <parameters>
     <parameter name="inbound.ws.port">9091</parameter>
     <parameter name="ws.outflow.dispatch.sequence">TestOut</parameter> 
     <parameter name="ws.client.side.broadcast.level">0</parameter>
     <parameter name="ws.outflow.dispatch.fault.sequence">fault</parameter>
  </parameters> 
</inboundEndpoint>
```

```xml tab='Secure Websocket'
<inboundEndpoint name="SecureWebSocketEP" onError="fault" protocol="wss" sequence="TestIn" suspend="false" xmlns="http://ws.apache.org/ns/synapse">
  <parameters>
     <parameter name="inbound.ws.port">9091</parameter>
     <parameter name="ws.client.side.broadcast.level">0</parameter>
     <parameter name="ws.outflow.dispatch.sequence">TestOut</parameter>
     <parameter name="ws.outflow.dispatch.fault.sequence">fault</parameter>
     <parameter name="wss.ssl.key.store.file">repository/resources/security/wso2carbon.jks</parameter>
     <parameter name="wss.ssl.key.store.pass">wso2carbon</parameter>
     <parameter name="wss.ssl.trust.store.file">repository/resources/security/client-truststore.jks</parameter>
     <parameter name="wss.ssl.trust.store.pass">wso2carbon</parameter>
     <parameter name="wss.ssl.cert.pass">wso2</parameter>
   </parameters>
</inboundEndpoint>
```

## Properties

Listed below are the properties used for [creating a Websocket inbound endpiont]({{base_path}}/integrate/develop/creating-artifacts/creating-an-inbound-endpoint).

### Required Properties

The following properties are required when [creating a Websocket inbound endpiont]({{base_path}}/integrate/develop/creating-artifacts/creating-an-inbound-endpoint).

<table>
  <tr>
    <th>Property</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>inbound.ws.port</td>
    <td>The netty listener port on which the WebSocket inbound listens.</td>
  </tr>
  <tr>
    <td>ws.client.side.broadcast.level</td>
    <td>The client broadcast level that defines how WebSocket frames are broadcast from the WebSocket inbound endpoint to the client. Broadcast happens based on the subscriber path client connected to the WebSocket inbound endpoint. The three possible levels are as follows:<br />
      0 - Only a unique client can receive the frame from a WebSocket inbound endpoint.<br />
      1 - All the clients connected with the same subscriber path receives the WebSocket frame.<br />
      2 - All the clients connected with the same subscriber path, except the one who publishes the frame to the inbound, receives the WebSocket frame.
    </td>
  </tr>
  <tr>
    <td>ws.outflow.dispatch.sequence</td>
    <td>The sequence for the back-end to client mediation.</td>
  </tr>
  <tr>
    <td>ws.outflow.dispatch.fault.sequence</td>
    <td>The fault sequence for the back-end to client mediation path.</td>
  </tr>
  <tr>
         <td>sequential</td>
         <td>The behavior when executing the given sequence.<br />
            When set as <code>true</code> , mediation will happen within the same thread. When set as <code>false</code> , the mediation engine will use the inbound thread pool. The default thread pool values can be found in the <code>MI_HOME/conf/deployment.toml</code> file, under the `[mediation]` section. The default setting is <code>true</code>.
         </td>
      </tr>
      <tr>
        <td>Suspend</td>
        <td>
          If the inbound listener should pause when accepting incoming requests, set this to <code>true</code>. If the inbound listener should not pause when accepting incoming requests, set this to <code>false</code>.
        </td>
      </tr>
</table>

### Required Properties (for Secured Websocket)

In addition to the [common websocket inbound properties](#common-websocket-inbound-required-properties) listed above, the following properties are required when [creating a **secured** Websocket inbound endpiont]({{base_path}}/integrate/develop/creating-artifacts/creating-an-inbound-endpoint).

<table>
  <tr>
    <th>Property</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>inbound.ws.port</td>
    <td>The netty listener port on which the WebSocket inbound listens.</td>
  </tr>
  <tr>
    <td>ws.client.side.broadcast.level</td>
    <td>The client broadcast level that defines how WebSocket frames are broadcast from the WebSocket inbound endpoint to the client. Broadcast happens based on the subscriber path client connected to the WebSocket inbound endpoint. The three possible levels are as follows:<br />
      0 - Only a unique client can receive the frame from a WebSocket inbound endpoint.<br />
      1 - All the clients connected with the same subscriber path receives the WebSocket frame.<br />
      2 - All the clients connected with the same subscriber path, except the one who publishes the frame to the inbound, receives the WebSocket frame.
    </td>
  </tr>
  <tr>
    <td>ws.outflow.dispatch.sequence</td>
    <td>The sequence for the back-end to client mediation.</td>
  </tr>
  <tr>
    <td>ws.outflow.dispatch.fault.sequence</td>
    <td>The fault sequence for the back-end to client mediation path.</td>
  </tr>
  <tr>
    <td>wss.ssl.key.store.file</td>
    <td>The keystore location where keys are stored.</td>
  </tr>
  <tr>
    <td>wss.ssl.key.store.pass</td>
    <td>The password to access the keystore file.</td>
  </tr>
  <tr>
    <td>wss.ssl.trust.store.file</td>
    <td>The truststore location where keys are stored.</td>
  </tr>
  <tr>
    <td>wss.ssl.trust.store.pass</td>
    <td>The password to access the truststore file.</td>
  </tr>
  <tr>
    <td>wss.ssl.cert.pass</td>
    <td>The SSL certificate password.</td>
  </tr>
</table>

### Optional Properties

The following optional properties can be configured when [creating a Websocket inbound endpiont]({{base_path}}/integrate/develop/creating-artifacts/creating-an-inbound-endpoint).

<table>
   <thead>
      <tr>
         <th>Property</th>
         <th>Description</th>
      </tr>
   </thead>
   <tbody>
      <tr>
         <td>ws.boss.thread.pool.size</td>
         <td>The size of the netty boss pool.</td>
      </tr>
      <tr>
         <td>ws.worker.thread.pool.size</td>
         <td>The size of the worker thread pool.</td>
      </tr>
      <tr>
         <td>ws.subprotocol.handler.class</td>
         <td>Specify one or more custom subprotocol handler classes that are required. Separate each custom subprotocol handler class using a semicolon.</td>
      </tr>
      <tr>
         <td>ws.default.content.type</td>
         <td>
            Specifies the content type of the Web Socket frames that are received from the inbound endpoint.
         </td>
      </tr>
      <tr>
         <td>ws.shutdown.status.code</td>
         <td>Specifies the status code of the closed web socket frame sent when the inbound endpoint is closed.</td>
      </tr>
      <tr>
         <td>ws.shutdown.status.message</td>
         <td>Specifies the status message of the closed web socket frame when the inbound endpoint is closed.</td>
      </tr>
      <tr>
         <td>ws.pipeline.handler.class</td>
         <td>The fully qualified class name of a pipeline handler class that you implemented.</td>
      </tr>
      <tr>
        <td>Ws Use Port Offset</td>
        <td></td>
      </tr>
   </tbody>
</table>

### Optional Properties (for Secured Websocket)

The following optional properties can be configured when [creating a **Secured** Websocket inbound endpiont]({{base_path}}/integrate/develop/creating-artifacts/creating-an-inbound-endpoint).

<table>
  <tr>
    <th>Property</th>
    <th>Description</th>
  </tr>
  <tr>
         <td>wss.ssl.protocols</td>
         <td>Enables the SSL protocol for the particular WebSocket inbound endpoint. Default value is "TLS". You can change it to a TLS version(s), which is/are enabled with the SSL protocol (i.e., TLSv1,TLSv1.1,TLSv1.2). For example, <code><parameter name="wss.ssl.protocols">TLSv1.1,TLSv1.2</parameter></code></td>
      </tr>
      <tr>
         <td>wss.ssl.cipher.suites</td>
         <td>
            <div class="content-wrapper">
               <p>Enables the specified Cipher Suites for the particular WebSocket inbound endpoint. For example:</p>
               <div class="code panel pdl" style="border-width: 1px;">
                  <div class="codeContent panelContent pdl">
                     <div class="sourceCode" id="cb1" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence">
                        <pre class="sourceCode java"><code class="sourceCode java"><span id="cb1-1"><a href="#cb1-1"></a>&lt;parameter name=<span class="st">&quot;wss.ssl.cipher.suites&quot;</span>&gt;</span>
<span id="cb1-2"><a href="#cb1-2"></a>TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA256,</span>
<span id="cb1-3"><a href="#cb1-3"></a>TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256,</span>
<span id="cb1-4"><a href="#cb1-4"></a>TLS_DHE_RSA_WITH_AES_128_CBC_SHA256,</span>
<span id="cb1-5"><a href="#cb1-5"></a>TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA,</span>
<span id="cb1-6"><a href="#cb1-6"></a>TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA,</span>
<span id="cb1-7"><a href="#cb1-7"></a>TLS_DHE_RSA_WITH_AES_128_CBC_SHA</span>
<span id="cb1-8"><a href="#cb1-8"></a>&lt;/parameter&gt;</span></code></pre>
                     </div>
                  </div>
               </div>
            </div>
         </td>
      </tr>
</table>
