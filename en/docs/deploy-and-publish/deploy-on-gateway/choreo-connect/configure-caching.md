# Configure Caching

The following section describes how you can enable caching in the Microgateway.

### Enabling Response Caching for an API

You need to enable response caching when adding an API using an OpenAPI definition. Add the following extension to the API level in the OpenAPI definition.

#### Response caching

``` java
x-wso2-response-cache: 
    enabled: true
    cacheTimeoutInSeconds: 300
```

| Sub extension         | Description                                                                    |
|-----------------------|--------------------------------------------------------------------------------|
| enabled               | This defines whether the response cache is enabled or not in the Microgateway. |
| cacheTimeoutInSeconds | Expiry time of the cache in seconds.                                           |

### Configuring OAuth Cache

The OAuth token is enabled by default in the Microgateway. Adding the following section to the `micro-gw.conf` file which is located in the `<MGW-RUNTIME-HOME>/conf ` directory , you can change the configurations in the OAuth cache.

#### OAuth caching

``` java
[caching]
tokenCacheExpiryTime = 900000
tokenCacheCapacity = 10000
tokenCacheEvictionFactor = 0.25
```

| Subheading               | Description                                                                                                                                                  |
|--------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------|
| tokenCacheExpiryTime     | Expiry time of the cache in seconds.                                                                                                                         |
| tokenCacheCapacity       | The size of the cache in MB.                                                                                                                                 |
| tokenCacheEvictionFactor | The factor of the cache that will be cleared when the cache is full. By default 0.25 @5MB of the cache will be cleared when the cache is full (i.e. 100 MB). |


