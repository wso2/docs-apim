# Governance Concepts

The governance capabilities in WSO2 API Manager builds upon the following core concepts:

## Artifact

Entity that is subject to governance enforcement. In the context of API governance, the governance artifact is an API or an MCP Server.

## Ruleset
A ruleset is a **collection of rules** that define governance policies to be enforced on [governance artifacts](#artifact). 

In the context of governance, these rules cover various aspects of API management, including security, compliance, performance, and operational guidelines. Rulesets can be defined at the organization level and later applied through policies to ensure governance enforcement.

Each ruleset must have a **unique name** and may include a description for additional context. It is **bound to a specific Artifact type (REST, Async, MCP)** and is used to **validate specific aspects of an Artifact**, including:

- **Artifact Definition** – The OpenAPI or AsyncAPI definition that establishes the Artifact contract.
- **Artifact Metadata** – WSO2 API Manager's interpretation of an Artifact, encompassing general information such as name and 
  version, along with API management-specific details such as security configurations, 
  business plans, etc.
- **Artifact Documentation** – Documentation that provides usage guidelines and other relevant information about the artifact.

Rules within a ruleset can have different **severity levels**, such as:

- **Error** – Indicates a critical violation.
- **Warn** – Indicates a warning that requires attention.
- **Info** – Provides informational messages about compliance.

## Policy

A policy is a **collection of rulesets** that can be enforced on [governance artifacts](#artifact) to ensure governance compliance.

In the context of governance, policies can be created at the organization level and applied to Artifacts to enforce governance requirements. They also provide the capability to apply different governance rulesets to different groups of Artifacts based on organizational needs.

Each policy must have a **unique name** and may include a **description** to provide additional context.

#### Policy Attachment

Policies can be attached to one or more **[labels](#label)** to categorize them effectively. Labels serve as a link between policies and Artifacts when a policy is assigned to a label, it is automatically applied to all Artifacts associated with that label.

#### Policy Enforcement Criteria

The policy enforcement criteria define when a policy should be applied and what actions should be taken if a policy violation occurs.

#### 1. When to Enforce

Policies can be triggered at different points in the Artifact's lifecycle. The enforcement happens when an Artifact transitions to a specific state. The stages where enforcement can occur include:

- **Create**
- **Update**
- **Deploy**
- **Publish**

#### 2. What to Do

Policies can be configured to take specific actions based on the severity of rule violations. The available actions include:

- **Block** – Prevents the Artifact operation from proceeding. This action can only be enforced during the **Publish** and **Deploy** stages.
- **Notify** – Sends alerts to users about the violation. Notifications appear in compliance dashboards, allowing users to review and resolve the issue.

## Label  

A **label** is a tag that can be attached to a specific [governance artifact](#artifact) to categorize them based on specific criteria. 

In the context of governance, labels help group Artifacts according to their type, purpose, or any other classification relevant to the organization.  

#### Label Usage  

Labels can be used to:  

- Organize Artifacts into meaningful categories.  
- Apply policies to Artifacts based on their category.  

When a label is attached to a policy, that policy is automatically applied to all Artifacts associated with that label.
