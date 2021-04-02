# Tuning the JMS Transport

The Java Message Service (JMS) transport of the WSO2 Micro Integrator allows you to easily send and receive messages to queues and topics of any JMS service that implements the JMS specification. The following sections describe how you can tune the JMS transport of the Micro Integrator for better performance.

!!! Info
    See the [JMS troubleshooting guide]({{base_path}}/troubleshooting/troubleshooting-jms) for more topics related to tuning JMS use cases.

## Increasing the maximum JMS proxies

If you create several JMS proxy services in the Micro Integrator, you will see a message similar to the following:

```bash
WARN - JMSListener Polling tasks on destination : JMStoHTTPStockQuoteProxy18 of type queue for service JMStoHTTPStockQuoteProxy18 have not yet started after 3 seconds ..
```

This issue occurs when you do not have enough threads available to consume messages from JMS queues. The maximum number of concurrent consumers (that is, the number of JMS proxies) that can be deployed is limited by the base transport worker pool that is used by the [JMS transport]({{base_path}}/reference/synapse-properties/transport-parameters/jms-transport-parameters). You can configure the size of this worker pool using the system properties `lst_t_core` and `lst_t_max`. Note that increasing these values will also increase the memory consumption, because the worker pool will allocate more resources.

Similarly, you can configure the current number and the anticipated number of outbound JMS proxies using the system properties `snd_t_core` and `snd_t_max`.

To adjust the values of these properties, you can modify the server startup script (requires more memory), or create a `jms.properties` file. Both approaches are described below.

### Using the server startup script

1.  Open the product startup script (`micro-integrator.sh` or `micro-integrator.bat` file) in your `MI_HOME/bin` directory for editing.
2.  Change the values of the properties as follows:

    !!! Info
        If you do not have the following properties in the `micro-integrator.sh` or `micro-integrator.bat` files, add them with the given values.
        -   `-Dlst_t_core=200`
        The defined values is applied as a System Property.
        -   `-Dlst_t_max=250`
        -   `-Dsnd_t_core=200`
        -   `-Dsnd_t_max=250`

### Using the jms.properties file

1.  Create a file named `jms.properties` with the following properties:
    -   `lst_t_core=200`
    -   `lst_t_max=250`
    -   `snd_t_core=200`
    -   `snd_t_max=250`

    !!! note "Determine a suitable value for lst_t_core and snd_t_core"
        Make sure that the above mentioned recommended values per server satisfy the following criterion.

        ```
        lst_t_core > Total number of consumers + 20

        lst_t_core < lst_t_max

        snd_t_core > Total number of consumers + 20

        snd_t_core < snd_t_max
        ```

        - `Total number of consumers = transport.jms.MaxConcurrentConsumers x Number of JMS proxies`
        - 20 threads have been added as a buffer.
        - Default value for `lst_t_core` and `snd_t_core` is 20.
        - If you do not specify a value for `lst_t_core` and `snd_t_core`, the default values are applied.

        !!! warning
            If the above values that you derived exceed the recommended values, make sure that your server has the necessary resources to handle the defined thread pool size efficiently.

2.  Create a directory called `conf` under your `MI_HOME` directory and save the file in this directory.

## Tuning the JMS Listener

To increase the JMS listener performance, add the following parameters to the [JMS listener configuration]({{base_path}}/reference/config-catalog-mi/#jms-transport-listener) in the `deployment.toml` file (stored in the `MI_HOME/conf`):

```toml
[[transport.jms.listener]]
parameter.concurrent_consumer = 1
parameter.max_concurrent_consumer = 1
parameter.cache_level = "consumer"
```

The parameters are described below.

-  `parameter.concurrent_consumer`: The concurrent threads that need to be started in order to consume messages (when polling). 

    If the JMS queue fills up at a high rate and the queue is long, you can improve the performance by increasing the number of concurrent consumers. If there are more messages to be consumed while the running threads are busy, then additional threads are started until the total number of threads reache the value of the maximum number of concurrent consumers (i.e., `MaxConcurrentConsumers`). 

    !!! Info
        -   The maximum number of concurrent consumers (or the number of JMS proxies) that can be deployed is limited by the base transport worker pool that is used by the JMS transport. The size of this worker pool can be configured via the system property `lst_t_core` and `lst_t_max` as described above. The number of concurrent producers are generally limited by the Synapse core worker pool.
        -   Concurrent consumers are only applicable to JMS queues and not for JMS topics.
        -   If you set the `locked` property to `true`, the JMS proxy creates only one listener thread at a given time. If you set it to `false`, it creates multiple listener threads from a single proxy to consume messages concurrently.

-  `parameter.cache_level`: The possible values for the cache level are `none` , `auto` , `connection`, `session` and `consumer`. Out of the possible values, `consumer` is the highest level that provides maximum performance.

After adding concurrency consumers and cache level, your complete configuration would be as follows:

```toml
[[transport.jms.listener]]
name = "myQueueConnectionFactory"
parameter.initial_naming_factory = "org.apache.activemq.jndi.ActiveMQInitialContextFactory"
parameter.provider_url = "tcp://localhost:61616"
parameter.connection_factory_name = "QueueConnectionFactory"
parameter.connection_factory_type = "queue"
parameter.cache_level = "consumer"
parameter.concurrent_consumer = 50
parameter.max_concurrent_consumer = 50
```
<!--
```xml
<transportReceiver name="jms" class="org.apache.axis2.transport.jms.JMSListener">
....
<parameter name="myQueueConnectionFactory" locked="false">
<parameter name="java.naming.factory.initial" locked="false">org.apache.activemq.jndi.ActiveMQInitialContextFactory</parameter>
<parameter name="java.naming.provider.url" locked="false">tcp://localhost:61616</parameter>
<parameter name="transport.jms.ConnectionFactoryJNDIName" locked="false">QueueConnectionFactory</parameter>
<parameter name="transport.jms.ConnectionFactoryType" locked="false">queue</parameter>
<parameter name="transport.jms.ConcurrentConsumers" locked="false">50</parameter>
<parameter name="transport.jms.MaxConcurrentConsumers" locked="false">50</parameter>
<parameter name="transport.jms.CacheLevel">consumer</parameter>
</parameter>
….
</transportReceiver>
```
-->

## Tuning the JMS Sender

To increase the JMS sender performance, add the following parameters to the [JMS listener configuration]({{base_path}}/reference/config-catalog-mi/#jms-transport-sender) in the `deployment.toml` file (stored in the `MI_HOME/conf`):

```toml
[[transport.jms.sender]]
parameter.cache_level = "producer"
```

The possible values for the `parameter.cache_level` are `none`, `auto`, `connection`, `session` and `producer`. Out of the possible values, `producer` is the highest level that provides maximum performance.
    
!!! Info
    -   When using `producer` as the cache level, be sure to add the JMS destination parameter to avoid the following error:
        ```bash       
        INFO - AxisEngine [MessageContext: logID=2eabe85aeeb3bb62c26bb46d21b11b087ebf1e5e0b350839] JMSCC0029: A destination must be specified when sending from  this   producer.
        ```
    -   By default, Axis2 spawns a new thread to handle each outgoing message. To change this behavior, you need to remove the `ClientApiNonBlocking` property from the message when sending messages. Removal of this property is vital when queuing transports like JMS are involved. Add the following parameter to your mediation configuration to remove `ClientApiNonBlocking` when sending messages via JMS:

        ```xml
        <property name="ClientApiNonBlocking" action="remove" scope="axis2"/>
        ```