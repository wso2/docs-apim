# Implementing a Custom Validation Engine

This document provides step-by-step instructions for creating and deploying a custom Validation Engine in WSO2 API Manager, following the official implementation pattern of the Spectral Validation Engine.

## Step 1 - Create the Validation Engine Bundle

### Project Structure

Create an OSGi-based Maven project with the following structure:

```
validation-engine-example
├── pom.xml
└── src
    └── main
        ├── java
        │   └── org
        │       └── wso2
        │           └── carbon
        │               └── apimgt
        │                   └── governance
        │                       └── engine
        │                           └── SpectralValidationEngine.java
        └── resources
            └── META-INF
                └── MANIFEST.MF
```

### Implement the ValidationEngine Interface

Create the `SpectralValidationEngine` class based on the [official WSO2 SpectralValidationEngine implementation](https://github.com/wso2/carbon-apimgt/blob/master/components/governance/org.wso2.carbon.apimgt.governance.engine/src/main/java/org/wso2/carbon/apimgt/governance/engine/SpectralValidationEngine.java).

```java
package org.wso2.carbon.apimgt.governance.engine;

import org.osgi.service.component.annotations.Component;
import org.wso2.carbon.apimgt.governance.api.ValidationEngine;
import org.wso2.carbon.apimgt.governance.api.error.APIMGovernanceException;
import org.wso2.carbon.apimgt.governance.api.model.Rule;
import org.wso2.carbon.apimgt.governance.api.model.RuleViolation;
import org.wso2.carbon.apimgt.governance.api.model.Ruleset;

import java.util.List;

@Component(
        name = "org.wso2.carbon.apimgt.governance.engine.SpectralValidationEngine",
        immediate = true,
        service = ValidationEngine.class
)
public class SpectralValidationEngine implements ValidationEngine {

    @Override
    public void validateRulesetContent(Ruleset ruleset) throws APIMGovernanceException {
        // Validate the ruleset definition logic
    }

    @Override
    public List<Rule> extractRulesFromRuleset(Ruleset ruleset) throws APIMGovernanceException {
        // Extract and return the individual rules
        return null;
    }

    @Override
    public List<RuleViolation> validate(String target, Ruleset ruleset) throws APIMGovernanceException {
        // Apply validation logic and return rule violations
        return null;
    }
}
```

### Define the Maven Configuration (pom.xml)

Configure the project's `pom.xml`:

```xml
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <groupId>org.wso2.carbon.apimgt</groupId>
    <artifactId>validation-engine-example</artifactId>
    <version>1.0.0-SNAPSHOT</version>
    <packaging>bundle</packaging>

    <dependencies>
        <dependency>
            <groupId>org.wso2.carbon.apimgt.governance</groupId>
            <artifactId>governance-api</artifactId>
            <version>1.0.0</version>
        </dependency>
        <dependency>
            <groupId>org.osgi</groupId>
            <artifactId>org.osgi.service.component.annotations</artifactId>
            <version>1.4.0</version>
            <scope>provided</scope>
        </dependency>
    </dependencies>

    <build>
        <plugins>
            <plugin>
                <groupId>org.apache.felix</groupId>
                <artifactId>maven-bundle-plugin</artifactId>
                <version>5.1.4</version>
                <extensions>true</extensions>
                <configuration>
                    <instructions>
                        <Bundle-SymbolicName>${project.artifactId}</Bundle-SymbolicName>
                        <Export-Package>
                            org.wso2.carbon.apimgt.governance.engine.*
                        </Export-Package>
                    </instructions>
                </configuration>
            </plugin>
        </plugins>
    </build>
</project>
```

### Build the Project

Execute the following command in the project directory:

```bash
mvn clean install
```

## Step 2 - Deploy the Validation Engine Bundle

1. Stop the WSO2 API Manager server if it's running.
2. Copy the generated JAR file from the `target` directory to:

```
<API-M_HOME>/repository/components/dropins/
```

3. Restart the WSO2 API Manager server to load the new bundle.

## Step 3 - Configure the Validation Engine

Configure your custom Validation Engine in WSO2 API Manager according to your specific governance and validation requirements through the relevant configuration files or admin interfaces.

## Use Cases
- Validating OpenAPI specifications against company standards
- Ensuring APIs adhere to security and governance guidelines
- Automating compliance checks in API CI/CD pipelines

## Exception Handling
Ensure to handle `APIMGovernanceException` appropriately within your implementation.

## Dependencies
- `org.wso2.carbon.apimgt.governance.api.error.APIMGovernanceException`
- `org.wso2.carbon.apimgt.governance.api.model.Rule`
- `org.wso2.carbon.apimgt.governance.api.model.RuleViolation`
- `org.wso2.carbon.apimgt.governance.api.model.Ruleset`