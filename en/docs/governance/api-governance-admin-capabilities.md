WSO2 API Manager provides organization administrators the following administrative capabilities to manage rulesets and policies for API governance.

### Create and Manage Rulesets

The **Rulesets Catalog** provides a list of predefined governance rulesets that can be used to enforce security, compliance, and performance policies on APIs. Follow these steps to access the catalog and explore available rulesets.  

1. Log in to the **API Manager Admin Portal**.  
2. Go to the **Governance** section in the main menu.  
3. Click **Rulesets Catalog** to view all available rulesets.  

<a href="../../assets/img/governance/ruleset_view.png">
  <img src="../../assets/img/governance/ruleset_view.png" alt="APIM Governance Ruleset View"/>
</a>

#### Create a New Ruleset

To create a new ruleset, click on the **Create Ruleset**. When creating a new ruleset, you need to provide the following information:

| Field Name | Description                                                                                                                                                                                                                       | Mandatory | Options/Values |
|------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------|----------------|
| Name | The name of the ruleset.                                                                                                                                                                                                          | Yes | - |
| Description | A brief description of the ruleset.                                                                                                                                                                                               | No | - |
| Documentation Link | A link to the documentation of the ruleset.                                                                                                                                                                                       | No | - |
| Ruleset Type | The type of the ruleset.                                                                                                                                                                                                          | Yes | API Definition, API Metadata, Documentation |
| Artifact Type | The type of the API.                                                                                                                                                                                                              | Yes | REST API, Async API |
| Ruleset Content | Refer [Writing Your Own Ruleset](#writing-your-own-ruleset) section. Define the ruleset content using the **Spectral-like format**. You can either write the rules manually or upload a pre-written ruleset YAML or JSON file. | Yes | - |


After providing the required information, click on the **Create** button to create the ruleset.

<a href="../../assets/img/governance/ruleset_create.png">
  <img src="../../assets/img/governance/ruleset_create.png" alt="APIM Governance Ruleset Create" width="60%"/>
</a>

#### Writing Your Own Ruleset

Please refer to the [WSO2 Rule Validator Documentation]({{base_path}}/governance/rule-validator/rule-validator) to understand the ruleset format and how to write your own ruleset.

- If Ruleset Type is selected as **API Definition**, the ruleset should only contain rules that can be validated against the API definition file (OpenAPI or AsyncAPI).
- If Ruleset Type is selected as **API Metadata**, the ruleset should only contain rules that can be validated against the [API's YAML Representation](). This representation is common for REST and Async APIs.
- If Ruleset Type is selected as **Documentation**, the ruleset should only contain rules that can be validated against the [Documentation YAML Representation](). This representation is common for REST and Async APIs.

#### Default Rulesets

WSO2 API Manager comes with a set of default rulesets that cover common governance aspects such as security, compliance, and performance. These rulesets can be used as-is or customized to meet specific organizational requirements. These include,

1. **[WSO2 API Management Guidelines]({{base_path}}/reference/governance/wso2-api-management-guidelines)** - An API Metadata ruleset that applies to REST APIs and covers general API management guidelines.
2. **[WSO2 REST API Design Guidelines]({{base_path}}/reference/governance/wso2-rest-api-design-guidelines)** - An API Definition ruleset that applies to REST APIs and covers design best practices.
3. **[OWASP Top 10]({{base_path}}/reference/governance/owasp-top-10)** - An API Definition ruleset that applies to REST APIs and covers best practices for securing APIs against OWASP Top 10 vulnerabilities.

### Create and Manage Policies

The **Policies** section in the **API Manager Admin Portal** provides a list of governance policies that can be enforced on APIs. Follow these steps to access the policies section and explore available policies. 

1. Navigate to the **Governance** section in the **API Manager Admin Portal**.  
2. Click **Policies** to view the list of available policies.  

<a href="../../assets/img/governance/policy_view.png">
  <img src="../../assets/img/governance/policy_view.png" alt="APIM Governance Ruleset Create"/>
</a>

#### Create a new Policy

To create a new policy, click the **Create Policy** button and provide the following details:  

| Field Name  | Description                                    | Mandatory | Options/Values                                                                                                                                                 |
|-------------|------------------------------------------------|-----------|----------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Name        | The name of the policy.                        | Yes | -                                                                                                                                                              |
| Description | A brief description of the policy.             | No | -                                                                                                                                                              |
| Attachment  | The way the policy is attached to the APIs.    | Yes | All APIs (REST and ASYNC) <br/> APIs with specific labels<br/> None                                                                                            |
| Enforcement | The detail of the policy enforcement criteria. | Yes | **When to Enforce** <br/> API Create, API Update, API Deploy, API Publish <br/> **Actions to Take** (based on severity of rule violations) <br/> Notify, Block |
| Rulesets    | The list rulesets included in the policy.      | Yes | -                                                                                                                                                              |


After providing the required information, click on the **Create** button to create the policy.

<a href="../../assets/img/governance/policy_create.png">
  <img src="../../assets/img/governance/policy_create.png" alt="APIM Governance Policy Create" width="60%" />
</a>

#### Default Policies

WSO2 API Manager comes with a default governance policy named **WSO2 API Management Best Practices**. This policy is a high-level policy that includes the **WSO2 API Management Guidelines** ruleset. This policy can be used as-is or customized to meet specific organizational requirements. 

It includes, **[WSO2 API Management Guidelines](reference/governance/wso2-api-management-guidelines.md)** ruleset and **[WSO2 REST API Design Guidelines](reference/governance/wso2-rest-api-design-guidelines.md)** ruleset.

### Compliance Monitoring

Compliance monitoring is a key aspect of API governance. It ensures that APIs adhere to the defined governance policies and rulesets. The **Compliance Dashboard** provides a comprehensive view of the compliance status of APIs. Follow these steps to access the dashboard:

1. Log in to the **API Manager Admin Portal**.
2. Go to the **Governance** section in the main menu.
3. Click **Compliance** to view the compliance status of APIs.

<a href="../../assets/img/governance/admin_compliance.png">
  <img src="../../assets/img/governance/admin_compliance.png" alt="APIM Governance Compliance Dashboard"/>
</a>

#### **Policy Adherence**

This widget gives a summary of the policies deployed in the system with a breakdown of the number of policies that are followed, violated and not applied to any APIs.


#### **API Compliance**

This widget provides a summary of the compliance status of APIs with a breakdown of the number of APIs that are compliant, non-compliant, pending compliant results, and not applied to any policies.

#### **API Compliance Details**

This widget provides a detailed overview of an API's compliance status, including compliance level of associated policies.  

#### **Policy Adherence Details**

This widget offers a detailed overview of each policy's compliance, including the overall policy status and the compliance status of each API governed by the policy.  

#### API-Specific Compliance View

By clicking on each API listed in [API Compliance Details](###api-compliance-details) widget, an API compliance page will be displayed. This page provides a detailed view of the API's compliance status, including a breakdown of the compliance status for each policy attached to the API.




