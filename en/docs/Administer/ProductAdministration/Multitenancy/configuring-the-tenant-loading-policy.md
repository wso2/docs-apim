# Configuring the Tenant Loading Policy

In WSO2 products based on Carbon 4.4.0 or later versions, you have the option of setting the required tenant loading policy by enabling either **Lazy Loading** or **Eager Loading** of tenants. Additionally, you can separately control the loading policy for web applications and axis2 services deployed in your tenants using the **GhostDeployment** setting.

!!! note
By default, **Lazy Loading** is enabled for tenants in all WSO2 products.


First, read the following descriptions to understand how Lazy loading and Eager loading work:

-   **Lazy Loading:** Lazy loading of tenants ensures that all tenants are not loaded at the time the server starts. Instead, the tenants are loaded on demand (upon a request sent to a particular tenant). When a tenant receives a request, the particular tenant and all tenant-specific artifacts, except **web applications** and **axis2 services** , get loaded. Therefore, if you have these artifacts (web applications and axis2 services) deployed in your tenants, you will need to separately enable lazy loading for artifacts using the `GhostDeployment` setting. If lazy loading is not enabled for artifacts, by default, these artifacts will comply with the Eager loading behavior that is explained below.
    Tenants (including the tenant-specific artifacts) are **unloaded** from memory if the tenant remains idle for a specified amount of time. You can configure the allowed tenant idle time. See [Configuring Lazy Loading](#ConfiguringtheTenantLoadingPolicy-ConfiguringLazyLoading) for instructions.
-   **Eager Loading:** Unlike lazy loading, eager loading ensures that tenants will be initialized when the server starts (without any delays). You can switch to eager loading if required. Note that you also have the option of enabling eager loading for specific tenants so that only the required tenants will be loaded when the server starts. If you have **web applications** and **axis2 services** deployed for your tenants, you will want these artifacts to behave according to the eager loading policy. Therefore, it is recommended that you disable lazy loading for artifacts ( `GhostDeployment` setting) when eager loading is enabled.
    When eager loading is enabled, tenants (and the tenant-specific artifacts) are expected to remain in memory without unloading until the server shuts down. However, due to a [known issue](https://wso2.org/jira/browse/CARBON-15215) in the system, tenants (and the tenant-specific artifacts) will unload from the system if the tenants are idle for more than 30 minutes. You can overcome this condition by applying a system property to change the allowed tenant idle time. See [Configuring Eager Loading](#ConfiguringtheTenantLoadingPolicy-ConfiguringEagerLoading) for instructions.

Now, see the instructions given below to configure the required tenant loading policy for your system.

-   [Configuring Lazy Loading](#ConfiguringtheTenantLoadingPolicy-ConfiguringLazyLoading)
    -   [Enabling lazy loading of artifacts (web applications and axis2 services)](#ConfiguringtheTenantLoadingPolicy-Enablinglazyloadingofartifacts(webapplicationsandaxis2services))
    -   [Configuring the tenant unloading time (for Lazy Loading)](#ConfiguringtheTenantLoadingPolicy-Configuringthetenantunloadingtime(forLazyLoading))
-   [Configuring Eager Loading](#ConfiguringtheTenantLoadingPolicy-ConfiguringEagerLoading)

### Configuring Lazy Loading

As explained above, Lazy Loading (for tenants) is enabled as the loading policy in WSO2 products, by default. To verify that lazy loading is enabled, open the `carbon.xml` file (stored in the `<PRODUCT_HOME>/repository/conf` directory) and see that `<LazyLoading>` is uncommented as shown below.

``` java
    <Tenant>
             <LoadingPolicy>
                <LazyLoading>
                        <IdleTime>30</IdleTime>
                 </LazyLoading>
             <!--<EagerLoading>
                        <Include>*,!foo.com,!bar.com</Include>
                 </EagerLoading>-->
            </LoadingPolicy>
    </Tenant>
```

#### Enabling lazy loading of artifacts (web applications and axis2 services)

If you have lazy loading enabled, and if you have web applications and axis2 services deployed as artifacts in your tenants, you need to separately enable lazy loading for artifacts. This will ensure that these artifacts are first loaded in ghost form. The actual artifacts are deployed only when the artifact is requested.

!!! note
**Before you enable lazy loading of artifacts** , note the following:

-   This setting is only applicable to the following artifacts: web applications and axis2 services.
-   This setting only applies if the artifacts (web applications and axis2 services) are using the HTTP/S transport. However, sometimes your axis2 services may be using other transport types such as JMS. In such situations, it is not recommended to enable lazy loading for your artifacts.
-   When this setting is enabled for PaaS deployments, lazy loading applies for tenants as well as the tenant artifacts. As a result, for a tenant in a cloud environment, lazy loading is applicable on both levels.
-   Also, if an artifact has not been utilized for a certain period of time ( [tenant idle time](#ConfiguringtheTenantLoadingPolicy-Configuringthetenantunloadingtime(forLazyLoading)) ), it will be unloaded from memory.


Follow the steps given below.

1.  Open the `carbon.xml` file (stored in the `<PRODUCT_HOME>/repository/conf` directory).

    ``` java
        <GhostDeployment>
           <Enabled>false</Enabled>
        </GhostDeployment>
    ```

2.  Set the `<Enabled>` property to `true` .

#### Configuring the tenant unloading time (for Lazy Loading)

If you have Lazy loading enabled, you can configure the allowed tenant idle time. For example, if you set the idle time to 30 minutes, tenants that are idle for more than 30 minutes will be unloaded automatically in your system. You can configure this value using two methods.

-   Specify the tenant idle time when you configure the tenant loading policy:
    1.  Open the `carbon.xml` file.

    2.  Be sure that the `<LazyLoading>` element is enabled and `<EagerLoading>` is commented out as per the default setting.
    3.  Set the tenant idle time using the `<IdleTime>` element as shown below.

        ``` java
                <Tenant>
                         <LoadingPolicy>
                             <LazyLoading>
                                    <IdleTime>30</IdleTime>
                             </LazyLoading>-->
                         <!--<EagerLoading>
                                    <Include>*,!foo.com,!bar.com</Include>
                             </EagerLoading>-->
                        </LoadingPolicy>
                </Tenant>
        ```

-   Alternatively, you can specify the tenant idle time when you start the server:

    1.  Open the product startup script (. `/wso2server.sh` file for Linux and `wso2server.bat` for Windows), which is stored in the `<PRODUCT_HOME>/bin` directory.
    2.  Add the following system property.

        ``` java
                    $JAVA_OPTS \ 
                         -Dtenant.idle.time=<value_in_minutes>. \
        ```

    3.  Restart the server.

### Configuring Eager Loading

Follow the instructions given below to change the tenant loading policy to eager loading.

!!! note **Before you enable eager loading** , note the following:
-   Web applications and axis2 services that are deployed as artifacts in your tenants follow the eager loading behavior by default unless the `GhostDeployment` setting is enabled, as explained above under [Enabling lazy loading of artifacts](#ConfiguringtheTenantLoadingPolicy-Enablinglazyloadingofartifacts(webapplicationsandaxis2services)) . Therefore, when you enable eager loading for your tenants, make sure that `GhostDeployment` is disabled.
-   The server startup time may increase depending on the number of tenants and artifacts you have.
-   The server's memory footprint will increase depending on the number of tenants and artifacts that are loaded.


1.  Open the `carbon.xml` file from the `<PRODUCT_HOME>/repository/conf/` directory.

2.  Enable the `<EagerLoading>` element and comment out `<LazyLoading>` as shown below.

    ``` java
        <Tenant>
                 <LoadingPolicy>
                 <!--<LazyLoading>
                            <IdleTime>30</IdleTime>
                     </LazyLoading>-->
                     <EagerLoading>
                            <Include>*,!foo.com,!bar.com</Include>
                     </EagerLoading>
                </LoadingPolicy>
        </Tenant>
    ```

3.  You can then list the specific tenant domains to which eager loading should apply, by using the `<Include>` element. See the following examples:
    -   If the setting should apply to all tenants, add `<Include>*</Include>` .
    -   If the setting should apply to all tenants, except [foo.com](http://foo.com/) and [bar.com](http://bar.com/) , add `<Include>  *,!  foo.com ,!bar.com</Include>.`
    -   If the setting should apply only to [foo.com](http://foo.com/) and [bar.com](http://bar.com/) , add `<Include>foo.com,bar.com </Include>` .

!!! info
Due to a [known issue](https://wso2.org/jira/browse/CARBON-15215) , when eager loading is enabled, tenants will be unloaded from memory if the tenant remains idle for more than 30 minutes. This issues will be resolved in the Carbon 4.5.0 release. In current product releases, you have the option of changing the allowed idle time (which is 30 minutes, by default) using a system property:

1.  Open the product startup script (. `/wso2server.sh` file for Linux and `wso2server.bat` for Windows), which is stored in the `<PRODUCT_HOME>/bin` directory.
2.  Add the following system property.

    ``` java
        $JAVA_OPTS \ 
             -Dtenant.idle.time=<value_in_minutes> \
    ```

3.  Restart the server.


