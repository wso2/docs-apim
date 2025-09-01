# Custom Connector

When onboarding a custom AI service provider to API Manager, you have the option to either use the built-in <a href='https://github.com/wso2/carbon-apimgt/blob/master/components/apimgt/org.wso2.carbon.apimgt.api/src/main/java/org/wso2/carbon/apimgt/api/DefaultLLMProviderService.java'>`default`</a> connector or write your own custom connector.

This guide provides step-by-step instructions for creating and deploying a custom AI service provider connector in WSO2 API Manager.

## Step 1 - AI Service Provider Connector Bundle Creation

1. Set up a Maven project.

    You can download a sample Maven project from [here]({{base_path}}/assets/attachments/administer/llm.provider.connector.zip).

    When manually creating a maven project, you will need to define a class that implements the `LLMProviderService` interface that is responsible of handling request/response payloads specific to AI service providers.

2. Implement `LLMProviderService`.

    The following are the methods that the `LLMProviderService` interface uses to carry out various related operations.

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
        <td><strong>getResponseMetadata</strong></td>
        <td><p>
        This method is responsible for extracting metadata from the response, which may be present in the response payload, headers, or query parameters. It takes the response payload and headers as input, along with a list of metadata keys that need to be extracted. The method processes the input data and returns a map containing the extracted metadata. If the extraction fails for any reason, it throws an <code>APIManagementException</code>, ensuring the error is captured and handled appropriately.
        </p></td>
        </tr>
        <tr class="even">
        <td><strong>getRequestMetadata</strong></td>
        <td><p>
        This method is used to extract metadata from the request, similar to how <strong>getResponseMetadata</strong> works for responses. It takes the request payload, headers, and query parameters, along with a list of metadata keys that need to be extracted. The method processes these inputs and returns a map containing the extracted metadata. In case of failure during extraction, it throws an <code>APIManagementException</code>, ensuring the issue is properly managed.
        </p></td>
        </tr>
        <tr class="odd">
        <td><strong>getType</strong></td>
        <td><p>This method retrieves the connector type for the custom Large Language Model (LLM) provider. It returns a string that corresponds to the connector type configured in the admin portal under the "Connector Type for AI Service Provider" section. The string returned by this method ensures that the correct custom LLM provider is used during interactions between the system and the AI service provider.</p></td>
        </tr>
        <tr class="even">
        <td><strong>registerLLMProvider</strong></td>
        <td><p>This method handles the registration of a new custom LLM provider. It programmatically onboard's the provider during the startup process. If the LLM provider is being onboarded manually through the admin portal, the method can return null. The method accepts the organization's name and the path to the API definition file associated with the provider, and it returns an instance of <strong>LLMProvider</strong> representing the newly registered provider. If any errors occur during the registration process, the method throws an <strong>APIManagementException</strong>.
        </p></td>
        </tr>
        </tbody>
    </table>

3. Build the project.

    Once you've implemented the necessary methods, navigate to the `<PROJECT_HOME>` directory and execute the following command.

    `mvn clean install`

    This will create a custom AI service provider connector JAR.

## Step 2 - Deploy the bundle in the WSO2 API-M Server

1. Stop the API-M server if it is already running. 

2. Copy the JAR file that is generated in the `custom.llm.provider` component target directory, and add it in to the `<API-M Server>/repository/components/dropins/` directory.

3. Start the Server.
