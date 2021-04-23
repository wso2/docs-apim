# Configuration Catalog
This document describes all the configuration parameters that are used in WSO2 Identity Server.

## Instructions for use

> Select the configuration sections, parameters, and values that are required for your use and add them to the .toml
file. See the example .toml file given below.

```toml
# This is an example .toml file.

[server]
pattern="value"
enable_port_forward=true

[key_mgr_node]
endpoints="value"

[gateway]
gateway_environments=["dev","test"]

[[database]]
pool_options.maxActiv=5

```




## Super admin configurations

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">

                <input name="2" type="checkbox" id="_tab_2">
                <label class="tab-selector" for="_tab_2"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
                        <pre><code class="toml">[super_admin]
username = "admin"
password = "admin"
create_admin_account = true</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[super_admin]</code>
                            <span class="badge-required">Required</span>
                            <p>
                                This includes the configurations related to the super admin user.
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

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>admin</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>super admin username</p>
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

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>admin</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>super admin password</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>create_admin_account</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>TRUE</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>Set this to true to create a new user with the super admin details given.</p>
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


## Connecting to the primary data store

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">

                <input name="3" type="checkbox" id="_tab_3">
                <label class="tab-selector" for="_tab_3"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
                        <pre><code class="toml">[server]
hostname="localhost"
node_ip="127.0.0.1"
enable_mtom=false
enable_swa=false</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[server]</code>
                            <span class="badge-required">Required</span>
                            <p>
                                This groups the parameters that define the server node details.
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
                                            <span class="param-default-value">Default:
                                                <code>&quot;localhost&quot;</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values:
                                                <code>&quot;127.0.0.1&quot;,&quot;localhost&quot;,&quot;&lt;any-ip-address&gt;&quot;</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>The hostname of the WSO2 API-M server instance.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>node_ip</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default:
                                                <code>&quot;127.0.0.1&quot;</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>The IP address of the server node.</p>
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


## Enabling the H2 database console

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">

                <input name="4" type="checkbox" id="_tab_4">
                <label class="tab-selector" for="_tab_4"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
                        <pre><code class="toml">[database_configuration]
enable_h2_console = true</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[database_configuration]</code>

                            <p>
                                Configurations required to enable browsing the H2 database from a web browser.
                            </p>
                        </div>
                        <div class="params-wrap">
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>enable_h2_console</code> </span>
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
                                            <span class="param-possible-values">Possible Values:
                                                <code>true, false</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>True when required to browser the H2 database from a browser. False when not.
                                        </p>
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


## Database configurations

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">

                <input name="5" type="checkbox" id="_tab_5">
                <label class="tab-selector" for="_tab_5"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
                        <pre><code class="toml">[database.apim_db]
type = "h2"
url = "jdbc:h2:./repository/database/WSO2AM_DB;DB_CLOSE_ON_EXIT=FALSE"
username = "wso2carbon"
password = "wso2carbon"</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[database.apim_db]</code>
                            <span class="badge-required">Required</span>
                            <p>
                                Database configurations related to API Manager
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
                                            <span class="param-default-value">Default: <code>h2</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values:
                                                <code>mysql,h2,mssql,postgre,oracle,db2</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Database vendor</p>
                                    </div>
                                </div>
                            </div>
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
                                            <span class="param-default-value">Default: <code></code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>You can use either hostname and port or the URL(given below). If you specify
                                            the URL the hostname and port will be overridden.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
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
                                            <span class="param-default-value">Default: <code></code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p></p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>url</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default:
                                                <code>jdbc:h2:repository/database/WSO2AM_DB;DB_CLOSE_ON_EXIT=FALSE</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>The connection URL is required when you use the h2 db.

                                            You have to add the URL to use the JDBC properties listed below. Otherwise
                                            it is optional.</p>
                                    </div>
                                </div>
                            </div>
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
                                            <span class="param-default-value">Default: <code>wso2carbon</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>The username used to create a connection to the database.</p>
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
                                            <span class="param-default-value">Default: <code>wso2carbon</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>The password used to create a connection to the database.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>*validationQuery</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>SELECT 1</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p> The value changes according to the Database query</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>pool_options.maxActive</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>50</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>The maximum number of active connections that can be allocated from the
                                            connection pool at the same time. Change according to the preferred
                                            database.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>pool_options.maxWait</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>60000</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>The maximum time that requests are expected to wait in the queue for a
                                            connection to be released. This property comes into effect when the maximum
                                            number of active connections allowed in the connection pool (see maxActive
                                            property) is used up.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>pool_options.testOnBorrow</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>TRUE</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>The indication of whether connection objects will be validated before they
                                            are borrowed from the pool. If the object validation fails, the connection
                                            is dropped from the pool, and there will be an attempt to borrow another
                                            connection.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>pool_options.validationInterval</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>30000</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>This parameter controls how frequently a given validation query is executed
                                            (time in milliseconds). That is, if a connection is due for validation, but
                                            has been validated previously within this interval, it will not be validated
                                            again.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>pool_options.defaultAutoCommit</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>TRUE</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>When auto committing is enabled, each SQL statement will be committed to the
                                            database as an individual transaction, as opposed to committing multiple
                                            statements as a single transaction.</p>
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


## Shared database configurations

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">

                <input name="6" type="checkbox" id="_tab_6">
                <label class="tab-selector" for="_tab_6"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
                        <pre><code class="toml">[database.shared_db]
type = "h2"
url = "jdbc:h2:./repository/database/WSO2SHARED_DB;DB_CLOSE_ON_EXIT=FALSE"
username = "wso2carbon"
password = "wso2carbon"</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[database.shared_db]</code>
                            <span class="badge-required">Required</span>
                            <p>
                                Configurations related to the databases shared between nodes
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

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>h2</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values:
                                                <code>mysql,h2,mssql,postgre,oracle,db2</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Database type</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>url</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default:
                                                <code>jdbc:h2:repository/database/WSO2SHARED_DB;DB_CLOSE_ON_EXIT=FALSE</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>connection url</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>username</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>wso2carbon</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>username</p>
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

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>wso2carbon</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>password</p>
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


## JWT Configurations

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">

                <input name="7" type="checkbox" id="_tab_7">
                <label class="tab-selector" for="_tab_7"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
                        <pre><code class="toml">[apim.jwt]
enable = true
encoding = "base64"
generator_impl = "org.wso2.carbon.apimgt.keymgt.token.JWTGenerator"
claim_dialect = "http://wso2.org/claims"
header = "X-JWT-Assertion"
signing_algorithm = "SHA256withRSA"
enable_user_claims = true
claims_extractor_impl = "org.wso2.carbon.apimgt.impl.token.DefaultClaimsRetriever"</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[apim.jwt]</code>
                            <span class="badge-required">Required</span>
                            <p>
                                Enable APIM to generate a JWT within itself.

                                JSON Web Token (JWT) is used to represent claims that are transferred between two
                                parties such as the end-user and the backend.
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
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>FALSE</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values:
                                                <code>true, false</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Enable JWT.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>encoding</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>base64</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values:
                                                <code>base64,base64url</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Use base64 encoding for the default JWT generator.

                                            Use the url-safe JWT generator if it is base64url.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>generator_impl</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code></code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>This can be defined as a custom generation implmetation.

                                            If this is defined, the &quot;apim.jwt.encoding&quot; will be ignored.

                                            Note that this should be the fully-qualified class name.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>header</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default:
                                                <code>X-JWT-Assertion</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>The HTTP header name used to send the JWT generated prev.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>enable_user_claims</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>FALSE</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values:
                                                <code>FALSE</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>No user store claims included in the JWT if false. </p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>enable_user_claims</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>FALSE</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values:
                                                <code>TRUE</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>THe default user claims will be added to the JWT</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>claims_extractor_impl</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code></code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>You can define the custom claim retiriver implmentation by adding the
                                            following
                                            apim.jwt.enable_user_claims=true.

                                            Make sure that it is the fully-qualified class name.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>claim_dialect</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default:
                                                <code>http://wso2.org/claims</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>A set of claims are identified as a dialect. Different dialects represent the
                                            same piece of information with different claim URIs.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>signing_algorithm</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>SHA256withRSA</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values:
                                                <code>NONE</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Specify NONE to disbale the sigining.</p>
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


## API-M gateway environment configurations

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">

                <input name="8" type="checkbox" id="_tab_8">
                <label class="tab-selector" for="_tab_8"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
                        <pre><code class="toml">[[apim.gateway.environment]]
name = "Production and Sandbox"
type = "hybrid"
display_in_api_console = true
description = "This is a hybrid gateway that handles both production and sandbox token traffic."
show_as_token_endpoint_url = true
service_url = "https://localhost:${mgt.transport.https.port}/services/"
username = "admin"
password = "admin"
ws_endpoint = "ws://localhost:9099"
http_endpoint = "http://localhost:${http.nio.port}"
https_endpoint = "https://localhost:${https.nio.port}"</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[apim.gateway.environment]</code>
                            <span class="badge-required">Required</span>
                            <p>
                                Configuring the gateways used by API Manager.
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
                                            <span class="param-default-value">Default:
                                                <code>Production and Sandbox</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>User can add preferred values as the name.</p>
                                    </div>
                                </div>
                            </div>
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
                                            <span class="param-default-value">Default: <code>hybrid</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values:
                                                <code>production, sandbox, hybrid</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p></p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>display_in_api_console  </code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>TRUE</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>Displays the environment under &#39;Try it&#39; in the API Store, in the API
                                            console.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>description</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default:
                                                <code>This is a hybrid gateway that handles both production and sandbox token traffic.</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>Describe the function of the gateway here.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>show_as_token_endpoint_url  </code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>TRUE</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>Use to construct the sample curl request in the API Store.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>service_url</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default:
                                                <code>https://localhost:9443/services/</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>APIs will be published using this URL</p>
                                    </div>
                                </div>
                            </div>
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
                                            <span class="param-default-value">Default:
                                                <code>$conf{super_admin.username}</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>Credentials used to publish APIs</p>
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
                                            <span class="param-default-value">Default:
                                                <code>$conf{super_admin.password}</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>Credentials used to publish APIs</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>ws_endpoint</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default:
                                                <code>no default value</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>E.g., ws://localhost:9099</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>https_endpoint</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default:
                                                <code>no default value</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>https://localhost:8243/</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>http_endpoint</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default:
                                                <code>no default value</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>http://localhost:8280/</p>
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


## Gateway token cache

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">

                <input name="9" type="checkbox" id="_tab_9">
                <label class="tab-selector" for="_tab_9"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
                        <pre><code class="toml">[apim.cache.gateway_token]
enable = true
expiry_time = "900s"
</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[apim.cache.gateway_token]</code>
                            <span class="badge-required">Required</span>
                            <p>

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
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>TRUE</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>Enable the gateway token cache. WSO2 recommends to enable this feature by
                                            default. The token validation request checks with the cached value.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>expiry_time</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>15 m</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>Set the cache expiry time in minutes. Recommended value is 15 minutes.</p>
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


## Cache resource

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">

                <input name="10" type="checkbox" id="_tab_10">
                <label class="tab-selector" for="_tab_10"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
                        <pre><code class="toml">[apim.cache.resource]
enable = true
expiry_time = "900s"</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[apim.cache.resource]</code>
                            <span class="badge-required">Required</span>
                            <p>

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
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>TRUE</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>Enable the gateway resource cache. Caches the API resources at the gateway.
                                            Expires in 15 minutes.</p>
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


## Cache Keymanager token

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">

                <input name="11" type="checkbox" id="_tab_11">
                <label class="tab-selector" for="_tab_11"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
                        <pre><code class="toml">[apim.cache.km_token]
enable = false
expiry_time = "15m"</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[apim.cache.km_token]</code>
                            <span class="badge-required">Required</span>
                            <p>

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
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>FALSE</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>Enable the Key Manager token cache. The token validation request checks with
                                            the value cached at the Key Manager. At any given time you should only have
                                            one cache enabled, which is either the Key Manager cache or the API Gateway
                                            cache. WSO2 does not recommend using both caches at the same time.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>expiry_time</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>15 m</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>Set the cache expiry time.</p>
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


## Cache recent APIs

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">

                <input name="12" type="checkbox" id="_tab_12">
                <label class="tab-selector" for="_tab_12"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
                        <pre><code class="toml">[apim.cache.recent_apis]
enable = false</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[apim.cache.recent_apis]</code>
                            <span class="badge-required">Required</span>
                            <p>

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
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>FALSE</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>Enable cache for recently added apis in the API Store. This expires in 15
                                            minutes by default.</p>
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


## Cache scopes

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">

                <input name="13" type="checkbox" id="_tab_13">
                <label class="tab-selector" for="_tab_13"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
                        <pre><code class="toml">[apim.cache.scopes]
enable = true
</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[apim.cache.scopes]</code>
                            <span class="badge-required">Required</span>
                            <p>

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
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>TRUE</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>Enabel cache for scopes. This expires in 15 minutes by default.</p>
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


## Cache publisher roles

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">

                <input name="14" type="checkbox" id="_tab_14">
                <label class="tab-selector" for="_tab_14"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
                        <pre><code class="toml">[apim.cache.publisher_roles]
enable = true</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[apim.cache.publisher_roles]</code>
                            <span class="badge-required">Required</span>
                            <p>

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
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>TRUE</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>Enable cache for publisher roles. Expires in 15 minutes by default</p>
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


## Cache JWT claims

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">

                <input name="15" type="checkbox" id="_tab_15">
                <label class="tab-selector" for="_tab_15"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
                        <pre><code class="toml">[apim.cache.jwt_claim]
enable = true
expiry_time = "15m"</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[apim.cache.jwt_claim]</code>
                            <span class="badge-required">Required</span>
                            <p>

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
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>TRUE</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>Enable JWT claim cache. The user&#39;s claims used to create the JWT are
                                            cached.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>expiry_time</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>Not defined</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>Set the cache expiry time. Would be same as the JWT expiry time.</p>
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


## Cache tags

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">

                <input name="16" type="checkbox" id="_tab_16">
                <label class="tab-selector" for="_tab_16"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
                        <pre><code class="toml">[apim.cache.tags]
expiry_time = "2m"</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[apim.cache.tags]</code>
                            <span class="badge-required">Required</span>
                            <p>

                            </p>
                        </div>
                        <div class="params-wrap">
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>expiry_time</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>2m</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>Set when the tag cache expires. This option is disabled when not defined.</p>
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


## API-M Analytics configurations

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">

                <input name="17" type="checkbox" id="_tab_17">
                <label class="tab-selector" for="_tab_17"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
                        <pre><code class="toml">[apim.analytics]
enable = false
store_api_url = "https://localhost:7444"
username = "$ref{super_admin.username}"
password = "$ref{super_admin.password}"
event_publisher_type = "default"
event_publisher_type = "custom"
event_publisher_impl = "org.wso2.carbon.apimgt.usage.publisher.APIMgtUsageDataBridgeDataPublisher"
publish_response_size = true</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[apim.analytics]</code>
                            <span class="badge-required">Required</span>
                            <p>

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
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>FALSE</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>Set TRUE to enable analytics in API Manager</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>store_api_url</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default:
                                                <code>https://localhost:7444</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>The Store REST API URL for Analytics. If there are mutiple analytics node,
                                            use the loadbalancing URL</p>
                                    </div>
                                </div>
                            </div>
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
                                            <span class="param-default-value">Default:
                                                <code>Credentials of the super admin user.</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>Credentials of the super admin user, in the analytics node</p>
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
                                            <span class="param-default-value">Default:
                                                <code>Credentials of the super admin user.</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>Credentials of the super admin user, in the analytics node</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>receiver_username</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default:
                                                <code>Uses the &quot;apim.analytics.username&quot;</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>Change this if a specific user is required for event publishing.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>receiver_password</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default:
                                                <code>Uses the &quot;apim.analytics.password&quot;</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>Change this if a specific user is required for event publishing.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>store_api_username</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default:
                                                <code>use apim.analytics.username</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>Change this if a specific user is required to access the Store REST API.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>store_api_password</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default:
                                                <code>use apim.analytics.password</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>Change this if a specific user is required to access the Store REST API.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>event_publisher_impl</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code></code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>If you have defined a custom &quot;event_publisher_type&quot;, the custom
                                            publisher needs to be defined to the following value

                                            &#39;event_publisher_impl =
                                            &quot;org.wso2.carbon.apimgt.usage.publisher.APIMgtUsageDataBridgeDataPublisher&quot;
                                        </p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>publish_response_size</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>FALSE</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>Set TRUE to enable and define size of the publisher response sent to
                                            Analytics. Size is set bytes.</p>
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


## API-M Analytics - URL group configurations

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">

                <input name="18" type="checkbox" id="_tab_18">
                <label class="tab-selector" for="_tab_18"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
                        <pre><code class="toml">#LOADBALANCER CONFIGS
[[apim.analytics.url_group]]
analytics_url =["tcp://analytics1:7611","tcp://analytics2:7611"]
analytics_auth_url =["ssl://analytics1:7711","ssl://analytics2:7711"]
type = "loadbalance"

#FAILOVER CONFIGS
[[apim.analytics.url_group]]
analytics_url =["tcp://analytics1:7612","tcp://analytics2:7612"]
analytics_auth_url =["ssl://analytics1:7712","ssl://analytics2:7712"]
type = "failover"</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[apim.analytics.url_group]</code>
                            <span class="badge-required">Required</span>
                            <p>

                            </p>
                        </div>
                        <div class="params-wrap">
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code></code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code></code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>Define each analytics node that the API Manager will connect to, as an array.
                                            If there are mutiple node, you need to define this configuration for each
                                            node.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>analytics_url</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default:
                                                <code>tcp://localhost:7612</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>The list of server URLs

                                            e.g.,: analytics_url = [&quot;tcp: //localhost:7611,
                                            tcp://localhost:7611&quot;]&quot;</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>analytics_auth_url</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default:
                                                <code>ssl://localhost:7712</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>The list of auth server URLs

                                            e.g.,: analytics_auth_url = [&quot;ssl:
                                            //localhost:7711,ssl://localhost:7711&quot;]</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>type</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default:
                                                <code>no default value</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>Loadbalance or Failover</p>
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


## API-M Key Manager related configurations

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">

                <input name="19" type="checkbox" id="_tab_19">
                <label class="tab-selector" for="_tab_19"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
                        <pre><code class="toml">[apim.key_manager]
service_url = "https://localhost:${mgt.transport.https.port}/services/"
username = "$ref{super_admin.username}"
password = "$ref{super_admin.password}"
pool.init_idle_capacity = 50
pool.max_idle = 100
key_validation_handler_type = "default"
key_validation_handler_type = "custom"
key_validation_handler_impl = "org.wso2.carbon.apimgt.keymgt.handlers.DefaultKeyValidationHandler"</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[apim.key_manager]</code>
                            <span class="badge-required">Required</span>
                            <p>

                            </p>
                        </div>
                        <div class="params-wrap">
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>service_url</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default:
                                                <code>https://localhost:9443/services/</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>URL that offers services of the KM</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>username</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default:
                                                <code>Credentials of the super admin user.</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>Credentials of the super admin user, in the Key Manager node.</p>
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

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default:
                                                <code>Credentials of the super admin user.</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>Credentials of the super admin user, in the Key Manager node.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>pool.init_idle_capacity</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>50</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>Minimum no. of clients created, to connect to the key manager.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>pool.max_idle</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>100</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>Maximum no. of clients created, to connect to the key manager.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>key_validation_handler_type</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>default</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values:
                                                <code>default or custom</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>If custom, then provide the &quot;key_validation_handler_impl&quot; value</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>key_validation_handler_impl</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code></code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>You can provide a custom key validation handler implmentation. To do this,
                                            set the &quot;key_validation_handler_type&quot; to custom</p>
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


## API-M OAuth configurations

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">

                <input name="20" type="checkbox" id="_tab_20">
                <label class="tab-selector" for="_tab_20"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
                        <pre><code class="toml">[apim.oauth_config]
enable_outbound_auth_header = false
auth_header = "Authorization"
revoke_endpoint = "https://localhost:${https.nio.port}/revoke"
enable_token_encryption = false
enable_token_hashing = false</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[apim.oauth_config]</code>
                            <span class="badge-required">Required</span>
                            <p>
                                Collection of OAuth related configs
                            </p>
                        </div>
                        <div class="params-wrap">
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>enable_outbound_auth_header</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>FALSE</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>If TRUE, sends Auth header to the backend as received from the client.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>auth_header</code> </span>
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
                                            <span class="param-possible-values">Possible Values:
                                                <code>Any custom value</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Valid authorization header for OAuth configurations.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>revoke_endpoint</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default:
                                                <code>https://localhost:8243/revoke</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values:
                                                <code>Valid URL for revocation endpoint.</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Token revocation endpoint used in the API Store</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>enable_token_encryption</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>FALSE</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>If set to TRUE, the token stored in the database will be encrypted/decrypted
                                            when reading and storing.

                                            RSA/ECB/OAEPwithSHA1andMGF1PaddingIf FALSE - Setting Up OAuth Token
                                            Encryption | Extension Points for OAuth - IS Docs</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>enable_token_hashing</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>FALSE</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>Similar to prev. Get desc from IS docs</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>allowed_scopes</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default:
                                                <code>[&quot;^device_.*,openid&quot;]</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>List of allowlisted scopes. Take desc from Key Concepts page.</p>
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


## API-M Developer Portal configurations

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">

                <input name="21" type="checkbox" id="_tab_21">
                <label class="tab-selector" for="_tab_21"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
                        <pre><code class="toml">[apim.devportal]
url = "https://localhost:${mgt.transport.https.port}/devportal"
enable_application_sharing = false
if application_sharing_type, application_sharing_impl both defined priority goes to application_sharing_impl
application_sharing_type = "default" changed type, saml, default todo: check the new config for rest api
application_sharing_impl = "org.wso2.carbon.apimgt.impl.SAMLGroupIDExtractorImpl"
display_multiple_versions = false
display_deprecated_apis = false
enable_comments = true
enable_ratings = true
enable_forum = true</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[apim.devportal]</code>
                            <span class="badge-required">Required</span>
                            <p>
                                Configures the API Developer Portal
                            </p>
                        </div>
                        <div class="params-wrap">
                            <div class="param">
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
                                            <span class="param-default-value">Default:
                                                <code>https://localhost:9443/devportal</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>Public store URL</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>enable_application_sharing</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>FALSE</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>Enable application sharing according to the claims.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>application_sharing_type</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default:
                                                <code>If the config is not mentioned, then undefined.default</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values:
                                                <code>default, saml</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Use the application_sharing_impl as default implmentationIf it is saml, the
                                            group extractor extracts the claims to group the applications from the saml
                                            response.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>application_sharing_impl</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default:
                                                <code>Based on the application sharing type.</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>Need to define if the application_sharing_type is custom. If both
                                            application_sharing_type and application_sharing_impl is defined, take value
                                            from application_sharing_impl.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>login_username_case_insensitive</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>TRUE</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>Check with new UI</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>display_multiple_versions</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>FALSE</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>If TRUE displays all the versions of the API under the API listing (and
                                            search depending on the new UI)</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>display_deprecated_apis</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>FALSE</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>If TRUE displays all the deprecated APIs under the API listing (and search
                                            depending on the new UI)</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>enable_comments</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>TRUE</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>Can comment on the API</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>enable_ratings</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>TRUE</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>Enable rating the API with a star-based rating</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>enable_forum</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>TRUE</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>^</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>application_sharing_claim</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default:
                                                <code>http://wso2.org/claims/organization</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>The user claim used to group the applications.</p>
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


## API-M CORS configurations

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">

                <input name="22" type="checkbox" id="_tab_22">
                <label class="tab-selector" for="_tab_22"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
                        <pre><code class="toml">[apim.cors]
allow_origins = "*"
allow_methods = ["GET","PUT","POST","DELETE","PATCH","OPTIONS"]
allow_headers = ["authorization","Access-Control-Allow-Origin","Content-Type","SOAPAction"]
allow_credentials = false</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[apim.cors]</code>
                            <span class="badge-required">Required</span>
                            <p>
                                Configures CORS headers on the Publisher and the Gateway.
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
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>TRUE</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>CORS configurations are enabled by default.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>allow_origins</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>*</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>Denotes &quot;Access-Control-Allow-Origin&quot; response header. Specify an
                                            origin to share the response with.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>allow_methods</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default:
                                                <code>GET,PUT,POST,DELETE,PATCH,OPTIONS</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>Configures the methods allowed by the access control.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>allow_headers</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default:
                                                <code>authorization,Access-Control-Allow-Origin,Content-Type,SOAPAction</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>Configures the type of headers allowed by the access control.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>allow_credentials</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>FALSE</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>Specifying this header to true means that the server allows cookies (or other
                                            user credentials) to be included on cross-origin requests.

                                            It is false by default and if you set it to true then make sure that the
                                            Access-Control-Allow-Origin header does not contain the wildcard (*)</p>
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


## API-M Throttling configurations

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">

                <input name="23" type="checkbox" id="_tab_23">
                <label class="tab-selector" for="_tab_23"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
                        <pre><code class="toml">[apim.throttling]
enable_data_publishing = true
enable_policy_deploy = true
enable_blacklist_condition = true
enable_persistence = true
throttle_decision_endpoints = ["tcp://localhost:5672","tcp://localhost:5672"]</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[apim.throttling]</code>
                            <span class="badge-required">Required</span>
                            <p>
                                Configures API-M traffic control.
                            </p>
                        </div>
                        <div class="params-wrap">
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>event_type</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>Binary</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values:
                                                <code>Thrift</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>Binary - Uses the binary transport. Recommended.Thrift - Uses thrift tranport
                                        </p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>receiver_url</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default:
                                                <code>if None of this is defined consider it as tcp://${carbon.local.ip}:${receiver.url.port}</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>Define traffic manager connection url inline. If none of this is defined
                                            consider it as tcp://${carbon.local.ip}:${receiver.url.port}</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>receiver_url</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code></code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>Define array of traffic manager connections</p>
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


## API-M Throttling URL group configs

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">

                <input name="24" type="checkbox" id="_tab_24">
                <label class="tab-selector" for="_tab_24"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
                        <pre><code class="toml">[apim.throttling.blacklist_condition]
start_delay = "5m"
period = "1h"

[apim.throttling.jms]
start_delay = "5m"

[apim.throttling.event_sync]
hostName = "0.0.0.0"
port = 11224

[apim.throttling.event_management]
hostName = "0.0.0.0"
port = 10005

LOADBALANCE CONFIGS
[[apim.throttling.url_group]]
traffic_manager_urls = ["tcp://localhost:9611","tcp://localhost:9611"]
traffic_manager_auth_urls = ["ssl://localhost:9711","ssl://localhost:9711"]
type = "loadbalance"

FAILOVER CONFIGS
[[apim.throttling.url_group]]
traffic_manager_urls = ["tcp://localhost:9611","tcp://localhost:9611"]
traffic_manager_auth_urls = ["ssl://localhost:9711","ssl://localhost:9711"]
type = "failover"</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[apim.throttling.url_group]</code>
                            <span class="badge-required">Required</span>
                            <p>

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

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default:
                                                <code>super username</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>Credentials of the Traffic Manager user.</p>
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

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default:
                                                <code>super user password</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>Credentials of the Traffic Manager user.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>receiver_username</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default:
                                                <code>super username</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>If the username of the receiver is different, use the username of the
                                            receiver configured on the Traffic Manager.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>receiver_password</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default:
                                                <code>super user password</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>If the credentials of the receiver is different, use the password of the
                                            receiver configured on the Traffic Manager.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>policy_deploy.username</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default:
                                                <code>super username</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>If the credentials of the user is different, use the credentials of the user
                                            configured for deploying policies.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>policy_deploy.password</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default:
                                                <code>super user password</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>If the credentials of the user is different, use the credentials of the user
                                            configured for deploying policies.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>jms.username</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default:
                                                <code>super username</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>If the credentials of the user is different, use the credentials of the user
                                            configured for the JMS connection.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>jms.password</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default:
                                                <code>super user password</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>If the credentials of the user is different, use the credentials of the user
                                            configured for the JMS connection.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>publisher.max_idle</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>1000</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>Ideal values for the maximum no. of connections to the data publisher pool.
                                        </p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>publisher.init_idle_size</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>200</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>Ideal values for the minimum no. of connections to the data publisher pool.
                                        </p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>publisher.pool_size</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>200</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>The size of the thread pool in the API Publisher.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>publisher.max_pool_size</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>1000</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>The maximum size of the thread pool in the API Publisher.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>publisher.keep_alive_time</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>200s</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>The timeframe after which the publisher thread pool is terminated.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>service_url</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default:
                                                <code>https://localhost:${mgt.transport.https.port}${carbon.context}services/</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>Service URL of the Traffic Manager.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>blacklist_condition.start_delay</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>not defined</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>Define the delay time to get the blacklist conditions from the Keymanager.
                                        </p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>jms.destination</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>throttleData</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>JMS topic name</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>jms.start_delay</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>not define</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>Connection delay to read the Traffic Manager at startup.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>jms.conn_jndi_name</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default:
                                                <code>TopicConnectionFactory</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values:
                                                <code>custom value</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p></p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>jms.destination_type</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>topic</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p></p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>decision_connection_type</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>andes</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>Define the JMS type e.g.,: andes</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>jms.java_naming_factory_initial</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code></code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>Define JMS factory initials. If decision_connection_type is andes, this is
                                            &quot;org.wso2.andes.jndi.PropertiesFileInitialContextFactory&quot;</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>throttle_decision_endpoints</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code></code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>Define array of JMS connection as a array.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>enable_unlimited_tier</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>TRUE</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>Enable the unlimited tier.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>enable_header_based_throttling</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>FALSE</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>Enable the header condition based throttling. Advanced policies allow you to
                                            apply limits to APIs by filtering requests based on HTTP headers.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>enable_jwt_claim_based_throttling</code>
                                    </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>FALSE</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>Enable JWT claim based throtlling.</p>
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


## API-M Throttling URL group

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">

                <input name="25" type="checkbox" id="_tab_25">
                <label class="tab-selector" for="_tab_25"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
                        <pre><code class="toml">[apim.throttling.blacklist_condition]
start_delay = "5m"
period = "1h"

[apim.throttling.jms]
start_delay = "5m"

[apim.throttling.event_sync]
hostName = "0.0.0.0"
port = 11224

[apim.throttling.event_management]
hostName = "0.0.0.0"
port = 10005

LOADBALANCE CONFIGS
[[apim.throttling.url_group]]
traffic_manager_urls = ["tcp://localhost:9611","tcp://localhost:9611"]
traffic_manager_auth_urls = ["ssl://localhost:9711","ssl://localhost:9711"]
type = "loadbalance"

FAILOVER CONFIGS
[[apim.throttling.url_group]]
traffic_manager_urls = ["tcp://localhost:9611","tcp://localhost:9611"]
traffic_manager_auth_urls = ["ssl://localhost:9711","ssl://localhost:9711"]
type = "failover"</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[apim.throttling.url_group]</code>
                            <span class="badge-required">Required</span>
                            <p>

                            </p>
                        </div>
                        <div class="params-wrap">
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>traffic_manager_urls</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code></code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values:
                                                <code>TM binary server url</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p>[[apim.throttling.url_group]]traffic_manager_urls =
                                            [&quot;tcp://localhost:9611&quot;,&quot;tcp://localhost:9611&quot;]traffic_manager_auth_urls
                                            = [&quot;ssl://localhost:9711&quot;,&quot;ssl://localhost:9711&quot;]type =
                                            &quot;loadbalance&quot;</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>traffic_manager_auth_urls</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>
                                            <span class="badge-required">Required</span>
                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code></code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values:
                                                <code>TM binary auth server url</code></span>
                                        </div>
                                    </div>
                                    <div class="param-description">
                                        <p></p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>type</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>failover</code></span>
                                        </div>
                                        <div class="param-possible">
                                            <span class="param-possible-values">Possible Values:
                                                <code>failover,loadbalance</code></span>
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


## API-M Workflow configurations

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">

                <input name="26" type="checkbox" id="_tab_26">
                <label class="tab-selector" for="_tab_26"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
                        <pre><code class="toml">[apim.workflow]
enable = false
service_url = "https://localhost:9445/bpmn"
username = "$ref{super_admin.username}"
password = "$ref{super_admin.password}"
callback_endpoint = "https://localhost:${mgt.transport.https.port}/api/am/publisher/v0.15/workflows/update-workflow-status"
token_endpoint = "https://localhost:${https.nio.port}/token"
client_registration_endpoint = "https://localhost:${mgt.transport.https.port}/client-registration/v0.15/register"
client_registration_username = "$ref{super_admin.username}"
client_registration_password = "$ref{super_admin.password}"</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[apim.workflow]</code>
                            <span class="badge-required">Required</span>
                            <p>
                                Configures the workflows in API Manager
                            </p>
                        </div>
                        <div class="params-wrap">
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>enable </code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>FALSE</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>Enable API State Change workflow.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>service_url</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default:
                                                <code>https://localhost:9445/bpmn</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>The service URL of the workflow engine.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>wf_engine_user</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default:
                                                <code>super username</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>Workflow username.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>wf_engine_pass</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default:
                                                <code>super user password</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>Workflow password.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>callback_endpoint</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default:
                                                <code>https://localhost:${mgt.transport.https.port}/api/am/publisher/v0.14/workflows/update-workflow-status</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>Callback URL for the workflow engine.</p>
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
                                            <span class="param-default-value">Default:
                                                <code>https://localhost:${https.nio.port}/token</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>Token endpoint used for the workflow.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>client_registration_endpoint</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default:
                                                <code>https://localhost:${mgt.transport.https.port}/client-registration/v0.14/register</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>DCR endpoint</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>client_registration_username</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default:
                                                <code>super username</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>DCR username</p>
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


## API-M SDK configurations

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">

                <input name="27" type="checkbox" id="_tab_27">
                <label class="tab-selector" for="_tab_27"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
                        <pre><code class="toml">#SAMPLE</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[apim.sdk]</code>
                            <span class="badge-required">Required</span>
                            <p>

                            </p>
                        </div>
                        <div class="params-wrap">
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>group_id</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>org.wso2</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>Group ID of the of the generated project.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>artifact_id</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default:
                                                <code>org.wso2.client.</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>Artifact ID of the generated project.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>model_package</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default:
                                                <code>org.wso2.client.model.</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>Model package of the generated project.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>api_package</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default:
                                                <code>org.wso2.client.api.</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>API package of the generated project.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>supported_languages</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default:
                                                <code>android,java,scala,csharp,dart,flash,groovy,javascript,jmeter,nodejs,perl,php,python,ruby,swift,clojure,asyncScala,csharpDotNet2</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>Supported programming languages.</p>
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


## API-M Open tracer configurations

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">

                <input name="28" type="checkbox" id="_tab_28">
                <label class="tab-selector" for="_tab_28"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
                        <pre><code class="toml">#SAMPLE</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[apim.open_tracer]</code>
                            <span class="badge-required">Required</span>
                            <p>
                                Configurations related to tracing.
                            </p>
                        </div>
                        <div class="params-wrap">
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>remote_tracer.enable</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>FALSE</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>Enable tracing in API Manager. Traces the execution time upto message level.
                                        </p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>remote_tracer.name</code> </span>
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
                                        <p>Tracer name.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>remote_tracer.properties.hostname</code>
                                    </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>localhost</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>Hostname of the zipkin tool (tracer)</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>remote_tracer.properties.port</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>9411</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>Port allocated for the tool.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>log_tracer.enable</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>FALSE</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>Define whether to log the tracer values.</p>
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


## API-M token revocation

<div class="mb-config-catalog">
    <section>
        <div class="mb-config-options">
            <div class="superfences-tabs">

                <input name="29" type="checkbox" id="_tab_29">
                <label class="tab-selector" for="_tab_29"><i class="icon fa fa-code"></i></label>
                <div class="superfences-content">
                    <div class="mb-config-example">
                        <pre><code class="toml">[apim.token.revocation]
notifier_impl = "org.wso2.carbon.apimgt.keymgt.events.TokenRevocationNotifierImpl"
enable_realtime_notifier = true
realtime_notifier.ttl = 5000
enable_persistent_notifier = true
persistent_notifier.hostname = "https://localhost:2379/v2/keys/jti/"
persistent_notifier.ttl = 5000
persistent_notifier.username = "root"
persistent_notifier.password = "root"</code></pre>
                    </div>
                </div>
                <div class="doc-wrapper">
                    <div class="mb-config">
                        <div class="config-wrap">
                            <code>[apim.token.revocation]</code>
                            <span class="badge-required">Required</span>
                            <p>
                                Configures the token revocation on KM
                            </p>
                        </div>
                        <div class="params-wrap">
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>notifier_impl</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default:
                                                <code>org.wso2.carbon.apimgt.keymgt.events.TokenRevocationNotifierImpl</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>This config is required only during a custom implementation.

                                            If a token is revoked, the notification will be sent to the JMS topic. Write
                                            a custom implementation to change this behaviour.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>enable_realtime_notifier</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>TRUE</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>(Only applicable if Choreo Connect is used). If set to FALSE, works as
                                            persistent.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>enable_persistent_notifier</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>TRUE</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>Notifications will be persisted to etcd. At the Choreo Connect startup,
                                            the etcd will be queried by Choreo Connect.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>realtime_notifier.ttl</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>5000</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p></p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>persistent_notifier.hostname</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default:
                                                <code>https://localhost:2379/v2/keys/jti/</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p>etcd hostname</p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>persistent_notifier.ttl</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>5000</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p></p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>persistent_notifier.username</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>root</code></span>
                                        </div>

                                    </div>
                                    <div class="param-description">
                                        <p></p>
                                    </div>
                                </div>
                            </div>
                            <div class="param">
                                <div class="param-name">
                                    <span class="param-name-wrap"> <code>persistent_notifier.password</code> </span>
                                </div>
                                <div class="param-info">
                                    <div>
                                        <p>
                                            <span class="param-type string"> string </span>

                                        </p>
                                        <div class="param-default">
                                            <span class="param-default-value">Default: <code>root</code></span>
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