# Building a Jenkins CI/CD Pipeline for Micro Integrator

## Overview

This is a guide of a reference implementation on setting up a CI/CD process for Micro Integrator. This guide contains two parts.
1. VM based CI/CD
2. Kubernetes based CI/CD 

## Phases of SDLC

Considering a deployment with having three typical environments as follows:

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

Please note that you are not allowed to create Nested Integration projects. Also for CI/CD, it is recommended to maintain one git repo per Integration project.