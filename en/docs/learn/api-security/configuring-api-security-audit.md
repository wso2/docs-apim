# Securing APIs by Auditing API Definitions

API Security has become an important concern in recent times as organizations are more cautious about exposing raw, sensitive data via APIs. Therefore, it is important that APIs adhere to the OpenAPI Specification (OAS) to ensure API security.

WSO2 API-M has partnered with [42Crunch](https://42crunch.com/), the only enterprise API security platform, to bring in the ability to conduct a security audit on the OpenAPI Specification definition and to obtain an audit report.

## Step 1 - Enable Audit API

### Step 1.1 - Obtain API token and collection ID

Follow the instructions below to obtain the API token and collection ID from 42Crunch:

1.  Navigate to the [42crunch platform](https://platform.42crunch.com) and register or sign in.

2.  Click **Settings**.

     [![API token settings menu]({{base_path}}/assets/img/learn/api-token-settings-menu.png)]({{base_path}}/assets/img/learn/api-token-settings-menu.png)

3.  Click **API Tokens** and click **Create New Token**.

     [![API token create button]({{base_path}}/assets/img/learn/api-token-create-button.png)]({{base_path}}/assets/img/learn/api-token-create-button.png)

4.  Enter a name for the token and select **API Contract Security Audit** as the token access right. 

     When working with API Audit, you only need to select the **API Contract Security Audit** permission.

     [![API token dialog box]({{base_path}}/assets/img/learn/api-token-dialog-box.png)]({{base_path}}/assets/img/learn/api-token-dialog-box.png)

5.  Click **Generate Token**.

    !!! note 
        The generated API Token can be viewed only once. Make sure to copy it and save it in a safe place for future reference.

     [![API token copy generated]({{base_path}}/assets/img/learn/api-token-copy-generated.png)]({{base_path}}/assets/img/learn/api-token-copy-generated.png)

6.  Click either **API Collections** in the left navigation bar or click **+ New Collection** at the bottom of the left navigation to create a collection.

     A Collection in this context is a folder hosted on 42Crunch containing all the APIs that are to be audited.

     [![create new collection]({{base_path}}/assets/img/learn/collection-create-new.png)]({{base_path}}/assets/img/learn/collection-create-new.png)

7.  Copy the Collection ID from the URL of the browser as highlighted below and save it in a safe place for reference.

     [![copy collection id]({{base_path}}/assets/img/learn/collection-copy-id.png)]({{base_path}}/assets/img/learn/collection-copy-id.png)

### Step 1.2 - Configure WSO2 API-M

You need to add the API Token and Collection ID properties inside the configuration files in WSO2 API-M in order to configure WSO2 API-M with the retrieved properties. Use one of the following methods to carry out this process.

#### Enable Audit API for all tenants

1.  Navigate to the `<API-M_HOME>/repository/conf/deployment.toml` file. 

2.  Add the following configuration to the file and save the changes.

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
        Set the **global** property to **false** to disable the feature for all other tenants except the super tenant.

3.  Restart the WSO2 API Manager server.

#### Enable Audit API for a single tenant

!!! tip
    For more information on creating a tenant, see [Managing Tenants]({{base_path}}/administer/product-administration/multitenancy/introduction-to-multitenancy/).

1.  Navigate to the Management Console [https://localhost:9443/carbon](https://localhost:9443/carbon) and sign in with your tenant credentials.

2.  Go to **Main > Resources**. Click **Browse**.

     [![Browse option]({{base_path}}/assets/img/learn/browse-option.png)]({{base_path}}/assets/img/learn/browse-option.png)

3.  Enter `/_system/config/apimgt/applicationdata/tenant-conf.json` as the location and click **Go** to access the `tenant-conf.json` file stored in the WSO2 Registry.

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

     [![tenant conf properties]({{base_path}}/assets/img/learn/tenant-conf-properties.png)]({{base_path}}/assets/img/learn/tenant-conf-properties.png)

6.  Restart the WSO2 API Manager server.

    !!! note
        If you define a value for the **overrideGlobal** property, it will override the **global** property value, which is under the [security_audit] section in the `<API-M_HOME>/repository/conf/deployment.toml` file.  
        **Important** : If both the **overrideGlobal** and **global** properties are set to **false**, API Security Audit will be disabled even if the API Token and Collection ID is provided.

## Step 2 - Audit an API

1.  Navigate to the API Publisher.

     [https://localhost:9443/publisher](https://localhost:9443/publisher)

2.  Click on the API that you need to audit.

3.  Go to **API Definitions**. 

     The **Audit API** button will only appear if API Auditing is enabled.

     [![audit api button]({{base_path}}/assets/img/learn/audit-api-button.png)]({{base_path}}/assets/img/learn/audit-api-button.png)

4.  Click **Audit API**. 

     At the end of the audit, an audit report is displayed.

     [![sample audit report]({{base_path}}/assets/img/learn/sample-audit-report.png)]({{base_path}}/assets/img/learn/sample-audit-report.png)

     For more information on the details provided in the report, see [Audit report sections](#auditreports)

<a href="auditreports"></a>

## Audit report sections

There are four sections to the Audit Report:

1.  [Audit Score and Summary](#audit-score-and-summary)
2.  [OpenAPI Format Requirements](#openapi-format-requirements)
3.  [Security](#security)
4.  [Data Validation](#data-validation)

### Audit score and summary

This section provides the following information. 

1.  Overall score, out of 100, given to the API Definition.
2.  The total number of errors.
3.  Overall severity of vulnerabilities present in the API Definition.
4.  Scores given to the Security and Data Validation sections.

!!! info
    The OpenAPI format requirements are not taken into account when calculating the score for the Audit Report.

### OpenAPI format requirements

This category presents any issues that exist due to the API Definition not adhering to the OpenAPI specification. OpenAPI format requirements are divided into the following three categories.

1.  **Structural Errors**

    These errors occur when the API's structure does not comply with the Open API format.

2.  **Semantic Errors**

    OpenAPI contracts that are structurally correct may have issues with the semantics of the fields in them. For example, the API could include an invalid email and URL formats, or inconsistent property formats across the API definition.

3.  **Best Practices Issues**

    The OpenAPI specification includes requirements, which are not mandatory but are highly recommended. Issues in this section will be shown in the report if those recommended requirements do not exist in the API definition.

!!! note
    The API will not be audited if there are Structural Errors. Therefore, Structural Errors have to be fixed using the built-in Swagger Editor before attempting to audit the API again.

### Security

This category presents security issues identified by checking the API against the security best practices such as Authentication, Authorization, and Transport.

### Data validation

This category presents issues that arise due to inadequate validation of input and output in an API Definition such as flaws in parameters, response headers, response definition, and schemas.

## Breakdown of severity levels

The **severity** level of an issue allows distinguishing between the most and least dangerous issues easier and is separated into five different levels:

1.  **INFO**

    The lowest severity level. Represents a threat that potentially is unlikely to cause damage should it be executed.

2.  **LOW**

    It represents a threat that could potentially cause damage but is lower priority.

3.  **MEDIUM**

    Reminiscent of a threat that needs attending to and could have moderately damaging effects should it be executed.

4.  **HIGH**

    It represents a threat that could potentially cause great damage if executed and needs to be attended to and fixed before the former levels.

5.  **CRITICAL**
    
    The highest severity level. It represents a threat that could have devastating and wide-spread consequences if executed. These threats should be fixed immediately.