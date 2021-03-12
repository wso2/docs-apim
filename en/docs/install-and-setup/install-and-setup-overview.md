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
 			Covers the different ways in which you can secure the API Manager and the data it handles. The topic covered are as follows:
 			<ul>
 			    <li>
 			        <a></a>
 			    </li>
 			    <li>
 			        <a></a>
 			    </li>
 			    <li>
 			        <a></a>
 			    </li>
 			    <li>
 			        <a></a>
 			    </li>
 			    <li>
 			        <a></a>
 			    </li> 			    		     			     			    
 			</ul>
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

### Migrating

### Upgrading

## The Streaming Integrator

This component develops streaming solutions that can be exposed as managed APIs in an asynchronous manner.

### Installing

### Deploying

### Setting up

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

Setting up involves doing the required configurations for the API Manager and its components before running them in the production environment. The following are some common set up tasks that you are required to do separately for each component.

In addition, there are component-specific setup tasks. For more information, see [Setup Overview]({{base_path}}/install-and-setup/setup/setup-overview).

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