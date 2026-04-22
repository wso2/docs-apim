# Develop and test custom policies

This guide explains how to develop and test custom policies locally before uploading them to API Manager. You can use the WSO2 Micro Integrator for Visual Studio Code extension to create and validate policy files on your local machine.

## Before you begin

Before you start developing custom policies, ensure you have the following prerequisites:

- Visual Studio Code installed on your machine
- Basic understanding of WSO2 Synapse mediators and XML configuration
- Familiarity with [policy creation concepts]({{base_path}}/design/api-policies/create-policy/)

## Set up your development environment

Follow these steps to configure your development environment for policy development.

### Install the Micro Integrator for VS Code extension

1. Open Visual Studio Code.

2. Navigate to the **Extensions** view by selecting the Extensions icon in the Activity Bar or pressing `Ctrl+Shift+X` (Windows/Linux) or `Cmd+Shift+X` (Mac).

3. Search for `WSO2 Micro Integrator` in the Extensions Marketplace.

4. Select **Install** to add the extension to your Visual Studio Code installation.

5. After installation completes, restart Visual Studio Code to activate the extension.

### Create a workspace for policy development

1. Create a new directory on your local machine for policy development. For example:

    ```bash
    mkdir apim-custom-policies
    cd apim-custom-policies
    ```

2. Open this directory in Visual Studio Code by selecting **File** > **Open Folder**.

3. Create a subdirectory to organize your policy files:

    ```bash
    mkdir policies
    ```

## Develop a custom policy

Custom policies for API Manager are XML-based configurations that use WSO2 Synapse mediators. You can create these files locally and test them before uploading.

### Create a policy file

1. In Visual Studio Code, create a new file in the `policies` directory. Use a descriptive name with either `.xml` or `.j2` extension. For example, `add-custom-header.xml`.

2. Add your policy logic using Synapse mediators. Here's an example policy that adds a custom header:

    ```xml
    <property action="set" name="Custom-Header" value="CustomValue" scope="transport" />
    ```

3. For policies with dynamic parameters, use Jinja2 template syntax (`.j2` extension):

    ```xml
    <property action="set" name="{{headerName}}" value="{{headerValue}}" scope="transport" />
    ```

4. Save the file.

### Validate your policy syntax

1. Ensure your policy file follows these requirements:

    - Remove XML prolog declarations. Don't include `<?xml version="1.0" encoding="UTF-8"?>` at the beginning of your file.
    - Start with a root mediator element or child elements directly.
    - Use valid Synapse mediator syntax.

2. Review the [list of unsupported mediators]({{base_path}}/design/api-policies/create-policy/) to ensure your policy doesn't use restricted mediators:

    - `Call` mediator in non-blocking mode
    - `Send` mediator

### Common policy examples

Here are examples of commonly used custom policies to help you get started.

#### Add request header

This policy adds a custom header to API requests:

```xml
<property action="set" name="X-Custom-Header" value="MyValue" scope="transport" />
```

#### Remove response header

This policy removes a specific header from API responses:

```xml
<property action="remove" name="Server" scope="transport" />
```

#### Log message payload

This policy logs the message payload for debugging:

```xml
<log level="full">
    <property name="MESSAGE" value="Request payload logged" />
</log>
```

#### Transform JSON payload

This policy modifies a JSON payload using a PayloadFactory mediator:

```xml
<payloadFactory media-type="json">
    <format>
        {
            "customField": "value",
            "originalPayload": $1
        }
    </format>
    <args>
        <arg evaluator="json" expression="$" />
    </args>
</payloadFactory>
```

## Test your policy locally

Before uploading your policy to API Manager, you can validate it using the Micro Integrator runtime.

### Set up local testing environment

1. Download and install WSO2 Micro Integrator from the [WSO2 website](https://wso2.com/integration/micro-integrator/).

2. Create a simple integration project in VS Code using the Micro Integrator extension:

    - Open the Command Palette (`Ctrl+Shift+P` or `Cmd+Shift+P`).
    - Search for `MI: Create New Project`.
    - Follow the prompts to create a new integration project.

3. Add your policy file to a test API or proxy service configuration to validate its behavior.

### Validate policy behavior

1. Configure a test proxy service that uses your policy logic:

    - Create a proxy service in your integration project.
    - Add your mediator sequence to the `inSequence` or `outSequence`.
    - Configure a simple backend endpoint for testing.

2. Start the Micro Integrator server from VS Code:

    - Open the Command Palette.
    - Search for `MI: Build and Run`.
    - Select your project to start the server.

3. Send test requests using a REST client or curl:

    ```bash
    curl -X GET http://localhost:8290/test-service
    ```

4. Review the server logs and response to verify your policy behaves as expected.

5. Iterate on your policy configuration until it produces the desired results.

## Upload your policy to API Manager

After you finish developing and testing your policy locally, upload it to API Manager.

1. Sign in to the WSO2 API Publisher:

    `https://<hostname>:9443/publisher`

2. Navigate to **Policies** from the left menu.

3. Select **Add New Policy** to create a new common policy or navigate to a specific API's **Policies** tab to create an API-specific policy.

4. Fill in the general details:

    - **Name**: Enter a descriptive name for your policy.
    - **Version**: Specify the policy version (typically starts at `1`).
    - **Description**: Provide a clear description of what the policy does.
    - **Applicable Flows**: Select whether the policy applies to requests, responses, or both.

5. In the **Gateway Specific Details** section:

    - **Supported Gateways**: Select **Regular Gateway** for Synapse-based policies.
    - **Upload Policy File**: Select your `.xml` or `.j2` file from your local machine.

6. Configure policy attributes if your policy uses template variables:

    - For each template variable (like `{{headerName}}`), add a corresponding attribute.
    - Specify the name, display name, type, validation rules, and whether it's required.

7. Select **Save** to upload your policy to API Manager.

8. Verify the policy appears in the policy list and test it by attaching it to an API.

## Best practices for policy development

Follow these recommendations when developing custom policies:

- **Start simple**: Begin with basic mediator configurations and add complexity incrementally.
- **Test thoroughly**: Always test policies locally before deploying to production environments.
- **Use meaningful names**: Choose descriptive names for policy files, attributes, and variables.
- **Document your policies**: Add clear descriptions to help other developers understand the policy's purpose.
- **Version control**: Store your policy files in a version control system like Git to track changes.
- **Reuse components**: Create a library of common policy patterns for consistent implementations.
- **Validate inputs**: When using policy attributes, configure appropriate validation rules to prevent errors.
- **Monitor performance**: Test policy performance with realistic payloads to ensure it doesn't introduce latency.
- **Follow security guidelines**: Avoid exposing sensitive information in logs or response headers.
- **Review limitations**: Remember that certain mediators (`Call` in non-blocking mode, `Send`) aren't supported in custom policies.

## Troubleshooting common issues

Use these solutions to resolve common problems when developing policies.

### Policy fails validation on upload

**Problem**: API Manager rejects your policy file during upload.

**Solution**: 
- Verify you removed the XML prolog (`<?xml version="1.0"...?>`).
- Check that all mediator tags are properly closed.
- Ensure you're not using unsupported mediators.
- Validate XML syntax using an XML validator.

### Template variables don't render correctly

**Problem**: Jinja2 template variables like `{{variableName}}` don't get replaced with actual values.

**Solution**:
- Ensure you defined corresponding policy attributes with matching names.
- Verify the attribute names in your policy file exactly match the attribute names in the policy form.
- Check that you're using the correct template syntax: `{{variableName}}`.

### Policy doesn't execute as expected

**Problem**: The policy uploads successfully but doesn't produce the expected behavior when attached to an API.

**Solution**:
- Review the API Gateway logs for error messages.
- Verify you attached the policy to the correct flow (request or response).
- Check the policy execution order if multiple policies are attached.
- Test with a simplified version of the policy to isolate the issue.
- Ensure backend services are responding correctly.

### Development environment setup issues

**Problem**: The Micro Integrator extension doesn't work correctly in VS Code.

**Solution**:
- Verify you installed the latest version of the extension.
- Check that Java is installed and configured in your system PATH.
- Restart VS Code after installing the extension.
- Review the VS Code Output panel for extension-related error messages.

## See also

- [Create a policy]({{base_path}}/design/api-policies/create-policy/)
- [Attach a policy]({{base_path}}/design/api-policies/attach-policy/)
- [API policies overview]({{base_path}}/design/api-policies/overview/)
