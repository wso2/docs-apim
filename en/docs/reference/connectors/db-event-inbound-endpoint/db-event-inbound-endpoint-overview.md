# DB Event Inbound Endpoint Overview

Data is the most valuable asset in any business. Almost every cooperate system has an on-premise or cloud-based data storage facility. When the individual systems in a particular business are integrated together, sometimes they are coupled via database systems. For an example, one system can write data, while another system reads and processes them. In such instances, the systems may want to know if there are any changes to the data being performed by external parties or systems. 

Hence, for an enterprise integration platform it is a useful feature to be able to generate events based on the data changes. **DB Event Inbound Endpoint** is the DB event listener for `WSO2 Enterprise Integrator`. You can configure it with any popular Database systems such as `MySQL` and `Oracle` etc.

To see the DB Event Inbound Endpoint, navigate to the [connector store](https://store.wso2.com/store/assets/esbconnector/list) and search for "Event". **DB Event Listener** is the name of the connector that has this functionality.

<img src="{{base_path}}/assets/img/integrate/connectors/db-event-store.png" title="DB Event Listener Store" width="200" alt="DB Event Listener Store"/>

## Compatibility

| Connector Version | Supported WSO2 EI version |
| ------------- |-------------|
| 1.0.4    | EI, 7.1.0, EI 7.0.x, EI 6.6.0, EI 6.5.0, EI 6.4.0, EI 6.1.1 |

For older versions, see the details in the connector store.

## DB Event Inbound Endpoint

* **[DB Event Inbound Endpoint Example]({{base_path}}/reference/connectors/db-event-inbound-endpoint/db-event-inbound-endpoint-example.md)**: In this example you will learn how to configure `DB-event Inbound Endpoint` so that it can listen to data changes done to a `MySQL` table. 

* **[DB Event Inbound Endpoint Reference]({{base_path}}/reference/connectors/db-event-inbound-endpoint/db-event-inbound-endpoint-config.md)**: This documentation provides a reference guide for the DB Event Inbound Endpoint.

## How to contribute

As an open source project, WSO2 extensions welcome contributions from the community. 

To contribute to the code for this connector, create a pull request in the following repository. 

* [DB Event Inbound Endpoint GitHub repository](https://github.com/wso2-extensions/esb-inbound-dbevent)

Check the issue tracker for open issues that interest you. We look forward to receiving your contributions.
