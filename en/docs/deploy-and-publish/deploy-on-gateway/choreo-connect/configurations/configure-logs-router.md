# Router Log Configurations

As Choreo Connect uses an Envoy proxy as the Router component, it only supports the logging mechanisms provided by the Envoy proxy ([read more details about router]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/getting-started/choreo-connect-overview/#router)). 
In the following sections, you may find how to enable Router wire logs.

## Router Wire Logs

!!! attention "Update Level 13"
    This feature is available only as an update. After the Update of level 1.0.0.14 (released on 27th October 2022) and further.

By enabling wire logs in the Router component, you can inspect headers, body, and trailers of the request/response. This is helpful to see the changes applied to the request or response after request path and/or response path interceptors.

To enable the wire logs, add the following configuration to the `log_config.toml` file in [these directories]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/configurations/configure-logs-overview/#log_config_toml) depending on your Choreo Connect deployment setup.

```yaml
[wireLogs]
enable = true
include = ["Headers", "Body", "Trailers"]
```

You need to set `enable` property as `true` as well as keep at least one from the set {"Headers", "Body", "Trailers"} depending on which parts you want to inspect in the `include` array.

An API request invoked at Choreo Connect with the above wire log configuration will generate logs similar to the following.

```yaml
[2022-06-03 09:53:03.304][24][info][lua] [source/extensions/filters/http/lua/lua_filter.cc:795] script log: 
[wirelog] >> request headers >> :authority: localhost:9095
[wirelog] >> request headers >> :path: /trailers/test
[wirelog] >> request headers >> :method: POST
[wirelog] >> request headers >> :scheme: https
[wirelog] >> request headers >> user-agent: curl/7.77.0
[wirelog] >> request headers >> accept: */*
[wirelog] >> request headers >> content-type: text/plain
[wirelog] >> request headers >> content-length: 12
[wirelog] >> request headers >> x-forwarded-proto: https
[wirelog] >> request headers >> x-request-id: 3f236205-f5be-4e65-b348-5d23a9b32a1b
[wirelog] >> request headers >> x-wso2-cluster-header: carbon.super_clusterProd_localhost_http-trailersv1
[wirelog] >> request headers >> x-trace-key: 17001635652092319657

[2022-06-03 09:53:03.307][24][info][lua] [source/extensions/filters/http/lua/lua_filter.cc:795] script log: 
[wirelog] >> request body >> 
request data
[wirelog] >> request body >> 

[2022-06-03 09:53:03.307][24][info][lua] [source/extensions/filters/http/lua/lua_filter.cc:795] script log: 

[2022-06-03 09:53:03.311][24][debug][http2] [source/common/http/http2/codec_impl.cc:1083] [C9] stream closed: 0
[2022-06-03 09:53:03.322][24][info][lua] [source/extensions/filters/http/lua/lua_filter.cc:795] script log: 
[wirelog] << response headers << :status: 200
[wirelog] << response headers << x-powered-by: Express
[wirelog] << response headers << content-type: text/plain
[wirelog] << response headers << trailer: Content-MD5
[wirelog] << response headers << trialer: Time-Taken
[wirelog] << response headers << date: Fri, 03 Jun 2022 09:53:03 GMT
[wirelog] << response headers << connection: keep-alive
[wirelog] << response headers << keep-alive: timeout=5
[wirelog] << response headers << transfer-encoding: chunked

[2022-06-03 09:53:03.323][24][info][lua] [source/extensions/filters/http/lua/lua_filter.cc:795] script log: 
[wirelog] << response body << 
sample text data. abcd 1234 
[wirelog] << response body << 

[2022-06-03 09:53:03.323][24][info][lua] [source/extensions/filters/http/lua/lua_filter.cc:795] script log: 
[wirelog] << response trailers << content-md5: 7895bf4b8828b55ceaf47747b4bca667
```
