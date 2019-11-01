# Changing the default token expiration time

Access tokens have an expiration time, which is set to 60 minutes by default.

To change the default expiration time of application access tokens,
To enable or disable token cleanup, open the `<API-M_HOME>/repository/conf/deployment.toml` file and do the following changes under `[oauth.token_validation]`.(add the configuration if not exists in the deployment.toml file)

``` toml
[oauth.token_validation]
app_access_token_validity = 2000
```

!!! note
    Changes you have done here will be applied only to the new applications that you create.

Alternatively, you can set a default expiration time through the UI when generating/regenerating the application access token.This is explained in [previous sections](application-access-tokens.md) .

Similarly, to change the default expiration time of user access tokens, put configuration with value or modify the value defined in the `user_access_token_validity` element in the `<API-M_HOME>/repository/conf/deployment.toml` file under `[oauth.token_validation]`.

User access tokens have an expiration time, which is set to 60 minutes by default.

``` toml
[oauth.token_validation]
user_access_token_validity = 3000
```

To  change the default expiration time of refresh tokens, put configuration with value or modify the value defined in the `refresh_token_validity` element in the `<API-M_HOME>/repository/conf/deployment.toml` file under `[oauth.token_validation]`.

Refresh access tokens have an expiration time, which is set to 24 hours by default.

``` toml
[oauth.token_validation]
refresh_token_validity = 86400
```

!!! note
    finally you have following if you configured all above configurations.
    ``` toml
        [oauth.token_validation]
        app_access_token_validity = 2000
        user_access_token_validity = 3000
        refresh_token_validity = 86400
    ```

Also see [Configuring Caching](../../../../../Administer/ProductConfigurations/configuring-caching.md) for several caching options available to optimize key validation.
