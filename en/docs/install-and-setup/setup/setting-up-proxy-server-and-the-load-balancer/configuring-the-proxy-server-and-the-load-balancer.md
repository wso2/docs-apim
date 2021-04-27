# Configuring the Proxy Server and the Load Balancer

A load balancer or reverse proxy is required to map external traffic with ports and URLs that WSO2 API Manager (WSO2 API-M) uses internally. 

Follow the instructions below to configure load balancing together with reverse proxying.

### Step 1 - Create an SSL certificate for the load balancer

!!! warning
    This step is only applicable for a High Availablity (HA) setup where multiple nodes are fronted by a load balancer.

Create an SSL certificate for the load balancer using the following instructions.

1.  Create the Server Key.

    ``` java
    sudo openssl genrsa -des3 -out <key_name>.key 1024
    ```

2.  Submit the certificate signing request (CSR).

    ``` java
    sudo openssl req -new -key <key_name>.key -out server.csr
    ```

3.  Remove the password.

    ``` java
    sudo cp <key_name>.key <key_name>.key.org 
    sudo openssl rsa -in <key_name>.key.org -out <key_name>.key
    ```

4.  Sign your SSL Certificate.

    ``` java
    sudo openssl x509 -req -days 365 -in server.csr -signkey <key_name>.key -out <certificate_name>.crt
    ```

5.  Copy the key and certificate files that you generated in the above step to the `/etc/nginx/ssl/` location.

### Step 2 - Configure the load balancer/reverse proxy server

In the following instructions, you are instructed to use NGINX to handle the load balancing requirements.

!!! warning
    Although the following section instructs you to use NGINX as the load balancer, **you can use any load balancer** in your deployment based on your preference.

!!! info
    NGINX is an HTTP and reverse proxy server, a mail proxy server, and a generic TCP/UDP proxy server. For more information, see <https://www.nginx.com/>.

Carry out the following steps to configure the load balancer to front multiple nodes.

1.  Install NGINX in a server configured in your cluster.

    !!! note
        The NGINX version that you need to install varies based on the WSO2 API-M components that the load balancer is fronting.

    <table>
    <thead>
    <tr class="header">
    <th><b>Deployment</b></th>
    <th><b>API-M Nodes</b></th>
    <th><b>LB</b></th>
    <th><b>Reason</b></th>
    </tr>
    </thead>
    <tbody>
    <tr class="odd">
    <td>Single all-in-one deployment</td>
    <td>N/A</td>
    <td>[NGINX Community](http://nginx.org/)</td>
    <td>This deployment does not need Sticky Sessions (Session Affinity).</td>
    </tr>
    <tr class="even">
    <td>Active-active deployment using single all-in-one nodes</td>
    <td>N/A</td>
    <td>[NGINX Plus](https://www.nginx.com/products/)</td>
    <td>This deployment requires Sticky Sessions, but NGINX Community version does not support it. You can use `ip_hash` as the sticky algorithm.</td>
    </tr>
    <tr class="odd">
    <td rowspan="3">Distributed deployment</td>
    <td>Gateway with a single Gateway Manager</td>
    <td>[NGINX Community version](http://nginx.org/)</td>
    <td>The Gateway node in this deployment does not need Sticky Sessions.</td>
    </tr>
    <tr class="even">
    <td>Gateway with multiple Gateway Managers</td>
    <td>[NGINX Plus](https://www.nginx.com/products/)</td>
    <td>The Gateway Manager nodes require Sticky Sessions, but NGINX Community version does not support it. You can use `ip_hash` as the sticky algorithm. Sticky Sessions are needed for port 9443 in the Gateway, and not needed for the pass-through ports in the Gateway (8243, 8280).</td>
    </tr>
    <tr class="odd">
    <td>Control Plane node running the Developer Portal, Publisher, and Key Manager</td>
    <td>[NGINX Plus](https://www.nginx.com/products/)</td>
    <td>Requires Sticky Sessions, but NGINX Community version does not support it. You can use `ip_hash` as the sticky algorithm.</td>
    </tr>
    </tbody>
    </table>

    For more information on installing NGINX, see **[NGINX community version](https://www.nginx.com/resources/admin-guide/installing-nginx-open-source/#prebuilt)** and **[NGINX Plus](https://www.nginx.com/resources/admin-guide/installing-nginx-plus/).**

2.  Configure **NGINX** to direct the HTTP and HTTPs requests based on your deployment.

    1.  Run the following command to identify the exact location of the `<NGINX_HOME>` directory. Inspect the output and identify the `--prefix` tag as it provides the location of the `<NGINX_HOME>` directory.

        ``` java
        nginx -V
        ```

    2.  Update the `ngnix.conf` file with the required NGINX configuration given below. If not, you can create a file with the `.conf` suffix and copy it to the `<NGINX_HOME>/conf.d` directory.

!!! note
    -   All ports are default ports assuming no port offsets are used.
    -   The key and the certificate for SSL is assumed to be at the `<NGINX_HOME>/ssl/` location. The placeholders `{cert_name}` and `{key_name}` are the name of the certificate and key generated.
    -   The directories used for access and error logs should be created if they do not exist.

!!! info

    **Single node**:

    -   The placeholder {node-ip-address} corresponds to the IP address of the backend node in which the WSO2 API-M server is running.
    -   In the sample configuration given below, the hostname api.am.wso2.com is used to access an all-in-one instance of the API-M runtime and gw.am.wso2.com is used to invoke APIs. Only HTTPS is allowed.

    **Active-Active**

    - The placeholders {node-1-ip-address} and {node-2-ip-address} correspond to the IP addresses of the backend nodes in which APIM servers are running.
    - In the sample configuration given below, the hostname api.am.wso2.com is used to access an all-in-one instance of the API-M runtime and gw.am.wso2.com is used to invoke APIs. Only HTTPS is allowed.
    - This configuration uses a session cookie to configure stickiness. However, if you are using Nginx community version, configuring sticky sessions based on session cookie is not supported. It is possible to use ip_hash method instead.

    - In an Active-Active deployment, it is mandatory to set up sticky sessions (session affinity) in the load balancers for the **Publisher** and **Developer Portal** components of the API-M runtime. However, sticky sessions are not required for the **Key Manager** and **Gateway** components.
    - However, authentication via session ID fails when sticky sessions are disabled in the load balancers (for the Publisher and Developer Portal).

    **HA for Gateway**

    -   The placeholder {gwm-ip-address} corresponds to the IP addresses of the backend nodes in which Gateway Manager server is running. Similarly, {gw-1-ip-address} and {gw-2-ip-address} are the nodes in which Gateway Workers are running.
    -   In the sample configuration given below, the mgtgw.am.wso2.com hostname is used to access management console of the Gateway Manager and gw.am.wso2.com is used to invoke APIs. Only HTTPS is allowed.
    -   If you are using multiple Gateway Managers when using a shared file system (e.g., NFS), then you need to enable sticky sessions.

    **HA for Control Plane**

    -   The placeholders {controlplane-1-ip-address} and {controlplane-2-ip-address} correspond to the IP addresses of the backend nodes in which API-M Control Planes are running.
    -   In the sample configuration given below, the hostname cp.am.wso2.com is used to access the Control Plane. Only HTTPS is allowed.
    -   This configuration uses a session cookie to configure stickiness. However, if you are using Nginx community version, configuring sticky sessions based on session cookie is not supported. It is possible to use the ip_hash method instead.

    **HA for Traffic Manager**

    -   The placeholders {tm-1-ip-address} and {tm-2-ip-address} correspond to the IP addresses of the back-end nodes in which APIM Traffic Managers are running.


!!! configurations
    ```tab="Single node"
    upstream sslapi.am.wso2.com {
        server {node-ip-address}:9443;
    }
    
    upstream sslgw.am.wso2.com {
        server {node-ip-address}:8243;
    }
    
    server {
        listen 80;
        server_name api.am.wso2.com;
        rewrite ^/(.*) https://api.am.wso2.com/$1 permanent;
    
    }
    
    server {
        listen 443 ssl;
        server_name api.am.wso2.com;
        proxy_set_header X-Forwarded-Port 443;
        ssl_certificate /etc/nginx/ssl/{cert_name};
        ssl_certificate_key /etc/nginx/ssl/{key_name};
        location / {
                proxy_set_header X-Forwarded-Host $host;
                proxy_set_header X-Forwarded-Server $host;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header Host $http_host;
                proxy_read_timeout 5m;
                proxy_send_timeout 5m;
                proxy_pass https://sslapi.am.wso2.com;
            }
    
            access_log /etc/nginx/log/am/https/access.log;
            error_log /etc/nginx/log/am/https/error.log;
    }
    
    server {
        listen 443 ssl;
        server_name gw.am.wso2.com;
        proxy_set_header X-Forwarded-Port 443;
        ssl_certificate /etc/nginx/ssl/{cert_name};
        ssl_certificate_key /etc/nginx/ssl/{key_name};
        location / {
                proxy_set_header X-Forwarded-Host $host;
                proxy_set_header X-Forwarded-Server $host;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header Host $http_host;
                proxy_read_timeout 5m;
                proxy_send_timeout 5m;
                proxy_pass https://sslgw.am.wso2.com;
            }
    
            access_log /etc/nginx/log/gw/https/access.log;
            error_log /etc/nginx/log/gw/https/error.log;
    }
    ```

    ```tab="Active-Active"
    upstream sslapi.am.wso2.com {
        server {node-1-ip-address}:9443;
        server {node-2-ip-address}:9443;
        #ip_hash;
        sticky learn create=$upstream_cookie_jsessionid
            lookup=$cookie_jsessionid
        zone=client_sessions:1m;
    }
    
    upstream sslgw.am.wso2.com {
        server {node-1-ip-address}:8243;
        server {node-2-ip-address}:8243;
    }
    
    server {
        listen 80;
        server_name api.am.wso2.com;
        rewrite ^/(.*) https://api.am.wso2.com/$1 permanent;
    }
    
    server {
        listen 443 ssl;
        server_name api.am.wso2.com;
        proxy_set_header X-Forwarded-Port 443;
        ssl_certificate /etc/nginx/ssl/{cert_name};
        ssl_certificate_key /etc/nginx/ssl/{key_name};
        location / {
                proxy_set_header X-Forwarded-Host $host;
                proxy_set_header X-Forwarded-Server $host;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header Host $http_host;
                proxy_read_timeout 5m;
                proxy_send_timeout 5m;
                proxy_pass https://sslapi.am.wso2.com;
            }
    
            access_log /etc/nginx/log/am/https/access.log;
            error_log /etc/nginx/log/am/https/error.log;
    }
    
    server {
        listen 443 ssl;
        server_name gw.am.wso2.com;
        proxy_set_header X-Forwarded-Port 443;
        ssl_certificate /etc/nginx/ssl/{cert_name};
        ssl_certificate_key /etc/nginx/ssl/{key_name};
        location / {
                proxy_set_header X-Forwarded-Host $host;
                proxy_set_header X-Forwarded-Server $host;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header Host $http_host;
                proxy_read_timeout 5m;
                proxy_send_timeout 5m;
                proxy_pass https://sslgw.am.wso2.com;
            }
    
            access_log /etc/nginx/log/gw/https/access.log;
            error_log /etc/nginx/log/gw/https/error.log;
    }
    ```

    ```tab="HA for Gateway"
    upstream gw.am.wso2.com {
        server {gw-1-ip-address}:9443;
        server {gw-2-ip-address}:9443 backup;
    }
    
    upstream sslgw.am.wso2.com {
        server {gw-1-ip-address}:8243;
        server {gw-2-ip-address}:8243;
    }
    
    server {
        listen 80;
        server_name gw.am.wso2.com;
        rewrite ^/(.*) https://gw.am.wso2.com/$1 permanent;
    }
    
    server {
        listen 443 ssl;
        server_name gwm.am.wso2.com;
        proxy_set_header X-Forwarded-Port 443;
        ssl_certificate /etc/nginx/ssl/{cert_name};
        ssl_certificate_key /etc/nginx/ssl/{key_name};
        location / {
                proxy_set_header X-Forwarded-Host $host;
                proxy_set_header X-Forwarded-Server $host;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header Host $http_host;
                proxy_read_timeout 5m;
                proxy_send_timeout 5m;
                proxy_pass https://gw.am.wso2.com;
            }
    
            access_log /etc/nginx/log/gwm/https/access.log;
            error_log /etc/nginx/log/gwm/https/error.log;
    }
    
    server {
        listen 443 ssl;
        server_name gw.am.wso2.com;
        proxy_set_header X-Forwarded-Port 443;
        ssl_certificate /etc/nginx/ssl/{cert_name};
        ssl_certificate_key /etc/nginx/ssl/{key_name};
        location / {
                proxy_set_header X-Forwarded-Host $host;
                proxy_set_header X-Forwarded-Server $host;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header Host $http_host;
                proxy_read_timeout 5m;
                proxy_send_timeout 5m;
                proxy_pass https://sslgw.am.wso2.com;
            }
    
            access_log /etc/nginx/log/gw/https/access.log;
            error_log /etc/nginx/log/gw/https/error.log;
    }
    ```

    ```tab="HA for Control Plane"
    upstream cp.am.wso2.com {
        server {cp-1-ip-address}:9443;
        server {cp-2-ip-address}:9443;
        #ip_hash;
        sticky learn create=$upstream_cookie_jsessionid
            lookup=$cookie_jsessionid
        zone=client_sessions:1m;
    }
    
    server {
        listen 80;
        server_name cp.am.wso2.com;
        rewrite ^/(.*) https://cp.am.wso2.com/$1 permanent;
    }
    
    server {
        listen 443 ssl;
        server_name cp.am.wso2.com;
        proxy_set_header X-Forwarded-Port 443;
        ssl_certificate /etc/nginx/ssl/{cert_name};
        ssl_certificate_key /etc/nginx/ssl/{key_name};
        location / {
                proxy_set_header X-Forwarded-Host $host;
                proxy_set_header X-Forwarded-Server $host;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header Host $http_host;
                proxy_read_timeout 5m;
                proxy_send_timeout 5m;
                proxy_pass https://cp.am.wso2.com;
            }
    
            access_log /etc/nginx/log/publisher/https/access.log;
            error_log /etc/nginx/log/publisher/https/error.log;
    }
    ```

    ```tab="HA for Traffic Manager"
    upstream tm.am.wso2.com {
    server {tm-1-ip-address}:9443;
    server {tm-2-ip-address}:9443  backup;
    }
                                
    server {
        listen 80;
        server_name tm.am.wso2.com;
        rewrite ^/(.*) https://tm.am.wso2.com/$1 permanent;
    }

    server {
        listen 443 ssl;
        server_name tm.am.wso2.com;
        proxy_set_header X-Forwarded-Port 443;
        ssl_certificate /etc/nginx/ssl/{cert_name};
        ssl_certificate_key /etc/nginx/ssl/{key_name};
        location / {
                proxy_set_header X-Forwarded-Host $host;
                proxy_set_header X-Forwarded-Server $host;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header Host $http_host;
                proxy_read_timeout 5m;
                proxy_send_timeout 5m;
                proxy_pass https://tm.am.wso2.com;
            }

            access_log /etc/nginx/log/tm/https/access.log;
            error_log /etc/nginx/log/tm/https/error.log;
    
    ```

The ports and URLs that are used internally by API Manager are given below:

| **Usage**                         | **URL**   | **Port** |
|-----------------------------------|-----------|----------|
| HTTPS Servlet (UI Consoles)       | localhost | 9443     |
| NIO transport (HTTP API Traffic)  | localhost | 8280     |
| NIO transport (HTTPS API Traffic) | localhost | 8243     |

Restart the NGINX server:

``` java
sudo service nginx restart
```

!!! tip
    You do not need to restart the server if you are simply making a modification to the VHost file. The following command is sufficient in such cases.

    ``` java
    sudo service nginx reload
    ```

### Step 3 - Configure the load balancer/reverse proxy settings in the product

When using a load balancer, you need to configure the proxy host and the port to be able to work with the Proxy Server configuration of the load balancer.

To do that add the following to the `<API-M_HOME>/repository/conf/deployment.toml` file as shown below.

```java
[transport.https.properties]
proxyPort = 443
[server]
hostname = "<loadbalancer_hostname>""
```
!!!note 
    When using a load balancer with the '9443' port, you only need to update the hostname of the load balancer in the `<API-M_HOME>/repository/conf/deployment.toml` file. An example is shown below.
    ```java
    [server]
    hostname = "<loadbalancer_hostname>"
    ```

### Step 4 - Configure the dynamic callback origin

When you have a custom URL configured for WSO2 API-M client applications (Publisher/ Developer Portal/ Admin Portal), the callback origin also has to be changed dynamically according to the X-Forwarded-For header in a typical scenario.

The following instructions are optional if you do not have a custom URL configured.

1. Open the new configuration file for reverse proxy config in the react applications.

    - **For Developer Portal**

         Open the `<API-M_HOME>/repository/deployment/server/jaggeryapps/devportal/site/public/theme/settings.js` file.
    
    - **For Publisher**
        
         Open the file `<API-M_HOME>/repository/deployment/server/jaggeryapps/publisher/site/public/conf/settings.js` file.
    
    - **For Admin Portal**
        
         Open the file `<API-M_HOME>/repository/deployment/server/jaggeryapps/admin/site/public/conf/settings.js` file.
 

2. Set `customUrl.enabled` to `true`
  
    ```json
        
    customUrl: { // Dynamically set the redirect origin according to the forwardedHeader host|proxyPort combination
        enabled: true,
        forwardedHeader: 'X-Forwarded-Host',
    },
    ```

    !!! Note
        New configurations do not have auto as a config value for the `customUrl.enable` property as it was in the 2.x versions.