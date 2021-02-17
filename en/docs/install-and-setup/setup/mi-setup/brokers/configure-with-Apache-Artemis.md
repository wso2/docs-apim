# Connecting to Apache Artemis

This section describes how to configure WSO2 Micro Integrator to connect with Apache Artemis (version 2.6.1).

Follow the instructions below to set up and configure.

1.  Download and setup [Apache Artemis](https://activemq.apache.org/artemis/).
2.  Download and install WSO2 Micro Integrator.
3.  If you want the Micro Integrator to receive messages from an Artemis instance, or to send messages to an Artemis instance, you need to update the deployment.toml file with the relevant connection parameters.

    - Add the following configurations to enable the JMS listener with ActiveMQ connection parameters.
        ```toml
        [[transport.jms.listener]]
        name = "myTopicConnectionFactory"
        parameter.initial_naming_factory = "org.apache.activemq.artemis.jndi.ActiveMQInitialContextFactory"
        parameter.provider_url = "tcp://localhost:61616"
        parameter.connection_factory_name = "TopicConnectionFactory"
        parameter.connection_factory_type = "topic"

        [[transport.jms.listener]]
        name = "myQueueConnectionFactory"
        parameter.initial_naming_factory = "org.apache.activemq.artemis.jndi.ActiveMQInitialContextFactory"
        parameter.provider_url = "tcp://localhost:61616"
        parameter.connection_factory_name = "QueueConnectionFactory"
        parameter.connection_factory_type = "queue"

        [[transport.jms.listener]]
        name = "default"
        parameter.initial_naming_factory = "org.apache.activemq.artemis.jndi.ActiveMQInitialContextFactory"
        parameter.provider_url = "tcp://localhost:61616"
        parameter.connection_factory_name = "QueueConnectionFactory"
        parameter.connection_factory_type = "queue"
        ```

    - Add the following configurations to enable the ActiveMQ JMS sender with ActiveMQ connection parameters.
        ```toml
        [[transport.jms.sender]]
        name = "commonJmsSenderConnectionFactory"
        parameter.initial_naming_factory = "org.apache.activemq.artemis.jndi.ActiveMQInitialContextFactory"
        parameter.provider_url = "tcp://localhost:61616"
        parameter.connection_factory_name = "QueueConnectionFactory"
        parameter.connection_factory_type = "queue"

        [[transport.jms.sender]]
        name = "commonTopicPublisherConnectionFactory"
        parameter.initial_naming_factory = "org.apache.activemq.artemis.jndi.ActiveMQInitialContextFactory"
        parameter.provider_url = "tcp://localhost:61616"
        parameter.connection_factory_name = "TopicConnectionFactory"
        parameter.connection_factory_type = "topic"
        ```
4.  Remove any existing Apache ActiveMQ client JAR files from the `MI_HOME/dropins/` and `MI_HOME/lib/` directories.  
5.  Download the [artemis-jms-client-all-2.6.1.jar](https://docs.wso2.com/download/attachments/119130330/artemis-jms-client-all-2.6.1.jar?version=1&modificationDate=1558091414000&api=v2) file and copy it to the `MI_HOME/lib/` directory.  
6.  Remove the below line from the `MI_HOME/conf/etc/launch.ini` file.  

    ```text
    javax.jms,\
    ```
7.  Start Apache Artemis. For instructions, see the [Apache Artemis Documentation](https://activemq.apache.org/artemis/docs.html).
8.  Start the Micro Integrator.

Now you have configured instances of Apache Artemis and WSO2 Micro Integrator.