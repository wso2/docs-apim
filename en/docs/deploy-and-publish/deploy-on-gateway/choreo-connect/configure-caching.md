# Configure Caching

The following section describes how you can enable caching in Choreo Connect.
### Configuring OAuth Cache

The OAuth token is enabled by default in the Choreo Connect. Adding the following section to the `config.toml` file which is located in the `<CHOREO-CONNECT_HOME>/docker-compose/choreo-connect-with-apim or choreo-connect/conf ` directory , you can change the configurations in the OAuth cache.

#### OAuth caching

``` java
[enforcer.cache]
  enabled = true
  maximumSize = 10000
  expiryTime = 15
```

| Config Element           | Description|
|--------------------------|--------------------------------------|
| enabled     | Enable/ disable enforcer token cache. |
| maximumSize| The maximum number of tokens that the cache can store.|
| expiryTime | The cache expiry time in minutes. |
