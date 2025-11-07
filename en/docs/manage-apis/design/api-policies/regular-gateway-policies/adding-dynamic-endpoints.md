# Adding Dynamic Endpoints

You cannot dynamically construct the back-end endpoint of an API using the address endpoints in the WSO2 API Manager. To achieve the requirement of a dynamic endpoint, you can use the default endpoint instead. 

[![Dynamic Endpoints]({{base_path}}/assets/img/learn/api-gateway/message-mediation/dynamic-endpoints.png)]({{base_path}}/assets/img/learn/api-gateway/message-mediation/dynamic-endpoints.png)  

The default endpoint sends the message to the address specified in the **To** header. The **To** header can be constructed dynamically. An example is given below.

!!! example
    ``` xml
    <sequence xmlns="http://ws.apache.org/ns/synapse" name="default-endpoint-seq">
        <property name="service_ep" expression="fn:concat('http://jsonplaceholder.typicode.com/', 'posts/')"/>
        <header name="To" expression="get-property('service_ep')"/>
    </sequence>
    ```

In this example, you have constructed the `service_ep` property dynamically and assigned the value of this property to the **To** header. The default endpoint sends the message to the address specified in the **To** header, in this case, 
`http://jsonplaceholder.typicode.com/posts/`. 

## Adding the To Header Policy

To implement the dynamic endpoint functionality, you need to create a custom API policy that sets the **To** header. Follow the steps below:

!!! info
    The dynamic endpoint functionality is suitable for scenarios where the application client can send an attribute in the request correlating to the intended endpoint (such as an HTTP transport header or as part of the payload), which can be used in the mediation extension.

!!! note
    The mediation extension is applied to all resources of the API. Therefore, all resources will contain a similar logic to construct the endpoint.

!!! tip
    For more details about working with dynamic endpoints, see [Endpoint Types]({{base_path}}/manage-apis/design/endpoints/endpoint-types).

### Step 1: Create the Policy File

1. Create a new file with a `.j2` or `.xml` extension (e.g., `dynamic-endpoint-policy.j2`) with the following content:

    !!! example
        ``` xml
        <property name="service_ep" expression="fn:concat('http://jsonplaceholder.typicode.com/', 'posts/')"/>
        <header name="To" expression="get-property('service_ep')"/>
        ```

    !!! note
        You can customize the `service_ep` property expression based on your requirements to dynamically construct the endpoint URL. The expression can use request parameters, headers, or payload data to determine the target endpoint.

### Step 2: Create a Common API Policy

1. Sign in to the WSO2 API Publisher.

    `https://<hostname>:9443/publisher`

2. Navigate to the **Policies** tab from the left menu and click **Add New Policy**.

3. Fill in the **General Details** section:

    <table>
        <tr>
            <th>Field</th>
            <th>Sample Value</th>
        </tr>
        <tr>
            <td>Name</td>
            <td>Dynamic Endpoint Policy</td>
        </tr>
        <tr>
            <td>Version</td>
            <td>v1</td>
        </tr>
        <tr>
            <td>Description</td>
            <td>Policy to set dynamic endpoint using To header</td>
        </tr>
        <tr>
            <td>Applicable Flows</td>
            <td>Request</td>
        </tr>
    </table>

4. In the **Gateway Specific Details** section:

    <table>
        <tr>
            <th>Field</th>
            <th>Value</th>
        </tr>
        <tr>
            <td>Supported Gateways</td>
            <td>Regular Gateway</td>
        </tr>
        <tr>
            <td>Supported API Types</td>
            <td>HTTP</td>
        </tr>
        <tr>
            <td>Upload Policy File</td>
            <td>Upload the <code>dynamic-endpoint-policy.j2</code> file you created in Step 1</td>
        </tr>
    </table>

5. Click **Save** to create the policy.

### Step 3: Attach the Policy to Your API

1. Navigate to your API in the Publisher Portal.

2. Go to **API Configurations** → **Policies**.

3. From the **Policy List**, drag and drop the **Dynamic Endpoint Policy** to the **Request Flow** of the desired API operation(s).

4. Click **Save** to apply the policy.

For more information on creating and attaching API policies, see:

- [Create a Policy]({{base_path}}/manage-apis/design/api-policies/create-policy/)
- [Attaching Policies]({{base_path}}/manage-apis/design/api-policies/attach-policy/)