# Choreo Connect Tracing Configuration Catalog

This document describes all the configurations related to tracing that are used in WSO2 Choreo Connect.

## Instructions for use

Select the configuration sections, parameters, and values that are required for your use and add them to the `config.toml`
file located in `<CHOREO-CONNECT_HOME>/docker-compose/choreo-connect/conf/`.
See the example .toml file given below.

```toml
# This is an example .toml file.
[tracing]
  enabled = true
  type = "zipkin"

[tracing.configProperties]
    host = "zipkin"
    port = "9411"
    endpoint = "/api/v2/spans"
    instrumentationName = "CHOREO-CONNECT"
    maximumTracesPerSecond = "2"

```






## Tracing Configurations


<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">
            
            <input name="2" type="checkbox" id="_tab_2">
                <label class="tab-selector" for="_tab_2"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
<pre><code class="toml">[enforcer.tracing]
  enabled = false
  type = "jaeger"
</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[tracing]</code>
                            
                            <p>
                                
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
                                            <span class="param-default-value">Default: <code>false</code></span>
                                        </div>
                                        
                                    </div>
                                    <div class="param-description">
                                        <p>Enable/Disable tracing in Choreo Connect</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>type</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>zipkin</code></span>
                                        </div>
                                        
                                    </div>
                                    <div class="param-description">
                                        <p>Type of trace exporter (e.g: azure, zipkin). Use `zipkin` for jaeger</p>
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



## Tracer Configuration Properties


<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">
            
            <input name="3" type="checkbox" id="_tab_3">
                <label class="tab-selector" for="_tab_3"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
<pre><code class="toml">[enforcer.tracing.configProperties]
  host = "jaeger"
  port = "9411"
  endpoint = "/api/v2/spans"
  instrumentationName = "CHOREO-CONNECT"
  maximumTracesPerSecond = "2"
  maxPathLength = "256"
  connectionTimeout = "20"
</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[tracing.configProperties]</code>
                            <span class="badge-required">Required</span>
                            <p>
                                Configurations specific to each tracer configured in `tracing.type`
                            </p>
                        </div>
                        <div class="params-wrap">
                            <div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>endpoint</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>/api/v2/spans</code></span>
                                        </div>
                                        
                                    </div>
                                    <div class="param-description">
                                        <p>Tracing data receiver&#39;s endpoint path. Applicable only for Jaeger and Zipkin tracers</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>host</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>jaeger</code></span>
                                        </div>
                                        
                                    </div>
                                    <div class="param-description">
                                        <p>Tracing data receiver&#39;s host. Applicable only for Jaeger and Zipkin tracers</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>port</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>9411</code></span>
                                        </div>
                                        
                                    </div>
                                    <div class="param-description">
                                        <p>Tracing data receiver host&#39;s port. Applicable only for Jaeger and Zipkin tracers</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>connectionString</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>&quot;&quot;</code></span>
                                        </div>
                                        
                                    </div>
                                    <div class="param-description">
                                        <p>Azure App Insights connection string. Applicable only for Azure Insights</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>instrumentationName</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>CHOREO-CONNECT</code></span>
                                        </div>
                                        
                                    </div>
                                    <div class="param-description">
                                        <p>Reference name for the Choreo Connect service in the tracer.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>maximumTracesPerSecond</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>2</code></span>
                                        </div>
                                        
                                    </div>
                                    <div class="param-description">
                                        <p>Number of trace events to publish per second</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>maxPathLength</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>256</code></span>
                                        </div>
                                        
                                    </div>
                                    <div class="param-description">
                                        <p>Maximum length of the request path to extract and include in the HttpUrl tag.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>connectionTimeout</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>20</code></span>
                                        </div>
                                        
                                    </div>
                                    <div class="param-description">
                                        <p>Connection timeout for the OTLP service</p>
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


