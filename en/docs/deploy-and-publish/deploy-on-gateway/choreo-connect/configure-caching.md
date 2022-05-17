# Configure Caching

Choreo Connect contains the following caching mechanisms to increase the performance of the Gateway. The following section describes how you can enable caching in Choreo Connect.

### Configuring OAuth Cache

Choreo Connect will accept JWTs as OAuth tokens issued by a trusted key manager as a valid token.

The OAuth token is kept in the default OAuth cache, which is enabled. It verifies the token by validating the signature, token expiration, and other factors if a cache entry does not present in the cache. If the certificate information isn't available, the JWKS endpoint is used to get the certificate information. The token is saved in the Choreo Connect cache after it has been verified.

The OAuth token is enabled by default in the Choreo Connect. Adding the following section to the `config.toml` file which is located in the `<CHOREO-CONNECT_HOME>/docker-compose/choreo-connect-with-apim or choreo-connect/conf ` directory , you can change the configurations in the OAuth cache.

#### OAuth caching

``` java
[enforcer.cache]
  enabled = true
  maximumSize = 10000
  expiryTime = 15
```

| Configuration Element           | Description|
|--------------------------|--------------------------------------|
| enabled     | Enable/ disable enforcer token cache. |
| maximumSize| The maximum number of tokens that the cache can store.|
| expiryTime | The cache expiry time in minutes. |
