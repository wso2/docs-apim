# Changing the Default Ports with Offset

When you run multiple runtimes on the same server or virtual machines (VMs), you must change their default ports with an `offset` value to avoid port conflicts. An offset defines the number by which all ports in the runtime (e.g., HTTP/S ports) are increased. 

For example, if the default HTTP port is 9763 and the offset is 1, the effective HTTP port changes to 9764. For each additional WSO2 product instance running on the same machine, you set the port offset to a unique value.

There are two ways to set an offset to a port: Update the server configurations, or pass the port offset during server startup. See the instructions given below to port offset the three runtimes of WSO2 API Manager.

## Before you begin

See the complete list of [default ports]({{base_path}}/install-and-setup/setup/reference/default-product-ports) in all the API Manager components.

Note that most of the **runtime ports** change automatically based on the offset you specify here.

## Changing the default API-M ports

The default port offset in the WSO2 API-M runtime is `0`. Use one of the following two methods to apply an offset to the API-M runtime.

#### Update the server configurations

1. Stop the API-M server if it is already running.

2.  Open the `<API-M-HOME>/repository/conf/deployment.toml` file.

3.  Uncomment the `offset` parameter under `[server]` and set the offset value.


    === "Format"
        ```toml
        [server]
        offset=<offset_value>
        ```

    === "Example"
        ```toml
        [server]
        offset=1
        ```

4. [Restart the server]({{base_path}}/install-and-setup/install/installing-the-product/running-the-api-m/).

#### Pass the port offset during server startup

1.  Stop the API-M server if it is already running.

2.  Restart the server with the `-DportOffset` system property.

    - Linux/Mac OS
    
        === "Format"
            ```toml
            ./api-manager.sh -DportOffset=<offset_value>
            ```
        
        === "Example"
            ```toml
            ./api-manager.sh -DportOffset=3
            ```
        
    - Windows
    
        === "Format"
            ```toml
            api-manager.bat -DportOffset=<offset_value>
            ```
        
        === "Example"
            ```toml
            api-manager.bat -DportOffset=3
            ```

When you offset the server's port, it automatically changes all ports. 

## What's Next?

You need to restart the server for these changes to take effect.