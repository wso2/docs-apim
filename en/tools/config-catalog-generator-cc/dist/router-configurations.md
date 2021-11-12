# Choreo Connect Router Configuration Catalog

This document describes all the configuration parameters that are used in WSO2 Choreo Connect Router.

## Instructions for use

Select the configuration sections, parameters, and values that are required for your use and add them to the `config.toml`
file located in `<CHOREO-CONNECT_HOME>/docker-compose/choreo-connect/conf/`.
See the example .toml file given below.

```toml
# This is an example .toml file.
[router]
  listenerHost = "0.0.0.0"
  listenerPort = 9090
  securedListenerHost = "0.0.0.0"
  securedListenerPort = 9095
  clusterTimeoutInSeconds = 20
  enforcerResponseTimeoutInSeconds = 20
  # system hostname for system API resources (eg: /testkey and /health)
  systemHost = "localhost"

[router.keystore]
  certPath = "/home/wso2/security/keystore/mg.pem"
  keyPath = "/home/wso2/security/keystore/mg.key"

```





## Router


<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">
            
            <input name="2" type="checkbox" id="_tab_2">
                <label class="tab-selector" for="_tab_2"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
<pre><code class="toml">[router]
  listenerHost = "0.0.0.0"
  listenerPort = 9090
  securedListenerHost = "0.0.0.0"
  securedListenerPort = 9095
  clusterTimeoutInSeconds = 20
  enforcerResponseTimeoutInSeconds = 20
  systemHost = "localhost"
</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[router]</code>
                            <span class="badge-required">Required</span>
                            <p>
                                The configurations required for router to route the traffic from different clients to services.
                            </p>
                        </div>
                        <div class="params-wrap">
                            <div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>listenerHost</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>0.0.0.0</code></span>
                                        </div>
                                        
                                    </div>
                                    <div class="param-description">
                                        <p>Host for the listener of Router.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>securedListenerHost</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>0.0.0.0</code></span>
                                        </div>
                                        
                                    </div>
                                    <div class="param-description">
                                        <p>Host for the secured listener of Router.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>listenerPort</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>9090</code></span>
                                        </div>
                                        
                                    </div>
                                    <div class="param-description">
                                        <p>Port for the listener of Router.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>securedListenerPort</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>9095</code></span>
                                        </div>
                                        
                                    </div>
                                    <div class="param-description">
                                        <p>Port for secured listener of Router.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>systemHost</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>localhost</code></span>
                                        </div>
                                        
                                    </div>
                                    <div class="param-description">
                                        <p>The system hostname for system API resources (eg: /testkey and /health).</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>clusterTimeoutInSeconds</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>20</code></span>
                                        </div>
                                        
                                    </div>
                                    <div class="param-description">
                                        <p>The time duration that the Router will wait for an upstream TCP connection to be established.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>enforcerResponseTimeoutInSeconds</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>20</code></span>
                                        </div>
                                        
                                    </div>
                                    <div class="param-description">
                                        <p>The timeout for response coming from enforcer to route per API request.</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>



## Connection Timeout


<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">
            
            <input name="3" type="checkbox" id="_tab_3">
                <label class="tab-selector" for="_tab_3"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
<pre><code class="toml">[router.connectionTimeout]
  requestTimeoutInSeconds = 0
  requestHeadersTimeoutInSeconds = 0 
  streamIdleTimeoutInSeconds = 300
  idleTimeoutInSeconds = 3600
</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[router.connectionTimeout]</code>
                            
                            <p>
                                Timeouts managed by the Envoy (Router) connection manager in Choreo Connect.
                            </p>
                        </div>
                        <div class="params-wrap">
                            <div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>requestTimeoutInSeconds</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>0</code></span>
                                        </div>
                                        
                                    </div>
                                    <div class="param-description">
                                        <p>The time duration that the Router waits for the request to be received by the upstream, starting from the time it was initiated at the client.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>requestHeadersTimeoutInSeconds</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>0</code></span>
                                        </div>
                                        
                                    </div>
                                    <div class="param-description">
                                        <p>The time duration that the Router waits for the request headers to be received by the upstream, starting from the time it was initiated at the client.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>streamIdleTimeoutInSeconds</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>300</code></span>
                                        </div>
                                        
                                    </div>
                                    <div class="param-description">
                                        <p>The time duration that the Router will allow a stream to exist with no upstream or downstream activity. This timeout is applied to regular requests/responses as well as streaming requests/responses, and can be overridden by router.upstream.timeouts.routeIdleTimeoutInSeconds</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>idleTimeoutInSeconds</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>3600</code></span>
                                        </div>
                                        
                                    </div>
                                    <div class="param-description">
                                        <p>The time at which a downstream connection will be terminated if there are no active streams.</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>



## Upstream Timeout


<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">
            
            <input name="4" type="checkbox" id="_tab_4">
                <label class="tab-selector" for="_tab_4"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
<pre><code class="toml">[router.upstream.timeouts]
  routeTimeoutInSeconds = 60
  maxRouteTimeoutInSeconds = 60
  routeIdleTimeoutInSeconds = 300
</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[router.upstream.timeouts]</code>
                            
                            <p>
                                Timeout settings related to routes. This will be applicable globally for all the APIs in Choreo Connect.
                            </p>
                        </div>
                        <div class="params-wrap">
                            <div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>routeTimeoutInSeconds</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>60</code></span>
                                        </div>
                                        
                                    </div>
                                    <div class="param-description">
                                        <p>This is the value that gets overridden by the timeout set at the endpoint level.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>maxRouteTimeoutInSeconds</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>60</code></span>
                                        </div>
                                        
                                    </div>
                                    <div class="param-description">
                                        <p>Maximum value accepted as the endpoint level timeout. If a larger timeout is set as the Endpoint Level Route Timeout, this value will replace the provided Endpoint Level Route Timeout.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>routeIdleTimeoutInSeconds</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>300</code></span>
                                        </div>
                                        
                                    </div>
                                    <div class="param-description">
                                        <p>The backend (upstream) connection idle timeout. The time duration that the request’s stream may be idle.</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>



## Router Keystore


<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">
            
            <input name="5" type="checkbox" id="_tab_5">
                <label class="tab-selector" for="_tab_5"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
<pre><code class="toml">[adapter.keystore]
  certPath = "/home/wso2/security/keystore/mg.pem"
  keyPath = "/home/wso2/security/keystore/mg.key"</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[router.keystore]</code>
                            <span class="badge-required">Required</span>
                            <p>
                                The configurations of key store used in Choreo Connect Router
                            </p>
                        </div>
                        <div class="params-wrap">
                            <div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>certPath</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>/home/wso2/security/keystore/mg.pem</code></span>
                                        </div>
                                        
                                    </div>
                                    <div class="param-description">
                                        <p>Path of the certificate of the Adaptor</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>keyPath</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>/home/wso2/security/keystore/mg.key</code></span>
                                        </div>
                                        
                                    </div>
                                    <div class="param-description">
                                        <p>Path of the private key of the Adaptor</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>



## CORS


<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">
            
            <input name="6" type="checkbox" id="_tab_6">
                <label class="tab-selector" for="_tab_6"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
<pre><code class="toml">[router.cors]
enabled = true
allowOrigins = ["*"]
allowMethods = ["GET","PUT","POST","DELETE","PATCH","OPTIONS"]
allowHeaders = ["authorization","Access-Control-Allow-Origin","Content-Type","SOAPAction","apikey", "testKey", "Internal-Key"]
exposeHeaders = []
allowCredentials = false
</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[router.cors]</code>
                            
                            <p>
                                CORS configurations
                            </p>
                        </div>
                        <div class="params-wrap">
                            <div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>enabled</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> boolean </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code></code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>true, false</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Enable CORS configurations globally for all endpoints and APIs deployed in Choreo Connect Router</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>allowOrigins</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> list of strings </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code></code></span>
                                        </div>
                                        
                                    </div>
                                    <div class="param-description">
                                        <p>Allowed origins. set this to [*] allow all origins.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>allowMethods</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> list of strings </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code></code></span>
                                        </div>
                                        
                                    </div>
                                    <div class="param-description">
                                        <p>The content for the access-control-allow-methods header.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>allowHeaders</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> list of strings </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code></code></span>
                                        </div>
                                        
                                    </div>
                                    <div class="param-description">
                                        <p>The content for the access-control-allow-headers header.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>exposeHeaders</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> list of strings </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code></code></span>
                                        </div>
                                        
                                    </div>
                                    <div class="param-description">
                                        <p>The content for the access-control-expose-headers header.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>allowCredentials</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> boolean </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>false</code></span>
                                        </div>
                                        
                                    </div>
                                    <div class="param-description">
                                        <p>Specifies whether the resource allows credentials.</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>



## Upstream Retry


<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">
            
            <input name="7" type="checkbox" id="_tab_7">
                <label class="tab-selector" for="_tab_7"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
<pre><code class="toml">[router.upstream.retry]
  maxRetryCount = 5
  baseIntervalInMillis = 25
  statusCodes = [ 504 ]
</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[router.upstream.retry]</code>
                            
                            <p>
                                The configurations for the Choreo Connect router when retrying upstream clusters.
                            </p>
                        </div>
                        <div class="params-wrap">
                            <div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>maxRetryCount</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>5</code></span>
                                        </div>
                                        
                                    </div>
                                    <div class="param-description">
                                        <p>Maximum value that can be set as the count within the Endpoint Level Retry configuration.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>baseIntervalInMillis</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>25</code></span>
                                        </div>
                                        
                                    </div>
                                    <div class="param-description">
                                        <p>Base interval for the Envoy&#39;s (Router&#39;s) exponential retry back off algorithm</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>statusCodes</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> list of integers </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>504</code></span>
                                        </div>
                                        
                                    </div>
                                    <div class="param-description">
                                        <p>HTTP status codes that would switch on the retry mechanism when an Endpoint Level Retry configuration is set. The list here is used when the retry configuration is set via the WSO2 API-M UI or when all given status codes are out of range.</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>



## Upstream TLS


<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">
            
            <input name="8" type="checkbox" id="_tab_8">
                <label class="tab-selector" for="_tab_8"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
<pre><code class="toml">[router.upstream.tls]
  minimumProtocolVersion = "TLS1_1"
  maximumProtocolVersion = "TLS1_2"
  ciphers = "ECDHE-ECDSA-AES128-GCM-SHA256, ECDHE-RSA-AES128-GCM-SHA256, ECDHE-ECDSA-AES128-SHA, ECDHE-RSA-AES128-SHA, AES128-GCM-SHA256, AES128-SHA, ECDHE-ECDSA-AES256-GCM-SHA384, ECDHE-RSA-AES256-GCM-SHA384, ECDHE-ECDSA-AES256-SHA, ECDHE-RSA-AES256-SHA, AES256-GCM-SHA384, AES256-SHA"
  # the default endpoint certificates
  trustedCertPath = "/etc/ssl/certs/ca-certificates.crt"
  verifyHostName = true
  disableSslVerification = false
</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[router.upstream.tls]</code>
                            
                            <p>
                                The configurations for SSL configuration related to the backend connection in Choreo Connect.
                            </p>
                        </div>
                        <div class="params-wrap">
                            <div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>minimumProtocolVersion</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>TLS1_1</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>TLSv1_0, TLSv1_1, TLSv1_2, TLSv1_3</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Minimum TLS protocol version.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>maximumProtocolVersion</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>TLS1_2</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>TLSv1_0, TLSv1_1, TLSv1_2, TLSv1_3</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Maximum TLS protocol version.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>ciphers</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>ECDHE-ECDSA-AES128-GCM-SHA256, ECDHE-RSA-AES128-GCM-SHA256, ECDHE-ECDSA-AES128-SHA, ECDHE-RSA-AES128-SHA, AES128-GCM-SHA256, AES128-SHA, ECDHE-ECDSA-AES256-GCM-SHA384, ECDHE-RSA-AES256-GCM-SHA384, ECDHE-ECDSA-AES256-SHA, ECDHE-RSA-AES256-SHA, AES256-GCM-SHA384, AES256-SHA</code></span>
                                        </div>
                                        
                                    </div>
                                    <div class="param-description">
                                        <p>If specified, the TLS listener will only support the specified [cipher list]() when negotiating TLS 1.0-1.2 (this setting has no effect when negotiating TLS 1.3)</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>trustedCertPath</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>/etc/ssl/certs/ca-certificates.crt</code></span>
                                        </div>
                                        
                                    </div>
                                    <div class="param-description">
                                        <p>Path to trusted certificates</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>verifyHostName</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> boolean </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>true</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>true, false</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Enable/Disable Verifying host name</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>disableSslVerification</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> boolean </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>false</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>true, false</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Disable SSL verification</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>


