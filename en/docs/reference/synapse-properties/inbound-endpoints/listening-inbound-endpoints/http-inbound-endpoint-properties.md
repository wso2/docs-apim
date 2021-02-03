# HTTP/HTTPS Inbound Endpoint
## Introduction

The HTTP inbound protocol is used to separate endpoint listeners for each HTTP inbound endpoint so that messages are handled separately. The HTTP inbound endpoint can bypass the inbound side axis2 layer and directly inject messages to a given sequence or API. For proxy services, messages will be routed through the axis2 transport layer in a manner similar to normal transports. You can start dynamic HTTP inbound endpoints without restarting the server.

## Syntax

```xml tab='HTTP Listener'
<inboundEndpoint name="HttpListenerEP" protocol="http" suspend="false" sequence="TestIn" onError="fault" >
    <p:parameters xmlns:p="http://ws.apache.org/ns/synapse">
        <p:parameter  name="inbound.http.port">8081</p:parameter>
    </p:parameters>
<inboundEndpoint>
```

```xml tab='HTTPS Listener'
<inboundEndpoint name="HttpListenerEP" protocol="https" suspend="false" sequence="TestIn" onError="fault" >
        <p:parameters xmlns:p="http://ws.apache.org/ns/synapse">
            <p:parameter  name="inbound.http.port">8081</p:parameter>
            <p:parameter name="keystore">
                <KeyStore>
                    <Location>repository/resources/security/wso2carbon.jks</Location>
                    <Type>JKS</Type>
                    <Password>wso2carbon</Password>
                    <KeyPassword>wso2carbon</KeyPassword>
                </KeyStore>
            </p:parameter>
            <p:parameter name="truststore">
                <TrustStore>
                    <Location>repository/resources/security/client-truststore.jks</Location>
                    <Type>JKS</Type>
                    <Password>wso2carbon</Password>
                </TrustStore>
            </p:parameter>
            <p:parameter name="SSLVerifyClient">require</p:parameter>
            <p:parameter name="HttpsProtocols">TLSv1,TLSv1.1,TLSv1.2</p:parameter>
            <p:parameter name="SSLProtocol">SSLV3</p:parameter>
            <p:parameter name="CertificateRevocationVerifier">
                <CertificateRevocationVerifier enable="true">
                   <CacheSize>10</CacheSize>
                   <CacheDelay>2</CacheDelay>
                </CertificateRevocationVerifier>
             </p:parameter>
         </p:parameters>
</inboundEndpoint>
```

## Properties

Listed below are the properties used for [creating an HTTP/HTTPS inbound endpiont]({{base_path}}/integrate/develop/creating-artifacts/creating-an-inbound-endpoint).

### Required Properties

Listed below are the required properties when [creating an HTTP/HTTPS inbound endpiont]({{base_path}}/integrate/develop/creating-artifacts/creating-an-inbound-endpoint).

<table>
      <tr>
         <th>
            Property
         </th>
         <th>
            Description
         </th>
      </tr>
   <tbody>
      <tr>
        <th>Property</th>
        <th>Description</th>
      </tr>
      <tr>
         <td>inbound.http.port</td>
         <td>
          The port on which the endpoint listener should be started.
         </td>
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
   </tbody>
</table>

### Optional Properties

Listed below are the optional properties you can configure when [creating an HTTP/HTTPS inbound endpiont]({{base_path}}/integrate/develop/creating-artifacts/creating-an-inbound-endpoint).

<table>
   <thead>
      <tr>
         <th>
            <p>Property Name</p>
         </th>
         <th>
            <p>Description</p>
         </th>
      </tr>
   </thead>
   <tbody>
      <tr>
         <td>
            keystore
         </td>
         <td>The KeyStore location where keys are stored.</td>
      </tr>
      <tr>
         <td>
            truststore
         </td>
         <td>The TrustStore location where keys are stored.</td>
      </tr>
      <tr>
         <td>
          SSLVerifyClient
         </td>
         <td>
            <p>Used when enabling mutual verification.</p>
         </td>
      </tr>
      <tr>
         <td>
          HttpsProtocols
         </td>
         <td>The supporting protocols.</td>
      </tr>
      <tr>
         <td>
            SSLProtocol
         </td>
         <td>The supporting SSL protocol.</td>
      </tr>
      <tr>
         <td>
            CertificateRevocationVerifier
         </td>
         <td>
            When the <code>enable</code> attribute is set to <code>true</code>, this validates and verifies the revocation status of the host certificates using OCSP/CRL when making HTTPS connections.<br />
            If the <code>enable</code> attribute of this parameter is set to <code>true</code>, you also need to specify the following:
            <ul>
              <li><b>CacheSize</b>: The maximum size of the cache.</li>
              <li><b>CacheDelay</b>: The time duration between two consecutive scheduled cache managing tasks that perform housekeeping work for the cache.</li>
            </ul>
         </td>
      </tr>
   </tbody>
</table>

### Worker Pool Configuration Properties

By default inbound endpoints share the PassThrough transport worker pool to handle incoming requests. If you need a separate worker pool for the inbound endpoint, you need to configure the following properties when [creating an HTTP/HTTPS inbound endpiont]({{base_path}}/integrate/develop/creating-artifacts/creating-an-inbound-endpoint).

<table>
  <tr>
    <th>Property Name</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>inbound.worker.pool.size.core</td>
    <td>
      The initial number of threads in the worker thread pool. This value can be changed accordingly based on the number of messages to be processed. The maximum value that can be specified here is the value of the inbound.worker.pool.size.max parameter.</br></br> The default value is 400.
    </td>
  </tr>
  <tr>
    <td>inbound.worker.pool.size.max</td>
    <td>
      The maximum number of threads in the worker thread pool. Specify a maximum limit in order to avoid performance degradation that can occur due to context switching.</br></br> The default value is 500.
    </td>
  </tr>
  <tr>
    <td>inbound.worker.thread.keep.alive.sec</td>
    <td>
      The keep-alive time for extra threads in the worker pool. This value should be less than the socket timeout. When this time is elapsed for an extra thread, it will be destroyed. The purpose of this parameter is to optimize the usage of resources by avoiding wastage that results from having extra threads that are not utilized.</br></br> The default value is 60.
    </td>
  </tr>
  <tr>
    <td>inbound.worker.pool.queue.length</td>
    <td>
      The length of the queue that is used to hold runnable tasks that are to be executed by the worker pool. The thread pool starts queuing jobs when all existing threads are busy and the pool has reached the maximum number of threads. The value for this parameter should be -1 to use an unbounded queue. If a bound queue is used and the queue gets filled to its capacity, any further attempt to submit jobs will fail causing synapse to drop some messages. </br></br> The default value is -1.
    </td>
  </tr>
  <tr>
    <td>inbound.thread.group.id</td>
    <td>
      Unique Identifier of the thread group. The default value is the PassThrough inbound worker thread group.
    </td>
  </tr>
  <tr>
    <td>inbound.thread.id</td>
    <td>
      Unique Identifier of the thread group. The default value is the PassThrough inbound worker thread.
    </td>
  </tr>
  <tr>
    <td>dispatch.filter.pattern</td>
    <td>
      The regular expression that defines the proxy services and API's to expose via the inbound endpoint. Provide the .* expression to expose all proxy services and API's or provide an expression similar to <code>^(/foo|/bar|/services/MyProxy)$</code> to define a set of services to expose via the inbound endpoint. If you do not provide an expression only the defined sequence of the inbound endpoint will be accessible.
    </td>
  </tr>
</table>