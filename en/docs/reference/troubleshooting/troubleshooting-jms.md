# Troubleshooting JMS scenarios

The following sections will help you to resolve common problems encountered in JMS integration scenarios with WSO2 Micro Integrator.

## Exceptions related to client libraries

You may encounter `ClassNotFoundExceptions` and `NoClassDefFoundExceptions` if you have not deployed all the required client libraries. The missing class should be available in one of the jar files deployed in `MI_HOME/lib` directory. WSO2 Micro Integrator comes with geronimo-jms library, which contains the javax.jms packages. Therefore, you do not have to deploy them again.

## HTTP header conversion

When forwarding HTTP traffic to a JMS queue using WSO2 Micro Integrator, you might get an error similar to the one given below.

```bash
ERROR JMSSender Error creating a JMS message from the axis message context
javax.jms.MessageFormatException: MQJMS1058: Invalid message property name: Content-Type
```

This exception is specific to the JMS broker used, and is  thrown by the JMS client libraries used to connect with the JMS broker.  

The incoming HTTP message contains a bunch of HTTP headers that have the ‘-‘ character. Some noticeable examples are **Content-length** and **Transfer-encoding** headers. When the Micro Integrator forwards a message over JMS, it sets the headers of the incoming message to the outgoing JMS message as JMS properties. But, according to the JMS specification, the ‘-‘ character is prohibited in JMS property names. Some JMS brokers like ActiveMQ do not check this specifically, in which case there will not be any issues. But some brokers do and they throw exceptions.

The solution is to simply remove the problematic HTTP headers from the message before delivering it over JMS. You can use the property mediator as follows to achieve this:

```xml
<property action="remove" name="Content-Length" scope="transport">
<property action="remove" name="Accept-Encoding" scope="transport">
<property action="remove" name="User-Agent" scope="transport">
<property action="remove" name="Content-Type" scope="transport">
```

Alternatively, you can use the `transport.jms.MessagePropertyHyphens` parameter to handle hyphenated properties, instead of handling them as described
above.

## JMS property data type mismatch

When WSO2 Micro Integrator attempts to forward a message over JMS, there are instances that the client libraries throw an exception saying the data type of a particular message property is invalid.  

This problem occurs when the developer uses the property mediator to manipulate property values set on the message. Certain implementations of JMS have data type restrictions on properties. But the property mediator always sets property values as strings.

The solution is to revise the mediation sequences and avoid manipulating property values containing non-string values. If you want to set a
non-string property value, write a simple custom mediator. Instructions are given in section [Creating Custom Mediators]({{base_path}}/integrate/develop/customizations/creating-custom-mediators). For an example, to set a property named foo with integer value 12345, use the property mediator as follows and set the type attribute
to INTEGER.  If the type attribute of the property is not specifically set, it will be assigned to String by default.

```xml
<property name="foo" value="12345" type="INTEGER" scope="transport/">
```

## Too-many-threads and out-of-memory issues

With some JMS brokers, WSO2 Micro Integrator tends to spawn new worker threads indefinitely until it runs out of memory and crashes. This problem is caused by a bug in the underlying Axis2 engine. A simple workaround to this problem is to engage the property mediator of the  mediation sequence  as follows:

```xml
<property action="remove" name="transportNonBlocking" scope="axis2">
```

This prevents the Micro Integrator from creating new worker threads indefinitely. You can use a jconsole like  JMX client to  monitor the active threads and
memory consumption of WSO2 Micro Integrator.

## JMSUtils cannot locate destination

If your topic or queue name contains the termination characters ":" or "=", JMSUtils will not be able to find the topic/queue and will give you
the warning "JMSUtils cannot locate destination". For more information, see <http://docs.oracle.com/javase/7/docs/api/java/util/Properties.html#load%28java.io.Reader%29>. For example, if the topic name is `my::topic`, the following configuration will not work, because the topic name will be parsed as `my` instead of `my::topic`:

```xml        
<address uri="jms:/my::topic?transport.jms.ConnectionFactoryJNDIName=QueueConnectionFactory&amp;java.naming.factory.initial=org.wso2.andes.jndi.PropertiesFileInitialContextFactory&amp;java.naming.provider.url=repository/conf/jndi.properties&amp;transport.jms.DestinationType=topic"/>
```

To avoid this issue, you can create a key-value pair in the `deployment.toml` file that maps the topic/queue name to a key that either escapes these characters with a backslash (\\) or does not contain ":" or "=". For example:

```toml     
[transport.jndi.topic]
'my\:\:topic' = "my::topic"
```

or

```toml
[transport.jndi.topic]
myTopic = "my::topic"
```

You can then use this key in the proxy service as follows:

```xml       
<address uri="jms:/my\:\:topic?transport.jms.ConnectionFactoryJNDIName=TopicConnectionFactory&amp;java.naming.factory.initial=org.wso2.andes.jndi.PropertiesFileInitialContextFactory&amp;java.naming.provider.url=repository/conf/jndi.properties&amp;transport.jms.DestinationType=topic"/>        
```

If you do not want to use the JNDI properties file, you can define the
key-value pair right in the proxy configuration:

```xml
<address uri="jms:/my\:\:topic?transport.jms.ConnectionFactoryJNDIName=TopicConnectionFactory&amp;java.naming.factory.initial=org.wso2.andes.jndi.PropertiesFileInitialContextFactory&amp;topic.my\:\:topic=my::topic&amp;java.naming.provider.url=repository/conf/jndi.properties&amp;transport.jms.DestinationType=topic"/>
```

## All the threads get blocked if one JMS backend is not available and do not recover when the backend is available again

When one backend fails, the following state appears for all the threads as they try to connect to the unavailable backend.

`- state:BLOCKED`

Once the backend is available again, the threads do not become active again

This is because in the JMS transport, all the threads that use the same JMS session for communication are synchronized for thread safety.
Therefore, if one thread obtains the shared JMS session object and waits to obtain another resource (i.e., a reconnection to IBM MQ), this results in a set of threads waiting on this monitor. This results in all the synapse threads being blocked. When all the threads are blocked in the connection pool, WSO2 MI stops responding to requests.

In order to make sure that WSO2 MI recovers after the backend is fixed, specify a connection timeout by following the steps below.

1. Open the `<MI_HOME>/bin/micro-integrator.sh` file.

2. In the `JAVA_OPTS` section, set the following property.

    `Dcom.ibm.mq.cfg.TCP.Connect_Timeout=5`
    
    e.g., The following is an extract of the `JAVA_OPTS` section with this property.
    
    `JAVA_OPTS="-Xdebug -Xnoagent -Djava.compiler=NONE -Dcom.ibm.mq.cfg.TCP.Connect_Timeout=5 -Xrunjdwp:transport=dt_socket,server=y,suspend=y,address=$PORT"`
    
    !!! info
        By default, the value of this parameter is `0` which results in the thread that tries to reconnect to IBM MQ keeps retrying, and remains blocked together with all the other threads that share the same JMS session. Here, you are specifying a timeout period of five seconds to reconnect to IBM MQ. So that all the threads in the thread pool are prevented from being blocked until the connection is successfully established. For more information about this parameter, see [IBM Knowledge Centre - TCP stanza of the client configuration file](https://www.ibm.com/support/knowledgecenter/SSFKSJ_9.1.0/com.ibm.mq.con.doc/q016910_.htm).
        
3. Restart the WSO2 MI server.