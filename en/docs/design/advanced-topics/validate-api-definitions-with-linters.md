# Validating API Definitions Against Custom Linter Rules

By default, API Definitions are validated against the standard Open API specification when importing and writing or editing them via a built-in API Definition editor in the Publisher Portal. Apart from the default OpenAPI validation, the APIs created by the API publisher can be validated against a set of custom rules and it is useful in standardizing and keeping API definitions clean.

For example, let’s say the API admin wants to allow only corporate email addresses `xxx@wso2.com` for the `$.info.contact.email` field inside an API definition. 

## Step 1: Formulate the required linter rule and add them in the Admin Portal

```json
"wso2-email-rule": {
            "description": "Should be a WSO2 email.",
            "given": "$",
            "severity": "error",
            "then": {
                "field": "info.contact.email",
                "function": "pattern",
                "functionOptions": {
                    "match": "^[a-z]+@wso2.com$"
                }
            }
```

Here we introduce a new rule `wso2-email-rule` to check whether the email address at `$.info.contact.email` path contains any matches to the Regex pattern `"^[a-z]+@wso2.com$"`. Only if it does not match, the violation of the custom rule will be listed with a severity level “error”.

!!! note 
    The custom ruleset should be in accordance with the schema used in [Stoplight Spectral custom rulesets](https://meta.stoplight.io/docs/spectral/d3482ff0ccae9-rules) and should be defined in JSON.

1. Navigate to the APIM Admin Portal.
    https://localhost:9443/admin

2. Sign in with your credentials.

3. On the side bar, click on **Advanced** under **Settings** and you will be directed to the **Advanced Configuration** editor.

4. Add the new rule under “LinterCustomRules -> rules” as below.

    [![Linter results]({{base_path}}/assets/img/design/create-api/linter-observe/linters1.png)]({{base_path}}/assets/img/design/create-api/linter-observe/linters1.png)

5. Click **Save** on the bottom of the page.


## Step 2: Observe API linter validation results

Now, the new rule is enforced and the API Publisher can observe the validation results in three scenarios.

### When creating an API from OpenAPI definition

When you are following the [API creation steps]({{base_path}}/design/create-api/create-rest-api/create-a-rest-api-from-an-openapi-definition), the linter results will be shown as below.

[![Linter results]({{base_path}}/assets/img/design/create-api/linter-observe/linters2.png)]({{base_path}}/assets/img/design/create-api/linter-observe/linters2.png)

!!! Note 
    Currently, the linter results feature is supported for URL and File-based API definition imports.

### When importing an API from OpenAPI definition

1. Navigate to the WSO2 API Manager Publisher Portal.

2. Log in using your credentials.

3. On the sidebar, go to **Develop** -> **API Configuration**.

4. Click on **Import Definition** from the toolbar.

5. Select OpenAPI URL and provide `https://petstore3.swagger.io/api/v3/openapi.json` as the URL.

6. The linter results will be shown as indicated below.

    [![Linter results]({{base_path}}/assets/img/design/create-api/linter-observe/linters3.png)]({{base_path}}/assets/img/design/create-api/linter-observe/linters3.png)

7. If there are any errors present, they can be solved in the built-in editor by clicking on the **Edit and Import** button.

8. Then click on **Import Content** in the editor to import the API definition.

    [![Linter results]({{base_path}}/assets/img/design/create-api/linter-observe/linters4.png)]({{base_path}}/assets/img/design/create-api/linter-observe/linters4.png)

### When editing an API

1. Navigate to the WSO2 API Manager Publisher Portal.

2. Log in using your credentials.

3. On the sidebar, go to **Develop** -> **API Configuration**.

4. Click on **Edit** from the toolbar.

    [![Linter results]({{base_path}}/assets/img/design/create-api/linter-observe/linters5.png)]({{base_path}}/assets/img/design/create-api/linter-observe/linters5.png)

5. Switch to the **Linter view** by clicking on the **LINTER** button at the top.

6. You will see the linter error corresponding to the new rule you enforced.

    [![Linter results]({{base_path}}/assets/img/design/create-api/linter-observe/linters6.png)]({{base_path}}/assets/img/design/create-api/linter-observe/linters6.png) 
