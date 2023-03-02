Choreo Connect is able to support HTTP 2.0 (HTTP/2) in both incoming connections from clients to the Gateway and from the Gateway to endpoints. For more information on HTTP/2 and its benefits, refer to the [HTTP/2 homepage](https://http2.github.io/).

## How HTTP 2.0 connections are created

There are few cases to consider as discussed below.

### HTTP/2 clear text connection with h2c upgrade call

The HTTP/2 client can request the server to upgrade to HTTP/2 by using a HTTP/1.1 call with some special headers as you can see in the below snippet called `Connection`, `Upgrade` (h2c means HTTP/2 with clear text), and `HTTP2-Settings` headers in the request. If the server is able to upgrade, it sends a response again with HTTP/1.1 call with `connection: upgrade` and `upgrade: h2c` headers and again responds to the initial actual request using HTTP/2.

```yaml
$ curl --http2 http://localhost:2350/hello -v
*   Trying ::1:2350...
* Connected to localhost (::1) port 2350 (#0)
> GET /hello HTTP/1.1
> Host: localhost:2350
> User-Agent: curl/7.77.0
> Accept: */*
> Connection: Upgrade, HTTP2-Settings
> Upgrade: h2c
> HTTP2-Settings: AAMAAABkAAQCAAAAAAIAAAAA
> 
* Mark bundle as not supporting multiuse
< HTTP/1.1 101 Switching Protocols
< connection: upgrade
< upgrade: h2c
* Received 101
* Using HTTP2, server supports multi-use
* Connection state changed (HTTP/2 confirmed)
* Copying HTTP/2 data in stream buffer to connection buffer after upgrade: len=0
* Connection state changed (MAX_CONCURRENT_STREAMS == 4294967295)!
< HTTP/2 200 
< 
* Connection #0 to host localhost left intact
```

### HTTP/2 clear text connection with prior knowledge

If the client already knows that the server also supports HTTP/2, the client can directly send requests with HTTP/2 like below and the server responds with HTTP/2.

```yaml
$ curl --http2-prior-knowledge http://localhost:2350/hello -v
*   Trying ::1:2350...
* Connected to localhost (::1) port 2350 (#0)
* Using HTTP2, server supports multi-use
* Connection state changed (HTTP/2 confirmed)
* Copying HTTP/2 data in stream buffer to connection buffer after upgrade: len=0
* Using Stream ID: 1 (easy handle 0x14e011600)
> GET /hello HTTP/2
> Host: localhost:2350
> user-agent: curl/7.77.0
> accept: */*
> 
* Connection state changed (MAX_CONCURRENT_STREAMS == 4294967295)!
< HTTP/2 200 
< 
* Connection #0 to host localhost left intact
```

### HTTP/2 encrypted text (TLS) connection

When the client and server needs to do encrypted text communication, the client and the server can negotiate a protocol version when creating a session using ALPN protocol (prior to sending the HTTP request as opposed to the clear text case described above). See the following example snippet it has printed `ALPN, server accepted to use h2`, which means HTTP calls will happen using HTTP/2 version.

```yaml
$ curl --cacert ./backend.crt <--http2> or <--http2-prior-knowledge> https://localhost:2351/hello
*   Trying ::1:2351...
* Connected to localhost (::1) port 2351 (#0)
* ALPN, offering h2
* ALPN, offering http/1.1
* successfully set certificate verify locations:
*  CAfile: ./backend.crt
*  CApath: none
* TLSv1.2 (OUT), TLS handshake, Client hello (1):
* TLSv1.2 (IN), TLS handshake, Server hello (2):
* TLSv1.2 (IN), TLS handshake, Certificate (11):
* TLSv1.2 (IN), TLS handshake, Server key exchange (12):
* TLSv1.2 (IN), TLS handshake, Server finished (14):
* TLSv1.2 (OUT), TLS handshake, Client key exchange (16):
* TLSv1.2 (OUT), TLS change cipher, Change cipher spec (1):
* TLSv1.2 (OUT), TLS handshake, Finished (20):
* TLSv1.2 (IN), TLS change cipher, Change cipher spec (1):
* TLSv1.2 (IN), TLS handshake, Finished (20):
* SSL connection using TLSv1.2 / ECDHE-RSA-CHACHA20-POLY1305
* ALPN, server accepted to use h2
* Server certificate:
*  subject: O=mockBackend Inc.; CN=mockBackend
*  start date: Nov  8 09:15:42 2021 GMT
*  expire date: Nov  6 09:15:42 2031 GMT
*  subjectAltName: host "localhost" matched cert's "localhost"
*  issuer: O=mockBackend Inc.; CN=mockBackend
*  SSL certificate verify ok.
* Using HTTP2, server supports multi-use
* Connection state changed (HTTP/2 confirmed)
* Copying HTTP/2 data in stream buffer to connection buffer after upgrade: len=0
* Using Stream ID: 1 (easy handle 0x13680e800)
> GET /hello HTTP/2
> Host: localhost:2351
> user-agent: curl/7.77.0
> accept: */*
> 
* Connection state changed (MAX_CONCURRENT_STREAMS == 4294967295)!
< HTTP/2 200 
< content-length: 0
< 
* Connection #0 to host localhost left intact
```

## Choreo Connect HTTP 2.0 Configuration

## Downstream configuration

Clients can initiate HTTP connections with Choreo Connect Router using HTTP/1.1 call or HTTP/1.1 call to switch protocol to HTTP/2 (if upstream does not support HTTP/2 then fallback to HTTP/1.1) or direct HTTP/2 call (with prior knowledge). It is the default configuration that is called `AUTO`. If you want only a specific HTTP version to work with, you can add the following configuration to the `config.toml` file that is located in the `<CHOREO-CONNECT_HOME>/docker-compose/choreo-connect/conf` or `<CHOREO-CONNECT_HOME>/docker-compose/choreo-connect-with-apim/conf` directory. 

```yaml
[router]
  listenerCodecType = "HTTP2"
```
You can set this confuration to `AUTO`, `HTTP1`, or `HTTP2`.

## Upstream configuration

Currently the upstream connections by default works with HTTP/1.1 version. To use HTTP/2 communications with endpoints, you need to set the following Swagger extension configuration for the API you deploy to the Gateway.

```yaml
x-wso2-http2-backend-enabled: true
```

Choreo Connect Router to endpoint connections are initiated only with HTTP/2 prior knowledge not with HTTP/2 upgrade calls in a clear text scenario. Therefore, if your endpoint only supports HTTP/1.1 then connection establishment will fail.

## Use cases with example configurations

#### Both client and backend supports HTTP 2.0

[![Choreo h2 h2 connection]({{base_path}}/assets/img/deploy/http2/choreo-h2-h2-connection.png)]({{base_path}}/assets/img/deploy/http2/choreo-h2-h2-connection.png)

```toml tab="config.toml"
[router]
  listenerCodecType = "AUTO" or "HTTP2"
# Default value will be "AUTO"
```

```toml tab="Swagger yaml"
x-wso2-http2-backend-enabled: true
```

#### The client supports HTTP 2.0 but the backend does not support HTTP 2.0

[![Choreo h2 h1 connection]({{base_path}}/assets/img/deploy/http2/choreo-h2-h1-connection.png)]({{base_path}}/assets/img/deploy/http2/choreo-h2-h1-connection.png)

```toml tab="config.toml"
[router]
  listenerCodecType = "AUTO" or "HTTP2"
# Default value will be "AUTO"
```

```toml tab="Swagger yaml"
# No need to add API level configuration
```


#### The client does not support HTTP/2 but the backend suppports HTTP 2.0

[![Choreo h1 h2 connection]({{base_path}}/assets/img/deploy/http2/choreo-h1-h2-connection.png)]({{base_path}}/assets/img/deploy/http2/choreo-h1-h2-connection.png)

```toml tab="config.toml"
[router]
  listenerCodecType = "AUTO" or "HTTP1"
# Default value will be "AUTO"
```

```toml tab="Swagger yaml"
x-wso2-http2-backend-enabled: true
```
