# All-in-One Deployment Overview

An all-in-one deployment contains all the API-M components in one runtime instance. This is easy to set up and requires less resources when compared with a distributed deployment. Although a distributed deployment provides high performance and a high level of scalability, it may be too complex if you want to a small to medium scale API management solution. The all-in-one deployment is ideal if you want to start small and iteratively build up a robust API management platform.

- [All-in-One Deployment Overview](#all-in-one-deployment-overview)
  - [Single Node Deployment](#single-node-deployment)
  - [Active - Active Deployment](#active---active-deployment)
  - [Secure Broker Connection Configuration](#secure-broker-connection-configuration)

## Single Node Deployment

In this setup, API traffic is served by one all-in-one instance of WSO2 API Manager.

<a href="{{base_path}}/assets/img/setup-and-install/single-node-apim-deployment.png"><img src="{{base_path}}/assets/img/setup-and-install/single-node-apim-deployment.png" alt="single-node api-m deployment" width="60%"></a>

| Pros 	| Cons 	|
|---	|---	|
| Production support is required only for a single API Manager node (you receive 24*7 WSO2 production support). 	|  	|
| Deployment is up and running within hours. 	|  	|
| Can handle up to 43 million API calls a day (up to 500 API calls a second) 	|  	|
| Minimum hardware/cloud infrastructure requirements (only one node). 	|  	|
| Suitable for anyone new to API Management. 	| Deployment does not provide High Availability. 	|
|  	| Not network friendly. Deploying on a demilitarized zone (DMZ) would require a Reverse Proxy. 	|

!!! info
    For more information on manually configuring a single node API-M production server, see [Configuring a Single Node]({{base_path}}/install-and-setup/deploying-wso2-api-manager/single-node/configuring-a-single-node/).


## Active - Active Deployment

In this setup, API traffic is served by two single node (all-in-one) instances of WSO2 API Manager.

<a href="{{base_path}}/assets/img/setup-and-install/active-active-apim-deployment.png"><img src="{{base_path}}/assets/img/setup-and-install/active-active-apim-deployment.png" alt="active-active apim deployment" width="60%"></a>

| Pros   | Cons |
|--------|------|
| The system is highly available. |        | 
| Production support is required for 2 API Manager nodes (you receive 24\*7 WSO2 production support). |     |
| Can handle up to 86 million API calls a day ( up to 1000 API calls a second)|    |
| Deployment is up and running within hours. |    Not network friendly. Deploying on a DMZ would require a Reverse Proxy. |

!!! info
    For more information on manually configuring active-active API-M production servers, see [Configuring an Active-Active Deployment]({{base_path}}/install-and-setup/deploying-wso2-api-manager/single-node/configuring-an-active-active-deployment/).

## Secure Broker Connection Configuration

For production deployments, you may need to enable secure broker connections for JMS communication within the API-M components. This is especially important when deploying in distributed environments or when security policies require encrypted inter-component communication.

### Enabling TLS/SSL for JMS Communications

If required, you can enable TLS/SSL for JMS communications in your all-in-one deployment. Add the following configuration to your `<API-M_HOME>/repository/conf/deployment.toml` file.

**JMS SSL Configuration for Gateway-Traffic Manager Communication:**

```toml
[apim.throttling.jms]
topic_connection_factory = "amqp://<![CDATA[<username>]]>:<![CDATA[<password>]]>@clientid/carbon?brokerlist='tcp://<hostname>:8672?ssl='true'%26ssl_cert_alias='<certificate_alias_in_truststore>'%26trust_store='<path_to_trust_store>'%26trust_store_password='<truststore_password>'%26key_store='<path_to_key_store>'%26key_store_password='<keystore_password>''"
```

**Secure Broker Connection Configuration:**

```toml
[broker.transport.amqp.ssl_connection]
enabled = true
port = 8672
ssl_enabled_protocols = "TLSv1,TLSv1.2"
ciphers = "TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384,TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256,TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384,TLS_ECDH_ECDSA_WITH_AES_256_GCM_SHA384,TLS_ECDH_RSA_WITH_AES_256_GCM_SHA384,TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256"

[broker.transport.amqp.ssl_connection.keystore]
location = "repository/resources/security/wso2carbon.jks"
password = "wso2carbon"
cert_type = "SunX509"

[broker.transport.amqp.ssl_connection.truststore]
location = "repository/resources/security/client-truststore.jks"
password = "wso2carbon"
cert_type = "SunX509"
```

!!! tip
    These configurations are optional and should only be added if your deployment requires secure broker connections. For more detailed information on distributed deployment security configurations, see [Security Guidelines for Production Deployment]({{base_path}}/install-and-setup/setup/deployment-best-practices/security-guidelines-for-production-deployment/#runtime-level-security).
