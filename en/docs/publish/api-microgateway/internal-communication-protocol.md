# Communication Protocol of API Microgateway Components

WSO2 API Microgateway uses an implementation of Envoy's [xDS protocol](https://www.envoyproxy.io/docs/envoy/latest/api-docs/xds_protocol#xds-rest-and-grpc-protocol) to communicate between its components, especially the Adapter -> Enforcer and Adapter -> Router communication. Here, the Adapter -> Router communication is already implemented by Envoy and its control plane. WSO2 implements same protocol for Adapter -> Enforcer communication.

Envoy xDS protocol is implemented on top of gRPC. This allows both the server and the client to stream data between each other. Therefore client's can request for required data from the server and server can push the requested data back to client when new data is available.

## WSO2 xDS Implementation

WSO2 xDS implementation is mainly used for communication between Adapter and Enforcer. Using this communication link, Enforcer receives all latest updates of resources required during the startup and runtime. These resources can be APIs, Configurations, Subscriptions, Revoked Tokens etc. Enfocer then uses above data to populate in memory data structures and validate requests based on provided configurations.

Following is the request/response flow of Adapter -> Enforcer xDS communication.
1. During startup the Enforcer sends the initial [`DiscoveryRequest`](https://www.envoyproxy.io/docs/envoy/latest/api-v3/service/discovery/v3/discovery.proto#service-discovery-v3-discoveryrequest) to the Adapter.
    
    This request mainly specifies the expected type of the resource (e.g.,: API, Config, Application, Subscription) by xDS client (Enforcer).
2. The Adapter checks if new resources are available in its cache, for the requested resource type.
    - If available, the Adapter sends a [`DiscoveryResponse`](https://www.envoyproxy.io/docs/envoy/latest/api-v3/service/discovery/v3/discovery.proto#service-discovery-v3-discoveryresponse).
    - If the resource is unavailable the Adapter doesn't respond to the client immediately. It waits until a new resource update happens for the requested resource type.
    - As soon as the new resource is added to the Adapter xDS cache, it responds to the initial client request with with a `DiscoveryResponse`
3. When the Enforcer receives a new `DiscoveryResponse` it extracts the resources from the response and populates in the memory data structures for request validation.
4. Then the Enforcer would Ack/Nack `DiscoveryRequest` to the Adapter.
    - If the Enforcer is able to process the `DiscoveryResponse` successfully, it sends a new `DiscoveryRequest` as `Ack` to the last received version of the resource.
    - If the Enforcer is unable to process the `DiscoveryResponse` successfully, it sends a new `DiscoveryRequest` as `Nack` to the last received version of the resource. Version infomation of this request containa the version of last successfully processed resource version.
5. The Adapter keeps track of the last `Ack`ed version of resource by an Enforcer node and uses that information to decide when and what to send in the next `DiscoveryResponse` to the Enforcer.
    - When a new resource cache update happens in the Adapter, it notifies this change to all subscribed Enforcer nodes. If an Enforcer node `Ack`ed the response, the Adapter will send another response to that Enforcer node only if a new resourse version update happens in Adapter resource cache.
