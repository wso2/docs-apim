# Revoked Tokens

Choreo Connect is required to be notified when a token is revoked by the Security Token Service (STS).
When Choreo Connect is working with JWT formatted self-contained access tokens, it does not communicate with the STS for checking the validity of the token. It considers any token with a trusted signature as valid as long as the token is not expired. 
However, this model becomes a problem when the respective token is revoked by the STS. As a result, there needs to be a mechanism where Choreo Connect gets notified when a token is revoked before its expiry.

Choreo Connect uses Real-time and Persistent Notifications to identify tokens that are revoked before their expiry. Real-time Notifications help you identify such revoked tokens in real-time after Choreo Connect server has spun up. In contrast, when using Persistent notifications, the persistent storage maintains a current list of the revoked tokens. This will help new Choreo Connect servers that spin up to obtain information about the previously revoked tokens, which still have not expired.

[![Revoked Tokens in Choreo Connect]({{base_path}}/assets/img/deploy/mgw/choreo-connect-jwt-revocation.png){: style="width:80%"}]({{base_path}}/assets/img/deploy/mgw/choreo-connect-jwt-revocation.png)

## Methods to detect JWT token revocation

The methods to detect JWT token revocation are described as follows:

   - [Real-time Notifier](#real-time-notifier)
  
   - [Persistent Notifier](#persistent-notifier)

### Real-time Notifier

When working with Real-time Notifications, Choreo Connect uses a Publisher- Subscriber model (pub-sub model) where the Security Token Service (STS) and Choreo Connects are linked using a Message Broker (MB). Whenever a revoke token request is received, the STS publishes a message to the JMS Message Broker. Choreo Connect has subscribed to the `tokenRevocation` topic, which is the JMS connection topic. When the JMS connection topic receives a message, the Message Broker propagates the message to the Choreo Connect servers. When Choreo Connect servers receive this message, it will store the revoked tokens in-memory and treat them as revoked tokens. You can't extend the Real-time Notifier to add your own implementation.

### Persistent Notifier

When using Persistent Notifications, Choreo Connect uses a persistent storage mechanism to link the Security Token Service (STS) and the WSO2 API Choreo Connect servers. Whenever a token revoke request is received, the STS publishes a message to the persistent storage. When a new  Choreo Connect server spins up, it pulls the list of revoked tokens from the persistent storage, and stores them in the revoked jti (JWT ID) cache. The latter mentioned process only takes place once, and the state of the token is preserved. The state of the revoked token is used at restarts and when a new Choreo Connect deployment joins to the cluster of Choreo Connect servers. By default, Choreo Connect can use WSO2 API Manager as its persistent storage when working with persistent notifications. 
