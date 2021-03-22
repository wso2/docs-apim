# HTTP 2.0

WSO2 API Microgateway by default support HTTP 2.0 (HTTP/2) together with HTTP/1.1 as the incoming and outgoing transport protocol. WSO2 API Microgateway is able to process requests faster and simpler with HTTP/2 enabled. For more information on HTTP/2 and its benefits, refer to the [HTTP/2 homepage](https://http2.github.io/) .

WSO2 API Microgateway, default configurations is to communicate using HTTP2, and also able to switch protocols from  HTTP/1.1 to HTTP/2 and vice versa.


### HTTP 2.0 Configuration of API Microgateway

HTTP2 can be configured in the listeners of the Microgateway to communicate with external clients(downstream) and as well as in http clients to 
communicate with upstream back end services.

#### Listener level HTTP2 configuration
Locate the `[http2]` tag in `micro-gw.conf` file and you can notice by default it is enabled.

``` toml
[http2]
enable=true
```

#### Upstream backend service HTTP2 configuration
By default communication with upstream clients over http2 is enabled. You can find the default configurations in the file `<MICROGW_HOME>/conf/default-micro-gw.conf.template` as below.

``` toml
[httpClients]
  # Enable http2 when connecting with upstream backend endpoints.
  enableHttp2 = true
```

In order to change the default configuration we can copy above configuration section from `default-micro-gw.conf.template` and place it in the `<MICROGW_HOME>/conf/micro-gw.conf` file and edit it accordingly.

### Identifying a HTTP 2.0 connection

A HTTP/2 request contains three special headers “ Connection ”, “ Upgrade ” and “ HTTP2-Settings ”.

``` text tab="Example : HTTP2 Request Headers"
upgrade: h2c
HTTP2-Settings: AAEAABAAAAIAAAABAAN_____AAQAAP__AAUAAEAAAAYAACAA
connection: HTTP2-Settings,upgrade  
```

 A HTTP/2 response contains 3 special headers “ Connection ”, “ Upgrade ” and  "HTTP/1.1 101 Switching Protocols"

``` text tab="Example : HTTP2 Response Headers"
HTTP/1.1 101 Switching Protocols
connection: upgrade
upgrade: h2c
```

### How it works

The following user stories explain how the API Microgateway works when HTTP/2 is enabled.

!!! note
    -   The backend service in the following scenarios communicate on HTTP/2 **without** SSL.
    -   The WSO2 API Microgateway server in the following scenarios communicate on HTTP/2 **with** SSL.
    -   "h2" in the following images refers to HTTP/2.

##### User story 1 - Both client and backend supports HTTP 2.0

![]({{base_path}}/assets/img/how-tos/http2-user-story-1.png)

-   The user sends an HTTP/2 request to WSO2 API Microgateway.

-   WSO2 API Microgateway forwards the received HTTP/2 request to the backend as an HTTP/1.1 request after including the HTTP/2 headers to determine the protocol of the connection between WSO2 API Microgateway and the backend.

-   The backend accepts the request and sends a response back to WSO2 API Microgateway with the connection upgrade header as well as the "HTTP/1.1 101 Switching Protocols" header. This indicates that the backend supports HTTP/2. As a result, a HTTP/2 connection between WSO2 API Microgateway and the backend is established.

-   The backend sends an HTTP/2 response with the payload back WSO2 API Microgateway.

-   The Microgateway forwards that HTTP/2 response back to the client.

##### User story 2 - The client supports HTTP 2.0 but the backend does not support HTTP 2.0

![]({{base_path}}/assets/img/how-tos/http2-user-story-2.png)


-   The user sends an HTTP/2 request to WSO2 API Microgateway.

-   WSO2 API Microgateway forwards the received HTTP/2 request to the backend as an HTTP/1.1 request after including the HTTP/2 headers to determine the protocol of the connection between the API Microgateway and the backend.

-   Since the backend does not support the HTTP/2, it does not upgrade the connection into HTTP/2.

-   The backend sends an HTTP/1.1 response with the payload to WSO2 API Microgateway.

-   WSO2 API Microgateway then upgrades it to an HTTP/2 response by adding HTTP/2 headers and sends it to the client.

##### User story 3 - The client does not support HTTP/2 but the backend supports HTTP 2.0

![]({{base_path}}/assets/img/how-tos/http2-user-story-3.png)

-   The user sends an HTTP/1.1 request to WSO2 API Microgateway.

-   WSO2 API Microgateway sends the request as an HTTP/1.1 request after including the HTTP/2 headers to determine the protocol of the connection between WSO2 API Microgateway and the backend.

-   The backend accepts the request and sends a response back to the client with connection upgrade header as well as the "HTTP/1.1 101 Switching Protocols" header. This indicates that the backend supports HTTP/2. As a result, a HTTP/2 connection between WSO2 API Microgateway and the backend is established.

-   The backend sends an HTTP/2 response with the payload to the API Microgateway.

-   WSO2 API Microgateway upon receiving an HTTP/2 response, proceeds to downgrade the response to an HTTP/1.1 response removing the HTTP/2  headers and forwards it to the client.

