# Configuring Caching

When an API call hits the API Gateway, the Gateway carries out security checks to verify if the token is valid. During these verifications, the API Gateway extracts parameters (i.e., access token, API name, and API version) that are passed on to it. As the entire load of the traffic to APIs goes through the API Gateway, this verification process needs to be fast and efficient in order to prevent overhead and delays. WSO2 API Manager uses caching for this purpose, where the validation information is cached with the token, API name, and version, and the cache is stored in either the API Gateway or the Key Manager server.

The default cache size of any type of cache in a WSO2 product is 10,000 elements/records. Cache eviction occurs from the 10001st element. All caches in WSO2 products can be configured using the `<PRODUCT_HOME>/repository/conf/deployment.toml` file. In case you have not defined a value for default cache timeout under server configurations, the `defaultCacheTimeout` of 15 minutes will be applied which comes by default.

``` java
[server]
default_cache_timeout = 15
```

These configurations apply globally to all caches. You can override these values for specific caches using the UI or different configuration files as discussed under each section below.

!!! tip
    In a distributed environment, the caching configurations you do in one node replicates equally in all nodes.

!!! tip
    Apart from response caching, all the other caches are enabled by the product. When the WSO2 API Manager components are clustered, they work as distributed caches. This means that a change done by one node is visible to another node in the cluster.


## API Gateway cache

When caching is enabled at the Gateway and a request hits the Gateway, it first populates the cached entry for a given token. If a cache entry does not exist in the cache, for **JWT tokens**, gateway self validates the JWT and store it in the Gateway. If a cache entry does not exist in the cache, for **opaque tokens**, it calls the Key Manager server. This process is carried out using web service calls. After the Key Manager server returns the validation information, it gets stored in the Gateway. 

### Clearing the API Gateway cache

When a token is revoked at the Key Manager, a token revocation event is sent to the Traffic Manager. Gateways receive this token revocation controller event and clear the cache accordingly.

This feature is enabled by default and token revocation events are published by the `org.wso2.carbon.apimgt.notification.TokenRevocationNotifierImpl.java` class.

If you need to change the default behavior, you can implement the `org.wso2.carbon.apimgt.notification.TokenRevocationNotifier` interface and plug new implementation using the following configuration in the `deployment.toml` file.

```
[apim.token.revocation]
notifier_impl="org.wso2.carbon.apimgt.notification.TokenRevocationNotifier"
```

For more information on the above configuration, see the [Config Catalog]({{base_path}}/reference/config-catalog/#api-m-token-revocation).

## Resource cache

An API's resources are HTTP methods that handle particular types of requests such as GET, POST, etc. They are similar to the methods of a particular class. Each resource has parameters such as its throttling level, Auth type, etc.

[![Resource security and throttling limit]({{base_path}}/assets/img/administer/resource-security-and-throttling-limit.png)]({{base_path}}/assets/img/administer/resource-security-and-throttling-limit.png)

Users can make requests to an API by calling any one of the HTTP methods of the API's resources. The API Manager uses the resource cache at the Gateway node to store the API's resource-level parameters (Auth type and throttling level). The cache entry is identified by a cache key, which is based on the API's context, version, request path, and HTTP method. Caching avoids the need to do a separate back-end call to check the Auth type and throttling level of a resource, every time a request to the API comes. It improves performance.

Note that if you update an API, the resource cache gets invalidated and the changes are reflected within a few minutes.

By default, the resource cache is enabled.  This can be disabled by modifying the following attribute in the `<API-M_HOME>/repository/conf/deployment.toml` file.

```
[apim.cache.resource]
enable = false
```

## Key Manager cache

The Key Manager consists of the OAuth Cache.

### OAuth cache

The OAuth token is saved in this cache, which is enabled by default. Whenever a new OAuth token is generated, it is saved in this cache to prevent constant database calls. Unless an OAuth expires or is revoked, the same token is sent back for the same user. Therefore, you do not need to change this cached token most of the time.

## Response cache

For information on how to enable response caching for a given API, see [Response Caching]({{base_path}}/deploy-and-publish/deploy-on-gateway/api-gateway/response-caching/).

## JWT claims cache

For information on how to enable JWT claims caching, see [JWT claims Caching]({{base_path}}/deploy-and-publish/deploy-on-gateway/api-gateway/passing-enduser-attributes-to-the-backend-via-api-gateway/#expiry-time-of-the-jwt).

## Publisher cache

### Publisher-roles cache

This indicates whether the role cache needs to be enabled in the Publisher. It is disabled by default. If this is disabled, for all API publisher calls, there will be a call to the Key Manager. It expires in 15 minutes by default. It is highly recommended to enable this cache. However, if the system is in a state where the role addition and deletion happen seamlessly, the caching will not happen as expected.

```
[apim.cache.publisher_roles]
enable = true
```

## Developer Portal cache

The Developer Portal has several caches to reduce the page load times and increase its responsiveness when multiple users access it simultaneously.

### Tag cache

This cache saves the API's tags after they have been retrieved from the Registry. If your APIs and associated tags change frequently, it is recommended to configure a smaller cache refresh time (in milliseconds). This cache is disabled by default. To enable it, uncomment the following element in the `<API-M_HOME>/repository/conf/deployment.toml` file.

``` java
[apim.cache.tags]
expiry_time = "2m"
```

### Recently-added-API cache

This cache saves the five most recently added APIs. It is disabled by default. If you have multiple API modifications during a short time period, it is recommended to not enable this cache. To enable it, uncomment the following section in the `<API-M_HOME>/repository/conf/deployment.toml` file and set enable to `true`.

``` java
[apim.cache.recent_apis]
enable = true
```
    
### Scopes cache

This specifies whether scopes are taken from the cache or not. It is disabled by default. If you are modifying application subscriptions frequently, modifying the user roles frequently, or updating the subscribed APIs frequently, it is recommended to not enable this cache. To enable it, uncomment the following section in the `<API-M_HOME>/repository/conf/deployment.toml` file and set enable to `true`.

``` java
[apim.cache.scopes]
enable = true
```
