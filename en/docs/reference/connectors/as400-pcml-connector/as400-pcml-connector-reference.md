# AS400 PCML Connector Reference

The following operations allow you to work with the AS400 PCML Connector. Click an operation name to see parameter details and samples on how to use it.

---

## Initialize the connector

To use the AS400 PCML connector, add the <pcml.init> element in your configuration before carrying out any other pcml operations.

The BigQuery API requires all requests to be authenticated as a user or a service account. For more information, see https://cloud.google.com/bigquery/authentication. See https://developers.google.com/identity/protocols/OAuth2ServiceAccount for information on service account authentication. For more information, see [related BigQuery documentation](https://developers.google.com/identity/protocols/OAuth2WebServer).

??? note "init"
    The init operation is used to initialize the connection to AS400 server.

    **Sample configuration**

    ```xml
    <pcml.init>
        <systemName>AS400_SystemName</systemName>
        <userID>MyUserID</userID>
        <password>MyPassword</password>
    </pcml.init>
    ```

    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>systemName</td>
            <td>The name of the AS400 system that you need to connect to.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>userID</td>
            <td>The user ID to use when connecting to the AS400 system.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>password</td>
            <td>The password to use when connecting to the AS400 system.</td>
            <td>Yes</td>
        </tr>
    </table>
    
    Using an AS400 Connection Pool
    
    The connector also supports creating AS400 connections using a connection pool and this can be declared in the init operation.
    
    init with connection pool declaration

    ```xml
    <pcml.init>
        <systemName>AS400_SystemName</systemName>
        <userID>MyUserID</userID>
        <password>MyPassword</password>
        <pool.poolName>MyConnectionPool</pool.poolName>
        <pool.maxConnections>50</pool.maxConnections>
        <pool.maxInactivity>30000</pool.maxInactivity>
        <pool.maxLifetime>600000</pool.maxLifetime>
        <pool.maxUseCount>-1</pool.maxUseCount>
        <pool.maxUseTime>300000</pool.maxUseTime>
        <pool.runMaintenance>true</pool.runMaintenance>
        <pool.threadUsed>true</pool.threadUsed>
        <pool.cleanupInterval>300000</pool.cleanupInterval>
        <pool.pretestConnections>true</pool.pretestConnections>
    </pcml.init>
    ```

    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>poolName</td>
            <td>The name used to uniquely identify a connection pool.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>maxConnections</td>
            <td>The maximum number of connections.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>maxInactivity</td>
            <td>The maximum time in milliseconds of inactivity before an available connection is closed.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>maxLifetime</td>
            <td>The maximum life in milliseconds for an available connection.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>maxUseCount</td>
            <td>The maximum number of times a connection can be used before it is replaced in the pool.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>maxUseTime</td>
            <td>The maximum time in milliseconds a connection can be in use before it is closed and returned to the pool.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>runMaintenance</td>
            <td>Indicates whether the maintenance thread is used to clean up expired connections.</td>
            <td>Yes</td>
            </tr>
        <tr>
            <td>threadUsed</td>
            <td>Indicates whether threads are used for communicating with the host servers and for running maintenance. The default value is true.</td>
            <td>Yes</td>
            </tr>
        <tr>
            <td>cleanupInterval</td>
            <td>The time interval in milliseconds for running the maintenance daemon. Default value is 300000 milliseconds.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>pretestConnections</td>
            <td>Indicates whether connections are pretested before they are allocated to requesters.</td>
            <td>Yes</td>
        </tr>
    </table>
    
    Each AS400 connection pool is mapped against a given pool name and stored within the ESB memory. A new connection pool will only be created if a connection pool with the given pool name does not exist. If a connection pool with the given pool name does exist, the connector uses the existing pool. Connection pools are stored within a single server node and are not distributed among the cluster. All pool related parameters will not take effect unless  pool.poolName  is defined. When using the connection pools in the integration server of WSO2, the first request that comes into the mediation flow will create the AS400 connection pool and use it. Every subsequent request will use the created connection pool for getting connections. After using a connection from the connection pool, it is mandatory to return the connection back to the pool. The connection can be returned to the pool by using a call operation or by using a returnPool operation.
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      
    Setting Socket Properties for the AS400 Connection
    
    The connector allows setting socket properties for the AS400 connection. These properties can be used depending on the use case and to prevent the AS400 connection timing out.
        
    ```xml
    <pcml.init>
        <systemName>AS400_SystemName</systemName>
        <userID>MyUserID</userID>
        <password>MyPassword</password>
        <socket.keepAlive>false</socket.keepAlive>
        <socket.loginTimeout>10000</socket.loginTimeout>
        <socket.receiveBufferSize>87380</socket.receiveBufferSize>
        <socket.sendBufferSize>16384</socket.sendBufferSize>
        <socket.soLinger>0</socket.soLinger>
        <socket.soTimeout>15000</socket.soTimeout>
        <socket.tcpNoDelay>false</socket.tcpNoDelay>
    </pcml.init> 
    ```
    
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>keepAlive</td>
            <td>Value for SO_KEEPALIVE socket option.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>loginTimeout</td>
            <td>The timeout value in milliseconds when creating a new socket connection.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>receiveBufferSize</td>
            <td>Value in bytes for SO_RCVBUF socket option.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>sendBufferSize</td>
            <td>Value in bytes for SO_SNDBUF socket option.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>soLinger</td>
            <td>Value in seconds for SO_LINGER socket option.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>soTimeout</td>
            <td>Value in milliseconds for SO_TIMEOUT socket option.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>tcpNoDelay</td>
            <td>Value for TCP_NODELAY socket option.</td>
            <td>Yes</td>
        </tr>
    </table>

    All above properties are optional. When using socket properties with AS400 connection pools, the socket properties are applied to the connection pool directly. 


   
---

### call Operation

??? note "call"
    The call operation can be used to access a program in the AS400 server.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>programName</td>
            <td>The name of the program that you need to call.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>pcmlFileLocation</td>
            <td>The location of the file in the registry.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>pcmlInputs</td>
            <td>The XML representation of the input parameters for the program.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>pool.returnPoolName</td>
            <td>The name of the pool to which the AS400 connection should be returned to once the program call is finished.</td>
            <td>Yes.</td>
        </tr>
    </table>

    **Sample configurations**

    ```xml
    <pcml.call>
        <programName>MyProgram</programName>
        <pcmlFileLocation>conf:/pcml/my-pcml-file.pcml</pcmlFileLocation>
        <pcmlInputs xmlns:pcml="pcml">{//pcml:pcmlInputs}</pcmlInputs>
        <pool.returnPoolName>MyConnectionPool</pool.returnPoolName>
    </pcml.call> 
    ```
    Let's assume that there is an RPG program in an AS400 server that performs an addition when two input values are provided. Following will be the PCML source file that is required for this program. This PCML file needs to be stored as /_system/config/pcml/PcmlNumberAddition.pcml resource in the ESB registry.
    
    ```xml
    <pcml version="4.0">
      <program name="Addition" path="/QSYS.LIB/%LIBL%.LIB/ADDITION.PGM">
         <data name="inputValue1" type="int" length="4" usage="input" />
         <data name="inputValue2" type="int" length="4" usage="input" />
         <data name="outputValue" type="int" length="4" usage="output" />
      </program>
    </pcml>
    ```

    **Sample request**

    ```xml
    <p:add xlmns:p="http://services.samples">
      <p:request>
        <p:value1>5</p:value1>
        <p:value2>10</p:value2>
      </p:request>
    </p:add>
    ```

    **Sample response**

    ```xml
    <<?xml version="1.0" ?>
    <xpcml version="6.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation='xpcml.xsd' >
        <program name="Addition" path="/QSYS.LIB/%LIBL%.LIB/ADDITION.PGM">
            <parameterList>
                <intParm name="inputValue1" passDirection="in">5</intParm>
                <intParm name="inputValue2" passDirection="in">10</intParm>
                <intParm name="outputValue" passDirection="out">15<intParm>
            </parameterList>
        </program>
    </xpcml>
    ```
    
    
---  
    
### returnPool Operation

??? note "returnPool"
    The returnPool operation can be used to return the AS400 instance from the mediation flow back into the connection pool.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>returnPoolName</td>
            <td> The name of the pool which the AS400 connection needs to be returned to.</td>
            <td>Yes.</td>
        </tr>
    </table>
    
    ```xml
    <pcml.returnPool>
        <pool.returnPoolName>MyConnectionPool</pool.returnPoolName>
    </pcml.returnPool>
    ```
    

---  

### trace Operation

??? note "trace"
    The trace operation can be used to enable/disable the trace logs that are generated by JTOpen library. The Trace feature of JTOpen library provides several levels of logging and each of these logging levels can be enabled/disabled using this operation. The operation also allows enabling/disabling all log levels at once. This operation is meant for development and debugging purposes only. All log levels are disabled by default. The generated logs will be available in the <ESB_HOME>/repository/logs/pcml-connector-logs.log  file. The location of the log files can be changed only during startup by setting the  com.ibm.as400.access.Trace.file  system property.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>all</td>
            <td>Whether all trace logs needs to be enabled/disabled.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>conversion</td>
            <td>Whether conversion trace logs needs to be enabled/disabled.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>all</td>
            <td>Whether all trace logs needs to be enabled/disabled.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>conversion</td>
            <td>Whether conversion trace logs needs to be enabled/disabled.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>datastream</td>
            <td>Whether datastream logs needs to be enabled/disabled.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>diagnostics</td>
            <td>Whether diagnostic trace logs needs to be enabled/disabled.</td>
            <td>Yes.</td>
        </tr>
        <tr>
            <td>error</td>
            <td>Whether error trace logs needs to be enabled/disabled.</td>
            <td>Yes.</td>
            </tr>
        <tr>
            <td>information</td>
            <td>Whether information logs needs to be enabled/disabled.</td>
            <td>Yes.</td>
            </tr>
        <tr>
            <td>pcml</td>
            <td>Whether PCML trace logs needs to be enabled/disabled.</td>
            <td>Yes.</td>
            </tr>
        <tr>
            <td>warning</td>
            <td>Whether warning trace logs needs to be enabled/disabled.</td>
            <td>Yes.</td>
            </tr>
        <tr>
            <td>proxy</td>
            <td>Whether proxy logs needs to be enabled/disabled.</td>
            <td>Yes.</td>
        <tr>
    </table>
    
     ```xml
     <pcml.trace>
         <conversion>true</conversion>
         <datastream>true</datastream>
         <diagnostics>false</diagnostics>
         <error>true</error>
         <information>true</information>
         <pcml>true</pcml>
         <warning>true</warning>
         <proxy>false</proxy>
     </pcml.trace> 
     ```
    Important!
    
    Enabling and disabling the log levels will effect all AS400 PCML connector based operations within the ESB instance. If there are two proxy services within ESB that use the connector, and trace logs for a specific level are enabled for one of them, the same level of logs will be enabled for the other proxy service as well.
    
    Trace Operation is not recommended for Production Environments. Enabling trace logs is not recommended for production environments as using the trace operation will generate logs in the log file but this file does not get cleared.