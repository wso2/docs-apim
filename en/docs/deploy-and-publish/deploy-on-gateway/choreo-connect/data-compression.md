# Data Compression
Data compression allows to reduce the size of the payload sent with the HTTP requests. This 
improves data transfer speed while utilizing the bandwidth. Choreo Connect supports HTTP data
compression considering the gzip compression scheme. Data compression can enable considering the request flow, 
response flow or considering the both flows. You can enable HTTP data compression only for the selected
HTTP content types. Choreo Connect supports data compression for application/javascript, application/json, application/xhtml+xml, 
image/svg+xml, text/css, text/html, text/plain, text/xml HTTP content types.

## Configuring HTTP request data with Choreo Connect

Below section explains configurations relevant to the HTTP data compression in Choreo Connect.

```toml tab="Format"
[router.filters]
  [router.filters.compression]
    enabled = true
    library = "gzip"
  [router.filters.compression.requestDirection]
    enabled = false
    minimumContentLength = 30
    contentType = ["text/html"]
  [router.filters.compression.responseDirection]
    enabled = true
    minimumContentLength = 30
    contentType = ["text/html","application/json"]
    enableForEtagHeader = true
  [router.filters.compression.libraryProperties]
    memoryLevel = 3
    windowBits = 12
    compressionLevel = 9
    compressionStrategy = "defaultStrategy"
    chunkSize = 4096
```

Following table explains the attribute details relevant to the above configuration.

<table>
    <tr>
        <th><b>Property</b></th>
        <th><b>Description</b></th>
    </tr>
    <tr>
        <td><code>enabled</code></td>
        <td>Enable/ disable HTTP data compression feature</td>
    </tr>
    <tr>
        <td><code>library</code></td>
        <td>Indicates compression library used for the HTTP data compression.</td>
    </tr>
    <tr>
        <td colspan="2"><center><code><b>Request direction configurations</b></code></center></td>
    </tr>
    <tr>
        <td><code>enabled</code></td>
        <td>Enable/ disable HTTP data compression for the request direction (data sent to the upstream will be compressed if this is enabled)</td>
    </tr>
    <tr>
        <td><code>minimumContentLength</code></td>
        <td>Payload will be compressed if it exceeds the defined byte size.</td>
    </tr>
    <tr>
        <td><code>contentType</code></td>
        <td>Content types that should consider to apply data compression</td>
    </tr>
    <tr>
        <td colspan="2"><center><code><b>Response direction configurations</b></code></center></td>
    </tr>
    <tr>
        <td><code>enabled</code></td>
        <td>Enable/ disable HTTP data compression for the response direction (data sent to the downstream will be compressed if this is enabled)</td>
    </tr>
    <tr>
        <td><code>minimumContentLength</code></td>
        <td>Payload will be compressed if it exceeds the defined byte size.</td>
    </tr>
    <tr>
        <td><code>contentType</code></td>
        <td>Content types that should consider to apply data compression</td>
    </tr>
    <tr>
        <td><code>enableForEtagHeader</code></td>
        <td>Applies data compression even there is an ETag header</td>
    </tr>
    <tr>
        <td colspan="2"><center><code><b>Compression Library relevant configurations</b></code></center></td>
    </tr>
    <tr>
        <td><code>memoryLevel</code></td>
        <td>
            Amount of internal memory used by the gzip zlib library. Large values use more memory. The relevant value range
            is 1 to 9.
        </td>
    </tr>
    <tr>
        <td><code>windowBits</code></td>
        <td>
            Represents the base two logarithmic of the compressor’s window size. Value range is from 9 to 15. Large window
            sizes provide high compression by using more memory.
        </td>
    </tr>
    <tr>
        <td><code>compressionLevel</code></td>
        <td>
            Denotes zlib library's compression level. This attributes impacts speed and compression amount applied to the 
            content. Value range is from 1 to 9. Level 9 provides the highest compression.
        </td>
    </tr>
    <tr>
        <td><code>compressionStrategy</code></td>
        <td>
            Denotes zlib library's compression strategy. Value can change based on the content type shared with the request. 
            For most of the cases default strategy is the best choice.
        </td>
    </tr>
    <tr>
        <td><code>chunkSize</code></td>
        <td>
            Value for the zlib library's next output buffer. Denotes the amount in bytes.
        </td>
    </tr>
</table>

## Examples for data compression in Choreo Connect

### Applying data compression for the request flow

If `router.filters.compression.requestDirection` enable value assigned as `true`, Choreo Connect will compress the HTTP request data
sent to the upstream. Similarly, if `router.filters.compression.responseDirection` enable value assigned as `true`, Choreo Connect 
will compress the HTTP response data sent to the downstream.

!!! note
    - To apply the data compression, content size should be higher than the value defined in the configurations (`minimumContentLength`).
    - Data compression will be applied only to the content types defined in the configurations.
    - If `Content-encoding` header is given in the request, Choreo Connect will not apply data compression during the request/response flow.

 ``` bash tab="Format"
 curl -X 'POST' "https://<CHOREO-CONNECT_ROUTER_HOST>:<CHOREO-CONNECT_ROUTER_PORT>/<API-context>/<API-resource>" -H "Content-type:application/json" -H "Authorization:Bearer $TOKEN" -H "Accept-encoding: gzip" --data <data> -k
 ```

 ``` bash tab="Example Request"
 curl -X 'POST' "https://localhost:9095/v2/testAPI/*" -H "Content-type:application/json" -H "Accept-encoding: gzip" -H "Authorization:Bearer $TOKEN" -k --data '{"name":"John","age":30,"Address":"No 123, Street Name, Province, Country"}'
 ```

 ``` bash tab="Example With Response Headers"
 server: envoy
 content-type: text/plain; charset=UTF-8
 vary: Accept-Encoding
 x-request-id: 5c9b2d23-599f-4b30-852c-123feadb34d1
 x-token-id: 65f29805-37cc-4ac9-a0f3-1231bd7c9eca
 cache-control: no-cache, private
 date: Fri, 07 Oct 2022 07:31:00 GMT
 content-encoding: gzip
 transfer-encoding: chunked
 ```

