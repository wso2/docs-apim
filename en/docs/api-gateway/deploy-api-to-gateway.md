# Deploy an API to Gateway

This guide provides comprehensive instructions for deploying APIs and API Products to the WSO2 Universal Gateway, enabling them to be invoked through Gateway environments.

!!! info
    You can deploy the following to the Gateway:
    
    - **APIs**: REST, SOAP, SSE, WebSocket, WebSub, GraphQL
    - **API Products**

## Overview

**API Deployment** is the process of making APIs and API Products available for invocation through a Gateway environment. Key points:

- APIs and API Products must be deployed to a Gateway before they can be invoked
- They must also be published to the Developer Portal for subscription
- Deployment uses a **revision-based approach** for version control
- You can deploy to multiple Gateway environments simultaneously

!!! note
    The steps for deploying APIs and API Products are identical.

#### What is Undeployment?

**Undeploying** removes the API or API Product from the selected Gateway environment, making it unavailable for invocation through that Gateway.

---

## Prerequisites

Before deploying, ensure:

1. **Created**: The API or API Product exists in the Publisher Portal
2. **Endpoint Configured**: Valid endpoint URL is configured
3. **Gateway Environment Available**: At least one Gateway environment is configured
4. **Appropriate Permissions**: User has deployment permissions

---

## Understanding Revisions

Revisions are snapshots of your API or API Product configuration at a specific point in time. They enable:

- Version control for API configurations
- Rollback capabilities
- Deployment to multiple environments with different configurations
- Safe testing before production deployment

### Revision Limitations

!!! warning
    - Maximum of **5 revisions** can exist
    - To deploy a new revision after reaching the limit, delete an existing revision
    - Revisions cannot be edited after creation

---

## Deploying to Gateway

### Step 1: Sign in to the Publisher Portal

1. Navigate to the Publisher Portal:
   ```
   https://<hostname>:9443/publisher
   ```
   Example: `https://localhost:9443/publisher`

2. Sign in with your credentials.

3. The list of available APIs appears.

### Step 2: Select the API or API Product

1. Click on the API or API Product you want to deploy.

2. Navigate to the **Deploy** section in the left menu.

3. Click **Deployments**.

### Step 3: Deploy First Revision (New API)

If you haven't deployed any revisions yet, you'll see the following screen:

![First Revision]({{base_path}}/assets/img/design/revision/deploy-first-revision.png)

1. Optionally, provide a **description** for the revision.Good revision descriptions help track changes over time. Example: "Added rate limiting and updated endpoint"

2. Select the **API Gateway environments** where you want to deploy.

3. Click **Deploy**

4. Verify deployment status. Hover over the deployment status icon to view detailed information about the deployment.

   ![Deployment Status]({{base_path}}/assets/img/design/revision/revision-deployment-acknowledgement.png)      

### Step 4: Deploy Additional Revisions

If you already have existing revisions, the Deployments page appears as follows:

![Deploy New Revision]({{base_path}}/assets/img/design/revision/deploy-new-revision.png)

**To deploy a new revision:**

1. Click **Deploy New Revision**

2. Optionally, provide a description for the new revision

3. Select the Gateway environments for deployment

4. Click **Deploy**

5. Monitor deployment status for each Gateway

Your API or API Product is now deployed and ready to receive traffic through the Gateway!

!!! warning
    You cannot deploy more than 5 revisions. If the maximum is reached, delete an existing revision first.
    ![Delete and Deploy]({{base_path}}/assets/img/design/revision/delete-and-deploy-revision.png)

---

## See Also

- [Deploy an API]({{base_path}}/api-design-manage/deploy-and-publish/deploy-on-gateway/deploy-api/deploy-an-api/) - Step-by-step guide to deploy an API using revisions.
- [Create API Revisions]({{base_path}}/api-design-manage/design/create-api/create-api-revisions/) - Learn how to create and manage API revisions for deployment.
- [Publish an API to Developer Portal]({{base_path}}/api-developer-portal/publish-an-api-to-dev-portal/) - Make your deployed APIs discoverable and subscribable in the Developer Portal.
- [Gateway Environments]({{base_path}}/api-gateway/maintaining-separate-production-and-sandbox-gateways/) - Configure separate production and sandbox Gateway environments.
- [Gateway Policies]({{base_path}}/api-gateway/gateway-policies/) - Apply global policies across all APIs deployed on a Gateway.
- [Understand Rate Limit Enforcement]({{base_path}}/api-gateway/rate-limiting/understand-rate-limit-enforcement/) - Learn how the Gateway enforces rate limiting policies in real-time.
