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


    ```toml tab="Format"
    [server]
    offset=<offset_value>
    ```

    ```toml tab="Example"
    [server]
    offset=1
    ```

4. [Restart the server]({{base_path}}/install-and-setup/install/installing-the-product/running-the-api-m/).

#### Pass the port offset during server startup

1.  Stop the API-M server if it is already running.

2.  Restart the server with the `-DportOffset` system property.

    - Linux/Mac OS
    
        ```toml tab="Format"
        ./api-manager.sh -DportOffset=<offset_value>
        ```
        
        ```toml tab="Example"
        ./api-manager.sh -DportOffset=3
        ```
        
    - Windows
    
        ```toml tab="Format"
        api-manager.bat -DportOffset=<offset_value>
        ```
        
        ```toml tab="Example"
        api-manager.bat -DportOffset=3
        ```

When you offset the server's port, it automatically changes all ports. 

## Changing the default MI ports

The default port offset in the WSO2 Micro Integrator runtime is `10`. Use one of the following two methods to apply an offset to the Micro Integrator runtime.

!!! Tip
	-	The internal offset of 10 is overriden by this manual offset. That is, if the manual offset is 3, the default ports will change as follows:
		- `8290` -> `8283` (8290 - 10 + 3)
		- `8253` -> `8246` (8253 - 10 + 3)
		- `9164` -> `9157` (9164 - 10 + 3)
	-	Note that if you manually set an offset of 10 using the following method, you will get the same default ports.

#### Update the server configurations

1. Stop the MI server if it is already running.

2.  Open the `<MI_HOME>/conf/deployment.toml` file.

3.  Uncomment the `offset` parameter under `[server]` and set the offset value.

    ```toml tab="Format"
    [server]
    offset=<offset_value>
    ```

    ```toml  tab="Example"
    [server]
    offset = 3
    ```

4. [Restart the server]({{base_path}}/install-and-setup/install/installing-the-product/running-the-mi).

#### Pass the port offset during server startup

1.  Stop the MI server if it is already running.

2.  Restart the server with the `-DportOffset` system property.

    - Linux/Mac OS
    
        ```toml tab="Format"
        ./micro-integrator.sh -DportOffset=<offset_value>
        ```
        
        ```toml tab="Example"
        ./micro-integrator.sh -DportOffset=3
        ```
        
    - Windows
    
        ```toml tab="Format"
        micro-integrator.bat -DportOffset=<offset_value>
        ```
        
        ```toml tab="Example"
        micro-integrator.bat -DportOffset=3
        ```

#### Changing the default EI Analytics ports

If required, you can manually change the HTTP/HTTPS ports in the `deployment.yaml` file (stored in `EI_ANALYTICS_HOME/conf/server` folder) as shown below.

!!! Note
    With the default internal port offset, the effective port is <code>https_port + 1</code>.

```yaml tab='HTTPS Port'
wso2.transport.http:            
listenerConfigurations:
-
	id: "msf4j-https"
	host: "0.0.0.0"
	port: https_port
	scheme: https
```

```yaml tab='HTTP Port'
wso2.transport.http:
listenerConfigurations:
-
  id: "default"
  host: "0.0.0.0"
  port: http_port
```

## Changing the default SI ports

The default port offset in the WSO2 Streaming Integrator (SI) runtime and the SI Tooling runtime are `0` and `3` respectively. Setting a port offset changes the **thrift**, **binary**, and **management** [ports of the SI runtimes]({{base_path}}/install-and-setup/setup/reference/default-product-ports/#streaming-integrator-ports).

Follow the steps given below.

1.  Open the `deployment.toml` file of the SI runtime or the SI Tooling runtime (stored in the `<SI_HOME>|<SI_TOOLING_HOME>/conf/server/deployment.yaml` directory). 

2.  Update the port offset parameters in the following configurations:

    ```yaml tab="SI runtime"
    # Carbon Configuration Parameters
    wso2.carbon:
        # value to uniquely identify a server
    id: wso2-si
        # server name
    name: WSO2 Streaming Integrator
        # server type
    type: wso2-si
        # ports used by this server
    ports:
        # port offset
        offset: 0
    ```

    ```yaml tab="SI Tooling runtime"
      # Carbon Configuration Parameters
    wso2.carbon:
        # value to uniquely identify a server
    id: wso2-si
        # server name
    name: WSO2 Streaming Integrator Tooling
        # ports used by this server
    ports:
        # port offset
        offset: 3
    ```

## What's Next?

You need to restart the server for these changes to take effect.