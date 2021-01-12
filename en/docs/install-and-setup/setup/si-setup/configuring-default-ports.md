# Configuring Default Ports

This page describes the default ports that are used for each runtime
when the port offset is 0 .


## Common Ports

The following ports are common to all runtimes.

|      |                                                                         |
|------|-------------------------------------------------------------------------|
| 7611 | Thrift TCP port to receive events from clients.                         |
| 7711 | Thrift SSL port for secure transport where the client is authenticated. |
| 9611 | Binary TCP port to receive events from clients.                         |
| 9711 | Binary SSL port for secure transport where the client is authenticated. |

You can offset binary and thrift by configuring the offset parameter in the `<SI_HOME>|<SI_TOOLING_HOME>/conf/server/deployment.yaml` file.
The following is a sample configuration.

```xml
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
    offset: 1
```




## Server runtime

|      |                       |
|------|-----------------------|
| 9090 | HTTP netty transport  |
| 9443 | HTTPS netty transport |


## Streaming Integrator Tooling runtime

|      |                       |
|------|-----------------------|
| 9390 | HTTP netty transport  |
| 9743 | HTTPS netty transport |

## Dashboard runtime

|      |                       |
|------|-----------------------|
| 9290 | HTTP netty transport  |
| 9643 | HTTPS netty transport |

!!! tip
    The following example shows how to overide the default netty port for the Streaming Integrator Tooling by updating the required parameters in the `<SI_TOOLING_HOME>/conf/server/deployment.yaml` file.

    ``` xml
        wso2.transport.http:
         transportProperties:
          listenerConfigurations:
         -
              id: "default"
         port: 9390
            -
              id: "msf4j-https"
         port: 9743
    ```


## Clustering Ports

Ports that are required for clustering deployment:


### Minimum High Availability (HA) Deployment:

#### Server node:

|      |                                                                                                                                                                                 |
|------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| 9090 | HTTP netty transport.                                                                                                                                                           |
| 9090 | Specify the port of the node for the `advertisedPort` parameter in the `liveSync` section. The HTTP netty transport port is considered the default port. |
| 9443 | HTTPS netty transport.                                                                                                                                                          |

### Multi Datacenter High Availability Deployment

Other than the ports used in clustering setups (i.e., a Minimum HA Deployment or a scalable cluster), the following is required:

|      |                                                                                                                                                                                                    |
|------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| 9092 | Ports of the two separate instances of the broker deployed in each data center (e.g., `bootstrap.servers= 'host1:9092, host2:9092'. The default is `9092` where the external kafka servers start.) |
