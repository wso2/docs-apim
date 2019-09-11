# Whitelisting Hostnames for API Store

API Manager provides the capability to whitelist multiple host names if you use different host names to access API Store in your environment.

!!! info
In this case, **localhost** is by default considered as a whitelisted host name.


Similarly you can whitelist multiple host names for store as follows.

-   You need to add the host names to the **whiteListedHostNames** attribute in `<API-M_HOME>/repository/deployment/server/jaggeryapps/store/site/conf/site.json` as comma separated values.

See the following example configuration.

``` java
    "whiteListedHostNames": ["www.wso2.org", "www.example.com"]
```

!!! note
Note :

When you try to access API Store with a host which is not whitelisted, or is not specified in `<API-M_HOME>/repository/conf.carbon.xml,` you will notice the following warning being logged in the server logs.

``` text
    Possible HOST Header Attack is identified. Hence, rewriting to default host in configuration.
```


