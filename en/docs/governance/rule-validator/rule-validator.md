# WSO2 Rule Validator

---
- WSO2 Rule Validator is a JSON/YAML linter that is a Java implementation of Stoplight Spectral. [https://github.com/stoplightio/spectral](https://github.com/stoplightio/spectral)
- This validator is automatically called by the APIM Governance feature to validate different artifacts. (Open API Specifications, API Metadata files, etc.)
- Any valid JSON or YAML file can be validated by providing a valid Spectral ruleset.

## Features and Limitations
WSO2 Rule validator supports most features that Spectral itself does. With the exception of a few listed below.

1. [_**given**_](https://docs.stoplight.io/docs/spectral/d3482ff0ccae9-rules#rules-properties) path is a JSON Path. But currently WSO2 Rule Validator does not support [JSON Path Plus](https://github.com/JSONPath-Plus/JSONPath) features, even though Spectral does.
    - Object access should always be done inside single quotes \(`['paths']['order']\`)
    - Comma separated object access is not supported. (`$['paths'][*]['get', 'put', 'post']`)
2. All [core functions](https://docs.stoplight.io/docs/spectral/cb95cf0d26b83-core-functions) except [UnreferencedReusableObject](https://docs.stoplight.io/docs/spectral/cb95cf0d26b83-core-functions#unreferencedreusableobject) and [typedEnum](https://docs.stoplight.io/docs/spectral/cb95cf0d26b83-core-functions#typedenum) are supported.
3. Custom functions are not supported.
4. References ($ref) are not supported.
5. The core function "pattern" allows you to define regex patterns and check whether a certain lint target matches it or not.
    - _**In YAML rulesets, always define the regex pattern inside single quotes.**_
    - All regex should be valid Java regex, which is different from JavaScript regex used in Stoplight Spectral.
6. Extends and overrides are currently not supported
7. Parser options are not supported
8. Only Async API and Open API are supported (all versions)

## Terms
1. Ruleset - Contains all the rules, aliases, and formats.
2. Document - The target document that should be validated against the ruleset. Mostly API specifications.
3. Target - The part of the document which is identified by the `given` and `field` properties of a rule. The target can be of any type, an object, array, or a primitive.

## Usage
### 1. Writing rulesets
Following is a simple ruleset.
```yaml
aliases:
   API_Server_URL:
      - "$.servers[*].url"
formats:
   - oas3_0
   - oas3_1
rules:
  server-lowercase:
       given:
          - "#API_Server_URL"
       severity: error
       then:
          function: pattern
          field: "url"
          functionOptions:
             match: '^[^A-Z]*$'
       formats:
          - oas3
```

1. `aliases` - This is a way to reuse pre-defined given paths instead of redefining them for each rule. More information in the [Aliases](#4-aliases) section.
2. `formats` - The formats of documents to which this ruleset should be applied. This ruleset will not be applied to any documents that are not in the listed formats. These ruleset level formats can be overridden by rule level formats.
3. `rules` - Definitions of rules. More information in the [Rules](#2-writing-rules) section.

### 2. Writing rules
Following is a simple rule. These rules have been extracted from the `wso2_rest_api_design_guidelines.yaml` ruleset provided as a default ruleset with WSO2 API Manager 4.5.0 onwards.

```yaml
    server-lowercase:
       given:
          - "$.servers[*]"
       severity: error
       then:
          function: pattern
          field: "url"
          functionOptions:
             match: '^[^A-Z]*$'
       description: |-
          Server URLs must be lowercase. This standard helps meet industry best practices.
   
          **Invalid Example**
   
          The `url` property uses uppercase letters.
   
          ```json
          {
            "servers": [
              {
                "url": "https://ACME.com/api"
              }
            ]
          }
          ```
   
          **Valid Example**
   
          The `url` property is fully lowercase.
   
          ```json
          {
            "servers": [
              {
                "url": "https://acme.com/api"
              }
            ]
          }
          ```
       message: Server URL must be lowercase.
       formats:
          - oas3
```
This rule will only be applied if the document is an OAS3 document. It will traverse the document to find server objects. Then for each server, it will find the field 'url', and check whether it matches the given regex pattern.

Following table contains a summary of the fields in a rule.
<table><thead>
  <tr>
    <th>Field name</th>
    <th>Required</th>
    <th>Type</th>
  </tr></thead>
<tbody>
  <tr>
    <td>given</td>
    <td>Yes</td>
    <td>Json path string, or an array of json paths.</td>
  </tr>
  <tr>
    <td>then</td>
    <td>Yes</td>
    <td>Object with the properties: `function`, `field`, and `functionOptions`.</td>
  </tr>
  <tr>
    <td>function</td>
    <td>Yes</td>
    <td>String. Name of a valid core function</td>
  </tr>
  <tr>
    <td>field</td>
    <td>No</td>
    <td>String. Sub target.</td>
  </tr>
  <tr>
    <td>functionOptions</td>
    <td>No</td>
    <td>Object or values required for the function</td>
  </tr>
  <tr>
    <td>description</td>
    <td>No</td>
    <td>String</td>
  </tr>
  <tr>
    <td>message</td>
    <td>No</td>
    <td>String with optional valid placeholders</td>
  </tr>
  <tr>
    <td>severity</td>
    <td>No</td>
    <td>String with a valid severity</td>
  </tr>
  <tr>
    <td>formats</td>
    <td>No</td>
    <td>Array of strings of valid formats</td>
  </tr>
</tbody></table>

Following is an explanation on the attributes of a rule.

1. `given` (required) - The part of the document (the target) the rule should be applied to. Written using [Json Path](https://github.com/json-path/JsonPath) syntax. Can be an array of strings or a single string
2. `then` (required) - Describes which function and how it should be applied to the target. Can be an array of objects or a single object containing the following fields.
    1. `function` (required) - which of the core functions should be applied. More information in the [Core Functions](#3-core-functions) section.
    2. `field` - which sub part of the target should the function be applied to. If omitted, the function is applied to the entire target. The field can be,
        1. `@key` - The function will be applied to the key of the target.
        2. A property - A property of the target.
        3. A Json Path - This Json Path will further traverse the target.
    3. `functionOptions` - Additional information that is required by the function.
3. `description` - Description of the rule
4. `message` - The message that is passed if the rule is violated. Can be customized using the following placeholders.
    - `{{error}}`
    - `{{description}}`
    - `{{path}}`
    - `{{property}}`
    - `{{value}}`
5. `severity` - The severity of the rule. The default value is `warn`. Can be one of the following. If the severity is `off`, the rule will not be applied. Other values do not affect the execution of the rule.
    - `error`
    - `warn`
    - `info`
    - `hint`
    - `off`
6. `formats` - The rule will only apply if the target document is of one of the following defined formats.
    - `aas2` (AsyncAPI v2.x)
    - `aas2_0` (AsyncAPI v2.0.0)
    - `aas2_1` (AsyncAPI v2.1.0)
    - `aas2_2` (AsyncAPI v2.2.0)
    - `aas2_3` (AsyncAPI v2.3.0)
    - `aas2_4` (AsyncAPI v2.4.0)
    - `aas2_5` (AsyncAPI v2.5.0)
    - `aas2_6` (AsyncAPI v2.6.0)
    - `aas3` (AsyncAPI v3.x)
    - `aas3_0` (AsyncAPI v3.0.0)
    - `oas2` (OpenAPI v2.0)
    - `oas3` (OpenAPI v3.x)
    - `oas3_0` (OpenAPI v3.0.x)
    - `oas3_1` (OpenAPI v3.1.x)

---

_The combination of `given` and `then` should be constructed carefully. If the provided paths are not present in the document it will not give out an error, but simply the rule will not run._

For example, in the following document, separate rules should be written for each level. If we need to write a rule to validate the existence of the `description`, it will run only if the parent is present. The validation of the parent should be a separate rule.

```yaml
paths:
  /order:
    post:
      operationId: orderPizza
      description: Create a new Order
      requestBody:
        $ref: "#/components/requestBodies/Order"
```

### 3. Core functions
Below is a list of core functions that are supported by the rule validator, with a summary of each of its options.

<table><thead>
  <tr>
    <th>Function Name</th>
    <th>Function Description</th>
    <th>Function Options</th>
    <th>Type</th>
    <th>Required</th>
    <th>Option Description</th>
  </tr></thead>
<tbody>
  <tr>
    <td>alphabetical</td>
    <td>Make sure an object or an array is sorted. If keyedBy is provided the target should contain an array of objects, and the order is deduced using the key.</td>
    <td>keyedBy</td>
    <td>String</td>
    <td>No</td>
    <td>The key by which the objects are sorted.</td>
  </tr>
  <tr>
    <td>enumeration</td>
    <td>Does the field value exist in this set of possible values?</td>
    <td>values</td>
    <td>List of strings or numbers</td>
    <td>Yes</td>
    <td>The list of possible values to search the membership of the target.</td>
  </tr>
  <tr>
    <td>falsy</td>
    <td>Is the value a boolean false, 0, null, undefined, or an empty string ("")?</td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td rowspan="2">length</td>
    <td rowspan="2">Count the length of a string or an array, the number of properties in an object, or a numeric value, and define minimum and/or maximum values.</td>
    <td>min</td>
    <td>number</td>
    <td>No</td>
    <td rowspan="2">At least one of the min and max values has to be provided. Both can be provided as well. If both are provided, the target should be smaller than the min value and larger than the max value.</td>
  </tr>
  <tr>
    <td>max</td>
    <td>number</td>
    <td>No</td>
  </tr>
  <tr>
    <td rowspan="2">pattern</td>
    <td rowspan="2">Check if part of the target string matches with a regex pattern.</td>
    <td>match</td>
    <td>String (valid regex)</td>
    <td>No</td>
    <td rowspan="2">Either match or notMatch has to be provided. Both can also be provided. If both are provided, the function checks whether the target matches the match regex and it doesn't match the notMatch regex.</td>
  </tr>
  <tr>
    <td>notMatch</td>
    <td>String (valid regex)</td>
    <td>No</td>
  </tr>
  <tr>
    <td rowspan="5">casing</td>
    <td rowspan="5">Text must match a certain predefined case.</td>
    <td>type</td>
    <td>String (valid case)</td>
    <td>Yes</td>
    <td>Can be one of flat (verylongname), camel (veryLongName), pascal (VeryLongName), kebab (very-long-name), cobol (VERY-LONG-NAME), snake (very_long_name), macro (VERY_LONG_NAME).</td>
  </tr>
  <tr>
    <td>disallowDigits</td>
    <td>boolean</td>
    <td>No</td>
    <td>Can the target not contain numbers?</td>
  </tr>
  <tr>
    <td>separator</td>
    <td>Object which contains the following values</td>
    <td>No</td>
    <td>Contains the following sub options. This object (the next 2 options) can be leveraged to accomplish custom cases.</td>
  </tr>
  <tr>
    <td>separator.char</td>
    <td>String (single character)</td>
    <td>No</td>
    <td>Custom character to separate groups of words.</td>
  </tr>
  <tr>
    <td>separator.allowLeading</td>
    <td>boolean</td>
    <td>No</td>
    <td>Can the separator character be used as the first character?</td>
  </tr>
  <tr>
    <td>schema</td>
    <td>Check if the target is defined according to the given schema.</td>
    <td>schema</td>
    <td>A valid schema</td>
    <td>Yes</td>
    <td>A valid json or yaml schema object.</td>
  </tr>
  <tr>
    <td>truthy</td>
    <td>Is the value not a boolean false, 0, null, undefined, or an empty string ("")?</td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>defined</td>
    <td>The `field` should be defined in the `then` object when using this function. Checks if the target value object contains the property defined by the `field`.</td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>undefined</td>
    <td>The `field` should be defined in the `then` object when using this function. Checks if the target value object&nbsp;&nbsp;doesn't contain the property defined by the `field`.</td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>xor</td>
    <td>One of the properties should be defined in the target object. But not more than one is allowed to be defined.</td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
</tbody></table>

#### Examples
1. Alphabetical
```yaml
  openapi-tags-alphabetical:
    given:
      - "$"
    severity: warn
    then:
      function: alphabetical
      functionOptions:
        keyedBy: name
      field: tags
```
If the above ruleset is used to validate the below document, it will fail because the tag objects are not sorted according to their names' alphabetical order.
```yaml
tags:
   - name: Z tag
     description: last tag
   - name: A tag
     description: first tag
```

This function can be used without `keyedBy` for simple arrays or objects.

2. Enumeration
```yaml
whitelisted-tags:
  description: Pick from a very restrictive set of tags.
  given: "$.paths.*.tags.*"
  then:
    function: enumeration
    functionOptions:
      values:
        - users
        - articles
        - categories
```
The above rule will check all tags whether they are one of the values defined in `values`.

3. falsy
```yaml
  path-parameters-on-path-only:
    given:
      - "$.paths[*][*].parameters[?(@.in == 'path')]"
    severity: warn
    then:
      function: falsy
```
Simply checks whether the targets selected by the given path are falsy.

4. Length
```yaml
  operation-tags:
    given:
      - "#Operation_Object"
    severity: warn
    then:
      - function: length
        functionOptions:
          max: 999
          min: 1
        field: tags
      - function: truthy
        field: tags
```
Checks whether operation tags contain between 1 to 999 tags.
- If the target is a string, it will consider the length of the string.
- If the target is an array, it will consider the number of elements.
- If the target is an object, it will consider the number of properties.
- If the target is a number, it will simply consider its value.

5. Pattern
```yaml
  path-declarations-must-exist:
    given:
      - "#Path_Object"
    severity: error
    then:
      function: pattern
      functionOptions:
        notMatch: '\{\}'
      field: "@key"
```
In this example, the function will check whether the target does not match the given regex. If `match` is provided, it will also check whether the target matches with that particular regex.

6. Casing
```yaml
path-kebab-casing:
  given:
     - "$.paths[*]"
  then:
    function: casing
    functionOptions:
      type: kebab
      disallowDigits: false
      separator:
        char: "*"
        allowLeading: true
```
The above will create a custom casing function where it allows strings like `*very*lo3ng*word`.

7. Schema
```yaml
  openapi-tags:
    given:
      - "#API_Document"
    severity: warn
    then:
      function: schema
      functionOptions:
        schema:
          type: array
          minItems: 1
      field: tags
```
The above rule will check whether the tags object is an array, and it contains at least 1 element.

The schema function is the most powerful and expressive one of the core functions.

8. Truthy
```yaml
  operation-description:
    given:
      - "#Operation_Object"
    severity: warn
    then:
      function: truthy
      field: description
```
Simply checks whether the targets selected by the given path is truthy.

9. Defined
```yaml
tags-should-be-defined:
  given:
     - "$"
  function: defined
  field: tags
```
Simply checks if the document root object has the property `tags` defined.

10. Undefined
```yaml
tags-should-not-be-defined:
  given:
     - "$"
  function: undefined
  field: tags
```
Simply checks if the document root object does not have the property `tags` defined.

11. Xor
```yaml
components-examples-value-or-externalValue:
  description: Examples should have either a `value`, `externalValue`, or `otherValue` field.
  given: "$.components.examples.*"
  then:
    function: xor
    functionOptions:
      properties:
        - externalValue
        - value
        - otherValue
```
Checks if all the examples contains one of the 3 properties provided.

### 4. Aliases
- Aliases are defined for commonly used JSONPath expressions on a global level and then reused across the ruleset.
- It's similar to `given` but with more capabilities.
- Aliases can be recursive. That is one alias can use another alias. But the references should **never** be circular.
- When using the aliases either in other aliases or rulesets, the alias can be extended by thinking of it as a Json Path, which it will resolve to during runtime.

2 types of aliases can be defined.
1. Simple aliases - Each alias is a list of Json Paths. They will simply replace the given clauses where the alias is called.
   ```yaml
   aliases:
      Path_Item:
         - "$.paths[*]"
         - "$.hidden.paths[*]"
      Operation_Object:
         - "#Path_Item['get']"
         - "#Path_Item['put']"
         - "#Path_Item['post']"
         - "#Path_Item['delete']"
         - "#Path_Item['options']"
         - "#Path_Item['head']"
         - "#Path_Item['patch']"
         - "#Path_Item['trace']"
     
   rules:
      operation-description:
         given:
            - "#Operation_Object.description"
         severity: warn
         then:
            function: truthy
         message: Operation "description" should be present and non-empty string.
   ```

2. Complex aliases - Complex aliases or scoped aliases allow you to define formats and given paths for each set of formats.
   ```yaml
   API_Server_URL:
      description: API host urls defined in the API specification
      targets:
      - formats:
          - oas3_0
          - oas3_1
        given:
          - "$.servers[*].url"
      - formats:
          - oas2
        given:
          - "$.host"
   ```

## Building

1. Build using `mvn clean install`.
2. Use the `.jar` file generated in `component/target`.
3. Use the following maven dependency
   ```xml
        <dependency>
            <groupId>org.wso2.carbon</groupId>
            <artifactId>org.wso2.rule.validator</artifactId>
            <version>${rule.validator.version}</version>
        </dependency>
    ```
4. Read the ruleset file into a string and call the `validateRuleset` method to validate the ruleset.
    ```java
        String document = new String(Files.readAllBytes(Paths.get("path/to/ruleset/ruleset.yaml")));
        String rulesetValidationResult = Validator.validateRuleset(ruleset);
    ```
5. Read the target document file and the ruleset into strings and call the `validateDocument` method to validate the document against the ruleset.
    ```java
        String document = new String(Files.readAllBytes(Paths.get("path/to/document/document.yaml")));
        String documentValidationResult = Validator.validateDocument(document, ruleset);
    ```