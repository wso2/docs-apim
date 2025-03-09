# API Creator, Publisher Capabilities

WSO2 API Manager enables API creators and publishers to effectively monitor the compliance status of their APIs.

## Compliance Evaluation for APIs

APIs are evaluated based on governance policies that enforce rulesets to ensure adherence to organizational standards. These policies are categorized into two types:

- **Global Policies** – Automatically applied to all APIs.
- **Labeled Policies** – Applied when specific labels are assigned to an API.

**Policy Execution and Evaluation** take place during following API lifecycle events depending on policy configuration:

- API Creation
- API Updates
- API Revision Creation and Deployment
- API Publishing

**Blocking vs. Non-Blocking Compliance Checks** can be configured by administrators based on enforcement needs:

- If a policy is configured as **blocking**, API creators **cannot proceed with the action until all compliance requirements are met**. Blocking policies are only enforceable during the API Publish and Deploy stages.
- If a policy is **non-blocking**, API actions can proceed while the **compliance check runs in the background**. The results will be displayed in the compliance dashboard once the evaluation is complete. By default, the background compliance check runs every 2 minutes if a change has been detected.

!!! tip "Understand Governance Concepts"
    To understand the core concepts of governance in WSO2 API Manager, refer to the [Governance Concepts]({{base_path}}/governance/governance-concept) documentation.

## Labeling APIs 

Labels are used to categorize APIs and enforce governance policies in line with organizational standards. 
Thus, to ensure proper governance policies are applied to APIs, API creators should attach appropriate labels to APIs. 
To add labels to an API follow these steps:  

1. Log in to the **API Manager Publisher Portal**.  
2. Select an existing API or create a new one.  
3. Navigate to the **Design** tab and open the **Portal Configurations** section.  
4. Click on **Basic Info** to access the API’s design configurations.  
5. Click the **+** icon to attach the relevant labels to the API from the list of available labels.

<a href="../../assets/img/governance/label_attach.png">
  <img src="../../assets/img/governance/label_attach.png" alt="APIM Governance API Label Attach"/>
</a>

## API Compliance Dashboard

The **API Compliance Dashboard** provides a comprehensive view of the compliance status of APIs. Follow these steps to access the dashboard:

1. Log in to the **API Manager Publisher Portal**.  
2. Select an API and navigate to the **Compliance** section from the left panel.

<a href="../../assets/img/governance/api_compliance.png">
  <img src="../../assets/img/governance/api_compliance.png" alt="APIM Governance API Compliance"/>
</a>


### **Compliance Summary**

Compliance Summary provides a list of donut charts that show policy adhrence summary, ruleset adherence summary and rule adherence summary of the selected API.

### **Detailed Rule Violations**

This section provides a breakdown of rule violations for the selected API based on severity level, categorized under each ruleset. Rules in each ruleset validate the following aspects:

- **API Definition** – The OpenAPI or AsyncAPI definition that defines the API contract.
- **API Metadata** – [API's YAML representation]({{base_path}}/reference/governance/api-yaml-representation/), which includes general details such as name and version, along with API management-specific configurations such as security settings and business plans. You can obtain the API's YAML representation by downloading the API from the API Publisher and opening the `api.yaml` file.
- **API Documentation** – [API documentation YAML representation]({{base_path}}/reference/governance/api-doc-yaml-representation/)


### **Ruleset Adherence Summary**

The Ruleset Adherence Summary widget provides a detailed view of which rulesets the selected API has passed or failed. It also displays the total number of violated rules, categorized by severity level.

### **Policy Adherence Summary**

Policy Adherence Summary widget provide a detail view of which policies are followed and violated by the selected API.

## Blocked API Operations

As previously stated in [Compliance Evaluation for APIs](#compliance-evaluation-for-apis), blocking policies are applied
during the API Publish and Deploy stages. When a blocking policy is violated, the API operation is blocked, 
and the API creator is notified of the violation. A view similar to following will be displayed in the Publisher Portal
when an API operation is blocked:

<a href="../../assets/img/governance/api_blocking.png">
  <img src="../../assets/img/governance/api_blocking.png" alt="APIM Blocked API Action"/>
</a>