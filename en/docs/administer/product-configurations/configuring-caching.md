# Configuring Caching

When an API call hits the API Gateway, the Gateway carries out security checks to verify if the token is valid. During these verifications, the API Gateway extracts parameters (i.e., access token, API name, and API version) that are passed on to it. Since the entire load of traffic to APIs goes through the API Gateway, this verification process needs to be fast and efficient in order to prevent overhead and delays. WSO2 API Manager uses caching for this purpose, where the validation information is cached with the token, API name, and version, and the cache is stored in either the API Gateway or the Key Manager server.

The default cache size of any type of cache in a WSO2 product is 10,000 elements/records. Cache eviction occurs from the 10001st element. All caches in WSO2 products can be configured using the `<PRODUCT_HOME>/repository/conf/deployment.toml` file. In case you have not defined a value for default cache timeout under server configurations, the defaultCacheTimeout of 15 minutes will be applied which comes by default.

``` java
    [server]
    default_cache_timeout = 15
```

These configurations apply globally to all caches. You can override these values for specific caches using the UI or different configuration files as discussed under each section below.

This section covers the following:

-   [API Gateway cache](#api-gateway-cache)
-   [Resource cache](#resource-cache)
-   [Key Manager cache](#key-manager-cache)
-   [Response cache](#response-cache)
-   [Developer Portal cache](#developer-portal-cache)

!!! tip
    In a distributed environment, the caching configurations you do in one node replicates equally in all nodes.

!!! tip
    Apart from response caching, all the other caches are enabled by product. When the WSO2 API Manager components are clustered, they work as distributed caches. This means that a change done by one node is visible to another node in the cluster.


### API Gateway cache

When caching is enabled at the Gateway and a request hits the Gateway, it first populates the cached entry for a given token. If a cache entry does not exist in the cache, it calls the Key Manager server. This process is carried out using Web service calls. After the Key Manager server returns the validation information, it gets stored in the Gateway. As the API Gateway issues a Web service call to the Key Manager server only, if it does not have a cache entry, this method reduces the number of Web service calls to the Key Manager server. Therefore, it is faster than the alternative method.

By default, the API Gateway cache is enabled. This can be disabled by modifying the following attribute in `<PRODUCT_HOME>/repository/conf/deployment.toml` file.

``` java
    [apim.cache.gateway_token]
    enable = false
```

!!! note
    If you need to enable Gateway caching across the entire cluster, see [Working with Hazelcast Clustering](https://docs.wso2.com/display/AM260/Working+with+Hazelcast+Clustering#WorkingwithHazelcastClustering-WhentouseHazelcast) .


##### Clearing the API Gateway cache

If you wish to remove old tokens that might still remain active in the Gateway cache, you need to configure the following attribute in the `<API-M_HOME>/repository/conf/deployment.toml` file by providing the URL of the [Revoke API](https://docs.wso2.com/display/AM260/Token+API) that is deployed in the API Gateway node. 

``` java
    [apim.oauth_config]
    revoke_endpoint = "https://localhost:${https.nio.port}/revoke"
```

The revoke API invokes the cache clear handler, which extracts information from transport headers of the revoke request and clears all associated cache entries. If there's a cluster of API Gateways in your setup, provide the URL of the revoke API deployed in one node in the cluster. This way, all revoke requests route to the OAuth service through the Revoke API.

Given below is how to configure this in a distributed API Manager setup.

1.  In the `deployment.toml` file of the **Developer Portal node** , point the revoke endpoint as follows:

    ``` java
        [apim.oauth_config]
        revoke_endpoint = "https://${carbon.local.ip}:${https.nio.port}/revoke"
    ```

2.  In the API Gateway, point the Revoke API to the OAuth application deployed in the key manager node. For example,

    ``` xml
        <api name="_WSO2AMRevokeAPI_" context="/revoke">
            <resource methods="POST" url-mapping="/*" faultSequence="_token_fault_">
                <inSequence>
                    <send>
                        <endpoint>
                            <address uri="https://keymgt.wso2.com:9445/oauth2/revoke"/>
                        </endpoint>
                    </send>
                </inSequence>
                <outSequence>
                    <send/>
                </outSequence>
            </resource>
            <handlers>
                <handler class="org.wso2.carbon.apimgt.gateway.handlers.ext.APIManagerCacheExtensionHandler"/>
            </handlers>
        </api>
    ```

### Resource cache

An API's resources are HTTP methods that handle particular types of requests such as GET, POST etc. They are similar to methods of a particular class. Each resource has parameters such as its throttling level, Auth type etc.

![]({{base_path}}/assets/img/administer/resource-security-and-throttling-limit.png)

Users can make requests to an API by calling any one of the HTTP methods of the API's resources. The API Manager uses the resource cache at the Gateway node to store the API's resource-level parameters (Auth type and throttling level). The cache entry is identified by a cache key, which is based on the API's context, version, request path and HTTP method. Caching avoids the need to do a separate back-end call to check the Auth type and throttling level of a resource, every time a request to the API comes. It improves performance.

Note that if you update an API, the resource cache gets invalidated and the changes are reflected within a few minutes.

By default, the resource cache is enabled.  This can be disabled by modifying the following attribute in <PRODUCT_HOME>/repository/conf/deployment.toml file.

``` java
    [apim.cache.resource]
    enable = false
```

### Key Manager cache

The following caches are available:

-   [Key cache](#key-cache)
-   [OAuth cache](#oauth-cache)

#### Key cache

In a typical API Manager deployment, the Gateway is deployed in a DMZ while the Key Manager is in MZ. By default, caching is enabled at the Gateway. To avoid caching token-related information in a leniently secured zone, you can store the cache on the Key Manager side. If you do, for each and every API call that hits the API Gateway, the Gateway issues a Web service call to the Key Manager server. If the cache entry is available in the Key Manager server, it is returned to the Gateway. Else, the database is checked for the validity of the token.

Storing the cache in the Key Manager causes lower performance than when storing it in the Gateway, but it is more secure. If you enable the key cache in a clustered environment, you should have only one Gateway per Key Manager, whereas you can have two Gateways per Key Manager when the Gateway cache is enabled instead. Note that you should always have one of the caches enabled, but we do not recommend using both caches combined. For more information, see [Clustering Gateways and Key Managers with key caching](https://docs.wso2.com/display/CLUSTER44x/API+Manager+Deployment+Patterns#APIManagerDeploymentPatterns-keycache) in the WSO2 Clustering Guide.

You can configure the key cache by editing the following elements in the `<APIM_HOME>/repository/conf/deployment.toml` file:

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<thead>
<tr class="header">
<th>Purpose</th>
<th>Configuration Elements</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>Disable the API Gateway cache.</td>
<td><p> [apim.cache.gateway_token] <br/> enable = false </p></td>
</tr>
<tr class="even">
<td>Enable the Key Manager cache.</td>
<td><p> [apim.cache.km_token] <br/> enable = true </p></td>
</tr>
<tr class="odd">
<td>Change the key cache duration, which expires after 900 seconds by default.</td>
<td><p> [apim.cache] <br/> token_expiry_time = 900 </p></td>
</tr>
</tbody>
</table>

#### OAuth cache

The OAuth token is saved in this cache, which is enabled by default. Whenever a new OAuth token is generated, it is saved in this cache to prevent constant database calls. Unless an OAuth expires or is revoked, the same token is sent back for the same user. Therefore, you do not need to change this cached token most of the time.

### Response cache

Please refer [Response Caching]({{base_path}}/learn/api-gateway/response-caching/) to see how to enable response caching for a given API.

### Developer Portal cache

The Developer Portal has several caches to reduce the page-load times and increase its responsiveness when multiple users access it simultaneously.

-   **Tag cache:** This cache saves the API's tags after they have been retrieved from registry. If your APIs and associated tags change frequently, it is recommended to configure a smaller cache refresh time (in milliseconds). This cache is disabled by default. To enable it, uncomment the following element in the `<APIM_HOME>/repository/conf/deployment.toml` file.

    ``` java
        [apim.cache.tags]
        expiry_time = "2m"
    ```

-   **Recently-added-API cache:** This cache saves the five most recently added APIs. It is disabled by default. If you have multiple API modifications during a short time period, it is recommended to not enable this cache. To enable it, uncomment following section in `<APIM_HOME>/repository/conf/deployment.toml` file and set enable to `true`.
    ``` java
        [apim.cache.recent_apis]
        enable = true
    ```


