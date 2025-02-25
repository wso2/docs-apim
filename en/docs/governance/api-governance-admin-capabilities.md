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

To create a new ruleset, click on the **Create Ruleset**. When creating a new ruleset, you need to provide the following information:

| Field Name | Description                                                                                                                                                                  | Mandatory | Options/Values |
|------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------|----------------|
| Name | The name of the ruleset.                                                                                                                                                     | Yes | - |
| Description | A brief description of the ruleset.                                                                                                                                          | No | - |
| Documentation Link | A link to the documentation of the ruleset.                                                                                                                                  | No | - |
| Ruleset Type | The type of the ruleset.                                                                                                                                                     | Yes | API Definition, API Metadata, Documentation |
| Artifact Type | The type of the API.                                                                                                                                                         | Yes | REST API, Async API |
| Ruleset Content | Define the ruleset content using the **Spectral-like format**. You can either write the rules manually or upload a pre-written ruleset file. The spec to write the ruleset can be access via [WSO2 rule validator documentation]({{base_path}}/governance/rule-validator/) | Yes | - |

After providing the required information, click on the **Create** button to create the ruleset.

<a href="{{base_path}}/assets/img/governance/ruleset_create.jpg">
  <img src="{{base_path}}/assets/img/governance/ruleset_create.jpg" alt="APIM Governance Ruleset Create"/>
</a>

### Create and Manage Policies
On the **Governance** section, click on **Policies** to view the list of policies that are available in the system. You can create a new policy by clicking on the **Create Policy** button. When creating a new policy, you need to provide the following information:

<a href="{{base_path}}/assets/img/governance/policy_view.png">
  <img src="{{base_path}}/assets/img/governance/policy_view.png" alt="APIM Governance Ruleset Create"/>
</a>

| Field Name | Description                                  | Mandatory | Options/Values                                                                                                                                           |
|------------|----------------------------------------------|-----------|----------------------------------------------------------------------------------------------------------------------------------------------------------|
| Name | The name of the policy.                      | Yes | -                                                                                                                                                        |
| Description | A brief description of the policy.           | No | -                                                                                                                                                        |
| Attachment | The way the policy is attached to the APIs.  | Yes | All APIs, APIs with specific labels, None                                                                                                                |
| Enforcement Detail | The detail of the policy enforcement.        | Yes | **Governed State** <br/> API Create, API Update, API Deploy, API Publish <br/> **Severity Levels** <br/> Error, Warn, Info <br/> **Actions** <br/> Notify, Block |
| Ruleset | The rulesets that is attached to the policy. | Yes | -                                                                                                                                                        |

After providing the required information, click on the **Create** button to create the policy.

<a href="{{base_path}}/assets/img/governance/policy_create.jpg">
  <img src="{{base_path}}/assets/img/governance/policy_create.jpg" alt="APIM Governance Ruleset Create"/>
</a>
