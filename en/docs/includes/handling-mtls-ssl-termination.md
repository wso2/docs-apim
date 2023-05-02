### Handling MTLS when SSL is terminated by the Load Balancer or Reverse Proxy

When SSL termination of API requests takes place at the Load Balancer or Reverse Proxy, the following prerequisites need to be met by the Load Balancer.

-   Terminate the mutual SSL connection from the client.
-   Pass the client SSL certificate to the Gateway in an HTTP Header. 

     For more information, see the [Nginx documentation](https://nginx.org/en/docs/http/ngx_http_ssl_module.html#ssl_client_certificate).

The following diagram illustrates how Mutual SSL works in such an environment.

[![MTLS Load Balancer](https://apim.docs.wso2.com/en/4.2.0/assets/img/learn/mtls-loadbalancer.png)](https://apim.docs.wso2.com/en/4.2.0/assets/img/learn/mtls-loadbalancer.png)

