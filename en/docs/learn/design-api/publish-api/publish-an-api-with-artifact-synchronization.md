# Publish an API with Artifact Synchronization

Currently, in a Multi Gateway setup, synapse artifacts such as sequences, local entries, endpoints are saved in
` <APIM_HOME>/repository/deployment/server/synapse-configs/default` directory as XMLs and have to be synced between all the gateway nodes using NFS or rsync. 
When using NFS we need to manage additional components that result in a considerable amount of changes in the current architecture.

Thus, a solution with an extension point which can be configurable to store these synapse artifacts is introduced.


###API Publish/ Update / Remove when the API Gateway is running

  [![Lifecycle tab]({{base_path}}/assets/img/learn/sam.png)]({{base_path}}/assets/img/learn/sam.png)

1. When an API gets Published, Edited, or removed, the synapse artifacts corresponding to that API will be Stored or
 updated  in the extension point. 
2. Then an event will be sent to Traffic Manager(TM) using Event Notifiers with API Name, UUID, and the gateway label
 for the API.
3. Gateways are subscribed to the TM. Gateway will filter out the events by the Gateway label and APIs that have the
 gateway's label will be sorted. 
4. Then it will fetch the artifacts associated with the API from the storage (Database or Github) and load it to the
 memory.


There will be an extension in the publisher profile to store the synapse artifacts in a persistence storage. The default implementation uses the API Manager Database itself. Once the API is Published, Edited, or removed, an event will be sent to Traffic Manager using Event Notifiers with API Name, UUID, and the gateway label for the API. 


###API Gateway at the startup


  [![Lifecycle tab]({{base_path}}/assets/img/learn/gateway-startup.png)]({{base_path}}/assets/img/learn/gateway-startup.png)
  
At startup, the gateway will look on the APIs with labels which it is subscribed to, in the extension, and fetch the synapse artifacts of those APIs. Those synapse artifacts will get deployed in the gateway.

Gateways are subscribed to the traffic manager. There is an extension in the gateway to get the synapse artifacts and deploy them in the memory. Gateways can subscribe to multiple labels.
