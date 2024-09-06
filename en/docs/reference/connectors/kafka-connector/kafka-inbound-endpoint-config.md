# Kafka Inbound Endpoint Reference

## Mandatory parameters for Kafka Inbound Endpoint

The following parameters are required when configuring Kafka Inbound Endpoint.

<table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
        </tr>
        <tr>
            <td>bootstrap.servers</td>
            <td>The Kafka brokers listed as host1:port1 and host2:port2</td>
        </tr>
        <tr>
            <td>key.deserializer</td>
            <td>Deserializer class for key that implements the org.apache.kafka.common.serialization.Deserializer interface.</td>
        </tr>
        <tr>
            <td>value.deserializer</td>
            <td>Deserializer class for value that implements the org.apache.kafka.common.serialization.Deserializer interface.</td>
        </tr>
        <tr>
            <td>group.id</td>
            <td>The consumer group ID.</td>
        </tr>
        <tr>
            <td>poll.timeout</td>
            <td>The max time to block in the consumer waiting for records.</td>
        </tr>
        <tr>
            <td>topic.name</td>
            <td>The name of the topic.</td>
        </tr>
        <tr>
            <td>topic.pattern</td>
            <td>The name pattern of the topic.</td>
        </tr>
        <tr>
            <td>contentType</td>
            <td>The content type of the message.</td>
        </tr>
</table>

## Optional parameters for Kafka Inbound Endpoint

<table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Default Value</th>
        </tr>
        <tr>
            <td>enable.auto.commit</td>
            <td>Whether the consumer will automatically commit offsets periodically at the interval set by auto.commit.interval.ms.</td>
            <td>true</td>
        </tr>
        <tr>
            <td>auto.commit.interval.ms</td>
            <td>Offsets are committed automatically with a frequency controlled by the config.</td>
            <td>5000</td>
        </tr>
        <tr>
            <td>session.timeout.ms</td>
            <td>The timeout used to detect client failures when using Kafka’s group management facility.</td>
            <td>10000</td>
        </tr>
        <tr>
            <td>fetch.min.bytes</td>
            <td>The minimum amount of data the server should return for a fetch request.</td>
            <td>1</td>
        </tr>
        <tr>
            <td>heartbeat.interval.ms</td>
            <td>The expected time between heartbeats to the consumer coordinator when using Kafka’s group management facilities.</td>
            <td>3000</td>
        </tr>
        <tr>
            <td>max.partition.fetch.bytes</td>
            <td>The maximum amount of data per-partition the server will return. Records are fetched in batches by the consumer.</td>
            <td>1048576</td>
        </tr>
        <tr>
            <td>key.delegate.deserializer</td>
            <td>Property name for the delegate key deserializer.</td>
            <td></td>
        </tr>
        <tr>
            <td>value.delegate.deserializer</td>
            <td>Property name for the delegate value deserializer.</td>
            <td></td>
        </tr>
        <tr>
            <td>schema.registry.url</td>
            <td>Comma-separated list of URLs for Schema Registry instances that can be used to register or look up schemas.</td>
            <td></td>
        </tr>
        <tr>
            <td>basic.auth.credentials.source</td>
            <td>Specify how to pick the credentials for the Basic authentication header.</td>
            <td></td>
        </tr>
        <tr>
            <td>basic.auth.user.info</td>
            <td>Specify the user info for the Basic authentication in the form of {username}:{password}.</td>
            <td></td>
        </tr>
        <tr>
            <td>ssl.key.password</td>
            <td>The password of the private key in the key store file or the PEM key specified in `ssl.keystore.key`.</td>
            <td></td>
        </tr>
        <tr>
            <td>ssl.keystore.location</td>
            <td>The location of the key store file. This is optional for client and can be used for two-way authentication for client.</td>
            <td></td>
        </tr>
        <tr>
            <td>ssl.keystore.password</td>
            <td>The store password for the key store file. This is optional for client and only needed if ‘ssl.keystore.location’ is configured.</td>
            <td></td>
        </tr>
        <tr>
            <td>ssl.truststore.location</td>
            <td>The location of the trust store file.</td>
            <td></td>
        </tr>
        <tr>
            <td>ssl.truststore.password</td>
            <td>The password for the trust store file.</td>
            <td></td>
        </tr>
        <tr>
            <td>auto.offset.reset</td>
            <td>Defines what to do when there is no initial offset in Kafka or if the current offset does not exist any more on the server.</td>
            <td>latest</td>
        </tr>
        <tr>
            <td>connections.max.idle.ms</td>
            <td>Close idle connections after the number of milliseconds specified by this config.</td>
            <td>540000</td>
        </tr>
        <tr>
            <td>exclude.internal.topics</td>
            <td>Whether internal topics matching a subscribed pattern should be excluded from the subscription.</td>
            <td>true</td>
        </tr>
        <tr>
            <td>fetch.max.bytes</td>
            <td>The maximum amount of data the server should return for a fetch request.</td>
            <td>52428800</td>
        </tr>
        <tr>
            <td>max.poll.interval.ms</td>
            <td>The maximum delay between invocations of poll() when using consumer group management.</td>
            <td>300000</td>
        </tr>
        <tr>
            <td>max.poll.records</td>
            <td>The maximum number of records returned in a single call to poll().</td>
            <td>500</td>
        </tr>
        <tr>
            <td>partition.assignment.strategy</td>
            <td>A list of class names or class types, ordered by preference, of supported partition assignment strategies that the client will use to distribute partition ownership amongst consumer instances when group management is used.</td>
            <td>org.apache.kafka.clients.consumer.RangeAssignor</td>
        </tr>
        <tr>
            <td>receive.buffer.bytes</td>
            <td>The size of the TCP receive buffer (SO_RCVBUF) to use when reading data.</td>
            <td>65536</td>
        </tr>
        <tr>
            <td>request.timeout.ms</td>
            <td>The configuration controls the maximum amount of time the client will wait for the response of a request.</td>
            <td>305000</td>
        </tr>
        <tr>
            <td>sasl.jaas.config</td>
            <td>JAAS login context parameters for SASL connections in the format used by JAAS configuration files.</td>
            <td></td>
        </tr>
        <tr>
            <td>sasl.client.callback.handler.class</td>
            <td>The fully qualified name of a SASL client callback handler class that implements the AuthenticateCallbackHandler interface.</td>
            <td></td>
        </tr>
        <tr>
            <td>sasl.login.class</td>
            <td>The fully qualified name of a class that implements the Login interface.</td>
            <td></td>
        </tr>
        <tr>
            <td>sasl.kerberos.service.name</td>
            <td>The Kerberos principal name that Kafka runs as.</td>
            <td></td>
        </tr>
        <tr>
            <td>sasl.mechanism</td>
            <td>SASL mechanism used for client connections.</td>
            <td></td>
        </tr>
        <tr>
            <td>security.protocol</td>
            <td>Protocol used to communicate with brokers.</td>
            <td></td>
        </tr>
        <tr>
            <td>send.buffer.bytes</td>
            <td>The size of the TCP send buffer (SO_SNDBUF) to use when sending data.</td>
            <td>131072</td>
        </tr>
        <tr>
            <td>ssl.enabled.protocols</td>
            <td>The list of protocols enabled for SSL connections.</td>
            <td></td>
        </tr>
        <tr>
            <td>ssl.keystore.type</td>
            <td>The file format of the key store file.</td>
            <td></td>
        </tr>
        <tr>
            <td>ssl.protocol</td>
            <td>The SSL protocol used to generate the SSLContext.</td>
            <td></td>
        </tr>
        <tr>
            <td>ssl.provider</td>
            <td>The name of the security provider used for SSL connections.</td>
            <td></td>
        </tr>
        <tr>
            <td>ssl.truststore.type</td>
            <td>The file format of the trust store file.</td>
            <td></td>
        </tr>
        <tr>
            <td>check.crcs</td>
            <td>Automatically check the CRC32 of the records consumed. This ensures no on-the-wire or on-disk corruption to the messages occurred.</td>
            <td>true</td>
        </tr>
        <tr>
            <td>client.id</td>
            <td>An id string to pass to the server when making requests.</td>
            <td></td>
        </tr>
        <tr>
            <td>fetch.max.wait.ms</td>
            <td>The maximum amount of time the server will block before answering the fetch request if there isn’t sufficient data to immediately satisfy the requirement given by fetch.min.bytes.</td>
            <td>500</td>
        </tr>
        <tr>
            <td>interceptor.classes</td>
            <td>A list of classes to use as interceptors.</td>
            <td></td>
        </tr>
        <tr>
            <td>metadata.max.age.ms</td>
            <td>The period of time in milliseconds after which we force a refresh of metadata even if we haven’t seen any partition leadership changes to proactively discover any new brokers or partitions.</td>
            <td>300000</td>
        </tr>
        <tr>
            <td>metric.reporters</td>
            <td>A list of classes to use as metrics reporters.</td>
            <td></td>
        </tr>
        <tr>
            <td>metrics.num.samples</td>
            <td>The number of samples maintained to compute metrics.</td>
            <td>2</td>
        </tr>
        <tr>
            <td>metrics.recording.level</td>
            <td>The highest recording level for metrics.</td>
            <td>INFO</td>
        </tr>
        <tr>
            <td>metrics.sample.window.ms</td>
            <td>The window of time a metrics sample is computed over.</td>
            <td>30000</td>
        </tr>
        <tr>
            <td>reconnect.backoff.ms</td>
            <td>The base amount of time to wait before attempting to reconnect to a given host.</td>
            <td>50</td>
        </tr>
        <tr>
            <td>retry.backoff.ms</td>
            <td>The amount of time to wait before attempting to retry a failed request to a given topic partition.</td>
            <td>100</td>
        </tr>
        <tr>
            <td>sasl.kerberos.kinit.cmd</td>
            <td>Kerberos kinit command path.</td>
            <td></td>
        </tr>
        <tr>
            <td>sasl.kerberos.min.time.before.relogin</td>
            <td>Login thread sleep time between refresh attempts.</td>
            <td></td>
        </tr>
        <tr>
            <td>sasl.kerberos.ticket.renew.jitter</td>
            <td>Percentage of random jitter added to the renewal time.</td>
            <td></td>
        </tr>
        <tr>
            <td>sasl.kerberos.ticket.renew.window.factor</td>
            <td>Login thread will sleep until the specified window factor of time from last refresh to ticket’s expiry has been reached, at which time it will try to renew the ticket.</td>
            <td></td>
        </tr>
        <tr>
            <td>ssl.cipher.suites</td>
            <td>A list of cipher suites.</td>
            <td></td>
        </tr>
        <tr>
            <td>ssl.endpoint.identification.algorithm</td>
            <td>The endpoint identification algorithm to validate server hostname using server certificate.</td>
            <td></td>
        </tr>
        <tr>
            <td>ssl.keymanager.algorithm</td>
            <td>The algorithm used by key manager factory for SSL connections.</td>
            <td></td>
        </tr>
        <tr>
            <td>ssl.secure.random.implementation</td>
            <td>The SecureRandom PRNG implementation to use for SSL cryptography operations.</td>
            <td></td>
        </tr>
        <tr>
            <td>ssl.trustmanager.algorithm</td>
            <td>The algorithm used by trust manager factory for SSL connections.</td>
            <td></td>
        </tr>
        <tr>
            <td>sasl.oauthbearer.token.endpoint.url</td>
            <td>The URL for the OAuth/OIDC identity provider.</td>
            <td></td>
        </tr>
        <tr>
            <td>sasl.oauthbearer.scope.claim.name</td>
            <td>The OAuth claim for the scope is often named “scope”, but this (optional) setting can provide a different name to use for the scope included in the JWT payload’s claims if the OAuth/OIDC provider uses a different name for that claim.</td>
            <td></td>
        </tr>
        <tr>
            <td>sasl.login.callback.handler.class</td>
            <td>The fully qualified name of a SASL login callback handler class that implements the AuthenticateCallbackHandler interface.</td>
            <td></td>
        </tr>
        <tr>
            <td>sasl.login.connect.timeout.ms</td>
            <td>The (optional) value in milliseconds for the external authentication provider connection timeout.</td>
            <td></td>
        </tr>
        <tr>
            <td>sasl.login.read.timeout.ms</td>
            <td>The (optional) value in milliseconds for the external authentication provider read timeout.</td>
            <td></td>
        </tr>
        <tr>
            <td>sasl.login.retry.backoff.ms</td>
            <td>The (optional) value in milliseconds for the initial wait between login attempts to the external authentication provider.</td>
            <td></td>
        </tr>
        <tr>
            <td>sasl.login.retry.backoff.max.ms</td>
            <td>The (optional) value in milliseconds for the maximum wait between login attempts to the external authentication provider.</td>
            <td></td>
        </tr>
        <tr>
            <td>kafka.header.prefix</td>
            <td>The prefix for Kafka headers.</td>
            <td></td>
        </tr>
        <tr>
            <td>avro.use.logical.type.converters</td>
            <td>Whether to enable the use of logical type converters in Avro. This parameter is available only with Kafka Inbound Endpoint v1.2.2 and above.</td>
            <td>False</td>
        </tr>
</table>
