# Proxy Services
## Introduction

Proxy services are virtual services that receive messages and optionally process them before forwarding them to a service at a given endpoint. This approach allows you to perform necessary transformations and introduce additional functionality without changing your existing service. 

Just as [REST APIs]({{base_path}}/reference/synapse-properties/rest-api-properties) and [Inbound Endpoints]({{base_path}}/reference/synapse-properties/inbound-endpoints/about-inbound-endpoints), the proxy service uses [mediators]({{base_path}}/reference/mediators/about-mediators) and [sequences]({{base_path}}/reference/synapse-properties/sequence-properties) to define the mediation logic for processing messages. You can also enabling WS-Security to a proxy service, so that it serves as a security gateway to your actual services. The [In]({{base_path}}/reference/synapse-properties/sequence-properties/#inout-sequences) sequence handles incoming requests and sends them to the back-end service, and the [Out]({{base_path}}/reference/synapse-properties/sequence-properties/#inout-sequences) sequence handles the responses from the back-end service and sends them to the requesting client. You can also define a [fault sequence]({{base_path}}/reference/synapse-properties/sequence-properties#fault-sequences) to handle any errors that may occur while mediating a message through a resource.

Any available transport can be used to receive and send messages from the proxy services. A proxy service is externally visible and can be accessed using a URL similar to a normal web service address.

## Properties

See the topics given below for the list of properties that can be configured when [creating a proxy service]({{base_path}}/integrate/develop/creating-artifacts/creating-a-proxy-service.md).

### General Properties

Listed below are the main properties that are required when [creating a proxy service]({{base_path}}/integrate/develop/creating-artifacts/creating-a-proxy-service.md) of any type.

<table>
  <tr>
    <th>Property</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>Proxy Servive Name</td>
    <td>A unique name for the proxy service.</td>
  </tr>
  <tr>
    <td>Transports</td>
    <td>
      The transport protocols that are used to receive messages. Once you have selected the required transports, you can later add <a href="#service-parameters">service parameters</a> relevant to each transport type.
    </td>
  </tr>
  <tr>
    <td>Target Endpoint</td>
    <td>
      The proxy service uses an <b>Endpoint</b> artifact inline to define the location to which messages should be routed. You can choose one of the following options to specify the endpoint.
      <ul>
        <li>Enter the URL of the endpoint.</li>
        <li>If you have a <a href="{{base_path}}/integrate/develop/creating-artifacts/creating-endpoints">predefined <b>Endpoint</b></a> artifact in WSO2 Integration Studio, provide the name of the artifact.</li>
        <li>If you have a predefined <b>Endpoint</b> artifact that is saved in the <a href="{{base_path}}/concepts/registry-concepts">registry</a>, provide the link to the artifact.</li>
      </ul>
      See <a href="{{base_path}}/reference/synapse-properties/endpoint-properties">Endpoint Properties</a> for the complete list of properties you can define for the Endpoint artifact.
    </td>
  </tr>
</table>

### Logging Properties

The following properties are required when [creating a logging proxy service]({{base_path}}/integrate/develop/creating-artifacts/creating-a-proxy-service.md):

<table>
  <tr>
    <th>Property</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>Target Endpoint</td>
    <td>
      See the descriptions of <a href="#general-properties">general properties</a>
    </td>
  </tr>
  <tr>
    <td>Transports</td>
    <td>
      See the descriptions of <a href="#general-properties">general properties</a>
    </td>
  </tr>
  <tr>
    <td>Request Log Level</td>
    <td>
      This is the log level used for logging the request message.
      <ul>
        <li>
          <strong>Simple</strong> logs <code>               To              </code> , <code>               From              </code> , <code>               WSAction              </code> , <code>               SOAPAction              </code> , <code>               ReplyTo              </code> , <code>               MessageID              </code> , and any properties.
        </li>
        <li>
          <strong>Full</strong> logs all attributes of the message plus the SOAP envelope information.
        </li>
      </ul>
    </td>
  </tr>
  <tr>
    <td>Response Log Level</td>
    <td>
      This is the log level used for logging the response message.
      <ul>
        <li>
          <strong>Simple</strong> logs <code>               To              </code> , <code>               From              </code> , <code>               WSAction              </code> , <code>               SOAPAction              </code> , <code>               ReplyTo              </code> , <code>               MessageID              </code> , and any properties.
        </li>
        <li>
          <strong>Full</strong> logs all attributes of the message plus the SOAP envelope information.
        </li>
      </ul>
    </td>
  </tr>
</table>

### WSDL Properties

The following properties are required when [creating a WSDL-based proxy service]({{base_path}}/integrate/develop/creating-artifacts/creating-a-proxy-service.md):

<table>
  <tr>
    <th>Property</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>Transports</td>
    <td>
      See the descriptions of <a href="#general-properties">general properties</a>
    </td>
  </tr>
  <tr>
    <td>WSDL URI</td>
    <td>
      The URL and the URN of the WSDL. The URL defines the host address of the network resource (can be omitted if resources are not network homed), and the URN defines the resource name in local namespaces. For example, if the URL is <code>ftp://ftp.dlink.ru</code> and the URN is <code>/pub/ADSL/</code>, you would enter <code>ftp://ftp.dlink.ru/pub/ADSL/</code> for the URI.
    </td>
  </tr>
  <tr>
    <td>WSDL Service</td>
    <td>
      The WSDL service name.
    </td>
  </tr>
  <tr>
    <td>WSDL Port</td>
    <td>
      The port of the WSDL.
    </td>
  </tr>
  <tr>
    <td>Publish Same Service Contract</td>
    <td>
      Select this option if you want to publish this WSDL.
    </td>
  </tr>
</table>

### Transformer Proxy Properties

The following properties are required when [creating a transformer proxy service]({{base_path}}/integrate/develop/creating-artifacts/creating-a-proxy-service.md):

<table>
  <tr>
    <th>Property</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>Transports</td>
    <td>
      See the descriptions of <a href="#general-properties">general properties</a>
    </td>
  </tr>
  <tr>
    <td>Target Endpoint</td>
    <td>
      See the descriptions of <a href="#general-properties">general properties</a>
    </td>
  </tr>
  <tr>
    <td>Request XSLT</td>
    <td>Specify the location of the XSLT you want to use for transformining incoming request messages.</td>
  </tr>
  <tr>
    <td>Transform Responses</td>
    <td>Select this option if you want the Micro Integrator to transform response messages that are sent back to the client.</td>
  </tr>
  <tr>
    <td>Response XSLT</td>
    <td>
      Specify the location of the XSLT you want to use for transformining response messages.
    </td>
  </tr>
</table>

### Service Parameters

- See the list of transport parameters you can configure at service level for a proxy service:

    - [JMS properties]({{base_path}}/reference/synapse-properties/transport-parameters/jms-transport-parameters)
    - [MailTo properties]({{base_path}}/reference/synapse-properties/transport-parameters/mailto-transport-parameters)
    - [MQTT properties]({{base_path}}/reference/synapse-properties/transport-parameters/mqtt-transport-parameters)
    - [RabbitMQ properties]({{base_path}}/reference/synapse-properties/transport-parameters/rabbitmq-transport-parameters)
    - [VFS properties]({{base_path}}/reference/synapse-properties/transport-parameters/vfs-transport-parameters)
    - [Fix properties]({{base_path}}/reference/synapse-properties/transport-parameters/fix-transport-parameters)

- You can also configure the following service-level property to expose an [Inbound Endpoint]({{base_path}}/concepts/message-entry-points/#inbound-endpoints) through a proxy service:
  <table>
     <tr>
        <th>Service Parameter</th>
        <th>Description</th>
     </tr>
     <tr>
        <td>inbound.only</td>
        <td>
              Whether the proxy service needs to be exposed only via inbound endpoints. If set to <code>true</code> all requests that the proxy service receives via normal transport will be rejected. The proxy service will process only the requests that are received via inbound endpoints.</br></br> The default setting is <code>false</code>.
        </td>
     </tr>
  </table>

- To publish a custom WSDL for a proxy service, select one of the WSDL types.
    <table>
    <thead>
    <tr class="header">
    <th>WSDL Type</th>
    <th>Description</th>
    </tr>
    </thead>
    <tbody>
    <tr class="odd">
    <td>INLINE</td>
    <td>Enter the WSDL definition in the <strong>WSDL XML</strong> field.</td>
    </tr>
    <tr class="even">
    <td>SOURCE_URL</td>
    <td><p>Enter the URI of the WSDL in the text box, and then click <strong>Test URI</strong> to ensure it is available. A URI consists of a URL and URN. The URL defines the host address of the network resource (can be omitted if resources are not network homed), and the URN defines the resource name in local "namespaces."</p>
    <p>For example URI = <code>                                 ftp://ftp.dlink.ru/pub/ADSL                                , w               </code> here URL = <code>                                 ftp://ftp.dlink.ru                               </code> and URN = <code>                pub/ADSL               </code></p></td>
    </tr>
    <tr class="odd">
    <td>REGISTRY_KEY</td>
    <td><div class="content-wrapper">
    <p>If the WSDL is saved as a registry entry, select this option and choose the reference key of that registry entry from the governance Registry or configuration Registry.</p>
    </div></td>
    </tr>
    <tr class="even">
    <td>ENDPOINT</td>
    <td>-</td>
    </tr>
    </tbody>
    </table>

    Following are additional service parameters you can use to configure the service WSDL.
    <table>
    <thead>
    <tr class="header">
    <th><p>Parameter</p></th>
    <th><p>Description</p></th>
    </tr>
    </thead>
    <tbody>
    <tr class="odd">
    <td><p>useOriginalwsdl</p></td>
    <td><div class="content-wrapper">
    <p>If this parameter is set to <code>                 true                </code> , the original WSDL published via the <code>                 publishWSDL                </code> parameter is used instead of the custom WSDL.</p>
    </div></td>
    </tr>
    <tr class="even">
    <td><p>modifyUserWSDLPortAddress</p></td>
    <td><p>If true (default), the port addresses will be modified to the current host. Effective only with <code>                useOriginalwsdl=true               </code> .</p></td>
    </tr>
    <tr class="odd">
    <td>ApplicationXMLBuilder.allowDTD</td>
    <td>If this parameter is set to true, it enables data type definition processing for the proxy service.<br />
    Data type definition processing is disabled in the Axis2 engine due to security vulnerability. This parameter enables it for individual proxy services.</td>
    </tr>
    <tr class="even">
    <td><p>enablePublishWSDLSafeMode</p></td>
    <td><div class="content-wrapper">
    <p>If this parameter is set to <code>                 true                </code> when deploying a proxy service, even though the WSDL is not available, you can prevent the proxy service from being faulty. However, the deployed proxy service will be inaccessible since the WSDL is not available.</p>
        <p><b>Note</b> that this is only applicable when you publish the WSDL (i.e., via the <code>                 publishWSDL                </code> property) either as a URI or as an endpoint.</p>

    </div></td>
    </tr>
    <tr class="odd">
    <td>showAbsoluteSchemaURL</td>
    <td>If this parameter is set to <code>               true              </code> , the absolute path of the referred schemas of the WSDL is shown instead of the relative paths.</td>
    </tr>
    <tr class="even">
    <td>showProxySchemaURL</td>
    <td>If this parameter is set to <code>               true              </code> , the full proxy URL will be set as the prefix to the schema location of the imports in proxy WSDL.</td>
    </tr>
    </tbody>
    </table>

    If your WSDL has dependencies with other resources (schemas or other
      WSDL documents), you can link them using the **Wsdl Resources**
      property. Click the **browse** icon and enter the
      registry key and the location of the dependent resource: The
      location is available in the WSDL. When you have the location, you
      can find registry key corresponding to the location from the
      registry.

    In the following example, the WSDL imports a metadata schema from
      the metadata.xsd file. Therefore, the location is metadata.xsd.

    ```xml
    <xsd:import namespace=http://www.wso2.org/test/10 schemaLocation="metadata.xsd" />
    ```

    In the following example, the WSDL is retrieved from the registry
    using the key `           my.wsdl          ` . This WSDL imports
    another WSDL from
    `                                    http://www.standards.org/standard.wsdl                                 `
    . This dependent WSDL is retrieved from the registry using the
    `           standard.wsdl          ` registry key.

    ```xml 
    <publishWSDL key="my.wsdl">
        <resource location="http://www.standards.org/standard.wsdl" key="standard.wsdl"/>
    </publishWSDL>
    ```