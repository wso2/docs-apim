# Validating API Definitions Against Custom Linter Rules

By default, API Definitions are validated against default OpenAPI schema when importing and writing or editing them inside the publisher portal. Apart from the default OpenAPI validation,  the APIs created by the API publisher can be validated against a set of custom rules and it is useful in standardizing and keeping API definitions clean.

For example, let’s say the API admin wants to allow only corporate email addresses (xxx@wso2.com) for the “$.info.contact.email” field inside an API definition. 

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

1. Navigate to the APIM Admin Portal
    https://localhost:9443/admin

2. Sign in with your credentials

3. On the side bar, Click on Advanced under Settings and you will be directed to the Advanced Configuration editor

4. Add the new rule under “LinterCustomRules -> rules” as below.

5. Click Save on the bottom of the page


## Step 2: Observe API linter validation results

Now, the new rule is enforced and the API Publisher can observe the validation results in two scenarios.

When creating an API from OpenAPI definition
When you are following the [API creation steps]({{base_path}}/design/create-api/create-rest-api/create-a-rest-api-from-an-openapi-definition), the linter results will be shown as below.