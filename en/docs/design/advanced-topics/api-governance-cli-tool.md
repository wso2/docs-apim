# API Governance CLI Tool

The API Governance CLI Tool is designed to validate API(s) against a set of rules and generate a report detailing any violations. This tool is intended for developers and API administrators to ensure compliance with best practices and organizational standards.

## Download the Tool

You can download the tool for apim 4.2.0 from [here]({{base_path}}/assets/attachments/governance/governance.cli.4.2.0.zip).

## Configuration

Before using the CLI tool, you must configure it with your user credentials and server details. These settings enable authentication with your API manager and specify the server endpoint for API interactions.

Example `config.yaml`:
```
User:
  username: <username>
  password: <user_password>
  clientID: <generated_client_ID>
  clientSecret: <generated_client_secret>
Server:
  hostname: <server_host>
   port: <port>
```

!!! note

    When generating the access token using the above provided clinetID and clientSecret, the following scopes are provided.
        ```
            apim:api_view
            apim:api_create
            apim:app_import_export
            apim:api_import_export
            apim:api_product_import_export
            apim:admin
            apim:api_publish
            apim:subscribe
            apim:app_manage
            apim:sub_manage
            apim:api_delete
            apim:app_owner_change
        ```

## Usage

The CLI tool supports various commands to validate one or more APIs. Below are the commands and their descriptions:

1. Validate all APIs 
    - This command validates all available APIs

        `./api-governance-cli-tool-linux validate --all`

2. Validate one API by giving API ID
    - To focus on a specific API, use its ID with the command. This is beneficial for targeted validation, after modifications.

        `./api-governance-cli-tool-linux validate --api <API ID>`
 
3. Validate one API by giving the path of a local directory
    - To validate a specific API which is locally available, we can use the command by providing the path to the local directory.

        `./api-governance-cli-tool-linux validate -d <path to the local directory>`

## Customizing the Rules

You can define and customize validation rules in the `rules/rules.yaml` file. These rules are grouped based on the aspects they validate.

Rules Categories:

- API_Rules: Validate API(s) using the details provided in `api.yaml`file.
- Swagger_Rules: Validate API(s) using the details provided in `swagger.yaml` file.
- Docs_Rules: Validate API(s) using the details provided in `docs.yaml`file which is created inside each API when extracting.

!!! info
    Each rule consists of the following properties:

    ```
    <rule_name>:
        description: "Description of what the rule checks"
        message: "Provides the error message that will be displayed if the rule is violated"
        severity: Sets the severity of the rule (e.g., error, warning).
        given: "Specifies the JSON path in the YAML file where the rule applies. (e.g., path_inside_api.yaml_file)"
        then: "Defines the conditions under which the rule is evaluated"
        field: "(Optional) Specific field to be validated"
        function: "Validation function (e.g., pattern, schema, truthy)"
        functionOptions: "Options that tailor how the function evaluates the field"
    ```

    ### Example Rule Definition

    Below is an example of how to define a custom rule within the `API_Rules` category:

    ```
    api-name:
        description: "API names must follow PascalCase naming convention."
        message: "API name does not follow the PascalCase naming convention."
        severity: error
        given: "$.data"
        then:
            field: "name"
            function: pattern
            functionOptions:
            match: "^[A-Z][a-z]+(?:[A-Z][a-z]+)*$"
    ```

## Violation Report

Upon validation, the tool generates reports detailing any rule violations. These reports are timestamped and saved in the `reports` directory for audit purposes and further review.

Report Example: The file might be named `Violation_Report_28-3-2024_14-35-12.csv`, containing detailed entries of each API and the specific rules they violated.
