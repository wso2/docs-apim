## Securing APIs by auditing API Definitions

API Security has become an important concern in recent times as organizations are more cautious about exposing raw, sensitive data via APIs. Therefore it is important that APIs adhere to the OpenAPI Specification (OAS) to ensure API security.

WSO2 API-M has partnered with 42Crunch, the only enterprise API security platform, to bring in the ability to conduct a security audit on the Open API Specification definition and to obtain an audit report.

## Enable the Audit API feature

### Obtain API Token and Collection ID from 42Crunch

1.  Navigate to the [42crunch platform](https://platform.42crunch.com) and register or sign in.

2.  Click on **Settings** on the user menu.

    ![]({{base_path}}/assets/img/Learn/api-token-settings-menu.png)

3.  Click on the **API Tokens** tab and select **Create New Token**

    ![]({{base_path}}/assets/img/Learn/api-token-create-button.png)

4.  Enter a name for the token and select **API Contract Security Audit** under token access right. For the audit feature to work, only the **API Contract Security Audit** permission is required.

    ![]({{base_path}}/assets/img/Learn/api-token-dialog-box.png)

5.  Click on the **Generate Token**.

    !!! note 
        The generated API Token can be viewed only once. Make sure to copy it and save it in a safe place for reference.

    ![]({{base_path}}/assets/img/Learn/api-token-copy-generated.png)

6.  Create a collection by clicking on **API Collections** from the left navigation bar or by clicking on **+ New Collection** at the bottom of the left navigation.

    !!! note
        A Collection in this context is a folder hosted on 42Crunch containing all the APIs that are to be audited.

    ![]({{base_path}}/assets/img/Learn/collection-create-new.png)

7.  Copy the Collection ID from the URL of the browser as highlighted below and save it in a safe place for reference.

    ![]({{base_path}}/assets/img/Learn/collection-copy-id.png)

### Configure WSO2 API-M with the retrieved properties

The API Token and Collection ID properties have to be placed inside the configuration files inside WSO2 API-M. There are two ways to do so.

#### Enabling the feature for all tenants

Navigate to the `<API-M_HOME>/repository/conf/deployment.toml` file. Add the following configuration to the file and save the changes.

``` bash tab="Format"
    [security_audit]
    api_token="{api-token}"
    collection_id="{collection-id}"
    global=true
```

``` bash tab="Example"
    [security_audit]
    api_token="c21404ea-p13x-1swq-013a-pur90605uiwl"
    collection_id="a5213vyo-6tre-560u-p04h-p0inb98i0gt1"
    global=true
```

!!! tip
    Set **global** property to **false** to disable the feature for all other tenants except the super tenant.

#### Enabling the feature for a single tenant

!!! tip
    For more information on creating a tenant, see [Managing Tenants](https://docs.wso2.com/display/ADMIN44x/Working+with+Multiple+Tenants).

1.  Navigate to [https://localhost:9443/carbon](https://localhost:9443/carbon) and sign In with your tenant credentials.

2.  Go to Main > Resources. Click on **Browse**.

    ![]({{base_path}}/assets/attachments/103334899/103334897.png)

3.  Enter `/_system/config/apimgt/applicationdata/tenant-conf.json` as the location and click **Go** to access the tenant-conf.json file stored in the WSO2 Registry.

4.  Click **Edit as text** to edit the JSON file.

5.  Add the following configuration to the JSON file and save it.

    ``` bash tab="Format"
        SecurityAuditConfig: {
            "apiToken": "{api-token}",
            "collectionId": "{collection-id}",
            "overrideGlobal": true
        }
    ```

    ``` bash tab="Example"
        SecurityAuditConfig: {
            "apiToken": "c21404ea-p13x-1swq-013a-pur90605uiwl",
            "collectionId": "a5213vyo-6tre-560u-p04h-p0inb98i0gt1",
            "overrideGlobal": true
        }
    ```

    ![]({{base_path}}/assets/img/Learn/tenant-conf-properties.png)

    !!! note
        The **overrideGlobal** property's value, when set, will override the **global** property's value (under the [security_audit] section in the `<API-M_HOME>/repository/conf/deployment.toml`).  
        **Important** : If both the **overrideGlobal** and **global** properties are set to **false** the API Security Audit feature will be disabled (even if the API Token and Collection ID is given).

### Auditing an API

1.  Open the API Publisher

2.  Click on the API that needs to be audited.

3.  Go to **API Definitions**. If the feature is enabled, you will be able to see the **Audit API** button.

    ![]({{base_path}}/assets/img/Learn/audit-api-button.png)

4.  Click on the **Audit API** button. At the end of the audit, an audit report is displayed.

![]({{base_path}}/assets/img/Learn/sample-audit-report.png)

There are 4 sections to the Audit Report:

1.  [Audit Score and Summary](#audit-score-and-summary)
2.  [OpenAPI Format Requirements](#openapi-format-requirements)
3.  [Security](#security)
4.  [Data Validation](#data-validation)

#### Audit Score and Summary

This section provides: 

1.  Overall score, out of 100, given to the API Definition.
2.  The total number of errors.
3.  Overall severity of vulnerabilities present in the API Definition.
4.  Scores given to the Security and Data Validation sections.

!!! info
    OpenAPI Format Requirements are not taken into account whn calculating the score for the Audit Report.

#### OpenAPI Format Requirements

This category presents any issues that exist due to the API Definition not adhering to the OpenAPI Specification. This is divided into 3 categories.

1.  **Structural Errors**

    These errors occur when the API's structure does not comply with the Open API format.

2.  **Semantic Errors**

    OpenAPI contracts that are structurally correct may have issues with the semantics of the fields in them. For example, the API could include invalid email and URL formats, or inconsistent property formats across the API definition.

3.  **Best Practices Issues**

    The OpenAPI Specification includes requirements that, while not mandatory, are highly recommended. Issues in this section will be shown in the report if those recommended requirements do not exist in the API Definition.

!!! note
    The API will not be audited if there are Structural Errors. Therefore Structural Errors have to be fixed using the built-in Swagger Editor before attempting to audit the API again.

#### Security

This category presents security issues identified by checking the API against security best practices such as Authentication, Authorization and Transport.

#### Data Validation

This category presents issues that arise due to inadequate validation of input and output in an API Definition such as flaws in parameters, response headers, response definition and schemas.

### Breakdown of Severity Levels

The **severity** level of an issue allows distinguishing between the most and least dangerous issues easier and is separated into 5 different levels:

1.  **INFO**

    The lowest severity level. Represents a threat that potentially is unlikely to cause damage should it be executed.

2.  **LOW**

    Represents a threat that could potentially cause damage but is lower priority.

3.  **MEDIUM**

    Reminiscent of a threat that needs attending to and could have moderately damaging effects should it be executed.

4.  **HIGH**

    Represents a threat that could potentially cause great damage if executed and needs to be attended to and fixed before the former levels.

5.  **CRITICAL**
    
    The highest severity level. Represents a threat that could have devastating and wide-spread consquences if executed. These threats should be fixed immediately.
