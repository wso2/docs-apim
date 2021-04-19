# Configuring Database and File System State Persistence

This section explains how to prevent the loss of data that can result
from a system failure by persisting the state of WSO2 SI periodically
either into a database system or into the file system.

### Prerequisites

Before configuring RDBMS database persistence, the following prerequisites
must be completed.

-   One or more Siddhi Applications must be running in the WSO2 SI
    server.
-   A working RDBMS instance that can be used for data persistence must
    exist.
-   The requirements of the datasource must be already defined.

-   Database persistence involves updating the databases connected to
    WSO2 Streaming Integrator with the latest information relating to the
    events that are being processed by WSO2 SI at a given time.

### Configuring database system persistence

The supported databases are H2, MySQL, Postgres, MSSQL and Oracle. The
relevant jdbc driver jar should be downloaded and added to the
`<SI_HOME>/lib` directory to prior to using database
system persistence.

To configure periodic data persistence, update the
`<SI_HOME>/conf/server/deployment.yaml` file under
`state.persistence` as follows:

<table>
<thead>
<tr class="header">
<th>Parameter</th>
<th>Purpose</th>
<th>Required Value</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>enabled</code></td>
<td>This enables data persistence.</td>
<td><code>true</code></td>
</tr>
<tr class="even">
<td><code>intervalInMin</code></td>
<td>The time interval in minutes that defines the interval in which state of Siddhi applications should be persisted</td>
<td>1</td>
</tr>
<tr class="odd">
<td><code>revisionsToKeep</code></td>
<td>The number of revisions to keep in the system. When a new persist takes place, the old revisions are removed.</td>
<td>3</td>
</tr>
<tr class="even">
<td><code>persistenceStore</code></td>
<td>The persistence store .</td>
<td><code>org.wso2.carbon.streaming.integrator.core.persistence.DBPersistenceStore</code></td>
</tr>
<tr class="odd">
<td><code>config &gt; datasource</code></td>
<td>The datasource to be used in persisting the state. The provided datasource should be properly defined in the deployment.yaml. For detailed instructions of how to configure a datasource, see <a href="_Configuring_Datasources_">Configuring Datasources</a> .</td>
<td><pre><code>WSO2_PERSISTENCE_DB (Datasource with this name should be defined in wso2.datasources)</code></pre></td>
</tr>
<tr class="even">
<td><code>config &gt; table</code></td>
<td>The table that should be created and used for the persisting of the state.</td>
<td><pre><code>PERSISTENCE_TABLE</code></pre></td>
</tr>
</tbody>
</table>

The following is a sample segment of the required configurations in the
`<SI_HOME>/conf/server/deployment.yaml` file to
configure file system persistence.

**Sample deployment.yaml segment**

``` xml
    state.persistence:
      enabled: true
      intervalInMin: 1
      revisionsToKeep: 3
      persistenceStore: org.wso2.carbon.streaming.integrator.core.persistence.DBPersistenceStore
      config:
        datasource: <DATASOURCE NAME>   # A datasource with this name should be defined in wso2.datasources namespace
        table: <TABLE NAME>
```

  

### Configuring file system persistence

This section explains how to persist the states of Siddhi applications
during a required time interval in the file system in order to maintain
back-ups. To configure state persistence, update the
`<SI_HOME>/conf/server/deployment.yaml` file under
`state.persistence` as follows:

<table>
<thead>
<tr class="header">
<th>Parameter</th>
<th>Purpose</th>
<th>Required Value</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>enabled</code></td>
<td>This enables data persistence.</td>
<td><code>true</code></td>
</tr>
<tr class="even">
<td><code>intervalInMin</code></td>
<td>The time interval in minutes that defines the interval in which state of Siddhi applications should be persisted<br />
</td>
<td><code>1</code></td>
</tr>
<tr class="odd">
<td><code>revisionsToKeep</code></td>
<td>The number of revisions to keep in the system. When a new persist takes place, the old revisions are removed.</td>
<td><code>3</code></td>
</tr>
<tr class="even">
<td><code>persistenceStore</code></td>
<td>The persistence store.</td>
<td><pre><code>org.wso2.carbon.streaming.integrator.core.persistence.FileSystemPersistenceStore</code></pre></td>
</tr>
<tr class="odd">
<td><code>config &gt; location</code></td>
<td>A fully qualified folder location to where the revision files should be persisted.</td>
<td><pre><code>siddhi-app-persistence</code></pre></td>
</tr>
</tbody>
</table>

  

The following is a sample segment of the required configurations in the
`<SI_HOME>/conf/server/deployment.yaml` file to
configure file system persistence.

**Sample deployment.yaml segment**

``` java
    state.persistence:
      enabled: true
      intervalInMin: 1
      revisionsToKeep: 2
      persistenceStore: org.wso2.carbon.streaming.integrator.core.persistence.FileSystemPersistenceStore
      config:
        location: siddhi-app-persistence
```
