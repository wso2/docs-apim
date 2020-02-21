# Token Expiration

### Configuring the token expiration time

User access tokens have a fixed expiration time, which is set to 60 minutes by default. Before deploying the API Manager to users, change the default expiration time by adding the following configuration to `<APIM_HOME>/repository/conf/deployment.toml` file.
```
    [oauth]
    token_validation.app_access_token_validity = 10000
```

Also take the **time stamp skew** into account when configuring the expiration time. The time stamp skew is used to manage small time gaps in the system clocks of different servers. For example, let's say you have two Key Managers and you generate a token from the first one and authenticate with the other. If the second server's clock runs 300 seconds ahead, you can configure a 300s time stamp skew in the first server. When the first Key Manager generates a token (e.g., with the default life span, which is 3600 seconds), the time stamp skew is deducted from the token's life span. The new life span is 3300 seconds and the first server calls the second server after 3200 seconds.

You configure the time stamp skew using the by adding the following configuration in `<APIM_HOME>/repository/conf/deployment.toml` file.
```
    [oauth]
    timestamp_skew = 100
```

!!! tip
    Ideally, the time stamp skew should not be larger than the token's life span. We recommend you to set it to zero if the nodes in your cluster are synchronized.


When a user access token expires, the user can try regenerating the token.
