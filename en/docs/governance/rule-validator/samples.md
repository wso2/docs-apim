# Sample Rules for WSO2 Rule Validator

Following are a set of rules that cover a certain aspect of writing Stoplight Spectral rules that work with WSO2 Rule Validator.

## 1. Using regex rules

```yaml
rules:
  tls-no-http:
    description: Finance APIs should not use http
    message: Http should not be used
    given: $.data.transport.*
    severity: "error"
    then:
      function: pattern
      functionOptions:
        notMatch: '^http$'
```

In this example, the targets will be all elements of `$.data.transport` of the target document. Which means there are multiple targets, and Rule Validator will evaluate the rule for each target individually and output errors for each if any errors do exist.

The core function to be used is `pattern` which accepts 2 function options, `match` and `notMatch`. The latter is used in this example and hence the rule will only pass if the target value does not match the regex given with `notMatch`.

## 2. Using the length core function

```yaml
rules:
  api-tags-count:
    description: "Financial APIs should have at least one tag."
    message: "API should have at least one tag."
    severity: "warn"
    given: "$.data.tags"
    then:
      function: "length"
      functionOptions:
        min: 1
```

This example is straightforward as the length of the `tags` array is simply evaluated.

## 3. Using the truthy core function

```yaml
rules:
  schema-validation:
    description: "Financial APIs should have schema validation enabled."
    message: "API should have schema validation enabled."
    severity: "error"
    given: "$.data.enableSchemaValidation"
    then:
      function: truthy
```

This example is straightforward as the value of `$.data.enableSchemaValidation` is tested to be truthy.

## 4. Using schema

```yaml
rules:
  basic-auth-mandatory:
    description: All Finance APIs should have basic auth enabled to comply with security guidelines
    message: Basic auth must be enabled
    given: $.data.securityScheme
    severity: "error"
    then:
      function: schema
      functionOptions:
        schema:
          type: array
          not:
            items:
              not:
                enum: [ basic_auth ]
```

Schema is the most powerful core function as it allows us to define the struture of the target to as much depth as we require.

A limitation of WSO2 Rule-Validator at the moment is that it only supports json schema draft-04. So sometimes we have to write convoluted logic to write the rule we want.

In the above example, in order to enforce `All APIs should have basic auth enabled`, we need to negate our schema twice as it is the only way to express this rule using draft-04.

1. Consider only the following snippet
```yaml
enum: [ basic_auth ]
```
This enforces that `the value equals the string basic_auth`.

2. Negating it once
```yaml
not:
    enum: [ basic_auth ]
```
This enforces that `the value is not equal to basic-auth`.

3. Apply it to all items
```yaml
items:
    not:
        enum: [ basic_auth ]
```
This enforces that `every item in the array is not basic_auth`.

4. Negate it again
```yaml
not:
    items:
        not:
            enum: [ basic_auth ]
```
This enforces that `It is not true that every item is not basic_auth` which is equivalent to `there exists an item that is basic_auth`, which is precisely the logic we want.
