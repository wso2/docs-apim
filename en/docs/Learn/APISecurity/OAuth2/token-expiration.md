# Token Expiration

### Configuring the token expiration time

User access tokens have a fixed expiration time, which is set to 60 minutes by default. Before deploying the API Manager to users, extend the default expiration time by editing the `<AccessTokenDefaultValidityPeriod>` element in the `<APIM_HOME>/repository/conf/identity/identity.xml` file.

Also take the **time stamp skew** into account when configuring the expiration time. The time stamp skew is used to manage small time gaps in the system clocks of different servers. For example, let's say you have two Key Managers and you generate a token from the first one and authenticate with the other. If the second server's clock runs 300 seconds ahead, you can configure a 300s time stamp skew in the first server. When the first Key Manager generates a token (e.g., with the default life span, which is 3600 seconds), the time stamp skew is deducted from the token's life span. The new life span is 3300 seconds and the first server calls the second server after 3200 seconds.

You configure the time stamp skew using the `<TimestampSkew>` element in the `<APIM_HOME>/repository/conf/identity/identity.xml` file.

!!! tip
**Tip** : Ideally, the time stamp skew should not be larger than the token's life span. We recommend you to set it to zero if the nodes in your cluster are synchronized.


When a user access token expires, the user can try regenerating the token.
