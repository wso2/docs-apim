# Changing the Hostname

By default, WSO2 products identify the hostname of the current machine through the Java API. However, it is recommended to configure the hostname by setting the hostname parameter in the `deployment.toml` file of the WSO2 Micro Integrator runtime.

## Changing the Micro Integrator hostname

Follow the steps given below.

1.  Open the `<MI-HOME>/conf/deployment.toml` file.
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
