# Enabling or disabling the walkthrough

To disable the API Store walkthrough, open the `         <APIM_HOME>/repository/deployment/server/jaggeryapps/store/site/conf/interactiveTutorial.json        ` file.

Set the `         isEnabledTutorial        ` parameter to false as show below.

``` java
    {
        "isEnabledTutorial" : false,
        "blackListedTenantDomains" : []
    }
```

