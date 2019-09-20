# Customize the API Store and Gateway URLs for Tenants

The default URL of WSO2 API Manager Store is `https://<HostName>:9443/store` . Follow the steps below to change the URL of the Gateways and API Store tenants in WSO2 API Manager.

-   [Install Nginx and create SSL certificates](#CustomizetheAPIStoreandGatewayURLsforTenants-InstallNginxandcreateSSLcertificates)
-   [Setup custom domain mapping in the registry](#CustomizetheAPIStoreandGatewayURLsforTenants-Setupcustomdomainmappingintheregistry)
-   [Configure the store webapp](#CustomizetheAPIStoreandGatewayURLsforTenants-Configurethestorewebapp)

#### Install Nginx and create SSL certificates

Follow the steps below to install Nginx and create SSL certificates.

!!! note
Install nginx in Mac OS

If you are using Mac OS, you need to install Nginx using the [brew package manager](https://brew.sh/) . The commands are as follows.

-   Command to install nginx

    ``` java
        brew install nginx
    ```

-   Command to run nginx

    ``` java
            sudo nginx
    ```


1.  Run the following command and install Nginx, if not already available.

    ``` java
        sudo apt-get install nginx
    ```

2.  Create an SSL certificate.

    ``` java
            sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/nginx.crt
    ```

3.  Navigate to the `<API-M_HOME>/repository/resources/security` directory and use the following command to add the certificate to the client trust store.

    ``` java
            keytool -import -file /etc/nginx/ssl/nginx.crt -keystore client-truststore.jks -storepass wso2carbon -alias wso2carbon2
    ```

4.  Navigate to the `/etc/nginx/sites-enabled/default` directory in your terminal and add the following configurations with your custom domain name.

    ``` java
            server {
                   listen 443;
                   ssl on;
                   ssl_certificate /etc/nginx/ssl/nginx.crt;
                   ssl_certificate_key /etc/nginx/ssl/nginx.key;
                   location / {
                       proxy_set_header X-WSO2-Tenant "ten5.com";
                       proxy_set_header X-Forwarded-Host $host;
                       proxy_set_header X-Forwarded-Server $host;
                       proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                       proxy_set_header Host $http_host;
                       proxy_pass https://localhost:9443/store/;
                       proxy_redirect  https://localhost:9443/store/ /;
                       proxy_redirect  <custom URL>;
                       proxy_cookie_path /store/ /;
                   }
            }
    ```

#### Setup custom domain mapping in the registry

!!! note
Only the super tenant can add custom URLs in their registry space for other tenants. Tenants cannot configure custom URLs for their Store or Gateway.


1.  Log in to the management console ( `https://<HostName>:9443/carbon` ) as the super admin.

2.  In the **Main** menu, click **Browse** under **Resources.
    ![](/assets/attachments/103334773/103334777.png)**

3.  Navigate to the `/_system/governance registry` path and create the following directory structure in the registry.

        !!! note
    In [API Cloud](https://docs.wso2.com/display/APICloud/Customize+Cloud+URLs) , this directory structure is created automatically when specifying the custom URL through the UI.


`customurl/api-cloud/<tenant-domain>/urlMapping          `

    ![](/assets/attachments/103334773/103334776.png)

        !!! tip
    To create a directory in the registry path,

    1. Navigate to the location in the registry browser, click and open the location.

    2. Click **Add Collection** and specify the name of the directory and click **Add** .

    ![](/assets/attachments/103334773/103334775.png)


4.  Navigate to `/_system/governance/customurl/api-cloud/< tenant-domain>/urlMapping` . Click **Add Resource** under **Entries** and click **Create Text Content.**

5.  Add the following resource configurations to the registry and click **Add** .

    ``` java
        {    "tenantDomain": "<tenant domain name>",
            "store" : {
                "customUrl" : "<custom domain for store>"
            },
            "gateway" : {
                "customUrl" : "<custom domain for gateway>"
            }
        }
    ```

    ![](/assets/attachments/103334773/103334774.png)

The URLs of the Store and Gateway are updated accordingly.

#### Configure the store webapp

1.  Go to `<API-M_HOME>/repository/deployment/server/jaggeryapps/store/site/conf` directory, open the `site.json` file and add the tenant header parameter as shown below.

    ``` java
            "reverseProxy" : {
                    "enabled" : "auto", 
                    "host" : "sample.proxydomain.com", 
                    "context":"",
                    "tenantHeader" : "X-WSO2-Tenant"
                },
    ```

    You can choose any name for the header and set the virtual host to create the specific domain.

For details on how to create and manage multiple tenants, see [Managing Tenants](https://docs.wso2.com/display/AM260/Managing+Tenants) . You can also see [Multi-tenant Architecture](https://docs.wso2.com/display/AM200/Multi-tenant+Architecture) for more information about tenants.
