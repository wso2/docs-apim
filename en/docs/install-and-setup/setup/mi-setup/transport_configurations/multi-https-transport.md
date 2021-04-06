# Multi-HTTPS Transport

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
            <servers>localhost:8244,hostname:8245</servers>
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

To dynamically load the SSL profiles at runtime for the Multi-HTTPS transport listener, you can configure 
`org.apache.synapse.transport.passthru.PassThroughHttpMultiSSLListener` (which is the existing implementation of the 
Multi-HTTPS transport receiver) as a custom transport receiver.

1.   Open the `deployment.toml` file (stored in the `MI_HOME/conf` directory) and add the following parameter to disable 
     the default HTTPS transport receiver.

    ```toml
    [transport.http]
    listener.secured_enable = false
    ```
2.   Add the following parameters to configure `org.apache.synapse.transport.passthru.PassThroughHttpMultiSSLListener` 
     as a custom transport receiver.
    
    ```toml
     [[custom_transport.listener]]
     class="org.apache.synapse.transport.passthru.PassThroughHttpMultiSSLListener"
     protocol = "https"
     parameter.port = 8243
     parameter.non_blocking = true
     
     keystore.location = "repository/resources/security/wso2carbon.jks"
     keystore.type = "JKS"
     keystore.password = "wso2carbon"
     keystore.key_password = "wso2carbon"
     truststore.location = "repository/resources/security/client-truststore.jks"
     truststore.type = "JKS"
     truststore.password = "wso2carbon"
     
     ssl_profile.file_path= "conf/sslprofiles/listenerprofiles.xml"
     ssl_profile.read_interval = 600000
     ```
     
3.   Create the `listenerprofiles.xml` file in the `MI_HOME/conf/sslprofiles` directory and add the following 
     configurations:

    !!! Info
        You can configure the file path for the `listenerprofiles.xml` file as required.

    ```xml
    <parameter name="SSLProfiles">
    <profile>
            <bindAddress>hostname</bindAddress>
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
    
    !!! Note
        It is recommended to configure the hostname as the server when configuring custom SSL profiles. If you want to use the IP address as the server, be sure to map the hostname in the Host file before using the hostname as the server.

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
