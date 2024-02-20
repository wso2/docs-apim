# Choreo Connect Control Plane Configuration Catalog

This document describes all the configuration parameters that are used in WSO2 Choreo Connect Control Plane.

## Instructions for use

Select the configuration sections, parameters, and values that are required for your use and add them to the `config.toml`
file located in `<CHOREO-CONNECT_HOME>/docker-compose/choreo-connect/conf/`.
See the example .toml file given below.

```toml
[controlPlane]
  enabled = false
```






## control Plane Configurations


<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">
            
            <input name="2" type="checkbox" id="_tab_2">
                <label class="tab-selector" for="_tab_2"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
<pre><code class="toml">[controlPlane]
  enabled = false
  serviceURL = "https://docker.for.mac.localhost:9443/"
  username="admin"
  password="$env{cp_admin_pwd}"
  environmentLabels = ["Default"]
  retryInterval = 5
  skipSSLVerification=true</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[controlPlane]</code>
                            <span class="badge-required">Required</span>
                            <p>
                                This includes configurations required for configuring the Choreo Connect's Control Plane
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
                                            <span class="param-default-value">Default: <code>true</code></span>
                                        </div>
                                        
                                    </div>
                                    <div class="param-description">
                                        <p>Enable/Disable Choreo Connect Control plane.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>serviceURL</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>https://localhost:9443/</code></span>
                                        </div>
                                        
                                    </div>
                                    <div class="param-description">
                                        <p>Service URL of the API Manager.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>username</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>admin</code></span>
                                        </div>
                                        
                                    </div>
                                    <div class="param-description">
                                        <p>Username of the API Manager user</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>password</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>$env{cp_admin_pwd}</code></span>
                                        </div>
                                        
                                    </div>
                                    <div class="param-description">
                                        <p>Password of the API Manager user</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>environmentLabels</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> list of strings </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>[Default]</code></span>
                                        </div>
                                        
                                    </div>
                                    <div class="param-description">
                                        <p>Environment labels list.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>retryInterval</code> </span>
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
                                        <p>Connection retry interval.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>skipSSLVerification</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> boolean </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>true</code></span>
                                        </div>
                                        
                                    </div>
                                    <div class="param-description">
                                        <p>Skip SSL verification.</p>
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



## JMS connection Configurations


<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">
            
            <input name="3" type="checkbox" id="_tab_3">
                <label class="tab-selector" for="_tab_3"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
<pre><code class="toml">[controlPlane.jmsConnectionParameters]
  eventListeningEndpoints = ["amqp://admin:$env{cp_admin_pwd}@wso2am-pattern-1-am-1-service:5672?retries='10'&connectdelay='30'", "amqp://admin:$env{cp_admin_pwd}@wso2am-pattern-1-am-2-service:5672?retries='10'&connectdelay='30'"]
</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[controlPlane.brokerConnectionParameters]</code>
                            <span class="badge-required">Required</span>
                            <p>
                                Message broker connection of the control plane.
                            </p>
                        </div>
                        <div class="params-wrap">
                            <div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>eventListeningEndpoints</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string array </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>[&quot;amqp://admin:$env{cp_admin_pwd}@localhost:5672?retries=&#39;10&#39;&amp;connectdelay=&#39;30&#39;&quot;]</code></span>
                                        </div>
                                        
                                    </div>
                                    <div class="param-description">
                                        <p>Message Broker connection URLs of the Control Plane with retry count and connect delay (in seconds). The array of endpoints acts as fail-over endpoints.</p>
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



## JMS connection Configurations


<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">
            
            <input name="4" type="checkbox" id="_tab_4">
                <label class="tab-selector" for="_tab_4"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
<pre><code class="toml">[controlPlane.httpClient] 
  requestTimeOut = 30</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[controlPlane.httpClient]</code>
                            
                            <p>
                                HTTP client configuration of the control plane.
                            </p>
                        </div>
                        <div class="params-wrap">
                            <div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>requestTimeOut</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>30</code></span>
                                        </div>
                                        
                                    </div>
                                    <div class="param-description">
                                        <p>Request timeout in seconds.</p>
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


