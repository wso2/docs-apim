# Access WSO2 API Manager through a custom proxy path

Adding a custom proxy path is useful when you have a proxy server
fronting your product server. In this scenario, the "custom proxy path"
is used for mapping a proxy URL with the actual URL of your
server, which allows clients to access the server with the proxy
URL.

In the following hypothetical scenario, devportal, publisher, admin, and carbon console apps are hosted in the knnect.lk domain as follows.

1. https://knnect.lk/apim/devportal/
2. https://knnect.lk/apim/publisher/
3. https://knnect.lk/apim/admin/
4. https://knnect.lk/apim/carbon/

!!! note
    Once you have configured your products with a proxy server, it will no longer be possible to access the product behind the proxy.

In the above example, "apim" is the "proxy context paths" of API Manager.

 When a client sends a request to the proxy entry URL path, e.g.
<https://knnect.lk/apim> , the request is directed to the
back-end service URL ([https://<server-ip>:9443/carbon](https://<server-ip>:9443/carbon)) 
where the original service lies. Eventually, the client has to be
served via the requested proxy entry URL path. The mapping between the
proxy URL path and the back-end service URL path is resolved by the
reverse proxy server fronting the back-end service.

### Step 1: Install and configure a reverse proxy

1.  Download [nginx server](http://nginx.org/) .
2.  Install the nginx server in your deployment server by executing the
    following command:

    ```bash
    sudo apt-get install nginx
    ```

3.  Create a folder called "ssl" inside /etc/nginx, and create the ssl
    certificates inside this folder by executing the following
    commands:  

    ```bash
    sudo mkdir /etc/nginx/ssl
    cd /etc/nginx/ssl
    ```

4.  The next step is to create the server key and certificates. First
    create the private key as shown below. Note that a passphrase is
    prompted when creating the private key.  

    ```bash
    sudo openssl genrsa -des3 -out server.key 1024
    ```

5.  Next, create the certificate signing request as shown below.

    Fill in the required details. The most important entry is the Common
    Name. Enter the domain name or the IP address if there is no domain name. 
    In the current example, we can give `knnect.lk`

    ```bash
    sudo openssl req -new -key server.key -out server.csr
    ```
    

6.  Next step is to sign the SSL certificate using the following
    command:  

    ```bash
    sudo openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt
    ```

    The certificate is now created.

7.  The last step is to set up the virtual host displaying the new
    certificate. Create a copy of the default, "sites-enabled"
    configuration using the following command:  

    ```bash
    cp /etc/nginx/sites-available/default /etc/nginx/sites-available/wso2
    ```

    If your Nginx installation does not contain "sites-enabled" and "sites-available" folders, follow the steps given below.

    1. Create /etc/nginx/sites-available and /etc/nginx/sites-enabled. 
    2. Open /etc/nginx/nginx.conf
    3. Add `include /etc/nginx/sites-enabled/*;` into the http block.


8.  Now, create a symbolic between the "sites-enabled" directory and
    the "sites-available" directory using the following command:  

    ```bash
    ln -s /etc/nginx/sites-available/wso2 /etc/nginx/sites-enabled/wso2
    ```

    The host is now activated.

9.  Open the `/etc/nginx/sites-enabled/wso2` file
    and enter the following configurations.

    ```nginx
    server {
            listen 443 ssl default_server;
            listen [::]:443 default_server ipv6only=on;
            server_name  knnect.lk office.knnect.com;
            access_log  /var/log/nginx/proxy.log;

            ssl_certificate /etc/nginx/ssl/server.crt;
            ssl_certificate_key /etc/nginx/ssl/server.key;
            
            ssl_session_timeout  5m;
            ssl_protocols       TLSv1 TLSv1.1 TLSv1.2;
            ssl_ciphers  HIGH:!aNULL:!MD5;
            ssl_prefer_server_ciphers   on;

            rewrite \w*(admin|devportal|publisher)$ $1/ permanent;

            location /apim/ {   
                proxy_set_header X-Forwarded-Host $host;
                proxy_set_header X-Forwarded-Server $host;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header Host $http_host;
                proxy_read_timeout 5m;
                proxy_send_timeout 5m;

                proxy_pass https://localhost:9443/;
                proxy_redirect https://knnect.lk/authenticationendpoint/ https://knnect.lk/apim/authenticationendpoint/;
                proxy_redirect https://knnect.lk/oauth2/ https://knnect.lk/apim/oauth2/;
                proxy_redirect https://knnect.lk/carbon/ https://knnect.lk/apim/carbon/;

                proxy_http_version 1.1;
                proxy_set_header Upgrade $http_upgrade;
                proxy_set_header Connection "upgrade";
            }
    }
    ```

10. Save the file and restart the Nginx server using the following
    command to complete the Nginx configuration:  

    ```bash
    sudo nginx -s reload
    ```
    Or start the Nginx server if it's not running.

    ```bash
    sudo nginx
    ```

### Step 2: Add host entries
Add the following host entries

```
127.0.0.1 knnect.lk
```

### Step 3: Update the API Manager configuration - deployment.toml

Open `repository/conf/deployment.toml` and add or update the following configurations.

```toml
[server]
hostname = "knnect.lk"
node_ip = "127.0.0.1"
mode = "single" #single or ha
base_path = "${carbon.protocol}://${carbon.host}:${carbon.management.port}/apim"
server_role = "default"
proxy_context_path = "/apim"

[apim.devportal]
url = "https://knnect.lk/apim/devportal"

[transport.https.properties]
proxyPort = 443
```

!!! note
    1. The hostname is set to "knnect.lk"
    2. base_path has a suffix of "/apim" which is the proxy_context_path
    3. proxy_context_path is set to "/apim"

### Step 4: Update the API Manager configuration - web.xml.j2

Open the following file.
`repository/resources/conf/templates/repository/conf/tomcat/carbon/WEB-INF/web.xml.j2`

Add the configuration below with the same level as other `<context-param>` nodes.
```xml
<context-param>
      <param-name>contextPath</param-name>
      <param-value>apim</param-value>
</context-param>
```

### Step 5: Update the API Manager web app configurations

Add the following configuration to each web application.

**devportal/site/public/theme/settings.js**
```js
context: '/apim/devportal', 
proxy_context_path: '/apim',
```

**publisher/site/public/conf/settings.js**
```js
context: '/apim/publisher', 
proxy_context_path: '/apim',
```

**admin/site/public/conf/settings.js**
```js
context: '/apim/admin', 
proxy_context_path: '/apim',
```

Now start/restart the API Manager server

The API Manager web applications will be accessible as expected.
