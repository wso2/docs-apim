# When to Use Integration Connectors

A connector is a collection or a set of operations that can be used in an integration flow to access a specific service or a functionality. This can be a third-party HTTP API, remote SOAP service, a legacy system with a proprietary protocol, or even a local library function.

<img src="{{base_path}}/assets/img/integrate/connectors/why-connectors.png" title="Why Connectors" width="500" alt="Why Connectors"/>

## Why and when connectors are useful

### Enables hybrid integration

Hybrid integration is a popular topic in the integration arena due to the rapid growth of cloud computing and cloud platforms. In the past, integration was limited to the on-premise applications and the platform could only provide functionalities available in the on-premise systems. Nowadays, with SaaS applications, a much broader application landscape is enabled. From established on-premises systems to newly adopted software-as-a-service (SaaS) applications, integration is a critical, yet increasingly complicated, step toward digital business transformation. 

<img src="{{base_path}}/assets/img/integrate/connectors/why-connectors2.png" title="Hybrid Integration" width="500" alt="Hybrid Integration"/>

When the WSO2 integration runtime is used as the integration core, connectors are the enablers for hybrid integration. For different SaaS applications, there are different connectors and they all fit into the same integration runtime. Mediators, endpoints, and data services that integrate on-premise data also fit into the integration runtime. As a result, the integration platform of WSO2 as a whole becomes a bridge between on-premise and cloud applications. 

### Reusable modules 

Imagine within your enterprise you need to connect to a legacy system with a custom protocol. There are several teams working with different integrations, however they all need to connect to that system. One team can develop a software module to enable the WSO2 integration runtime to connect to that system. Question is, how they can develop it in a way that other teams can also reuse it. 

Developing a connector is the solution here. The other teams can use the operations exposed by it in the way they need. Connectors are like libraries for the mediation engine. Connector project can be versioned and maintained. When integration logic is compiled into a deployable artifact, relevant versions can be imported. 

<img src="{{base_path}}/assets/img/integrate/connectors/why-connectors3.png" title="Reusable modules" width="500" alt="Reusable modules"/>

CAppA and CAppB are developed by two different teams and contain different integration logic. However, underneath they share the same connector. 

### Legacy modernization and custom integration 

The WSO2 integration runtime is shipped with a set of inbound and outbound transports and with the support to integrate with popular protocols (i.e HTTP, JMS, AMQP, SMTP). However, there are instances where it needs to support custom protocols and custom logic that are not supported by the runtime by default. In such instances, writing a connector is one of the extension points available. Developers can plug and play connectors.

This brings the capability of fulfilling legacy modernization requirements. Brownfield integration is a major part of that. As enterprises are interested in accelerating their digital transformation, they tend to integrate new technologies with legacy technologies rather than waiting until all legacy technologies are transformed to new ones. 

## WSO2 Integration Studio support 

WSO2 Integration Studio is the tooling or the IDE that developers use to code their integration logic. Integration connectors can be easily imported and immediately used in WSO2 Integration Studio. When the connector UI model is provided in the connector, all custom operations and their properties will get rendered in WSO2 Integration Studio automatically. Any integration logic developer can use it with WSO2 Integration Studio so that the connector developer does not need to worry about it as long as development rules are met. 

<img src="{{base_path}}/assets/img/integrate/connectors/why-connectors4.png" title="Integration Studio Connectors" width="600" alt="Integration Studio Connectors"/>

Operations of the WSO2 connector that you import are listed on the right-side panel. Developers can drag and drop connector operations to construct the integration logic. Input parameters to the operations can be provided as static values or expressions using the properties panel that appears when the connector operation is clicked. 

## What's Next?

* [Learn how to write a connector from scratch]({{base_path}}/reference/connectors/develop-connectors/) 
* Publication process for connectors 
* [Connector best practices and Integration Studio]({{base_path}}/reference/connectors/connector-usage/) 