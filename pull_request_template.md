## Purpose
Improves the quality and professionalism of the WSO2 API Manager documentation by fixing multiple typographical, grammatical, capitalization, and formatting issues across navigation entries.


## Goals
Enhance the accuracy, consistency, and readability of the API Manager documentation by:

- Fixing spelling and casing errors in navigation titles (correcting "Asymetric", proper capitalization of "API").
- Fixing grammatical inconsistencies to ensure parallel structure in menu items (correcting mixed verb tenses).
- Applying proper hyphenation and title-casing to compound security terms.
- Resolving a formatting issue where a Markdown file prefix (admin_) appeared into the rendered UI text.

## Approach
Updated navigation entries (mainly in `mkdocs.yml`) with the following corrections:

### 1. Spelling & Casing Corrections
- **"About Asymetric Cryptography" → "About Asymmetric Cryptography"**  
  *Security → Configure Keystores*

- **"Change the Provider of an Api" → "Change the Provider of an API"**  
  *Manage Applications → Advanced Topics*

- Standardized **"api" → "API"** (12 occurrences) to ensure consistent technical terminology across the documentation.

- **"PingFederate as A Key Manager" → "PingFederate as a Key Manager"**  
  *Third-Party Key Managers*


### 2. Grammar & Phrasing Corrections
- **"Enable or Disabling Self Signup" → "Enabling or Disabling Self Signup"**  
  *Customizations → Customize the Developer Portal*

- **"Configure Single Sign On with SAML2" → "Configure Single Sign-On with SAML2"**

- **"Multi Factor Authentication" → "Multi-Factor Authentication"**

- **"Role based access control" → "Role-Based Access Control"**

- **"Fine Grained Access Control" → "Fine-Grained Access Control"**

### 3. Formatting & UI Fix
Removed an unintended file prefix that appeared in the UI:

- **"admin_Directory Structure of WSO2 Products" → "Directory Structure of WSO2 Products"**  
  *Compliance Guides → Guides*

Renamed the file "about-asymetric-cryptography.md" into "about-asymmetric-cryptography.md"

## User Stories
As a documentation reader, I want clear, correctly formatted navigation titles so that the documentation appears professional and is easier to understand and navigate.

## Release Note
Improved documentation quality by correcting spelling, grammar, capitalization, and formatting issues in navigation titles.

## Documentation
N/A — This change improves existing documentation structure and wording without introducing new documentation content.

## Training
N/A — No training content changes required.

## Certification
N/A — These documentation improvements do not impact certification exams.

## Marketing
N/A — Internal documentation quality improvement only.

## Automation Tests
- Unit Tests  
  N/A

- Integration Tests  
  N/A

## Security Checks
- Followed secure coding standards: **N/A (documentation update)**
- Ran FindSecurityBugs plugin: **N/A**
- Confirmed that no credentials, tokens, or secrets are included: **Yes**

## Samples
N/A — No code samples affected.

## Related PRs
N/A

## Migrations
N/A

## Test Environment
Tested by verifying the rendered navigation structure locally.

## Learning
Reviewed documentation style conventions including:

- Proper technical capitalization
- Title casing for navigation items
- Standard hyphenation for security terminology
- Consistency with existing documentation patterns