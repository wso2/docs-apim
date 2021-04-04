# Connecting to IBM WebSphere MQ

The WSO2 JMS transport can be configured with IBM® WebSphere® MQ. The
following topics cover the configuration steps.

!!! Info 
    The configuration steps below are for a Windows environment.

## Prerequisites

-   Download and install WSO2 Micro Integrator. 
-   WebSphere MQ is installed and the latest fix pack applied (see the [IBM documentation](http://publib.boulder.ibm.com/infocenter/sametime/v8r0/index.jsp?topic=/com.ibm.help.sametime.advanced.doc/stv_inst_mq_appl_win_t.html). The fix pack can be obtained from <http://www-01.ibm.com/software/integration/wmq>). These instructions are tested on [IBM WebSphere MQ version 8.0.0.4](http://www-01.ibm.com/support/docview.wss?uid=swg24040022).

### Creating queue manager, queue and channel in IBM WebSphere MQ

1.  Start IBM WebSphere MQ Explorer as an administrator. If you are not running on an administrator account, right-click the IBM WebSphere MQ icon/menu item and then click **Run as Administrator**.
2.  Right-click on **Queue Managers**, move the cursor to **New**, and then click **Queue Manager** to open the **Create Queue Manager** wizard. Enter ESBQManager as the queue manager name. Make sure you select **make this the default queue manager** check box. Leave the default values unchanged in the other fields. Click **Next** to move to the next page.
3.  Click **Next** in the page for entering data and log values without changing any default values.
4.  In the page for entering configuration options, select the following. Then click **Next**.

    | Field Name                                                  | Value                                                                  |
    |-------------------------------------------------------------|------------------------------------------------------------------------|
    | **Start queue manager after it has been created** check box | If this is selected, the queue manager will start running immediately after it is created.  |
    | **Automatic** field                                         | If this is selected, the queue manager is automatically started when the machine starts up. |

5.  Configure the following in the page for entering listener options.

    | Field Name                                          | Value                                                                   |
    |-----------------------------------------------------|-------------------------------------------------------------------------|
    | **Create listener configured for TCP/IP** check box | Select this check box to create the listener.                           |
    | **Listen on port number** field | Enter the number of the port where you want to set the listener. In this example, the port number will be 1414.|

6.  Click **Next** and then click **Finish** to save the configuration. The queue manager will be created as shown below.  
    ![Created Queue Manager]({{base_path}}/assets/img/integrate/broker-configs/ibm-websphere-mq/119130334.png)
7.  Expand the navigation tree of the ESBQManager queue manager in the navigation tree. Right-click **Queues**, move the cursor to **New**, and then click **Local Queue** to open the **Create a Local Queue** wizard. Enter the local queue name as `LocalQueue1` and complete running the wizard. Leave the default values of all other fields unchanged, and click **Finish** to save the local queue.  
8.  Right-click **Channels** , move the cursor to **New** , and then click **Server-connection Channel** to open the **Create a Server-connection Channel** wizard. Enter **myChannel** as the channel name and click **Next**. Make sure that the value for the **Transmission Protocol** is **TCP** . Leave the default values unchanged for the rest of the fields, and click **Finish** to save the channel.

### Generating the .bindings file

1.  Create a directory in which the `.bindings` file
    can be saved in any location of your computer. In this example, a
    directory named `jndidirectory` will be created
    in the `G` folder.
2.  Go to IBM Websphere MQ, and right-click on **JMS Administered
    Objects** , and then click **Add Initial Context** .  
    ![JMS Administered Objects]({{base_path}}/assets/img/integrate/broker-configs/ibm-websphere-mq/119130339.png)
3.  Select the **File system** option in the **Connection Details**
    wizard. Enter `file:G/jndidirectory` in the
    **Context nickname** field. Leave the default values unchanged for
    other fields and complete running the wizard. The new file initial
    context will be displayed in the left navigator under **JMS
    Administered Objects** as shown below.  
    ![New File Initial Context]({{base_path}}/assets/img/integrate/broker-configs/ibm-websphere-mq/119130338.png)
4.  Click the file initial context (named
    `file:G/jndidirectory` in this example) in the
    navigator to expand it. Right-click on **Connection Factories**,
    move the cursor to **New**, and then click **Connection Factory**.
    Enter the name of the connection factory as
    `MyQueueConnectionFactory`. Select
    `Queue Connection Factory` as the connection
    factory type. Select `MQClient` as the transport.
    Leave the default values unchanged for other fields and complete
    running the wizard.
5.  Right-click on the newly connected connection factory in the left
    navigator, and the click **Properties** . Click **Connection** .
    Then browse and select `          ESBQManager         ` for the
    **Base queue manager** field. You can change the host and port name
    for the connection factory if required. No changes will be made in
    this example since default values are used. Leave the default values
    unchanged for other fields and click **OK** .
6.  Right-click **Destination** under **JMS Administered Objects** in
    the left navigator. Move the cursor to **New** and then click
    **Destination** to open the **New Destination** wizard. In order to
    map the destination to the local queue you created in step 7 of the
    [Creating queue manager, queue and channel in IBM WebSphere
    MQ](#ConfigurewithIBMWebSphereMQ-Qmanager) section, enter the same
    queue name ( `          LocalQueue1         ` in this example) in
    the **Name** field. Select `          Queue         ` for the
    **Type** field. Select `          ESBQManager         ` as the queue
    manager and `          LocalQueue1         ` as the queue in the
    wizard. Leave the default values unchanged for other fields and
    complete running the wizard.  

The .bindings file will be created in the location you specified (
`         file:G/jndidirectory        ` in this example) after you carry
out the above steps.

In order to connect to the queue, you need to configure channel
authentication. Run the following two commands to disable channel
authentication for the ease of use. Alternatively, you can configure the
authentication for the MQ server.

!!! Info
    Note that you have to run the command prompt as a admin user and run these commands.

```java
runmqsc ESBQManager
```

```java
ALTER QMGR CHLAUTH(DISABLED)
```

```java
REFRESH SECURITY TYPE(CONNAUTH)
```
  
The following will be displayed in the command prompt.

![Command Prompt]({{base_path}}/assets/img/integrate/broker-configs/ibm-websphere-mq/119130336.png)

### Configuring the Micro Integrator

!!! Info
    -   If you use the default configuration of the IBM MQ queue manager,
        you need to provide username and password client authentication. The
        username and password that you need to provide here is the username
        and password that you provide to log on to your operating system.
    -   If you need to enable MQCSP authentication mode to connect to IBM MQ (without using admin user name and password), 
        start the server (runtime) with the following system property:
        ``bash
        -Dcom.ibm.mq.cfg.jmqi.useMQCSPauthentication=Y
        ``
    -   The `          vender.class.loader.enabled         ` parameter in
        the above configuration should be added only when you use IBM
        Websphere MQ as the JMS broker.
    -   WSO2 uses some external class loader mechanisms for some external
        products such as QPID and AMQP due to the limitation of serializing
        the JMSObject message. However, it is not required to use this
        mechanism for IBM Websphere MQ. By adding the
        `          vender.class.loader.enabled         ` parameter, you can
        skip the external class loader for IBM Websphere MQ.
    -   This property can also be included in a proxy service, REST API,
        message store, JMS receiver or the Synapse configuration depending
        on the use case.
    -   **If you are using Windows Operating Systems (e.g., Windows 10)** ,
        mention the `.bindings` file location starting with `file:///         ` format, in the deployment.toml file. 

        `parameter.provider_url = "file:///G:/jndidirectory"`

1.  Add the following configurations to enable the two JMS listeners.

    ```toml
    [[transport.jms.listener]]
    name = "myQueueConnectionFactory1"
    parameter.initial_naming_factory = "com.sun.jndi.fscontext.RefFSContextFactory"
    parameter.provider_url = "file:/G:/jndidirectory"
    parameter.connection_factory_name = "MyQueueConnectionFactory"
    parameter.connection_factory_type = "queue"
    parameter.username = "username"
    parameter.password = "password"

    [[transport.jms.listener]]
    name = "default"
    parameter.initial_naming_factory = "com.sun.jndi.fscontext.RefFSContextFactory"
    parameter.provider_url = "file:/G:/jndidirectory"
    parameter.connection_factory_name = "MyQueueConnectionFactory"
    parameter.connection_factory_type = "queue"
    parameter.username = "username"
    parameter.password = "password"
    ```

2.  Add the following configurations to enable the two JMS senders.

    ```toml
    [[transport.jms.sender]]
    name = "myQueueConnectionFactory1"
    parameter.initial_naming_factory = "com.sun.jndi.fscontext.RefFSContextFactory"
    parameter.provider_url = "file:/G:/jndidirectory"
    parameter.connection_factory_name = "MyQueueConnectionFactory"
    parameter.connection_factory_type = "queue"
    parameter.username = "username"
    parameter.password = "password"

    [[transport.jms.sender]]
    name = "default"
    parameter.initial_naming_factory = "com.sun.jndi.fscontext.RefFSContextFactory"
    parameter.provider_url = "file:/G:/jndidirectory"
    parameter.connection_factory_name = "MyQueueConnectionFactory"
    parameter.connection_factory_type = "queue"
    parameter.username = "username"
    parameter.password = "password"
    ```

### Copying IBM Websphere MQ libraries

Follow the instructions below to build and install IBM WebSphere MQ client JAR files to WSO2 Micro Integrator.

!!! Info
    These instructions are tested on IBM WebSphere MQ version 8.0.0.4. However, you can follow them for other versions appropriately.

1.  Create a new directory named `wmq-client` , and
    then create another new directory named `lib`
    inside it.

2.  Copy the following JAR files from the
    `<IBM_MQ_HOME>/java/lib/` directory (where
    `<IBM_MQ_HOME>` refers to the IBM WebSphere MQ
    installation directory) to the
    `wmq-client/lib/` directory.
    
    !!! Info
        If you are using IBM MQ docker container, you can find these libraries in inside the `/opt/mqm/java/lib` directory. You can use `docker cp` command to copy jar files from the docker container.
   
    !!! Note
        If you are using IBM MQ 8 with Mutual SSL enabled, you need to download the [wmq-client-8.0.0.zip]({{base_path}}/assets/img/integrate/broker-configs/IBM-websphere-mq/119130333.zip)
        file and follow the instructions in the readme.txt file.

    -   `             com.ibm.mq.allclient.jar            `
    -   `             fscontext.jar            `
    -   `             jms.jar            `
    -   `             providerutil.jar            `

3.  Create a `           POM.xml          ` file inside the wmq
    `           -client/          ` directory and add all the required
    dependencies as shown in the example below.

    !!! Tip
        You need to change the values of the
        `           <version>          ` and
        `           <systemPath>          ` properties accordingly.
    

    ```xml
    <?xml version="1.0"?>
    <project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <groupId>wmq-client</groupId>
    <artifactId>wmq-client</artifactId>
    <version>8.0.0.4</version>
    <packaging>bundle</packaging>
    <dependencies>
        <dependency>
            <groupId>com.ibm</groupId>
            <artifactId>fscontext</artifactId>
            <version>8.0.0.4</version>
            <scope>system</scope>
            <systemPath>${basedir}/lib/fscontext.jar</systemPath>
        </dependency>
        <dependency>
            <groupId>com.ibm</groupId>
            <artifactId>providerutil</artifactId>
            <version>8.0.0.4</version>
            <scope>system</scope>
            <systemPath>${basedir}/lib/providerutil.jar</systemPath>
        </dependency>
        <dependency>
            <groupId>com.ibm</groupId>
            <artifactId>allclient</artifactId>
            <version>8.0.0.4</version>
            <scope>system</scope>
            <systemPath>${basedir}/lib/com.ibm.mq.allclient.jar</systemPath>
        </dependency>
        <dependency>
            <groupId>javax.jms</groupId>
            <artifactId>jms</artifactId>
            <version>1.1</version>
            <scope>system</scope>
            <systemPath>${basedir}/lib/jms.jar</systemPath>
        </dependency>
    </dependencies>
    <build>
        <plugins>
            <plugin>
                <groupId>org.apache.felix</groupId>
                <artifactId>maven-bundle-plugin</artifactId>
                <version>2.3.4</version>
                <extensions>true</extensions>
                <configuration>
                    <instructions>
                        <Bundle-SymbolicName>${project.artifactId}</Bundle-SymbolicName>
                        <Bundle-Name>${project.artifactId}</Bundle-Name>
                        <Export-Package>*;-split-package:=merge-first</Export-Package>
                        <Private-Package/>
                        <Import-Package/>
                        <Embed-Dependency>*;scope=system;inline=true</Embed-Dependency>
                        <DynamicImport-Package>*</DynamicImport-Package>
                    </instructions>
                </configuration>
            </plugin>
        </plugins>
    </build>
    </project>
    ```

4.  Navigate to the wmq `-client` directory using your Command Line Interface (CLI), and execute the following
    command, to build the project: `mvn clean install`
5.  Stop the WSO2 Micro Integrator, if it is already running.
6.  Remove any existing IBM MQ client JAR files from the `MI_HOME/dropins` directory and the `MI_HOME/lib` directory.
7.  Copy the `<wmq-client>/target/wmq-client-8.0.0.4.jar`
    file to the `MI_HOME/dropins` directory.
8.  Download the [`jta.jar` file from the maven repository](http://central.maven.org/maven2/javax/transaction/jta/1.1/jta-1.1.jar), and copy it to the `MI_HOME/lib` directory.
9. [Regenerate the `.bindings` file](#ConfigurewithIBMWebSphereMQ-generate) with the `Provider Version : 8` property (if 
you already generated one before), and replace the existing `.bindings` file (if you have one) with the new `
.bindings` file you generated.

10. Start the WSO2 Micro Integrator server.

### Deploying JMS listener proxy service

In this section, the following simple proxy service is deployed to listen to the `LocalQueue1` queue. When a message is published in this queue, the proxy service would pull the message out of the queue and log it.

```xml
<proxy xmlns="http://ws.apache.org/ns/synapse"
       name="MyJMSProxy"
       transports="jms"
       startOnLoad="true"
       trace="disable">
   <description/>
   <target>
      <inSequence>
         <log level="full"/>
         <drop/>
      </inSequence>
   </target>
   <parameter name="transport.jms.Destination">LocalQueue1</parameter>
</proxy>
```

### Testing the proxy service

Open IBM Websphere MQ and publish a message to `LocalQueue1`.

![Publish Message to Queue]({{base_path}}/assets/img/integrate/broker-configs/ibm-websphere-mq/119130337.png)

