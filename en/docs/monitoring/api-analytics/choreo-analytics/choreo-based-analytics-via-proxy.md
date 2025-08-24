# Choreo Based Analytics via Proxy

   This documentation outlines the steps to configure APIM Analytics with Choreo through a proxy, utilizing a self-signed certificate for secure communication.

## Prerequisites

   - Install OpenSSL.

## Installation and Configuration Steps

### Step 1: Install mitmproxy

   First, install mitmproxy by following the instructions on the [official mitmproxy documentation](https://docs.mitmproxy.org/stable/overview-installation/). This tool will act as the intercepting proxy between your API Manager and the internet.

### Step 2: Generate a Self-Signed Certificate

   To create a secure channel, generate a self-signed certificate using the following steps:

   1. Create a configuration file named `req.conf` with the following content:

   ```toml
   [req]
   distinguished_name = req_distinguished_name
   x509_extensions = v3_req
   prompt = no

   [req_distinguished_name]
   C = US
   ST = VA
   L = SomeCity
   O = MyCompany
   OU = MyDivision
   CN = www.company.com

   [v3_req]
   keyUsage = keyEncipherment, dataEncipherment
   extendedKeyUsage = serverAuth
   subjectAltName = @alt_names

   [alt_names]
   IP.1 = 127.0.0.1
   DNS.1 = localhost
   DNS.2 = analytics-event-auth.choreo.dev
   DNS.3 = analytics-prod-incoming.servicebus.windows.net
   ```

   2. Generate the certificate and key by executing the following command:

   ```conf
   openssl genrsa -out cert.key 2048

   openssl req -new -x509 -key cert.key -out cert.crt -config req.conf -extensions 'v3_req'

   cat cert.key cert.crt > cert.pem
   ```

   More details on configuring certificates in mitmproxy can be found [here](https://docs.mitmproxy.org/stable/concepts-certificates/).

!!! note
    In a production environment, it is crucial to use a certificate issued by a trusted Certificate Authority (CA) instead of a self-signed certificate. This ensures the integrity and trustworthiness of the secure connections established by your infrastructure.

### Step 3: API Manager Configuration

   Import the generated cert.crt and cert.key into the API Manager's client-truststore and keystore. Then, apply the following configurations to your deployment.toml file:

   ```toml
   [apim.analytics]
   enable = true
   config_endpoint = 'https://analytics-event-auth.choreo.dev/auth/v1'
   auth_token = 'YOUR_AUTH_TOKEN'

   [apim.analytics.properties]
   proxy_config_enable = true
   proxy_config_host ='127.0.0.1'
   proxy_config_port = '3128'
   proxy_config_protocol = 'https'
   ```

   Replace `YOUR_AUTH_TOKEN` with the On-premise key. For guidance on obtaining this key, please refer to the instructions provided in the [WSO2 documentation](https://apim.docs.wso2.com/en/latest/monitoring/api-analytics/choreo-analytics/getting-started-guide/#step-2-register-your-environment).

### Step 3: API Manager Configuration

   Launch mitmproxy with the following command to start intercepting traffic:

   ```conf
   mitmweb --web-port 8086 --listen-port 3128 -m regular --no-http2 --certs cert.pem
   ```

   For further details on mitmproxy and its configurations, consult the [mitmproxy documentation](https://docs.mitmproxy.org/stable/overview-installation/).
