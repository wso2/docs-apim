# Template Properties
## Introduction

A large number of configuration files in the form of [sequences]({{base_path}}/reference/synapse-properties/sequence-properties), [endpoints]({{base_path}}/reference/synapse-properties/endpoint-properties), [proxy services]({{base_path}}/reference/synapse-properties/proxy-service-properties), and transformations can be required to satisfy all the mediation requirements of your system. To keep your configurations manageable, it's important to avoid scattering configuration files across different locations and to avoid duplicating redundant configurations.

Templates help minimize this redundancy by creating prototypes that users can use and reuse when needed. This is very much analogous to classes and instances of classes: a template is a class that can be used to wield instance objects such as [sequences]({{base_path}}/reference/synapse-properties/sequence-properties) and [endpoints]({{base_path}}/reference/synapse-properties/endpoint-properties). Thus, templates are an ideal way to improve reusability and readability of configurations/XMLs. Additionally, users can use predefined templates that reflect common enterprise integration patterns for rapid development of message/mediation flows.

<table>
    <tr>
        <th>Template Type</th>
        <th>Description</th>
    </tr>
    <tr>
        <td>Endpoint Template</td>
        <td>
            Endpoint template is a generalized form of endpoint configurations. It parameterizes a list of endpoint configurations. This allows a mediation flow to use the template parameters to select specific endpoint configurations (defined in the template) and apply them to the mediation flow.</br></br>
            Unlike <a href="{{base_path}}/reference/synapse-properties/template-properties/#sequence_template">sequence templates</a>, endpoint templates are always parametrized using <code>$</code> prefixed values (not XPath expressions). Once an endpoint template is created, it can be referred in a mediation flow through a Template Endpoint. Therefore, the template endpoint is the artifact that translates this template into a concrete endpoint. This is semantically similar to the relationship between a <a href="#sequence_template">sequence template</a> and the Call Template Mediator.
        </td>
    </tr>
    <tr>
        <td id='sequence_template'>Sequence Template</td>
        <td>
            This is a parametrized <b>sequence</b> providing an abstract or generic form of a sequence defined in the Micro Integrator. Parameters of a template are defined in the form of XPath statements. Callers can invoke the template by populating the parameters with static values/XPath expressions using the <b>Call Template</b> mediator, which makes a sequence template into a concrete sequence.
        </td>
    </tr>
</table>

See the topics given below for the list of properties that can be configured when you create an artifact template.

## Sequence Template Properties

The parameters available to [configure the Sequence Template]({{base_path}}/integrate/develop/creating-artifacts/creating-sequence-templates.md) are as follows.

<table>
    <tr>
        <th>
            Parameter
        </th>
        <th>
            Description
        </th>
    </tr>
    <tr>
        <td>
            Name
        </td>
        <td>
            The name of the Sequence Template.
        </td>
    </tr>
    <tr>
        <td>
           onError 
        </td>
        <td>
           Select the error sequence that needs to be invoked. 
        </td>
    </tr>
    <tr>
        <td>
           Trace Enabled 
        </td>
        <td>
            Whether or not trace is to be enabled for the sequence. 
        </td>
    </tr>
    <tr>
        <td>
           Statistics Enabled 
        </td>
        <td>
            Whether or not statistics is to be enabled for the sequence.
        </td>
    </tr>
    <tr>
        <td>
            Template Parameters
        </td>
        <td>
            The input parameter that are supported by this Sequence Template.
        </td>
    </tr>
    <tr>
        <td>
            isMandatory
        </td>
        <td>
            Set this parameter to 'true' if a value is required to be passed for the configuration.</br></br>
            When this parameter is 'true', if a value is not passed from a Call Template mediator as shown below, the Micro Integrator will first check for a <a href="#defaultValue">defaultvalue</a>. If a <a href="#defaultValue">defaultValue</a> does not exist, the 'onError' sequence of the <a href="{{base_path}}/reference/synapse-properties/template-properties/call-Template-Mediator">Call Template mediator</a> will be called.</br></br>
            If an empty value is passed in the Call Template mediator, the empty value will be used instead of using the default value.</br></br>
            See the <a href="{{base_path}}/integrate/examples/template_examples/using-sequence-templates/">example use cases</a> for details.
        </td>
    </tr>
    <tr id="defaultValue">
        <td>
            defaultValue
        </td>
        <td>
            Specifies a default value that should apply when a value is not passed when calling the template. See the <a href="{{base_path}}/integrate/examples/template_examples/using-sequence-templates/">example use cases</a> for details.
        </td>
    </tr>
</table>

## Endpoint Template Properties

The basic parameters available to [configure the Endpoint template]({{base_path}}/integrate/develop/creating-artifacts/creating-endpoint-templates.md) are as follows.

<table>
  <tr>
    <th>Parameter</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>Name</td>
    <td>The name of the Endpoint template. This name will be referred by Template Endpoint to access the parameters defined within the Endpoint template.</td>
  </tr>
  <tr>
    <td>Parameter Value</td>
    <td>Parameters added to the endpoint template. As the endpoint defined within the endpoint template is parameterized using these parameters. Therefore, these can be accessed from Template Endpoints.</td>
  </tr>
</table>

### Endpoint Properties (Required)

An Endpoint Template contains an **Endpoint** artifact. The following Endpoint properties are required depending on the template type:

<table>
        <tr>
            <th>Template Type</th>
            <th>Description</th>
        </tr>
        <tr>
            <td><b>Address Endpoint Template</b></td>
            <td>
                The following information needs to be specified:
                <ul>
                    <li><b>Template Name</b>: The unique name for the endpoint template.</li>
                    <li><b>Name</b>: A name for the inline endpoint.</li>
                    <li><b>Address</b>: The URL of the template endpoint. This can be a parametrized value such as <code>$uri</code>.</li>
                </ul>
            </td>
        </tr>
        <tr>
            <td><b>Default Endpoint Template</b></td>
            <td>
                The following information needs to be specified:
                <ul>
                    <li><b>Template Name</b>: The unique name for the endpoint template.</li>
                    <li><b>Name</b>: A name for the inline endpoint.</li>
                </ul>
            </td>
        </tr>
        <tr>
            <td><b>WSDL Endpoint Template</b></td>
            <td>
                The following information needs to be specified:
                <ul>
                    <li><b>Template Name</b>: The unique name for the template.</li>
                    <li><b>Name</b>: A name for the inline endpoint.</li>
                    <li><b>Specify As</b>: The method to specify the WSDL. The available values are as follows:
                        <ul>
                            <li><b>In-lined WSDL</b>: Paste the WSDL in the text box that appears when this option is selected.
                            </li>
                            <li><b>URI</b>: Activates the WSDL URI field.</li>
                        </ul>
                    </li>
                    <li><b>WSDL URI</b>: The URI of the WSDL.</li>
                    <li><b>Service</b>: The service selected from the available services for the WSDL.</li>
                    <li><b>Port</b>: The port selected for the service specified in the above
                        field. In a WSDL an endpoint is bound to each port inside each service.
                    </li>
                </ul>
            </td>
        </tr>
        <tr>
            <td><b>HTTP Endpoint Template</b></td>
            <td>
                You can define a URI template based REST service endpoint. The Endpoint Template has the following options:
                <ul>
                    <li><b>Template Name</b>: The unique name for the endpoint template.</li>
                    <li><b>Name</b>: A name for the inline endpoint.</li>
                    <li><b>URI Template</b>: The URI template of the endpoint. Insert <code>uri.var.</code> before each variable.</li>
                </ul>
            </td>
        </tr>
    </table>

### Endpoint Properties (Optional)

To configure the other **Endpoint** properties of the inline Endpoint, see [Endpoint Properties](endpoint-properties.md).