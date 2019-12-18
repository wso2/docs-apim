# Adding a Custom Proxy Path

Adding a custom proxy path is useful when you have a proxy server fronting your Carbon server. In this scenario, the "custom proxy path" is used for mapping a proxy url with the actual url of your Carbon server, which allows clients to access the Carbon server with the proxy url.

This feature is particularly useful when multiple WSO2 products are hosted under the same domain name. For example, consider that you have three WSO2 products; Application Server, API Manager and ESB, deployed in your production environment and you want all of them to be hosted with the "wso2test.com" domain. By using a reverse proxy and by configuring your servers with 'custom proxy paths' , you can host all products under a single domain and assign proxy paths for each product separately as shown below:
![Custom Proxy Paths]({{base_path}}/assets/attachments/126562770/126562773.png)

**Proxy URLs mapped to Carbon server URLs:**

-   [https://10.100.1.1:&lt;ListeningPort-apimanager&gt;/carbon](https://10.100.1.1:9443/carbon) mapped to <https://wso2test.com/apimanager> .
-   [https://10.100.1.1:&lt;ListeningPort-esb&gt;/carbon](https://10.100.1.1:9443/carbon) mapped to <https://wso2test.com/esb> .
-   [https://10.100.1.1:&lt;ListeningPort-appserver&gt;/carbon](https://10.100.1.1:9443/carbon) mapped to <https://wso2test.com/appserver> .

!!! note
Note the following:

-   This functionality is only available for WSO2 products that are based on Carbon 4.3.0 or a later Carbon version. See the [WSO2 product release matrix](http://wso2.com/products/carbon/release-matrix/) for more information about WSO2 Carbon platform releases.
-   Once you have configured your products with a proxy server, it will no longer be possible to access the product behind the proxy. See the section given below on [configuring products to use the proxy server](#AddingaCustomProxyPath-Step2) for more information.


In the above example, "apimanager", "esb" and "appserver" are the "proxy context paths" of the respective products, which are configured in the `carbon.xml` file (stored in `<PRODUCT_HOME>/repository/conf/` directory) for each product. When a client sends a request to the proxy entry url path, e.g. <https://wso2test.com/apimanager> , the request is directed to the back-end service url ( [https://10.100.1.1:&lt;PortNumber&gt;/carbon](https://10.100.1.1:9443/carbon) ) where the original service lies. Eventually, the client has to be served via the requested proxy entry url path. The mapping between the proxy url path and the back-end service url path is resolved by the reverse proxy server fronting the back-end service.

!!! info
Prior to this solution, it was necessary to host these products as sub domains of the "wso2.com" domain as: [https://apim.wso2.com](https://apim.wso2test.com) , [https://esb.wso2.com](https://esb.wso2test.com) , [https://as.wso2.com](https://as.wso2test.com) .


### Access WSO2 products through a custom proxy path

This functionality will be demonstrated in this documentation using two WSO2 product servers as examples; WSO2 Application Server and WSO2 ESB as the back-end servers, and [nginx](http://nginx.org/) as the reverse proxy.

Follow the steps given below.

-   [Step 1: Install and configure a reverse proxy](#AddingaCustomProxyPath-Step1:Installandconfigureareverseproxy)
-   [Step 2: Configure products with proxy context path](#AddingaCustomProxyPath-Step2Step2:Configureproductswithproxycontextpath)
-   [Step 3: Start the Product](#AddingaCustomProxyPath-Step3:StarttheProduct)

#### Step 1: Install and configure a reverse proxy

1.  Download [nginx server](http://nginx.org/) .
2.  Install the nginx server in your deployment server by executing the following command:

    ``` java
        sudo apt-get install nginx
    ```

3.  Create a folder called "ssl" inside /etc/nginx, and create the ssl certificates inside this folder by executing the following commands:

    ``` java
            sudo mkdir /etc/nginx/ssl
            cd /etc/nginx/ssl
    ```

4.  The next step is to create the server key and certificates. First create the private key as shown below. Note that a pass phrase is prompted when creating the private key.

    ``` java
            sudo openssl genrsa -des3 -out server.key 1024
    ```

5.  Next, create the certificate signing request as shown below.

    ``` java
            sudo openssl req -new -key server.key -out server.csr
    ```

    Fill in the required details. Most important entry is the Common Name. Enter the domain name or the ip address if there is no domain name.

6.  Next step is to sign the SSL certificate using the following command:

    ``` java
            sudo openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt
    ```

    The certificate is now created.

7.  The last step is to set up the virtual host displaying the new certificate. Create a copy of the default, " sites-enabled" configuration using the following command:

    ``` java
            sudo cp /etc/nginx/sites-available/default /etc/nginx/sites-available/wso2
    ```

8.  Now, create a symbolic between the " sites-enabled" directory and the "sites-available" directory using the following command:

    ``` java
            sudo ln -s /etc/nginx/sites-available/wso2 /etc/nginx/sites-enabled/wso2
    ```

    The host is now activated.

9.  Open the `/etc/nginx/sites-enabled/wso2` file and enter the following configurations.

    ``` java
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
             
                #with portOffset 0 running AS
                location /appserver/ {
                    proxy_pass https://wso2test.com:9443/;
                    proxy_redirect https://wso2test.com:8243/ https://wso2test.com:8243/appserver/;
                    proxy_cookie_path / /appserver;
                }
             
                #with portOffset 10 running ESB
                location /esb/ {
                    proxy_pass https://wso2test.com:9453/;
                    proxy_redirect https://wso2test.com:8243/ https://wso2test.com:8243/esb/;
                    proxy_cookie_path / /esb;
                }
            }
    #Configurations for listener 8280.
    server {
        listen 8280;
        server_name wso2test.com;
        client_max_body_size 100M;
     
        root /usr/share/nginx/www;
        index index.html index.htm;
     
        #with portOffset 0 running AS
        location /appserver/ {
            proxy_pass http://wso2test.com:9763/;
            proxy_redirect http://wso2test.com:8280/ http://wso2test.com:8280/appserver/;
            proxy_cookie_path / /appserver;
        }
     
        #with portOffset 10 running ESB
        location /esb/ {
            proxy_pass http://wso2test.com:9773/;
            proxy_redirect http://wso2test.com:8280/ http://wso2test.com:8280/esb/;
            proxy_cookie_path / /esb;
        }
    }
    ```
        !!! note
    According to the nginx configuration, https requests with the /appserver/\* pattern are directed to the /\* pattern and then when the service is served to the client, it resolves the url pattern to /appserver/\*. This works the same for http requests.


10. Save the file and restart the nginx server using the following command to complete the nginx configuration:

    ``` java
        sudo service nginx restart
    ```

11. In the above configuration, the https and http requests are listening on 8243 and 8280 ports respectively. Server name is set to wso2test.com. To test this in a local machine, you need to add `wso2test.com` and `as.wso2.com` to the `/etc/hosts` file as shown below.

    ``` java
            127.0.0.1  wso2test.com 
            127.0.0.1  as.wso2test.com
            127.0.0.1  esb.wso2test.com
    ```

#### Step 2: Configure products with proxy context path

1.  Download WSO2 Application Server and WSO2 ESB.
2.  Open the `carbon.xml` file stored in the `<PRODUCT_HOME>/repository/conf/` directory and set the HostName to what you defined in the nginx configuration as shown below (for both products):

    ``` java
            <HostName>wso2test.com</HostName>
    ```

3.  Now, set the MgtHostName as shown below.

    -   For Application Server:

        ``` java
                    <MgtHostName>as.wso2test.com</MgtHostName>
        ```

    -   For ESB:

        ``` java
                    <MgtHostName>esb.wso2test.com</MgtHostName> 
        ```

4.  Set the "ProxyContextPath" as shown below. This is the proxy path string, which will appear in the management console, web apps and services urls.

    -   For Application Server:

        ``` java
                    <ProxyContextPath>appserver</ProxyContextPath> 
        ```

    -   For ESB:

        ``` java
                    <ProxyContextPath>esb</ProxyContextPath> 
        ```

5.  Since you need to run both products (AS and ESB) simultaneously, set port offsets as shown below.

    -   For Application Server: `<Offset>0</Offset>`

    -   For ESB: `<Offset>10</Offset>`

6.  According to the nginx configuration, the https, http requests are listening on 8243 and 8280 ports. However, by default WSO2 products are listening on 9443 (WSO2 Application Server) and 9453 (WSO2 ESB). Therefore, the listening ports of the reverse proxy should be configured as proxy ports in Application Server and ESB respectively. T o enable proxy ports, open the `<PRODUCT_HOME>/repository/conf/tomcat/catalina-server.xml` file and add the "proxyPort" entries.

        !!! note
    Note that after you define proxy ports (8243 and 8280) in the `catalina-server.xml` file, it will no longer be possible to access the products using the normal ports (9443 and 9453).


    For example, the "proxyPort" entries for Application Server are as follows:

    ``` java
        <Connector  protocol="org.apache.coyote.http11.Http11NioProtocol"
                        port="9763"
                        proxyPort="8280"
                        redirectPort="9443" 
                        bindOnInit="false"
                        maxHttpHeaderSize="8192"
                        acceptorThreadCount="2"
                        maxThreads="250"
                        minSpareThreads="50"
                        disableUploadTimeout="false"
                        connectionUploadTimeout="120000"
                        maxKeepAliveRequests="200"
                        acceptCount="200"
                        server="WSO2 Carbon Server"
                        compression="on"
                        compressionMinSize="2048"
                        noCompressionUserAgents="gozilla, traviata"
                        compressableMimeType="text/html,text/javascript,application/xjavascript,application/javascript,application/xml,text/css,
                                              application/xslt+xml,text/xsl,image/gif,image/jpg,image/jpeg" 
                        URIEncoding="UTF-8"/>
            <!--
            optional attributes:
            proxyPort="443"
            -->
            <Connector  protocol="org.apache.coyote.http11.Http11NioProtocol"
                        port="9443"
                        proxyPort="8243"
                        bindOnInit="false"
                        sslProtocol="TLS"
                        maxHttpHeaderSize="8192"
    ```

#### Step 3: Start the Product

1.  Start the server and enter the following url in a browser:
    -   For Application Server: https://wso2test.com:8243/appserver/carbon/
    -   For ESB: https://wso2test.com:8243/esb/carbon/
2.  Give the admin credentials and log in to the server. You'll find the proxy path for admin console, services, webapps changed for each product as shown below.
    -   For “/appserver” proxy path: https://wso2test.com:8243/appserver/carbon/admin/index.jsp.
    -   For "/esb" proxy path: https://wso2test.com:8243/esb/carbon/admin/index.jsp.

