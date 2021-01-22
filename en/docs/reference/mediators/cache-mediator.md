# Cache Mediator

When a message enters a message flow, the Cache mediator checks whether the incoming message is similar to a previous message that was received
within a specified period of time. This is done by evaluating the hash value of incoming messages. If a similar message was identified before, the Cache mediator executes the `         onCacheHit        ` sequence (if specified), fetches the cached response, and prepares the Micro Integrator to send the response. The `         onCacheHit        ` sequence can send back the response message using the [Respond Mediator]({{base_path}}/reference/mediators/respond-mediator). If the `         onCacheHit        ` sequence is not specified, the cached response is sent back to the requester and the message is not passed on. If a similar message has not been seen before, then the message is passed on.

!!! Info
    - The Cache mediator is a [content-aware]({{base_path}}/reference/mediators/about-mediators/#classification-of-mediators) mediator.
    - The Cache mediator supports only local caching. It does not support distributed caching.

## Syntax

``` java
<cache [timeout="seconds"] [collector=(true | false)] [maxMessageSize="in-bytes"] >
   <onCacheHit [sequence="key"]>
    (mediator)+
   </onCacheHit>?
   <protocol type="http" >?
     <methods>comma separated list</methods>
     <headersToExcludeInHash>comma separated list</headersToExcludeInHash>
     <responseCodes>regular expression</responseCodes>
     <enableCacheControl>(true | false)</enableCacheControl>
     <includeAgeHeader>(true | false)</includeAgeHeader>
     <hashGenerator>class</hashGenerator>
   </protocol>    
   <implementation [maxSize="int"]/>
</cache>
```

!!! Info
    In a message flow, you can use the cache mediator as a **finder** (in the incoming path to check the request) or as a **collector** (in the outgoing path to cache the response). It is not possible to have more than one cache mediator in the same message flow because mediation is terminated after the finder on a cache hit, and the response is not passed on to the next finder after a cache hit. See the [Example 1](#example-1) given below.

!!! Note
    The message needs to be explicitly marked as *RESPONSE* using the following property when collecting the cached 
    response in the same sequence after using the call mediator. This will not be required if the back end is 
    called via send mediator. See the [Example 1](#example-1) given below.
    ```xml
    <property name="RESPONSE" value="true" scope="default" type="STRING"/>
    ```
    
## Configuration

### Cache Mediator as a Finder

The parameters available to configure the Cache mediator as a **Finder** are as follows.

<table>
<thead>
<tr class="header">
<th>Parameter Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><strong>Cache Type</strong></td>
<td><p>This parameter specifies whether the Cache mediator should be in the incoming path (to check the request) or in the outgoing path (to cache the response). Possible values are as follows.</p>
<ul>
<li><strong>Finder</strong> : If this is selected, the Cache mediator is used to search for the request hash of incoming messages.</li>
<li><strong>Collector</strong> : If this is selected, the Cache mediator is used to collect response messages in the cache.</li>
</ul></td>
</tr>
<tr class="even">
<td><strong>Cache Timeout (Seconds)</strong></td>
<td>The time duration that the cache should be retained specified in seconds. The cache expires once this time duration elapses. The default value is 5000 seconds.</td>
</tr>
<tr class="odd">
<td><strong>Maximum Message Size</strong></td>
<td>The maximum size of the message to be cached. This should be specified in bytes.</td>
</tr>
<tr class="even">
<td><strong>Protocol Type</strong></td>
<td>The protocol type to be cached in the message flow. In the current implementation, HTTP is the only value that you can select. Although the only configuration supported for other protocols is the <code>                HashGenerator               </code> , you can specify the protocol type to be anything and specify a <code>                HashGenerator               </code> that you prefer.</td>
</tr>
<tr class="odd">
<td><strong>HTTP Methods</strong></td>
<td>A comma separated list of HTTP methods that should be cached for the HTTP protocol. The default value is <code>*</code>, and it caches all HTTP methods.</td>
</tr>
<tr class="even">
<td><strong>Headers to Exclude in Hash</strong></td>
<td>A comma separated list of headers to ignore when hashing an incoming messages. If you want to exclude all headers when hashing an incoming message, specify *.</td>
</tr>
<tr class="odd">
<td><strong>Response Codes</strong></td>
<td>Specify the response codes to be cached as a regular expression. If the http status code of a response matches the regular expression, the response should be cached. The default setting is to cache any response code.</td>
</tr>
<tr class="even">
<td><strong>Hash Generator</strong></td>
<td><div class="content-wrapper">
<p>This parameter is used to define the logic used by the Cache mediator to evaluate the hash values of incoming messages. The value specified here should be a class that implements the <code>org.separated.carbon.mediator.cache.digest.DigestGenerator</code> class interface. The default hash generator is <code>org.wso2.carbon.mediator.cache.digest.HttpRequestHashGenerator</code>. If the generated hash value is found in the cache, then the Cache mediator executes the <code>onCacheHit</code> sequence, which can be specified inline or referenced.</p>
<b>Note</b>:
<p>The hash generator is specific to the HTTP protocol.</p>
<p>If you are using any other protocol, you need to write a custom hash generator or use one of the following deprecated hash generator classes:</p>
<ul>
<li><code>                   org.wso2.carbon.mediator.cache.digest.DOMHASHGenerator                  </code></li>
<li><code>                   org.wso2.carbon.mediator.cache.digest.REQUESTHASHGenerator                  </code></li>
</ul>

</div></td>
</tr>
<tr class="odd">
<td><strong>Enable Cache Control Headers</strong></td>
<td><p>Whether the Cache mediator should honor the Cache-Control header(no-cache, no-store, max-age headers). If you set this to the default value (i.e., <code>                 false                </code> ), the Cache mediator will not consider the Cache-Control headers when caching the response or when returning the cached response.</p>
<div>
<br />

</div></td>
</tr>
<tr class="even">
<td><strong>Include Age Header</strong></td>
<td>Whether an Age header needs to be included when returning the cached response.</td>
</tr>
<tr class="odd">
<td><strong>Maximum Size</strong></td>
<td>The maximum number of elements to be cached. The default size is 1000.</td>
</tr>
<tr class="even">
<td><strong>Anonymous</strong></td>
<td>If this option is selected, an anonymous sequence is executed when an incoming message is identified as an equivalent to a previously received message based on the value defined in the <strong>Hash Generator</strong> field.</td>
</tr>
<tr class="odd">
<td><strong>Sequence Reference</strong></td>
<td>The reference to the <code>onCacheHit</code> sequence to be executed when an incoming message is identified as an equivalent to a previously received message, based on the value defined in the <strong>Hash Generator</strong> field. The sequence should be created in the registry in order to be specified in this field. You can click either <strong>Configuration</strong>, <strong>Registry</strong>, or <strong>Governance Registry</strong> as applicable to select the required sequence from the resource tree.</td>
</tr>
</tbody>
</table>

### Cache Mediatior as a Collector

The parameters available to configure the Cache mediator as a **Collector** are as follows.

<table>
<thead>
<tr class="header">
<th>Parameter Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><strong>Cache Type</strong></td>
<td><p>This parameter specifies whether the mediator should be in the incoming path (to check the request) or in the outgoing path (to cache the response). Possible values are as follows.</p>
<ul>
<li><strong>Finder</strong> : If this is selected, the mediator is used to search for the request hash of incoming messages.</li>
<li><strong>Collector</strong> : If this is selected, the mediator is used to collect response messages in the cache.</li>
</ul></td>
</tr>
</tbody>
</table>

## Examples

Following are examples of how you can use the Cache mediator.

### Example 1

Following is an example where the expected response from the last cache hit is not received because the response is sent once the request comes
to the first finder:

``` java
<?xml version="1.0" encoding="UTF-8"?>
<proxy xmlns="http://ws.apache.org/ns/synapse" name="cache115" transports="http https" startOnLoad="true">
   <description />
   <target>
      <inSequence>
         <cache collector="false" timeout="60">
            <protocol type="HTTP">
               <methods>POST</methods>
               <headersToExcludeInHash />
               <responseCodes>.*</responseCodes>
               <enableCacheControl>false</enableCacheControl>
               <includeAgeHeader>false</includeAgeHeader>
               <hashGenerator>org.wso2.carbon.mediator.cache.digest.HttpRequestHashGenerator</hashGenerator>
            </protocol>
         </cache>
         <call>
            <endpoint>
               <address uri="http://demo0585968.mockable.io/some" />
            </endpoint>
         </call>
         <property name="RESPONSE" value="true" scope="default" type="STRING" />
         <log level="full" />
         <cache collector="true" />
         <property name="RESPONSE" value="false" scope="default" type="STRING" />
         <cache collector="false" timeout="60">
            <protocol type="HTTP">
               <methods>POST</methods>
               <headersToExcludeInHash />
               <responseCodes>.*</responseCodes>
               <hashGenerator>org.wso2.carbon.mediator.cache.digest.HttpRequestHashGenerator</hashGenerator>
            </protocol>
         </cache>
         <call>
            <endpoint>
               <address uri="http://demo0585968.mockable.io/hello" />
            </endpoint>
         </call>
         <property name="RESPONSE" value="true" scope="default" type="STRING" />
         <log level="full" />
         <cache collector="true" />
         <respond />
      </inSequence>
   </target>
</proxy>          
```

### Example 2

According to this example configuration, when the first message is sent
to the endpoint, the cache is not hit. The Cache mediator configured in
the `         Out        ` sequence caches the response to this message.
When a similar message is sent to the endpoint for the second time, the
previous response is directly fetched from the cache and sent to the
requester. This happens because the `         onCacheHit        `
sequence is not defined in this configuration.

``` java
<?xml version="1.0" encoding="UTF-8"?>
<sequence name="main">
        <in>
            <cache collector="false" maxMessageSize="10000" timeout="20">
                <protocol type="HTTP">
                    <methods>POST</methods>
                    <headersToExcludeInHash/>
                    <responseCodes>2[0-9][0-9]</responseCodes>
                    <enableCacheControl>false</enableCacheControl>
                    <includeAgeHeader>false</includeAgeHeader>
                    <hashGenerator>org.wso2.carbon.mediator.cache.digest.HttpRequestHashGenerator</hashGenerator>
                </protocol>
                <implementation maxSize="100"/>
            </cache>
            <send>
                <endpoint name="inlined">
                    <address uri="http://localhost:9000/services/SimpleStockQuoteService"/>
                </endpoint>
            </send>
        </in>
        <out>
            <cache collector="true"/>
            <send/>
        </out>
    </sequence>
```

### Example 3

According to this example configuration, if you define a cache collector
using the cache mediator in the in sequence, you need to add the
`         RESPONSE        ` property to consider the message as a
response message.

``` xml
<?xml version="1.0" encoding="UTF-8"?>
<api xmlns="http://ws.apache.org/ns/synapse" name="cacheAPI" context="/cache">
<resource methods="POST GET" uri-template="/headerapi/*">
    <inSequence>
        <cache collector="false" timeout="5000">
            <protocol type="HTTP">
                <methods>GET, POST</methods>
                <headersToExcludeInHash>*</headersToExcludeInHash>
                <responseCodes>.*</responseCodes>
                <enableCacheControl>false</enableCacheControl>
                <includeAgeHeader>false</includeAgeHeader>
                <hashGenerator>org.wso2.carbon.mediator.cache.digest.HttpRequestHashGenerator</hashGenerator>
            </protocol>
        </cache>
        <call>
            <endpoint>
                <address uri="http://localhost:9000/services/SimpleStockQuoteService"/>
            </endpoint>
        </call>
        <property name="RESPONSE" value="true" scope="default" type="STRING"/>
        <enrich>
            <source type="inline" clone="true">
                <ax21:newvalue
                    xmlns:ax21="http://services.samples/xsd">testsamplevalue
                </ax21:newvalue>
            </source>
            <target
                xmlns:ax21="http://services.samples/xsd"
                xmlns:ns="http://services.samples" action="sibling" xpath="//ns:getQuoteResponse/ns:return/ax21:volume"/>
            </enrich>
            <cache collector="true"/>
            <respond/>
        </inSequence>
</resource>
</api>
```

### Invalidating cached responses remotely

You can invalidate all cached response remotely by using any [JMX monitoring tool such as Jconsole]({{base_path}}/observe/mi-observe/jmx_monitoring) via the exposed MBeans. You can use the `         invalidateTheWholeCache()        ` operation of the `         org.wso2.carbon.mediation        ` MBean for this as shown below.

![]({{base_path}}/assets/img/integrate/jmx/jmx_monitoring_cache_mediator.png)
