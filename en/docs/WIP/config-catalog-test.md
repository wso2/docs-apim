---
template: templates/2-column.html
---
# Configuration Catalog
This document describes all the configuration parameters that are used in WSO2 API Manager.
## Instructions for use
> Select the configuration sections, parameters, and values that are required for your use and add them to the .toml file. See the example .toml file given below.
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

<div class="mb-config-catalog">
	<section class="title">
		<div class="mb-config-options">
			<h2>Common Configurations</h2>
		</div>
		<div class="mb-config-example">
			<pre>
				<code class="toml">[server]
hostname="localhost"
node_ip="127.0.0.1"
enable_mtom=false
enable_swa=false</code>
			</pre>
		</div>
	</section>
	<section>
		<div class="mb-config-options">
			<div class="mb-config">
				<div class="config-wrap">
					<code>[server]</code>
					<span class="badge-required">Required</span>
					<p>
                                This section configures the server details for the WSO2 API Manager Publisher instance.
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>hostname</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"tm.wso2.com"</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The hostname of the WSO2 EI server instance.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>node_ip</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"127.0.0.1"</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The IP address of the server node.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>offset</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> integer </span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"0"</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>Port offset allows you to run multiple WSO2 products, multiple instances of a WSO2 product, or multiple WSO2 product clusters on the same server or virtual machine (VM). Port offset defines the number by which all ports defined in the runtime such as the HTTP/S ports will be offset.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>mode</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"single"</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The mode defines if the server is started in HA or single mode.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>base_path</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"${carbon.protocol}://${carbon.host}:${carbon.management.port}"</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The base path where the server will be hosted at</p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[super_admin]</code>
					<span class="badge-required">Required</span>
					<p>
                                This section configures the super user for the WSO2 API Manager Publisher instance.
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>username</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"admin"</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The username of the super user.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>password</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"admin"</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The password for the super user for the WSO2 API Manager Publisher instance.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>create_admin_account</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"true"</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p> Specifies if the super user needs to be created upon server start up</p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[user_store]</code>
					<span class="badge-required">Required</span>
					<p>
                                This section configures the user store for the WSO2 API Manager Publisher instance.
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>type</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"database"</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The type of the userstore.</p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[database.apim_db]</code>
					<span class="badge-required">Required</span>
					<p>
                                This section configures the AM_DB for the WSO2 API Manager Publisher instance. The AM_DB stores APIM related information
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>type</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"h2"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code>mssql</code>
										<code>oracle</code>
										<code>postgres</code>
										<code>h2</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The database engine</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>url</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"jdbc:h2:repository/database/WSO2AM_DB;DB_CLOSE_ON_EXIT=FALSE"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p>The connection URL of your database server.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>username</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"wso2carbon"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p>The username used to connect to the apim_db of the WSO2 API Manager Publisher instance.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>password</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"wso2carbon"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p>The password used to connect to the apim_db of the WSO2 API Manager Publisher instance.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>validationQuery</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"SELECT 1"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p></p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>pool_options.maxActive</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> integer </span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"50"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p></p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>pool_options.maxWait</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> long </span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"60000"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p></p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>pool_options.testOnBorrow</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"true"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code>true</code>
										<code>false</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p></p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>pool_options.validationInterval</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> long </span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"30000"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p></p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>pool_options.defaultAutoCommit</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"true"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code>true</code>
										<code>false</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p></p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>pool_options.xxxxxxxx</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"SELECT 1"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p>can provide any pool properties for xxxxx</p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[database.shared_db]</code>
					<span class="badge-required">Required</span>
					<p>
                                This section configures the shared database for the WSO2 API Manager Publisher instance. The AM_DB stores APIM related information
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>type</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"h2"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code>mssql</code>
										<code>oracle</code>
										<code>postgres</code>
										<code>h2</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The database engine</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>url</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"jdbc:h2:repository/database/WSO2SHARED_DB;DB_CLOSE_ON_EXIT=FALSE"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p>The hostname of your database server.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>username</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"wso2carbon"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p>The username used to connect to the apim_db of the WSO2 API Manager Publisher instance.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>password</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"wso2carbon"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p>The password used to connect to the apim_db of the WSO2 API Manager Publisher instance.</p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[keystore.tls]</code>
					<span class="badge-required">Required</span>
					<p>
                                This section configures the shaed database for the WSO2 API Manager Publisher instance. The AM_DB stores APIM related information
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>file_name</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"wso2carbon.jsk"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The file name of the keystore</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>type</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"JKS"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The type of the keystore.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>password</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"wso2carbon"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p> The password that is used to access and store passwords in the keystore.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>alias</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"wso2carbon"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The alias of the keystore</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>key_password</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"wso2carbon"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The keypass value that specified when the private key was generated.</p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[apim.gateway.environment]</code>
					<span class="badge-required">Required</span>
					<p>
                                Define GW environments as an array
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>name</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"Production and Sandbox"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p>The name of the gateway environment</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>type</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"hybrid"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p>The type of the gateway enviornment.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>display_in_api_console</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"true"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p> The password that is used to access and store passwords in the keystore.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>description</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"This is a hybrid gateway that handles both production and sandbox token traffic."</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p>The file name of the keystore</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>service_url </code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"https://localhost:9443/services/"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p>The type of the keystore.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>username</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"$conf{super_admin.username}"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p></p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>password</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"$conf{super_admin.password}"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p></p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>ws_endpoint </code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"ws://localhost:9099"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p>The type of the keystore.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>http_endpoint</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"http://localhost:${http.nio.port}"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p></p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>https_endpoint</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"https://localhost:${https.nio.port}"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p></p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[apim.cache.gateway_token]</code>
					<p>
                                This section configures the gateway token cache
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>enable</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"false"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code>true</code>
										<code>false</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>enable gateway token cache.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>expiry_time</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"15m"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p>set cache expirary time.</p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[apim.cache.resource]</code>
					<p>
                                This section configures the gateway resource cache.
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>enable</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"true"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code>true</code>
										<code>false</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>enable gateway resource cache.</p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[apim.cache.km_token]</code>
					<p>
                                This section configures the KM token cache
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>enable</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"false"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code>true</code>
										<code>false</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>enable KM token cache.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>expiry_time</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"15m"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p>set the cache expirary time.</p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[apim.cache.recent_apis]</code>
					<p>
                                Configures cache for recently added apis
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>enable</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"false"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code>true</code>
										<code>false</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>Enable cache for recently added apis.</p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[apim.cache.scopes]</code>
					<p>
                                Configures cache for scopes
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>enable</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"true"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code>true</code>
										<code>false</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>Enable cache for scopes.</p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[apim.cache.publisher_roles]</code>
					<p>
                                Configures cache for publisher roles
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>enable</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"true"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code>true</code>
										<code>false</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>Enable cache for publisher roles.</p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[apim.cache.jwt_claim]</code>
					<p>
                                Configures cache for JWT claim cache
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>enable</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"true"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code>true</code>
										<code>false</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>Enable JWT claim cache.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>expiry_time</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"15m"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p>Set the cache expirary time.</p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[apim.analytics]</code>
					<p>
                                This section configures api manager analytics
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>enable</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"true"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code>true</code>
										<code>false</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>enable/disable analytics.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>store_api_url</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"https://localhost:7444"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p>Analytics store rest api url. If there are mutiple analytics node, use LB url</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>username</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"$ref{super_admin.username}"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p>username of the analytics node.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>password</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"$ref{super_admin.password}"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p>password of the analytics node.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>receiver_username</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"$ref{apim.analytics.username}"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p>if specific user need to used for the event publishing.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>receiver_password</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"$ref{apim.analytics.password}"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p>if specific user need to used for the event publishing.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>store_api_username</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"$ref{apim.analytics.username}"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p>if specific user need to used for access rest api.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>store_api_password</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"$ref{apim.analytics.password}"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p>if specific user need to used for  access rest api.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>provider_impl</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"org.wso2.carbon.apimgt.usage.client.impl.APIUsageStatisticsRestClientImpl"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p>if need to customized and extend default rest api data retrival implmentation.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>event_publisher_impl</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"$ref{apim.analytics.username}"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p>if  event_publisher_type is custom. custom publisher need to be definied to this value ex: event_publisher_impl = org.wso2.carbon.apimgt.usage.publisher.APIMgtUsageDataBridgeDataPublisher</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>publish_response_size</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"false"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code>true</code>
										<code>false</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>enable whather to publisher response size to analytics.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>receiver_urls</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>""</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p>Used to define failover urls inline. Need to configure if apim.analytics.analytics_node is not defiined..</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>receiver_auth_urls</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>""</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p>Used to define failover auth urls inline. Need to configure if apim.analytics.analytics_node is not defiined.</p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[apim.analytics.url_group]</code>
					<span class="badge-required">Required</span>
					<p>
                                Define analytics nodes as an array. If there are mutiple node, need to define this configuration mutiple times
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>analytics_url</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"tcp://localhost:7612"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p>list of server urls ex: analytics_url = [tcp://localhost:7611,tcp://localhost:7611]</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>analytics_auth_url</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"ssl://localhost:7712"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p>list of server urls ex: analytics_url = [tcp://localhost:7611,tcp://localhost:7611]</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>type</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"loadbalance"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code>loadbalance</code>
										<code>failover</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>loadbalance or failover.</p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[apim.key_manager]</code>
					<p>
                                This section configures the api manager gateway to be connected with the WSO2 API Manager Publisher
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>service_url</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"https://localhost:9443/services/"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p>The name of the gateway environment</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>username</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"$ref{super_admin.username}"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p></p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>password</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"$ref{super_admin.password}"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p></p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>pool.init_idle_capacity</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> integer </span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"50"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p></p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>pool.max_idle</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> integer </span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"100"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p></p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>key_validation_handler_type</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"default"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code>default</code>
										<code>custom</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p></p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>key_validation_handler_impl</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code></code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p>Can provide custom key validation handler implmentation. Need to set key_validation_handler_type to custom </p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[apim.jwt]</code>
					<p>
                                This section configures the api manager to work with JWT
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>enable</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"true"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code>true</code>
										<code>false</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>Enbale JWT</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>encoding</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"base64"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code>base64</code>
										<code>base64url</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>base64-Use default JWT generator. base64url-Use url-safe JWT generator</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>generator_impl</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"org.wso2.carbon.apimgt.keymgt.token.JWTGenerator"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p>can be define custom generation implmetation. If this is defnied apim.jwt.encoding will be ignored.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>claim_dialect</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"http://wso2.org/claims"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code>true</code>
										<code>false</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p></p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>header</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"X-JWT-Assertion"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p></p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>signing_algorithm</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"SHA256withRSA"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code>SHA256withRSA</code>
										<code>None</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>NONE to disbale the sigining</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>enable_user_claims</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"true"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code>false</code>
										<code>true</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>If false -Not user user store claims, If true - Use default claim extractor</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>claims_extractor_impl</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"org.wso2.carbon.apimgt.impl.token.DefaultClaimsRetriever"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p>Can define custom claim retiriver implmentation and need to apim.jwt.user_claims_enable=true</p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[apim.oauth_config]</code>
					<p>
                                This section configures the api manager gateway to be connected with the WSO2 API Manager Publisher
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>enable_outbound_auth_header</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"true"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p></p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>auth_header</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"Authorization"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p></p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>revoke_endpoint</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"https://localhost:${https.nio.port}/revoke"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p></p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>enable_token_encryption</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"false"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code>false</code>
										<code>true</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p></p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>enable_token_hashing</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"false"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code>false</code>
										<code>true</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p></p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>default_app_scope</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"am_application_scope"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p></p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>enable_token_hashing</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>[^device_.*, openid]</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p>List of whitelisted scopes.</p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[apim.store]</code>
					<p>
                                This section configures the api manager store
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>url</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"https://localhost:${mgt.transport.https.port}/store"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p></p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>enable_application_sharing</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"false"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code>true</code>
										<code>false</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>Enable application sharing</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>application_sharing_type</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"default"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code>default</code>
										<code>saml</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>Use the application_sharing_impl as default implmentation</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>application_sharing_impl</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"org.wso2.carbon.apimgt.impl.SAMLGroupIDExtractorImpl"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p>Need to define if the application_sharing_type is custom. If both application_sharing_type and application_sharing_impl is defined, take value from application_sharing_impl</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>display_multiple_versions</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"true"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code>true</code>
										<code>false</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p></p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>display_deprecated_apis</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"false"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code>true</code>
										<code>false</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p></p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>enable_comments</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"true"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code>true</code>
										<code>false</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p></p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>enable_ratings</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"true"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code>true</code>
										<code>false</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p></p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>enable_forum</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"true"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code>true</code>
										<code>false</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p></p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>application_sharing_claim</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"http://wso2.org/claims/organization"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p></p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[apim.cors]</code>
					<p></p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>allow_origins</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>*</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p>default configuration in the toml</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>allow_methods</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> array </span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>GET,PUT,POST,DELETE,PATCH,OPTIONS</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p></p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>allow_headers</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> array </span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>authorization,Access-Control-Allow-Origin,Content-Type,SOAPAction</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p></p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>allow_credentials</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"false"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p>.</p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[apim.throttling]</code>
					<p>
                                This section configures the api manager gateway to be connected with the WSO2 API Manager Publisher
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>enable_advanced_throttling</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"true"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code>true</code>
										<code>false</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p></p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>receiver_url</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"tcp://${carbon.local.ip}:${receiver.url.port}"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p>define traffic manager connection url inline</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>apim.throttling.receiver_url</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"tcp://${carbon.local.ip}:${receiver.url.port}"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p>Define array of traffic manager connections.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>apim.throttling.receiver_auth_url</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"ssl://${carbon.local.ip}:${auth.url.port}"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p>define traffic manager auth connection url inline</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>username</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"$ref{super_admin.username}"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p>TM username</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>password</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"$ref{super_admin.password}"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p>TM password</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>receiver_username</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"$ref{super_admin.username}"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p>receiver username if it is diffrent</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>receiver_password</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"$ref{super_admin.password}"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p>receiver password if it is diffrent</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>enable_policy_deploy</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"true"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p>enable policy deploy</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>policy_deploy.username</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"$ref{super_admin.username}"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p>user name for policy deploy. if it is diffrent</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>policy_deploy.password</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"$ref{super_admin.password}"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p>user password for policy deploy. if it is diffrent</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>jms.username</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"$ref{super_admin.username}"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p>JMS connection user if it is diffrent</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>jms.password</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"$ref{super_admin.password}"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p>JMS connection password if it is diffrent</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>enable_data_publishing</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"true"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code>true</code>
										<code>false</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>Enable data publishing to TM</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>publisher.max_idle</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> integer </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"1000"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p>publisher pool max ideal values</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>publisher.init_idle_size</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> integer </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"200"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p>publisher pool max ideal size</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>publisher.pool_size</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> integer </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"200"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p>publisher thread pool size</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>publisher.max_pool_size</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> integer </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"1000"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p>publisher threax pool max size</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>publisher.keep_alive_time</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"200s"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p>publisher thread pool, keep alive time</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>service_url</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"https://localhost:${mgt.transport.https.port}${carbon.context}services/"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p>TM service URL </p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>enable_blacklist_condition</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"true"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code>true</code>
										<code>false</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>enable blocking condiftions</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>blacklist_condition.start_delay</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> integer </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>""</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p>Define delay time to get blocking data from KM</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>blacklist_condition.period</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> integer </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>""</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p></p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>enable_decision_connection</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"true"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code>true</code>
										<code>false</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>Enable dicision retriveing from TM</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>jms.destination</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>""</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p>Connection delay to read TM at startup</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>jms.start_delay</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"true"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code>true</code>
										<code>false</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>enable blocking condiftions</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>jms.conn_jndi_name</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> integer </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"TopicConnectionFactory"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p></p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>jms.destination_type</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> integer </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"topic"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p></p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>decision_connection_type</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"andes"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p>Define JMS type ex: andes</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>jms.java_naming_factory_initial</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>""</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p>Define JMS factory initials. If decision_connection_type is andes, this is "org.wso2.andes.jndi.PropertiesFileInitialContextFactory"</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>jms.topic_connection_factory</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>""</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p>Define JMS connection URLs inline</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>throttle_decision_endpoints</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>""</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p>Define array of JMS connection as a array. ex:throttle_decision_endpoints = [tcp://localhost:5672,tcp://localhost:5672] If this is not defined use amqp://${admin.username}:${admin.password}@clientid/carbon?brokerlist='tcp://${carbon.local.ip}:${jms.port}'</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>enable_unlimited_tier</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"true"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code>true</code>
										<code>false</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>Enable unlimited tier</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>enable_header_based_throttling</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"false"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code>true</code>
										<code>false</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>Enable header condition based thortlling"</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>enable_jwt_claim_based_throttling</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"false"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code>true</code>
										<code>false</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>enable JWT claim based throtlling</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>enable_query_param_based_throttling</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"false"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code>true</code>
										<code>false</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>enable query param based throtlling</p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[apim.throttling.url_group]</code>
					<p>
                                This section configures the api manager gateway to be connected with the WSO2 API Manager Publisher
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>traffic_manager_url</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"tcp://tm1.local:9611"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The name of the gateway environment</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>traffic_manager_auth_url</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"ssl://tm1.local:9711"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The type of the gateway enviornment.</p>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

	</section>
</div>
<!-- GATEWAY WORKER -->
<div class="mb-config-catalog">
	<section class="title">
		<div class="mb-config-options">
			<h2>Configuring a WSO2 API Manager - Gateway Worker instance</h2>
		</div>
		<div class="mb-config-example"></div>
	</section>
	<section>
		<div class="mb-config-options">
			<div class="mb-config">
				<div class="config-wrap">
					<code>[server]</code>
					<span class="badge-required">Required</span>
					<p>
                                This section configures the server details for the WSO2 API Manager Publisher instance.
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>hostname</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"gw.wso2.com"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The hostname of the WSO2 EI server instance.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>node_ip</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"127.0.0.1"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p>The IP address of the server node.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>server_role</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"gateway-worker"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p>The server profile</p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[user_store]</code>
					<span class="badge-required">Required</span>
					<p>
                                This section configures the user store for the WSO2 API Manager Publisher instance.
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>type</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"database"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The type of the userstore.</p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[super_admin]</code>
					<span class="badge-required">Required</span>
					<p>
                                This section configures the super user for the WSO2 API Manager Publisher instance.
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>username</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"admin"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The username of the super user.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>password</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"admin"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The password for the super user for the WSO2 API Manager Publisher instance.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>create_adming_account</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"true"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code>true</code>
										<code>false</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p> Specifies if the super user needs to be created upon server start up</p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[database.shared_db]</code>
					<span class="badge-required">Required</span>
					<p>
                                This section configures the shaed database for the WSO2 API Manager Publisher instance. The AM_DB stores APIM related information
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>type</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"mysql"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code>mssql</code>
										<code>oracle</code>
										<code>postgres</code>
										<code>h2</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The database engine</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>hostname</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"shared_db.mysql"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The hostname of your database server.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>name</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"shared_db"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p> The name of the database created on the database engine to be used as the apim_db.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>port</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"3306"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The port open for the database engine</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>username</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"shareduser"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The username used to connect to the apim_db of the WSO2 API Manager Publisher instance.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>password</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"shareduser"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code>true</code>
										<code>false</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The password used to connect to the apim_db of the WSO2 API Manager Publisher instance.</p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[keystore.tls]</code>
					<span class="badge-required">Required</span>
					<p>
                                This section configures the shaed database for the WSO2 API Manager Publisher instance. The AM_DB stores APIM related information
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>file_name</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"wso2carbon.jsk"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The file name of the keystore</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>type</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"JKS"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The type of the keystore.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>password</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"wso2carbon"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p> The password that is used to access and store passwords in the keystore.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>alias</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"wso2carbon"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The alias of the keystore</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>key_password</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"wso2carbon"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The keypass value that specified when the private key was generated.</p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[truststore]</code>
					<span class="badge-required">Required</span>
					<p>
                                This section configures the shaed database for the WSO2 API Manager Publisher instance. The AM_DB stores APIM related information
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>file_name</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"client-truststore.jks"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The file name of the keystore</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>type</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"JKS"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The type of the keystore.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>password</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"wso2carbon"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p> The password that is used to access and store passwords in the keystore.</p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[apim.key_manager]</code>
					<span class="badge-required">Required</span>
					<p>
                                This section configures the api manager gateway to be connected with the WSO2 API Manager Publisher
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>service_url</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"https://km.wso2.com:443/services/"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The name of the gateway environment</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>username</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"$ref{super_admin.username}"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p></p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>password</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"$ref{super_admin.password}"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p></p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[apim.throttling]</code>
					<span class="badge-required">Required</span>
					<p>
                                This section configures the api manager gateway to be connected with the WSO2 API Manager Publisher
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>username</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"$ref{super_admin.username}"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p></p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>password</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"$ref{super_admin.password}"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p></p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>enable_data_publishing</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"true"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code>true</code>
										<code>false</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The name of the gateway environment</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>enable_policy_deploy</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"false"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code>true</code>
										<code>false</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The type of the gateway enviornment.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>enable_blacklist_condition</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"true"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code>true</code>
										<code>false</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The type of the gateway enviornment.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>enable_unlimited_tier</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"true"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p></p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>enable_header_based_throttling</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"false"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code>true</code>
										<code>false</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The name of the gateway environment</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>enable_query_param_based_throttling</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"false"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code>true</code>
										<code>false</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The type of the gateway enviornment.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>throttle_decision_endpoints</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>tcp://tm1.local:5672,tcp://tm2.local:5672</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code>true</code>
										<code>false</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The type of the gateway enviornment.</p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[apim.throttling.nodes.group0]</code>
					<span class="badge-required">Required</span>
					<p>
                                This section configures the api manager gateway to be connected with the WSO2 API Manager Publisher
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>traffic_manager_url</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"tcp://tm1.local:9611"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The name of the gateway environment</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>traffic_manager_auth_url</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"ssl://tm1.local:9711"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The type of the gateway enviornment.</p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[apim.throttling.nodes.group1]</code>
					<span class="badge-required">Required</span>
					<p>
                                This section configures the api manager gateway to be connected with the WSO2 API Manager Publisher
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>traffic_manager_url</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"tcp://tm2.local:9611"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The name of the gateway environment</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>traffic_manager_auth_url</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"ssl://tm2.local:9711"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The type of the gateway enviornment.</p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[apim.analytics]</code>
					<span class="badge-required">Required</span>
					<p>
                                This section configures the api manager gateway to be connected with the WSO2 API Manager Publisher
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>username</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"$ref{super_admin.username}"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The type of the gateway enviornment.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>password</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"$ref{super_admin.password}"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p> The password that is used to access and store passwords in the keystore.</p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[apim.analytics.analytics_node]</code>
					<span class="badge-required">Required</span>
					<p>
                                This section configures the api manager gateway to be connected with the WSO2 API Manager Publisher
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>analytics_url</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"tcp://analytic1.local:7612"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The name of the gateway environment</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>analytics_auth_url</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"ssl://analytic1.local:7712"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The type of the gateway enviornment.</p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[apim.analytics.analytics_node]</code>
					<span class="badge-required">Required</span>
					<p>
                                This section configures the api manager gateway to be connected with the WSO2 API Manager Publisher
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>analytics_url</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"tcp://analytic2.local:7612"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The name of the gateway environment</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>analytics_auth_url</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"ssl://analytic2.local:7712"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The type of the gateway enviornment.</p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[apim.cache.gateway_token]</code>
					<span class="badge-required">Required</span>
					<p>
                                This section configures the api manager gateway to be connected with the WSO2 API Manager Publisher
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>enable</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"true"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The name of the gateway environment</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>expiry_time</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> integer </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"15"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The type of the gateway enviornment.</p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[apim.cache.resource]</code>
					<span class="badge-required">Required</span>
					<p>
                                This section configures the api manager gateway to be connected with the WSO2 API Manager Publisher
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>enable</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"true"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The name of the gateway environment</p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[apim.oauth_config]</code>
					<span class="badge-required">Required</span>
					<p>
                                This section configures the api manager gateway to be connected with the WSO2 API Manager Publisher
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>remove_outbound_auth_header</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"true"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The name of the gateway environment</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>auth_header</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"Authorization"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The type of the gateway enviornment.</p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[apim.cors]</code>
					<span class="badge-required">Required</span>
					<p>
                                This section configures the api manager gateway to be connected with the WSO2 API Manager Publisher
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>allow_origins</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>*</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The name of the gateway environment</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>allow_methods</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> array </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>GET,PUT,POST,DELETE,PATCH,OPTIONS</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The type of the gateway enviornment.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>allow_headers</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> array </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>authorization,Access-Control-Allow-Origin,Content-Type,SOAPAction</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The type of the gateway enviornment.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>allow_credentials</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"false"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The type of the gateway enviornment.</p>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="mb-config-example">
			<pre>
				<code class="toml">[server]
hostname="localhost"
node_ip="127.0.0.1"
enable_mtom=false
enable_swa=false</code>
			</pre>
		</div>
	</section>
</div>
<!-- PUBLISHER -->
<div class="mb-config-catalog">
	<section class="title">
		<div class="mb-config-options">
			<h2>Configuring a WSO2 API Manager - Publisher instance</h2>
		</div>
		<div class="mb-config-example"></div>
	</section>
	<section>
		<div class="mb-config-options">
			<div class="mb-config">
				<div class="config-wrap">
					<code>[server]</code>
					<span class="badge-required">Required</span>
					<p>
                                This section configures the server details for the WSO2 API Manager Publisher instance.
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>hostname</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"localhost"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The hostname of the WSO2 EI server instance.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>node_ip</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"127.0.0.1"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p>The IP address of the server node.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>server_role</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"127.0.0.1"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p>The server profile</p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[user_store]</code>
					<span class="badge-required">Required</span>
					<p>
                                This section configures the user store for the WSO2 API Manager Publisher instance.
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>type</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"database"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The type of the userstore.</p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[super_admin]</code>
					<span class="badge-required">Required</span>
					<p>
                                This section configures the super user for the WSO2 API Manager Publisher instance.
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>username</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"admin"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The username of the super user.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>password</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"admin"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The password for the super user for the WSO2 API Manager Publisher instance.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>create_adming_account</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"true"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code>true</code>
										<code>false</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p> Specifies if the super user needs to be created upon server start up</p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[database.apim_db]</code>
					<span class="badge-required">Required</span>
					<p>
                                This section configures the AM_DB for the WSO2 API Manager Publisher instance. The AM_DB stores APIM related information
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>type</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"mysql"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code>mssql</code>
										<code>oracle</code>
										<code>postgres</code>
										<code>h2</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The database engine</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>hostname</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"apimg.mysql"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The hostname of your database server.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>name</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"apimgtdb"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p> The name of the database created on the database engine to be used as the apim_db.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>port</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"3306"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The port open for the database engine</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>username</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"apimuser"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The username used to connect to the apim_db of the WSO2 API Manager Publisher instance.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>password</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"apimuser"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code>true</code>
										<code>false</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The password used to connect to the apim_db of the WSO2 API Manager Publisher instance.</p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[database.shared_db]</code>
					<span class="badge-required">Required</span>
					<p>
                                This section configures the shaed database for the WSO2 API Manager Publisher instance. The AM_DB stores APIM related information
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>type</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"mysql"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code>mssql</code>
										<code>oracle</code>
										<code>postgres</code>
										<code>h2</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The database engine</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>hostname</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"shared_db.mysql"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The hostname of your database server.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>name</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"shared_db"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p> The name of the database created on the database engine to be used as the apim_db.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>port</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"3306"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The port open for the database engine</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>username</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"shareduser"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The username used to connect to the apim_db of the WSO2 API Manager Publisher instance.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>password</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"shareduser"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code>true</code>
										<code>false</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The password used to connect to the apim_db of the WSO2 API Manager Publisher instance.</p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[keystore.tls]</code>
					<span class="badge-required">Required</span>
					<p>
                                This section configures the shaed database for the WSO2 API Manager Publisher instance. The AM_DB stores APIM related information
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>file_name</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"wso2carbon.jsk"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The file name of the keystore</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>type</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"JKS"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The type of the keystore.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>password</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"wso2carbon"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p> The password that is used to access and store passwords in the keystore.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>alias</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"wso2carbon"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The alias of the keystore</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>key_password</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"wso2carbon"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The keypass value that specified when the private key was generated.</p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[truststore]</code>
					<span class="badge-required">Required</span>
					<p>
                                This section configures the shaed database for the WSO2 API Manager Publisher instance. The AM_DB stores APIM related information
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>file_name</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"client-truststore.jks"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The file name of the keystore</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>type</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"JKS"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The type of the keystore.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>password</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"wso2carbon"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p> The password that is used to access and store passwords in the keystore.</p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[apim.gateway.environment]</code>
					<span class="badge-required">Required</span>
					<p>
                                This section configures the api manager gateway to be connected with the WSO2 API Manager Publisher
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>name</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"Production and Sandbox"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The name of the gateway environment</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>type</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"hybrid"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code>production</code>
										<code>sandbox</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The type of the gateway enviornment.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>display_in_api_console</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"true"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p> The password that is used to access and store passwords in the keystore.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>description</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"This is a hybrid gateway that handles both production and sandbox token traffic."</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The file name of the keystore</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>service_url </code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"https://gw.mgt.wso2.com:443/services/"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The type of the keystore.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>username</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"$ref{super_admin.username}"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p></p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>password</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"$ref{super_admin.password}"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p></p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[apim.analytics]</code>
					<span class="badge-required">Required</span>
					<p>
                                This section configures the api manager gateway to be connected with the WSO2 API Manager Publisher
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>store_api_url</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"https://analytics.wso2.com:7444"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The name of the gateway environment</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>username</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"$ref{super_admin.username}"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The type of the gateway enviornment.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>password</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"$ref{super_admin.password}"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p> The password that is used to access and store passwords in the keystore.</p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[apim.analytics.analytics_node]</code>
					<span class="badge-required">Required</span>
					<p>
                                This section configures the api manager gateway to be connected with the WSO2 API Manager Publisher
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>analytics_url</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"tcp://analytic1.local:7612"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The name of the gateway environment</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>analytics_auth_url</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"ssl://analytic1.local:7712"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The type of the gateway enviornment.</p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[apim.analytics.analytics_node]</code>
					<span class="badge-required">Required</span>
					<p>
                                This section configures the api manager gateway to be connected with the WSO2 API Manager Publisher
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>analytics_url</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"tcp://analytic2.local:7612"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The name of the gateway environment</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>analytics_auth_url</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"ssl://analytic2.local:7712"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The type of the gateway enviornment.</p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[apim.throttling]</code>
					<span class="badge-required">Required</span>
					<p>
                                This section configures the api manager gateway to be connected with the WSO2 API Manager Publisher
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>service_url</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"https://tm.wso2.com:443/services/"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The name of the gateway environment</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>username</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"$ref{super_admin.username}"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The type of the gateway enviornment.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>password</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"$ref{super_admin.password}"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The type of the gateway enviornment.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>enable_data_publishing</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"true"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code>true</code>
										<code>false</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The name of the gateway environment</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>enable_policy_deploy</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"true"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code>true</code>
										<code>false</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The type of the gateway enviornment.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>enable_blacklist_condition</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"false"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code>true</code>
										<code>false</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The type of the gateway enviornment.</p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[apim.throttling.nodes.group0]</code>
					<span class="badge-required">Required</span>
					<p>
                                This section configures the api manager gateway to be connected with the WSO2 API Manager Publisher
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>traffic_manager_url</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"tcp://tm1.local:9611"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The name of the gateway environment</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>traffic_manager_auth_url</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"ssl://tm1.local:9711"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The type of the gateway enviornment.</p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[apim.throttling.nodes.group1]</code>
					<span class="badge-required">Required</span>
					<p>
                                This section configures the api manager gateway to be connected with the WSO2 API Manager Publisher
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>traffic_manager_url</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"tcp://tm2.local:9611"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The name of the gateway environment</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>traffic_manager_auth_url</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"ssl://tm2.local:9711"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The type of the gateway enviornment.</p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[apim.cache.scopes]</code>
					<span class="badge-required">Required</span>
					<p>
                                This section configures the api manager gateway to be connected with the WSO2 API Manager Publisher
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>enable</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"true"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The name of the gateway environment</p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[apim.cache.publisher_roles]</code>
					<span class="badge-required">Required</span>
					<p>
                                This section configures the api manager gateway to be connected with the WSO2 API Manager Publisher
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>enable</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"true"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The name of the gateway environment</p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[apim.store]</code>
					<span class="badge-required">Required</span>
					<p>
                                This section configures the api manager gateway to be connected with the WSO2 API Manager Publisher
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>enable</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"true"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The name of the gateway environment</p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[apim.workflow]</code>
					<span class="badge-required">Required</span>
					<p>
                                This section configures the api manager gateway to be connected with the WSO2 API Manager Publisher
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>enable</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"true"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The name of the gateway environment</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>service_url</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"https://localhost:9445/bpmn"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The name of the gateway environment</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>username</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"$ref{super_admin.username}"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The name of the gateway environment</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>password</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"$ref{super_admin.password}"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The name of the gateway environment</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>callback_endpoint</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"https://localhost:9443/api/am/publisher/v0.14/workflows/update-workflow-status"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The name of the gateway environment</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>token_endpoint</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"https://localhost:8243/token"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The name of the gateway environment</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>client_registration_endpoint</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"https://localhost:9443/client-registration/v0.14/register"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The name of the gateway environment</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>client_registration_username</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"$ref{super_admin.username}"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The name of the gateway environment</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>client_registration_password</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"$ref{super_admin.password}"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The name of the gateway environment</p>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="mb-config-example">
			<pre>
				<code class="toml">[server]
hostname="localhost"
node_ip="127.0.0.1"
enable_mtom=false
enable_swa=false</code>
			</pre>
		</div>
	</section>
</div>
<!-- STORE -->
<div class="mb-config-catalog">
	<section class="title">
		<div class="mb-config-options">
			<h2>Configuring a WSO2 API Manager - Store instance</h2>
		</div>
		<div class="mb-config-example"></div>
	</section>
	<section>
		<div class="mb-config-options">
			<div class="mb-config">
				<div class="config-wrap">
					<code>[server]</code>
					<span class="badge-required">Required</span>
					<p>
                                This section configures the server details for the WSO2 API Manager Store instance.
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>hostname</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"localhost"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The hostname of the WSO2 EI server instance.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>node_ip</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"127.0.0.1"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p>The IP address of the server node.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>server_role</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"127.0.0.1"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p>The server profile</p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[user_store]</code>
					<span class="badge-required">Required</span>
					<p>
                                This section configures the user store for the WSO2 API Manager Publisher instance.
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>type</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"database"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The type of the userstore.</p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[super_admin]</code>
					<span class="badge-required">Required</span>
					<p>
                                This section configures the super user for the WSO2 API Manager Publisher instance.
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>username</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"admin"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The username of the super user.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>password</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"admin"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The password for the super user for the WSO2 API Manager Publisher instance.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>create_adming_account</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"true"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code>true</code>
										<code>false</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p> Specifies if the super user needs to be created upon server start up</p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[database.apim_db]</code>
					<span class="badge-required">Required</span>
					<p>
                                This section configures the AM_DB for the WSO2 API Manager Publisher instance. The AM_DB stores APIM related information
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>type</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"mysql"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code>mssql</code>
										<code>oracle</code>
										<code>postgres</code>
										<code>h2</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The database engine</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>hostname</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"apimg.mysql"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The hostname of your database server.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>name</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"apimgtdb"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p> The name of the database created on the database engine to be used as the apim_db.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>port</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"3306"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The port open for the database engine</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>username</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"apimuser"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The username used to connect to the apim_db of the WSO2 API Manager Publisher instance.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>password</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"apimuser"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code>true</code>
										<code>false</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The password used to connect to the apim_db of the WSO2 API Manager Publisher instance.</p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[database.shared_db]</code>
					<span class="badge-required">Required</span>
					<p>
                                This section configures the shaed database for the WSO2 API Manager Publisher instance. The AM_DB stores APIM related information
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>type</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"mysql"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code>mssql</code>
										<code>oracle</code>
										<code>postgres</code>
										<code>h2</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The database engine</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>hostname</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"shared_db.mysql"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The hostname of your database server.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>name</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"shared_db"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p> The name of the database created on the database engine to be used as the apim_db.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>port</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"3306"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The port open for the database engine</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>username</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"shareduser"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The username used to connect to the apim_db of the WSO2 API Manager Publisher instance.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>password</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"shareduser"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code>true</code>
										<code>false</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The password used to connect to the apim_db of the WSO2 API Manager Publisher instance.</p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[keystore.tls]</code>
					<span class="badge-required">Required</span>
					<p>
                                This section configures the shaed database for the WSO2 API Manager Publisher instance. The AM_DB stores APIM related information
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>file_name</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"wso2carbon.jsk"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The file name of the keystore</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>type</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"JKS"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The type of the keystore.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>password</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"wso2carbon"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p> The password that is used to access and store passwords in the keystore.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>alias</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"wso2carbon"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The alias of the keystore</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>key_password</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"wso2carbon"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The keypass value that specified when the private key was generated.</p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[truststore]</code>
					<span class="badge-required">Required</span>
					<p>
                                This section configures the shaed database for the WSO2 API Manager Publisher instance. The AM_DB stores APIM related information
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>file_name</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"client-truststore.jks"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The file name of the keystore</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>type</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"JKS"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The type of the keystore.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>password</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"wso2carbon"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p> The password that is used to access and store passwords in the keystore.</p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[apim.gateway.environment]</code>
					<span class="badge-required">Required</span>
					<p>
                                This section configures the api manager gateway to be connected with the WSO2 API Manager Publisher
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>name</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"Production and Sandbox"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The name of the gateway environment</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>type</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"hybrid"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code>production</code>
										<code>sandbox</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The type of the gateway enviornment.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>display_in_api_console</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"true"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p> The password that is used to access and store passwords in the keystore.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>description</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"This is a hybrid gateway that handles both production and sandbox token traffic."</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The file name of the keystore</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>service_url </code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"https://gw.mgt.wso2.com:443/services/"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The type of the keystore.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>username</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"$ref{super_admin.username}"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p></p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>password</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"$ref{super_admin.password}"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p></p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>ws_endpoint</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"http://api.gw.wso2.com:8280/"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p></p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>http_endpoint</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"$ref{super_admin.password}"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p></p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>https_endpoint</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"https://api.gw.wso2.com:8243/"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p></p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>show_as_token_endpoint_url</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"true"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p></p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[apim.key_manager]</code>
					<span class="badge-required">Required</span>
					<p>
                                This section configures the api manager gateway to be connected with the WSO2 API Manager Publisher
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>service_url</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"https://km.wso2.com:443/services/"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The name of the gateway environment</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>username</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"$ref{super_admin.username}"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The type of the gateway enviornment.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>password</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"$ref{super_admin.password}"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p> The password that is used to access and store passwords in the keystore.</p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[apim.throttling]</code>
					<span class="badge-required">Required</span>
					<p>
                                This section configures the api manager gateway to be connected with the WSO2 API Manager Publisher
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>enable_data_publishing</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"false"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code>true</code>
										<code>false</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The name of the gateway environment</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>enable_policy_deploy</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"false"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code>true</code>
										<code>false</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The type of the gateway enviornment.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>enable_blacklist_condition</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"false"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code>true</code>
										<code>false</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The type of the gateway enviornment.</p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[apim.analytics]</code>
					<span class="badge-required">Required</span>
					<p>
                                This section configures the api manager gateway to be connected with the WSO2 API Manager Publisher
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>store_api_url</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"https://analytics.wso2.com:7444"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The name of the gateway environment</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>username</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"$ref{super_admin.username}"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The type of the gateway enviornment.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>password</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"$ref{super_admin.password}"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p> The password that is used to access and store passwords in the keystore.</p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[apim.analytics.analytics_node]</code>
					<span class="badge-required">Required</span>
					<p>
                                This section configures the api manager gateway to be connected with the WSO2 API Manager Publisher
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>analytics_url</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"tcp://analytic1.local:7612"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The name of the gateway environment</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>analytics_auth_url</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"ssl://analytic1.local:7712"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The type of the gateway enviornment.</p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[apim.analytics.analytics_node]</code>
					<span class="badge-required">Required</span>
					<p>
                                This section configures the api manager gateway to be connected with the WSO2 API Manager Publisher
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>analytics_url</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"tcp://analytic2.local:7612"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The name of the gateway environment</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>analytics_auth_url</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"ssl://analytic2.local:7712"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The type of the gateway enviornment.</p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[apim.cache.recent_apis]</code>
					<span class="badge-required">Required</span>
					<p>
                                This section configures the api manager gateway to be connected with the WSO2 API Manager Publisher
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>enable</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"true"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The name of the gateway environment</p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[apim.cache.scopes]</code>
					<span class="badge-required">Required</span>
					<p>
                                This section configures the api manager gateway to be connected with the WSO2 API Manager Publisher
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>enable</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"true"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The name of the gateway environment</p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[apim.cache.tags]</code>
					<span class="badge-required">Required</span>
					<p>
                                This section configures the api manager gateway to be connected with the WSO2 API Manager Publisher
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>expiry_time</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> long </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"120000"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The name of the gateway environment</p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[apim.store]</code>
					<span class="badge-required">Required</span>
					<p>
                                This section configures the api manager gateway to be connected with the WSO2 API Manager Publisher
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>enable</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"true"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The name of the gateway environment</p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[apim.oauth_config]</code>
					<span class="badge-required">Required</span>
					<p>
                                This section configures the api manager gateway to be connected with the WSO2 API Manager Publisher
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>revoke_endpoint</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"https://localhost:8243/revoke"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The name of the gateway environment</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>enable_token_encryption</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"https://localhost:9445/bpmn"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The name of the gateway environment</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>enable_token_hashing</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"false"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The name of the gateway environment</p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[apim.store]</code>
					<span class="badge-required">Required</span>
					<p>
                                This section configures the api manager gateway to be connected with the WSO2 API Manager Publisher
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>enable_application_sharing</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"true"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The name of the gateway environment</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>application_sharing_type</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"default"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The name of the gateway environment</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>display_multiple_versions</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"false"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The name of the gateway environment</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>display_deprecated_apis</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"false"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The name of the gateway environment</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>enable_comments</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"true"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The name of the gateway environment</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>enable_ratings</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"true"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The name of the gateway environment</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>enable_forum</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"true"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The name of the gateway environment</p>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="mb-config-example">
			<pre>
				<code class="toml">[server]
hostname="localhost"
node_ip="127.0.0.1"
enable_mtom=false
enable_swa=false</code>
			</pre>
		</div>
	</section>
</div>
<!-- KEY MANAGER -->
<div class="mb-config-catalog">
	<section class="title">
		<div class="mb-config-options">
			<h2>Configuring a WSO2 API Manager - Key Manager instance</h2>
		</div>
		<div class="mb-config-example"></div>
	</section>
	<section>
		<div class="mb-config-options">
			<div class="mb-config">
				<div class="config-wrap">
					<code>[server]</code>
					<span class="badge-required">Required</span>
					<p>
                                This section configures the server details for the WSO2 API Manager Store instance.
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>hostname</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"localhost"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The hostname of the WSO2 EI server instance.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>node_ip</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"127.0.0.1"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p>The IP address of the server node.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>server_role</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"127.0.0.1"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p>The server profile</p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[user_store]</code>
					<span class="badge-required">Required</span>
					<p>
                                This section configures the user store for the WSO2 API Manager Publisher instance.
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>type</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"database"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The type of the userstore.</p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[super_admin]</code>
					<span class="badge-required">Required</span>
					<p>
                                This section configures the super user for the WSO2 API Manager Publisher instance.
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>username</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"admin"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The username of the super user.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>password</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"admin"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The password for the super user for the WSO2 API Manager Publisher instance.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>create_adming_account</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"true"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code>true</code>
										<code>false</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p> Specifies if the super user needs to be created upon server start up</p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[database.apim_db]</code>
					<span class="badge-required">Required</span>
					<p>
                                This section configures the AM_DB for the WSO2 API Manager Publisher instance. The AM_DB stores APIM related information
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>type</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"mysql"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code>mssql</code>
										<code>oracle</code>
										<code>postgres</code>
										<code>h2</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The database engine</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>hostname</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"apimg.mysql"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The hostname of your database server.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>name</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"apimgtdb"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p> The name of the database created on the database engine to be used as the apim_db.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>port</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"3306"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The port open for the database engine</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>username</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"apimuser"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The username used to connect to the apim_db of the WSO2 API Manager Publisher instance.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>password</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"apimuser"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code>true</code>
										<code>false</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The password used to connect to the apim_db of the WSO2 API Manager Publisher instance.</p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[database.shared_db]</code>
					<span class="badge-required">Required</span>
					<p>
                                This section configures the shaed database for the WSO2 API Manager Publisher instance. The AM_DB stores APIM related information
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>type</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"mysql"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code>mssql</code>
										<code>oracle</code>
										<code>postgres</code>
										<code>h2</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The database engine</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>hostname</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"shared_db.mysql"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The hostname of your database server.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>name</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"shared_db"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p> The name of the database created on the database engine to be used as the apim_db.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>port</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"3306"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The port open for the database engine</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>username</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"shareduser"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The username used to connect to the apim_db of the WSO2 API Manager Publisher instance.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>password</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"shareduser"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code>true</code>
										<code>false</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The password used to connect to the apim_db of the WSO2 API Manager Publisher instance.</p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[keystore.tls]</code>
					<span class="badge-required">Required</span>
					<p>
                                This section configures the shaed database for the WSO2 API Manager Publisher instance. The AM_DB stores APIM related information
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>file_name</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"wso2carbon.jsk"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The file name of the keystore</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>type</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"JKS"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The type of the keystore.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>password</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"wso2carbon"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p> The password that is used to access and store passwords in the keystore.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>alias</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"wso2carbon"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The alias of the keystore</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>key_password</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"wso2carbon"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The keypass value that specified when the private key was generated.</p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[truststore]</code>
					<span class="badge-required">Required</span>
					<p>
                                This section configures the shaed database for the WSO2 API Manager Publisher instance. The AM_DB stores APIM related information
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>file_name</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"client-truststore.jks"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The file name of the keystore</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>type</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"JKS"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The type of the keystore.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>password</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"wso2carbon"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p> The password that is used to access and store passwords in the keystore.</p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[apim.cache.km_token]</code>
					<span class="badge-required">Required</span>
					<p>
                                This section configures the api manager gateway to be connected with the WSO2 API Manager Publisher
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>enable</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"true"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The name of the gateway environment</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>expiry_time</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> integer </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"15"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code>production</code>
										<code>sandbox</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The type of the gateway enviornment.</p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[apim.cache.jwt_claim]</code>
					<span class="badge-required">Required</span>
					<p>
                                This section configures the api manager gateway to be connected with the WSO2 API Manager Publisher
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>enable</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"true"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The name of the gateway environment</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>expiry_time</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> integer </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"900"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The type of the gateway enviornment.</p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[apim.jwt]</code>
					<span class="badge-required">Required</span>
					<p>
                                This section configures the api manager gateway to be connected with the WSO2 API Manager Publisher
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>enable</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"true"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code>true</code>
										<code>false</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The name of the gateway environment</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>encoding</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"base64"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code>base64</code>
										<code>base64url</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The type of the gateway enviornment.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>claim_dialect</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"http://wso2.org/claims"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code>true</code>
										<code>false</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The type of the gateway enviornment.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>header</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"X-JWT-Assertion"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code>base64</code>
										<code>base64url</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The type of the gateway enviornment.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>signing_algorithm</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"SHA256withRSA"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code>true</code>
										<code>false</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The type of the gateway enviornment.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>enable_user_claims</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"true"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code>base64</code>
										<code>base64url</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The type of the gateway enviornment.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>claims_extractor_impl</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"org.wso2.carbon.apimgt.impl.token.DefaultClaimsRetriever"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code>true</code>
										<code>false</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The type of the gateway enviornment.</p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[apim.throttling]</code>
					<span class="badge-required">Required</span>
					<p>
                                This section configures the api manager gateway to be connected with the WSO2 API Manager Publisher
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>enable_data_publishing</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"false"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code>true</code>
										<code>false</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The name of the gateway environment</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>enable_policy_deploy</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"false"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code>true</code>
										<code>false</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The type of the gateway enviornment.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>enable_blacklist_condition</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"false"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code>true</code>
										<code>false</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The type of the gateway enviornment.</p>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="mb-config-example">
			<pre>
				<code class="toml">[server]
hostname="localhost"
node_ip="127.0.0.1"
enable_mtom=false
enable_swa=false</code>
			</pre>
		</div>
	</section>
</div>
<!-- TRAFFIC MANAGER -->
<div class="mb-config-catalog">
	<section class="title">
		<div class="mb-config-options">
			<h2>Configuring a WSO2 API Manager - Traffic Manager instance</h2>
		</div>
		<div class="mb-config-example"></div>
	</section>
	<section>
		<div class="mb-config-options">
			<div class="mb-config">
				<div class="config-wrap">
					<code>[server]</code>
					<span class="badge-required">Required</span>
					<p>
                                This section configures the server details for the WSO2 API Manager Publisher instance.
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>hostname</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"tm.wso2.com"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The hostname of the WSO2 EI server instance.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>node_ip</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"127.0.0.1"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p>The IP address of the server node.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>server_role</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"traffic-manager"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value"></span>
								</div>
							</div>
							<div class="param-description">
								<p>The server profile</p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[user_store]</code>
					<span class="badge-required">Required</span>
					<p>
                                This section configures the user store for the WSO2 API Manager Publisher instance.
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>type</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"database"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The type of the userstore.</p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[super_admin]</code>
					<span class="badge-required">Required</span>
					<p>
                                This section configures the super user for the WSO2 API Manager Publisher instance.
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>username</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"admin"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The username of the super user.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>password</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"admin"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The password for the super user for the WSO2 API Manager Publisher instance.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>create_adming_account</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> boolean </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"true"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code>true</code>
										<code>false</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p> Specifies if the super user needs to be created upon server start up</p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[database.shared_db]</code>
					<span class="badge-required">Required</span>
					<p>
                                This section configures the shaed database for the WSO2 API Manager Publisher instance. The AM_DB stores APIM related information
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>type</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"mysql"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code>mssql</code>
										<code>oracle</code>
										<code>postgres</code>
										<code>h2</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The database engine</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>hostname</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"shared_db.mysql"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The hostname of your database server.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>name</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"shared_db"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p> The name of the database created on the database engine to be used as the apim_db.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>port</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"3306"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The port open for the database engine</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>username</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"shareduser"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The username used to connect to the apim_db of the WSO2 API Manager Publisher instance.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>password</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"shareduser"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code>true</code>
										<code>false</code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The password used to connect to the apim_db of the WSO2 API Manager Publisher instance.</p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[keystore.tls]</code>
					<span class="badge-required">Required</span>
					<p>
                                This section configures the shaed database for the WSO2 API Manager Publisher instance. The AM_DB stores APIM related information
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>file_name</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"wso2carbon.jsk"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The file name of the keystore</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>type</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"JKS"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The type of the keystore.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>password</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"wso2carbon"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p> The password that is used to access and store passwords in the keystore.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>alias</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"wso2carbon"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The alias of the keystore</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>key_password</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"wso2carbon"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The keypass value that specified when the private key was generated.</p>
							</div>
						</div>
					</div>
				</div>
				<div class="config-wrap">
					<code>[truststore]</code>
					<span class="badge-required">Required</span>
					<p>
                                This section configures the shaed database for the WSO2 API Manager Publisher instance. The AM_DB stores APIM related information
                            </p>
				</div>
				<div class="params-wrap">
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>file_name</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"client-truststore.jks"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The file name of the keystore</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>type</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"JKS"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p>The type of the keystore.</p>
							</div>
						</div>
					</div>
					<div class="param">
						<div class="param-name">
							<span class="param-name-wrap">
								<code>password</code>
							</span>
						</div>
						<div class="param-info">
							<div>
								<p>
									<span class="param-type string"> string </span>
									<span class="badge-required">Required</span>
								</p>
								<div class="param-default">
									<span class="param-default-value">
										<code>"wso2carbon"</code>
									</span>
								</div>
								<div class="param-possible">
									<span class="param-possible-value">
										<code></code>
									</span>
								</div>
							</div>
							<div class="param-description">
								<p> The password that is used to access and store passwords in the keystore.</p>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="mb-config-example">
			<pre>
				<code class="toml">[server]
hostname="localhost"
node_ip="127.0.0.1"
enable_mtom=false
enable_swa=false</code>
			</pre>
		</div>
	</section>
</div>
