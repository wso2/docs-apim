# About this Release

WSO2 API Manager is a complete platform for building, integrating, and exposing your digital services as managed APIs in the cloud, on-premise, and hybrid architectures to drive your digital transformation strategy. It comes with a cloud-native, standards-based messaging engine, and an integration framework for integrating APIs, services, data, SaaS, proprietary, and legacy systems and it can also serve streaming-based integrations. The product comes with command-line and developer tools that enable easy design, development, and testing.

**WSO2 API Manager 4.2.0** is the latest **WSO2 API Manager release** and is the successor of **WSO2 API Manager 4.1.0**.

For more information on WSO2 API Manager, see the [overview]({{base_path}}/getting-started/overview/).

## Downloads

<a href="https://wso2.com/api-manager/#"><img src="{{base_path}}/assets/img/get_started/download-apim.png" title="Download WSO2 API Manager" width="25%" alt="Download WSO2 API Manager"/></a>

## New features

??? note "JDK 17 support"
    You can now run our products with JDK 17.

??? note "OpenTelemetry Support"
    OpenTelemetry combines OpenTracing and OpenCencus, which is a single set of APIs and libraries that standardize how telemetry data such as traces, metrics, and logs are collected, transmitted, and managed. It offers a safe, vendor-neutral specification for instrumentation so that information about the selection can be communicated to various backends.

??? note "Datadog integration with WSO2 API Manager"
    DataDog is a widely-used SaaS-based data analytics platform, and this new feature allows users to benefit from its advanced analytics capabilities. With this support for DataDog, users of the API Manager can now choose the analytics provider that best suits their needs, making it easier to manage and monitor APIs. Currently, API Manager supports Choreo analytics and ELK analytics for data analysis. With this integration, you can now use DataDog as an analytics provider for the API Manager.

??? note "ELK Support for MI"
    From WSO2 API Manager 4.2.0 onwards, Micro Integrator now enables publishing operational analytics for Elastic Stack as a replacement for WSO2 EI Analytics.

??? note "Configuring Self Sign up through Admin Portal"
    WSO2 API Manager offers you the ability to self-signup into the Developer Portal. In this new release, the capability to disable self-signup is also added. You can also migrate the self-signup configurations from the registry via the **Advance Configuration** option or by editing the `tenant-conf.json` file.

??? note "Configuring API Lifecycle through Admin Portal"
    APIs created in WSO2 API Manager have their own life cycle consisting of the following: a set of life cycle states, specific actions for each state transition, and a checklist of items before a state transition occurs. An API has a predefined life cycle consisting of six states by default. This feature allows you to customize and/or add new states, configure the API Lifecycle via the **Advance Configuration** option or by editing the `tenant-conf.json` file.

??? note "Enable logs without server restart"
    You can now enable or disable correlation logs as needed for troubleshooting at runtime, as a server restart is not required with the Micro Integrator.

??? note "Removal of Jaggery Apps from Portals"
    Jaggery is not currently in an active stage of development or upkeep. Therefore, it is essential to switch to a different language which is closer to server-side while still using the react component as the client-side handler. WSO2 API Manager now uses `JSP` as the server-side language in all its portals.

??? note "Registry artifact view support for MI Management API/Dashboard"
    A new page has been added to the Micro Integrator dashboard to view the `<MI-HOME>/registry` directory and registry metadata, properties, and content.

    REST API resources have been added to the Micro Integrator as a **management API** to facilitate the functionalities of fetching existing registry data, adding new registry artifacts, modifying and deleting existing registries.

??? note "Gateway Support for Single Usage Token"
    The JWT access tokens supplied by the Gateway can be used to access the dedicated API resource as many times as the user requires. However, if the application developer wishes to limit this functionality by allowing just one chance to access the resource, One Time Token can be utilized. A One Time Token (JWT) is a JWT that will be revoked after a single use. This functionality is only accessible for JWT access tokens.

??? note "Support for managing Common API Policies with APICTL"
    As an upgrade from the current version of APICTL (4.2.0), a command to export the shared operation policies in particular has been added.

??? note "Handling accidental deletions of shared backend certificates"
    Backend certificates are currently shared amongst APIs based on the endpoint. As a result, another person who creates an API with the same endpoint can view and remove a certificate that does not belong to the user. This new functionality is designed to limit the ability to delete backend certificates.

??? note "API Linters for validating the API Specifications"
    This feature integrates an API Linter with the support of custom rules.

??? note "Generate API Documentation Automatically from OAS"
    This feature generates API Documentation automatically using the API’s Open API Specification.

??? note "Support for managing Rate Limiting Policies with APICTL"
    This new capability allows you to import and export rate limiting policies between environments. Rate limiting policies are imported to the target environment in a separate stage before importing either the API or the App. After importing rate limiting policies to the target environment, you may import the API/Application without encountering any rate limiting policy support problems.

??? note "MI Dashboard Improvement and Search capability for MI Management API"
    This feature improves the MI Dashboard and Implements Search Functionality for MI Management API.

## Deprecated features and functionalities

These features are deprecated and will be removed from subsequent versions of WSO2 API Manager.

- **Synchronous Data Retrieval Mode in Gateway Runtime Artifact Synchronization**

     Synchronous Data Retrieval Mode in Gateway Runtime Artifact Synchronization was configurable by setting the value of `data_retrieval_mode` to `sync` (`data_retrieval_mode = "sync"`). 
     
     ```
     [apim.sync_runtime_artifacts.gateway]
     data_retrieval_mode = "sync"
     ```
     The support for this mode is now deprecated from WSO2 API Manager 4.2.0 onwards. Therefore, it is recommended to use the `async` mode only.

## Removed features and functionalities

These features are unsupported and removed from WSO2 API Manager 4.2.0 onwards.

- **Support for Jaggery apps from API Manager**

     In previous releases, webapps of API-Manager were dependant on the deprecated [Jaggery.js](https://github.com/wso2/jaggery) Javascript framework. From this version onwards all the webapps will be using JSP as the server-side language. Therefore, the capability to deploy Jaggery apps in WSO2 API Manager is removed from this release onwards.
     
- **JDK 8 support**

     JDK 8 support is removed from  WSO2 API Manager 4.2.0 onwards. 

- **Publisher and Devportal profiles**

    The `api-publisher` and `api-devportal` profiles, which were deprecated in previous releases, are no longer supported in API Manager 4.2.0 and beyond. To perform tasks previously handled by these profiles, use the `control-pane` profile instead.

## Compatible WSO2 product versions

- WSO2 API Manager 4.2.0 is compatible with WSO2 Identity Server 6.0.0 and 6.1.0.
- WSO2 API Manager 4.2.0 is compatible with Choreo Connect {{choreo_connect.version}}.

## Fixed issues

- [API Manager](https://github.com/wso2/api-manager/issues?q=is%3Aissue+is%3Aclosed+label%3AComponent%2FAPIM+closed%3A2022-04-05..2023-03-11)
- [Micro Integrator](https://github.com/wso2/api-manager/issues?q=is%3Aissue+is%3Aclosed+label%3AComponent%2FMI+closed%3A2022-04-05..2023-03-03)
- [Streaming Integrator](https://github.com/wso2/api-manager/issues?q=is%3Aissue+is%3Aclosed+label%3AComponent%2FSI+closed%3A2022-04-05..2023-03-03+)
- [API Controller](https://github.com/wso2/api-manager/issues?q=is%3Aissue+is%3Aclosed+label%3AComponent%2FAPICTL+label%3AType%2FBug++closed%3A2022-04-05..2023-03-11)
- [Integration Studio](https://github.com/wso2/api-manager/issues?q=is%3Aissue+is%3Aclosed+label%3AComponent%2FIntegrationStudio+closed%3A2022-04-05..2023-03-03+)
- [Micro Integrator Dashboard](https://github.com/wso2/api-manager/issues?q=is%3Aissue+is%3Aclosed+label%3AComponent%2FMIDashboard+closed%3A2022-04-05..2023-03-03+)
- [Streaming Integrator Tooling](https://github.com/wso2/api-manager/issues?q=is%3Aissue+is%3Aclosed+label%3AComponent%2FSITooling+closed%3A2022-04-05..2023-03-03+)
- [Choreo Connect](https://github.com/wso2/product-microgateway/issues?q=is%3Aissue+is%3Aclosed+project%3Awso2%2Fproduct-microgateway%2F16+)

## Known issues

- [API Manager](https://github.com/wso2/api-manager/issues?q=is%3Aissue+label%3AComponent%2FAPIM+is%3Aopen)
- [Micro Integrator](https://github.com/wso2/api-manager/issues?q=is%3Aissue+label%3AComponent%2FMI+is%3Aopen)
- [Streaming Integrator](https://github.com/wso2/api-manager/issues?q=is%3Aissue+label%3AComponent%2FSI+is%3Aopen)
- [API Controller](https://github.com/wso2/api-manager/issues?q=is%3Aissue+label%3AComponent%2FAPICTL+is%3Aopen)
- [Integration Studio](https://github.com/wso2/api-manager/issues?q=is%3Aissue+label%3AComponent%2FIntegrationStudio+is%3Aopen)
- [Micro Integrator Dashboard](https://github.com/wso2/api-manager/issues?q=is%3Aissue+label%3AComponent%2FMIDashboard+is%3Aopen)
- [Streaming Integrator Tooling](https://github.com/wso2/api-manager/issues?q=is%3Aissue+label%3AComponent%2FSITooling+is%3Aopen)
- [Choreo Connect](https://github.com/wso2/product-microgateway/issues?q=is%3Aopen+is%3Aissue)

## What has changed

WSO2 API Manager Server 4.2.0 brings a range of new features and major improvements. The following aspects have changed in 4.2.0 compared to the previous WSO2 API-M versions. This page provides details about those behavioral changes.

### Changes in WSO2 API Manager

#### API Manager 4.2.0

- Prior to WSO2 API Manager 4.2.0, the tenant configurations listed below were persisted only in the registry and only accessible via the Carbon Console. With the 4.2.0 release, these configurations are migrated to the `tenant-conf.json` file, and support is enabled to manage these through the Admin Portal (Advanced Configuration Section).
    - Self Sign Up Config

        Self-signup is enabled out-of-the-box not only for the super tenant but also for the other tenants. Now the 'Internal/subscriber' role is taken from the `Advanced Configurations → DefaultRoles → SubscriberRole` when creating a tenant. In addition, the `sign-up-config.xml` file is removed along with the connection with the registry. For more information, see [Disabling or Enabling Self Signup]({{base_path}}/reference/customize-product/customizations/customizing-the-developer-portal/enabling-or-disabling-self-signup/).

    - Life Cycle Config

        XML configuration is converted to JSON format. Now the life cycle changes can be managed via `Advanced Configurations → LifeCycle` via the Admin Portal. The `APILifeCycle.xml` file is removed along with the connection with the registry. For more information, see [Customize API Life Cycle]({{base_path}}/design/lifecycle-management/customize-api-life-cycle/).

- From WSO2 API Manager 4.2.0 onwards, correlation logs can be enabled without restarting the server. Newly added CorrelationConfigManager will handle the configuration updates from the DevOps API. This configuration information is persisted in the database. For more information, see [Monitoring Correlation Logs]({{base_path}}/observe/api-manager/monitoring-correlation-logs/).
- In the WSO2 API Manager 4.2.0 onwards, the schema name in the challenge string for basic auth will be changed from "Basic Auth" to "Basic" according to IANA standards. For more information, see [HTTP Authentication Scheme Registry](https://www.iana.org/assignments/http-authschemes/http-authschemes.xhtml).
- Prior to API Manager 4.2.0, only a single registry handler property with nested elements can be added. From API Manager 4.2.0 onwards multiple registry handler properties with nested elements can be added. To support that, the approach to configure nested properties is changed in 4.2.0. Therefore, if you are using registry handlers with nested properties, see [API-M Config Catalog - Registry Handler Properties]({{base_path}}/reference/config-catalog/#registry-handler-properties) and change the configuration accordingly.
