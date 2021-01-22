# Enabling Security for Kafka

Security is an important aspect today because cyber-attacks have become a common occurrence and the threat of data breaches is a reality for businesses of all sizes. Before version 0.9, Kafka did not support built-in security. Although it was possible to lock down access at the network level, that approach was not viable for a large shared multi-tenant cluster used across a large company.

There are a number of different ways to secure a Kafka cluster depending on your requirements.  Let's have a look at how to secure a Kafka cluster using Transport Layer Security (TLS) authentication.

For client/broker and inter-broker communication you need to do the following:

* Use TLS or Kerberos authentication
* Encrypt network traffic via TLS
* Perform authorization via access control lists (ACLs)

Now let's take a look at how TLS authentication can be applied to Kafka brokers, producers and consumers.

* [Generating TLS keys and certificates](#generating-tls-keys-and-certificates)
* [Configuring TLS authentication for the Kafka broker](#configuring-tls-authentication-for-the-kafka-broker)
* [Configuring TLS authentication for Kafka clients/producers ](#configuring-tls-authentication-for-kafka-clientsproducers)
* [Configuring TLS authentication for the Kafka consumer ](#configuring-tls-authentication-for-the-kafka-consumer) 
* [Analyzing the output ](#analyzing-the-output)

## Generating TLS keys and certificates
Before you start, you need to generate a key and certificate for each broker and client in the cluster. The common name (CN) of the broker certificate must match the fully qualified domain name (FQDN) of the server because the client compares the CN with the DNS domain name to ensure that it is connecting to the desired broker, instead of a malicious one.

Now that each broker has a public-private key pair and an unsigned certificate to identify itself, it is important for each certificate to be signed by a certificate authority (CA) to prevent forged certificates. As long as the CA is a genuine and trusted authority, the clients have high assurance that they are connecting to authentic brokers.

In contrast to the keystore, which stores each application’s identity, the truststore stores all the certificates that the application should trust. Importing a certificate into a truststore also means trusting all certificates that are signed by that certificate. This attribute is called the chain of trust, and it is particularly useful when deploying TLS on a large Kafka cluster. You can sign all certificates in the cluster with a single CA, and have all machines share the same truststore that contains the CA certificate. That way all machines can authenticate all other machines. A slightly more complex alternative is to use two CAs, one to sign brokers’ keys and another to sign clients’ keys.

Now Let's see how you can generate your own CA, which is simply a public-private key pair and certificate.  Then you can add the CA certificate to each client and broker’s truststore.

The following bash script generates the keystore and truststore for brokers (kafka.server.keystore.jks and kafka.server.truststore.jks) and clients (kafka.client.keystore.jks and kafka.client.truststore.jks):

**createCertificates**
````
#!/bin/bash
PASSWORD=test1234
VALIDITY=365
keytool -keystore kafka.server.keystore.jks -alias localhost -validity $VALIDITY -genkey
openssl req -new -x509 -keyout ca-key -out ca-cert -days $VALIDITY
keytool -keystore kafka.server.truststore.jks -alias CARoot -import -file ca-cert
keytool -keystore kafka.client.truststore.jks -alias CARoot -import -file ca-cert
keytool -keystore kafka.server.keystore.jks -alias localhost -certreq -file cert-file
openssl
 x509 -req -CA ca-cert -CAkey ca-key -in cert-file -out cert-signed
-days $VALIDITY -CAcreateserial -passin pass:$PASSWORD
keytool -keystore kafka.server.keystore.jks -alias CARoot -import -file ca-cert
keytool -keystore kafka.server.keystore.jks -alias localhost -import -file cert-signed
keytool -keystore kafka.client.keystore.jks -alias localhost -validity $VALIDITY -genkey
keytool -keystore kafka.client.keystore.jks -alias localhost -certreq -file cert-file
openssl
 x509 -req -CA ca-cert -CAkey ca-key -in cert-file -out cert-signed
-days $VALIDITY -CAcreateserial -passin pass:$PASSWORD
keytool -keystore kafka.client.keystore.jks -alias CARoot -import -file ca-cert
keytool -keystore kafka.client.keystore.jks -alias localhost -import -file cert-signed
````

## Configuring TLS authentication for the Kafka broker

* Configure the required security protocols and ports in the <KAFKA_HOME>/config/server.properties file.
````
listeners=SSL://:9093
````
> **Note**: Do not enable an unsecured (PLAINTEXT) port because you need to ensure that all broker/client and inter-broker network communication is encrypted. You can select SSL as the security protocol for inter-broker communication (SASL_SSL is the other possible option for the configured listeners):
>  ````
>  security.inter.broker.protocol=SSL
>  ````
>  
> It is difficult to simultaneously upgrade all systems to the new secure clients. Therefore, you can allow supporting a mix of secure and unsecured clients.
>
>  To support a mix of secure and unsecured clients, you need to add a PLAINTEXT port to listeners, but ensure that you restrict access to this port to trusted clients only. Network segmentation and/or authorization ACLs can be used to restrict access to trusted IPs in such cases.
  
Now let's take a look at how to apply protocol-specific configuration settings.

* Configure the following in the <KAFKA-HOME>/config/server.properties file:

**TLS configuration in Broker**
````
ssl.client.auth=required
ssl.keystore.location={file-path}/kafka.server.keystore.jks
ssl.keystore.password=test1234
ssl.key.password=test1234
ssl.truststore.location={file-path}/kafka.server.truststore.jks
ssl.truststore.password=test1234
````
The above configuration should have the TLS client authentication and configuration key details as well as keystore and truststore details. Since you need to store passwords in the broker configuration, it is important to restrict access to the broker configuration via filesystem permission.

## Configuring TLS authentication for Kafka clients/producers

Enabling TLS authentication for Kafka producers and consumers can be done by configuring a set of parameters. It does not require any code changes.

> **Note**: Kafka versions 0.9.0.0 and above support TLS. The older APIs do not support TLS.

##### TLS
The parameters you need to specify to support TLS is the same for both producers and consumers. It is required to specify the security protocol as well as the truststore and keystore information since you are using mutual authentication:

##### Console Clients
The client configuration can slightly differ depending on whether you want the client to use TLS or SASL/Kerberos.

Use the following configuration to create a producer that sends messages to the broker.

**Proxy with Kafka Security**
````
<proxy xmlns="http://ws.apache.org/ns/synapse"
    name="testKafka"
    startOnLoad="true"
    statistics="disable"
    trace="disable"
    transports="http,https">
   <target>
   <inSequence>
      <kafkaTransport.init>
         <bootstrapServers>localhost:9093</bootstrapServers>
         <keySerializerClass>org.apache.kafka.common.serialization.StringSerializer</keySerializerClass>
         <valueSerializerClass>org.apache.kafka.common.serialization.StringSerializer</valueSerializerClass>
         <securityProtocol>SSL</securityProtocol>
         <sslTruststoreLocation>{file-path}/kafka.client.truststore.jks</sslTruststoreLocation>
         <sslTruststorePassword>test1234</sslTruststorePassword>
         <sslKeystoreLocation>{file-path}/kafka.client.keystore.jks</sslKeystoreLocation>
         <sslKeystorePassword>test1234</sslKeystorePassword>
         <sslKeyPassword>test1234</sslKeyPassword>
      </kafkaTransport.init>
      <kafkaTransport.publishMessages>
         <topic>test</topic>
      </kafkaTransport.publishMessages>
   </inSequence>
   </target>
   <description/>
</proxy>
````
The console producer is a convenient way to send a small amount of data to the broker.

Follow the sample scenario in [Kafka configuration documentation]({{base_path}}/reference/connectors/kafka-connector/kafka-connector-config/), and send the following message to the Kafka broker:

> **Note**: Be sure to include the following configuration in the proxy service when you are building the sample:

```
bootstrap.servers=localhost:9093
security.protocol=SSL
ssl.truststore.location={file-path}/kafka.client.truststore.jks
ssl.truststore.password=test1234
ssl.keystore.location={file-path}/kafka.client.keystore.jks
ssl.keystore.password=test1234
ssl.key.password=test1234
```
```
{“test”:”wso2”}
{“test”:”wso2”}
{“test”:”wso2”}
```

## Configuring TLS authentication for the Kafka consumer
The console consumer is a convenient way to consume messages. You can either use the console consumer or the Kafka inbound endpoint to consume messages.

* Execute the following command on the terminal to start the consumer with security:

**command to start the cosumer**
````
bin/kafka-console-consumer --bootstrap-server localhost:9093 --topic test --new-consumer
--from-beginning --consumer.config {file-path}/consumer_ssl.properties
````

* Ensure that you Include the following configuration to enable security.

**consumer_ssl.properties**
````
bootstrap.servers=localhost:9093
security.protocol=SSL
ssl.truststore.location={file-path}/kafka.client.truststore.jks
ssl.truststore.password=test1234
ssl.keystore.location={file-path}/kafka.client.keystore.jks
ssl.keystore.password=test1234
ssl.key.password=test1234
````
Now that you have applied TLS authentication to Kafka brokers, producers and consumers, let's 

## Analyzing the output

You will see the following output on the consumer console:
````
{“test”:”wso2”}
{“test”:”wso2”}
{“test”:”wso2"}
````