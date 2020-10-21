# Scope Allowlisting

A scope is not always used for controlling access to a resource. You can also use it to simply mark an access token. There are scopes that cannot be associated to roles (e.g., openid, device\_). Such scopes do not have to have roles associated with them. Skipping role validation for scopes is called scope allowlisting.

If you do not want a role validation for a scope in an API's request, add the scope as `allowed_scopes` in the `<API-M_HOME>/repository/conf/deployment.toml` file and restart the server. It will be allowlisted. For example,

```
[apim.oauth_config]
allowed_scopes = ["^device_.*", "openid", "some_random_scope"]
```

Next, invoke the Token API to get a token for the scope that you just allowlisted. For example,

```
curl -k -d  "grant_type=password&username=admin&password=admin&scope=some_random_scope" -H "Authorization: Basic WmRFUFBvZmZwYVFnR25ScG5iZldtcUtSS3IwYTpSaG5ocEVJYUVCMEN3T1FReWpiZTJwaDBzc1Vh" -H "Content-Type: application/x-www-form-urlencoded" https://localhost:8243/token
```

Note that the issued token has the scope you requested. You get the token without any role validation as the scope is allowlisted.

```
{"scope":"some_random_scope","token_type":"bearer","expires_in":3600,"refresh_token":"59e6676db0addca46e68991e44f2b8b8","access_token":"48855d444db883171c347fa21ba77e8"}
```
