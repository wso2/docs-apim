# CI/CD for Integrations - Overview

Continuous integration(CI) and continuous deployment(CD) for Integration is a must for delivering changes more frequently and reliably. 
Different organizations have different ways of addressing the problem. 
This is a guide of a reference implementation that involves a minimum number of parties in an organization for Integration automation.
This guide contains two parts.

1. [VM based CI/CD]({{base_path}}/install-and-setup/setup/mi-setup/deployment/mi-cicd-vm).

2. [Kubernetes based CI/CD]({{base_path}}/install-and-setup/setup/mi-setup/deployment/mi-cicd-k8s).

## Phases of SDLC

Let's consider a deployment that has three typical environments as follows:

*   Developers use the Dev environment to develop their code and execute developer testing.
*   Staging (Quality Assurance) uses the Test environment for functional testing.
*   Actual consumers use the production environment

## Project structure

Main project should be an Integration project. Integration project can contain the multiple sub modules as follows. 

*   ESB Configs module
*   Data Source Configs module
*   Data Service Configs module
*   Registry Resource module
*   Mediator module
*   Composite Exporter module
*   Connector Exporter module
*   Docker Exporter module
*   Kubernetes Exporter module

Please note that you are not allowed to create Nested Integration projects. Also, for CI/CD, it is recommended to maintain one GitHub repository per Integration project.
