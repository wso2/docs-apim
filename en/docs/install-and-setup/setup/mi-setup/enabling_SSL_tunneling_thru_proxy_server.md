# Enabling SSL Tunneling through a Proxy Server

If your proxy service connects to a back-end server through a proxy server, you can enable secure socket layer (SSL) tunneling through the proxy server to prevent any intermediate proxy services from interfering with the communication. SSL tunneling is available when your proxy service uses either the **HTTP PassThrough** transport.

The following section walks you through the steps to enable SSL tunneling through a proxy server. Here we will use [Squid](http://www.squid-cache.org/) as the caching and forwarding HTTP web proxy.

## Setting up Squid

Follow the steps below to set up Squid:

1.  Install Squid as described [here](http://wiki.squid-cache.org/SquidFaq/InstallingSquid) .
2.  Add the following lines in the `<SQUID_HOME>/etc/squid3/squid.conf` file:

    ```java
    acl SSL_ports port 443 8443 8448 8248 8280
    acl Safe_ports port 80 # http
    acl Safe_ports port 21 # ftp
    acl Safe_ports port 443 # https
    acl Safe_ports port 70 # gopher
    acl Safe_ports port 210 # wais
    acl Safe_ports port 1025–65535 # unregistered ports
    acl Safe_ports port 280 # http-mgmt
    acl Safe_ports port 488 # gss-http
    acl Safe_ports port 591 # filemaker
    acl Safe_ports port 777 # multiling http
    acl CONNECT method CONNECT

    auth_param basic program /usr/lib/squid3/basic_ncsa_auth /etc/squid3/basic_pw
    auth_param basic children 5
    auth_param basic realm Squid proxy-caching web server
    auth_param basic credentialsttl 2 hours
    auth_param basic casesensitive off

    acl ncsa_users proxy_auth REQUIRED
    http_access allow ncsa_users

    http_port 3128
    ```

## Configuring SSL tunneling

To configure SSL tunneling through the proxy server, open the deployment.toml file and update the following parameters for the HTTP transport listener and sender:

```toml tab='Passthrough HTTP'
[transport.http]
sender.proxy_host = "localhost"                           
sender.proxy_port = 8080
```

```toml tab='Passthrough HTTPS'
[transport.https]
sender.parameter.'http.proxyHost' = "hostname"
sender.parameter.'http.proxyPort' = "8080"
sender.parameter.'HostnameVerifier' = "AllowAll"
```