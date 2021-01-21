# Kafka Inbound 
## Introduction

The Kafka inbound endpoint provides the functionalilties of the <a href="http://kafka.apache.org/documentation.html">Kafka</a> messaging system. Kafka maintains feeds of messages in topics. Producers write data to topics and consumers read from topics. The Kafka inbound endpoint serves as a message consumer by creating a connection to ZooKeeper and requesting messages for a topic, topics, or topic filters.

## Properties

Listed below are the properties used for [creating an Kafka inbound endpiont]({{base_path}}/integrate/develop/creating-artifacts/creating-an-inbound-endpoint).

### Required Properties

The following properties are required when [creating a Kafka inbound endpiont]({{base_path}}/integrate/develop/creating-artifacts/creating-an-inbound-endpoint).

<table>
  <tr>
    <th>Property</th>
    <th>Description</th>
  </tr>
  <tr>
      <td>
        zookeeper.connect
      </td>
      <td>The host and port of a ZooKeeper server (<code>hostname:port</code>).</td>
      </tr>
      <tr>
         <td>
            consumer.type
         </td>
         <td>The consumer configuration type. This can either be <code>simple</code> or <code>highlevel</code>.</td>
      </tr>
      <tr>
         <td>
          interval
         </td>
         <td>The polling interval for the inbound endpoint to poll the messages.</td>
      </tr>
      <tr>
         <td>
          coordination
         </td>
         <td>If set to <code>true</code> in a clustered setup, this will run the inbound only in a single worker node.</br></br> The property is set to <code>true</code> by default.</td>
      </tr>
      <tr>
         <td>
           sequential
         </td>
         <td>The behaviour when executing the given sequence.</br></br> The property is set to <code>true</code> by default. Set this property to <code>false</code> to use the Kafka inbound in a non-sequential mode as it allows better performance than the sequential mode.</td>
      </tr>
      <tr>
         <td>
            topics
         </td>
         <td>The category to feed the messages. A high-level kafka configuration can have more than one topic. You can specify multiple topic names as comma separated values.</td>
      </tr>
      <tr>
         <td>
           content.type
         </td>
         <td>The content of the message. The possible values are as follows: <code>appllication/xml</code> or <code>application/json</code>.</td>
      </tr>
      <tr>
         <td>
          group.id
         </td>
         <td>
            <p>If all the consumer instances have the same consumer group, this works as a traditional queue balancing the load over the consumers.</p>
         </td>
      </tr>
      <tr>
         <td>
            topic.filter
         </td>
         <td>The name of the topic filter.</td>
      </tr>
      <tr>
         <td>
            filter.from.allowlist
         </td>
         <td>If this is set to <code>true</code>, messages are consumed from the allowlist(include).<br />
            If this is set to <code>false</code>, messages are consumed from the denylist(exclude).
         </td>
      </tr>
      <tr>
    <td>coordination</td>
    <td>
      This optional property is only applicable in a cluster environment. In a clustered environment, an inbound endpoint will only be executed in worker nodes. If set to <code>true</code> in a cluster setup, this will run the inbound only in a single worker node. Once the running worker is down, the inbound starts on another available worker in the cluster. By default, coordniation is enabled.
    </td>
  </tr>
  <tr>
    <td>
       sequential
     </td>
     <td>Whether the messages need to be polled and injected sequentially or not.</td>
  </tr>
</table>

### Optional Properties

The following optional properties can be configured when [creating a Kafka inbound endpiont]({{base_path}}/integrate/develop/creating-artifacts/creating-an-inbound-endpoint).

<table>
   <thead>
      <tr>
         <th>
           Property Name
         </th>
         <th>
            <p>Description</p>
         </th>
      </tr>
   </thead>
   <tbody>
      <tr>
         <td>
          thread.count
         </td>
         <td>The number of threads. The default value is 1.</td>
      </tr>
      <tr>
         <td>consumer.id</td>
         <td>The id of the consumer. The default value is <code>null</code>.</td>
      </tr>
      <tr>
         <td>socket.timeout.ms</td>
         <td>The socket timeout for network requests. The default value is <code>30 * 1000</code>.</td>
      </tr>
      <tr>
         <td>socket.receive.buffer.bytes</td>
         <td>The socket receive buffer for network requests. The default value is <code>64 * 1024</code>.</td>
      </tr>
      <tr>
         <td>fetch.message.max.bytes</td>
         <td>The number of bytes of messages that the system should attempt to fetch for each topic-partition in each fetch request. The default values is <code>1024 * 1024</code>.</td>
      </tr>
      <tr>
         <td>num.consumer.fetchers</td>
         <td>The number fetcher threads used to fetch data. The default value is 1.</td>
      </tr>
      <tr>
         <td>auto.commit.enable</td>
         <td>The committed offset to be used as the position from which the new consumer will begin when the process fails.</br></br> The default value is <code>true</code>.</td>
      </tr>
      <tr>
         <td>auto.commit.interval.ms</td>
         <td>The frequency (in miliseconds) at which the consumer offsets are committed to zookeeper.</br></br> The default value is <code>60 * 1000</code>.</td>
      </tr>
      <tr>
         <td>queued.max.message.chunks</td>
         <td>The maximum number of message chunks buffered for consumption. Each chunk can go up to the value specified in <code>fetch.message.max.bytes</code>.</br></br> The default value is 2.</td>
      </tr>
      <tr>
         <td>rebalance.max.retries</td>
         <td>The maximum number of retry attempts. The default value is 4.</td>
      </tr>
      <tr>
         <td>fetch.min.bytes</td>
         <td>The minimum amount of data the server should return for a fetch request. The default value is 1.</td>
      </tr>
      <tr>
         <td>fetch.wait.max.ms</td>
         <td>The maximum amount of time the server will stay blocked before responding to the fetch request when sufficient data is not available to immediately serve <code>fetch.min.bytes</code>.</br></br> The default value is <code>100</code></td>
      </tr>
      <tr>
         <td>rebalance.backoff.ms</td>
         <td>The backoff time between retries during rebalance. The default value is 2000.</td>
      </tr>
      <tr>
         <td>refresh.leader.backoff.ms</td>
         <td>The backoff time to wait before trying to determine the leader of a partition that has just lost its leader.</br></br> The default value is 200.</td>
      </tr>
      <tr>
         <td>auto.offset.reset</td>
         <td>
            <p>Set this to one of the following values based on what you need to do when there is no initial offset in ZooKeeper or if an offset is out of range.</p>
            <ul>
              <li><b>smallest</b>: Automatically reset the offset to the smallest offset.</li>
              <li><b>largest</b>: Automatically reset the offset to the largest offset.</li>
              <li><b>anything else</b>: Throw an exception to the consumer.</li>
            </ul>
            The default values is <b>largest</b>.
         </td>
      </tr>
      <tr>
         <td>consumer.timeout.ms</td>
         <td>The timeout interval after which a timeout exception is to be thrown to the consumer if no message is available for consumption. It is a good practice to set this value lower than the interval of the Kafka inbound endpoint. The default value is 2000.</td>
      </tr>
      <tr>
         <td>exclude.internal.topics</td>
         <td>Set to <code>true</code> if messages from internal topics such as offsets should be exposed to the consumer. The default value is <code>true</code>.</td>
      </tr>
      <tr>
         <td>partition.assignment.strategy</td>
         <td>The partitions assignment strategy to be used when assigning partitions to consumer streams. Possible values are <code>range</code> and <code>roundrobin</code>.</br></br> Default setting is <code>range</code>.</td>
      </tr>
      <tr>
         <td>client.id</td>
         <td>The user specified string sent in each request to help trace calls.</td>
      </tr>
      <tr>
         <td>
            <p>zookeeper.session.timeout.ms</p>
         </td>
         <td>The ZooKeeper session timeout value in milliseconds. The default value is 6000.</td>
      </tr>
      <tr>
         <td>zookeeper.connection.timeout.ms</td>
         <td>The maximum time in milliseconds that the client should wait while establishing a connection to ZooKeeper.</br></br> The default value is 6000.</td>
      </tr>
      <tr>
         <td>
            <p>zookeeper.sync.time.ms</p>
         </td>
         <td>The time difference in milliseconds that a ZooKeeper follower can be behind a ZooKeeper leader. The default value is 2000.</td>
      </tr>
      <tr>
         <td>offsets.storage</td>
         <td>The offsets storage location. Possible values are <code>zookeeper<code> and <code>kafka</code>. Default setting is <code>zookeeper</code>.</td>
      </tr>
      <tr>
         <td>offsets.channel.backoff.ms</td>
         <td>The backoff period in milliseconds when reconnecting the offsets channel or retrying failed offset fetch/commit requests.</br></br> Default value is 1000.</td>
      </tr>
      <tr>
         <td>offsets.channel.socket.timeout.ms</td>
         <td>The socket timeout in milliseconds when reading responses for offset fetch/commit requests.</br></br> The default value is 10000.</td>
      </tr>
      <tr>
         <td>offsets.commit.max.retries</td>
         <td>The maximum retry attempts allowed. If a consumer metadata request fails for any reason, retry takes place but does not have an impact on this limit.</br></br> Default value is 5.</td>
      </tr>
      <tr>
         <td>dual.commit.enabled</td>
         <td>If <code>offsets.storage</code> is set to <code>kafka</code>, the commit offsets can be dual to ZooKeeper. Set this to <code>true</code> if you need to perform migration from zookeeper-based offset storage to kafka-based offset storage. The default value is <code>true</code>.</td>
      </tr>
      <tr>
         <td>
            simple.topic
         </td>
         <td>The category to feed the messages.</td>
      </tr>
      <tr>
         <td>
            simple.brokers
         </td>
         <td>The specific Kafka broker name.</td>
      </tr>
      <tr>
         <td>
            simple.port
         </td>
         <td>The specific Kafka server port number.</td>
      </tr>
      <tr>
         <td>
            simple.partition
         </td>
         <td>The partition of the topic.</td>
      </tr>
      <tr>
         <td>
            simple.max.messages.to.read
         </td>
         <td>
            <p>The maximum number of messages to retrieve.</p>
         </td>
      </tr>
   </tbody>
</table>