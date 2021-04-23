# Changing the Hostname

By default, WSO2 products identify the hostname of the current machine through the Java API. However, it is recommended to configure the hostname by setting the hostname parameter in the `deployment.toml` file of each runtime (API-M or Micro Integrator).

## Changing the API-M hostname

Follow the steps given below.

1. Update the `deployment.toml` file.

    1. Open the `<API-M_HOME>/repository/conf/deployment.toml` file 
    
    2. Define the `hostname` attribute under server configurations as shown below.

        ``` format tab="Format"
        [server]
        hostname = "{hostname}"
        ```
    
        ``` example tab="Example"
        [server]
        hostname = "am.dev.wso2.com"
        ```
    
        `{hostname}` - Hostname or IP address of the machine hosting this server. This will become part of the End Point Reference of the services deployed on this server instance.
    
    3. Configure the Developer Portal URL, which is used to access the Developer Portal via the Publisher. 

        Uncomment the following configuration and define the `hostname`.

        ```
        [apim.devportal]
        url = "https://<hostname>:${mgt.transport.https.port}/devportal"
        ```

2.  Generate a key store, export the public certificate from the keystore, and import that certificate to the `client­-truststore.jks` file.
    
     For more information, see [Creating New Keystores]({{base_path}}/administer/product-security/configuring-keystores/keystore-basics/creating-new-keystores/).

3.  Restart the server.

    !!! warning

        After you change the hostname, if you encounter login failures when trying to access the API Publisher and API Developer Portal with the error `Registered callback does not match with the provided url`, see ['Registered callback does not match with the provided url' error]({{base_path}}/troubleshooting/troubleshooting-invalid-callback-error) in the Troubleshooting guide.

## Changing the Micro Integrator hostname

Follow the steps given below.

1.  Open the `<MI-HOME>/conf/deployment.toml` file 
2.  Define the `hostname` attribute under server configuration as shown below.

    ``` format tab="Format"
    [server]
    hostname = "{hostname}"
    ```

    ``` example tab="Example"
    [server]
    hostname="localhost"
    ```

To configure hostnames for WSDLs and endpoints, it is recommended to add the following parameter for the transport listener in the `deployment.toml` file.

```toml
[transport.http]
listener.wsdl_epr_prefix="$ref{server.hostname}"
```

