# Install and Setup Overview

The installation and the setup of API Manager involves installing the product, deploying it in the method that is best suited for your requirements, and setting it up to run in the production environment. If you already have an older version of WSO2 API Manager or one of it's components, you can follow the upgrading instructions in this guide.

This section provides installation and setup instructions for the following three components of WSO2 API Manager that you need to operate as three separate runtimes.

## The API Manager

This component manages APIs. To install and set up this component, see the following topics:

### Installing

 To install and run the API Manager, see the following topics.
 
 <table>
 	<tr>
 		<td>
 			<a href="{{base-path}}/install-and-setup/install/installing-the-product/installing-via-the-installer">Installing via the Installer</a>
 		</td>
 		<td>
 			Explains how to install the API Manager component via the Installer.
 		</td>
 	</tr>
 	<tr>
 		<td>
 			<a href="{{base-path}}/install-and-setup/install/installing-the-product/installing-the-binary/installing-on-linux-or-os-x">Installing on Linux or OS X</a>
 		</td>
 		<td>
 			Explains how to download the API Manager component as a binary and install it on a virtual machine with a Linux operating system.
 		</td>
 	</tr>
 	<tr>
 		<td>
 			<a href="{{base-path}}/install-and-setup/install/installing-the-product/installing-the-binary/installing-on-solaris">Installing on Solaris</a>
 		</td>
 		<td>
 			Explains how to download the API Manager component as a binary and install it on a virtual machine with a Solaris operating system.
 		</td>
 	</tr>
 	<tr>
 		<td>
 			<a href="{{base-path}}/install-and-setup/install/installing-the-product/installing-the-binary/installing-on-windows">Installing on Windows</a>
 		</td>
 		<td>
 			Explains how to download the API Manager component as a binary and install it on a virtual machine with a Windows operating system.
 		</td>
 	</tr>
 	<tr>
 		<td>
 			<a href="{{base-path}}/install-and-setup/install/installing-the-product/installing-the-binary/installing-on-windows">Installing as a Linux Service</a>
 		</td>
 		<td>
 			Explains how to install the API Manager as a Linux service.
 		</td>
 	</tr>
 	<tr>
 		<td>
 			<a href="{{base-path}}/install-and-setup/install/installing-the-product/installing-the-binary/installing-as-a-windows-service">Installing as a Windows Service</a>
 		</td>
 		<td>
 			Explains how to install the API Manager as a Windows service.
 		</td>
 	</tr>
 </table>

### Deploying

The API Manager component can be deployed in multiple deployment patterns. Some of these patterns allow the API manager to be deployed with the other components (i.e., the Micro Integrator and the Streaming Integrator), whereas the other patterns involve deploying only the sub components of the API Manager component. For more information, see the topics below:

 <table>
 	<tr>
 		<td>
 			<a href="{{base-path}}/install-and-setup/setup/deployment-overview">Deployment Overview</a>
 		</td>
 		<td>
 			This explains all the deployment patterns you can follow when you deploy WSO2 API manager. These patterns involve deploying the API Manager component together with Micro Integrator and Streaming Integrator components in clustered setups.
 		</td>
 	</tr>
 	<tr>
 		<td>
 			<a href="{{base-path}}/install-and-setup/setup/single-node/all-in-one-deployment-overview">All-in-One Deployment</a>
 		</td>
 		<td>
 			This describes the all-in-one deployment patterns where you can deploy all the sub components of the API Manager component in one instance.
 		</td>
 	</tr>
 	<tr>
 		<td>
 			<a href="{{base-path}}/install-and-setup/setup/distributed-deployment/understanding-the-distributed-deployment-of-wso2-api-m">Distributed Deployment</a>
 		</td>
 		<td>
 			This describes the distributed deployment patterns where you can deploy the sub-components of the API Manager component in a distributed manner in order to handle a high volume of requests in an efficient manner.
 		</td>
 	</tr>
 </table>

### Setting up

Setting up the API Manager component involves performing the following tasks:

 <table>
 	<tr>
 		<td>
 			<a href="{{base-path}}/install-and-setup/setup/deployment-overview">Applying WSO2 WUM Updates</a>
 		</td>
 		<td>
 			Explains how to get the latest updates that are available for a particular release of the API Manager.
 		</td>
 	</tr>
 	<tr>
 		<td>
 			<a>">Setting up a Key Manager</a>
 		</td>
 		<td>
 			The key manager of the API Manager handles all clients, security, and access token-related operations. This section covers the following topics:
            <ul>
                <li>
                    <a href="{{base_path}}/install-and-setup/setup/distributed-deployment/configure-a-third-party-key-manager">Configure a Third-party Key Manager</a>
                </li>
                <li>
                    <a href="{{base_path}}/install-and-setup/setup/distributed-deployment/configuring-wso2-identity-server-as-a-key-manager">Configuring WSO2 Identity Server as a Key Manager</a>
                </li>
            </ul>
 		</td>
 	</tr>
 	<tr>
 		<td>
 			<a href="{{base-path}}/install-and-setup/setup/setting-up-databases/overview">Setting up Databases</a>
 		</td>
 		<td>
 			The API Manager is shipped with an H2 database for storing data. This guide explains the default H2 databases used within API Manager as well as how to switch to a different database supported for the API Manager such as MSSQL, MySQL, PostgreSQL, Oracle, MariaDB, IBM DB2, and Oracle RAC. In addition, this section covers how to manage data growth and improve performance when storing meta data and runtime data in databases.
 		</td>
 	</tr>
 	<tr>
 		<td>
 			<a>Setting up Proxy Server and the Load Balancer
 		<td>
 			A load balancer or reverse proxy is required to map external traffic with ports and URLs that the APi Manager component uses internally. This section covers the following topics relating to the proxy server and the load balancer.
            <ul>
                <li>
                    <a href="{{base_path}}/install-and-setup/setup/setting-up-proxy-server-and-the-load-balancer/configuring-the-proxy-server-and-the-load-balancer">Configuring the Proxy Server and the Load Balancer</a>
                </li>
                <li>
                    <a href="{{base_path}}/install-and-setup/setup/setting-up-proxy-server-and-the-load-balancer/adding-a-custom-proxy-path">Adding a Custom Proxy Path</a>
                </li>
            </ul>
 		</td>
 	</tr>
 	<tr>
 		<td>
 			<a>Securing the API Manager</a>
 		</td>
 		<td>
 			Covers the different ways in which you can secure the API Manager and the data it handles. The topic covered are as follows:
            <ul>
                <li>
                    <a>Logins and Passwords</a>
                </li>
                    <li>
                        <a href="{{base_path}}/install-and-setup/setup/security/logins-and-passwords/maintaining-logins-and-passwords">Maintaining Logins and Passwords</a>
                    </li>
                    <li>
                        <a>Securing Passwords</a>
                    </li>
                        <li>
                            <a href="{{base_path}}/install-and-setup/setup/security/logins-and-passwords/carbon-secure-vault-implementation">Customizing Secure Vault</a>
                        </li>
                        <li>
                            <a href="{{base_path}}/install-and-setup/setup/security/logins-and-passwords/set-passwords-using-vars-and-sys-props">Set Passwords using Environment Variables/System Properties</a>
                        </li>
                        <li>
                            <a href="{{base_path}}/install-and-setup/setup/security/logins-and-passwords/working-with-encrypted-passwords">Working with Encrypted Passwords</a>
                        </li>
                <li>
                    <a>Configuring Keystores</a>
                </li>
                    <li>
                        <a href="{{base_path}}/install-and-setup/setup/security/configuring-keystores/configuring-keystores-in-wso2-api-manager">Configuring Keystores in API Manager</a>
                    </li>
                    <li>
                        <a>Keystore Basics</a>
                    </li>
                        <li>
                            <a href="{{base_path}}/install-and-setup/setup/security/configuring-keystores/keystore-basics/creating-new-keystores">Creating a New Keystore</a>
                        </li>
                        <li>
                            <a href="{{base_path}}/install-and-setup/setup/security/configuring-keystores/keystore-basics/renewing-a-ca-signed-certificate-in-a-keystore">Renewing a CA Signed Certificate</a>
                        </li>
                        <li>
                            <a href="{{base_path}}/install-and-setup/setup/security/configuring-keystores/keystore-basics/about-asymetric-cryptography">About Asymetric Cryptography</a>
                        </li>
                <li>
                    <a href="{{base_path}}/install-and-setup/setup/security/enabling-hostname-verification">Enabling HostName Verification</a>
                </li>
                <li>
                    <a href="{{base_path}}/install-and-setup/setup/security/enabling-java-security-manager">Enabling Java Security Manager</a>
                </li>
                <li>
                    <a href="{{base_path}}/install-and-setup/setup/security/general-data-protection-regulation-gdpr-for-wso2-api-manager">General Data Protection Regulation (GDPR) for WSO2 API Manager</a>
                </li>
                <li>
                    <a href="{{base_path}}/install-and-setup/setup/security/configuring-transport-level-security">Configuring Transport Level Security</a>
                </li>
                <li>
                    <a href="{{base_path}}/install-and-setup/setup/security/user-account-management">User Account Management</a>
                </li>                                                                                      
            </ul>
 		</td>
 	</tr>
 	<tr>
 		<td>
 			<a href="{{base-path}}/administer/managing-users-and-roles/managing-user-stores/introduction-to-userstores">Configuring User Stores</a>
 		</td>
 		<td>
 			You can configure primary user stores as well as secondary user stores for the API Manager component. This section explains the concept of user stores and provides instructions to configure primary user stores. The topics covered are as follows:
 			<ul>
                <li>
                    <a href="{{base-path}}/administer/managing-users-and-roles/managing-user-stores/introduction-to-userstores">Introduction to User Stores</a>
                </li>
                    <li>
                        <a href="{{base-path}}/administer/managing-users-and-roles/managing-user-stores/configure-primary-user-store/configuring-the-primary-user-store"> Configuring Primary User Stores</a>
                    </li>
                    <li>
                        <a href="{{base-path}}/administer/managing-users-and-roles/managing-user-stores/configure-primary-user-store/configuring-a-jdbc-user-store">Configuring a JDBC User Store</a>
                    </li>
                    <li>
                        <a href="{{base-path}}/administer/managing-users-and-roles/managing-user-stores/configure-primary-user-store/configuring-a-read-write-ldap-user-store">Configuring a Read-Write LDAP User Store</a>
                    </li>	
                    <li>
                        <a href="{{base-path}}/administer/managing-users-and-roles/managing-user-stores/configure-primary-user-store/configuring-a-read-only-ldap-user-store"> Configuring a Read-Only LDAP User Store</a>
                    </li>
                    <li>
                        <a href="{{base-path}}/administer/managing-users-and-roles/managing-user-stores/configure-primary-user-store/configuring-a-read-write-active-directory-user-store">Configuring a Read-Write Active Directory User Store</a>
                    </li>
            </ul>                                                                		
 		</td>
 	</tr>
 </table>


### Migrating

### Upgrading



## The Micro Integrator 

This component develops complex integration services that can be exposed as managed APIs

### Installing

 <table>
 	<tr>
 		<td>
 			<a href="{{base-path}}/install-and-setup/install/installing-the-product/installing-via-the-installer">Installing via the Installer</a>
 		</td>
 		<td>
 			Explains how to install the Micro Integrator component via the Installer.
 		</td>
 	</tr>
 	<tr>
 		<td>
 			<a href="{{base-path}}/install-and-setup/install/installing-the-product/installing-the-binary/installing-on-linux-or-os-x">Installing on Linux or OS X</a>
 		</td>
 		<td>
 			Explains how to download the Micro Integrator component as a binary and install it on a virtual machine with a Linux operating system.
 		</td>
 	</tr>
 	<tr>
 		<td>
 			<a href="{{base-path}}/install-and-setup/install/installing-the-product/installing-the-binary/installing-on-solaris">Installing on Solaris</a>
 		</td>
 		<td>
 			Explains how to download the Micro Integrator component as a binary and install it on a virtual machine with a Solaris operating system.
 		</td>
 	</tr>
 	<tr>
 		<td>
 			<a href="{{base-path}}/install-and-setup/install/installing-the-product/installing-the-binary/installing-on-windows">Installing on Windows</a>
 		</td>
 		<td>
 			Explains how to download the Micro Integrator component as a binary and install it on a virtual machine with a Windows operating system.
 		</td>
 	</tr>
 	<tr>
 		<td>
 			<a href="{{base-path}}/install-and-setup/install/installing-the-product/installing-the-binary/installing-on-windows">Installing as a Linux Service</a>
 		</td>
 		<td>
 			Explains how to install the Micro Integrator as a Linux service.
 		</td>
 	</tr>
 	<tr>
 		<td>
 			<a href="{{base-path}}/install-and-setup/install/installing-the-product/installing-the-binary/installing-as-a-windows-service">Installing as a Windows Service</a>
 		</td>
 		<td>
 			Explains how to install the Micro Integrator as a Windows service.
 		</td>
 	</tr>
 </table>

### Deploying

### Setting up

Setting up the Micro Integrator component involves performing the following tasks:

 <table>
 	<tr>
 		<td>
 			<a href="{{base-path}}/install-and-setup/setup/mi-setup/updating-mi">Applying WSO2 Updates</a>
 		</td>
 		<td>
 			Explains how to get the latest updates that are available for a particular release of the Micro Integrator.
 		</td>
 	</tr>
 	<tr>
 		<td>
 			<a href="{{base-path}}/install-and-setup/setup/mi-setup/updating-mi"Data Stores</a>
 		</td>
 		<td>
 			Explains how to set up a user store, databases (multiple types), and a file-based registry. The topics covered are as follows:
 			<ul>
                <li>
                    <a href="{{base-path}}/install-and-setup/setup/mi-setup/user_stores/setting_up_a_userstore">Configuring a User Store</a>
                </li>
                <li>
                    <a href="{{base-path}}/install-and-setup/setup/mi-setup/databases/setting-up-MySQL">Setting up a MySQL Database</a>
                </li>
                <li>
                    <a href="{{base-path}}/install-and-setup/setup/mi-setup/databases/setting-up-MSSQL">Setting up a MSSQL Database</a>
                </li>
                <li>
                    <a href="{{base-path}}/install-and-setup/setup/mi-setup/databases/setting-up-Oracle">Setting up a Oracle Database</a>
                </li>
                <li>
                    <a href="{{base-path}}/install-and-setup/setup/mi-setup/databases/setting-up-PostgreSQL">Setting up a Postgre SQL Database</a>
                </li>
                <li>
                    <a href="{{base-path}}/install-and-setup/setup/mi-setup/databases/setting-up-IBM-DB2">Setting up a IBM Database</a>
                </li>
                <li>
                    <a href="{{base-path}}/install-and-setup/setup/mi-setup/deployment/file_based_registry">Configuring the File-based Registry</a>
                </li>
            </ul>		  														
 		</td>
 	</tr>
 	<tr>
 		<td>
 			<a>Securing the Micro Integrator</a>
 		</td>
 		<td>
 			Covers the different ways in which you can secure the Micro Integrator and the data it handles. The topic covered are as follows:
 			<ul>
 			    <li>
 			        <a>Setting up Keystores</a>
 			    </li>
                    <li>
                        <a href="{{base-path}}/install-and-setup/setup/mi-setup/security/creating_keystores">Creating New Keystores</a>
                    </li>
                    <li>
                        <a href="{{base-path}}/install-and-setup/setup/mi-setup/security/importing_ssl_certificate">Adding SSL certificates to keystores</a>
                    </li>
                    <li>
                        <a href="{{base-path}}/install-and-setup/setup/mi-setup/security/renewing_ca_signed_certificate_in_keystore">Renewing a CA-signed Certificate</a>
                    </li>
                    <li>
                        <a href="{{base-path}}/install-and-setup/setup/mi-setup/security/configuring_keystores">Configuring Keystores</a>
                    </li> 	                                                            			    
 			    <li>
 			        <a>Complying with GDPR</a>
 			    </li>
                    <li>
                        <a href="{{base-path}}/install-and-setup/setup/mi-setup/security/gdpr_ei">GDPR for the WSO2 Micro Integrator</a>
                    </li>
                    <li>
                        <a href="{{base-path}}/install-and-setup/setup/mi-setup/security/about_forgetme_tool">About the Identity Anonymization Tool</a>
                    </li>                     		    
 			    <li>
 			        <a>Working with Secrets</a>
 			    </li>
                    <li>
                        <a href="{{base-path}}/install-and-setup/setup/mi-setup/security/encrypting_plain_text">Encrypting Secrets using WSO2 Secure Vault</a>
                    </li>
                    <li>
                        <a href="{{base-path}}/install-and-setup/setup/mi-setup/security/using-hashicorp-secrets">Using Hashicorp Secrets</a>
                    </li>
                    <li>
                        <a href="{{base-path}}/install-and-setup/setup/mi-setup/security/single_key_encryption">Using Symmetric Encryption</a>
                    </li>                                          			    
 			    <li>
 			        <a href="{{base-path}}/install-and-setup/setup/mi-setup/security/securing_management_api">Securing the Management API</a>
 			    </li>
 			    <li>
 			        <a href="{{base-path}}/install-and-setup/setup/mi-setup/customizing_error_pages">Customizing Error Messages</a>
 			    </li> 			    		     			     			    
 			</ul>
 		</td>
 	</tr>
 	<tr>
 		<td>
 			<a>Performance</a>
 		</td>
 		<td>
 			Explains how to configure the Micro Integrator at different levels to optimize performance.
            <li>
                <a href="{{base-path}}/install-and-setup/setup/mi-setup/performance_tuning/tuning_jvm_performance">Tuning JVM Performance</a>
            </li>
            <li>
                <a href="{{base-path}}/install-and-setup/setup/mi-setup/performance_tuning/network_os_performance">Tuning Network and OS Performance</a>
            </li>
            <li>
                <a href="{{base-path}}/install-and-setup/setup/mi-setup/performance_tuning/jdbc_tuning">Tuning JDBC Configurations</a>
            </li>
            <li>
                <a href="{{base-path}}/install-and-setup/setup/mi-setup/performance_tuning/http_transport_tuninge">Tuning the HTTP Transport</a>
            </li>
            <li>
                <a href="{{base-path}}/install-and-setup/setup/mi-setup/performance_tuning/jms_transport_tuning">Tuning the JMS Transport</a>
            </li>
            <li>
                <a href="{{base-path}}/install-and-setup/setup/mi-setup/performance_tuning/tuning-the-VFS-Transport">Tuning the VFS Transport</a>
            </li>
            <li>
                <a href="{{base-path}}/install-and-setup/setup/mi-setup/performance_tuning/rabbitmq_transport_tuning">Tuning the RabbitMQ Transport</a>
            </li>
            <li>
                <a href="{{base-path}}/install-and-setup/setup/mi-setup/performance_tuning/tuning-inbound-endpoints">Tuning the Inbound Endpoints</a>
            </li>
 		</td>
 	</tr>
 	<tr>
 		<td>
 			<a href="{{base-path}}/install-and-setup/install/installing-the-product/installing-the-binary/installing-on-windows">Message Brokers</a>
 		</td>
 		<td>
 			Explains how to set up the Micro Integrator component to integrate with message brokers such as RabbitMQ, Kafka, and JMS. The topics covered are as follows:
 			<li>
 			    <a>AMQP (RabbitMQ)</a>
 			</li>
                <li>
                    <a href="{{base-path}}/install-and-setup/setup/mi-setup/brokers/deploy-rabbitMQ">Deploying RabbitMQ</a>
                </li>
                <li>
                    <a href="{{base-path}}/install-and-setup/setup/mi-setup/brokers/configure-with-rabbitMQ">Connecting to RabbitMQ</a>
                </li>                
 			<li>
 			    <a>JMS</a>
 			</li>
                <li>
                    <a href="{{base-path}}/install-and-setup/setup/mi-setup/brokers/configure-with-ActiveMQ">Connecting to ActiveMQ</a>
                </li>
                <li>
                    <a href="{{base-path}}/install-and-setup/setup/mi-setup/brokers/configure-with-Apache-Artemis">Connecting to Apache Artemis</a>
                </li>
                <li>
                    <a href="{{base-path}}/install-and-setup/setup/mi-setup/brokers/configure-with-HornetQ">Connecting to HornetQ</a>
                </li>
                <li>
                    <a href="{{base-path}}/install-and-setup/setup/mi-setup/brokers/configure-with-IBM-websphere-app-server">Connecting to IBM Websphere App Server</a>
                </li>
                <li>
                    <a href="{{base-path}}/install-and-setup/setup/mi-setup/brokers/configure-with-IBM-websphereMQ">Connecting to IBM WebSphere MQ</a>
                </li>
                <li>
                    <a href="{{base-path}}/install-and-setup/setup/mi-setup/brokers/configure-with-JBossMQ">Connecting to JBoss MQ</a>
                </li>
                <li>
                    <a href="{{base-path}}/install-and-setup/setup/mi-setup/brokers/configure-with-MSMQ">Connecting to MSMQ</a>
                </li>
                <li>
                    <a href="{{base-path}}/install-and-setup/setup/mi-setup/brokers/configure-with-SwiftMQ">Connecting to Swift MQ</a>
                </li>
                <li>
                    <a href="{{base-path}}/install-and-setup/setup/mi-setup/brokers/configure-with-Tibco-EMS">Connecting to TIBCO EMS</a>
                </li>
                <li>
                    <a href="{{base-path}}/install-and-setup/setup/mi-setup/brokers/configure-with-WebLogic">Connecting to Weblogic</a>
                </li>
                <li>
                    <a href="{{base-path}}/install-and-setup/setup/mi-setup/brokers/configure-with-WSO2-MB">Connecting to WSO2 MB</a>
                </li>
                <li>
                    <a href="{{base-path}}/install-and-setup/setup/mi-setup/brokers/configure-with-multiple-brokers">Connecting to Multiple Brokers</a>
                </li>                                                                                                                                                                
 			<li>
 			    <a href="{{base-path}}/install-and-setup/setup/mi-setup/feature_configs/configuring-kafka">Kafka</a>
 			</li>
 			<li>
 			    <a href="{{base-path}}/install-and-setup/setup/mi-setup/brokers/configure-with-azureservicebus">Azure Service Bus</a>
 			</li> 			 			 			
 		</td>
 	</tr>
 	<tr>
 		<td>
 			<a href="{{base-path}}/install-and-setup/setup/mi-setup/transport_configurations/configuring-transports">Transports</a>
 		</td>
 		<td>
 			Explains how to configure the Micro Integrator component to work with a range of transports. These include all the widely used transports including HTTP/S, JMS, VFS, as well as domain-specific transports such as FIX.
 		</td>
 	</tr>
 	<tr>
 		<td>
 			<a href="{{base-path}}/install-and-setup/setup/mi-setup/transport_configurations/multi-https-transport">Multi-HTTPS Transport</a>
 		</td>
 		<td>
 			Explains how to enable dynamic SSL profiles for the Micro Integrator component and how to  dynamically load the SSL profiles at runtime using a periodic schedule or JMX invocation.
 		</td>
 	</tr>
 	<tr>
 		<td>
 			<a href="{{base-path}}/install-and-setup/setup/mi-setup/message_builders_formatters/message-builders-and-formatters">Message Builders and Formatters</a>
 		</td>
 		<td>
            When the Micro Integrator receives a request via a transport, the transport uses a **message builder** to process the payload and convert it to SOAP. Similarly, when the Micro Integrator sends a message via a transport, the publishing transport uses a **message formatter** to present the payload in the required format. This section explains how to configure these message builders and message formatters.
 		</td>
 	</tr>
 	<tr>
 		<td>
 			<a href="{{base-path}}/install-and-setup/setup/mi-setup/message_builders_formatters/message-relay">Message Relay</a>
 		</td>
 		<td>
 			Enabling message relay allows the Micro Integrator component to to pass messages along without building or processing them unless specifically requested to do so. This way, the Micro Integrator can handle a higher throughput.
 		</td>
 	</tr>
 	<tr>
 		<td>
 			<a href="{{base-path}}/install-and-setup/setup/mi-setup/observability/observability-deployment-strategy">Observability</a>
 		</td>
 		<td>
 			There are two possible observability solutions that you can enable for the Micro Integrator component. This section explains how to set them up and well as how to configure logging. The topics covered are as follows:
 			<li>
 			    <a href="{{base-path}}/install-and-setup/setup/mi-setup/observability/setting-up-minimum-basic-observability-deployment">Setting up Cloud-Native Observability on a VM</a>
 			</li>
 			<li>
 			    <a href="{{base-path}}/install-and-setup/setup/mi-setup/observability/setting-up-cloud-native-observability-in-kubernetes">Setting up Cloud-Native Observability on Kubernetes</a>
 			</li> 			
 			<li>
 			    <a href="{{base-path}}/install-and-setup/setup/mi-setup/observability/setting-up-classic-observability-deployment">Setting up Classic Observability Deployment</a>
 			</li>
 			<li>
 			    <a>Configuring Logs</a>
 			</li>
                <li>
                    <a href="{{base-path}}/administer-and-observe/logs/enabling_component_logs">Enabling Logs for a Component</a>
                </li>
                <li>
                    <a href="{{base-path}}/administer-and-observe/logs/configuring_log4j_properties">Configuring Logs</a>
                </li>
                <li>
                    <a href="{{base-path}}/administer-and-observe/logs/managing_log_growth">Managing Log Growth</a>
                </li>
                <li>
                    <a href="{{base-path}}/administer-and-observe/logs/masking_sensitive_info_in_logs">Masking Sensitive Information in Logs</a>
                </li>                                                 		 						 			
 		</td>
 	</tr>
 	<tr>
 		<td>
 			<a href="{{base-path}}/install-and-setup/setup/mi-setup/feature_configs/configuring_timestamp_conversion_for_rdbms">Timestamp Conversion for RDBMS</a>
 		</td>
 		<td>
 			Explains how to enable/disable time stamp conversions for the RDBMS databases configured for the Micro Integrator component..
 		</td>
 	</tr>	 	
 </table>

### Migrating

### Upgrading

## The Streaming Integrator

This component develops streaming solutions that can be exposed as managed APIs in an asynchronous manner.

### Installing

### Deploying

### Set up

Setting up the Streaming Integrator component involves performing the following tasks:

 <table>
 	<tr>
 		<td>
 			<a href="{{base-path}}/install-and-setup/setup/si-setup/updating-si">Applying WSO2 Updates</a>
 		</td>
 		<td>
 			Explains how to get the latest updates that are available for a particular release of the Streaming Integrator.
 		</td>
 	</tr>
 	<tr>
 		<td>
 			<a href="{{base-path}}/install-and-setup/setup/si-setup/production-checklist">Production Checklist</a>
 		</td>
 		<td>
 			Lists all the setup tasks you need to complete in order to run the Streaming Integrator component in a production environment.
 		</td>
 	</tr>
 	<tr>
 		<td>
 			<a href="{{base-path}}/install-and-setup/setup/si-setup/performance-analysis-results">Performance Analysis Results</a>
 		</td>
 		<td>
 			This has the results of the performance tests carried out for the Streaming Integrator component.
 		</td>
 	</tr>
 	<tr>
 		<td>
 			<a href="{{base-path}}/install-and-setup/setup/si-setup/configuring-business-rules-deployment">Configuring Business Rules Deployment</a>
 		</td>
 		<td>
 			Explains how to configure a Streaming Integrator node to use a specified business rule template. Business rules templates are templates Streaming applications and queries that allow you to use the streaming logic ofWSO2 API Manager without writing queries from scratch.
 		</td>
 	</tr>
 	<tr>
 		<td>
 			<a href="{{base-path}}/install-and-setup/setup/si-setup/configuring-data-sources">Configuring Data Sources</a>
 		</td>
 		<td>
		 	Explains how to configure the data sources vis which the Streaming Integrator server and the Streaming Integrator Tooling connect to databases. This section also explains the default data sources configured for the Streaming Integrator and the Streaming Integrator Tooling.	
 		</td>
 	</tr>
 	<tr>
 		<td>
 			<a>Securing the Streaming Integrator</a>
 		</td>
 		<td>
 			Explains how to secure the Streaming Integrator component and the data it handles. The topics covered are as follows.
 			<li>
 			    <a href="{{base-path}}/install-and-setup/setup/si-setup/general-data-protection-regulations">General Data Protection Regulations</a>
 			</li>
 			<li>
 			    <a href="{{base-path}}/install-and-setup/setup/si-setup/working-with-keystores">Working with Keystores</a>
 			</li>
 			<li>
 			    <a href="{{base-path}}/install-and-setup/setup/si-setup/protecting-sensitive-data-via-the-secure-vault">Protecting Sensitive Data via the Secure Vault</a>
 			</li>
 		</td>
 	</tr>
 	<tr>
 		<td>
 			<a href="{{base-path}}/install-and-setup/setup/si-setup/supporting-different-transports">Supporting Different Transports</a>
 		</td>
 		<td>
 			Explains the setup tasks you need to complete to allow the Streaming Integrator component to work with different transports.
 		</td>
 	</tr>
 	<tr>
 		<td>
 			<a href="{{base-path}}/install-and-setup/setup/si-setup/configuring-database-and-file-system-state-persistence">Configuring State Persistence</a>
 		</td>
 		<td>
 			Explains how to prevent the loss of data that can result from a system failure by persisting the state of Streaming Integrator component periodically either into a database system or into the file system.
 		</td>
 	</tr>
 	<tr>
 		<td>
 			<a href="{{base-path}}/install-and-setup/setup/si-setup/configuring-cluster-coordination">Configuring Cluster Coordination</a>
 		</td>
 		<td>
 			Explains how to configure a cluster coordination strategy that determines how the Streaming Integrator nodes in a cluster coordinate with each other.
 		</td>
 	</tr>
 	<tr>
 		<td>
 			<a href="{{base-path}}/install-and-setup/setup/si-setup/adding-third-party-non-osgi-libraries">Adding Third Party Non OSGi Libraries</a>
 		</td>
 		<td>
 			The Streaming Integrator component is OSGi-based. Therefore, when you are adding non-OSGi libraries to the Streaming Integrator pack, you need to first convert them into OSGi bundles. This section provides instructions to do this.
 		</td>
 	</tr>
 	<tr>
 		<td>
 			<a href="{{base-path}}/install-and-setup/setup/si-setup/configuring-default-ports">Configuring Default Ports</a>
 		</td>
 		<td>
 			Explains the default ports that the Streaming Integrator component uses for different purposes when the port offset is 0.
 		</td>
 	</tr>
 	<tr>
 		<td>
 			<a href="{{base-path}}/install-and-setup/setup/si-setup/change-hostname-and-context-path">Changing the Host Name and Context Path of Web UI Applications</a>
 		</td>
 		<td>
 			Explains how to change the host name and the context path specified in the URLS via which the user interfaces of the Streaming Integrator are accessed.
 		</td>
 	</tr>
 	<tr>
 		<td>
 			<a href="{{base-path}}/install-and-setup/setup/si-setup/monitoring-received-events-count-via-logs">Enabling Logs for Received Event Count</a>
 		</td>
 		<td>
 			Explains how to configure the Streaming Integrator component to log the total number of events it received via its sources per given time interval.
 		</td>
 	</tr> 			 		 	 	 	
 </table>

### Migrating

### Upgrading

## Install

The installation guide of WSO2 API Manager explains how to set the API Manager and its components on a single node or in a container. For installation prerequisites for a single API Manager node, see [Installation Prerequisites]({{base_path}}/install-and-setup/install/installation-prerequisites).

For instructions to install each component, see the topics below:

- [Installing API Manager]({{base_path}}/install-and-setup/install/installing-the-product)
- [Installing Micro Integrator]({{base_path}}/install-and-setup/install/installing-mi)
- [Installing Streaming Integrator]({{base_path}}/install-and-setup/install/installing-si)


## Deploy

You can deploy WSO2 API Manager and its components in a virtual machine or in a containerized environment. 

To get started with deployment, see [Deployment Overview]({{base_path}}/install-and-setup/setup/deployment-overview)

## Setup





## SSO

This section explains how to configure Single Sign On (SSO) for the WSO2 API Manager.

WSO2 API Manager uses the OIDC Single Sign-On feature by default. Alternatively, you can configure WSO2 Identity Server or OKTA as the external identity provider.
## Advanced confuguration

## References

This subsection contains some reference information related to installing and setting up WSO2 API Manager

## Upgrade

This covers several scenarios that involve upgrading from an older version of WSO2 API Manager to a newer version.

## Kubernetes operators

This covers all topics related to the Kubernetes API Operator.

## API Controller

WSO2 API Controller(CTL) is a command-line tool for managing API Manager environments, listing APIs, API products and applications, creating API projects, importing and exporting APIs, API products and applications, generating tokens for APIs and API products for testing purposes, etc. and managing WSO2 Micro Integrator.

This section covers how to download, install and set up the API Controller.