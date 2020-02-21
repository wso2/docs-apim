# Changing the Default Ports with Offset

When you run multiple WSO2 products/clusters or multiple instances of the same product on the same server or virtual machines (VMs), you must change their default ports with an `offset` value to avoid port conflicts. An offset defines the number by which all ports in the runtime (e.g., HTTP/S ports) will be increased. 

For example, if the default HTTP port is 9763 and the offset is 1, the effective HTTP port will change to 9764. For each additional WSO2 product instance running on the same machine, you set the port offset to a unique value. The default port offset value of any WSO2 product is `0`.

There are two ways to set an offset to a port.

-   [Configuring the port offset](#configuring-the-port-offset)
-   [Passing the port offset during server startup](#passing-the-port-offset-during-server-startup)

## Configuring the port offset

1. [Stop the server]({{base_path}}/InstallAndSetup/InstallationGuide/running-the-product/#stopping-the-server) if it is already running

2.  Open `<APIM_HOME>/repository/conf/deployment.toml` file.

3.  Uncomment `offset` element under `[server]` configuration and set the offset value.


    ```toml tab="Format"
    [server]
    offset=<offset_value>
    ```
   
    ```toml  tab="Example"
    [server]
    offset=1
    ```

4. [Restart the server]({{base_path}}/InstallAndSetup/InstallationGuide/running-the-product/).

## Passing the port offset during server startup

1.  [Stop the server]({{base_path}}/InstallAndSetup/InstallationGuide/running-the-product/#stopping-the-server) if it is already running

2.  Restart the server with `-DportOffset` system property.

    - Linux/Mac OS
    
        ```toml tab="Format"
        ./wso2server.sh -DportOffset=<offset_value>
        ```
        
        ```toml tab="Example"
        ./wso2server.sh -DportOffset=3
        ```
        
    - Windows
    
        ```toml tab="Format"
        wso2server.bat -DportOffset=<offset_value>
        ```
        
        ```toml tab="Example"
        wso2server.bat -DportOffset=3
        ```

When you offset the server's port, it automatically changes all ports it uses. 

For the list of all default ports opened in WSO2 API Manager, see [Default Product Ports]({{base_path}}/Administer/ProductConfigurations/default-product-ports/) .

