# Governance Concepts

The governance capabilities in WSO2 API Manager builds upon the following core concepts:

## Artifact

Entity that is subject to governance enforcement. In the context of API governance, the governance artifact is an API.

## Ruleset
A ruleset is a **collection of rules** that define governance policies to be enforced on [governance artifacts](#Artifact). 

In the context of API governance, these rules cover various aspects of API management, including security, compliance, performance, and operational guidelines. Rulesets can be defined at the organization level and later applied through policies to ensure governance enforcement.

Each ruleset must have a **unique name** and may include a description for additional context. It is **bound to a specific API type (REST, Async)** and is used to **validate specific aspects of an API**, including:

- **API Definition** – The OpenAPI or AsyncAPI definition that establishes the API contract.
- **API Metadata** – WSO2 API Manager's interpretation of an API, encompassing general information such as name and 
  version, along with API management-specific details such as mediation policies in use, security configurations, 
  business plans, etc.
- **API Documentation** – Documentation that provides usage guidelines and other relevant information about the API.

Rules within a ruleset can have different **severity levels**, such as:

- **Error** – Indicates a critical violation.
- **Warn** – Indicates a warning that requires attention.
- **Info** – Provides informational messages about compliance.

## Policy

A policy is a **collection of rulesets** that can be enforced on [governance artifacts](#Artifact) to ensure governance compliance.

In the context of API governance, policies can be created at the organization level and applied to APIs to enforce governance requirements. They also provide the capability to apply different governance rulesets to different groups of APIs based on organizational needs.

Each policy must have a **unique name** and may include a **description** to provide additional context.

#### Policy Attachment

Policies can be attached to one or more **[labels](#label)** to categorize them effectively. Labels serve as a link between policies and APIs when a policy is assigned to a label, it is automatically applied to all APIs associated with that label.

#### Policy Enforcement Criteria

The policy enforcement criteria define when a policy should be applied and what actions should be taken if a policy violation occurs.

#### 1. When to Enforce

Policies can be triggered at different points in the API lifecycle. The enforcement happens when an API transitions to a specific state. The stages where enforcement can occur include:

- **API Create**
- **API Update**
- **API Deploy**
- **API Publish**

#### 2. What to Do

Policies can be configured to take specific actions based on the severity of rule violations. The available actions include:

- **Block** – Prevents the API operation from proceeding. This action can only be enforced during the **Publish** and **Deploy** stages.
- **Notify** – Sends alerts to users about the violation. Notifications appear in compliance dashboards, allowing users to review and resolve the issue.

## Label  

A **label** is a tag that can be attached to a specific [governance artifact](#Artifact) to categorize them based on specific criteria. 

In the context of API governance, labels help group APIs according to their type, purpose, or any other classification relevant to the organization.  

#### Label Usage  

Labels can be used to:  

- Organize APIs into meaningful categories.  
- Apply policies to APIs based on their category.  

When a label is attached to a policy, that policy is automatically applied to all APIs associated with that label.
