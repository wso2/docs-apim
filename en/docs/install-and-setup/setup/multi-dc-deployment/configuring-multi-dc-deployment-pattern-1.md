# Configure Pattern 1: Geo-Regional Synchronized API Management with Replicated Databases

<a href="{{base_path}}/assets/img/setup-and-install/multi-dc-pattern-1.png"><img src="{{base_path}}/assets/img/setup-and-install/multi-dc-pattern-1.png" alt="Multi-DC Pattern 1" width="80%"></a>

All the regions are identical in this pattern. therefore, the documentation will provide information about configuring a single region.

## Step 1: Configure the Database with replication

WSO2 API Manager comes with the multi-dc database scripts for MSSQL and Oracle. When setting up the database with replication for the multi-dc deployment, it is recommended to use the provided script. The file structure is as follows.

```bash
<APIM-Home>
└── dbscripts
    └── multi-dc
        ├── OGG
        │   └── oracle
        │       ├── Readme.txt
        │       ├── apimgt
        │       │   ├── sequences.sql
        │       │   ├── sequences_23c.sql
        │       │   ├── tables.sql
        │       │   └── tables_23c.sql
        │       ├── sequence.sql
        │       ├── sequences_23c.sql
        │       ├── tables.sql
        │       └── tables_23c.sql
        ├── Postgresql
        │   ├── ReadMe.txt
        │   ├── apimgt
        │   │   └── tables.sql
        │   └── tables.sql
        └── SQLServer
            └── mssql
                ├── ReadMe.txt
                ├── apimgt
                │   └── tables.sql
                └── tables.sql
```

You should consult your database administrator on replication related configurations.

!!! note
    Bi-directional replication in the multi-DC setup was tested using Virtual Machine (VM)-based databases. If you intend to use a cloud-based database service, consult the relevant cloud provider for any limitations related to configuring an active-active database setup in their environment.

## Step 2: Configure the API Manager Nodes

{!includes/deploy/steps-to-deploy-apim-in-a-distributed-setup-with-tm-separation.md!}

## Step 3: Configure the Communication Between Control Plane Nodes Across Regions

In a multi-datacenter (multi-DC) deployment of WSO2 API Manager, each region operates independently and communicates with other regions through their respective event hubs via JMS (Java Message Service) events. This pattern allows for efficient inter-region coordination and notification for various events, including API-related events, application-related events, key manager-related events, and token revocation events.

It should be noted that this cross-region communication via JMS events and event hubs is not supported out of the box in WSO2 API Manager. Therefore, organizations deploying multi-DC setups are required to implement custom data publishers in each region's control plane node. These custom data publishers are designed to publish data to the event hubs in different regions, facilitating communication between them.

4 data publishers should be implemented per control plane where the following data publishers are utilized,

<table>
<thead>
<tr class="header">
<td><b>Data Publisher</b></td>
<td><b>Purpose</b></td>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>Notifications data publisher</td>
<td>Publishes data related to the “org.wso2.apimgt.notification.stream” event stream. This event stream consists of events related to APIs, Applications, Policies etc.</td>
</tr>
<tr class="even">
<td>Token revocation data publisher</td>
<td>Publishes data related to “org.wso2.apimgt.token.revocation.stream” event stream. This event stream is responsible for token revocation related events.</td>
</tr>
<tr class="odd">
<td>Key management data publisher</td>
<td>Publishes data related to “org.wso2.apimgt.keymgt.stream” event stream. This event stream is responsible for key manager related events such as key manager addition, updating and deletion.</td>
</tr>
<tr class="even">
<td>Async Webhooks data publisher</td>
<td>Publishes data from “org.wso2.apimgt.webhooks.request.stream” event stream. This event stream is responsible for the request data from deployed webhooks in the API gateway.</td>
</tr>
<tr class="odd">
<td>Blocking Event Data Publisher</td>
<td>Publishes data from “org.wso2.blocking.request.stream” event stream. This event stream is responsible for blocking tasks such as application blocking, IP blocking etc.</td>
</tr>
</tbody>
</table>

Moreover, jndi.properties files should be added per region to provide information on the connection of the event hub.

Since the control planes are only connected through the JMS connections, the TCP port 5672 should be exposed to the external parties (Other regions' control planes).

<a href="{{base_path}}/assets/img/setup-and-install/multi-dc-cp-to-cp-communication.png"><img src="{{base_path}}/assets/img/setup-and-install/multi-dc-cp-to-cp-communication.png" alt="Multi-DC CP to CP Communication" width="80%"></a>

Follow the steps below to configure the control plane node(s) in region 1 to communicate with the region 2 control plane. Similarly region 1 configurations should be added to the region 2 control plane.

1. Add the following event publishers to the `<APIM-HOME>/repository/deployment/server/eventpublishers` directory of the control plane.

   **notificationJMSPublisherRegion2.xml**

  ``` 
    <?xml version="1.0" encoding="UTF-8"?>
    <eventPublisher name="notificationJMSPublisherRegion2" statistics="disable"
    trace="disable"
    xmlns="http://wso2.org/carbon/eventpublisher">
    <from streamName="org.wso2.apimgt.notification.stream" version="1.0.0"/>
    <mapping customMapping="disable" type="json"/>
    <to eventAdapterType="jms">
    <property name="java.naming.factory.initial">org.wso2.andes.jndi.PropertiesFileInitialContextFactory</property>
    <property name="java.naming.provider.url">repository/conf/jndi-region2.properties</property>
    <property name="transport.jms.DestinationType">topic</property>
    <property name="transport.jms.Destination">notification</property>
    <property name="transport.jms.ConcurrentPublishers">allow</property>
    <property name="transport.jms.ConnectionFactoryJNDIName">TopicConnectionFactory</property>
    </to>
    </eventPublisher>
  ```

  **tokenRevocationJMSPublisherRegion2.xml**

  ```
      <?xml version="1.0" encoding="UTF-8"?>
    <eventPublisher name="tokenRevocationJMSPublisherRegion2" statistics="disable"
                    trace="disable"
        xmlns="http://wso2.org/carbon/eventpublisher">
        <from streamName="org.wso2.apimgt.token.revocation.stream" version="1.0.0"/>
        <mapping customMapping="disable" type="json"/>
        <to eventAdapterType="jms">
            <property name="java.naming.factory.initial">org.wso2.andes.jndi.PropertiesFileInitialContextFactory</property>
            <property name="java.naming.provider.url">repository/conf/jndi-region2.properties</property>
            <property name="transport.jms.DestinationType">topic</property>
            <property name="transport.jms.Destination">tokenRevocation</property>
            <property name="transport.jms.ConcurrentPublishers">allow</property>
            <property name="transport.jms.ConnectionFactoryJNDIName">TopicConnectionFactory</property>
        </to>
    </eventPublisher>
  ```

  **keymgtEventJMSEventPublisherRegion2.xml**

  ```
      <?xml version="1.0" encoding="UTF-8"?>
    <eventPublisher name="keymgtEventJMSEventPublisherRegion2" statistics="disable"
      trace="disable" xmlns="http://wso2.org/carbon/eventpublisher">
      <from streamName="org.wso2.apimgt.keymgt.stream" version="1.0.0"/>
      <mapping customMapping="disable" type="json"/>
      <to eventAdapterType="jms">
        <property name="java.naming.factory.initial">org.wso2.andes.jndi.PropertiesFileInitialContextFactory</property>
        <property name="java.naming.provider.url">repository/conf/jndi-region2.properties</property>
        <property name="transport.jms.DestinationType">topic</property>
        <property name="transport.jms.Destination">keyManager</property>
        <property name="transport.jms.ConcurrentPublishers">allow</property>
        <property name="transport.jms.ConnectionFactoryJNDIName">TopicConnectionFactory</property>
      </to>
    </eventPublisher>
  ```

  **asyncWebhooksEventPublisherRegion2.xml** (This is optional only if you have webhook streaming APIs in your deployment)

  ```
        <?xml version="1.0" encoding="UTF-8"?>
        <eventPublisher name="asyncWebhooksEventPublisher-1.0.0-Region2" statistics="disable" processing="disable"
        trace="disable"
        xmlns="http://wso2.org/carbon/eventpublisher">
        <from streamName="org.wso2.apimgt.webhooks.request.stream" version="1.0.0"/>
        <mapping customMapping="disable" type="json"/>
        <to eventAdapterType="jms">
        <property name="java.naming.factory.initial">org.wso2.andes.jndi.PropertiesFileInitialContextFactory</property>
        <property name="java.naming.provider.url">repository/conf/jndi2-region2.properties</property>
        <property name="transport.jms.DestinationType">topic</property>
        <property name="transport.jms.Destination">asyncWebhooksData</property>
        <property name="transport.jms.ConcurrentPublishers">allow</property>
        <property name="transport.jms.ConnectionFactoryJNDIName">TopicConnectionFactory</property>
        </to>
        </eventPublisher>
  ```

  **blockingEventJMSPublisherRegion2.xml**

  ```
    <?xml version="1.0" encoding="UTF-8"?>
    <eventPublisher name="blockingEventJMSPublisher" statistics="disable"
      trace="disable" xmlns="http://wso2.org/carbon/eventpublisher">
      <from streamName="org.wso2.blocking.request.stream" version="1.0.0"/>
      <mapping customMapping="disable" type="json"/>
      <to eventAdapterType="jms">
        <property name="java.naming.factory.initial">org.wso2.andes.jndi.PropertiesFileInitialContextFactory</property>
        <property name="java.naming.provider.url">repository/conf/jndi2-region2.properties</property>
        <property name="transport.jms.DestinationType">topic</property>
        <property name="transport.jms.Destination">throttleData</property>
        <property name="transport.jms.ConcurrentPublishers">allow</property>
        <property name="transport.jms.ConnectionFactoryJNDIName">TopicConnectionFactory</property>
      </to>
    </eventPublisher>
  ```

2. Add the following JNDI configuration file to `<APIM-HOME>/repository/conf directory`.

  **jndi-region2.properties**

  ```
    connectionfactory.TopicConnectionFactory = amqp://admin:admin@clientid/carbon?brokerlist='tcp://<region2-cp-host>:5672'
    
    topic.tokenRevocation = tokenRevocation
    topic.keyManager = keyManager
    topic.notification = notification
    topic.asyncWebhooksData = asyncWebhooksData
    
  ```
Replace `<region2-cp-host>` with the host of the control plane of the region where this data is published. In pattern 1, all the event hubs publish data to all the eventhubs. Therefore, all the event hubs (control plane nodes) in all the regions should be configured to publish data to other regions.

## Optional Step
If you have secondary user stores, make sure that the userstores directory is shared between the regions.

!!! Note
    When a secondary user store is initially added, a new directory called userstores will be created at <APIM_HOME>/repository/deployment/server location. All the secondary user store related configurations will be stored in the userstores directory. 
