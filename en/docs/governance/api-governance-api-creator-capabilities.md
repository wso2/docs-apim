## Evaluating compliance for an API

Governance compliance can be applied to an API using two methods:  

1. **Global Policies** – Automatically applied to all APIs if marked as global.  
2. **Label-Based Policies** – Policies are attached to labels, and APIs inherit the policies when a corresponding label is assigned.  

## Adding Labels to an API  

Labels are used to categorize APIs and enforce governance policies in line with organizational standards. To add labels to an API, follow these steps:  

1. Log in to the **API Manager Publisher Portal**.  
2. Select an existing API or create a new one.  
3. Navigate to the **Design** tab and open the **Portal Configurations** section.  
4. Click on **Basic Info** to access the API’s design configurations.  
5. Click the **+** icon to attach the relevant labels to the API. 

<a href="{{base_path}}/assets/img/governance/label_attach.png">
  <img src="{{base_path}}/assets/img/governance/label_attach.png" alt="APIM Governance API Label Attach"/>
</a>

## API Compliance Dashboard

The **API Compliance Dashboard** provides a comprehensive view of the compliance status of APIs. Follow these steps to access the dashboard:

1. Log in to the **API Manager Publisher Portal**.  
2. Select an API and navigate to the **Compliance** section from the left panel.

<a href="{{base_path}}/assets/img/governance/api_compliance.png">
  <img src="{{base_path}}/assets/img/governance/api_compliance.png" alt="APIM Governance API Compliance"/>
</a>


### **Compliance Summary**

Compliance summary widget provide a detail view of the compliance violations of each ruleset categorized by the severity level.

### **Policy Adherence Summary**

Policy adherence summary widget provide a detail view of the policy adherence of each policy and the compliance of each ruleset.

### **Ruleset Adherence Summary**

Ruleset adherence summary widget provide a detail view of the ruleset adherence of each ruleset and the number of violation of each rule by the severity level.

### **Ruleset Adherence**

Ruleset adherence pie chart provides a count of rulesets by passed, failed and not applied.