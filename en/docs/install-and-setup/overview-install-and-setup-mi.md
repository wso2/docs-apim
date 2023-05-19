# Install and Setup Overview

The installation and the setup of WSO2 Micro Integrator involve installing the product, deploying it in the method that is best suited for your requirements, and setting it up to run in the production environment. If you already have an older version of WSO2 Micro Integrator you can follow the upgrading instructions in this guide.

This component develops complex integration services that can be exposed as managed APIs.

### Installing

To install and run the Micro Integrator on a virtual machine, see the topics given below.

<table>
    <tr>
        <th>
            <a href="{{base_path}}/install-and-setup/install/installing-the-product/installing-mi">Installing the Micro Integrator Runtime</a>
        </th>
        <td>
            Explains how to download the Micro Integrator runtime as a binary and install it on a virtual machine.
        </td>
    </tr>   
    <tr>
        <th>
            <a href="{{base_path}}/install-and-setup/install/installing-the-product/running-the-mi">Running the Micro Integrator Runtime</a>
        </th>
        <td>
            Explains how you can execute the Micro Integrator runtime and start using its features.
        </td>
    </tr> 
    <tr>
        <th>
            <a href="{{base_path}}/install-and-setup/install/installing-the-product/installing-mi-as-a-windows-service">Running the Micro Integrator as a Windows Service</a>
        </th>
        <td>
            Explains how to install and run the Micro Integrator as a Windows service.
        </td>
    </tr>
</table>

To install and run the Micro Integrator Dashboard on a virtual machine, see the topics given below.

<table>
    <tr>
        <th>
            <a href="{{base_path}}/install-and-setup/install/installing-the-product/installing-mi-dashboard">Installing the Micro Integrator Dashboard</a>
        </th>
        <td>
            Explains how to download the Micro Integrator Dashboard as a binary and install it on a virtual machine.
        </td>
    </tr>   
    <tr>
        <th>
            <a href="{{base_path}}/install-and-setup/install/installing-the-product/running-the-mi-dashboard">Running the Micro Integrator Dashboard</a>
        </th>
        <td>
            Explains how you can execute the Micro Integrator Dashboard and start using its features.
        </td>
    </tr> 
</table>

### Setting up

To set up and configure the Micro Integrator runtime, see the topics given below.

<table>
<tr>
    <th>
        <a href="{{base_path}}/install-and-setup/setup/mi-setup/updating-mi">Applying WSO2 Updates</a>
    </th>
    <td>
        Explains how to get the latest updates that are available for a particular release of the Micro Integrator.
    </td>
</tr>
<tr>
    <th>
        <a href="{{base_path}}/install-and-setup/setup/mi-setup/updating-mi">Data Stores</a>
    </th>
    <td>
        Explains how to set up a user store, databases (multiple types), and a file-based registry. The topics covered are as follows:
        <ul>
            <li>
                <a href="{{base_path}}/install-and-setup/setup/mi-setup/user_stores/setting_up_a_userstore">Configuring a User Store</a>
            </li>
            <li>
                <a href="{{base_path}}/install-and-setup/setup/mi-setup/databases/setting-up-MySQL">Setting up a MySQL Database</a>
            </li>
            <li>
                <a href="{{base_path}}/install-and-setup/setup/mi-setup/databases/setting-up-MSSQL">Setting up a MSSQL Database</a>
            </li>
            <li>
                <a href="{{base_path}}/install-and-setup/setup/mi-setup/databases/setting-up-Oracle">Setting up a Oracle Database</a>
            </li>
            <li>
                <a href="{{base_path}}/install-and-setup/setup/mi-setup/databases/setting-up-PostgreSQL">Setting up a Postgre SQL Database</a>
            </li>
            <li>
                <a href="{{base_path}}/install-and-setup/setup/mi-setup/databases/setting-up-IBM-DB2">Setting up a IBM Database</a>
            </li>
            <li>
                <a href="{{base_path}}/install-and-setup/setup/mi-setup/deployment/file_based_registry">Configuring the File-based Registry</a>
            </li>
        </ul>                                                               
    </td>
</tr>
<tr>
    <th>
        <a>Securing the Micro Integrator</a>
    </th>
    <td>
        Covers the different ways in which you can secure the Micro Integrator and the data it handles. The topic covered are as follows:
        <ul>
            <li>
                <a>Setting up Keystores</a>
            </li>
                <li>
                    <a href="{{base_path}}/install-and-setup/setup/mi-setup/security/creating_keystores">Creating New Keystores</a>
                </li>
                <li>
                    <a href="{{base_path}}/install-and-setup/setup/mi-setup/security/importing_ssl_certificate">Adding SSL certificates to keystores</a>
                </li>
                <li>
                    <a href="{{base_path}}/install-and-setup/setup/mi-setup/security/renewing_ca_signed_certificate_in_keystore">Renewing a CA-signed Certificate</a>
                </li>
                <li>
                    <a href="{{base_path}}/install-and-setup/setup/mi-setup/security/configuring_keystores">Configuring Keystores</a>
                </li>                                                                               
            <li>
                <a>Complying with GDPR</a>
            </li>
                <li>
                    <a href="{{base_path}}/install-and-setup/setup/mi-setup/security/gdpr_ei">GDPR for the WSO2 Micro Integrator</a>
                </li>
                <li>
                    <a href="{{base_path}}/install-and-setup/setup/mi-setup/security/about_forgetme_tool">About the Identity Anonymization Tool</a>
                </li>                               
            <li>
                <a>Working with Secrets</a>
            </li>
                <li>
                    <a href="{{base_path}}/install-and-setup/setup/mi-setup/security/encrypting_plain_text">Encrypting Secrets using WSO2 Secure Vault</a>
                </li>
                <li>
                    <a href="{{base_path}}/install-and-setup/setup/mi-setup/security/using-hashicorp-secrets">Using Hashicorp Secrets</a>
                </li>
                <li>
                    <a href="{{base_path}}/install-and-setup/setup/mi-setup/security/single_key_encryption">Using Symmetric Encryption</a>
                </li>                                                       
            <li>
                <a href="{{base_path}}/install-and-setup/setup/mi-setup/security/securing_management_api">Securing the Management API</a>
            </li>
            <li>
                <a href="{{base_path}}/install-and-setup/setup/mi-setup/customizing_error_pages">Customizing Error Messages</a>
            </li>                                                           
        </ul>
    </td>
</tr>
<tr>
    <th>
        <a>Performance</a>
    </th>
    <td>
        Explains how to configure the Micro Integrator at different levels to optimize performance.
        <li>
            <a href="{{base_path}}/install-and-setup/setup/mi-setup/performance_tuning/tuning_jvm_performance">Tuning JVM Performance</a>
        </li>
        <li>
            <a href="{{base_path}}/install-and-setup/setup/mi-setup/performance_tuning/network_os_performance">Tuning Network and OS Performance</a>
        </li>
        <li>
            <a href="{{base_path}}/install-and-setup/setup/mi-setup/performance_tuning/jdbc_tuning">Tuning JDBC Configurations</a>
        </li>
        <li>
            <a href="{{base_path}}/install-and-setup/setup/mi-setup/performance_tuning/http_transport_tuninge">Tuning the HTTP Transport</a>
        </li>
        <li>
            <a href="{{base_path}}/install-and-setup/setup/mi-setup/performance_tuning/jms_transport_tuning">Tuning the JMS Transport</a>
        </li>
        <li>
            <a href="{{base_path}}/install-and-setup/setup/mi-setup/performance_tuning/tuning-the-vfs-transport">Tuning the VFS Transport</a>
        </li>
        <li>
            <a href="{{base_path}}/install-and-setup/setup/mi-setup/performance_tuning/rabbitmq_transport_tuning">Tuning the RabbitMQ Transport</a>
        </li>
        <li>
            <a href="{{base_path}}/install-and-setup/setup/mi-setup/performance_tuning/tuning-inbound-endpoints">Tuning the Inbound Endpoints</a>
        </li>
    </td>
</tr>
<tr>
    <th>
        <a>Message Brokers</a>
    </th>
    <td>
        Explains how to set up the Micro Integrator component to integrate with message brokers such as RabbitMQ, Kafka, and JMS. The topics covered are as follows:
        <li>
            <a>AMQP (RabbitMQ)</a>
        </li>
            <li>
                <a href="{{base_path}}/install-and-setup/setup/mi-setup/brokers/deploy-rabbitMQ">Deploying RabbitMQ</a>
            </li>
            <li>
                <a href="{{base_path}}/install-and-setup/setup/mi-setup/brokers/configure-with-rabbitMQ">Connecting to RabbitMQ</a>
            </li>                
        <li>
            <a>JMS</a>
        </li>
            <li>
                <a href="{{base_path}}/install-and-setup/setup/mi-setup/brokers/configure-with-activemq">Connecting to ActiveMQ</a>
            </li>
            <li>
                <a href="{{base_path}}/install-and-setup/setup/mi-setup/brokers/configure-with-apache-artemis">Connecting to Apache Artemis</a>
            </li>
            <li>
                <a href="{{base_path}}/install-and-setup/setup/mi-setup/brokers/configure-with-hornetq">Connecting to HornetQ</a>
            </li>
            <li>
                <a href="{{base_path}}/install-and-setup/setup/mi-setup/brokers/configure-with-ibm-websphere-app-server">Connecting to IBM Websphere App Server</a>
            </li>
            <li>
                <a href="{{base_path}}/install-and-setup/setup/mi-setup/brokers/configure-with-ibm-webspheremq">Connecting to IBM WebSphere MQ</a>
            </li>
            <li>
                <a href="{{base_path}}/install-and-setup/setup/mi-setup/brokers/configure-with-jbossmq">Connecting to JBoss MQ</a>
            </li>
            <li>
                <a href="{{base_path}}/install-and-setup/setup/mi-setup/brokers/configure-with-msmq">Connecting to MSMQ</a>
            </li>
            <li>
                <a href="{{base_path}}/install-and-setup/setup/mi-setup/brokers/configure-with-swiftmq">Connecting to Swift MQ</a>
            </li>
            <li>
                <a href="{{base_path}}/install-and-setup/setup/mi-setup/brokers/configure-with-tibco-ems">Connecting to TIBCO EMS</a>
            </li>
            <li>
                <a href="{{base_path}}/install-and-setup/setup/mi-setup/brokers/configure-with-weblogic">Connecting to Weblogic</a>
            </li>
            <li>
                <a href="{{base_path}}/install-and-setup/setup/mi-setup/brokers/configure-with-wso2-mb">Connecting to WSO2 MB</a>
            </li>
            <li>
                <a href="{{base_path}}/install-and-setup/setup/mi-setup/brokers/configure-with-multiple-brokers">Connecting to Multiple Brokers</a>
            </li>                                                                                                                                                                
        <li>
            <a href="{{base_path}}/install-and-setup/setup/mi-setup/feature_configs/configuring-kafka">Kafka</a>
        </li>
        <li>
            <a href="{{base_path}}/install-and-setup/setup/mi-setup/brokers/configure-with-azureservicebus">Azure Service Bus</a>
        </li>                                   
    </td>
</tr>
<tr>
    <th>
        <a href="{{base_path}}/install-and-setup/setup/mi-setup/transport_configurations/configuring-transports">Transports</a>
    </th>
    <td>
        Explains how to configure the Micro Integrator component to work with a range of transports. These include all the widely used transports including HTTP/S, JMS, VFS, as well as domain-specific transports such as FIX.
    </td>
</tr>
<tr>
    <th>
        <a href="{{base_path}}/install-and-setup/setup/mi-setup/transport_configurations/multi-https-transport">Multi-HTTPS Transport</a>
    </th>
    <td>
        Explains how to enable dynamic SSL profiles for the Micro Integrator component and how to  dynamically load the SSL profiles at runtime using a periodic schedule or JMX invocation.
    </td>
</tr>
<tr>
    <th>
        <a href="{{base_path}}/install-and-setup/setup/mi-setup/message_builders_formatters/message-builders-and-formatters">Message Builders and Formatters</a>
    </th>
    <td>
        When the Micro Integrator receives a request via a mode of transport, the transport uses a <b>message builder</b> to process the payload and convert it to SOAP. Similarly, when the Micro Integrator sends a message via a mode of transport, the publishing transport uses a <b>message formatter</b> to present the payload in the required format. This section explains how to configure these message builders and message formatters.
    </td>
</tr>
<tr>
    <th>
        <a href="{{base_path}}/install-and-setup/setup/mi-setup/message_builders_formatters/message-relay">Message Relay</a>
    </th>
    <td>
        Enabling message relay allows the Micro Integrator component to to pass messages along without building or processing them unless specifically requested to do so. This way, the Micro Integrator can handle a higher throughput.
    </td>
</tr>
<tr>
    <th>
        <a href="{{base_path}}/observe/micro-integrator/cloud-native-observability-overview">Observability</a>
    </th>
    <td>
        There are two possible observability solutions that you can enable for the Micro Integrator component. This section explains how to set them up and well as how to configure logging. The topics covered are as follows:
        <li>
            <a href="{{base_path}}/observe/micro-integrator/setting-up-cloud-native-observability-on-a-vm">Setting up Cloud-Native Observability on a VM</a>
        </li>
        <li>
            <a href="{{base_path}}/observe/micro-integrator/setting-up-cloud-native-observability-in-kubernetes/">Setting up Cloud-Native Observability on Kubernetes</a>
        </li>
        <li>
            <a href="{{base_path}}/install-and-setup/setup/mi-setup/observability/setting-up-classic-observability-deployment">Setting up Classic Observability Deployment</a>
        </li>
        <li>
            <a>Configuring Logs</a>
        </li>
            <li>
                <a href="{{base_path}}/observe/micro-integrator/classic-observability-logs/enabling-logs-for-a-component">Enabling Logs for a Component</a>
            </li>
            <li>
                <a href="{{base_path}}/observe/micro-integrator/classic-observability-logs/configuring-log4j2-properties">Configuring Logs</a>
            </li>
            <li>
                <a href="{{base_path}}/administer/logging-and-monitoring/logging/managing-log-growth">Managing Log Growth</a>
            </li>
            <li>
                <a href="{{base_path}}/administer/logging-and-monitoring/logging/masking-sensitive-information-in-logs">Masking Sensitive Information in Logs</a>
            </li>                                                                                           
    </td>
</tr>
<tr>
    <th>
        <a href="{{base_path}}/install-and-setup/setup/mi-setup/feature_configs/configuring_timestamp_conversion_for_rdbms">Timestamp Conversion for RDBMS</a>
    </th>
    <td>
        Explains how to enable/disable time stamp conversions for the RDBMS databases configured for WSO2 Micro Integrator component.
    </td>
</tr>       
</table>
 
### Deploying

To deploy the Micro Integrator runtime, see the topics given below.

<table>
    <tr>
        <th>
            <a href="{{base_path}}/install-and-setup/setup/mi-setup/deployment/deploying_wso2_ei">Configuring a Micro Integrator Cluster</a>
        </th>
        <td>
            Explains how to set up a two-node Micro Integrator cluster.
        </td>
    </tr>
    <tr>
        <th>
            <a href="{{base_path}}/install-and-setup/setup/mi-setup/deployment/deployment_synchronization">Deployment Synchronization</a>
        </th>
        <td>
            Set up deployment synchronization for the Micro Integrator.
        </td>
    </tr>
</table>

### CI/CD

To implement continuous integration and continuous deployment pipelines for integrations, see the topics given below.

<table>
    <tr>
        <th>
            <a href="{{base_path}}/install-and-setup/setup/mi-setup/deployment/mi-cicd-overview">CI/CD for Integrations - Overview</a>
        </th>
        <td>
            Find out about the methods of implementing CI/CD for integrations in the Micro Integrator.
        </td>
    </tr>
     <tr>
        <th>
            <a href="{{base_path}}/install-and-setup/setup/mi-setup/deployment/mi-cicd-vm">Building a CI/CD Pipeline for Integrations (VM deployment)</a>
        </th>
        <td>
            See the instructions on how to implement a CI/CD pipeline for integrations in a VM deployment of the Micro Integrator.
        </td>
    </tr>
    <tr>
        <th>
            <a href="{{base_path}}/install-and-setup/setup/mi-setup/deployment/mi-cicd-k8s">Building a CI/CD Pipeline for Integrations (K8s deployment)</a>
        </th>
        <td>
            See the instructions on how to implement a CI/CD pipeline for integrations in a Kubernetes deployment of the Micro Integrator.
        </td>
    </tr>
</table>

To manage integration artifacts and logs in the Micro Integrator by using the API Controller (apictl), see the topics given below.

<table>
    <tr>
        <th>
            <a href="{{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller">Getting Started with WSO2 API Controller</a>
        </th>
        <td>
            Explains how to set up the API Controller.
        </td>
    </tr>
    <tr>
        <th>
            <a href="{{base_path}}/install-and-setup/setup/api-controller/managing-integrations/managing-integrations-with-ctl">Managing Integrations</a>
        </th>
        <td>
            Explains how to manage integrations with the API Controller.
        </td>
    </tr>
</table>

### Upgrading

The Micro integrator of WSO2 Enterprise Integrator is the predecessor of the Micro Integrator component of WSO2 API Manager 4.2.0. To upgrade from a WSO2 Enterprise Integrator version, see [Upgrade WSO2 Micro Integrator]({{base_path}}/install-and-setup/setup/mi-setup/upgrading-micro-integrator).

## Reference

<table>
    <tr>
        <th>
            <a href="{{base_path}}/install-and-setup/setup/reference/default-product-ports-mi">Default Product Ports</a>
        </th>
        <td>
            Explains the default ports used by the WSO2 Micro Integrator.
        </td>
    </tr>
    <tr>
        <th>
            <a href="{{base_path}}/install-and-setup/setup/reference/product-compatibility-mi">Product Compatibility</a>
        </th>
        <td>
            Provides details relating to the compatibility of WSO2 Micro Integrator with different operating systems, JDKs and databases.
        </td>
    </tr>
    <tr>
        <th>
            <a href="{{base_path}}/install-and-setup/setup/reference/supported-cipher-suites">Supported Cipher Suites</a>
        </th>
        <td>
            Provides details of the supported cipher suites.
        </td>
    </tr>
</table>
