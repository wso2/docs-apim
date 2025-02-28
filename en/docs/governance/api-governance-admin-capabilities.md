Governance Administrative Capabilities
--------------------------------------

API Management Governance provides the following administrative capabilities to manage rulesets and policies

### Create and Manage Rulesets

The **Rulesets Catalog** provides a list of predefined governance rulesets that can be used to enforce security, compliance, and performance policies on APIs. Follow these steps to access the catalog and explore available rulesets.  

1. Log in to the **API Manager Admin Portal**.  
2. Go to the **Governance** section in the main menu.  
3. Click **Rulesets Catalog** to view all available rulesets.  

<a href="{{base_path}}/assets/img/governance/ruleset_view.png">
  <img src="{{base_path}}/assets/img/governance/ruleset_view.png" alt="APIM Governance Ruleset View"/>
</a>

#### Create a new Ruleset

To create a new ruleset, click on the **Create Ruleset**. When creating a new ruleset, you need to provide the following information:

| Field Name | Description                                                                                                                                                                  | Mandatory | Options/Values |
|------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------|----------------|
| Name | The name of the ruleset.                                                                                                                                                     | Yes | - |
| Description | A brief description of the ruleset.                                                                                                                                          | No | - |
| Documentation Link | A link to the documentation of the ruleset.                                                                                                                                  | No | - |
| Ruleset Type | The type of the ruleset.                                                                                                                                                     | Yes | API Definition, API Metadata, Documentation |
| Artifact Type | The type of the API.                                                                                                                                                         | Yes | REST API, Async API |
| Ruleset Content | Define the ruleset content using the **Spectral-like format**. You can either write the rules manually or upload a pre-written ruleset file. The spec to write the ruleset can be access via [WSO2 rule validator documentation]({{base_path}}/governance/rule-validator/rule-validator) | Yes | - |

After providing the required information, click on the **Create** button to create the ruleset.

<a href="{{base_path}}/assets/img/governance/ruleset_create.jpg">
  <img src="{{base_path}}/assets/img/governance/ruleset_create.jpg" alt="APIM Governance Ruleset Create"/>
</a>

### Create and Manage Policies

Policies define governance rules that enforce security, compliance, and performance standards for APIs. Follow these steps to create and manage policies:  

1. Navigate to the **Governance** section in the **API Manager Admin Portal**.  
2. Click **Policies** to view the list of available policies.  

<a href="{{base_path}}/assets/img/governance/policy_view.png">
  <img src="{{base_path}}/assets/img/governance/policy_view.png" alt="APIM Governance Ruleset Create"/>
</a>

#### Create a new Policy

To create a new policy, click the **Create Policy** button and provide the following details:  

| Field Name | Description                                  | Mandatory | Options/Values                                                                                                                                           |
|------------|----------------------------------------------|-----------|----------------------------------------------------------------------------------------------------------------------------------------------------------|
| Name | The name of the policy.                      | Yes | -                                                                                                                                                        |
| Description | A brief description of the policy.           | No | -                                                                                                                                                        |
| Attachment | The way the policy is attached to the APIs.  | Yes | All APIs, APIs with specific labels, None                                                                                                                |
| Enforcement | The detail of the policy enforcement criteria.        | Yes | **Governed State** <br/> API Create, API Update, API Deploy, API Publish <br/> **Severity Levels** <br/> Error, Warn, Info <br/> **Actions** <br/> Notify, Block |
| Ruleset | The rulesets that is attached to the policy. | Yes | -                                                                                                                                                        |

After providing the required information, click on the **Create** button to create the policy.

<a href="{{base_path}}/assets/img/governance/policy_create.jpg">
  <img src="{{base_path}}/assets/img/governance/policy_create.jpg" alt="APIM Governance Ruleset Create"/>
</a>


### Compliance Monitoring

Compliance monitoring is a key aspect of API governance. It ensures that APIs adhere to the defined governance policies and rulesets. The **Compliance Monitoring Dashboard** provides a comprehensive view of the compliance status of APIs. Follow these steps to access the dashboard:

1. Log in to the **API Manager Admin Portal**.
2. Go to the **Governance** section in the main menu.
3. Click **Overview** to view the compliance status of APIs.

<a href="{{base_path}}/assets/img/governance/admin_compliance.png">
  <img src="{{base_path}}/assets/img/governance/admin_compliance.png" alt="APIM Governance Ruleset Create"/>
</a>

#### **Policy Adherence**

This widget gives a summary of the policies deployed in the system with a breakdown of the number of policies that are adhered to, violated and not applied to any APIs.


#### **API Compliance**

This widget provides a summary of the compliance status of APIs with a breakdown of the number of APIs that are compliant, non-compliant, Pending compliant results, and not applied to any policies.

#### **API Compliance Details**

This widget provides a detailed overview of an API's compliance status, including compliance level of associated policies.  

#### **Policy Adherence Details**

This widget offers a detailed overview of each policy's compliance, including the overall policy status and the compliance status of each API governed by the policy.  

By clicking on the each API listed in this widgets, an API compliance summary page will be displayed. This page provides a detailed view of the compliance status of the API with a breakdown of the compliance status of each policy attached to the API. 




