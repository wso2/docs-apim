# Kubernetes Gateway integration with API Manager

## Overview

The Control Plane serves as the central intelligence hub for WSO2 Kubernetes Gateway, orchestrating the entirety of the API ecosystem. It encompasses critical functionalities such as API management, administrative operations, and the API marketplace. Structurally, it comprises four principal components: the Back Office, Dev Portal, Admin Portal, and APIM-APK Agent. These components cater to diverse user roles, ranging from API product managers to consumers and administrative personnel. Within the Control Plane, users configure, oversee, and track the performance of APIs, ensuring seamless management and optimization of the API landscape.

For the Kubernetes Gateway Control Plane, we are going to use same WSO2 API Control Plane. The WSO2 API control plane is a set of components that are responsible for managing and monitoring APIs.
Kubernetes Gateway only supports REST API and GraphQL API creation for now.

## Architecture

Following diagram depicts the architecture of how the WSO2 API Control Plane connects with WSO2 Kubernetes Gateway using APIM-APK Agent.

<a href="{{base_path}}/assets/img/setup-and-install/apk-overview.png" ><img src="{{base_path}}/assets/img/setup-and-install/apk-overview.png" alt="Architecture" title="Architecture" width="100%" /></a>

## APIM APK Agent

The APIM APK Agent is a component that connects the WSO2 API Control Plane with the WSO2 Kubernetes Gateway. The APIM APK Agent is responsible for the following tasks:

- Receive JMS Events which relates to API,Application,Subscription management from the APIM Control Plane.
- Convert the data which is received from the APIM Control Plane to the Kubernetes Gateway understandable format which are K8s Custom Resources.
- Apply the generated Custom Resources to the K8s cluster to deploy API to Kubernetes Gateway.

## Supported Features

- API Management: Manage APIs, including creating, publishing, and retiring APIs.
- Application Management: Manage applications that consume APIs, including subscription management.
- Subscription Management: Manage subscriptions to APIs by applications.
- API Analytics: Gather and analyze data on API usage and performance.
- API Marketplace: Provide a marketplace for discovering and consuming APIs.
- Integration with WSO2 Kubernetes Gateway: Integrate with the Kubernetes Gateway for deploying APIs and managing traffic.

## Next Steps

You can refer the [Quick Start Guide](https://apk.docs.wso2.com/en/latest/get-started/quick-start-guide-with-cp/) with regards to trying out API Control Plane with Kubernetes Gateway using APIM-APK Agent.
