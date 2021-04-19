# Adding a Custom Proxy Path

!!! Warning
    **Please note that the contents on this page are under review!**

Adding a custom proxy path is useful when you have a proxy server
fronting your product server. In this scenario, the "custom proxy path"
is used for mapping a proxy url with the actual url of your
server, which allows clients to access the server with the proxy
url.

This feature is particularly useful when multiple WSO2 products are
hosted under the same domain name. For example, consider that you have
three WSO2 products; WSO2 API Manager, WSO2 Micro Integrator, and WSO2 Identity Server, deployed
in your production environment and you want all of them to be hosted
with the "wso2test.com" domain. By using a reverse proxy and by
configuring your servers with 'custom proxy paths' , you can host all
products under a single domain and assign proxy paths for each product
separately.

!!! Note
    Once you have configured your products with a proxy server, it will no longer be possible to access the product behind the proxy.

In the above example, "apimanager", "micro-integrator", and "iam" are the "proxy context paths" of the respective products:

```toml
[Config_Heading]
parameter="value"
```

 When a client sends a request to the proxy entry url path, e.g.
<https://wso2test.com/apimanager> , the request is directed to the
back-end service url (
[https://10.100.1.1:<PortNumber>/carbon](https://10.100.1.1:9443/carbon)
) where the original service lies. Eventually, the client has to be
served via the requested proxy entry url path. The mapping between the
proxy url path and the back-end service url path is resolved by the
reverse proxy server fronting the back-end service.

!!! Info
    Prior to this solution, it was necessary to host these products as sub domains of the "wso2.com" domain as:
    [https://apim.wso2.com](https://apim.wso2test.com) ,
    [https://micro-interator.wso2.com](https://micro-integrator.wso2test.com) ,
    [https://iam.wso2.com](https://iam.wso2test.com) .


## Access WSO2 products through a custom proxy path

This functionality will be demonstrated in this documentation using two
WSO2 product servers as examples; WSO2 API Manager and WSO2 MI
as the back-end servers, and [nginx](http://nginx.org/) as the reverse
proxy.

Follow the steps given below.

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
    create the private key as shown below. Note that a pass phrase is
    prompted when creating the private key.  

    ```bash
    sudo openssl genrsa -des3 -out server.key 1024
    ```

5.  Next, create the certificate signing request as shown below.

    ```bash
    sudo openssl req -new -key server.key -out server.csr
    ```

    Fill in the required details. Most important entry is the Common
    Name. Enter the domain name or the ip address if there is no domain
    name.

6.  Next step is to sign the SSL certificate using the following
    command:  

    ```bash
    sudo openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt
    ```

    The certificate is now created.

7.  The last step is to set up the virtual host displaying the new
    certificate. Create a copy of the default, " sites-enabled"
    configuration using the following command:  

    ```bash
    sudo cp /etc/nginx/sites-available/default /etc/nginx/sites-available/wso2
    ```

8.  Now, create a symbolic between the " sites-enabled" directory and
    the "sites-available" directory using the following command:  

    ```bash
    sudo ln -s /etc/nginx/sites-available/wso2 /etc/nginx/sites-enabled/wso2
    ```

    The host is now activated.

9.  Open the `           /etc/nginx/sites-enabled/wso2          ` file
    and enter the following configurations.

    ```bash
    #Configurations for listener 8243.
    server {
        listen 8243;
        server_name wso2test.com;
        client_max_body_size 100M;

        root /usr/share/nginx/www;
        index index.html index.htm;

        ssl on;
        ssl_certificate /etc/nginx/ssl/server.crt;
        ssl_certificate_key /etc/nginx/ssl/server.key;

        #with portOffset 0 running APIM
        location /apim/ {
            proxy_pass https://wso2test.com:8243/;
            proxy_redirect https://wso2test.com:8243/ https://wso2test.com:8243/apim/;
            proxy_cookie_path / /apim;
        }

        #with portOffset 10 running MI
        location /mi/ {
            proxy_pass https://wso2test.com:8253/;
            proxy_redirect https://wso2test.com:8243/ https://wso2test.com:8243/mi/;
            proxy_cookie_path / /mi;
        }
    }

    #Configurations for listener 8280.
    server {
        listen 8280;
        server_name wso2test.com;
        client_max_body_size 100M;

        root /usr/share/nginx/www;
        index index.html index.htm;

        #with portOffset 0 running APIM
        location /apim/ {
            proxy_pass http://wso2test.com:9763/;
            proxy_redirect http://wso2test.com:8280/ http://wso2test.com:8280/apim/;
            proxy_cookie_path / /apim;
        }

        #with portOffset 10 running MI
        location /mi/ {
            proxy_pass http://wso2test.com:8290/;
            proxy_redirect http://wso2test.com:8280/ http://wso2test.com:8280/mi/;
            proxy_cookie_path / /mi;
        }
    }
    ```

    !!! Info
        According to the nginx configuration, https requests with the /mi/\* pattern are directed to the /\* pattern and then when the service is served to the client, it resolves the url pattern to /mi/\*. This works the same for http requests.

10. Save the file and restart the nginx server using the following
    command to complete the nginx configuration:  

    ```bash
    sudo service nginx restart
    ```

11. In the above configuration, the https and http requests are
    listening on 8243 and 8280 ports respectively. Server name is set to
    wso2test.com. To test this in a local machine, you need to add
    `           wso2test.com          ` , `mi.wso2test.com` and
    `           apim.wso2.com          ` to the
    `           /etc/hosts          ` file as shown below.  

    ```bash
    127.0.0.1  wso2test.com
    127.0.0.1  apim.wso2test.com
    127.0.0.1  mi.wso2test.com
    ```

### Step 2: Configure products with proxy context path

1.  Download WSO2 Application Server and WSO2 ESB.
2.  Open the `                       deployment.toml                     `
    file stored in the
    `           <MI_HOME>/conf/          ` directory and
    set the HostName to what you defined in the nginx configuration as
    shown below (for both products):

    ```bash
    [server]
    hostname = "wso2test.com"
    ```
    
3. Open the carbon.xml file stored in the <APIM_HOME>/repository/conf/ directory and set the HostName to what you defined in the nginx configuration as shown below:

    ```xml
    <HostName>wso2test.com</HostName>
    ```

4.  Set the proxy context path as shown below. This is the proxy path
    string, which will appear in the management console, web apps and
    services urls.

    -   For APIM: In <APIM_HOME>/repository/conf/carbon.xml file 

        ```xml
        <ProxyContextPath>appserver</ProxyContextPath> 
        ```
    <!--
    -   For MI: In <MI_HOME>/conf/deployment.toml file

        ```xml
        <ProxyContextPath>esb</ProxyContextPath> 
        ```
    -->
    
5.  Since you need to run both products (AS and ESB) simultaneously, set
    port offsets as shown below.

    -   For APIM:
        `<Offset>0</Offset>            `

    -   For MI:
        ```toml
        [server]
        offset  = 0     
        ```

### Step 3: Start the Product

Start the server and invoke services:

-   For APIM:
    https://wso2test.com:8243/apim/<api_name>
-   For MI: https://wso2test.com:8243/mi/<api_name>
