# Multi-HTTPS Transport

<!--
## Synchronizing the profiles in a cluster

If you are running in a clustered environment and want your SSL profiles
to be synchronised across the cluster nodes, you can move the
`         SSLProfiles        ` parameter from
`         axis2.xml        ` to
`         <EI_HOME>/repository/deployment/server/multi_ssl_profiles.xml        `
. Then you can add the `         SSLProfilesConfigPath        `
parameter to the Multi-HTTPS transport receiver configuration in the
`         axis2.xml        ` file and point to the new destination of
the configuration.

For example, the Multi-HTTPS transport configuration in the
`         axis2.xml        ` file will now look as follows:

```
<transportReceiver name="multi-https" class="org.apache.synapse.transport.nhttp.HttpCoreNIOMultiSSLListener">
            <parameter name="port">8343</parameter>
            <parameter name="non-blocking">true</parameter>
            <parameter name="SSLProfilesConfigPath">
               <filePath>/repository/deployment/server/multi_ssl_profiles.xml</filePath>
            </parameter>
</transportReceiver>
```

To synchronise this configuration between two EI nodes, you must enable
EI clustering and the SVN-Based Deployment Synchronizer.

The `         <EI_HOME>/repository/deployments/server        `
directory will then be synchronized on the WSO2 EI nodes when the nodes
are run in a clustered environment. If you change the
`         multi_ssl_profiles.xml        ` file, you must manually reload
it into each WSO2 EI node by invoking the
`         reloadSSLProfileConfig        ` in the
`         org.apache.synapse.MultiSSLProfileReload        ` MBean in
JConsole. For more information, see [JMX-based
Monitoring](https://docs.wso2.com/display/ADMIN44x/JMX-Based+Monitoring).
-->

You can [enable dynamic SSL profiles](#enabling-dynamic-ssl-profiles) for the Micro Integrator by updating the `deployment.toml` file with the required SSL
profile configurations. Also, you can [dynamically load the SSL profiles](#loading-ssl-profiles-at-runtime) at
runtime using a periodic schedule or JMX invocation. That is, instead of reloading the entire `deployment.toml` at runtime, you can
reload the new configuration files that contain only the custom profile
information for the sender and receiver.

## Enabling dynamic SSL profiles

The following configuration changes should be done in the Multi-HTTPS
transport receiver and sender.

Dynamic SSL profiles for the Multi-HTTPS **transport sender**:

1.   Open the `deployment.toml` file (stored in the `MI_HOME/conf` directory) and add the following parameters.

    ```toml
    [transport.http]
    sender.ssl_profile.file_path = "conf/sslprofiles/senderprofiles.xml"
    sender.ssl_profile.read_interval = 600000
    ```

2.   Create the `senderprofiles.xml` file with the following configuration in the
    `MI_HOME/conf/sslprofiles` directory:

    !!! Info
        You can configure the file path for the `senderprofiles.xml` file as required.

    ```xml
    <parameter name="customSSLProfiles">
        <profile>
            <servers>localhost:8244,192.168.1.234:8245</servers>
            <KeyStore>
                <Location>repository/resources/security/esb.jks</Location>
                <Type>JKS</Type>
                <Password>123456</Password>
                <KeyPassword>123456</KeyPassword>
            </KeyStore>
            <TrustStore>          
                <Location>repository/resources/security/esbtruststore.jks</Location>
                <Type>JKS</Type>
                <Password>123456</Password>
            </TrustStore>
        </profile>
    </parameter>
    ```

    The SSL profile will be applied to each request that is sent to the
    destination server specified within the
    `<servers>` element as IP:Port combination.
    
    !!! Note
        Use host names in the `<servers>` list instead of IP addresses to avoid latencies due to DNS lookup. If you 
        are using IP address, make sure to add an entry to the host file with respective host name mapping.


Dynamic SSL profiles for the Multi-HTTPS **transport listener**:

!!! Warning
        The following instructions relevant to the **Multi-HTTPS Transport Listener** is currently under review. Please refer [Issue #2034](https://github.com/wso2/micro-integrator/issues/2034) for details.

1.   Open the `deployment.toml` file (stored in the `MI_HOME/conf` directory) and add the following parameters.

    ```toml
    [transport.http]
    listener.ssl_profile.file_path = "conf/sslprofiles/listenerprofiles.xml"
    listener.ssl_profile.read_interval = 600000
    ```

2.   Create the `listenerprofiles.xml` file with the following configuration in the
    `MI_HOME/conf/sslprofiles` directory:

    !!! Info
        You can configure the file path for the `listenerprofiles.xml` file as required.

    ```xml
    <parameter name="SSLProfiles">
    <profile>
            <bindAddress>192.168.0.123</bindAddress>
            <KeyStore>
                <Location>repository/resources/security/esb.jks</Location>
                <Type>JKS</Type>
                <Password>123456</Password>
                <KeyPassword>123456</KeyPassword>
                </KeyStore>
            <TrustStore>              
                <Location>repository/resources/security/esbtruststore.jks</Location>
                <Type>JKS</Type>
                <Password>123456</Password>
            </TrustStore>
            <SSLVerifyClient>require</SSLVerifyClient>
        </profile>
    </parameter>
    ```

    The SSL profile will be applied to each request that is received at
    the IP specified within the `           <bindAddress>          `
    element.

## Loading SSL profiles at runtime

You can either use a periodic schedule or a JMX invocation to apply
custom profiles at runtime. The following section describes the two
options in detail:

-   **Periodic schedule**: If you use this option, the Micro Integrator will
    automatically check updates of the file content and apply the custom
    profiles based on the value specified in the
    `           fileReadInterval          ` parameter. For example, if
    you have set the `           fileReadInterval          ` as 1 hour,
    The Micro Integrator will automatically check updates of the file content and
    apply the custom profile every 1 hour.

-   **JMX Invocation**: If you use this option, custom profiles will be
    applied dynamically by invoking the
    `notifyFileUpdate` method in the
    respective sender/listener MBean under the
    `ListenerSSLProfileReloader` or
    `SenderSSLProfileReloader` group in JConsole.

The following table provides information on the parameters that you can
set when you enable dynamic SSL profiles:

| Parameter Name                              | Description                                                                                                                                           | Default Value |
|---------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------|---------------|
| `             filePath            `         | The relative/absolute file path of the custom SSL profile configuration XML file.                                                                     | \-            |
| `             fileReadInterval            ` | The time interval (in milliseconds) in which configuration updates will be loaded and applied at runtime. This value should be greater than 1 minute. | 3600000       |
