# Communication Protocol of API Microgateway Components

WSO2 API Microgateway uses an implementation of Envoy's [xDS protocol](https://www.envoyproxy.io/docs/envoy/latest/api-docs/xds_protocol#xds-rest-and-grpc-protocol) to communicate between it's componets. Specially for Adapter -> Enforcer and Adapter -> Router communication. In here the Adapter -> Router communication is already implemented by the Envoy and it's control plane. WSO2 implements same protocol for Adapter -> Enforcer communication.

Envoy xDS protocol is implemented on top of gRPC. This allows both server and client to stream data between each other. Therefore client's can request for required data from the server and server can push the requested data back to client when new data is available.

## WSO2 xDS Implementation

WSO2 xDS implementation is mainly used for communication between Adapter and Enforcer. Using this communication link, Enforcer receives all latest updates of resources required during the startup and runtime. These resources can be APIs, Configurations, Subscriptions, Revoked Tokens etc. Enfocer then uses above data to populate in memory data structures and validate requests based on provided configurations.

Following is the request/response flow of Adapter -> Enforcer xDS communication.
1. During Enforcer startup it sends the initial [`DiscoveryRequest`](https://www.envoyproxy.io/docs/envoy/latest/api-v3/service/discovery/v3/discovery.proto#service-discovery-v3-discoveryrequest) to the Adapter.
    
    This request mainly specifies the expected type of the resource (ex: API, Config, Application, Subscription) by xDS client (Enforcer).
1. Adapter checks if new resources are available in its cache, for the requested resource type.
    - If available, Adapter sends a [`DiscoveryResponse`](https://www.envoyproxy.io/docs/envoy/latest/api-v3/service/discovery/v3/discovery.proto#service-discovery-v3-discoveryresponse).
    - If resource is not available Adapter doesn't respond to the client immediately and wait until a new resource update happens for the requested resource type.
    - As soon as new resource is added to the Adapter xDS cache, it'll respond to the initial client request with with a `DiscoveryResponse`
1. When Enforcer receives a new `DiscoveryResponse` it will extract the resources from it and populate in memory data structures for request validation.
1. Then the Enforcer should Ack/Nack `DiscoveryRequest` to the Adapter.
    - If Enforcer is able to process the `DiscoveryResponse` successfully, it'll send new `DiscoveryRequest` as `Ack` to the last received version of the resource.
    - If Enforcer is unable to process the `DiscoveryResponse` successfully, it'll send new `DiscoveryRequest` as `Nack` to the last received version of the resource. Version infomation of this request will contain the version of last successfully processed resource version.
1. Adapter keeps track of what version of resource is last `Ack`ed by an Enforcer node and use that information to decide when and what to send in next `DiscoveryResponse` to the Enforcer.
    - When new resource cache update happens in Adapter, it'll notify this change for all subscribed Enforcer nodes. If Enforcer node `Ack` the response, Adapter will send another response to that Enforcer node only if new resourse version update happens in Adapter resource cache.