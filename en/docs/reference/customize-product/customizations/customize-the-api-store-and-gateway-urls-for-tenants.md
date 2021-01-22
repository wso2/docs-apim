# Customizing the Developer Portal and Gateway URLs for Tenants

The default URL of WSO2 API Manager Developer Portal (`https://<HostName>:9443/devportal`) and the gateway URLs (`http://<HostName>:8280/t/<tenant-domain>` and `https://<HostName>:8243/t/<tenant-domain>`) can be customized per tenant. Following steps illustrate how to configure devportal and gateway custom urls for a given tenant.

-   [Configure per tenant custom domain mappings](#configure-per-tenant-custom-domain-mappings)
-   [Configure per tenant service provider creation for devportal](#configure-per-tenant-service-provider-creation-for-devportal)
-   [Configure the load balancer for custom URLs](#configure-the-load-balancer-for-custom-urls)

## Configure per tenant custom domain mappings

!!! note
    Only the super tenant can add custom URLs in their registry space for other tenants. Tenants cannot configure custom URLs for their Developer Portal or Gateway.

1.  Log in to the management console ( `https://<HostName>:9443/carbon` ) as the super admin.

2.  In the **Main** menu, click **Browse** under **Resources**.

    ![]({{base_path}}/assets/img/develop/customizations/browse-registry.png)

3.  Navigate to the `/_system/governance` registry path and create `customurl/api-cloud/<tenant-domain>/urlMapping` directory structure in the registry, as shown in the following diagram. Replace the `<tenant-domain>` placeholder with the domain name of the tenant you want to customize the devportal and gateway URLs. For details on how to create and manage multiple tenants, see [Managing Tenants]({{base_path}}/administer/multitenancy/managing-tenants).

    ![]({{base_path}}/assets/img/develop/customizations/mapping-file-directory-structure.png)

    To create a directory in the registry path,

    1.  Navigate to the location in the registry browser, click and open the location.

    2.  Click **Add Collection** and specify the name of the directory and click **Add**.
    
        ![]({{base_path}}/assets/img/develop/customizations/browse-registry.png)

        !!! note
            In [API Cloud](https://docs.wso2.com/display/APICloud/Customize+Cloud+URLs), this directory structure is created automatically when specifying the custom URL through the UI.

4.  Navigate to `/_system/governance/customurl/api-cloud/<tenant-domain>/urlMapping` in the registry. Click **Add Resource** under **Entries** and select **Create Text Content** as the resource type.

5.  Provide tenant domain as the resource name and add the following configurations as the resource content. In here, you need to specify the developer portal and the gateway custom URLs for the respective tenant.

    ``` tab="Format"
        {
           "tenantDomain":"<tenant domain name>",
           "store":{
              "customUrl":"<custom domain for developer portal>"
           },
           "gateway":{
              "customUrl":"<custom domain for gateway>"
           }
        }
    ``` 

    ``` tab="Example"
        {
           "tenantDomain":"wso2.com",
           "store":{
              "customUrl":"developer.wso2.com"
           },
           "gateway":{
              "customUrl":"gw.wso2.com"
           }
        }
    ```

    ![]({{base_path}}/assets/img/develop/customizations/create-mapping-file.png)

## Configure per tenant service provider creation for devportal

By default the developer portal is acting as SAAS app, which is shared among all the tenants. But when custom urls are enabled for a given tenant, this particular SAAS application cannot be used(Due to custom callback urls) for tenant login management. Hence, below steps has to be followed in order to enable service provider creation per tenant.

1.  Log in to the management console ( `https://<HostName>:9443/carbon` ) as the **tenant admin**.

2.  In the **Main** menu, click **Browse** under **Resources**.

    ![]({{base_path}}/assets/img/develop/customizations/browse-registry.png)

3.  Navigate to `/_system/config/apimgt/applicationdata/tenant-conf.json` configuration file.

    ![]({{base_path}}/assets/img/develop/customizations/tenant-conf.png )

4.  Edit `tenant-conf.json` and add following new property to enable per tenant service provider creation for the respective tenant. Then save the content.

    ```json
    "EnablePerTenantServiceProviderCreation": true
    ```

    ![]({{base_path}}/assets/img/develop/customizations/per-tenant-sp-creation-config.png )

## Configure the load balancer for custom URLs

Carry out the following steps to configure NGINX as the load balancer to support custom tenant URLs.

!!! note
    Although the following section instructs you to use NGINX as the load balancer, you can use any load balancer in your deployment based on your preference.

1.  Install NGINX. For more information on installing NGINX, refer [NGINX](https://nginx.org/en/) official documentation.

2.  Navigate to the `<API-M_HOME>/repository/resources/security` directory and use the following command to add the Nginx certificate to the client trust store.

    ```java
    keytool -import -file /etc/nginx/ssl/nginx.crt -keystore client-truststore.jks -storepass wso2carbon -alias wso2carbon2
    ```

3.  Add following Nginx server configurations to handle customized **developer portal URL** configured for the tenant.

    ```tab="Format"
    server{
        listen 443;
        ssl on;
        server_name "{custom-url-for-dev-portal}";
        ssl_certificate {nginx-certificate-file-path};
        ssl_certificate_key {nginx-key-file-path};
        location /{
                proxy_set_header X-Forwarded-Host $host;
                proxy_set_header X-Forwarded-Server $host;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header Host $http_host;
                proxy_read_timeout 5m;
                proxy_send_timeout 5m;
                proxy_pass https://{server-IP}:9443/devportal/;
                proxy_redirect https://{server-IP}:9443/devportal/ /;
                proxy_set_header X-WSO2-Tenant "{tenant-domain}";
        }
        location ~ (/api/am/store/v1|/oauth2|/authenticationendpoint|/logincontext|/commonauth) {
                proxy_set_header X-Forwarded-Host $host;
                proxy_set_header X-Forwarded-Server $host;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header Host $http_host;
                proxy_read_timeout 5m;
                proxy_send_timeout 5m;
                proxy_pass https://{server-IP}:9443;
                proxy_set_header X-WSO2-Tenant "{tenant-domain}";
        }
    }
    ```

    ```tab="Example"
    server{
        listen 443;
        ssl on;
        server_name "developer.wso2.com";
        ssl_certificate /usr/local/etc/nginx/ssl/nginx.crt;
        ssl_certificate_key /usr/local/etc/nginx/ssl/nginx.key;
        location /{
                proxy_set_header X-Forwarded-Host $host;
                proxy_set_header X-Forwarded-Server $host;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header Host $http_host;
                proxy_read_timeout 5m;
                proxy_send_timeout 5m;
                proxy_pass https://192.168.1.8:9443/devportal/;
                proxy_redirect https://localhost:9443/devportal/ /;
                proxy_set_header X-WSO2-Tenant "wso2.com";
        }
        location ~ (/api/am/store/v1|/oauth2|/authenticationendpoint|/logincontext|/commonauth|/oidc) {
                proxy_set_header X-Forwarded-Host $host;
                proxy_set_header X-Forwarded-Server $host;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header Host $http_host;
                proxy_read_timeout 5m;
                proxy_send_timeout 5m;
                proxy_pass https://192.168.1.8:9443;
                proxy_set_header X-WSO2-Tenant "wso2.com";
        }
    }
    ```

4.  Add following Nginx server configurations to handle customized **Gateway URL** configured for the tenant.

    ```tab="Format"
    server{
           listen 443;
           ssl on;
           server_name "{custom-url-for-gateway}";
           ssl_certificate {nginx-certificate-file-path};
           ssl_certificate_key {nginx-key-file-path};
           location /{
                   proxy_set_header X-Forwarded-Host $host;
                   proxy_set_header X-Forwarded-Server $host;
                   proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                   proxy_set_header Host $http_host;
                   proxy_read_timeout 5m;
                   proxy_send_timeout 5m;
                   proxy_pass https://{server-IP}:8243/t/{tenant-domain}/;
           }
    }
    ```

    ```tab="Example"
    server{
           listen 443;
           ssl on;
           server_name "gw.wso2.com";
           ssl_certificate /usr/local/etc/nginx/ssl/nginx.crt;
           ssl_certificate_key /usr/local/etc/nginx/ssl/nginx.key;
           location /{
                   proxy_set_header X-Forwarded-Host $host;
                   proxy_set_header X-Forwarded-Server $host;
                   proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                   proxy_set_header Host $http_host;
                   proxy_read_timeout 5m;
                   proxy_send_timeout 5m;
                   proxy_pass https://192.168.1.8:8243/t/wso2.com/;
           }
    }
    ```

Now you should be able to access the developer portal and the gateways using custom URLs defined.
