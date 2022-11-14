# About this Release

WSO2 API Manager is a complete platform for building, integrating, and exposing your digital services as managed APIs in the cloud, on-premise, and hybrid architectures to drive your digital transformation strategy. It comes with a cloud-native, standards-based messaging engine, and an integration framework for integrating APIs, services, data, SaaS, proprietary, and legacy systems and it can also serve streaming-based integrations. The product comes with command-line and developer tools that enable easy design, development, and testing.

**WSO2 API Manager 4.2.0 M1** is the latest **WSO2 API Manager release** and is the successor of **WSO2 API Manager 4.1.0**.

For more information on WSO2 API Manager, see the [overview]({{base_path}}/getting-started/overview/).

## Downloads

<a href="https://wso2.com/api-manager/#"><img src="{{base_path}}/assets/img/get_started/download-apim.png" title="Download WSO2 API Manager" width="25%" alt="Download WSO2 API Manager"/></a>

## New features

??? note "JDK 17 support"
    You can now run our products with JDK 17.

??? note "OpenTelemetry Support"
    OpenTelemetry combines OpenTracing and OpenCencus, which is a single set of APIs and libraries that standardize how telemetry data such as traces, metrics, and logs are collected, transmitted, and managed. It offers a safe, vendor-neutral specification for instrumentation so that information about the selection can be communicated to various backends.

??? note "ELK Support for MI"
    From WSO2 API Manager 4.2.0 onwards, Micro Integrator now enables publishing operational analytics for Elastic Stack as a replacement for WSO2 EI Analytics.

??? note "Configuring Self Sign up through Admin Portal"
    WSO2 API Manager now offers you the ability to self-signup into the Developer Portal as well as the option to disable self-signup. You can also migrate the self-signup configurations from the registry through the **Advance Configuration** option or through editing the `tenant-conf.json` file.

??? note "Configuring API Lifecycle through Admin Portal"
    APIs created in WSO2 API Manager have their own life cycle consisting of the following: a set of life cycle states, specific actions for each state transition, and a checklist of items before a state transition occurs. An API has a predefined life cycle consisting of six states by default. This feature allows you to customize and/or add new states, migrate API Lifecycle through the **Advance Configuration** option or through editing the `tenant-conf.json` file.

??? note "Enable logs without server restart"
    In this new version of WSO2 API Manager, you can enable or disable correlation logs as needed for troubleshooting at runtime, as a server restart is not required.

??? note "Removal of Jaggery Apps from Portals"
    Jaggery is not currently in an active stage of development or upkeep. Therefore, it is essential to switch to a different language which is closer to server-side while still using the react component as the client-side handler.

??? note "Registry artifact view support for MI Management API/Dashboard"
    A new page has been added to the Micro Integrator dashboard to view the `<MI-HOME>/registry` directory and registry metadata, properties, and content.

    REST API resources have been added to the Micro Integrator as a **management API** to facilitate the functionalities of fetching existing registry data, adding new registry artifacts, modifying and deleting existing registries.

??? note "Gateway Support for Single Usage Token"
    The JWT access tokens supplied by the gateway can be used to access the dedicated API resource as many times as the user requires. However, if the application developer wishes to limit this functionality by allowing just one chance to access the resource, One Time Token can be utilized. A One Time Token (JWT) is a JWT that will be revoked after a single use. This functionality is only accessible for JWT access tokens.

??? note "Support for managing Common API Policies with APICTL"
    As an upgrade from the current version of APICTL (4.1.0), a command to export the shared operation policies in particular has been added.

??? note "Handling accidental deletions of shared backend certificates"
    Backend certificates are currently shared amongst APIs based on the endpoint. As a result, another person who creates an API with the same endpoint can view and remove a certificate that does not belong to the user. This new functionality is designed to limit the ability to delete backend certificates.

??? note "API Linters for validating the API Specifications"
    This feature integrates an API Linter with the support of custom rules.

??? note "Generate API Documentation Automatically from OAS"
    This feature generates API Documentation automatically using the API’s Open API Specification.

??? note "Support for managing Rate Limiting Policies with APICTL"
    This new capability allows you to import and export rate limiting policies between environments. Rate limiting policies are imported to the target environment in a separate stage before importing either the API or the App. After importing rate limiting policies to the target environment, you may import the API/Application without encountering any rate limiting policy support problems.

??? note "Introducing MI control plane, Search and Pagination"
    This feature introduces a new Micro Integrator Control plane and Implement Pagination and Search Functionality.


## Compatible WSO2 product versions

- WSO2 API Manager 4.2.0 is compatible with WSO2 Identity Server 6.0.0.
- WSO2 API Manager 4.2.0 is compatible with Choreo Connect {{choreo_connect.version}}.

## Fixed issues

- [API Manager](https://github.com/wso2/product-apim/issues?q=is%3Aissue+is%3Aclosed+closed%3A2021-10-30..2022-03-05+)
- [Micro Integrator](https://github.com/wso2/micro-integrator/issues?q=is%3Aissue+is%3Aclosed+closed%3A2021-05-01..2022-03-05+label%3A4.1.0+)
- [Streaming Integrator](https://github.com/wso2/streaming-integrator/issues?q=is%3Aissue+is%3Aclosed+label%3A4.1.0+)
- [API Controller](https://github.com/wso2/product-apim-tooling/milestone/17?closed=1)
- [Integration Studio](https://github.com/wso2/integration-studio/milestone/14?closed=1)
- [Micro Integrator Dashboard](https://github.com/wso2/product-mi-tooling/milestone/1?closed=1)
- [Streaming Integrator Tooling](https://github.com/wso2/streaming-integrator/milestone/17?closed=1)
- [Choreo Connect](https://github.com/wso2/product-microgateway/issues?q=is%3Aissue+is%3Aclosed+closed%3A2022-01-01..2022-04-04+)

## Known issues

- [API Manager](https://github.com/wso2/product-apim/issues?q=is%3Aopen+is%3Aissue+label%3A4.x.x)
- [Micro Integrator](https://github.com/wso2/micro-integrator/issues)
- [Streaming Integrator](https://github.com/wso2/streaming-integrator/issues?q=is%3Aissue+is%3Aopen+label%3A4.1.0)
- [API Controller](https://github.com/wso2/product-apim-tooling/issues?q=is%3Aopen+is%3Aissue)
- [Integration Studio](https://github.com/wso2/integration-studio/issues)
- [Micro Integrator Dashboard](https://github.com/wso2/product-mi-tooling/issues?q=is%3Aopen+is%3Aissue)
- [Streaming Integrator Tooling](https://github.com/wso2/streaming-integrator-tooling/issues?q=is%3Aopen+is%3Aissue)
- [Choreo Connect](https://github.com/wso2/product-microgateway/issues)
