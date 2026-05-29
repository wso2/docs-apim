# Quick Start Guide: API Manager Governance  

This guide provides a step-by-step overview of how to set up and apply governance policies to artifacts in API Manager.  

## Prerequisites  

Before configuring governance, ensure that:  
- The API Manager is installed and running.  
- You have the necessary permissions to configure governance policies.  
- Artifacts such as APIs and MCP Servers are registered in the API Manager.  

## Step 1: Understanding Governance  

Governance helps maintain **security, compliance, and consistency** across artifacts such as APIs and MCP Servers. It involves:  
- Defining **rulesets** that establish governance policies.  
- Creating **policies** that apply these rulesets to artifacts.  
- Using **labels** to categorize artifacts for policy enforcement.  

## Step 2: Creating a Ruleset  

A **ruleset** is a collection of rules that define governance policies.  

1. Log in to the Admin Portal.
2. Navigate to **Governance > Ruleset Catalog** in the API Manager.  
3. Click **Create Ruleset** and provide:  
   - **Name**: A unique identifier for the ruleset.  
   - **Description** (optional): Additional details about the ruleset.  
   - **Validation Type**: Choose from Definition, Metadata, or Documentation.  
   - **Artifact Type**: Choose from REST API, Async API, or MCP Server.
4. Add specific **rules** related to security, compliance, and performance.  
5. Save and activate the ruleset.  

## Step 3: Defining a Policy  

A **policy** is a high-level grouping of rulesets that applies governance policies to artifacts.  

1. Navigate to **Governance > Policies**.  
2. Click **Create Policy** and enter:  
   - **Name** and **Description**.  
   - **Rulesets** to be enforced.  
   - **Enforcement Criteria**:  
     - **Artifact State** (e.g., Create, Update, Publish, Deploy).  
     - **Rule Violation Level** (Error, Warn, Info).  
     - **Rule Violation Action** (Block or Notify).  
3. Save the policy.  

## Step 4: Applying Policies Using Labels  

A **label** groups artifacts based on type or purpose, enabling automated policy enforcement.  

1. Navigate to **Governance > Labels**.  
2. Click **Create Label** and enter:  
   - **Name** and **Description**.  
   - **Associated Policies** to be applied.  
3. Save the label.  
4. Assign the label to relevant artifacts in the API Manager.  

## Step 5: Monitoring Governance Compliance  

To track policy enforcement and compliance for artifacts:  

1. Navigate to **Governance > Compliance**.  
2. Review the compliance status, violations, warnings, and enforcement actions.  
3. Adjust rulesets, policies, or labels as needed to improve compliance.  

## Next Steps  

- Explore **advanced governance configurations**.  
- Automate governance checks using API Manager's CI/CD pipelines for supported artifact types.  
- Integrate governance with security and analytics tools.  

This guide provides a foundational setup for artifact governance. For detailed configurations, refer to the **API Manager Governance Documentation**.  
