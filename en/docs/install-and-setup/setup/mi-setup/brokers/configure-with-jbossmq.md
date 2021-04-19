# Connecting to JBossMQ

This section describes how to configure WSO2 Micro Integrator to connect with [JBossMQ](https://community.jboss.org/wiki/JBossMQ). The default JMS provider in JBoss Application Server 4.2. JBossMQ was replaced by [JBoss Messaging](http://www.jboss.org/jbossmessaging) in JBoss Application Server 5.0.

To configure the JMS transport with JBossMQ:

1.  Copy the following client libraries to the `MI_HOME/lib` directory.  
    -   `JBOSS_HOME/lib/jboss­system.jar`
    -   `JBOSS_HOME/client/jbossall­client.jar`

2.  If you want the Micro Integrator to receive messages from an JBossMQ instance, or to send messages to an ActiveMQ instance, you need to update the deployment.toml file with the relevant connection parameters.

    Add the following configurations to enable the JMS sender and listener with JBossMQ connection parameters.
    
    ```toml
    [transport.jms]
    sender_enable = true
    
    [[transport.jms.listener]]
    name = "MyQueueConnectionFactory"
    parameter.initial_naming_factory = "org.jnp.interfaces.NamingContextFactory"
    parameter.provider_url = "jnp://localhost:1099"
    parameter.connection_factory_name = "/ConnectionFactory"
    parameter.destination = "queue/susaQueue"
    parameter.'java.naming.factory.url.pkgs' = "org.jnp.interfaces:org.jboss.naming"
    ```
    !!! Info
        For details on the JMS configuration parameters used in the code segments above, see [JMS connection factory parameters]({{base_path}}/reference/config-catalog-mi/#jms-transport-listener-non-blocking-mode).

4.  Start WSO2 Micro Integrator and ensure that the logs print messages indicating that the JMS listener and sender are started, and that the JMS transport is initialized.
