# Integration Server Configs

All the server-level configurations of your Micro Integrator instance can be applied using a single configuration file, which is the `deployment.toml` file (stored in the `MI_HOME/conf` directory).

The complete list of configuration parameters that you can use in the `deployment.toml` file are listed below along with descriptions. You can also see the documentation on product [installation and setup](/setup/install_and_setup_overview) for details on applying product configurations to your Micro Integrator deployment.

## Instructions for use

To update the product configurations:

1. Open the `deployment.toml` file (stored in the `MI_HOME/conf` directory).
2. Select the required configuration headers and parameters from the list given below and apply them to the `deployment.toml` file.

The **default** `deployment.toml` file of the Micro Integrator is as follows:

```toml
[server]
hostname = "localhost"

[keystore.primary]
file_name = "wso2carbon.jks"
password = "wso2carbon"
alias = "wso2carbon"
key_password = "wso2carbon"

[truststore]
file_name = "client-truststore.jks"
password = "wso2carbon"
alias = "symmetric.key.value"
algorithm = "AES"
```




## Deployment

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">
            
            <input name="2" type="checkbox" id="_tab_2">
                <label class="tab-selector" for="_tab_2"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
<pre><code class="toml">[server]
hostname="localhost"
node_ip="127.0.0.1"
enable_mtom=false
enable_swa=false
</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[server]</code>
                            <span class="badge-required">Required</span>
                            <p>
                                This configuration header is required for configuring the deployment parameters that are used for identifying a Micro Integrator server node. You need to update these values when you deploy <a href="{{base_path}}/install-and-setup/setup/mi-setup/deployment/deploying_wso2_ei">WSO2 Micro Integrator</a>. The required and optional parameters for this configuration are listed below.
                            </p>
                        </div>
                        <div class="params-wrap">
                            <div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>hostname</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>&quot;localhost&quot;</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>&quot;127.0.0.1&quot;,&quot;localhost&quot;,&quot;&lt;any-ip-address&gt;&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The hostname of the Micro Integrator instance.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>offset</code> </span>
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
                                        <p>Port offset allows you to run multiple WSO2 products, multiple instances of a WSO2 product, or multiple WSO2 product clusters on the same server or virtual machine (VM). Port offset defines the number by which all ports defined in the runtime such as the HTTP/S ports will be offset. For example, if the default HTTP port is 9443 and the port offset is 1, the effective HTTP port will be 9444. Therefore, for each additional WSO2 product instance, set the port offset to a unique value so that they can all run on the same server without any port conflicts.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>enable_mtom</code> </span>
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
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>&quot;true&quot; or &quot;false&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Use this paramater to enable MTOM (Message Transmission Optimization Mechanism) for the product server.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>enable_swa</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> boolean </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>&quot;true&quot; or &quot;false&quot;</code></span>
                                        </div>
                                        
                                    </div>
                                    <div class="param-description">
                                        <p>Use this paramater to enable SwA (SOAP with Attachments) for the product server. When SwA is enabled, the Micro Integrator will process the files attached to SOAP messages.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>userAgent</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>WSO2 ${product.key} ${product.version}</code></span>
                                        </div>
                                        
                                    </div>
                                    <div class="param-description">
                                        <p></p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>serverDetails</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>WSO2 ${product.key} ${product.version}</code></span>
                                        </div>
                                        
                                    </div>
                                    <div class="param-description">
                                        <p></p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>serverDetails</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>WSO2 ${product.key} ${product.version}</code></span>
                                        </div>
                                        
                                    </div>
                                    <div class="param-description">
                                        <p></p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>synapse_config_file_path</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>repository/deployment/server/synapse-configs</code></span>
                                        </div>
                                        
                                    </div>
                                    <div class="param-description">
                                        <p></p>
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


## Service Catalog Client

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">
            
            <input name="3" type="checkbox" id="_tab_3">
                <label class="tab-selector" for="_tab_3"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
<pre><code class="toml">[[service_catalog]]
apim_host = "https://localhost:9443"
enable = true
username = "$secret{username}"
password = "$secret{password}"</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[[service_catalog]]</code>
                            <span class="badge-required">Required</span>
                            <p>
                                This cofiguration header is required if you want the Micro Integrator to publish integation services to the Service Catalog in the API Publisher. This allows you to generate an API proxy for the integrations deployed in the Micro Integrator.
                            </p>
                        </div>
                        <div class="params-wrap">
                            <div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>apim_host</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>&quot;https://127.0.0.1:9443&quot;</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>&quot;https://{hostname/ip}:{port}&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The hostname of the API Manager runtime. Be sure to replace {hostname/ip} and {port} with the relevant values.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>enable</code> </span>
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
                                        <p>The service catalog client in the Micro Integrator is enabled when this parameter is set to &#39;true&#39;.</p>
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
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The user name for signing in to the API Manager runtime.</p>
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
                                            <span class="param-default-value">Default: <code>admin</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The user password for signing in to the API Manager runtime.</p>
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


## Micro Integrator Dashboard

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">
            
            <input name="4" type="checkbox" id="_tab_4">
                <label class="tab-selector" for="_tab_4"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
<pre><code class="toml">[dashboard_config]
dashboard_url = "https://localhost:9743/dashboard/api/"
heartbeat_interval = 5
group_id = "mi_dev"
node_id = "dev_node_2"</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[dashboard_config]</code>
                            <span class="badge-required">Required</span>
                            <p>
                                This configuration header is required for the Micro Integrator server to connect with the dashboard server.
                            </p>
                        </div>
                        <div class="params-wrap">
                            <div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>dashboard_url</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>&quot;https://localhost:9743/dashboard/api/&quot;</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>https://{hostname/ip}:{port}/dashboard/api/</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The URL to access the dashboard server. Be sure to replace {hostname/ip} and {port} with the relevant values from your environment.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>heartbeat_interval</code> </span>
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
                                        <p>The time interval (in seconds) between two consecutive heartbeats that are sent from the Micro Integrator to the dashboard server.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>group_id</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>default</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The server group to which the Micro Integrator instance belongs. Specify the same group ID in all the Micro Integrator servers that should belong to a single group. By default, a &#39;group_id&#39; named &#39;default&#39; is assinged to every Micro Integrator server that connects to the dashboard. When you sign in to the dashboard, you can view data per server group.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>node_id</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>A random UUID or the node ID used for cluster coordination.</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The dashboard identifies the Micro Integrator node by this ID. If you have already specified a node ID when you set up the Micro Integrator cluster, the same node ID applies here by default. However, if a node ID is not defined in your clustering configurations, a random uuid is used here by default.</p>
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


## Primary keystore

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">
            
            <input name="5" type="checkbox" id="_tab_5">
                <label class="tab-selector" for="_tab_5"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
<pre><code class="toml">[keystore.primary]
file_name = "wso2carbon.jks"
type = "JKS"
password = "wso2carbon"
alias = "wso2carbon"
key_password = "wso2carbon"</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[keystore.primary]</code>
                            <span class="badge-required">Required</span>
                            <p>
                                This configuration header is required for configuring the parameters that connect the Micro Integrator to the <a href="{{base_path}}/install-and-setup/setup/mi-setup/security/configuring_keystores/#changing-the-default-primary-keystore">primary keystore</a>. This keystore is used for SSL handshaking (when the server communicates with another server) and for encrypting plain text information in configuration files. By default, this keystore is also used for encrypted data in internal datastores, unless you have configured a <a href="#internal-keystore">separate keystore</a> for internal data encryption.
                            </p>
                        </div>
                        <div class="params-wrap">
                            <div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>file_name</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>wso2carbon.jks</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The name of the keystore file that is used for SSL communication and for encrypting/decrypting data in configuration files.</p>
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
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>JKS</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>&quot;JKS&quot;, &quot;PKCS12&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The type of the keystore file.</p>
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
                                            <span class="param-default-value">Default: <code>wso2carbon</code></span>
                                        </div>
                                        
                                    </div>
                                    <div class="param-description">
                                        <p>The password of the keystore file that is used for SSL communication and for encrypting/decrypting data in configuration files. The keystore password is used when accessing the keys in the keystore.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>alias</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>wso2carbon</code></span>
                                        </div>
                                        
                                    </div>
                                    <div class="param-description">
                                        <p>The alias of the public key corresponding to the private key that is included in the keystore. The public key is used for encrypting data in the Micro Integrator server, which only the corresponding private key can decrypt. The public key is embedded in a digital certificate, and this certificate can be shared over the internet by storing it in a separate trust store file.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>key_password</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>wso2carbon</code></span>
                                        </div>
                                        
                                    </div>
                                    <div class="param-description">
                                        <p>The password of the private key that is included in the keystore. The private key is used to decrypt the data that has been encrypted using the keystore&#39;s public key.</p>
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


## Internal keystore

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">
            
            <input name="6" type="checkbox" id="_tab_6">
                <label class="tab-selector" for="_tab_6"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
<pre><code class="toml">[keystore.primary]
file_name = "wso2carbon.jks"
type = "JKS"
password = "wso2carbon"
alias = "wso2carbon"
key_password = "wso2carbon"</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[keystore.internal]</code>
                            <span class="badge-required">Required</span>
                            <p>
                                This configuration header is required for configuring the parameters that connect the Micro Integrator to the keystore used for encrypting/decrypting data in internal data stores. You may sometimes choose to configure a separate keystore for this purpose because the primary keystore needs to renew certificates frequently. However, for encrypting information in internal data stores, the keystore certificates should not be changed frequently because the data that is already encrypted will become unusable every time the certificate changes. Read more about <a href="{{base_path}}/install-and-setup/setup/mi-setup/security/configuring_keystores/#separating-the-internal-keystore">configuring the internal keystore</a>.
                            </p>
                        </div>
                        <div class="params-wrap">
                            <div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>file_name</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>wso2carbon.jks</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The name of the keystore file that is used for data encryption/decryption in internal data stores. By default, the keystore file of the primary keystore is enabled for this purpose.</p>
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
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>JKS</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>&quot;JKS&quot;, &quot;PKCS12&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The type of the keystore file. By default, the keystore type of the primary keystore is enabled for this purpose.</p>
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
                                            <span class="param-default-value">Default: <code>wso2carbon</code></span>
                                        </div>
                                        
                                    </div>
                                    <div class="param-description">
                                        <p>The password of the keystore file that is used for data encryption/decryption in internal data stores. This keystore password is used when accessing the keys in the keystore. By default, the keystore password of the primary keystore is enabled for this purpose.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>alias</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>wso2carbon</code></span>
                                        </div>
                                        
                                    </div>
                                    <div class="param-description">
                                        <p>The alias of the public key corresponding to the private key that is included in the keystore. The public key is used for encrypting data in the Micro Integrator server, which only the corresponding private key can decrypt. The public key is embedded in a digital certificate, and this certificate can be shared over the internet by storing it in a separate trust store file. By default, the alias of the primary keystore is enabled for this purpose.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>key_password</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>wso2carbon</code></span>
                                        </div>
                                        
                                    </div>
                                    <div class="param-description">
                                        <p>The password of the private key that is included in the keystore. The private key is used to decrypt the data that has been encrypted using the keystore&#39;s public key. By default, the public key password of the primary keystore is enabled for this purpose.</p>
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


## System Parameters

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">
            
            <input name="7" type="checkbox" id="_tab_7">
                <label class="tab-selector" for="_tab_7"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
<pre><code class="toml">[system.parameter]
org.wso2.SecureVaultPasswordRegEx = "any_valid_regex"</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[system.parameter]</code>
                            <span class="badge-required">Required</span>
                            <p>
                                This configuration header is required for configuring system parameters for the server.
                            </p>
                        </div>
                        <div class="params-wrap">
                            <div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>org.wso2.SecureVaultPasswordRegEx</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>^[\S]{5,30}$</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>regex value</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>A regex pattern that specifies the password length and character composition for passwords in a synapse configuration.</p>
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


## Truststore

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">
            
            <input name="8" type="checkbox" id="_tab_8">
                <label class="tab-selector" for="_tab_8"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
<pre><code class="toml">[truststore]
file_name="wso2truststore.jks"
type="JKS"
password="wso2carbon"
alias="symmetric.key.value"</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[truststore]</code>
                            <span class="badge-required">Required</span>
                            <p>
                                This configuration header is required for configuring the parameters that connect the Micro Integrator to the keystore file (trust store) that is used to store the digital certificates that the server trusts for SSL communication. Read more about <a href="{{base_path}}/install-and-setup/setup/mi-setup/security/configuring_keystores/#optional-changing-the-default-truststore">configuring the truststore</a>.
                            </p>
                        </div>
                        <div class="params-wrap">
                            <div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>file_name</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>wso2truststore.jks</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The name of the keystore file that is used for storing the trusted digital certificates. The product is shipped with a default trust store (wso2truststore.jks), which contains the self-signed digital certificate of the default keystore.</p>
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
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>JKS</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>&quot;JKS&quot;, &quot;PKCS12&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The type of the keystore file that is used as the trust store.</p>
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
                                            <span class="param-default-value">Default: <code>wso2carbon</code></span>
                                        </div>
                                        
                                    </div>
                                    <div class="param-description">
                                        <p>The password of the keystore file that is used as the trust store.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>alias</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>symmetric.key.value</code></span>
                                        </div>
                                        
                                    </div>
                                    <div class="param-description">
                                        <p>The alias is the password of the digital certificate (which holds the public key) that is included in the trustore.</p>
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


## Default File-based User Store

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">
            
            <input name="9" type="checkbox" id="_tab_9">
                <label class="tab-selector" for="_tab_9"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
<pre><code class="toml">[internal_apis.file_user_store]
enable = true

[[internal_apis.users]]
user.name = "user-1"
user.password = "pwd-1"

[[internal_apis.users]]
user.name = "user-2"
user.password = "pwd-2"
</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[internal_apis.file_user_store]</code>
                            <span class="badge-required">Required</span>
                            <p>
                                This configuration header is required for disabling the default file-based user store of the Micro Integrator's Management API. Read more about <a href='{{base_path}}/install-and-setup/setup/mi-setup/setup/user_stores/setting_up_a_userstore'>configuring user stores</a>.
                            </p>
                        </div>
                        <div class="params-wrap">
                            <div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>enable</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>true</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>&quot;true&quot; or &quot;false&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Set this paramter to &#39;false&#39; if you want to disable the default file-based user store. This allows you to use an external user store for user authentication in the Management API.</p>
                                    </div>
                                </div>
                            </div>
                        </div><div class="config-wrap">
                            <code>[[internal_apis.users]]</code>
                            <span class="badge-required">Required</span>
                            <p>
                                This configuration header is required for defining the user name and password for the Management API. Reuse this header when you want to add more users. The user credentials are stored in the default file-based user store of the Management API. Read more about <a href='{{base_path}}/install-and-setup/setup/mi-setup/setup/user_stores/setting_up_a_userstore'>configuring user stores</a>.
                            </p>
                        </div>
                        <div class="params-wrap">
                            <div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>user.name</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>admin</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Enter a user name. Note that this will overwrite the default &#39;admin&#39; user that is stored in the user store.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>user.password</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>admin</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Enter a password for the user specified by &#39;user.name&#39;. Note that this will overwrite the default &#39;admin&#39; password that is stored in the user store.</p>
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


## External User Store

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">
            
            <input name="10" type="checkbox" id="_tab_10">
                <label class="tab-selector" for="_tab_10"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
<pre><code class="toml">[user_store]
type = "read_only_ldap"
class = "org.wso2.micro.integrator.security.user.core.ldap.ReadOnlyLDAPUserStoreManager"
connection_url = "ldap://localhost:10389"
connection_name = "uid=admin,ou=system"
connection_password = "admin"
anonymous_bind = false
user_search_base = "ou=Users,dc=wso2,dc=org"
user_name_attribute = "uid"
user_name_search_filter = "(&(objectClass=person)(uid=?))"
user_name_list_filter = "(objectClass=person)"
read_groups = true
group_search_base = "ou=Groups,dc=wso2,dc=org"
group_name_attribute = "cn"
group_name_search_filter = "(&(objectClass=groupOfNames)(cn=?))"
group_name_list_filter = "(objectClass=groupOfNames)"
membership_attribute = "member"
back_links_enabled = false
username_java_regex = "[a-zA-Z0-9._\\-|//]{3,30}$"
rolename_java_regex = "[a-zA-Z0-9._\\-|//]{3,30}$"
password_java_regex = "^[\\S]{5,30}$"
scim_enabled = false
password_hash_method = "PLAIN_TEXT"
multi_attribute_separator = ","
max_user_name_list_length = 100
max_role_name_list_length = 100
user_roles_cache_enabled = true
connection_pooling_enabled = true
ldap_connection_timeout = 5000
read_timeout = ''
retry_attempts = ''
connection_retry_delay = "120000"
</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[user_store]</code>
                            <span class="badge-required">Required</span>
                            <p>
                                This configuration header is required for conencting the Micro Integrator to an <a href='{{base_path}}/install-and-setup/setup/mi-setup/setup/user_stores/setting_up_a_userstore'>external user store</a>.
                            </p>
                        </div>
                        <div class="params-wrap">
                            <div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>type</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>&quot;read_only_ldap&quot;</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>&quot;read_only_ldap&quot;, &quot;read_write_ldap&quot;, &quot;database&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>This parameter specifies the type of user store. The following options are available: &lt;ul&gt;&lt;li&gt;read_only_ldap: The Micro Integrator connects to a read-only LDAP. &lt;/li&gt;&lt;li&gt;read_write_ldap: The Micro Integrator connects to an LDAP with write permissions.&lt;/li&gt;&lt;li&gt;database: The Micro Integrator connects to an RDBMS user store.&lt;/li&gt;&lt;/ul&gt; When you set this parameter, all of the remaining parameters (listed below) are inferred with default values. You can override the defaults by giving specific values to these parameters.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>class</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>org.wso2.micro.integrator.security.user.core.ldap.ReadOnlyLDAPUserStoreManager</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The implementation class that enables the read-only LDAP user store. If the type parameter is not used, you need to specify a value for this parameter.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>read_only</code> </span>
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
                                            <span class="param-possible-values">Possible Values: <code>&quot;true&quot; or &quot;false&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Specifies whether or not the user store is read only.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>connection_url</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>ldap://localhost:10389</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The URL for connecting to the LDAP. Override the default URL for your setup. If you are connecting over ldaps (secured LDAP), you need to import the certificate of the user store to the truststore (wso2truststore.jks by default). See the instructions on how to &lt;a href=&#39;{{base_path}}/install-and-setup/setup/mi-setup/setup/security/importing_ssl_certificate&#39;&gt;add certificates to the truststore&lt;/a&gt;.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>connection_name</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>uid=admin,ou=system</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The username used to connect to the user store and perform various operations. This user does not need to be an administrator in the user store. However, the user requires permission to read the user list and user attributes, and to perform search operations on the user store. The value you specify is used as the DN (Distinguish Name) attribute of the user who has sufficient permissions to perform operations on users and roles in LDAP.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>connection_password</code> </span>
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
                                        <p>Password for the connection user name.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>user_search_base</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>ou=system</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The DN of the context or object under which the user entries are stored in the user store. When the user store searches for users, it will start from this location of the directory.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>user_name_attribute</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>uid</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The attribute used for uniquely identifying a user entry. Users can be authenticated using their email address, UID, etc. The name of the attribute is considered as the username. Note that the email address is considered as a special case in WSO2 products. Read more about using the email address as user name.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>user_name_search_filter</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>(&amp;amp;(objectClass=person)(uid=?))</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Filtering criteria used to search for a particular user entry.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>user_name_list_filter</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>(objectClass=person)</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Filtering criteria for searching user entries in the user store. This query or filter is used when doing search operations on users with different search attributes. According to the default configuration, the search operation only provides the objects created from the person object class.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>read_groups</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> boolean </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>true</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>&quot;true&quot; or &quot;false&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>This indicates whether groups should be read from the user store. If this is set to &#39;false&#39;, none of the groups in the user store can be read, and the following group configurations are NOT mandatory: &#39;group_search_base&#39;, &#39;group_name_list_filter&#39;, or &#39;group_name_attribute&#39;.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>group_search_base</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>ou=system</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The DN of the context or object under which the group entries are stored in the user store. When the user store searches for groups, it will start from this location of the directory.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>group_name_attribute</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>cn</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The attribute used for uniquely identifying a group entry. This attribute is to be treated as the group name.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>group_name_search_filter</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>(&amp;amp;(objectClass=groupOfNames)(cn=?))</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The filtering criteria used to search for a particular group entry.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>group_name_list_filter</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>(objectClass=groupOfNames)</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The filtering criteria for searching group entries in the user store. This query or filter is used when doing search operations on groups with different search attributes.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>membership_attribute</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>member</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Defines the attribute that contains the distinguished names (DN) of user objects that are in a group.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>back_links_enabled</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>member</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Defines whether the backlink support is enabled.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>username_java_regex</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>[a-zA-Z0-9._\-|//]{3,30}$</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The regular expression used by the back-end components for username validation. By default, a length of 3 to 30 allowed for strings with non-empty characters. You can provide ranges of alphabets, numbers, and also ranges of ASCII values in the RegEx properties.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>rolename_java_regex</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>[a-zA-Z0-9._\-|//]{3,30}$</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The regular expression used by the back-end components for role name validation. By default, a length of 3 to 30 allowed for strings with non-empty characters. You can provide ranges of alphabets, numbers, and also ranges of ASCII values in the RegEx properties.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>password_java_regex</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>^[\S]{5,30}$</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The regular expression used by the back-end components for password validation. By default, a length of 3 to 30 allowed for strings with non-empty characters. You can provide ranges of alphabets, numbers, and also ranges of ASCII values in the RegEx properties.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>scim_enabled</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> boolean </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>true</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>&quot;true&quot; or &quot;false&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The regular expression used by the back-end components for password validation. By default, a length of 3 to 30 allowed for strings with non-empty characters. You can provide ranges of alphabets, numbers, and also ranges of ASCII values in the RegEx properties.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>password_hash_method</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>PLAIN_TEXT</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>&quot;SHA&quot;, &quot;MD5&quot;, &quot;PLAIN_TEXT&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Specifies the password hashing algorithm used for hashing the password before storing in the user store. You can use the SHA digest method (SHA-1, SHA-256), the MD 5 digest method, or plain text passwords.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>multi_attribute_separator</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>,</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>This parameter is used to define a character to separate multiple attributes. This ensures that it will not appear as part of a claim value. Normally &#39;,&#39; is used to separate multiple attributes, but you can define &#39;,,,&#39;, &#39;...&#39;, or a similar character sequence.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>max_user_name_list_length</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>100</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Controls the number of users listed in the user store. This is useful when you have a large number of users and you don&#39;t want to list them all. Setting this property to 0 displays all users. In some user stores, there are policies to limit the number of records that can be returned from the query. Setting the value to 0 will list the maximum results returned by the user store. To increase that value, you need to set it at the user store level. Active directory has the &#39;MaxPageSize&#39; property with the default value set to 1000.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>max_role_name_list_length</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>100</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Controls the number of roles listed in the user store. This is useful when you have a large number of roles and you don&#39;t want to list them all. Setting this property to 0 displays all roles. In some user stores, there are policies to limit the number of records that can be returned from the query. Setting the value to 0 will list the maximum results returned by the user store. To increase that value, you need to set it at the user store level. Active directory has the &#39;MaxPageSize&#39; property with the default value set to 1000.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>user_roles_cache_enabled</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> boolean </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>true</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>&quot;true&quot; or &quot;false&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>This parameter indicates whether the list of roles for a user should be cached. Set this to &#39;false&#39; if the user roles are changed by external means and the changes should be instantly reflected in the product instance.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>connection_pooling_enabled</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> boolean </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>true</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>&quot;true&quot; or &quot;false&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Define whether LDAP connection pooling is enabled. The connection performance will improve when this parameter is enabled.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>ldap_connection_timeout</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>5000</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>This is the connection timeout period (in milliseconds) when the initial connection is created.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>read_timeout</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The value for this parameter is the read timeout in milliseconds for LDAP operations. If the LDAP provider cannot get an LDAP response within that period, it aborts the read attempt. The integer should be greater than zero. An integer less than or equal to zero means no read timeout is specified, which is equivalent to waiting for the response infinitely until it is received.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>retry_attempts</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Retry the authentication request if a timeout happened.</p>
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


## Database Connection

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">
            
            <input name="11" type="checkbox" id="_tab_11">
                <label class="tab-selector" for="_tab_11"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
<pre><code class="toml">[[datasource]]
id = "WSO2_CARBON_DB"
url= "jdbc:h2:./repository/database/WSO2CARBON_DB;DB_CLOSE_ON_EXIT=FALSE;LOCK_TIMEOUT=60000"
username="username"
password="password"
driver="org.h2.Driver"
pool_options.maxActive=50
pool_options.maxWait = 60000
pool_options.testOnBorrow = true</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[[datasource]]</code>
                            <span class="badge-required">Required</span>
                            <p>
                                This configuration header is required for connecting to a database from the Micro Integrator. Databases are only required if you are connecting the Micro Integrator to an <a href='{{base_path}}/install-and-setup/setup/mi-setup/setup/user_stores/setting_up_ro_ldap/#configuring-an-rdbms-user-store-optional'>RDBMS user store</a>.
                            </p>
                        </div>
                        <div class="params-wrap">
                            <div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>id</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The name of the database.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>url</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The connection URL for your database. Note that the URL depends on the type of database you use.</p>
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
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The user name for connecting to the database.</p>
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
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The password for connecting to the database.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>driver</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The driver class of your database.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>pool_options.maxActive</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>50</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The maximum number of active connections that can be allocated from this pool at the same time. If you set this value too low, the response times for some requests might slow down as they have to wait for connections to get free. A value too high might cause too much memory/resource utilization and the system may slow down or be unresponsive.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>pool_options.maxWait</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>60000</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Maximum number of milliseconds that the pool waits (when there are no available connections) for a connection to be returned before throwing an exception.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>pool_options.testOnBorrow</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> boolean </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>true</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>&quot;true&quot; or &quot;false&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Used to indicate if objects will be validated before being borrowed from the pool. If the object fails to validate, it will be dropped from the pool, and we will attempt to borrow another one.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>pool_options.maxIdle</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>8</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The maximum number of connections that can remain idle in the pool, without extra ones being released. Default value is 8. Put a negative value for unlimited. Idle connections are checked periodically (if enabled) and connections that have been idle for longer than minEvictableIdleTimeMillis will be released.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>pool_options.minIdle</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>0</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The minimum number of connections that can remain idle in the pool, without extra ones being created. The connection pool can shrink below this number if validation queries fail. Default value is 0.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>pool_options.validationInterval</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>30000</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>This parameter controls how frequently a given validation query is executed (time in milliseconds). The default value is 30000 (30 seconds). That is, if a connection is due for validation, but has been validated previously within this interval, it will not be validated again.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>pool_options.validationQuery</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>Null</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The SQL query used to validate connections from this pool before returning them to the caller. If specified, this query does not have to return any data, it just can&#39;t throw an SQLException. The default value is null. Example values are SELECT 1(mysql), select 1 from dual(oracle), SELECT 1(MS Sql Server).</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>pool_options.MaxPermSize</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The memory size allocated for WSO2 Micro Integrator.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>pool_options.removeAbandoned</code> </span>
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
                                            <span class="param-possible-values">Possible Values: <code>&quot;true&quot; or &quot;false&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>If this property is set to &#39;true&#39;, a connection is considered abandoned and eligible for removal if it has been in use for longer than the removeAbandonedTimeout value explained below.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>pool_options.removeAbandonedTimeout</code> </span>
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
                                            <span class="param-possible-values">Possible Values: <code>&quot;true&quot; or &quot;false&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The time in seconds that should pass before a connection that is in use can be removed. This is the time period after which the connection will be declared abandoned. This value should be set to the longest running query that the applications might have.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>pool_options.logAbandoned</code> </span>
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
                                            <span class="param-possible-values">Possible Values: <code>&quot;true&quot; or &quot;false&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Set this property to &#39;true&#39; if you wish to log when the connection was abandoned. If this option is set to &#39;true&#39;, a stack trace is recorded during the dataSource.getConnection call and is printed when a connection is not returned.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>pool_options.initialSize</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>0</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The initial number of connections created when the pool is started. Default value is 0.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>pool_options.defaultTransactionIsolation</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>TRANSACTION_NONE</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>&quot;TRANSACTION_NONE&quot;, &quot;TRANSACTION_UNKNOWN&quot;, &quot;TRANSACTION_READ_COMMITTED&quot;, &quot;TRANSACTION_READ_UNCOMMITTED&quot;, &quot;TRANSACTION_REPEATABLE_READ&quot;, &quot;TRANSACTION_SERIALIZABLE&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The default TransactionIsolation state of connections created by this pool.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>pool_options.validationQueryTimeout</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-1</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The timeout in seconds before a connection validation queries fail. This works by calling java.sql.Statement.setQueryTimeout(seconds) on the statement that executes the validationQuery . The pool itself doesn&#39;t timeout the query. It is still up to the JDBC driver to enforce query timeouts. A value less than or equal to zero will disable this feature. The default value is -1.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>pool_options.timeBetweenEvictionRunsMillis</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>5000</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The number of milliseconds to sleep between runs of the idle connection validation/cleaner thread. This value should not be set under 1 second. It dictates how often we check for idle, abandoned connections, and how often we validate idle connections. The default value is 5000 (5 seconds).</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>pool_options.numTestsPerEvictionRun</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The number of objects to examine during each run of the idle object evictor thread.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>pool_options.minEvictableIdleTimeMillis</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>60000</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The minimum amount of time an object may sit idle in the pool before it is eligible for eviction. The default value is 60000 (60 seconds).</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>pool_options.defaultCatalog</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The default catalog of connections created by this pool.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>pool_options.validatorClassName</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The name of a class that implements the org.apache.tomcat.jdbc.pool.Validator interface and provides a no-arg constructor (may be implicit). If specified, the class will be used to create a Validator instance, which is then used instead of any validation query to validate connections. The default value is null. An example value is com.mycompany.project.SimpleValidator.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>pool_options.connectionProperties</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>Null</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The connection properties that will be sent to our JDBC driver when establishing new connections. Format of the string must be [propertyName=property;]* NOTE - The &#39;user&#39; and &#39;password&#39; properties will be passed explicitly, so they do not need to be included here. The default value is null.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>pool_options.initSQL</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The ability to run a SQL statement exactly once, when the connection is created.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>pool_options.jdbcInterceptors</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Flexible and pluggable interceptors to create any customizations around the pool, the query execution and the result set handling.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>pool_options.abandonWhenPercentageFull</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>0</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Connections that have been abandoned (timed out) wont get closed and reported up unless the number of connections in use are above the percentage defined by abandonWhenPercentageFull. The value should be between 0-100. The default value is 0, which implies that connections are eligible for closure as soon as removeAbandonedTimeout has been reached.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>pool_options.maxAge</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>0</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Time in milliseconds to keep this connection. When a connection is returned to the pool, the pool will check to see if the now - time-when-connected &gt; maxAge has been reached, and if so, it closes the connection rather than returning it to the pool. The default value is 0, which implies that connections will be left open and no age check will be done upon returning the connection to the pool.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>pool_options.suspectTimeout</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>0</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Timeout value in seconds. Default value is 0. Similar to to the removeAbandonedTimeout value but instead of treating the connection as abandoned, and potentially closing the connection, this simply logs the warning if logAbandoned is set to true. If this value is equal or less than 0, no suspect checking will be performed. Suspect checking only takes place if the timeout value is larger than 0 and the connection was not abandoned or if abandon check is disabled. If a connection is suspect a WARN message gets logged and a JMX notification gets sent once.</p>
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


## Management API - JWT Handler

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">
            
            <input name="12" type="checkbox" id="_tab_12">
                <label class="tab-selector" for="_tab_12"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
<pre><code class="toml">[management_api.jwt_token_security_handler]
enable = true
token_store_config.max_size= "200"
token_store_config.clean_up_interval= "600"
token_store_config.remove_oldest_token_on_overflow= "true"
token_config.expiry= "3600"
token_config.size= "2048"
</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[management_api.jwt_token_security_handler]</code>
                            <span class="badge-required">Required</span>
                            <p>
                                This configuration header is required for configuring the default JWT token store configurations of the Micro Integrator's Management API. Read more about <a href='{{base_path}}/install-and-setup/setup/mi-setup/security/securing_management_api'>securing the Management API</a>.
                            </p>
                        </div>
                        <div class="params-wrap">
                            <div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>enable</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> boolean </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>true</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>&quot;true&quot; or &quot;false&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Set this paramter to &#39;false&#39; if you want to disable JWT authentication for the management API.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>token_store_config.max_size</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>200</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Number of tokens stored in the in-memory token store. User can increase or decrease this value accordingly.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>token_store_config.clean_up_interval</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>600</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Token cleanup will be handled through a seperate thread and the frequency of the token clean up can be configured from this setting. This will clean all the expired and revoked security tokens. The thread will run only when there are tokens in the store. If it is empty, the cleanup thread will automatically stop. Interval is specified in seconds.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>token_store_config.remove_oldest_token_on_overflow</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> boolean </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>true</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>&quot;true&quot; or &quot;false&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>If set to &#39;true&#39;, this will remove the oldest accessed token when the token store is full. If it is set to &#39;false&#39;, the user should either wait until other tokens expire or increase the token store max size accordingly.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>token_config.expiry</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>3600</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>This configures the expiry time of the token (specified in seconds).</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>token_config.size</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>2048</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Specifies the key size of the token.</p>
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


## Management API - Authorization Handler

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">
            
            <input name="13" type="checkbox" id="_tab_13">
                <label class="tab-selector" for="_tab_13"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
<pre><code class="toml">[management_api.authorization_handler]
enable = false

[[management_api.authorization_handler.resources]]
path = "/users"

[[management_api.authorization_handler.resources]]
path = "/apis"
</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[management_api.authorization_handler]</code>
                            <span class="badge-required">Required</span>
                            <p>
                                This configuration header is required for disabling authorization for the Micro Integrator's Management API. Authorization only applies when an external user store is used. Read more about <a href='{{base_path}}/install-and-setup/setup/mi-setup/security/securing_management_api'>securing the Management API</a>.
                            </p>
                        </div>
                        <div class="params-wrap">
                            <div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>enable</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> boolean </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>true</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>&quot;true&quot; or &quot;false&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Set this paramter to &#39;false&#39; if you want to disable authorization for the management API.</p>
                                    </div>
                                </div>
                            </div>
                        </div><div class="config-wrap">
                            <code>[[management_api.authorization_handler.resources]]</code>
                            <span class="badge-required">Required</span>
                            <p>
                                This configuration header is required for enabling authorization for additional resources (other than 'users') of the Micro Integrator's Management API. Read more about <a href='{{base_path}}/install-and-setup/setup/mi-setup/security/securing_management_api'>securing the Management API</a>.
                            </p>
                        </div>
                        <div class="params-wrap">
                            <div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>path</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code></code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>/resource_name</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Use this parameter to specify the resources in the management API for which you want to enable authorization.</p>
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


## Management API - CORS

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">
            
            <input name="14" type="checkbox" id="_tab_14">
                <label class="tab-selector" for="_tab_14"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
<pre><code class="toml">[management_api.cors]
enabled = true
allowed_origins = "*"
allowed_headers = "Authorization"</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[[management_api.cors]]</code>
                            <span class="badge-required">Required</span>
                            <p>
                                This configuration header is required for configuring CORs for the Management API of the Micro Integrator. Read more about <a href='{{base_path}}/install-and-setup/setup/mi-setup/security/securing_management_api'>securing the Management API</a>.
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
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>true</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Set this paramter to &#39;false&#39; if you want to disable CORs for the Management API.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>allowed_origins</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>*</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>&quot;true&quot; or &quot;false&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Specify the allowed origins. By default &#39;*&#39; indicates that all origins are allowed.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>allowed_headers</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>Authorization</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Specify the allowed authorization headers.</p>
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


## Message Builders (non-blocking mode)

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">
            
            <input name="15" type="checkbox" id="_tab_15">
                <label class="tab-selector" for="_tab_15"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
<pre><code class="toml">[message_builders]
application_xml = "org.apache.axis2.builder.ApplicationXMLBuilder"
form_urlencoded = "org.apache.synapse.commons.builders.XFormURLEncodedBuilder"
multipart_form_data = "org.apache.axis2.builder.MultipartFormDataBuilder"
text_plain = "org.apache.axis2.format.PlainTextBuilder"
application_json = "org.wso2.micro.integrator.core.json.JsonStreamBuilder"
json_badgerfish = "org.apache.axis2.json.JSONBadgerfishOMBuilder"
text_javascript = "org.apache.axis2.json.JSONBuilder"
octet_stream =  "org.wso2.carbon.relay.BinaryRelayBuilder"
application_binary = "org.apache.axis2.format.BinaryBuilder"</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[message_builders]</code>
                            <span class="badge-required">Required</span>
                            <p>
                                This configuration header is required for configuring the <a href='{{base_path}}/install-and-setup/setup/mi-setup/message_builders_formatters/message-builders-and-formatters'>message builder</a> implementation that is used to build messages that are received by the Micro Integrator in the default non-blocking mode. If you are using the Micro Integrator in blocking mode, see the <a href='#message-builders-blocking-mode'>message builder configurations for blocking mode</a>.
                            </p>
                        </div>
                        <div class="params-wrap">
                            <div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>application_xml</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>org.apache.axis2.builder.ApplicationXMLBuilder</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The message builder implementation that builds messages with the &#39;application_xml&#39; content type. If required, you can change the default builder class.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>form_urlencoded</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>org.apache.synapse.commons.builders.XFormURLEncodedBuilder</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The message builder implementation that builds messages with the &#39;form_urlencoded&#39; content type. If required, you can change the default builder class.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>multipart_form_data</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>org.apache.axis2.builder.MultipartFormDataBuilder</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The message builder implementation that builds messages with the &#39;multipart_form_data&#39; content type. If required, you can change the default builder class.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>text_plain</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>org.apache.axis2.format.PlainTextBuilder</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The message builder implementation that builds messages with the &#39;text_plain&#39; content type. If required, you can change the default builder class.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>application_json</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>org.wso2.micro.integrator.core.json.JsonStreamBuilder</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The message builder implementation that builds messages with the &#39;application_json&#39; content type. If required, you can change the default builder class.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>json_badgerfish</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>org.apache.axis2.json.JSONBadgerfishOMBuilder</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The message builder implementation that builds messages with the &#39;json_badgerfish&#39; content type. If required, you can change the default builder class.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>text_javascript</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>org.apache.axis2.json.JSONBuilder</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The message builder implementation that builds messages with the &#39;text_javascript&#39; content type. If required, you can change the default builder class.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>octet_stream</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>org.wso2.carbon.relay.BinaryRelayBuilder</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The message builder implementation that builds messages with the &#39;octet_stream&#39; content type. If required, you can change the default builder class.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>application_binary</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>org.apache.axis2.format.BinaryBuilder</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The message builder implementation that builds messages with the &#39;application_binary&#39; content type. If required, you can change the default builder class.</p>
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


## Message Builders (blocking mode)

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">
            
            <input name="16" type="checkbox" id="_tab_16">
                <label class="tab-selector" for="_tab_16"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
<pre><code class="toml">[blocking.message_builders]
application_xml = "org.apache.axis2.builder.ApplicationXMLBuilder"
form_urlencoded = "org.apache.synapse.commons.builders.XFormURLEncodedBuilder"
multipart_form_data = "org.apache.axis2.builder.MultipartFormDataBuilder"
text_plain = "org.apache.axis2.format.PlainTextBuilder"
application_json = "org.wso2.micro.integrator.core.json.JsonStreamBuilder"
json_badgerfish = "org.apache.axis2.json.JSONBadgerfishOMBuilder"
text_javascript = "org.apache.axis2.json.JSONBuilder"
octet_stream =  "org.wso2.carbon.relay.BinaryRelayBuilder"
application_binary = "org.apache.axis2.format.BinaryBuilder"</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[blocking.message_builders]</code>
                            <span class="badge-required">Required</span>
                            <p>
                                This configuration header is required for configuring the <a href='{{base_path}}/install-and-setup/setup/mi-setup/message_builders_formatters/message-builders-and-formatters'>message builder</a> implementation that is used to build messages that are received by the Micro Integrator in <b>blocking</b> mode. You can use the <a href='#message-builders-non-blocking-mode'>same list of parameters</a> that are available for message builders in non-blocking mode.
                            </p>
                        </div>
                        <div class="params-wrap">
                            
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>


## Message Formatters (non-blocking mode)

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">
            
            <input name="17" type="checkbox" id="_tab_17">
                <label class="tab-selector" for="_tab_17"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
<pre><code class="toml">[message_formatters]
form_urlencoded =  "org.apache.synapse.commons.formatters.XFormURLEncodedFormatter"
multipart_form_data =  "org.apache.axis2.transport.http.MultipartFormDataFormatter"
application_xml = "org.apache.axis2.transport.http.ApplicationXMLFormatter"
text_xml = "org.apache.axis2.transport.http.SOAPMessageFormatter"
soap_xml = "org.apache.axis2.transport.http.SOAPMessageFormatter"
text_plain = "org.apache.axis2.format.PlainTextFormatter"
application_json =  "org.wso2.micro.integrator.core.json.JsonStreamFormatter"
json_badgerfish = "org.apache.axis2.json.JSONBadgerfishMessageFormatter"
text_javascript = "org.apache.axis2.json.JSONMessageFormatter"
octet_stream = "org.wso2.carbon.relay.ExpandingMessageFormatter"
application_binary =  "org.apache.axis2.format.BinaryFormatter"</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[message_formatters]</code>
                            <span class="badge-required">Required</span>
                            <p>
                                This configuration header is required for configuring the <a href='{{base_path}}/install-and-setup/setup/mi-setup/message_builders_formatters/message-builders-and-formatters'>message formatting</a> implementation that is used for formatting messages that are sent out of the Micro Integrator in <b>non-blocking</b> mode. If you are using the Micro Integrator in <b>blocking</b> mode, see the <a href='#message-formatter-blocking-mode'>message formatter configurations for blocking mode</a>.
                            </p>
                        </div>
                        <div class="params-wrap">
                            <div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>application_xml</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>org.apache.axis2.transport.http.ApplicationXMLFormatter</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The message formating implementation that formats messages with the &#39;application_xml&#39; content type before they are sent out of the Micro Integrator. If required, you can change the default formating class.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>form_urlencoded</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>org.apache.synapse.commons.formatters.XFormURLEncodedFormatter</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The message formating implementation that formats messages with the &#39;form_urlencoded&#39; content type before they are sent out of the Micro Integrator. If required, you can change the default formating class.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>multipart_form_data</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>org.apache.axis2.transport.http.MultipartFormDataFormatter</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The message formating implementation that formats messages with the &#39;multipart_form_data&#39; content type before they are sent out of the Micro Integrator. If required, you can change the default formating class.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>text_plain</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>org.apache.axis2.format.PlainTextFormatter</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The message formating implementation that formats messages with the &#39;text_plain&#39; content type before they are sent out of the Micro Integrator. If required, you can change the default formating class.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>application_json</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>org.wso2.micro.integrator.core.json.JsonStreamFormatter</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The message formating implementation that formats messages with the &#39;application_json&#39; content type before they are sent out of the Micro Integrator. If required, you can change the default formating class.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>json_badgerfish</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>org.apache.axis2.json.JSONBadgerfishMessageFormatter</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The message formating implementation that formats messages with the &#39;json_badgerfish&#39; content type before they are sent out of the Micro Integrator. If required, you can change the default formating class.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>text_javascript</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>org.apache.axis2.json.JSONMessageFormatter</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The message formating implementation that formats messages with the &#39;text_javascript&#39; content type before they are sent out of the Micro Integrator. If required, you can change the default formating class.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>octet_stream</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>org.wso2.carbon.relay.ExpandingMessageFormatter</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The message formatting implementation that formats messages with the &#39;octet_stream&#39; content type before they are sent out of the Micro Integrator. If required, you can change the default formating class.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>application_binary</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>org.apache.axis2.format.BinaryFormatter</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The message formating implementation that formats messages with the &#39;application_binary&#39; content type before they are sent out of the Micro Integrator. If required, you can change the default formating class.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>text_xml</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>org.apache.axis2.transport.http.SOAPMessageFormatter</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The message formating implementation that formats messages with the &#39;text_xml&#39; content type before they are sent out of the Micro Integrator. If required, you can change the default formating class.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>soap_xml</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>org.apache.axis2.transport.http.SOAPMessageFormatter</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The message formating implementation that formats messages with the &#39;soap_xml&#39; content type before they are sent out of the Micro Integrator. If required, you can change the default formating class.</p>
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


## Message Formatters (blocking mode)

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">
            
            <input name="18" type="checkbox" id="_tab_18">
                <label class="tab-selector" for="_tab_18"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
<pre><code class="toml">[blocking.message_formatters]
form_urlencoded =  "org.apache.synapse.commons.formatters.XFormURLEncodedFormatter"
multipart_form_data =  "org.apache.axis2.transport.http.MultipartFormDataFormatter"
application_xml = "org.apache.axis2.transport.http.ApplicationXMLFormatter"
text_xml = "org.apache.axis2.transport.http.SOAPMessageFormatter"
soap_xml = "org.apache.axis2.transport.http.SOAPMessageFormatter"
text_plain = "org.apache.axis2.format.PlainTextFormatter"
application_json =  "org.wso2.micro.integrator.core.json.JsonStreamFormatter"
json_badgerfish = "org.apache.axis2.json.JSONBadgerfishMessageFormatter"
text_javascript = "org.apache.axis2.json.JSONMessageFormatter"
octet_stream = "org.wso2.carbon.relay.ExpandingMessageFormatter"
application_binary =  "org.apache.axis2.format.BinaryFormatter"</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[blocking.message_formatters]</code>
                            <span class="badge-required">Required</span>
                            <p>
                                This configuration header is required for configuring the <a href='{{base_path}}/install-and-setup/setup/mi-setup/message_builders_formatters/message-builders-and-formatters'>message formatter</a> implementations that are used to format messages that are sent out from the Micro Integrator in <b>blocking</b> mode. You can use the <a href='#message-formatters-non-blocking-mode'>same list of parameters</a> that are available for message formatters in non-blocking mode.
                            </p>
                        </div>
                        <div class="params-wrap">
                            
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>


## Custom Message Builders (non-blocking mode)

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">
            
            <input name="19" type="checkbox" id="_tab_19">
                <label class="tab-selector" for="_tab_19"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
<pre><code class="toml">[[custom_message_builders]]
content_type = "application/json/badgerfish"
class = "org.apache.axis2.json.JSONBadgerfishOMBuilder"</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[[custom_message_builders]]</code>
                            <span class="badge-required">Required</span>
                            <p>
                                This configuration header is required for configuring the custom message builder implementation class and the selected content types to which the builder should apply <b>in non-blocking mode</b>. See the instructions on configuring <a href='{{base_path}}/install-and-setup/setup/mi-setup/message_builders_formatters/message-builders-and-formatters'>custom message builders and formatters</a>.
                            </p>
                        </div>
                        <div class="params-wrap">
                            <div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>content_type</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The content types to which the custom message builder implementation should apply. You can specify the list of content types as follows: application/json/badgerfish.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>class</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The custom message builder implementation that should apply to the given content types.</p>
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


## Custom Message Builders (blocking mode)

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">
            
            <input name="20" type="checkbox" id="_tab_20">
                <label class="tab-selector" for="_tab_20"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
<pre><code class="toml">[[blocking.custom_message_builders]]
content_type = "application/json/badgerfish"
class = "org.apache.axis2.json.JSONBadgerfishOMBuilder"</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[[blocking.custom_message_builders]]</code>
                            <span class="badge-required">Required</span>
                            <p>
                                This configuration header is required for configuring the custom message builder implementation class and the selected content types to which the builder should apply <b>in blocking mode</b>. See the instructions on configuring <a href='{{base_path}}/install-and-setup/setup/mi-setup/message_builders_formatters/message-builders-and-formatters'>custom message builders and formatters</a>. You can use the <a href='#custom-message-builder-non-blocking-mode'>same list of parameters</a> that are available for custom message builders in non-blocking mode.
                            </p>
                        </div>
                        <div class="params-wrap">
                            
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>


## Custom Message Formatters (non-blocking mode)

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">
            
            <input name="21" type="checkbox" id="_tab_21">
                <label class="tab-selector" for="_tab_21"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
<pre><code class="toml">[[custom_message_formatters]]
content_type = "application/json/badgerfish"
class = "org.apache.axis2.json.JSONBadgerfishMessageFormatter"</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[[custom_message_formatters]]</code>
                            <span class="badge-required">Required</span>
                            <p>
                                This configuration header is required for configuring the custom message formatter implementation class and the selected content types to which the formatter should apply <b>in non-blocking mode</b>. See the instructions on configuring <a href='{{base_path}}/install-and-setup/setup/mi-setup/message_builders_formatters/message-builders-and-formatters'>custom message builders and formatters</a>.
                            </p>
                        </div>
                        <div class="params-wrap">
                            <div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>content_type</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The content types to which the custom message formatter implementation should apply. You can specify the list of content types as follows: application/json/badgerfish.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>class</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The custom message formatter implementation that should apply to the given content types.</p>
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


## Custom Message Formatters (blocking mode)

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">
            
            <input name="22" type="checkbox" id="_tab_22">
                <label class="tab-selector" for="_tab_22"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
<pre><code class="toml">[[blocking.custom_message_formatters]]
content_type = "application/json/badgerfish"
class = "org.apache.axis2.json.JSONBadgerfishMessageFormatter"</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[[blocking.custom_message_formatters]]</code>
                            <span class="badge-required">Required</span>
                            <p>
                                This configuration header is required for configuring the custom message formatter implementation class and the selected content types to which the formatter should apply <b>in blocking mode</b>. See the instructions on configuring <a href='{{base_path}}/install-and-setup/setup/mi-setup/message_builders_formatters/message-builders-and-formatters'>custom message builders and formatters</a>. You can use the <a href='#custom-message-formatter-non-blocking-mode'>same list of parameters</a> that are available for custom message formatters in non-blocking mode.
                            </p>
                        </div>
                        <div class="params-wrap">
                            
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>


## Server Request Processor

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">
            
            <input name="23" type="checkbox" id="_tab_23">
                <label class="tab-selector" for="_tab_23"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
<pre><code class="toml">[[server.get_request_processor]]
item = "swagger.yaml"
class = "org.wso2.micro.integrator.transport.handlers.requestprocessors.swagger.format.SwaggerYamlProcessor"

[[server.get_request_processor]]
item = "swagger.json"
class = "org.wso2.micro.integrator.transport.handlers.requestprocessors.swagger.format.SwaggerJsonProcessor"</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[[server.get_request_processor]]</code>
                            <span class="badge-required">Required</span>
                            <p>
                                This configuration header is required for configuring the parameters that specify how special HTTP GET requests (such as '?wsdl', '?policy', etc.) are processed. This is an array-type header, which you can reuse depending on the number of processors you want to enable.
                            </p>
                        </div>
                        <div class="params-wrap">
                            <div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>item</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>&quot;swagger.yaml&quot; and &quot;swagger.json&quot;</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The item repesents the first parameter in the query string (e.g. ?wsdl), which needs special processing.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>class</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>&quot;org.wso2.micro.integrator.transport.handlers.requestprocessors.swagger.format.SwaggerYamlProcessor&quot; and &quot;org.wso2.micro.integrator.transport.handlers.requestprocessors.swagger.format.SwaggerYamlProcessor&quot;</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>This is the class that implements the org.wso2.carbon.transport.HttpGetRequestProcessor processor. By default, the following two classes are used for handling the two default request items: org.wso2.micro.integrator.transport.handlers.requestprocessors.swagger.format.SwaggerYamlProcessor (for swagger.yaml) and org.wso2.micro.integrator.transport.handlers.requestprocessors.swagger.format.SwaggerYamlProcessor (for swagger.json).</p>
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


## HTTP/S transport (non-blocking mode)

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">
            
            <input name="24" type="checkbox" id="_tab_24">
                <label class="tab-selector" for="_tab_24"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
<pre><code class="toml">[transport.http]
socket_timeout = "3m"
core_worker_pool_size = 400
max_worker_pool_size = 400
worker_pool_queue_length = -1
io_buffer_size = 16384
max_http_connection_per_host_port = 32767
preserve_http_user_agent = false
preserve_http_server_name = true
preserve_http_headers = ["Content-Type"]
disable_connection_keepalive = false
enable_message_size_validation = false
max_message_size_bytes = 81920
max_open_connections = -1
force_xml_validation = false
force_json_validation = false
listener.port = 8280    #inferred  default: 8280
listener.wsdl_epr_prefix ="$ref{server.hostname}"
listener.bind_address = "$ref{server.hostname}"
listener.secured_port = 8243
listener.secured_wsdl_epr_prefix = "$ref{server.hostname}"
listener.secured_bind_address = "$ref{server.hostname}"
listener.secured_protocols = "TLSv1,TLSv1.1,TLSv1.2"
listener.verify_client = "require"
listener.ssl_profile.file_path = "conf/sslprofiles/listenerprofiles.xml"
listener.ssl_profile.read_interval = "1h"
listener.preferred_ciphers = "TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA256,TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256,TLS_DHE_RSA_WITH_AES_128_CBC_SHA256,TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA,TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA,TLS_DHE_RSA_WITH_AES_128_CBC_SHA,TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256,TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256,TLS_DHE_RSA_WITH_AES_128_GCM_SHA256"
listener.keystore.file_name ="$ref{keystore.tls.file_name}"
listener.keystore.type = "$ref{keystore.tls.type}"
listener.keystore.password = "$ref{keystore.tls.password}"
listener.keystore.key_password = "$ref{keystore.tls.key_password}"
listener.truststore.file_name = "$ref{truststore.file_name}"
listener.truststore.type = "$ref{truststore.type}"
listener.truststore.password = "$ref{truststore.password}"
sender.warn_on_http_500 = "*"
sender.proxy_host = "$ref{server.hostname}"
sender.proxy_port = 3128
sender.non_proxy_hosts = ["$ref{server.hostname}"]
sender.hostname_verifier = "AllowAll"
sender.keystore.file_name ="$ref{keystore.tls.file_name}"
sender.keystore.type = "$ref{keystore.tls.type}"
sender.keystore.password = "$ref{keystore.tls.password}"
sender.keystore.key_password = "$ref{keystore.tls.key_password}"
sender.truststore.file_name = "$ref{truststore.file_name}"
sender.truststore.type = "$ref{truststore.type}"
sender.truststore.password = "$ref{truststore.password}"
sender.ssl_profile.file_path = "conf/sslprofiles/senderprofiles.xml"
sender.ssl_profile.read_interval = "30s"
enable_message_size_validation = false
max_message_size_bytes = 2147483647
max_open_connections = -1
force_xml_validation = false
force_json_validation = false</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[transport.http]</code>
                            <span class="badge-required">Required</span>
                            <p>
                                This configuration header is required for configuring the parameters that are used for <a href='{{base_path}}/install-and-setup/setup/mi-setup/performance_tuning/http_transport_tuning'>tuning the default HTTP/S passthrough transport</a> of the Micro Integrator in non-blocking mode.
                            </p>
                        </div>
                        <div class="params-wrap">
                            <div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>socket_timeout</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>180000</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>This is the maximum period of inactivity between two consecutive data packets, specified in milliseconds.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>core_worker_pool_size</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>400</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The Micro Integrator uses a thread pool executor to create threads and to handle incoming requests. This parameter controls the number of core threads used by the executor pool. If you increase this parameter value, the number of requests received that can be processed by the integrator increases, hence, the throughput also increases. The nature of the integration scenario and the number of concurrent requests received by the integrator are the main factors that helps to determine this parameter.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>max_worker_pool_size</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>400</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>This is the maximum number of threads in the worker thread pool. Specifying a maximum limit avoids performance degradation that can occur due to context switching. If the specified value is reached, you will see the error &#39;SYSTEM ALERT - HttpServerWorker threads were in BLOCKED state during last minute&#39;. This can occur due to an extraordinarily high number of requests sent at a time when all the threads in the pool are busy, and the maximum number of threads is already reached.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>worker_pool_queue_length</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-1</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>This defines the length of the queue that is used to hold runnable tasks to be executed by the worker pool. The thread pool starts queuing jobs when all the existing threads are busy, and the pool has reached the maximum number of threads. The value for this parameter should be -1 to use an unbound queue. If a bound queue is used and the queue gets filled to its capacity, any further attempts to submit jobs fail causing some messages to be dropped by Synapse.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>io_buffer_size</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>16384</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>This is the value of the memory buffer allocated when reading data into the memory from the underlying socket/file channels. You should leave this property set to the default value.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>max_http_connection_per_host_port</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>32767</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>This defines the maximum number of connections allowed per host port.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>preserve_http_user_agent</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> boolean </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>&quot;true&quot; or &quot;false&quot;</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>If this parameter is set to true, the user-agent HTTP header of messages passing through the integrator is preserved and printed in the outgoing message.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>preserve_http_headers</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>Content-Type</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>This parameter allows you to specify the header field/s of messages passing through the EI that need to be preserved and printed in the outgoing message such as Location, CommonsHTTPTransportSenderKeep-Alive, Date, Server, User-Agent, and Host. For example, http.headers.preserve = Location, Date, Server.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>disable_connection_keepalive</code> </span>
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
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>&quot;true&quot; or &quot;false&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>If this parameter is set to true, the HTTP connections with the back end service are closed soon after the request is served. It is recommended to set this property to false so that the integrator does not have to create a new connection every time it sends a request to a back-end service. However, you may need to close connections after they are used if the back-end service does not provide sufficient support for keep-alive connections.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>listener.port</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>8290</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The port on which this transport receiver should listen for incoming messages.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>listener.wsdl_epr_prefix</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>A URL prefix which will be added to all service EPRs and EPRs in WSDLs etc.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>listener.secured_port</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>8253</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The secured port on which this transport receiver should listen for incoming messages.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>listener.keystore.file_name</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>MI_HOME/repository/resources/security/wso2carbon.jks</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The path to the keystore file that is used for securing the HTTP passthrough connection. By default, the keystore file of the primary keystore is enabled for this purpose.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>listener.keystore.type</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>JKS</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>&quot;JKS&quot; or &quot;PKCS12&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The type of the keystore file. By default, the keystore type of the primary keystore is enabled for this purpose.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>listener.keystore.password</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>wso2carbon</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The password of the keystore file that is used for securing the HTTP passthrough connection. This keystore password is used when accessing the keys in the keystore. By default, the keystore password of the primary keystore is enabled for this purpose.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>listener.keystore.key_password</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>wso2carbon</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The password of the private key that is used for securing the HTTP passthrough connection. This keystore password is used when accessing the keys in the keystore. By default, the keystore password of the primary keystore is enabled for this purpose.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>listener.truststore.file_name</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>MI_HOME/repository/resources/security/wso2truststore.jks</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The path to the keystore file that is used for storing the trusted digital certificates. By default, the product&#39;s trust store is configured for this purpose.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>listener.truststore.type</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>JKS</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>&quot;JKS&quot; or &quot;PKCS12&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The type of the keystore file that is used as the trust store. By default, the product&#39;s trust store is configured for this purpose.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>listener.truststore.password</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>wso2carbon</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The password of the keystore file that is used as the trust store. By default, the product&#39;s trust store is configured for this purpose.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>sender.warn_on_http_500</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>If the outgoing messages should be sent through an HTTP proxy server, use this parameter to specify the target proxy.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>sender.proxy_host</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>If the outgoing messages should be sent through an HTTP proxy server, use this parameter to specify the target proxy.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>sender.proxy_port</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The port through which the target proxy (specified by the &#39;sender.proxy_port&#39; parameter) accepts HTTP traffic.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>sender.secured_proxy_host</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>If the outgoing messages should be sent through an HTTPS proxy server, use this parameter to specify the target proxy.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>sender.secured_proxy_port</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The port through which the target proxy (specified by the &#39;sender.secured_proxy_port&#39; parameter) accepts HTTPS traffic.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>sender.non_proxy_hosts</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The list of hosts to which the HTTP traffic should be sent directly without going through the proxy. When trying to add multiple hostnames along with an asterisk in order to define a set of sub-domains for non-proxy hosts, you need to add a period before the asterisk when configuring proxy server.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>sender.hostname_verifier</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The list of hosts to which the HTTP traffic should be sent directly without going through the proxy. When trying to add multiple hostnames along with an asterisk in order to define a set of sub-domains for non-proxy hosts, you need to add a period before the asterisk when configuring proxy server.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>sender.keystore.file_name</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>MI_HOME/repository/resources/security/wso2carbon.jks</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The path to the keystore file that is used for securing the HTTP passthrough connection. By default, the keystore file of the primary keystore is enabled for this purpose.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>sender.keystore.type</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>JKS</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>&quot;JKS&quot; or &quot;PKCS12&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The type of the keystore file. By default, the keystore type of the primary keystore is enabled for this purpose.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>sender.keystore.password</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>wso2carbon</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The password of the keystore file that is used for securing the HTTP passthrough connection. This keystore password is used when accessing the keys in the keystore. By default, the keystore password of the primary keystore is enabled for this purpose.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>sender.keystore.key_password</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>wso2carbon</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The password of the private key that is used for securing the HTTP passthrough connection. This keystore password is used when accessing the keys in the keystore. By default, the keystore password of the primary keystore is enabled for this purpose.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>sender.truststore.file_name</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>MI_HOME/repository/resources/security/wso2truststore.jks</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The path to the keystore file that is used for storing the trusted digital certificates. By default, the product&#39;s trust store is configured for this purpose.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>sender.truststore.type</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>JKS</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>&quot;JKS&quot; or &quot;PKCS12&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The type of the keystore file that is used as the trust store. By default, the product&#39;s trust store is configured for this purpose.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>sender.truststore.password</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>wso2carbon</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The password of the keystore file that is used as the trust store. By default, the product&#39;s trust store is configured for this purpose.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>enable_message_size_validation</code> </span>
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
                                            <span class="param-possible-values">Possible Values: <code>&quot;true&quot; or &quot;false&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>If this property is enabled and the payload exceeds the size specified by the &#39;max_message_size_bytes&#39; property, the Micro Integrator will discontinue reading the input stream. This will prevent out-of-memory issues.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>max_message_size_bytes</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>2147483647</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>If the size of the payload exceeds this value, the Micro Integrator will discontinue reading the input stream. Only applicable if the ‘enable_message_size_validation’ property is enabled.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>max_open_connections</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-1</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>This property allows connection throttling to restrict the number of simultaneously opened connections. That is, simultaneously opened incoming connections will be restricted by the specified value. To disable throttling, delete the ‘max_open_connections’ setting or set it to -1.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>force_xml_validation</code> </span>
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
                                            <span class="param-possible-values">Possible Values: <code>&quot;true&quot; or &quot;false&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>This property validates badly formed XML messages by building the whole XML document. This validation ensures that erroneous XML messages will trigger the fault sequence in the Micro Integrator.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>force_json_validation</code> </span>
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
                                            <span class="param-possible-values">Possible Values: <code>&quot;true&quot; or &quot;false&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>This property validates JSON messages by parsing the input message. This validation ensures that erroneous JSON messages will trigger the fault sequence in the Micro Integrator.</p>
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


## HTTP/S Transport (blocking mode)

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">
            
            <input name="25" type="checkbox" id="_tab_25">
                <label class="tab-selector" for="_tab_25"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
<pre><code class="toml">[transport.blocking.http]

listener.enable = true
listener.port = 8200
listener.hostname = ""
listener.origin_server = ""
listener.request_timeout = ""
listener.request_tcp_no_delay = ""
listener.request_core_thread_pool_size = ""
listener.request_max_thread_pool_size = ""
listener.thread_keepalive_time = ""
listener.thread_keepalive_time_unit = ""

sender.enable = true
sender.enable_client_caching = true
sender.transfer_encoding = ""
sender.default_connections_per_host = 200
sender.omit_soap12_action = true
sender.so_timeout = 60000</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[transport.blocking.http]</code>
                            <span class="badge-required">Required</span>
                            <p>
                                This configuration header is required for configuring the parameters that are used for configuring the <a href='{{base_path}}/install-and-setup/setup/mi-setup/transport_configurations/configuring-transports/#configuring-the-httphttps-transport'>default HTTP/S passthrough transport in blocking mode</a>.
                            </p>
                        </div>
                        <div class="params-wrap">
                            <div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>listener.enable</code> </span>
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
                                            <span class="param-possible-values">Possible Values: <code>&quot;true&quot; or &quot;false&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>This parameter is used for enabling the HTTP passthrough transport listener in blocking mode.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>listener.port</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>8200</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The port on which this transport receiver should listen for incoming messages.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>listener.hostname</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        
                                    </div>
                                    <div class="param-description">
                                        <p></p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>listener.origin_server</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        
                                    </div>
                                    <div class="param-description">
                                        <p></p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>listener.request_timeout</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        
                                    </div>
                                    <div class="param-description">
                                        <p></p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>listener.request_tcp_no_delay</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        
                                    </div>
                                    <div class="param-description">
                                        <p></p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>listener.request_core_thread_pool_size</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        
                                    </div>
                                    <div class="param-description">
                                        <p></p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>listener.request_max_thread_pool_size</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        
                                    </div>
                                    <div class="param-description">
                                        <p></p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>listener.thread_keepalive_time</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        
                                    </div>
                                    <div class="param-description">
                                        <p></p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>listener.thread_keepalive_time_unit</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        
                                    </div>
                                    <div class="param-description">
                                        <p></p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>sender.enabled</code> </span>
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
                                            <span class="param-possible-values">Possible Values: <code>&quot;true&quot; or &quot;false&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>This parameter is used for enabling the HTTP passthrough transport sender in blocking mode.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>sender.enable_client_caching</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> boolean </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>&quot;true&quot; or &quot;false&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>This parameter is used to specify whether the HTTP client should save cache entries and the cached responses in the JVM memory or not.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>sender.transfer_encoding</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>&quot;chunked&quot; or &quot;true&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>This parameter enables you to specify whether the data sent should be chunked. It can be used instead of the Content-Length header if you want to upload data without having to know the amount of data to be uploaded in advance.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>sender.default_connections_per_host</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The maximum number of connections that will be created per host server by the client. If the backend server is slow, the connections in use at a given time will take a long time to be released and added back to the connection pool. As a result, connections may not be available for some requests. In such situations, it is recommended to increase the value for this parameter.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>sender.omit_soap12_action</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> boolean </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>&quot;true&quot; or &quot;false&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>If following is set to &#39;true&#39;, optional action part of the Content-Type will not be added to the SOAP 1.2 messages.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>sender.so_timeout</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>60000</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>If following is set to &#39;true&#39;, optional action part of the Content-Type will not be added to the SOAP 1.2 messages.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>sender.proxy_host</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>If the outgoing messages should be sent through an HTTP proxy server (in blocking mode), use this parameter to specify the target proxy.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>sender.proxy_port</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The port through which the target proxy (specified by the &#39;sender.proxy_host&#39; parameter) accepts HTTP traffic (in blocking mode).</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>sender.secured_proxy_host</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>If the outgoing messages should be sent through an HTTPS proxy server (in blocking mode), use this parameter to specify the target proxy.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>sender.secured_proxy_port</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The port through which the target proxy (specified by the &#39;sender.secured_proxy_host&#39; parameter) accepts HTTPS traffic (in blocking mode).</p>
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


## HTTP proxy profile

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">
            
            <input name="26" type="checkbox" id="_tab_26">
                <label class="tab-selector" for="_tab_26"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
<pre><code class="toml">[[transport.http.proxy_profile]]
target_hosts = ["example.com", ".*.sample.com"]
proxy_host = "localhost"
proxy_port = "3128"
proxy_username = "squidUser"
proxy_password = "password"
bypass_hosts = ["xxx.sample.com"]</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[[transport.http.proxy_profile]]</code>
                            <span class="badge-required">Required</span>
                            <p>
                                This configuration header is required for configuring <a href='{{base_path}}/install-and-setup/setup/mi-setup/configuring_proxy_servers/#configuring-proxy-profiles-in-wso2-micro-integrator'>HTTP proxy profiles</a> when you use multiple proxy servers to route messages to different endpoints.
                            </p>
                        </div>
                        <div class="params-wrap">
                            <div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>target_hosts</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>&quot;*&quot;, &quot;example.com&quot;, &quot;&lt;any-ip-address&gt;&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>A host name or a comma-separated list of host names for a target endpoint. Host names can be specified as regular expressions that match a pattern. When asterisks (*) is specified as the target hostname, it will match all the hosts in the profile.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>proxy_host</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The host name of the proxy server.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>proxy_port</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The port number of the proxy server.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>proxy_username</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The password for authenticating the proxy server.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>bypass_hosts</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>A host name or a comma-separated list of host names that should not be sent via the proxy server. For example, if you want all requests sent to *.sample.com to be sent via a proxy server, while you need to directly send requests to hello.sample.com (without going through the proxy server), you can add hello.sample.com as a bypass host name.</p>
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


## HTTP secured proxy profile

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">
            
            <input name="27" type="checkbox" id="_tab_27">
                <label class="tab-selector" for="_tab_27"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
<pre><code class="toml">[[transport.http.secured_proxy_profile]]
target_hosts = ["example.com", ".*.sample.com"]
proxy_host = "localhost"
proxy_port = "3128"
proxy_username = "squidUser"
proxy_password = "password"
bypass_hosts = ["xxx.sample.com"]</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[[transport.http.secured_proxy_profile]]</code>
                            <span class="badge-required">Required</span>
                            <p>
                                This configuration header is required for configuring <a href='{{base_path}}/install-and-setup/setup/mi-setup/setup/configuring_proxy_servers/#configuring-proxy-profiles-in-wso2-micro-integrator'>secured HTTP proxy profiles</a> when you use multiple (secured) proxy servers to route messages to different endpoints.
                            </p>
                        </div>
                        <div class="params-wrap">
                            <div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>target_hosts</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>&quot;*&quot;, &quot;example.com&quot;, &quot;&lt;any-ip-address&gt;&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>A host name or a comma-separated list of host names for a target endpoint. Host names can be specified as regular expressions that match a pattern. When asterisks (*) is specified as the target hostname, it will match all the hosts in the profile.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>proxy_host</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The host name of the proxy server.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>proxy_port</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The port number of the proxy server.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>proxy_username</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The password for authenticating the proxy server.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>proxy_password</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The password for authenticating the proxy server.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>bypass_hosts</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>A host name or a comma-separated list of host names that should not be sent via the proxy server. For example, if you want all requests sent to *.sample.com to be sent via a proxy server, while you need to directly send requests to hello.sample.com (without going through the proxy server), you can add hello.sample.com as a bypass host name.</p>
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


## VFS Transport

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">
            
            <input name="28" type="checkbox" id="_tab_28">
                <label class="tab-selector" for="_tab_28"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
<pre><code class="toml">[transport.vfs]

listener.enable = true
listener.keystore.file_name = "$ref{keystore.tls.file_name}" 
listener.keystore.type = "$ref{keystore.tls.type}"
listener.keystore.password = "$ref{keystore.tls.password}"
listener.keystore.key_password = "$ref{keystore.tls.key_password}"
listener.keystore.alias = "$ref{keystore.tls.alias}"

listener.parameter.customParameter = ""

sender.enable = true
sender.parameter.customParameter = ""</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[transport.vfs]</code>
                            <span class="badge-required">Required</span>
                            <p>
                                This configuration header is required for configuring how the Micro Integrator communicates through the <a href='{{base_path}}/install-and-setup/setup/mi-setup/transport_configurations/configuring-transports/#configuring-the-vfs-transport'>VFS transport</a>.
                            </p>
                        </div>
                        <div class="params-wrap">
                            <div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>listener.enabled</code> </span>
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
                                            <span class="param-possible-values">Possible Values: <code>&quot;true&quot; or &quot;false&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The parameter for enabling the VFS transport listener.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>listener.keystore.file_name</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>MI_HOME/repository/resources/security/wso2carbon.jks</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The path to the keystore file that is used for securing a VFS connection. By default, the keystore file of the primary keystore is enabled for this purpose.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>listener.keystore.type</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>JKS</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>&quot;JKS&quot; or &quot;PKCS12&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The type of the keystore file. By default, the keystore type of the primary keystore is enabled for this purpose.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>listener.keystore.password</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>wso2carbon</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The password of the keystore file that is used for securing a VFS connection. This keystore password is used when accessing the keys in the keystore. By default, the keystore password of the primary keystore is enabled for this purpose.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>listener.keystore.alias</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>wso2carbon</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The alias of the public key corresponding to the private key that is included in the keystore. The public key is used for encrypting data in the Micro Integrator server, which only the corresponding private key can decrypt. The public key is embedded in a digital certificate, and this certificate can be shared over the internet by storing it in a separate trust store file. By default, the alias of the primary keystore is enabled for this purpose.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>listener.keystore.key_password</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>wso2carbon</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The password of the private key that is included in the keystore. The private key is used to decrypt the data that has been encrypted using the keystore&#39;s public key. By default, the public key password of the primary keystore is enabled for this purpose.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>sender.enabled</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> boolean </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>wso2carbon</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>&quot;true&quot; or &quot;false&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The parameter for enabling the VFS transport sender.</p>
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


## MAIL Transport Listener (non-blocking mode)

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">
            
            <input name="29" type="checkbox" id="_tab_29">
                <label class="tab-selector" for="_tab_29"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
<pre><code class="toml">[transport.vfs]

listener.enable = true
listener.keystore.file_name = "$ref{keystore.tls.file_name}" 
listener.keystore.type = "$ref{keystore.tls.type}"
listener.keystore.password = "$ref{keystore.tls.password}"
listener.keystore.key_password = "$ref{keystore.tls.key_password}"
listener.keystore.alias = "$ref{keystore.tls.alias}"

listener.parameter.customParameter = ""

sender.enable = true
sender.parameter.customParameter = ""</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[[transport.http.secured_proxy_profile]]</code>
                            <span class="badge-required">Required</span>
                            <p>
                                This configuration header is required for configuring the <a href='{{base_path}}/install-and-setup/setup/mi-setup/transport_configurations/configuring-transports/#configuring-the-mailto-transport'>MailTo transport</a> listener implementation of the Micro Integrator in non-blocking mode. Note that the list of parameters given below can be used for the non-blocking transport listener as well as the <a href='#mail-transport-listener-blocking-mode'>blocking transport listener</a>.
                            </p>
                        </div>
                        <div class="params-wrap">
                            <div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>listener.enabled</code> </span>
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
                                            <span class="param-possible-values">Possible Values: <code>&quot;true&quot; or &quot;false&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The parameter for enabling the VFS transport listener.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>listener.keystore.file_name</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>MI_HOME/repository/resources/security/wso2carbon.jks</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The path to the keystore file that is used for securing a VFS connection. By default, the keystore file of the primary keystore is enabled for this purpose.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>listener.keystore.type</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>JKS</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>&quot;JKS&quot; or &quot;PKCS12&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The type of the keystore file. By default, the keystore type of the primary keystore is enabled for this purpose.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>listener.keystore.password</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>wso2carbon</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The password of the keystore file that is used for securing a VFS connection. This keystore password is used when accessing the keys in the keystore. By default, the keystore password of the primary keystore is enabled for this purpose.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>listener.keystore.alias</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>wso2carbon</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The alias of the public key corresponding to the private key that is included in the keystore. The public key is used for encrypting data in the Micro Integrator server, which only the corresponding private key can decrypt. The public key is embedded in a digital certificate, and this certificate can be shared over the internet by storing it in a separate trust store file. By default, the alias of the primary keystore is enabled for this purpose.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>listener.keystore.key_password</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>wso2carbon</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The password of the private key that is included in the keystore. The private key is used to decrypt the data that has been encrypted using the keystore&#39;s public key. By default, the public key password of the primary keystore is enabled for this purpose.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>sender.enabled</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> boolean </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>wso2carbon</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>&quot;true&quot; or &quot;false&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The parameter for enabling the VFS transport sender.</p>
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


## MAIL Transport Listener (non-blocking mode)

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">
            
            <input name="30" type="checkbox" id="_tab_30">
                <label class="tab-selector" for="_tab_30"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
<pre><code class="toml">[transport.mail.listener]
enable = true   
name = "mailto"
parameter.customParameter = ""</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[transport.mail.listener]</code>
                            <span class="badge-required">Required</span>
                            <p>
                                This configuration header is required for configuring the MailTo transport listener implementation of the Micro Integrator in non-blocking mode. Note that the list of parameters given below can be used for the non-blocking transport listener as well as the blocking transport listener.
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
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>&quot;true&quot; or &quot;false&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The parameter for enabling the MAIL transport listener in the Micro Integrator.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>name</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The name of the transport receiver.</p>
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


## MAIL Transport Listener (non-blocking mode)

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">
            
            <input name="31" type="checkbox" id="_tab_31">
                <label class="tab-selector" for="_tab_31"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
<pre><code class="toml">[transport.blocking.mail.listener]
enable = true
name = "mailto"
parameter.customParameter = "value"</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[transport.blocking.mail.listener]</code>
                            <span class="badge-required">Required</span>
                            <p>
                                This configuration header groups the parameters that are used to configure the <a href='{{base_path}}/install-and-setup/setup/mi-setup/transport_configurations/configuring-transports/#configuring-the-mailto-transport'>MailTo transport</a> listener in blocking mode. You can use the <a href='#mail-transport-listener-non-blocking-mode'>same list of parameters</a> that are available for the non-blocking mail sender.
                            </p>
                        </div>
                        <div class="params-wrap">
                            
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>


## MAIL Transport Sender (non-blocking mode)

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">
            
            <input name="32" type="checkbox" id="_tab_32">
                <label class="tab-selector" for="_tab_32"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
<pre><code class="toml">[[transport.mail.sender]]
name = "mailto"
parameter.hostname = "smtp.gmail.com"
parameter.port = "587"
parameter.enable_tls = true
parameter.auth = true
parameter.username = "demo_user"
parameter.password = "mailpassword"
parameter.from = "demo_user@wso2.com"</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[[transport.mail.sender]]</code>
                            <span class="badge-required">Required</span>
                            <p>
                                This configuration header groups the parameters that are used to configure the <a href='{{base_path}}/install-and-setup/setup/mi-setup/transport_configurations/configuring-transports/#configuring-the-mailto-transport'>MailTo transport</a> sender implementation of the Micro Integrator in non-blocking mode. Note that the list of parameters given below can be used for the non-blocking transport sender as well as the <a href='#mail-transport-sender-blocking-mode'>blocking transport sender</a>.
                            </p>
                        </div>
                        <div class="params-wrap">
                            <div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>name</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>mailto</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The parameter for enabling the MAIL transport sender in the Micro Integrator.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.hostname</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>smtp.gmail.com</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The mail server that serves outgoing mails from the Micro Integrator.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.port</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>587</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The port of the mail server.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.enable_tls</code> </span>
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
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>&quot;true&quot; or &quot;false&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>This parameter specifies whether TLS is enabled for the MailTo transport.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.username</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>demo_user</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The user name of the email account (mail sender). Note that in some email service providers, the user name is the same as the email address specified for &#39;parameter.from&#39;.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.password</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>mailpassword</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The password of the email account (mail sender).</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.from</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>demo_user@wso2.com</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The email address from which mails will be sent.</p>
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


## MAIL Transport Sender (blocking mode)

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">
            
            <input name="33" type="checkbox" id="_tab_33">
                <label class="tab-selector" for="_tab_33"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
<pre><code class="toml">[transport.blocking.mail.listener]
enable = true
name = "mailto"
parameter.customParameter = "value"</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[[transport.blocking.mail.sender]]</code>
                            <span class="badge-required">Required</span>
                            <p>
                                This configuration header groups the parameters that are used to configure the <a href='{{base_path}}/install-and-setup/setup/mi-setup/transport_configurations/configuring-transports/#configuring-the-mailto-transport'>MailTo transport</a> sender in blocking mode. You can use the <a href='#mail-transport-sender-non-blocking-mode'>same list of parameters</a> that are available for the non-blocking mail sender.
                            </p>
                        </div>
                        <div class="params-wrap">
                            
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>


## JMS Transport Listener (non-blocking mode)

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">
            
            <input name="34" type="checkbox" id="_tab_34">
                <label class="tab-selector" for="_tab_34"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
<pre><code class="toml">[[transport.jms.listener]]

name = "myTopicListener"
parameter.initial_naming_factory = "org.apache.activemq.artemis.jndi.ActiveMQInitialContextFactory"
parameter.broker_name = "artemis"
parameter.provider_url = "tcp://localhost:61616"
parameter.connection_factory_name = "TopicConnectionFactory"
parameter.connection_factory_type = "topic"
parameter.cache_level = "consumer"

parameter.naming_security_principal = ""
parameter.naming_security_credential = ""
parameter.transactionality = ""
parameter.transaction_jndi_name = ""
parameter.cache_user_transaction = true
parameter.session_transaction = true
parameter.session_acknowledgement = "AUTO_ACKNOWLEDGE"
parameter.jms_spec_version = "1.1"
parameter.username = ""
parameter.password = ""
parameter.destination = ""
parameter.destination_type = "queue"
parameter.default_reply_destination = ""
parameter.default_destination_type = "queue"
parameter.message_selector = ""
parameter.subscription_durable = false
parameter.durable_subscriber_client_id = ""
parameter.durable_subscriber_name = ""
parameter.pub_sub_local = false
parameter.receive_timeout = "1000"
parameter.concurrent_consumer = 1
parameter.max_concurrent_consumer = 1
parameter.idle_task_limit = 10
parameter.max_message_per_task = -1
parameter.initial_reconnection_duration = "10000"
parameter.reconnect_progress_factor = 2
parameter.max_reconnect_duration = "3600000"
parameter.reconnect_interval = "3600000"
parameter.max_jsm_connection = 10
parameter.max_consumer_error_retrieve_before_delay = 20
parameter.consume_error_delay = "100"         
parameter.consume_error_progression = "2.0"</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[[transport.jms.listener]]</code>
                            <span class="badge-required">Required</span>
                            <p>
                                This configuration header groups the parameters that are used to configure the <a href='{{base_path}}/install-and-setup/setup/mi-setup/transport_configurations/configuring-transports/#configuring-the-jms-transport'>JMS transport</a> listener implementation of the Micro Integrator in non-blocking mode. Note that the list of parameters given below can be used for the non-blocking transport listener as well as the <a href='#jms-transport-listener-blocking-mode'>blocking transport listener</a>.
                            </p>
                        </div>
                        <div class="params-wrap">
                            <div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>name</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The user-defined name of the JMS listener.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.initial_naming_factory</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>JNDI initial context factory class. The class must implement the java.naming.spi.InitialContextFactory interface.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.provider_url</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>URL of the JNDI provider.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.connection_factory_name</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The JNDI name of the connection factory.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.cache_level</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>consumer</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>consumer</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The cache level that should apply when JMS objects startup. When the Micro Integrator produces JMS messages, you need to specify this cache level in the deployment.toml file. If the Micro Integrator works as JMS listener, you need to specify the JMS cache level in the proxy service. See the list of service-level JMS parameters.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.naming_security_principal</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The JNDI Username.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.naming_security_credential</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The JNDI password.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.transactionality</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Preferred mode of transactionality. &lt;b&gt;Note&lt;/b&gt; that JMS transactions only works with either the Callout mediator or the Call mediator in blocking mode.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.transaction_jndi_name</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>JNDI name to be used to require user transaction.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.cache_user_transaction</code> </span>
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
                                            <span class="param-possible-values">Possible Values: <code>&quot;true&quot; or &quot;false&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Specifies whether or not caching should be enabled for user transactions.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.session_transaction</code> </span>
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
                                            <span class="param-possible-values">Possible Values: <code>&quot;true&quot; or &quot;false&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Specifies whether or not the JMS session should be transacted.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.session_acknowledgement</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>AUTO_ACKNOWLEDGE</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>JMS session acknowledgment mode.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.jms_spec_version</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>1.1</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>JMS API version.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.username</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The JMS connection username.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.password</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The JMS connection password.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.destination</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The JNDI name of the destination.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.destination_type</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>&quot;queue&quot; or &quot;topic&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The type of the destination.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.message_selector</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The message selector implementation.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.subscription_durable</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> boolean </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>&quot;true&quot; or &quot;false&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Specifies whether or not the connection factory is subscription durable.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.durable_subscriber_client_id</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The ClientId parameter when using durable subscriptions.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.durable_subscriber_name</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The name of the durable subscriber.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.pub_sub_local</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> boolean </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>&quot;true&quot; or &quot;false&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Specifies whether or not the messages should should be published by the same connection in which the messages were received.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.receive_timeout</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>1000</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Time to wait for a JMS message during polling. Set this parameter value to a negative integer to wait indefinitely. Set to zero to prevent waiting.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.concurrent_consumer</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>1</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The number of concurrent threads to be started to consume messages when polling.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.max_concurrent_consumer</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>1</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The maximum number of concurrent threads to use during polling.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.idle_task_limit</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>10</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The number of idle runs per thread before it dies out.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.max_message_per_task</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-1</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The maximum number of successful message receipts per thread.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.initial_reconnection_duration</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>10000</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The initial reconnection attempts duration in milliseconds.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.reconnect_progress_factor</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>2</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The factor by which the reconnection duration will be increased.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.max_reconnect_duration</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>3600000</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The maximum reconnection duration in milliseconds.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.reconnect_interval</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>3600000</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The reconnection interval in milliseconds.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.max_jsm_connection</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>10</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The maximum cached JMS connections in the producer level.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.max_consumer_error_retrieve_before_delay</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>20</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The number of retries on consume errors before sleep delay becomes effective.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.consume_error_delay</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>100</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The sleep delay when a consume error is encountered (in milliseconds).</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.consume_error_progression</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>2.0</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The factor by which the consume error retry sleep will be increased.</p>
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


## JMS Transport Listener (blocking mode)

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">
            
            <input name="35" type="checkbox" id="_tab_35">
                <label class="tab-selector" for="_tab_35"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
<pre><code class="toml">[[transport.blocking.jms.listener]]

name = "myTopicListener"
parameter.initial_naming_factory = "org.apache.activemq.artemis.jndi.ActiveMQInitialContextFactory"
parameter.provider_url = "tcp://localhost:61616"
parameter.connection_factory_name = "TopicConnectionFactory"
parameter.connection_factory_type = "topic"
parameter.cache_level = "consumer"

parameter.naming_security_principal = ""
parameter.naming_security_credential = ""
parameter.transactionality = ""
parameter.transaction_jndi_name = ""
parameter.cache_user_transaction = true
parameter.session_transaction = true
parameter.session_acknowledgement = "AUTO_ACKNOWLEDGE"
parameter.jms_spec_version = "1.1"
parameter.username = ""
parameter.password = ""
parameter.destination = ""
parameter.destination_type = "queue"
parameter.default_reply_destination = ""
parameter.default_destination_type = "queue"
parameter.message_selector = ""
parameter.subscription_durable = false
parameter.durable_subscriber_client_id = ""
parameter.durable_subscriber_name = ""
parameter.pub_sub_local = false
parameter.receive_timeout = "1000"
parameter.concurrent_consumer = 1
parameter.max_concurrent_consumer = 1
parameter.idle_task_limit = 10
parameter.max_message_per_task = -1
parameter.initial_reconnection_duration = "10000"
parameter.reconnect_progress_factor = 2
parameter.max_reconnect_duration = "3600000"
parameter.reconnect_interval = "3600000"
parameter.max_jsm_connection = 10
parameter.max_consumer_error_retrieve_before_delay = 20
parameter.consume_error_delay = "100"        
parameter.consume_error_progression = "2.0"</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[[transport.blocking.jms.listener]]</code>
                            <span class="badge-required">Required</span>
                            <p>
                                This configuration header groups the parameters that are used to configure the <a href='{{base_path}}/install-and-setup/setup/mi-setup/transport_configurations/configuring-transports/#configuring-the-jms-transport'>JMS transport</a> listener in blocking mode. You can use the <a href='#jms-transport-listener-non-blocking-mode'>same list of parameters</a> that are available for the non-blocking JMS listener.
                            </p>
                        </div>
                        <div class="params-wrap">
                            
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>


## JMS Transport Sender (non-blocking mode)

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">
            
            <input name="36" type="checkbox" id="_tab_36">
                <label class="tab-selector" for="_tab_36"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
<pre><code class="toml">[[transport.jms.sender]]

name = "myTopicSender"
parameter.initial_naming_factory = "org.apache.activemq.artemis.jndi.ActiveMQInitialContextFactory"
parameter.broker_name = "artemis"
parameter.provider_url = "tcp://localhost:61616"
parameter.connection_factory_name = "TopicConnectionFactory"
parameter.connection_factory_type = "topic"
parameter.cache_level = "producer"

parameter.naming_security_principal = ""
parameter.naming_security_credential = ""
parameter.transactionality = ""
parameter.transaction_jndi_name = ""
parameter.cache_user_transaction = true
parameter.session_transaction = true
parameter.session_acknowledgement = "AUTO_ACKNOWLEDGE"
parameter.jms_spec_version = "1.1"
parameter.username = ""
parameter.password = ""
parameter.destination = ""
parameter.destination_type = "queue"
parameter.default_reply_destination = ""
parameter.default_destination_type = "queue"
parameter.message_selector = ""
parameter.subscription_durable = false
parameter.durable_subscriber_client_id = ""
parameter.durable_subscriber_name = ""
parameter.pub_sub_local = false
parameter.receive_timeout = "1000"
parameter.concurrent_consumer = 1
parameter.max_concurrent_consumer = 1
parameter.idle_task_limit = 10
parameter.max_message_per_task = -1
parameter.initial_reconnection_duration = "10000"
parameter.reconnect_progress_factor = 2
parameter.max_reconnect_duration = "3600000"
parameter.reconnect_interval = "3600000"
parameter.max_jsm_connection = 10
parameter.max_consumer_error_retrieve_before_delay = 20
parameter.consume_error_delay = "100"
parameter.consume_error_progression = "2.0"

parameter.vender_class_loader = false</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[[transport.jms.sender]]</code>
                            <span class="badge-required">Required</span>
                            <p>
                                This configuration header groups the parameters that are used to configure the <a href='{{base_path}}/install-and-setup/setup/mi-setup/transport_configurations/configuring-transports/#configuring-the-jms-transport'>JMS transport</a> sender implementation of the Micro Integrator in non-blocking mode.
                            </p>
                        </div>
                        <div class="params-wrap">
                            <div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>name</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The user-defined name of the JMS sender.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.initial_naming_factory</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>JNDI initial context factory class. The class must implement the java.naming.spi.InitialContextFactory interface.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.broker_name</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The name of the JMS broker.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.provider_url</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>URL of the JNDI provider.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.connection_factory_name</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The JNDI name of the connection factory.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.cache_level</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>producer</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>producer</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The cache level that should apply when JMS objects startup. When the Micro Integrator produces JMS messages, you need to specify this cache level in the deployment.toml file. If the Micro Integrator works as JMS listener, you need to specify the JMS cache level in the proxy service. See the list of service-level JMS parameters.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.naming_security_principal</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The JNDI Username.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.naming_security_credential</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The JNDI password.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.transactionality</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Preferred mode of transactionality. &lt;b&gt;Note&lt;/b&gt; that JMS transactions only works with either the Callout mediator or the Call mediator in blocking mode.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.transaction_jndi_name</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>JNDI name to be used to require user transaction.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.cache_user_transaction</code> </span>
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
                                            <span class="param-possible-values">Possible Values: <code>&quot;true&quot; or &quot;false&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Specifies whether or not caching should be enabled for user transactions.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.session_transaction</code> </span>
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
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>&quot;true&quot; or &quot;false&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Specifies whether or not the JMS session should be transacted.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.session_acknowledgement</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>AUTO_ACKNOWLEDGE</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>JMS session acknowledgment mode.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.jms_spec_version</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>1.1</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>JMS API version.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.username</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The JMS connection username.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.password</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The JMS connection password.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.destination</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The JNDI name of the destination.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.destination_type</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>&quot;queue&quot; or &quot;topic&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The type of the destination.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.default_reply_destination</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The JNDI name of the default reply destination.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.default_destination_type</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>&quot;queue&quot; or &quot;topic&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The type of the reply destination.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.message_selector</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The message selector implementation.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.subscription_durable</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> boolean </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>&quot;true&quot; or &quot;false&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Specifies whether or not the connection factory is subscription durable.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.durable_subscriber_client_id</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The ClientId parameter when using durable subscriptions.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.durable_subscriber_name</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The name of the durable subscriber.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.pub_sub_local</code> </span>
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
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>&quot;true&quot; or &quot;false&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Specifies whether or not the messages should should be published by the same connection in which the messages were received.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.receive_timeout</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>1000</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Time to wait for a JMS message during polling. Set this parameter value to a negative integer to wait indefinitely. Set to zero to prevent waiting.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.concurrent_consumer</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>1</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The number of concurrent threads to be started to consume messages when polling.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.max_concurrent_consumer</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>1</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The maximum number of concurrent threads to use during polling.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.idle_task_limit</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>10</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The number of idle runs per thread before it dies out.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.max_message_per_task</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-1</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The maximum number of successful message receipts per thread.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.initial_reconnection_duration</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>10000</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The initial reconnection attempts duration in milliseconds.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.reconnect_progress_factor</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>2</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The factor by which the reconnection duration will be increased.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.max_reconnect_duration</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>3600000</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The maximum reconnection duration in milliseconds.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.reconnect_interval</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>3600000</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The reconnection interval in milliseconds.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.max_jsm_connection</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>10</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The maximum cached JMS connections in the producer level.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.max_consumer_error_retrieve_before_delay</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>20</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The number of retries on consume errors before sleep delay becomes effective.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.consume_error_delay</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>100</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The sleep delay when a consume error is encountered (in milliseconds).</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.consume_error_progression</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>2.0</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The factor by which the consume error retry sleep will be increased.</p>
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


## JMS Transport Sender (blocking mode)

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">
            
            <input name="37" type="checkbox" id="_tab_37">
                <label class="tab-selector" for="_tab_37"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
<pre><code class="toml">[[transport.blocking.jms.sender]]

name = "myTopicSender"
parameter.initial_naming_factory = "org.apache.activemq.artemis.jndi.ActiveMQInitialContextFactory"
parameter.provider_url = "tcp://localhost:61616"
parameter.connection_factory_name = "TopicConnectionFactory"
parameter.connection_factory_type = "topic"
parameter.cache_level = "producer"

parameter.naming_security_principal = ""
parameter.naming_security_credential = ""
parameter.transactionality = ""
parameter.transaction_jndi_name = ""
parameter.cache_user_transaction = true
parameter.session_transaction = true
parameter.session_acknowledgement = "AUTO_ACKNOWLEDGE"
parameter.jms_spec_version = "1.1"
parameter.username = ""
parameter.password = ""
parameter.destination = ""
parameter.destination_type = "queue"
parameter.default_reply_destination = ""
parameter.default_destination_type = "queue"
parameter.message_selector = ""
parameter.subscription_durable = false
parameter.durable_subscriber_client_id = ""
parameter.durable_subscriber_name = ""
parameter.pub_sub_local = false
parameter.receive_timeout = "1000"
parameter.concurrent_consumer = 1
parameter.max_concurrent_consumer = 1
parameter.idle_task_limit = 10
parameter.max_message_per_task = -1
parameter.initial_reconnection_duration = "10000"
parameter.reconnect_progress_factor = 2
parameter.max_reconnect_duration = "3600000"
parameter.reconnect_interval = "3600000"
parameter.max_jsm_connection = 10
parameter.max_consumer_error_retrieve_before_delay = 20
parameter.consume_error_delay = "100"
parameter.consume_error_progression = "2.0"
parameter.vender_class_loader = false</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[[transport.blocking.jms.sender]]</code>
                            <span class="badge-required">Required</span>
                            <p>
                                This configuration header groups the parameters that are used to configure the <a href='{{base_path}}/install-and-setup/setup/mi-setup/transport_configurations/configuring-transports/#configuring-the-jms-transport'>JMS transport</a> sender in blocking mode. You can use the <a href='#jms-transport-sender-non-blocking-mode'>same list of parameters</a> that are available for the non-blocking JMS sender.
                            </p>
                        </div>
                        <div class="params-wrap">
                            
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>


## JNDI Connection Factories

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">
            
            <input name="38" type="checkbox" id="_tab_38">
                <label class="tab-selector" for="_tab_38"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
<pre><code class="toml">[transport.jndi.connection_factories]
QueueConnectionFactory = "amqp://admin:admin@clientID/carbon?brokerlist='tcp://localhost:5675'"
TopicConnectionFactory = "amqp://admin:admin@clientID/carbon?brokerlist='tcp://localhost:5675'"</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[transport.jndi.connection_factories]</code>
                            <span class="badge-required">Required</span>
                            <p>
                                This configuration header groups the parameters used for specifying the JNDI connection factory classes.
                            </p>
                        </div>
                        <div class="params-wrap">
                            <div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>TopicConnectionFactory</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>amqp://admin:admin@clientID/carbon?brokerlist=&#39;tcp://localhost:5675&#39;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The connection factory URL for connecting to a JMS queue.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>QueueConnectionFactory</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>amqp://admin:admin@clientID/carbon?brokerlist=&#39;tcp://localhost:5675&#39;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The connection factory URL for connecting to a JMS topic.</p>
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


## JNDI Queues

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">
            
            <input name="39" type="checkbox" id="_tab_39">
                <label class="tab-selector" for="_tab_39"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
<pre><code class="toml">[transport.jndi.queue]
JMSMS = "JMSMS"
StockQuotesQueue = "StockQuotesQueue"</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[transport.jndi.queue]</code>
                            <span class="badge-required">Required</span>
                            <p>
                                This configuration header is used to specify the list of queues that are defined your JMS broker. The JNDI name of the queue, and the actual queue name should be specifed as a key-value pair as follows: jndi_name = queue_name.
                            </p>
                        </div>
                        <div class="params-wrap">
                            <div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>&lt;jndi_queue_name&gt;</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>&lt;queue_name&gt;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The jndi queue name and the actual queue name as a key-value pair.</p>
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


## JNDI Topics

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">
            
            <input name="40" type="checkbox" id="_tab_40">
                <label class="tab-selector" for="_tab_40"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
<pre><code class="toml">[transport.jndi.topic]
MyTopic = "example.MyTopic"</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[transport.jndi.topic]</code>
                            <span class="badge-required">Required</span>
                            <p>
                                This configuration header is used to specify the list of topics that are defined your JMS broker. The JNDI name of the topic, and the actual topic name should be specifed as a key-value pair as follows: jndi_name = topic_name.
                            </p>
                        </div>
                        <div class="params-wrap">
                            <div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>&lt;jndi_topic_name&gt;</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>&lt;topic_name&gt;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The jndi queue name and the actual topic name as a key-value pair.</p>
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


## RabbitMQ Listener

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">
            
            <input name="41" type="checkbox" id="_tab_41">
                <label class="tab-selector" for="_tab_41"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
<pre><code class="toml">[[transport.rabbitmq.listener]]

name = "rabbitMQListener"
parameter.hostname = "localhost"
parameter.port = 5672
parameter.username = "guest"
parameter.password = "guest"
parameter.connection_factory = ""
parameter.exchange_name = "amq.direct"
parameter.queue_name = "MyQueue"
parameter.queue_auto_ack = false
parameter.consumer_tag = ""
parameter.channel_consumer_qos = ""
parameter.durable = ""
parameter.queue_exclusive = ""
parameter.queue_auto_delete = ""
parameter.queue_routing_key = ""
parameter.queue_auto_declare = ""
parameter.exchange_auto_declare = ""
parameter.exchange_type = ""
parameter.exchange_durable = ""
parameter.exchange_auto_delete = ""
parameter.message_content_type = ""

parameter.retry_interval = "10s"
parameter.retry_count = 5
parameter.connection_pool_size = 25

parameter.ssl_enable = true
parameter.ssl_version = "SSL"
parameter.keystore_location ="$ref{keystore.tls.file_name}"
parameter.keystore_type = "$ref{keystore.tls.type}"
parameter.keystore_password = "$ref{keystore.tls.password}"
parameter.truststore_file_name ="$ref{truststore.file_name}"
parameter.truststore_type = "$ref{truststore.type}"
parameter.truststore_password = "$ref{truststore.password}"</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[[transport.rabbitmq.listener]]</code>
                            <span class="badge-required">Required</span>
                            <p>
                                This configuration header is required if you are configuring WSO2 Micro Integrator to receive messages from a RabbitMQ client. Read more about <a href='{{base_path}}/install-and-setup/setup/mi-setup/brokers/configure-with-rabbitMQ'>connecting the Micro Integator with RabbitMQ</a>.
                            </p>
                        </div>
                        <div class="params-wrap">
                            <div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>name</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The name of the broker.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.hostname</code> </span>
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
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The IP address of the server node.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.port</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>5672</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The port on which the RabbitMQ broker can be accessed.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.username</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>guest</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The user name for connecting to RabbitMQ broker.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.password</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>guest</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The password for connecting to the RabbitMQ broker.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.connection_factory</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>org.apache.axis2.transport.rabbitmq.RabbitMQListener</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The name of the connection factory.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.exchange_name</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>amq.direct</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Name of the RabbitMQ exchange to which the queue is bound. Use this parameter instead of rabbitmq.queue.routing.key, if you need to use the default exchange and publish to a queue.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.queue_name</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>MyQueue</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The queue name to send or consume messages. If you do not specify this parameter, you need to specify the rabbitmq.queue.routing.key parameter.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.queue_auto_ack</code> </span>
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
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>&quot;true&quot; or &quot;false&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The queue name to send or consume messages. If you do not specify this parameter, you need to specify the rabbitmq.queue.routing.key parameter.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.consumer_tag</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The client­ generated consumer tag to establish context.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.channel_consumer_qos</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The consumer qos value. You need to specify this parameter only if the rabbitmq.queue.auto.ack parameter is set to false.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.durable</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Specifies whether the queue should remain declared even if the broker restarts.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.queue_exclusive</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Specifies whether the queue should be exclusive or should be consumable by other connections.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.queue_auto_delete</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Specifies whether to keep the queue even if it is not being consumed anymore.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.queue_routing_key</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The routing key of the queue.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.queue_auto_declare</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Specifies whether to create queues if they are not present. However, you should set this parameter only if queues are not declared prior on the broker. Setting this parameter in the publish URL to false improves RabbitMQ transport performance.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.exchange_auto_declare</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Specifies whether to create exchanges if they are not present. However, you should set this parameter only if exchanges are not declared prior on the broker. Setting this parameter in the publish URL to false improves RabbitMQ transport performance.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.exchange_type</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The type of the exchange.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.exchange_durable</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Specifies whether the exchange should remain declared even if the broker restarts.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.exchange_auto_delete</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Specifies whether to keep the exchange even if it is not bound to any queue anymore.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.default_destination_type</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>text/xml</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The content type of the consumer. &lt;/br&gt;Note that if the content type is specified in the message, this parameter does not override the specified content type.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.retry_interval</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>30000</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>In the case of network failure or broker shut down, the Micro Integrator will attempt to reconnect a number of times (as sepcified by the parameter.retry_count parameter) with an interval (specified by this parameter) between the retry attempts.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.retry_interval</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>3</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>In the case of network failure or broker shut down, the Micro Integrator will attempt to reconnect as many times as sepcified by this parameter with an interval (specified by the parameter.retry_interval parameter) between the retry attempts.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.ssl_enable</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> boolean </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>&quot;true&quot; or &quot;false&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Specifies whether or not SSL is enabled for RabbitMQ connection. If you set this to &#39;true&#39;, be sure to update the keystore and trust store parameters given below.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.ssl_version</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>SSL</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The SSL versions.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.keystore_location</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>MI_HOME/repository/resources/security/wso2carbon.jks</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The path to the keystore file that is used for securing a RabbitMQ connection. By default, the keystore file of the primary keystore is enabled for this purpose.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.keystore_type</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>JKS</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>&quot;JKS&quot; or &quot;PKCS12&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The type of the keystore file. By default, the keystore type of the primary keystore is enabled for this purpose.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.keystore_password</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>wso2carbon</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The password of the keystore file that is used for securing a RabbitMQ connection. This keystore password is used when accessing the keys in the keystore. By default, the keystore password of the primary keystore is enabled for this purpose.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.truststore_location</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>MI_HOME/repository/resources/security/wso2truststore.jks</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The path to the keystore file that is used for storing the trusted digital certificates. By default, the product&#39;s trust store is configured for this purpose.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.truststore_type</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>JKS</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>&quot;JKS&quot; or &quot;PKCS12&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The type of the keystore file that is used as the trust store. By default, the product&#39;s trust store is configured for this purpose.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.truststore_password</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>wso2carbon</code></span>
                                        </div>
                                        
                                    </div>
                                    <div class="param-description">
                                        <p>The password of the keystore file that is used as the trust store. By default, the product&#39;s trust store is configured for this purpose.</p>
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


## RabbitMQ Sender

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">
            
            <input name="42" type="checkbox" id="_tab_42">
                <label class="tab-selector" for="_tab_42"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
<pre><code class="toml">[transport.rabbitmq]
sender_enable = true

[[transport.rabbitmq.sender]]
name = "rabbitMQSender"
parameter.hostname = "localhost"
parameter.port = 5672
parameter.username = "guest"
parameter.password = "guest"
parameter.exchange_name = "amq.direct"
parameter.routing_key = "MyQueue"
parameter.reply_to_name = ""
parameter.queue_delivery_mode = 1 # 1/2
parameter.exchange_type = ""
parameter.queue_name = "MyQueue"
parameter.queue_durable = false
parameter.queue_exclusive = false
parameter.queue_auto_delete = false
parameter.exchange_durable = ""
parameter.queue_auto_declare = ""
parameter.exchange_auto_declare = ""
parameter.connection_pool_size = 10</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[transport.rabbitmq]</code>
                            
                            <p>
                                This configuration header is required for enabling the RabbitMQ listener in the Micro Integrator. Read more about <a href='{{base_path}}/install-and-setup/setup/mi-setup/brokers/configure-with-rabbitMQ'>connecting the Micro Integator with RabbitMQ</a>.
                            </p>
                        </div>
                        <div class="params-wrap">
                            <div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>sender_enable</code> </span>
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
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>&quot;true&quot; or &quot;false&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Set this parameter to &#39;true&#39; if you want to configure the Micro Integrator to send messages to a RabbitMQ client.</p>
                                    </div>
                                </div>
                            </div>
                        </div><div class="config-wrap">
                            <code>[[transport.rabbitmq.sender]]</code>
                            
                            <p>
                                This configuration header is optional when you have the RabbitMQ sender enabled ([transport.rabbitmq]. Read more about <a href='{{base_path}}/install-and-setup/setup/mi-setup/brokers/configure-with-rabbitMQ'>connecting the Micro Integator with RabbitMQ</a>.
                            </p>
                        </div>
                        <div class="params-wrap">
                            <div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>name</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The name of the broker.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.hostname</code> </span>
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
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The IP address of the server node.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.port</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>5672</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The port on which the RabbitMQ broker can be accessed.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.username</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>guest</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The user name for connecting to RabbitMQ broker.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.password</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>guest</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The password for connecting to the RabbitMQ broker.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.exchange_name</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>amq.direct</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Name of the RabbitMQ exchange to which the queue is bound. Use this parameter instead of rabbitmq.queue.routing.key, if you need to use the default exchange and publish to a queue.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.routing_key</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>MyQueue</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The routing key of the queue.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.queue_name</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>MyQueue</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The queue name to send or consume messages. If you do not specify this parameter, you need to specify the rabbitmq.queue.routing.key parameter.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.reply_to_name</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The name of the call back­ queue. Specify this parameter if you expect a response.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.queue_delivery_mode</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>persistent</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The delivery mode of the queue. Possible values are Non­-persistent and Persistent.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.exchange_type</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The type of the exchange.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.queue_name</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>MyQueue</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The queue name to send or consume messages. If you do not specify this parameter, you need to specify the rabbitmq.queue.routing.key parameter.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.queue_durable</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>MyQueue</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Whether the queue should remain declared even if the broker restarts. The default value is false.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.queue_exclusive</code> </span>
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
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>&quot;true&quot; or &quot;false&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Whether the queue should be exclusive or should be consumable by other connections. The default value is false.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.queue_auto_delete</code> </span>
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
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>&quot;true&quot; or &quot;false&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Specifies whether to keep the queue even if it is not being consumed anymore.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.exchange_auto_declare</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Specifies whether to create exchanges if they are not present. However, you should set this parameter only if exchanges are not declared prior on the broker. Setting this parameter in the publish URL to false improves RabbitMQ transport performance.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.queue_auto_declare</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Specifies whether to create queues if they are not present. However, you should set this parameter only if queues are not declared prior on the broker. Setting this parameter in the publish URL to false improves RabbitMQ transport performance.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.exchange_durable</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Specifies whether the exchange should remain declared even if the broker restarts.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.queue_auto_declare</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Whether to keep the queue even if it is not being consumed anymore. The default value is false.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>parameter.exchange_auto_declare</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Whether to create queues if they are not present. However, you should set this parameter only if queues are not declared prior on the broker. Setting this parameter in the publish URL to false improves RabbitMQ transport performance.</p>
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


## FIX Transport

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">
            
            <input name="43" type="checkbox" id="_tab_43">
                <label class="tab-selector" for="_tab_43"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
<pre><code class="toml">[transport.fix]

listener.enable = false
listener.parameter.customParameter = ""
sender.enable = false
sender.parameter.customParameter = ""</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[transport.fix]</code>
                            <span class="badge-required">Required</span>
                            <p>
                                This configuration header groups the parameters that configure the Micro Integrator to communicate through the <a href='{{base_path}}/install-and-setup/setup/mi-setup/transport_configurations/configuring-transports/#configuring-the-fix-transport'>FIX transport</a>.
                            </p>
                        </div>
                        <div class="params-wrap">
                            <div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>listener.enabled</code> </span>
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
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>&quot;true&quot; or &quot;false&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The parameter for enabling the FIX transport listener.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>sender.enabled</code> </span>
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
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>&quot;true&quot; or &quot;false&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The parameter for enabling the FIX transport sender.</p>
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


## MQTT Transport

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">
            
            <input name="44" type="checkbox" id="_tab_44">
                <label class="tab-selector" for="_tab_44"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
<pre><code class="toml">[transport.mqtt]

listener.enable = false
listener.hostname = "$ref{server.hostname}"
listener.connection_factory = "mqttConFactory"
listener.server_port = 1883
listener.client_id = "client-id-1234"
listener.topic_name = "esb.test"

# not reqired parameter list
listener.subscription_qos = 0
listener.session_clean = false
listener.enable_ssl = false
listener.subscription_username = ""
listener.subscription_password = ""
listener.temporary_store_directory = ""
listener.blocking_sender = false
listener.connect_type = "text/plain"
listener.message_retained = false

listener.parameter.customParameter = ""

sender.enable = false
sender.parameter.customParameter = ""</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[transport.mqtt]</code>
                            <span class="badge-required">Required</span>
                            <p>
                                This configuration header groups the parameters that configure the Micro Integrator to communicate through the <a href='{{base_path}}/install-and-setup/setup/mi-setup/transport_configurations/configuring-transports/#configuring-the-mqtt-transport'>MQTT transport</a>.
                            </p>
                        </div>
                        <div class="params-wrap">
                            <div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>listener.enabled</code> </span>
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
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>&quot;true&quot; or &quot;false&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The parameter for enabling the MQTT transport listener.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>listener.hostname</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>$ref{server.hostname}</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The name of the host. By default, the hostname of the Micro Integrator server is used.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>listener.connection_factory</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The connection factory URL for connecting to a JMS topic.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>listener.server_port</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>&quot;1883&quot; or &quot;1885&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The port ID.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>listener.client_id</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The client ID.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>listener.topic_name</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The name of the topic.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>listener.parameter.customParameter</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Replace &#39;customParameter&#39; with a required parameter name.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>sender.enable</code> </span>
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
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>&quot;true&quot; or &quot;false&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The parameter for enabling the MQTT transport sender.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>sender.parameter.customParameter</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Replace &#39;customParameter&#39; with a required parameter name.</p>
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


## SAP Transport

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">
            
            <input name="45" type="checkbox" id="_tab_45">
                <label class="tab-selector" for="_tab_45"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
<pre><code class="toml">[transport.sap]

listener.idoc.enable = true
listener.bapi.enable = true
listener.idoc.class = "org.wso2.carbon.transports.sap.SAPTransportListener"
listener.idoc.parameter.customParameter = ""
listener.bapi.class = "org.wso2.carbon.transports.sap.SAPTransportListener"
listener.bapi.parameter.customParameter = ""
sender.idoc.enable = true
sender.bapi.enable = true
sender.idoc.class = "org.wso2.carbon.transports.sap.SAPTransportSender"
sender.idoc.parameter.customParameter = ""
sender.bapi.class = "org.wso2.carbon.transports.sap.SAPTransportSender"
sender.bapi.parameter.customParameter = ""</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[transport.sap]</code>
                            
                            <p>
                                This configuration header groups the parameters that configure the Micro Integrator to <a href='{{base_path}}/tutorials/integration-tutorials/sap-integration'>communicate with SAP</a>.
                            </p>
                        </div>
                        <div class="params-wrap">
                            <div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>listener.idoc.enabled</code> </span>
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
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>&quot;true&quot; or &quot;false&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The parameter for enabling SAP idoc transport listener.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>listener.bapi.enabled</code> </span>
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
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>&quot;true&quot; or &quot;false&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The parameter for enabling SAP bapi transport listener.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>listener.idoc.class</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>org.wso2.carbon.transports.sap.SAPTransportListener</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The class that implements the SAP transport listener for the Sap IDoc libary.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>listener.bapi.class</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>org.wso2.carbon.transports.sap.SAPTransportListener</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The class that implements the SAP transport listener for the SAP BAPI library.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>sender.idoc.enabled</code> </span>
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
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>&quot;true&quot; or &quot;false&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The parameter for enabling the SAP idoc transport sender.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>sender.bapi.enabled</code> </span>
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
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>&quot;true&quot; or &quot;false&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The parameter for enabling the SAP bapi transport sender.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>sender.idoc.class</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>org.wso2.carbon.transports.sap.SAPTransportSender</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The class that implements the SAP transport sender for the Sap IDoc library.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>sender.bapi.class</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>org.wso2.carbon.transports.sap.SAPTransportSender</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The class that implements the SAP transport listener for the Sap BAPI library.</p>
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


## MSMQ Transport

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">
            
            <input name="46" type="checkbox" id="_tab_46">
                <label class="tab-selector" for="_tab_46"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
<pre><code class="toml">[transport.msmq]

listener.enable = false
listener.hostname = "$ref{server.hostname}"
listener.parameter.customParameter = ""

sender.enable = false
sender.parameter.customParameter = ""</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[transport.msmq]</code>
                            <span class="badge-required">Required</span>
                            <p>
                                This configuration header groups the parameters that configure the Micro Integrator to communicate through the <a href='{{base_path}}/install-and-setup/setup/mi-setup/transport_configurations/configuring-transports/#configuring-the-msmq-transport'>MSMQ transport</a>.
                            </p>
                        </div>
                        <div class="params-wrap">
                            <div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>listener.enabled</code> </span>
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
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>&quot;true&quot; or &quot;false&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The parameter for enabling MSMQ transport listener.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>sender.enable</code> </span>
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
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>&quot;true&quot; or &quot;false&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The parameter for enabling MSMQ transport sender.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>listener.hostname</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>$ref{server.hostname}</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The hostname.</p>
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


## TCP Transport (non-blocking mode)

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">
            
            <input name="47" type="checkbox" id="_tab_47">
                <label class="tab-selector" for="_tab_47"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
<pre><code class="toml">[transport.tcp]

listener.enable = false
listener.port = 8000
listener.hostname = "$ref{server.hostname}"
listener.content_type = ["application/xml"]
listener.response_client = true
listener.parameter.customParameter = ""

sender.enable = true
sender.parameter.customParameter = ""</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[transport.tcp]</code>
                            <span class="badge-required">Required</span>
                            <p>
                                This configuration header groups the parameters that configure the Micro Integrator to communicate through the <a href='{{base_path}}/install-and-setup/setup/mi-setup/transport_configurations/configuring-transports/#configuring-the-tcp-transport'>TCP transport</a>. Note that the list of parameters given below can be used for the non-blocking transport as well as the <a href='#tcp-transport-blocking-mode'>blocking transport</a>.
                            </p>
                        </div>
                        <div class="params-wrap">
                            <div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>listener.enabled</code> </span>
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
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>&quot;true&quot; or &quot;false&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The parameter for enabling the TCP transport listener.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>listener.port</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>8000</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>A positive integer less than 65535</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The port on which the TCP server should listen for incoming messages.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>listener.hostname</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>$ref{server.hostname}</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The host name of the server to be displayed in WSDLs, etc.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>listener.content_type</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>&quot;application/xml&quot;, &quot;application/json&quot;, or &quot;text/html&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The content type of the input message.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>listener.response_client</code> </span>
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
                                            <span class="param-possible-values">Possible Values: <code>&quot;true&quot; or &quot;false&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Whether or not the client needs to get the response.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>sender.enabled</code> </span>
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
                                            <span class="param-possible-values">Possible Values: <code>&quot;true&quot; or &quot;false&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The parameter for enabling the TCP transport sender.</p>
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


## TCP Transport (blocking mode)

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">
            
            <input name="48" type="checkbox" id="_tab_48">
                <label class="tab-selector" for="_tab_48"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
<pre><code class="toml">[transport.blocking.tcp]

listener.enable = false
listener.port = 8000
listener.hostname = "$ref{server.hostname}"
listener.content_type = ["application/xml"]
listener.response_client = true
listener.parameter.customParameter = ""

sender.enable = false
sender.parameter.customParameter = ""</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[transport.blocking.tcp]</code>
                            <span class="badge-required">Required</span>
                            <p>
                                This configuration header groups the parameters that are used to configure the <a href='{{base_path}}/install-and-setup/setup/mi-setup/transport_configurations/configuring-transports/#configuring-the-tcp-transport'>TCP transport</a> in blocking mode. You can use the <a href='#tcp-transport-non-blocking-mode'>same list of parameters</a> that are available for the non-blocking TCP transport.
                            </p>
                        </div>
                        <div class="params-wrap">
                            
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>


## Websocket Transport

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">
            
            <input name="49" type="checkbox" id="_tab_49">
                <label class="tab-selector" for="_tab_49"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
<pre><code class="toml">[transport.ws]

sender.enable = false
sender.outflow_dispatch_sequence = "outflowDispatchSeq"
sender.outflow_dispatch_fault_sequence = "outflowFaultSeq"      
sender.parameter.customParameter = ""</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[transport.ws]</code>
                            <span class="badge-required">Required</span>
                            <p>
                                This configuration header groups the parameters that configure the Micro Integrator to communicate through the <a href='{{base_path}}/install-and-setup/setup/mi-setup/transport_configurations/configuring-transports/#configuring-the-websocket-transport'>Websocket transport</a>.
                            </p>
                        </div>
                        <div class="params-wrap">
                            <div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>sender.enable</code> </span>
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
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>&quot;true&quot; or &quot;false&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The parameter for enabling the websocket transport listener.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>sender.outflow_dispatch_sequence</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>outflowDispatchSeq</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The sequence for the back-end to client mediation.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>sender.outflow_dispatch_fault_sequence</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>outflowFaultSeq</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The fault sequence for the back-end to client mediation path.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>sender.parameter.customParameter</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Replace &#39;customParameter&#39; with required parameter name.</p>
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


## Secure Websocket Transport

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">
            
            <input name="50" type="checkbox" id="_tab_50">
                <label class="tab-selector" for="_tab_50"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
<pre><code class="toml">[transport.wss]

sender.enable = false
sender.outflow_dispatch_sequence = "outflowDispatchSeq"
sender.outflow_dispatch_fault_sequence = "outflowFaultSeq"
sender.parameter.customParameter = ""

sender.truststore_location = "$ref{truststore.file_name}"
sender.truststore_password = "$ref{truststore.password}"</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[transport.wss]</code>
                            <span class="badge-required">Required</span>
                            <p>
                                This configuration header groups the parameters that configure the Micro Integrator to communicate through the <a href='{{base_path}}/install-and-setup/setup/mi-setup/transport_configurations/configuring-transports/#configuring-the-websocket-transport'>secured Websocket transport</a>.
                            </p>
                        </div>
                        <div class="params-wrap">
                            <div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>sender.enable</code> </span>
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
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>&quot;true&quot; or &quot;false&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The parameter for enabling the websocket secured transport sender.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>sender.outflow_dispatch_sequence</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>outflowDispatchSeq</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The sequence for the back-end to client mediation.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>sender.outflow_dispatch_fault_sequence</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>outflowFaultSeq</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The fault sequence for the back-end to client mediation path.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>sender.truststore_location</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>MI_HOME/repository/resources/security/wso2truststore.jks</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The file path to the truststore that stores the trusted digital certificates for websocket use cases. By default, the product&#39;s trust store is configured for this purpose.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>sender.truststore_password</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>wso2carbon</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The password of the keystore file that is used as the trust store.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>sender.parameter.customParameter</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Replace &#39;customParameter&#39; with required parameter name.</p>
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


## UDP Transport (non-blocking mode)

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">
            
            <input name="51" type="checkbox" id="_tab_51">
                <label class="tab-selector" for="_tab_51"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
<pre><code class="toml">[transport.udp]

listener.enable = false
listener.parameter.customParameter = ""

sender.enable =false               
sender.parameter.customParameter = ""</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[transport.udp]</code>
                            <span class="badge-required">Required</span>
                            <p>
                                This configuration header groups the parameters that configure the Micro Integrator to communicate through the <a href='{{base_path}}/install-and-setup/setup/mi-setup/transport_configurations/configuring-transports/#configuring-the-udp-transport'>UDP transport</a>. Note that the list of parameters given below can be used for the non-blocking transport as well as the <a href='#udp-transport-blocking-mode'>blocking transport</a>.
                            </p>
                        </div>
                        <div class="params-wrap">
                            <div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>listener.enabled</code> </span>
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
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>&quot;true&quot; or &quot;false&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The parameter for enabling the UDP transport listener.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>sender.enabled</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>false</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>&quot;true&quot; or &quot;false&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The parameter for enabling the UDP transport sender.</p>
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


## UDP Transport (blocking mode)

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">
            
            <input name="52" type="checkbox" id="_tab_52">
                <label class="tab-selector" for="_tab_52"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
<pre><code class="toml">[transport.blocking.udp]

listener.enable = false
listener.parameter.customParameter = ""

sender.enable = false        
sender.parameter.customParameter = ""</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[transport.blocking.tcp]</code>
                            <span class="badge-required">Required</span>
                            <p>
                                This configuration header groups the parameters that are used to configure the <a href='{{base_path}}/install-and-setup/setup/mi-setup/transport_configurations/configuring-transports/#configuring-the-udp-transport'>UDP transport</a> in blocking mode. You can use the <a href='#udp-transport-non-blocking-mode'>same list of parameters</a> that are available for the non-blocking UDP transport.
                            </p>
                        </div>
                        <div class="params-wrap">
                            
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>


## Custom Transport Listener

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">
            
            <input name="53" type="checkbox" id="_tab_53">
                <label class="tab-selector" for="_tab_53"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
<pre><code class="toml">[[custom_transport.listener]]
class = "org.wso2.micro.integrator.business.messaging.hl7.transport.HL7TransportListener"
protocol = "hl7"</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[[custom_transport.listener]]</code>
                            <span class="badge-required">Required</span>
                            <p>
                                This configuration header groups the parameters that configure the Micro Integrator to receive messages through a <a href='{{base_path}}/install-and-setup/setup/mi-setup/transport_configurations/configuring-transports/#configuring-custom-transports'>custom transport</a>.
                            </p>
                        </div>
                        <div class="params-wrap">
                            <div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>class</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The class implementing the custom transport. For example, if you are using an HL7 transport listener, use the following class: org.wso2.micro.integrator.business.messaging.hl7.transport.HL7TransportListener.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>protocol</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The transport protocol for the custom implementation. For example: hl7.</p>
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


## Custom Transport Sender

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">
            
            <input name="54" type="checkbox" id="_tab_54">
                <label class="tab-selector" for="_tab_54"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
<pre><code class="toml">[[custom_transport.sender]]
class = "org.wso2.micro.integrator.business.messaging.hl7.transport.HL7TransportSender"
protocol = "hl7"</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[transport.udp]</code>
                            <span class="badge-required">Required</span>
                            <p>
                                This configuration header groups the parameters that configure the Micro Integrator to send messages through a <a href='{{base_path}}/install-and-setup/setup/mi-setup/transport_configurations/configuring-transports/#configuring-custom-transports'>custom transport</a>.
                            </p>
                        </div>
                        <div class="params-wrap">
                            <div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>class</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The class implementing the custom transport. For example, if you are using an HL7 transport listener, use the following class: org.wso2.micro.integrator.business.messaging.hl7.transport.HL7TransportSender.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>protocol</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The transport protocol for the custom implementation. For example: hl7.</p>
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


## Message Mediation

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">
            
            <input name="55" type="checkbox" id="_tab_55">
                <label class="tab-selector" for="_tab_55"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
<pre><code class="toml">[mediation]
synapse.core_threads = 20
synapse.max_threads = 100
synapse.threads_queue_length = 10

synapse.global_timeout_interval = "120000ms"

synapse.enable_xpath_dom_failover=true
synapse.temp_data_chunk_size=3072

synapse.command_debugger_port=9005
synapse.event_debugger_port=9006

synapse.script_mediator_pool_size=15
synapse.enable_xml_nil=false
synapse.disable_auto_primitive_regex = "^-?(0|[1-9][0-9]*)(\\.[0-9]+)?([eE][+-]?[0-9]+)?$"
synapse.disable_custom_replace_regex = "@@@"
synapse.enable_namespace_declaration = false
synapse.build_valid_nc_name = false
synapse.enable_auto_primitive = false
synapse.json_out_auto_array = false
synapse.preserve_namespace_on_xml_to_json=false
flow.statistics.enable=false
flow.statistics.capture_all=false
statistics.enable_clean=true
statistics.clean_interval = "1000ms"
stat.tracer.collect_payloads=false
stat.tracer.collect_mediation_properties=false
inbound.core_threads = 20
inbound.max_threads = 100</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[mediation]</code>
                            <span class="badge-required">Required</span>
                            <p>
                                This configuration header groups the parameters used for tuning the mediation process (Synapse engine) of the Micro Integrator. These parameters are mainly used when mediators such as Iterate and Clone (which uses the internal thread pools) are used.
                            </p>
                        </div>
                        <div class="params-wrap">
                            <div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>synapse.core_threads</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>20</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The initial number of synapse threads in the pool. This parameter is applicable only if the Iterate and Clone mediators are used to handle a higher load. These mediators use a thread pool to create new threads when processing messages and sending messages in parallal. You can configure the size of the thread pool by this parameter. The number of threads specified via this parameter should be increased as required to balance an increased load. Increasing the value specified for this parameter results in higher performance of the Iterate and Clone mediators.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>synapse.max_threads</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>100</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The maximum number of synapse threads in the pool. This parameter is applicable only if the Iterate and Clone mediators are used to handle a higher load. The number of threads specified for this parameter should be increased as required to balance an increased load.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>synapse.threads_queue_length</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>10</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The length of the queue that is used to hold the runnable tasks that are to be executed by the pool. This parameter is applicable only if the Iterate and Clone mediators are used to handle a higher load. You can specify a finite value as the queue length by giving any positive number. If this parameter is set to (-1) it means that the task queue length is infinite. If the queue length is finite, there can be situations where requests are rejected when the task queue is full and all the cores are occupied. If the queue length is infinite, and if some thread locking happens, the server can go out of memory. Therefore, you need to decide on an optimal value based on the actual load.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>synapse.global_timeout_interval</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>120000</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The maximum number of milliseconds within which a response for the request should be received. A response that arrives after the specified number of seconds cannot be correlated with the request. Hence, a warning will be logged and the request will be dropped. This parameter is also referred to as the time-out handler.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>synapse.enable_xpath_dom_failover</code> </span>
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
                                            <span class="param-possible-values">Possible Values: <code>&quot;true&quot; or &quot;false&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>If this parameter is set to true, the Micro Integrator can switch to XPATH 2.0. This parameter can be set to false if XPATH 2.0 evaluations cause performance degradation. The Micro Integrator uses the Saxon Home Edition when implementing XPATH 2.0 functionalities, and thus supports all the functions that are shipped with it. For more information on the supported functions, see the Saxon Documentation.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>synapse.temp_data_chunk_size</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>3072</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The message size that can be processed by the Micro Integrator.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>synapse.script_mediator_pool_size</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> integer </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>15</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>When using externally referenced scripts, this parameter specifies the size of the script engine pool that should be used per script mediator. The script engines from this pool are used for externally referenced script execution where updates to external scripts on an engine currently in use may otherwise not be thread safe. It is recommended to keep this value at a reasonable size since there will be a pool per externally referenced script.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>synapse.preserve_namespace_on_xml_to_json</code> </span>
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
                                            <span class="param-possible-values">Possible Values: <code>&quot;true&quot; or &quot;false&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Preserves the namespace declarations in the JSON output during XML to JSON message transformations.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>flow.statistics.enable</code> </span>
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
                                            <span class="param-possible-values">Possible Values: <code>&quot;true&quot; or &quot;false&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Set this property to true and enable statistics for the required integration artifact to record information such as the following: &lt;ul&gt;&lt;li&gt;The time spent on each mediator.&lt;/li&gt;&lt;li&gt;The time spent on processing each message.&lt;/li&gt;&lt;li&gt;The fault count of a single message flow.&lt;/li&gt;&lt;/ul&gt;</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>flow.statistics.enable</code> </span>
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
                                            <span class="param-possible-values">Possible Values: <code>&quot;true&quot; or &quot;false&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Set this property to &#39;true&#39; and set the flow.statistics.enable property also to &#39;true&#39;. This will enable mediation statistics for all the integration artifacts by default. If you set this property to &#39;false&#39;, you need to set the flow.statistics.enable property to &#39;true&#39; and manually enable statistics for the required integration artifact.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>statistics.enable_clean</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> boolean </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>true</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>&quot;true&quot; or &quot;false&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>If this parameter is set to true, all the existing statistics would be cleared before processing a request. This is recommended if you want to increase the processing speed.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>stat.tracer.collect_payloads</code> </span>
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
                                            <span class="param-possible-values">Possible Values: <code>&quot;true&quot; or &quot;false&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Set this property to true and enable tracing for the required integration artifact to record the message payload before and after the message mediation performed by individual mediators.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>stat.tracer.collect_mediation_properties</code> </span>
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
                                            <span class="param-possible-values">Possible Values: <code>&quot;true&quot; or &quot;false&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Set this property to true and enable tracing for the required integration artifact to record the following information:&lt;ul&gt;&lt;li&gt;Message context properties.&lt;/li&gt;&lt;li&gt;Message transport-scope properties.&lt;/li&gt;&lt;/ul&gt;</p>
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


## Synapse Handlers

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">
            
            <input name="56" type="checkbox" id="_tab_56">
                <label class="tab-selector" for="_tab_56"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
<pre><code class="toml">[[synapse_handlers]]
name = <handler_name>
class = <handler_class>
</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[[synapse_handlers]]</code>
                            <span class="badge-required">Required</span>
                            <p>
                                This configuration header is required for configuring a synapse handler with the name and the implementation class.
                            </p>
                        </div>
                        <div class="params-wrap">
                            <div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>name</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Name of the synapse handler.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>class</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The synapse handler implementation.</p>
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


## External Valut Configurations

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">
            
            <input name="57" type="checkbox" id="_tab_57">
                <label class="tab-selector" for="_tab_57"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
<pre><code class="toml">[[external_vault]]
name = "hashicorp"
address = "http://127.0.0.1:8200"
# When static authentication is used, apply the rootToken:
rootToken = "ROOT_TOKEN"
# When AppRole-pull method is used for authentication, apply the roleId and secretId:
roleId = "ROLE_ID"
secretId = "SECRET_ID"
cachableDuration = 15000
engineVersion = 2
namespace = "NAMESPACE"
trustStoreFile = "${carbon.home}/repository/resources/security/client-truststore.jks"
keyStoreFile = "${carbon.home}/repository/resources/security/wso2carbon.jks"
keyStorePassword = "KEY_STORE_PASSWORD"</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[[external_vault]]</code>
                            <span class="badge-required">Required</span>
                            <p>
                                This configuration header is required for configuring an external vault for secrets. Read more about <a href='{{base_path}}/install-and-setup/setup/mi-setup/security/using-hashicorp-secrets'>using HashiCorp sercrets</a>.
                            </p>
                        </div>
                        <div class="params-wrap">
                            <div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>name</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>hashicorp</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The name of the vault. For example, specify &#39;hashicorp&#39; when connecting to the HashiCorp vault.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>address</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The URL for connecting to the vault.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>rootToken</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Specify the root token generated from the HashiCorp server. This is only applicable if static token authentication is used when connecting the Micro Integrator to the HashiCorp server.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>roleId</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Specify the role ID generated from HashiCorp. The secret ID and role ID you specify in the deployment.toml file will internally generate a token and authenticate the HashiCorp server connection. The role ID is only applicable if AppRole Pull authentication is used when connecting the Micro Integrator to the HashiCorp server.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>secretId</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Specify the secret ID generated from HashiCorp. The secret ID and role ID you sepecify in the deployment.toml file will internally generate a token and authenticate the HashiCorp server connection. The secret ID you generate in HashiCorp may expire. If that happens, you can renew the security token. The secret ID is only applicable if AppRole Pull authentication is used when connecting the Micro Integrator to the HashiCorp server.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>cachableDuration</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>15000</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>All resources fetched from the HashiCorp vault would be cached for this number of milliseconds.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>engineVersion</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>2</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The version of the HashiCorp secret engine.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>namespace</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>-</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Namespace support is available only in the Enterprise edition of HashiCorp. The namespace value specified here applies globally to HashiCorp secrets in all synapse configurations.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>trustStoreFile</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>${carbon.home}/repository/resources/security/client-truststore.jks</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The keystore file (trust store) that is used to store the digital certificates that the Micro Integrator trusts for SSL communication.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>keyStoreFile</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>${carbon.home}/repository/resources/security/wso2carbon.jks</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>This keystore used for SSL handshaking when the Micro Integrator communicates with the HashiCorp server.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>keyStorePassword</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>wso2carbon</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The password of the keystore file that is used for SSL communication. If you are using the default keystore file in the Micro Integrator, the default password is &#39;wso2carbon&#39;.</p>
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

