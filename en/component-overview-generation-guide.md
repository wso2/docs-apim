# AI Agent Instructions: WSO2 API Manager Component Overview Documentation

## Task: Create Educational Overview Documentation

Generate a comprehensive overview document for a WSO2 API Manager component that serves as a navigation hub for understanding and implementation.

## Input Required
```
Component: [COMPONENT_NAME]
Problem it solves: [PRODUCTION_CHALLENGES_ADDRESSED]
Target users: [USER_TYPES]
Architecture: [SINGLE_FEATURE / MULTIPLE_SUB_COMPONENTS / COMPLEX_SYSTEM]
Existing docs: [LIST_DOCUMENTATION_PATHS]
Platform integration: [WSO2_API_MANAGER_INTEGRATION_POINTS]
```

## Document Objectives
1. Help new users understand what problems this component solves and when to use it
2. Provide clear understanding of capabilities before users dive into implementation
3. Guide users to appropriate detailed documentation based on their needs  
4. Position component within WSO2 API Manager ecosystem

## Target Audience
- **New Users**: Need clear implementation paths and progressive guidance
- **Technical Teams**: Require comprehensive feature coverage and actionable links
- **AI Agents**: Need structured, parseable information

## Required Content Structure

### Introduction Section
**Format**: Problem/solution approach with bullet-pointed value propositions
**Content**: Position component within WSO2 API Manager ecosystem
**Example Pattern**:
```markdown
# [Component Name]

[1-2 sentences describing production challenges this component solves]

**WSO2 [Component Name]** provides [solution description within API Manager platform].

As [description of role], it delivers:
- **[Capability]**: [Benefit description]
- **[Capability]**: [Benefit description]
[Continue for 6-8 key capabilities]
```

### Architecture Section (if applicable)
**Content**: Brief integration description with WSO2 API Manager
**Include**: Cloud-native capabilities mention
**Add**: Architecture diagram placeholder

### Component/Feature Sections
**Organization**: Structure based on component architecture (single feature / multiple sub-components / feature groupings)
**Format**: 
- When to Use subsection (3-4 bullet points)
- Features organized by logical categories
- Each feature: `**[Feature Name]({{base_path}}/path/)**: Brief description with actionable outcome`

### Implementation Guidance Section
**Choose format based on component type**:
- **Scenario-based**: For different use cases → `**[User Situation]**: Brief context` with numbered steps
- **Progressive**: For learning progression → `**Start Here / Build On / Advanced**` sections  
- **Decision-tree**: For choice scenarios → `**If [Condition]: Use [Approach]**` format
- **Conceptual**: For complex components → Focus on understanding concepts first

### Best Practices Section  
**Format**: Actionable guidance with rationale
**Content**: Production experience, specific recommendations, monitoring guidance
**Pattern**: `### [Practice Area]` + explanation of rationale + specific recommendations + links

### Next Steps Section
**Placement**: Final section at document end
**Purpose**: Guide users to appropriate implementation starting points
**Format**: Simple, concise hints without excessive sub-structure
**Content**: Direct links to getting started guides with brief use case hints
**Pattern**: 
```markdown
## Next Steps

Choose your path based on your use case:

- **[Getting Started with [Component A]]({{base_path}}/path/)** - For [specific use case description]
- **[Getting Started with [Component B]]({{base_path}}/path/)** - For [different use case description]
```

## Mandatory Requirements

### Writing Standards
- **Technical Precision**: No marketing language ("world's best", "most popular", superlatives)
- **User-Centric**: Write for specific user scenarios, not generic audiences  
- **Progressive Complexity**: Start simple, clearly separate advanced capabilities
- **Actionable Content**: Every feature must link to implementation documentation
- **Zero Redundancy**: Each concept explained once in most appropriate context

### Link Requirements
- **{{base_path}} Format**: All internal links use `{{base_path}}/path/to/page/` format
- **Link Verification**: Every link must point to existing documentation files
- **Directory Links**: Link to `overview.md` or main entry point, not bare directories
- **Platform Integration**: Link to existing WSO2 API Manager docs, do not duplicate shared capabilities

### Content Organization Rules
1. **Component-Based Structure**: Organize features under respective components/sub-components
2. **Logical Category Grouping**: Group related features (Core Operations, Security, Performance, etc.)
3. **Scenario-Based Implementation Guidance**: Use specific user scenarios, not generic "Phase 1, Phase 2"
4. **Actionable Best Practices**: Provide production guidance with rationale, not feature lists

## Validation Checklist

Execute this validation before completing the document:

### Content Validation
- [ ] Introduction uses problem/solution format with clear value propositions
- [ ] All features have actionable descriptions with implementation links
- [ ] Zero redundant content across all sections
- [ ] Best practices provide specific production guidance with rationale
- [ ] Implementation guidance uses specific user scenarios (not generic phases)
- [ ] Next Steps section provides concise guidance without redundant sub-structure
- [ ] Next Steps links direct to appropriate getting started guides

### Technical Validation
- [ ] All links use `{{base_path}}/path/` format
- [ ] All links verified to point to existing documentation files  
- [ ] No broken or 404 links
- [ ] Links to existing platform capabilities instead of duplicating content
- [ ] Consistent markdown formatting throughout

### User Experience Validation
- [ ] New users can identify appropriate implementation path within 30 seconds
- [ ] Advanced users can discover all capabilities through clear navigation
- [ ] No information overwhelming (separate essential from advanced clearly)
- [ ] Logical progression from understanding to implementation
- [ ] Each section serves specific navigation purpose

## Execution Process

### 1. Research Phase
- Audit existing documentation: map all component features and sub-components
- Identify 3 main user scenarios/types for the component
- Map component architecture and platform integration points
- Verify all documentation link targets exist

### 2. Content Generation  
- Write introduction using problem/solution format with 6-8 value proposition bullets
- Structure component sections based on architecture (single/multiple/complex)
- Organize features into logical categories with {{base_path}} links
- Create scenario-based implementation guidance (not generic phases)
- Draft production best practices with specific recommendations

### 3. Validation Execution
- Execute complete validation checklist
- Verify all links point to existing files
- Eliminate any redundant content across sections  
- Ensure clear separation of essential vs advanced capabilities
- Confirm logical flow from understanding to implementation

## Required Patterns

### Feature Description Pattern
```markdown
- **[Feature Name]({{base_path}}/component/feature/)**: Action-oriented description focusing on user outcomes and business value
```

### Implementation Guidance Patterns (Select Based on Component Type)

**Scenario-Based** (for different use cases):
```markdown
**[User Situation]**: Brief context and goals
1. [Action with link to documentation]
2. [Configuration step]  
3. [Validation step]
```

**Progressive Learning** (for natural progression):
```markdown  
**Foundation**: Basic concepts and implementation
**Intermediate**: Common extensions and integrations
**Advanced**: Enterprise features and complex scenarios
```

**Decision-Tree** (for choice scenarios):
```markdown
**If [Condition]**: Use [Approach] - [link]
**If [Different Condition]**: Use [Alternative] - [link]
**For [Complex Case]**: Consider [Comprehensive Approach] - [link]
```

### Best Practice Pattern
```markdown
### [Practice Area Title]
[Rationale explanation]. [Specific recommendation with links]. [Monitoring guidance]. [Implementation approach].
```

### Best Practice Pattern
```markdown
### [Practice Area]
[Rationale and context]. [Specific recommendation with links]. [What to monitor/measure]. [Progressive implementation guidance].
```

## Prohibited Actions

1. **Feature Lists**: Do not create exhaustive feature catalogs; focus on decision-making context
2. **Tutorial Content**: Do not include step-by-step implementation; provide educational context only  
3. **Marketing Language**: Eliminate superlatives, "best-in-class", "industry-leading", unsubstantiated claims
4. **Template Rigidity**: Do not force component into standard template; adapt to natural organization
5. **Platform Duplication**: Do not rewrite shared WSO2 API Manager capabilities; link to existing docs
6. **Information Overload**: Do not overwhelm new users; separate essential from advanced clearly
7. **Next Steps Redundancy**: Do not duplicate advanced features in overview Next Steps; these are covered in component-specific getting started guides
7. **Implementation Details**: Focus on "what" and "why", not "how" (link to detailed guides)
8. **Unverified Links**: Do not include links without verifying they point to existing files
9. **Content Redundancy**: Do not explain same concept multiple times; consolidate in appropriate context

## AI Agent Task Execution

**Input Template:**
```
Component: [COMPONENT_NAME]
Description: [BRIEF_COMPONENT_DESCRIPTION]  
Problem solved: [PRODUCTION_CHALLENGES_ADDRESSED]
Target users: [PRIMARY_USER_TYPES]
Architecture: [SINGLE_FEATURE | MULTIPLE_SUB_COMPONENTS | COMPLEX_SYSTEM]
Existing documentation: [LIST_CURRENT_DOC_PATHS]
Platform integration: [WSO2_API_MANAGER_INTEGRATION_POINTS]
```

**Task Execution:**
1. Research existing documentation structure in provided paths
2. Generate introduction using problem/solution format with 6-8 value bullets
3. Structure component sections based on architecture type
4. Create scenario-based implementation guidance (not generic phases)
5. Generate actionable best practices with production rationale
6. Add concise Next Steps section directing to getting started guides
7. Use {{base_path}}/path/ format for all internal links
8. Execute validation checklist before completion
9. Ensure zero redundancy across all sections
10. Position component within WSO2 API Manager ecosystem context

**Output:** Complete markdown document following required content structure and patterns

---

**End of AI Agent Instructions**