# Configuring Cluster Coordination

Multiple WSO2 SI nodes can be configured to work together by configuring
a cluster coordination strategy that is used in various deployments such
as the <a target="_blank" href="minimum-ha-deployment">Minimum High Available(HA) Deployment</a>
and <a target="_blank" href="scalable-ha-deployment">Scalable High Available(HA) Deployment</a>
. At present, cluster coordination is supported via an RDBMS instance
using and RDBMS coordination strategy. Support for cluster coordination
via a Zookeeper instance will be supported in the near future.

At any given time, there is a leader in an SI cluster that is
arbitrarily selected among the members of the cluster. The RDBMS
coordination strategy that is used for cluster coordination works on the
concept of heartbeats where the members of the cluster periodically send
heartbeat signals via the datasource to the leader of the cluster. If
the leader node does not detect a pre configured consecutive number of
heartbeats from a specific node, the relevant node is removed from the
cluster. Similarly, if the leader node fails to update its heartbeat,
the cluster re-elects a new leader.

### Prerequisites

In order to configure a cluster, the following prerequisites must be
completed:

-   A minimum of two binary packs of WSO2 SI must be available.
-   A working RDBMS instance must be available to be shared among the
    nodes of the cluster.
    

### Configuring the Cluster with the RDBMS coordination strategy

To configure a cluster for several nodes, the cluster.config section of
the `         <SI_HOME>/conf/server/deployment.yaml        `
should be configured for **all the nodes** as follows:

| Parameter                                                        | Purpose                                                                                                                                                                                                                                                                              | Sample Values                                                                                  |
|------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------|
| `             enabled            `                               | Set this value to `             true            ` to enable cluster coordination for the node.                                                                                                                                                                                       | `             true/false            `                                                          |
| `             groupId            `                               | The group ID is used to identify the cluster to which the node belongs. Nodes that belong to the same cluster must be configured with the same group ID.                                                                                                                             | `             group-1            `                                                             |
| `             coordinationStrategyClass            `             | The clustering class to be used.                                                                                                                                                                                                                                                     | `             org.wso2.carbon.cluster.coordinator.rdbms.RDBMSCoordinationStrategy            ` |
| `             strategyConfig > datasource            `           | The shared datasource to be used in the cluster. The datasource specified must be properly configured in the `             deployment.yaml            ` file. For detailed instructions to configure a datasource, see [Configuring Datasources](_Configuring_Datasources_) .        | `             WSO2_CARBON_DB            `                                                      |
| `             strategyConfig > heartbeatInterval            `    | This value defines the time interval in milliseconds between heartbeat pulses sent by nodes to indicate that they are still alive within the cluster.                                                                                                                                | `             1000            `                                                                |
| `             strategyConfig > heartbeatMaxRetry            `    | The number of times the heartbeat pulse can be unavailable until a node is identified as unresponsive. If a node fails to send its heartbeat pulse to the leader of the cluster after a number of retries equal to the number specified here, that node is removed from the cluster. | `             2            `                                                                   |
| `             strategyConfig > eventPollingInterval            ` | The time interval in millseconds at which a node listens to identify the changes happening within the cluster. The changes may include a new node joining the cluster, a node being removed from the cluster and the coordinator changed event.                                      | `             1000            `                                                                |

  

Following is a sample segment of the configurations needed for RDBMS
coordination in the deployment.yaml

**Sample deployment.yaml segment**

``` java
    cluster.config:
      enabled: true
      groupId:  <GROUP ID>
      coordinationStrategyClass: org.wso2.carbon.cluster.coordinator.rdbms.RDBMSCoordinationStrategy
      strategyConfig:
        datasource: <DATASOURCE NAME>
        heartbeatInterval: 5000
        heartbeatMaxRetry: 5
        eventPollingInterval: 5000
```
