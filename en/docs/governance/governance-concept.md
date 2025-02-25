# Governance Concepts
API Management Governance build on the following concepts

## Ruleset
A ruleset is a collection of rules that define governance policies to be enforced on APIs. These rules cover various aspects of API management, including security, compliance, performance, and operational guidelines. Rulesets can be defined at the organization level and later applied through policies to ensure governance enforcement.

Each ruleset must have a unique name and may include a description to provide additional context. Rulesets are used to validate specific aspects of an API, including:

- **API Definition** – The OpenAPI or AsyncAPI definition that establishes the API contract.
- **API Metadata** – Information about the API, such as name, version, context, and other details.
- **API Documentation** – Documentation that provides usage guidelines and other relevant information about the API.

When defining a ruleset, the API type must be specified. Supported API types include:

- **REST API**
- **Async API**

## Policy

A **policy** is a set of rules that define governance policies to be enforced on APIs. Policies can be created at the organization level and later applied to APIs to enforce security, compliance, performance, and other governance requirements. Policies act as high-level groupings of rules and can be used to categorize APIs, such as external APIs, internal APIs, and partner APIs.

Each policy must have a **unique name** and may include a **description** to provide additional context.

#### Policy Association and Labeling

Policies can be attached to one or more **labels** to categorize them effectively. Labels serve as a link between policies and APIs—when a policy is assigned to a label, it is automatically applied to all APIs associated with that label.

#### Policy Enforcement

Policy enforcement is an integral part of policy definition and can be categorized into three types:

#### 1. API State Enforcement

Policies can be enforced based on the lifecycle state of an API. Enforcement occurs when an API transitions into a specific state. The supported states include:

- **Create**
- **Update**
- **Publish**
- **Deploy**

#### 2. Rule Violation Level

Policies can be enforced based on the severity of rule violations. The supported levels include:

- **Error** – Indicates a critical violation.
- **Warn** – Indicates a warning that requires attention.
- **Info** – Provides informational messages about compliance.

#### 3. Rule Violation Action

Policies define actions to be taken when a rule violation is detected. The supported actions include:

- **Block** – Prevents the API operation. This can only be enforced during the **Publish** and **Deploy** state transitions.
- **Notify** – Alerts users about the violation. Notifications appear in compliance dashboards, allowing users to review and take necessary actions.

This section provides details on how to define and manage policies for effective API governance.

## Label  

A **label** is a tag that can be attached to APIs to categorize them based on specific criteria. Labels help group APIs according to their type, purpose, or any other classification relevant to the organization.  

### Label Usage  

Labels can be used to:  

- Organize APIs into meaningful categories.  
- Apply policies to APIs based on their category.  

When a policy is attached to a label, it is automatically applied to all APIs associated with that label.  

This section provides details on how to define and manage labels for effective API governance.  
