# Exposing an Integration SOAP Service as a Managed API

Managed APIs refer to the APIs that are managed using WSO2 API Manager, namely REST APIs, GraphQL APIs, SOAP APIs, and Streaming APIs. This guide explains how to create a Proxy Service (SOAP backend) for the integration solution, generate relevant metadata for the corresponding Proxy service, publish the WSDL definition in the WSO2 API Manager Service Catalog and then creating a **SOAP Pass-Through API**.

Also, this demonstrates how the integration components and API management components of WSO2 API Manager work together to enable API-led integration.

## Let's get started!

Follow the steps given below to build this use case and try it out.

!!! Note
    For more information on generating metadata artifacts if you are using an older Integration Studio workspace, see [Generating Service Catalog Metadata Artifact]({{base_path}}/integrate/develop/generate-service-catalog-metadata).

### Step 1: Develop the integration service

Follow the instructions given in this section to create and configure the required artifacts.

1.  Download the relevant [WSO2 Integration Studio](https://wso2.com/api-management/tooling/) based on your operating system.
2.  Open **WSO2 Integration Studio**.
3.  Click **New Integration Project** in the **Getting Started** tab as shown below.

    <img src="{{base_path}}/assets/img/integrate/tutorials/common/create-integration-project.jpg" width="90%">

    This will open the <b>New Integration Project</b> dialog box.

4.  Enter `ProxyServiceSample` as the project name and select the following check boxes to create the required modules.
    -   **Create ESB Configs**
    -   **Create Composite Exporter**

5.  Click **Finish**.

    You can see the projects listed in the **Project Explorer** as shown below:

    <a href="{{base_path}}/assets/img/integrate/tutorials/service-catalog/expose-soap-service/project-explorer-service-catalog.png"><img src="{{base_path}}/assets/img/integrate/tutorials/service-catalog/expose-soap-service/project-explorer-service-catalog.png" width="40%"></a>

    !!! Note
        A **resources** folder is created in the `ProxyServiceSampleConfigs` project. This folder holds the metadata YAML files of the created proxy services. These YAML files will be uploaded to the Service Catalog later in this tutorial.   
    
6. Create a **Proxy Service** artifact.

    1.  In the project explorer, right-click **ProxyServiceSampleConfigs** and click **New -> Proxy Service**.
    2.  Follow the [Using a Simple Proxy Service]({{base_path}}/integrate/examples/proxy_service_examples/introduction-to-proxy-services.md) to create the StockQuoteProxy Proxy Service.
    3.  Enter the details given below to create a new Proxy Service.
        <table>
        <tr>
            <th>Property</th>
            <th>Value</th>
            <th>Description</th>
        </tr>
        <tr>
            <td>Name</td>
            <td><code>StockQuoteProxy</code></td>
            <td>
            The name of the Proxy Service.
            </td>
        </tr>
        <tr>
            <td>Save location</td>
            <td>
            ProxyServiceSampleConfigs
            </td>
            <td>
            This is the <b>ESB Config</b> module where the artifact will be saved.
            </td>
        </tr>
        </table>
                                                                      
    4.  Click **Finish**.

7.  Open the **Source** view of the StockQuoteProxy that you created and edit the integration solution.

    ```xml
    <?xml version="1.0" encoding="UTF-8"?>
    <proxy name="StockQuoteProxy" startOnLoad="true" transports="http https" xmlns="http://ws.apache.org/ns/synapse">
        <target>
            <endpoint>
                <address uri="http://localhost:9000/services/SimpleStockQuoteService"/>
            </endpoint>
            <inSequence>
                <log description="Request Log" level="custom">
                    <property name="Message" value="&quot;You have successfully invoked the StockQuoteProxy&quot;"/>
                </log>
            </inSequence>
            <outSequence>
                <send/>
            </outSequence>
            <faultSequence/>
        </target>
        <publishWSDL uri="file:/path/to/sample_proxy_1.wsdl"/>
    </proxy>
    ```

When the **StockQuoteProxy** is created, the following new file is created in the metadata folder. 

<table>
    <tr>
        <th>
            StockQuoteProxy_proxy_metadata.yaml
        </th>
        <td>
            This file contains the metadata of the integration service you created in the previous step.
        </td>
    </tr>
</table>

<img src="{{base_path}}/assets/img/integrate/tutorials/service-catalog/expose-soap-service/metadata-folder-service-catalog.png" width="40%">

### Step 2: Configure service metadata

Let's update the metadata of the integration service.

1.  Open the `StockQuoteProxy_proxy_metadata.yaml` file from the project explorer.
2.  Update the following values in the file.

    <table>
        <tr>
            <th>
                Parameter
            </th>
            <th>
                Value
            </th>
            <th>
                Description
            </th>
        </tr>
        <tr>
            <td>
                description
            </td>
            <td>
                <code>Response a sample payload from the service</code>
            </td>
            <td>
                Explain the purpose of the Proxy Service.
            </td>
        </tr>
        <tr>
            <td>
                serviceUrl
            </td>
            <td>
                <code>http://localhost:8290/services/StockQuoteProxy</code>
            </td>
            <td>
                This is the URL of the API when it gets deployed in the Micro Integrator. You (as the integration developer) may not know this URL during development. Therefore, you can parameterize the URL to be resolved later using environment variables. By default, the <code>{MI_HOST}</code> and <code>{MI_PORT}</code> values are parameterized with placeholders. In the runtime, if placeholder values are not defined server default hostname and http/https listener ports will be used.</br></br>
                You can configure the serviceUrl in the following ways:
                <ul>
                    <li>
                        Add the complete URL without parameters. For example: <code>http://localhost:8290/services/StockQuoteProxy</code>.</br>
                        <b>Let's use this option for this tutorial.</b>
                    </li>
                    <li>
                        Parameterize using the host and port combination. For example: <code>http://{MI_HOST}:{MI_PORT}/services/StockQuoteProxy</code>.
                    </li>
                    <li>
                        Parameterize using a preconfigured URL. For example: <code>http://{MI_URL}/services/StockQuoteProxy</code>.
                    </li>
                </ul>
            </td>
        </tr>
    </table>

    !!! Tip
        See the [Service Catalog API documentation]({{base_path}}/reference/product-apis/service-catalog-apis/service-catalog-v1/service-catalog-v1/) for more information on the metadata in the YAML file.

3.  <b>Important</b>: Be sure to change the `serviceUrl` from HTTPS to HTTP. This is required because the StockQuoteProxy is not secured.

4.  Leave the default values for the remaining parameters. 

### Step 3: Configure the Micro Integrator 

The Micro Integrator contains a client application, which automatically publishes artifacts to the **Service Catalog** in the **API Publisher** portal. 

Let's enable this client for the embedded Micro Integrator of WSO2 Integration Studio.

1.  Click the <b>Embedded Micro Integrator Configuration</b> (<img src="{{base_path}}/assets/img/integrate/tutorials/common/server-config-64x64.png" width="20">) icon on the upper menu to open the dialog box.
2.  Uncomment the `[[service_catalog]]` section as shown below and change the APIM server configurations accordingly. 

    !!! Tip
        The default username and password for connecting to the API gateway is `admin`.

    ```toml
    [[service_catalog]]
    apim_host = "https://localhost:9443"
    enable = true
    username = "admin"
    password = "admin"
    ```

3.  **Optionally**, you can encrypt the username and password for better security:

    1.  Update the configuration as shown below. 

        ```toml
        [secrets]
        userName = "[admin]"
        password = "[admin]"

        [[service_catalog]]
        apim_host = "https://localhost:9443"
        enable = true
        username = "$secret{username}"
        password = "$secret{password}"
        ```

    2.  Click **Encrypt Secrets**. 
    
    !!! Tip
        See [Encrypt static (embedded) server secrets]({{base_path}}/integrate/develop/using-embedded-micro-integrator/#encrypt-static-embedded-server-secrets) for details.

4.  Save the configurations.

5.  **Optionally**, inject environment variables to your Micro Integrator. Default in runtime, if placeholder `{MI_HOST}` and `{MI_PORT}` values are not defined server default hostname and http/https listener ports will be used.

    If you chose to parameterize the `serviceUrl` in the metadata file, you must inject the parameterized values as environment variables. Shown below are example placeholder values that you may have used in the `serviceUrl` followed by the corresponding environment variables. 

    ```bash
    {MI_HOST}  :  localhost
    {MI_PORT}  :  8290 #for http protocols. Otherwise 8253
    {MI_URL}   :  localhost:8290 #for http protocols. Otherwise localhost:8253
    ```

    !!! Tip
        See the instructions on [injecting environment variables to the embedded Micro Integrator]({{base_path}}/integrate/develop/using-embedded-micro-integrator/#injecting-environment-variables-to-embedded-micro-integrator).

### Step 4: Package the artifacts

Package the artifacts in your composite exporter module to be able to deploy the artifacts in the server.

1.  Open the `pom.xml` file of the **ProxyServiceSampleCompositeExporter** module.
2.  Ensure that the following artifact is selected in the POM file.

    -   `StockQuoteProxy`

3. By default, the `Publish to Service Catalog` checkbox is enabled. If not, please select the checkbox in the wizard so that it will include metadata files of the selected artifacts.

4. Save the changes.

### Step 5: Start the API Manager runtime

Let's start the API Manager runtime before starting the Micro Integrator.

1.  Download and set up [WSO2 API Manager](https://wso2.com/api-management/).
2.  Start the server.

### Step 6: Build and run the service

Let's deploy the [packaged artifacts](#step-3-package-the-artifacts) in the embedded Micro Integrator:

!!! Info
    When you do this step: 

    1.  The Micro Integrator first reads the metadata files. 
    2.  If you used placeholders in the metadata file, they are replaced with environment variable values.
    3.  It gets the WSDL 1 definition of the deployed proxy service from the 'serviceUrl' as in 'Step 2: Configure service metadata' and ZIP file is created along with the metadata file.
    3.  Finally, it uploads the metadata to the API management runtime.

1.  Right-click the composite exporter module and click **Export Project Artifacts and Run**.
2.  In the dialog box that opens, confirm that the required artifacts from the composite exporter module are selected.
3.  Click **Finish**.

The artifacts are deployed in the embedded Micro Integrator and the Micro Integrator starts. The integration service is also deployed in the **Service Catalog** during server startup. You will see the following in the server start-up log.

```bash
Successfully updated the service catalog
```


### Step 7: Create and Deploy the Proxy Service as a SOAP Pass-Through API

**Create the API**

Let's expose the integration service as a managed API. 

1.  Sign in to the API Publisher portal: `https://localhost:9443/publisher`. 

    !!! Tip
        Use `admin` as the username and password.

2.  You can also click the **hamburger** icon on the upper-left and click **Services** to see the available services.

    <img src="{{base_path}}/assets/img/integrate/tutorials/service-catalog/expose-soap-service/open-service-catalog.png" alt="open service catalag" width="40%">

3.  Open StockQuoteProxy from the above list.

    <img src="{{base_path}}/assets/img/integrate/tutorials/service-catalog/expose-soap-service/new-service-api-view.png" alt="API created from service catalog">

4.  Click **Create API** in the above screen to open the **Create API** dialog box.

    <img src="{{base_path}}/assets/img/integrate/tutorials/service-catalog/expose-soap-service/create-api-from-service.png" alt="create api dialog box">

5.  Specify an API name, context, and version, and then click **Create API**.

    !!! Tip
        You will find these values already populated based on the information in the integration service.

You can now see the new API's overview page.

<img src="{{base_path}}/assets/img/integrate/tutorials/service-catalog/expose-soap-service/api-overview.png" alt="new api view">

!!! Note
    -   You can use the left-hand navigation to explore the new API.
    -   Click **Endpoints** in the left-hand navigator. You will see that the new API uses the integration service deployed in the Micro Integrator as the endpoint (backend).
        <img src="{{base_path}}/assets/img/integrate/tutorials/service-catalog/expose-soap-service/endpoint-config-of-api.png" alt="endpoint view">

**Select business plans**

Let's allocate some business plans for the API.

1.  Go to the API overview and click **Business Plan**.

    <img src="{{base_path}}/assets/img/integrate/tutorials/service-catalog/api-overview-business-plan.png" alt="click to add business plan">

3.  Select at least one business plan for the API and save.
 
    <img src="{{base_path}}/assets/img/integrate/tutorials/service-catalog/expose-soap-service/api-business-plans.png" alt="add business plans to api">

**Deploy API in the Gateway**

Let's deploy the API in a gateway environment.

1.  Go to the API overview and click **Deploy**.
    
    !!! Tip
        This opens the **Deployment** tab in the left-hand navigator.
    
    <img src="{{base_path}}/assets/img/integrate/tutorials/service-catalog/api-overview-deployment.png" alt="open the deployment options">

2.  Click **Default** to specify the gateway environment and host.

    !!! Tip
        This setting deploys the API in Production as well as Sandbox gateways. Find out more about [gateway environments]({{base_path}}/deploy-and-publish/deploy-on-gateway/api-gateway/maintaining-separate-production-and-sandbox-gateways).

    <img src="{{base_path}}/assets/img/integrate/tutorials/service-catalog/expose-soap-service/api-deployment-revision.png" alt="select gateways for the deployment">

3.  **Optionally**, you can add a description.

4.  Click **Deploy**. 

You will now see the deployment as the first revision of the API:

<img src="{{base_path}}/assets/img/integrate/tutorials/service-catalog/expose-soap-service/api-gateway-deployment-summary.png" alt="api first revision">

### Step 8: Publish the API

Go to the API overview in the **Publisher** portal and click **Publish** for the `StockQuoteProxy` as shown below.

<img src="{{base_path}}/assets/img/integrate/tutorials/service-catalog/api-overview-publish.png">

The API is now available in the **Developer** portal for consumers to access.

### Step 9: Subscribe to the API

Now, let's assume you are an API consumer who wants to use the API. As a consumer, you need to first subscribe to the API.

1.  Sign in to the **Developer** portal: `https://localhost:9443/devportal/apis`. 

    !!! Tip
        Use `admin` as the username and password.

2.  Go to the **API** tab. The `StockQuoteProxy` is listed as shown below.

    <img src="{{base_path}}/assets/img/integrate/tutorials/service-catalog/expose-soap-service/developer-portal-api-list.png">

3.  Select the `StockQuoteProxy` to open the API overview.

    <img src="{{base_path}}/assets/img/integrate/tutorials/service-catalog/expose-soap-service/developer-portal-api-overview.png">

4.  Go to the **Subscriptions** tab and subscribe using the **DefaultApplication** as shown below.

    <img src="{{base_path}}/assets/img/integrate/tutorials/service-catalog/expose-soap-service/developer-portal-api-subscription.png">

!!! Tip
    For detailed instructions, see [Subscribe to an API]({{base_path}}/consume/manage-subscription/subscribe-to-an-api/).

### Step 10: Use the SOAP Pass-Through API

!!! Info "Before you begin"

    Let's start the back-end service.

    1. Download the [back-end service](https://github.com/wso2-docs/WSO2_EI/blob/master/Back-End-Service/axis2Server.zip).
    2. Extract the downloaded zip file.
    3. Open a terminal, navigate to the `axis2Server/bin/` directory inside the extracted folder.
    4. Execute the following command to start the axis2server with the SimpleStockQuote back-end service:
    
        ```bash tab='On MacOS/Linux/CentOS'
        sh axis2server.sh
        ```
    
        ```bash tab='On Windows'
        axis2server.bat
        ```

**Generate access token**

When you consume an API from the marketplace, your access to the API is authenticated. Therefore, the **DefaultApplication** that you used for subscribing to the API should get an access token for the gateway environment in which the API is deployed. Since the `StockQuoteProxy` is deployed in the Production gateway, you must generate **PROD** keys.

1.  Go to the **Subscriptions** tab for the `StockQuoteProxy` in the **Developer** portal.
2.  Click **PROD KEYS** for the **DefaultApplication**.

    <img src="{{base_path}}/assets/img/integrate/tutorials/service-catalog/developer-portal-api-generate-keys.png">

3.  Click **Generate Keys** (at the bottom of this view) to apply a consumer key and secret as shown below.

    !!! Note
        The application may already have a consumer key and secret generated. In this case, you can skip this step. 

    <img src="{{base_path}}/assets/img/integrate/tutorials/service-catalog/developer-portal-api-consumer-keys.png">

4.  Click **Generate Access Token** in the above view to generate the access token.

5.  Save the generated token.

**Try out the service**

Now, let's test the use case by sending a simple client request that invokes the service.

1.  Click **Try Out** for the `StockQuoteProxy` in the **Developer** portal as shown below.

    <img src="{{base_path}}/assets/img/integrate/tutorials/service-catalog/expose-soap-service/developer-portal-api-try-it.png">

2.  Enter the following details.

    <table>
        <tr>
            <th>
                Security Type
            </th>
            <td>
                Select <b>OAuth</b> as the security type.
            </td>
        </tr>
        <tr>
            <th>
                Applications
            </th>
            <td>
                Select <b>DefaultApplication</b> from the list of application.
            </td>
        </tr>
        <tr>
            <th>
                Key Type
            </th>
            <td>
                Select <b>Production</b> as the key type. This means that the production gateway (environment) is used.
            </td>
        </tr>
        <tr>
            <th>
                access.token
            </th>
            <td>
                Add the access token you generated for the <b>DefaultApplication</b>. You can also click <b>GET TEST KEY</b> to generate a test token.
            </td>
        </tr>
        <tr>
            <th>
                Gateway
            </th>
            <td>
                Select <b>Default</b> as the gateway.
            </td>
        </tr>
    </table>

3.  Expand the **/** POST resource and click **Try it out**.
4.  Let's specify 'urn:getQuote' as the SOAP Action.
5.  Let's input the following payload as the SOAP Request.
    ```xml
        <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="http://services.samples" xmlns:xsd="http://services.samples/xsd">
            <soapenv:Header/>
            <soapenv:Body>
              <ser:getQuote>
                 <ser:request>
                    <xsd:symbol>IBM</xsd:symbol>
                 </ser:request>
              </ser:getQuote>
            </soapenv:Body>
        </soapenv:Envelope>
    ```
5.  Click **Execute**.

    <img src="{{base_path}}/assets/img/integrate/tutorials/service-catalog/expose-soap-service/developer-portal-api-try-it-execute.png">

You will get the response message from the StockQuoteProxy service:

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">
    <soapenv:Header/>
    <soapenv:Body>
        <ns:getQuoteResponse xmlns:ns="http://services.samples">
            <ns:return xsi:type="ax21:GetQuoteResponse" xmlns:ax21="http://services.samples/xsd" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
                <ax21:change>3.9976027101114964</ax21:change>
                <ax21:earnings>13.346364457377131</ax21:earnings>
                <ax21:high>-73.39500514990955</ax21:high>
                <ax21:last>73.6913265107944</ax21:last>
                <ax21:lastTradeTimestamp>Fri Sep 24 22:10:56 IST 2021</ax21:lastTradeTimestamp>
                <ax21:low>-71.88761385784731</ax21:low>
                <ax21:marketCap>4.3004624870633185E7</ax21:marketCap>
                <ax21:name>IBM Company</ax21:name>
                <ax21:open>-71.86467758088759</ax21:open>
                <ax21:peRatio>24.390401836247552</ax21:peRatio>
                <ax21:percentageChange>-5.715833533678435</ax21:percentageChange>
                <ax21:prevClose>-69.93910313442652</ax21:prevClose>
                <ax21:symbol>IBM</ax21:symbol>
                <ax21:volume>8029</ax21:volume>
            </ns:return>
        </ns:getQuoteResponse>
    </soapenv:Body>
</soapenv:Envelope>
```

Now, check the **Console** tab of WSO2 Integration Studio and you will see the following message:

```bash
INFO - LogMediator Message = "You have successfully invoked the StockQuoteProxy"
```

!!! Tip
    For detailed instructions see [Invoke an API using the Integrated API Console]({{base_path}}/consume/invoke-apis/invoke-apis-using-tools/invoke-an-api-using-the-integrated-api-console/).
