# Micro Integrator Dashboard Configuration Catalog

All the server-level configurations of your Micro Integrator Dashboard can be applied using a single configuration file, which is the `deployment.toml` file (stored in the `MI_DASHBOARD_HOME/conf` directory).

The complete list of configuration parameters that you can use in the `deployment.toml` file are listed below along with descriptions.

## Instructions for use

To update the product configurations:

1. Open the `deployment.toml` file (stored in the `MI_DASHBOARD_HOME/conf` directory).
2. Select the required configuration headers and parameters from the list given below and apply them to the `deployment.toml` file.

The **default** `deployment.toml` file of the Micro Integrator Dashboard is as follows:

```toml
[server_config]
port = 9743

[heartbeat_config]
pool_size = 15

[mi_user_store]
username = "admin"
password = "admin"

[keystore]
file_name = "conf/security/dashboard.jks"
password = "wso2carbon"
key_password = "wso2carbon"
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
<pre><code class="toml">[server_config]
port = 9743
</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[server_config]</code>
                            <span class="badge-required">Required</span>
                            <p>
                                This configuration header is required for configuring the deployment parameters that are used for identifying a Micro Integrator Dashboard server.
                            </p>
                        </div>
                        <div class="params-wrap">
                            <div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>port</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type integer"> integer </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>9743</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The port of the Micro Integrator Dashboard.</p>
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

## Heart beat

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">
            
            <input name="3" type="checkbox" id="_tab_3">
                <label class="tab-selector" for="_tab_3"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
<pre><code class="toml">[heartbeat_config]
pool_size = 15
</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[heartbeat_config]</code>
                            <span class="badge-required">Required</span>
                            <p>
                                This configuration header is required for the Micro Integrator dashboard server to listen to the Micro Inetgrator runtimes.
                            </p>
                        </div>
                        <div class="params-wrap">
                            <div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>pool_size</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type integer"> integer </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>15</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The Micro Integrator Dashboard uses a thread pool executor to create threads and to handle incoming requests from Micro Integrator runtimes. This parameter controls the number of threads used by the executor pool.</p>
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

## Micro Integrator User Store

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">
            
            <input name="4" type="checkbox" id="_tab_4">
                <label class="tab-selector" for="_tab_4"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
<pre><code class="toml">[mi_user_store]
username = "admin"
password = "admin"
</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[mi_user_store]</code>
                            <span class="badge-required">Required</span>
                            <p>
                                This configuration header is required for the Micro Integrator dashboard server to connect with the Micro Integrator instances.
                            </p>
                        </div>
                        <div class="params-wrap">
                            <div class="param">
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
                                            <span class="param-default-value">Default: <code>&quot;admin&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The user name for signing in to the Micro Integrator runtimes.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
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
                                            <span class="param-default-value">Default: <code>&quot;admin&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The user password for signing in to the Micro Integrator runtimes.</p>
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

## Keystore

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">
            
            <input name="5" type="checkbox" id="_tab_5">
                <label class="tab-selector" for="_tab_5"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
<pre><code class="toml">[keystore]
file_name = "conf/security/dashboard.jks"
password = "wso2carbon"
key_password = "wso2carbon"</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[keystore]</code>
                            <span class="badge-required">Required</span>
                            <p>
                                This configuration header is used for SSL handshaking when the server communicates with the web browser.
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
                                            <span class="param-default-value">Default: <code>conf/security/dashboard.jks</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>-</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The name of the keystore file that is used for SSL communication.</p>
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
                                        <p>The password of the keystore file that is used for SSL communication. The keystore password is used when accessing the keys in the keystore.</p>
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
                                        <p>The password of the private key that is included in the keystore.</p>
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
file_name="con/security/wso2truststore.jks"
password="wso2carbon"</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[truststore]</code>
                            <p>
                                This configuration header is required for configuring the parameters that connect the Micro Integrator Dashboard to the keystore file (trust store) that is used to store the digital certificates that the server trusts for SSL communication.
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
                                    </div>
                                    <div class="param-description">
                                        <p>The path of the keystore file that is used for storing the trusted digital certificates.</p>
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
                                    </div>
                                    <div class="param-description">
                                        <p>The password of the keystore file that is used as the trust store.</p>
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

## Single Sign-On

!!! note
	-	Upgrade Micro Integrator Dashboard to version 4.0.1 or above to enable this feature.
	-	This feature was tested with WSO2 IS 5.10.0 and Shibboleth 4.1.2. There may be compatibility issues when using other vendors.

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">
            
            <input name="7" type="checkbox" id="_tab_7">
                <label class="tab-selector" for="_tab_7"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
<pre><code class="toml">[sso]
enable = true
client_id = "abcqet54mfD6t5d7"
base_url = "https://localhost/oauth2"
jwt_issuer = "https://localhost/oauth2"
resource_server_URLs = ["https://localhost:9743"]
sign_in_redirect_URL = "https://localhost:9743/sso"
admin_group_attribute = "groups"
admin_groups = ["admin", "tester"]

[[sso.authorization_request.params]]
key = "app_id"
value = "C123d"

</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[sso]</code>
                            <span class="badge-required">Required</span>
                            <p>
                                This configuration header is required for configuring Single Sign-on with OpenID Connect</a>.
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
                                            <span class="param-type boolean"> boolean </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>false</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>true or false</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Use this paramater to enable Single Sign-On.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>client_id</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                    </div>
                                    <div class="param-description">
                                        <p>Specify the client ID generated from the Identity Provider.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>base_url</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                    </div>
                                    <div class="param-description">
                                        <p>The URL of the Identity Provider.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>well_known_endpoint</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                        </p>
                                    </div>
                                    <div class="param-description">
                                        <p>The well known endpoint that is used to get the OpenID Connect metadata of your Identity Provider.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>jwt_issuer</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>                                        
                                    </div>
                                    <div class="param-description">
                                        <p>The Identity Provider's issuer identifier.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>override_well_known_endpoint</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type boolean"> boolean </span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>false</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>true or false</code></span>
                                        </div>
                                        
                                    </div>
                                    <div class="param-description">
                                        <p>Use this paramater to manually define the OpenID Connect endpoints of the Identity Provider. When overriding is enabled, you need to define authorization, token, user-info, token-revocation, introspection and logout endpoints.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>jwks_endpoint</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                        </p>                                        
                                    </div>
                                    <div class="param-description">
                                        <p>The Jwks endpoint URL.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>authorization_endpoint</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                        </p>         
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>&quot;/oauth2/authorize&quot;</code></span>
                                        </div>                               
                                    </div>
                                    <div class="param-description">
                                        <p>The authorization endpoint URL.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>token_endpoint</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                        </p>         
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>&quot;/oauth2/token&quot;</code></span>
                                        </div>                               
                                    </div>
                                    <div class="param-description">
                                        <p>The token endpoint URL.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>user_info_endpoint</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                        </p>                           
                                    </div>
                                    <div class="param-description">
                                        <p>The user info endpoint URL.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>revocation_endpoint</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                        </p>         
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>&quot;/oauth2/revoke&quot;</code></span>
                                        </div>                               
                                    </div>
                                    <div class="param-description">
                                        <p>The token revocation endpoint URL.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>introspection_endpoint</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                        </p>                         
                                    </div>
                                    <div class="param-description">
                                        <p>The introspection endpoint URL.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>end_session_endpoint</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                        </p>         
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>&quot;/oidc/logout&quot;</code></span>
                                        </div>                               
                                    </div>
                                    <div class="param-description">
                                        <p>The logout endpoint URL.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>resource_server_URLs</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type array"> array </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>["https://localhost:9743"]</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>[&quot;https://{hostname/ip}:{port}&quot;]</code></span>
                                        </div>                                        
                                    </div>
                                    <div class="param-description">
                                        <p>The URL of the Micro Integrator Dashboard. Be sure to replace {hostname/ip} and {port} with the relevant values.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>sign_in_redirect_URL</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>&quot;https://localhost:9743/sso&quot;</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>&quot;https://{hostname/ip}:{port}/sso&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The Sign In redirect URL of the Micro Integrator Dashboard. Be sure to replace {hostname/ip} and {port} with the relevant values.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>sign_out_redirect_URL</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>&quot;https://localhost:9743&quot;</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>&quot;https://{hostname/ip}:{port}&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The Sign Out redirect URL of the Micro Integrator Dashboard. Be sure to replace {hostname/ip} and {port} with the relevant values.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>admin_group_attribute</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                        </p>
                                    </div>
                                    <div class="param-description">
                                        <p>The claim name used by the Identity Provider to determine the group of the user.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>admin_groups</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type array"> array </span>
                                        </p>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>[&quot;publisher&quot;, &quot;tester&quot;, &quot;any group assigned to the users&quot;]</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The groups which are used to grant admin privileges to users. If the user belongs to any of the defined groups, that user is considered as an Admin user.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>enable_PKCE</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type boolean"> boolean </span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>true</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>true or false</code></span>
                                        </div>
                                        
                                    </div>
                                    <div class="param-description">
                                        <p>Use this paramater to specify if a PKCE should be sent with the request for the authorization code.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>scope</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type array"> array </span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>["openid"]</code></span>
                                        </div>                                   
                                    </div>
                                    <div class="param-description">
                                        <p>Use this paramater to specify the requested scopes.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>user_name_attribute</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type array"> string </span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>&quot;sub&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Use this paramater to specify the attribute you need to use as the user name in the dashboard.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>additional_trusted_audience</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type array"> array </span>
                                        </p>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values: <code>[&quot;account&quot;, &quot;finance&quot;, &quot;additional trusted audience other than client id&quot;]</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The additional audience apart from the <code>client_id</code> configured in sso configs.</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[[sso.authorization_request.params]]</code>
                            <p>
                                This configuration header is required for defining custom parameters that needs to be sent with the Authorization request to the Identity Provider.
                            </p>
                        </div>
                        <div class="params-wrap">
                            <div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>key</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                        </p>
                                    </div>
                                    <div class="param-description">
                                        <p>Use this parameter to specify the key of the parameter you want to send with the authorization request.</p>
                                    </div>
                                </div>
                            </div><div class="param">
                                <div class="param-name">
                                  <span class="param-name-wrap"> <code>value</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                        </p>
                                    </div>
                                    <div class="param-description">
                                        <p>Use this parameter to specify the value of the parameter you want to send with the authorization request.</p>
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
