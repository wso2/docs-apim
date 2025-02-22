# API Management Governance

API Management Governance is a set of processes, practices, roles, and responsibilities that ensure the effective and efficient management of APIs throughout their lifecycle. It is essential for organizations to have a governance strategy in place to ensure that APIs are developed, managed, and consumed in a consistent and secure manner. API governance helps organizations to achieve their business goals by enabling them to create, publish, and manage APIs that meet the needs of their customers and partners.

This section provides information on the governance features available in WSO2 API Manager and how you can use them to manage your APIs effectively.

Governance Concepts
--------------------

API Management Governance build on the following concepts

### Ruleset
A ruleset is a set of rules that define the governance policies that need to be enforced on APIs. A ruleset can contain rules related to security, compliance, performance, and other aspects of API management. Rulesets can be defined at the organization level and later attached to policies to enforce governance policies on APIs.
Every ruleset should have a unique name and may have a description to provide additional information about the ruleset. A ruleset can be defined to validate on of the following aspects of an API:

- API Definition - API Definition is the OpenAPI/ AsyncAPI definition of the API that is used to define the API contract.
- API Metadata - API Metadata is the information about the API such as the API name, version, context, and other details.
- API Documentation - API Documentation is the documentation of the API that provides information on how to use the API.

The API type is also specified when defining a ruleset. The API type can be one of the following:
- REST API
- Async API

### Policy
A policy is a set of rules that define the governance policies that need to be enforced on APIs. Policies can be defined at the organization level and later attached to APIs to enforce governance policies on APIs. Policies can be defined to enforce rules related to security, compliance, performance, and other aspects of API management. Policies can use as a high-level grouping of rules that can be applied to APIs. As an example, policies can define to represent external APIs, internal APIs, and partner APIs etc.

Every policy should have a unique name and may have a description to provide additional information about the policy. Policy can be attached to a label or multiple labels to categorize the policies. Labels are used as the bridge between policies and APIs. When a policy is attached to a label, it is applied to all APIs that are associated with the label. 

The policy enforcement detail is also a part of the policy definition. The policy enforcement detail can be categorized in to 3 types:
- API state - The policy is enforced based on the state of the API. The policy can be enforced when the API is in transition to a specific state. The current supported states are:
  - Create
  - Update
  - Publish
  - Deploy
- Rule violation level - The policy is enforced based on the level of violation of the rule. The current supported levels are:
  - Error
  - Warn
  - Info
- Rule violation action - The policy is enforced based on the action that needs to be taken when a rule violation is detected. The current supported actions are:
  - Block - Block the operation, this can be only enforced for the API state transition of Publish and Deploy.
  - Notify - Notify the user about the rule violation. Currently, this will populate the compliance dashboards so that user can take necessary actions after reviewing the violations.


Governance Administrative Capabilities
--------------------------------------

API Management Governance provides the following administrative capabilities to manage rulesets and policies

### Create and Manage Rulesets
Log in to the API Manager Admin Portal and click on the **Governance** section. Click on **Rulesets Catalog** to view the list of rulesets that are available in the system. You can create a new ruleset by clicking on the **Create Ruleset** button. When creating a new ruleset, you need to provide the following information:

<a href="{{base_path}}/assets/img/governance/rule_view.png"><img src="{{base_path}}/assets/img/governance/rule_view.png" width="70%" alt="APIM Governance Ruleset View"></a>


| Field Name | Description                                                                                                                                                                                              | Mandatory | Options/Values |
|------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------|----------------|
| Name | The name of the ruleset.                                                                                                                                                                                 | Yes | - |
| Description | A brief description of the ruleset.                                                                                                                                                                      | No | - |
| Documentation Link | A link to the documentation of the ruleset.                                                                                                                                                              | No | - |
| Ruleset Type | The type of the ruleset.                                                                                                                                                                                 | Yes | API Definition, API Metadata, Documentation |
| Artifact Type | The type of the API.                                                                                                                                                                                     | Yes | REST API, Async API |
| Ruleset Content | The content of the ruleset. The rule has to written in a spectral like format. Furthermore, a pre written ruleset can be uploaded. [WSO2 rule validator documentation](rule-validator/rule-validator.md) | Yes | - |

After providing the required information, click on the **Create** button to create the ruleset.


### Create and Manage Policies
On the **Governance** section, click on **Policies** to view the list of policies that are available in the system. You can create a new policy by clicking on the **Create Policy** button. When creating a new policy, you need to provide the following information:

| Field Name | Description                                  | Mandatory | Options/Values                                                                                                                                           |
|------------|----------------------------------------------|-----------|----------------------------------------------------------------------------------------------------------------------------------------------------------|
| Name | The name of the policy.                      | Yes | -                                                                                                                                                        |
| Description | A brief description of the policy.           | No | -                                                                                                                                                        |
| Attachment | The way the policy is attached to the APIs.  | Yes | All APIs, APIs with specific labels, None                                                                                                                |
| Enforcement Detail | The detail of the policy enforcement.        | Yes | **Governed State** <br/> API Create, API Update, API Deploy, API Publish <br/> **Severity Levels** <br/> Error, Warn, Info <br/> **Actions** <br/> Notify, Block |
| Ruleset | The rulesets that is attached to the policy. | Yes | -                                                                                                                                                        |

After providing the required information, click on the **Create** button to create the policy.


