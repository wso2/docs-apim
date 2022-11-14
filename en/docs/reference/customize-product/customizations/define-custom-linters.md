# Defining Custom Linter Rules

Linting against custom rules is useful in standardizing and keeping API definitions clean. 

Let’s see how to enforce a custom rule to validate an email address filed to check if it is a corporate email address.

```json
{
    "rules": {
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
        }
    }
}
```

Here we introduce a new rule “wso2-email-rule” to check whether the email address at the `$.info.contact.email` path contains any matches to the regex pattern `"^[a-z]+@wso2.com$"`. If it does not match, the violation of the custom rule will be listed with a severity level “error”.

!!! note 
    The custom ruleset should be in accordance with the schema used in [Stoplight Spectral custom rulesets](https://meta.stoplight.io/docs/spectral/e5b9616d6d50c-custom-rulesets) and should be defined in JSON.
