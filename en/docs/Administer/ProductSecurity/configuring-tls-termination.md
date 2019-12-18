# Configuring TLS Termination

When you have Carbon servers fronted by a load balancer, you have the option of terminating SSL for HTTPS requests. This means that the load balancer will be decrypting incoming HTTPS messages and forwarding them to the Carbon servers as HTTP. This is useful when you want to reduce the load on your Carbon servers due to encryption. To achieve this, the load balancer should be configured with TLS termination and the Tomcat RemoteIpValve should be enabled for Carbon servers.

When you work with Carbon servers, this will allow you to access admin services and the admin console of your product using HTTP (without SSL).

Given below are the steps you need to follow:

-   [Step 1: Configuring the load balancer with TLS termination](#ConfiguringTLSTermination-Step1:ConfiguringtheloadbalancerwithTLStermination)
-   [Step 2: Enabling RemoteIpValve for Carbon servers](#ConfiguringTLSTermination-Step2:EnablingRemoteIpValveforCarbonservers)

### Step 1: Configuring the load balancer with TLS termination

See the documentation of the load balancer that you are using for instructions on how to enable TLS termination. For example, see [NGINX SSL Termination](https://www.nginx.com/resources/admin-guide/nginx-ssl-termination/) .

### Step 2: Enabling RemoteIpValve for Carbon servers

You can enable Tomcat's RemoteIpValve for your Carbon server by simply adding the valve to the `catalina-sever.xml` file (stored in the `<PRODUCT_HOME>/repository/conf/tomcat` directory). This valve should be specified under the `<Host>` element (shown below) in the `catalina-sever.xml` file. See the [Tomcat documentation](https://tomcat.apache.org/tomcat-7.0-doc/api/org/apache/catalina/valves/RemoteIpValve.html) for more information about `RemoteIpValve` .

``` java
    <Host name="localhost" unpackWARs="true" deployOnStartup="false" autoDeploy="false" appBase="${carbon.home}/repository/deployment/server/webapps/">
       ............
       <Valve className=/>
    </Host>
```
