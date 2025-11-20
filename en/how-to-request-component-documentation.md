# How to Request Component Overview Documentation

This guide shows you how to use the component overview generation methodology to request documentation from an AI agent (like GitHub Copilot).

## Quick Start

### Step 1: Fill Out Component Information

Copy and complete this template:

```
Component: [Your component name]
Description: [Brief description of what it does]
Problem solved: [What production challenges it addresses]
Target users: [Who uses this component]
Architecture: [SINGLE_FEATURE | MULTIPLE_SUB_COMPONENTS | COMPLEX_SYSTEM]
Existing documentation: [List current documentation paths]
Platform integration: [How it uses WSO2 API Manager features]
```

### Step 2: Make Your Request

Send this to your AI agent:

**"Using the component overview generation guide, create documentation for:**

[Paste your completed template here]

**Generate the complete overview document following the guide requirements."**

## Examples

### Example 1: Simple Feature
```
Component: Basic Authentication
Description: Username/password authentication for API access
Problem solved: Simple authentication needs without complex OAuth setup
Target users: Developers building internal APIs, proof-of-concept projects
Architecture: SINGLE_FEATURE
Existing documentation: docs/api-design-manage/design/api-security/api-authentication/
Platform integration: Uses WSO2 API Manager's built-in authentication policies
```

### Example 2: Multiple Sub-components
```
Component: Rate Limiting
Description: Traffic management and resource protection capabilities
Problem solved: API abuse prevention, resource consumption management, ensuring fair usage
Target users: API developers, DevOps teams, Enterprise architects
Architecture: MULTIPLE_SUB_COMPONENTS
Existing documentation: docs/api-design-manage/design/rate-limiting/, docs/administer/throttling/
Platform integration: Uses gateway policies, integrates with analytics and monitoring
```

### Example 3: Complex System
```
Component: API Analytics
Description: Comprehensive monitoring and insights into API usage and performance
Problem solved: Lack of visibility into API usage patterns, performance bottlenecks, business metrics
Target users: API product managers, DevOps teams, Business analysts
Architecture: COMPLEX_SYSTEM
Existing documentation: docs/monitoring/api-analytics/, docs/monitoring/observability/
Platform integration: Uses API Manager's data collection, integrates with multiple analytics backends
```

## What Happens Next

The AI agent will:

1. **Research your existing documentation** to understand the component
2. **Extract accurate technical information** from current docs
3. **Generate a complete overview document** following WSO2 standards
4. **Verify all links** point to existing documentation
5. **Structure content** based on your component's architecture
6. **Apply quality validation** before providing the final document

## Tips for Better Results

### Provide Accurate Paths
- List all relevant documentation directories
- Include subdirectories if they contain important content
- Mention related components or integrations

### Be Specific About Users
- Don't just say "developers" - specify what kind (API developers, frontend developers, etc.)
- Include business roles if relevant (product managers, architects)
- Mention experience levels when important (beginners, enterprise teams)

### Choose the Right Architecture Type
- **SINGLE_FEATURE**: One main capability (e.g., Basic Auth, API Keys)
- **MULTIPLE_SUB_COMPONENTS**: Several related features (e.g., Rate Limiting has subscription policies, application policies, advanced throttling)
- **COMPLEX_SYSTEM**: Multiple interconnected parts (e.g., Analytics with different deployment options, integrations, dashboards)

## Expected Output

You'll receive a complete markdown document with:

- **Problem/solution introduction** with clear value propositions
- **Component sections** organized by architecture type
- **Implementation guidance** using scenario-based approaches
- **Best practices** with actionable production advice
- **Working links** using {{base_path}} format to existing documentation
- **Quality validation** ensuring no redundancy or broken links

The document will serve as a navigation hub that helps users understand the component before diving into detailed implementation guides.