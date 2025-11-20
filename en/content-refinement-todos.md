# Future TODO List for WSO2 API Manager Documentation Restructuring

## Content-Specific TODOs Identified During Design APIs Analysis

### Rate Limiting Content Refinement
**Priority: Medium**
- **Task**: Refactor rate limiting content to better align with component-based architecture
- **Details**: Currently rate limiting content is distributed across multiple components but could be better organized by the component responsible for applying each rate limiting policy
- **Current State**: Rate limiting policies are split between Management Portal (most), Admin Portal (policy creation), API Portal (application management), and API Gateways (clustering)
- **Future Goal**: Reorganize content by actual component workflows rather than just moving entire sections

### API Monetization Missing Navigation Entry
**Priority: Low**
- **Task**: Add `configuring-api-monetization-category-labels.md` to mkdocs.yml navigation structure
- **Details**: This file exists in the filesystem but is missing from the navigation structure
- **File**: `/docs/manage-apis/design/api-monetization/configuring-api-monetization-category-labels.md`
- **Target Location**: Admin Portal section (monetization category configurations)

### API Monetization Component Separation
**Priority: Medium**
- **Task**: Refactor API Monetization content by component-specific tasks
- **Current State**: Currently moved to new "API Analytics and Monetization" section as a whole
- **Future Breakdown**:
  - **Management Portal**: API Publisher monetization workflows (setting up billing plans, enabling monetization for APIs)
  - **Admin Portal**: Monetization category configurations, billing plan settings
  - **System Setup**: Billing engine integration, database setup, JAR installations
  - **API Portal**: Monetization labels and billing plan display for developers

### B2B API Management Component Separation
**Priority: Medium**
- **Task**: Split B2B API Management content by component workflows
- **Current State**: Moved entire section to Admin Portal
- **Future Breakdown**:
  - **Admin Portal**: Organization registration, Key Manager setup, system-level B2B configurations, federated authenticator setup
  - **Management Portal**: API sharing with organizations, organization visibility settings, business plan assignment per organization
  - **API Portal**: Organization-based API discovery, organization user workflows, organization-specific application creation
  - **Key Manager/Authorization Server**: Organization-specific OAuth endpoints and configurations

### OAuth2 Content Organization
**Priority: Low**
- **Task**: Review OAuth2 content placement within Key Manager/Authorization Server section
- **Details**: Ensure all OAuth2 content is properly categorized within the Key Manager component
- **Current State**: Moved from API Security to Key Manager/Authorization Server
- **Future Consideration**: May need subcategorization as OAuth2 content grows

### Custom Hostnames Content Splitting
**Priority: Medium**
- **Task**: Split `exposing-apis-via-custom-hostnames.md` across multiple components based on user personas
- **Current State**: Moved entire content to Admin Portal for simplicity
- **Future Breakdown**:
  - **Admin Portal**: Gateway environment creation (both via Admin Portal and deployment.toml), starting second Gateway instance
  - **Management Portal**: API hostname assignment workflow in Publisher Portal
  - **API Portal**: Viewing custom hostnames in Developer Portal
- **Details**: This file contains multiple workflows serving different personas and should ideally be split to provide focused, role-based documentation

### Multiple API Gateways Content Review
**Priority: Medium**
- **Task**: Review and update `deploy-through-multiple-api-gateways.md` content and consider tutorial restructuring
- **Current State**: Moved to Management Portal as API deployment workflow
- **Action Items**:
  - **Content Review**: Verify all configuration examples and steps are up-to-date with current WSO2 API Manager version
  - **Tutorial Consideration**: Evaluate if this content should be moved to a dedicated tutorial section rather than core documentation
  - **Infrastructure vs Workflow**: Consider if the heavy infrastructure setup portions should be split to Admin Portal while keeping API deployment workflow in Management Portal
- **Details**: This file contains significant infrastructure setup content that may be better suited as a comprehensive tutorial

### Revision Deployment Workflow Component Placement
**Priority: Medium**
- **Task**: Consider moving `revision-deployment-workflow.md` from Management Portal to Admin Portal
- **Current State**: Placed in Management Portal as API deployment workflow
- **Reasoning for Admin Portal**: 
  - Primary focus is on administrative approval workflows and task management
  - Admin Portal contains the approval interface and workflow management
  - While API Publishers initiate requests, the core functionality is administrative approval
  - Workflow configuration is done via Management Console (admin-level)
- **Details**: This is fundamentally an administrative approval process that should align with other workflow management content in Admin Portal

### Consume APIs Workflow Content Refactoring
**Priority: High**
- **Task**: Deep content refactoring for workflow configuration files in Consume APIs section
- **Current State**: Workflow files kept in API Portal for simplicity
- **Files Requiring Refactoring**:
  - Application workflows: `adding-an-application-creation-workflow.md`, `adding-an-application-update-workflow.md`, `adding-an-application-key-generation-workflow.md`
  - Subscription workflows: `adding-an-api-subscription-workflow.md`, `adding-an-api-subscription-tier-update-workflow.md`, `adding-an-api-subscription-deletion-workflow.md`
- **Refactoring Approach**:
  - **Admin Portal**: Workflow configuration, approval management, administrative setup
  - **API Portal**: User-facing workflow experience, request submission, status checking
- **Details**: These files contain both administrative workflow configuration and user workflow experience that should be split across components

### Monitoring Component Architecture Review
**Priority: Medium**
- **Task**: Review and potentially reorganize the Monitoring section for better component alignment
- **Current State**: All monitoring content placed in dedicated Monitoring component
- **Considerations**:
  - **Analytics Platform Integration**: Consider if external analytics (Moesif, ELK, DataDog) should be in Admin Portal vs Monitoring
  - **Component-Specific Monitoring**: Some monitoring may be better placed within respective components (e.g., Gateway monitoring with API Gateways, Application monitoring with API Portal)
  - **Cross-Component Monitoring**: Determine which monitoring content spans multiple components vs component-specific monitoring
- **Details**: Current placement is practical but may benefit from review to align monitoring content with the components they actually monitor

### AI Gateway Content Component Distribution
**Priority: High**
- **Task**: Split AI Gateway content across appropriate components based on user personas and workflows
- **Current State**: Moved entire AI Gateway section under API Gateways component for simplicity
- **Proposed Distribution**:
  - **Management Portal**: AI API creation workflows (`getting-started-with-ai-gateway.md`, `ai-backend-security.md`, backend rate limiting configuration)
  - **Admin Portal**: AI service provider management (`ai-vendor-management/` subsection, subscription rate limiting policies)
  - **API Gateways**: Gateway runtime features (`overview.md`, `multi-model-routing/`, `prompt-management/`, `ai-guardrails/`, `semantic-caching.md`)
  - **API Portal**: Developer consumption patterns (`using-proxy-apis-in-sdks.md`)
- **Requires Discussion**: In-person discussion needed to finalize the optimal distribution strategy
- **Details**: AI Gateway functionality spans multiple components based on user workflows rather than being a monolithic gateway feature

### MCP Gateway Content Component Distribution
**Priority: High**
- **Task**: Split MCP Gateway content across appropriate components based on user personas and workflows
- **Current State**: Moved entire MCP Gateway section under API Gateways component for simplicity
- **Proposed Distribution**:
  - **Management Portal**: MCP Server creation workflows (`create-from-openapi.md`, `create-from-api.md`, `create-from-mcp-server.md`), MCP tool configuration and management (`update-and-deploy-mcp-server.md`)
  - **API Portal**: MCP Server consumption workflows (`subscribe-to-a-mcp-server.md`, `invoke-a-mcp-server-using-playground.md`), MCP server discovery and documentation
  - **CLI (apictl)**: MCP server management via command line (`managing-mcp-servers.md`, `importing-mcp-servers-via-dev-first-approach.md`)
  - **API Gateways**: MCP server runtime and gateway deployment aspects (`overview.md` - architecture and deployment sections)
- **Requires Discussion**: In-person discussion needed to finalize the optimal distribution strategy
- **Details**: MCP functionality spans multiple user workflows similar to AI Gateway - Publishers create/manage, Developers consume/test, CLI users automate, Gateway handles runtime

### Key Managers Content Component Placement Review
**Priority: Medium**
- **Task**: Review whether Key Managers administration content should remain in Admin Portal or move to Key Manager/Authorization Server component
- **Current State**: Key Managers content from Administer section moved to Admin Portal alongside other administrative tasks
- **Consideration**: Key Manager/Authorization Server component already contains OAuth2 content from Design APIs analysis
- **Decision Factors**:
  - **Admin Portal**: Key manager configuration and administration from system admin perspective (current placement)
  - **Key Manager/Authorization Server**: Consolidate all key manager-related content in dedicated component
- **Content in Question**: `administer/key-managers/` subsection including multiple key manager connectors, global key manager configuration, application scopes
- **Details**: Need to determine if key manager administration should be grouped with OAuth2 functionality or remain as administrative task

### Multiple Gateways Content Component Placement Review  
**Priority: Medium**
- **Task**: Review whether Multiple Gateways content should remain in Admin Portal or move to API Gateways component
- **Current State**: Multiple Gateways content from Administer section moved to Admin Portal as administrative task
- **Consideration**: API Gateways component already contains gateway-specific policies and configurations
- **Decision Factors**:
  - **Admin Portal**: Gateway environment administration and configuration from admin perspective (current placement)
  - **API Gateways**: Consolidate all gateway-related content including environment setup and configuration
- **Content in Question**: `administer/multiple-gateways/` subsection including gateway configuration and visibility settings
- **Details**: Need to determine if gateway environment administration should be grouped with gateway runtime content or remain as administrative task

### Cross-Component Content References
**Priority: High**
- **Task**: Establish cross-referencing system for content that spans multiple components
- **Details**: Some workflows (like B2B setup) involve multiple components and need clear cross-references
- **Examples**: 
  - B2B setup involves Admin Portal (setup) → Management Portal (API sharing) → API Portal (consumption)
  - Rate limiting involves Admin Portal (policy creation) → Management Portal (policy application) → API Gateways (enforcement)

### API Policies Gateway Content
**Priority: Low**
- **Task**: Review and potentially reorganize Regular Gateway Policies content
- **Current State**: Moved entire `regular-gateway-policies/` folder to API Gateways section
- **Future Consideration**: Some policies might be better organized by use case rather than just being gateway-specific
