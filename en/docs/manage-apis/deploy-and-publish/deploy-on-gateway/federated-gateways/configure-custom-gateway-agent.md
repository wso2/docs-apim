# Configure a Custom Gateway Agent

WSO2 API Manager is capable of deploying APIs to external third party API Gateways. Essentially, if the API Provider wants to deploy their APIs a third party gateway that is not supported OOTB by WSO2 API-M, you need to use a custom Gateway Agent. To configure a custom Gateway Agent, you need to do the following:

- Write a custom Gateway Agent
- Deploy the custom Gateway Agent in API Manager
- Register the relevant API Gateway in the Admin Portal by providing the required details.
- Create and deploy API in the third party API Gateway from API-M Publisher Portal.

Refer to the instructions below to do the configurations.

## Step 1 - Create a Gateway Agent bundle

You need to write a custom Gateway Agent bundle as explained below.

!!! tip
    The following is a out-of-the-box agent that you can use as references.

      - [AWS GW Agent](https://github.com/wso2-extensions/apim-gw-agents/tree/main/aws)

1. Create a Maven project.

    Let's download the sample project from [here](../../../../assets/attachments/deploy-and-publish/custom.gw.client.zip).

    However, when manually creating a Maven project, you will need to follow the following steps.

    1. Define a class that implements the `GatewayAgentConfiguration` interface that is responsible for managing the configurations related to the Gateway Instance.

    2. Define a class that extends the `GatewayDeployer` interface which is responsible for creating external gateway artifacts and deploying the API.

2. Implement `GatewayAgentConfiguration`.

    In the sample project, this has been implemented in the `org.wso2.customgw.client.CustomGatewayConfiguration.java` class.

    The following are the methods that the `GatewayAgentConfiguration` interface uses to carry out various related operations.

    <table>
    <colgroup>
    <col width="30%" />
    <col width="70%" />
    </colgroup>
    <thead>
    <tr class="header">
    <th><b>Method</b></th>
    <th><b>Description</b></th>
    </tr>
    </thead>
    <tbody>
    <tr class="odd">
    <td><strong>getImplementation</strong></td>
    <td><p>Provides the fully qualified class name of the implementation that corresponds to the `GatewayDeployer` interface.</p></td>
    </tr>
    <tr class="even">
    <td><strong>getConnectionConfigurations</strong></td>
    <td><p>Provides the list of configurations that need to appear in the Admin Portal in order to connect with the Management API of the third party Gateway.</p></td>
    </tr>
    <tr class="odd">
    <td><strong>getGatewayFeatureCatalog</strong></td>
    <td><p>Provides the list of portal features supported by the third party gateway. Portal UIs will be rendered based on the availability of features. Please refer [Universal Gateway Feature Catalog](https://github.com/wso2/carbon-apimgt/blob/v9.31.86/components/apimgt/org.wso2.carbon.apimgt.impl/src/main/resources/gatewayFeatureCatalog/synapse-gateway-feature-catalog.json) to see how to do this configuration.
    </p></td>
    </tr>
    <tr class="even">
    <td><strong>getType</strong></td>
    <td><p>Type of gateway agent. For example, AWS.</p></td>
    </tr>
    <tr class="odd">
    <td><strong>getDefaultHostnameTemplate</strong></td>
    <td><p>Provides the base URL of the Gateway instance</p></td>
    </tr>
    </tbody>
    </table>  

3. Implement `GatewayDeployer`.

    In the sample project, this has been implemented in the `org.wso2.customgw.client.CustomGatewayDeployer.java` class.

    The following are the methods that the `GatewayDeployer` interface uses to carry out various related operations.
    
    <table>
    <colgroup>
    <col width="30%" />
    <col width="70%" />
    </colgroup>
    <thead>
    <tr class="header">
    <th><b>Method</b></th>
    <th><b>Description</b></th>
    </tr>
    </thead>
    <tbody>
    <tr class="odd">
    <td><strong>init</strong></td>
    <td><p>Loads Gateway Agent configurations and create client objects to communicate with the external gateway's management API.</p></td>
    </tr>
    <tr class="even">
    <td><strong>getType</strong></td>
    <td><p>Type of gateway agent. For example, AWS.</p></td>
    </tr>
    <tr class="odd">
    <td><strong>deploy</strong></td>
    <td><p>Deploy API in custom gateway.</p></td>
    </tr>
    <tr class="even">
    <td><strong>undeploy</strong></td>
    <td><p>Deploy a previously deployed API in custom gateway.
    </p></td>
    </tr>
    <tr class="odd">
    <td><strong>validateApi</strong></td>
    <td><p>Performs initial validations before deploying API.</p></td>
    </tr>
    <tr class="even">
    <td><strong>getAPIExecutionURL</strong></td>
    <td><p>Provides the execution URL of the API deployed in custom gateway. Gateway URL displayed on the devportal tryout will be generated using this method's output.</p></td>
    </tr>
    <tr class="odd">
    <td><strong>transformAPI</strong></td>
    <td><p>Transforms API before deploying to gateway.</p></td>
    </tr>
    </tbody>
    </table>

4. Build the project.

    Navigate to the `<PROJECT_HOME>` directory and execute the following command.

    `mvn clean install`

    This will create a custom Gateway Agent JAR.

## Step 2 - Deploy the bundle in the WSO2 API-M Server

1. Stop the API-M server if it is already running.

2. Copy the JAR file that is generated in the `custom.gw.manager` component target directory, and add it in to the `<API-M Server>/repository/components/dropins/` directory.

3. Start the Server

## Step 3 - Configure the Gateway using the Admin Portal

1. Sign in to the Admin Portal using the following URL: `https://<hostname>:9443/admin`

2. Add a new Gateway.

    1. Click **Gateways** and then click **Add Gateway Environment**.

        [![Add new Gateway Environment]({{base_path}}/assets/img/deploy/add-custom-gateway-environment.png)]({{base_path}}/assets/img/deploy/add-custom-gateway-environment.png)

## Step 4 - Create and Deploy API

1. Sign in to the Publisher Portal using the following URL: `https://<hostname>:9443/publisher`

2. Create a new API. Select the custom gateway from the gateway list.

   [![Create API]({{base_path}}/assets/img/deploy/create-custom-gateway-api.png)]({{base_path}}/assets/img/deploy/create-custom-gateway-api.png)

3. Navigate to deployments tab, select the custom gateway environment registered in step 3 and deploy API to custom gateway.

   [![Deploy API]({{base_path}}/assets/img/deploy/deploy-custom-gateway-api.png)]({{base_path}}/assets/img/deploy/deploy-custom-gateway-api.png)