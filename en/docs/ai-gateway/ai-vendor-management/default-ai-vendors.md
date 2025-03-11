# Default AI Vendors

WSO2 API Manager provides built-in support for three AI/LLM vendors:

- Mistral
- OpenAI
- Azure OpenAI

These default AI vendors come pre-configured within WSO2 API Manager, enabling seamless integration with their AI models. This out-of-the-box support simplifies API creation and ensures a smooth experience when working with AI services.

## Managing Default AI Vendor Configurations

The following configurations are **read-only** and you can view them by navigating to the **AI/LLM Vendors** section under the Admin Portal.

<table>
    <tr>
        <th>Category</th>
        <th>Field</th>
    </tr>
    <tr>
        <td>General Details</td>
        <td>
            Name</br>
            API Version</br>
            Description</br>
        </td>
    </tr>
    <tr>
        <td>LLM Configurations</td>
        <td>
            Request Model</br>
            Response Model</br>
            Prompt Token Count</br>
            Completion Token Count</br>
            Total Token Count</br>
            Remaining Token Count</br>
        </td>
    </tr>
    <tr>
        <td>LLM Provider Auth Configurations</td>
        <td>
            Auth Type: Header, Query Parameter or Unsecured</br>
            Auth Type Identifer: Header/Query Parameter Identifier</br>
        </td>
    </tr>
    <tr>
        <td>Connector Type for AI/LLM Vendor</td>
        <td>
            Connector Type
        </td>
    </tr>
</table>

Note that the following configurations can be updated.

<table>
    <tr>
        <th>Category</th>
        <th>Field</th>
    </tr>
    <tr>
        <td>API Definition</td>
        <td>AI vendor exposed API definition file</td>
    </tr>
    <tr>
        <td>Model List</td>
        <td>Add the list of models supported by the AI vendor. This list enables you to configure routing stratergies within your AI APIs.</td>
    </tr>
</table>
