---
template: templates/single-column.html
---

<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<div class="homePage">
    <div class="section01">
        <div class="leftContent">
            <h2>Learn to build and manage your APIs with ease  </h2>
            <p>
                WSO2 API Manager is a complete platform for building, integrating, and exposing your digital services as managed APIs in the cloud, on-premise, and hybrid architectures to drive your digital transformation strategy. 
            </p>
            <p>
                It allows API developers to design, publish, and manage the lifecycle of APIs and API product 
                managers to create API products from one or more APIs.
            </p>
        </div>
    </div></br></br>
    <div class="section02">
        <h3>Quick Start Guide</h3>
        <div class="linkWrapper">
            <div class="linkSet2" onclick="location.href='{{base_path}}/get-started/quick-start-guide/quick-start-guide';">
                <img src="{{base_path}}/assets/img/home/landing-page/design-and-implement-apis.svg" title="Design and Implement APIs" width="75" alt="Design and Implement APIs"/>
                <h4>Design and implement APIs</h4>
                <p>
                    Create, publish, and consume an API in 5 minutes. Let's get started by running a simple use case.
                </p>
            </div>
            <div class="linkSet2 middle" onclick="location.href='{{base_path}}/get-started/quick-start-guide/integration-qsg';">
                <img src="{{base_path}}/assets/img/home/landing-page/write-your-first-integration-service.svg" title="Integration Service" width="75" alt="Integration Service"/>
                <h4>Write your first Integration Service</h4>
                <p>
                    Create an integration service and expose it as a managed API. Let's get started by running a simple use case. 
                </p>
            </div>
            <div class="linkSet2 last" onclick="location.href='{{base_path}}/get-started/quick-start-guide/streaming-qsg';">
                <img src="{{base_path}}/assets/img/home/landing-page/write-a-streaming-integration.svg" title="Streaming Integration" width="75" alt="Streaming Integration"/>
                <h4>Write a Streaming Integration</h4>
                <p>
                    Create and deploy a Siddhi application in 5 minutes and expose it as a Streaming API. Let's get started by running a simple use case.
                </p>
            </div>
        </div>
    </div>
    <div class="section03">
        <div class="linkSet2" onclick="location.href='{{base_path}}/get-started/overview';">
            <h3>Overview</h3>
            <p>
                Introduces WSO2 API Manager and quickly describes what it can do.
            </p>
            <a href='{{base_path}}/get-started/overview'><h4>Read a Short Overview</h4></a>
        </div>
        <div class="linkSet2 middle" onclick="location.href='{{base_path}}/get-started/key-concepts';">
            <h3>Concepts</h3>
            <p>
                The key concepts of WSO2 API Manager give you a brief introduction to the terminology and make it easy for you to understand the API management domain.
            </p>
            <a href='{{base_path}}/get-started/key-concepts'><h4>Understand the Concepts</h4></a>
        </div>
        <div class="linkSet2 last" onclick="location.href='{{base_path}}/get-started/architecture';">
            <h3>Architecture</h3>
            <p>
                The WSO2 API Manager consists of a management plane, a data plane, and a control plane, along with multiple developer-friendly tools to help you work with the various components.
            </p>
            <a href='{{base_path}}/get-started/architecture'><h4>View Architecture</h4></a>
        </div>
    </div>
    <div class="section04">
        <h3>APIM Scenarios</h3>
        <div class="linkWrapper">
            <div class="linkSet2" onclick="location.href='{{base_path}}/tutorials/scenarios/scenario1-create-rest-api';">
                ![]({{base_path}}/assets/img/home/intigration.svg)
                <h4>Create REST API from an OpenAPI Definition</h4>
                <p>
                    Create an API in WSO2 API Manager that maps to an OpenAPI definition. 
                </p>
            </div>
            <div class="linkSet2 middle" onclick="location.href='{{base_path}}/tutorials/scenarios/scenario2-access-control';">
                ![]({{base_path}}/assets/img/home/proxies.svg)
                <h4>Engage Access Control to the API</h4>
                <p>
                    Configure your API so that it is visible only to selected users.
                </p>
            </div>
            <div class="linkSet2 last" onclick="location.href='{{base_path}}/tutorials/scenarios/scenario3-implementing-an-api';">
                ![]({{base_path}}/assets/img/home/streaming.svg)
                <h4>Implementing an API</h4>
                <p>
                    You can implement the business logic to call three backends that provide metrics, aggregate the response, and present it to the client as one response.
                </p>
            </div>
        </div>
        <div class="linkWrapper">
            <div class="linkSet2" onclick="location.href='{{base_path}}/tutorials/scenarios/scenario4-user-signup-approval-flow';">
                ![]({{base_path}}/assets/img/home/intigration.svg)
                <h4>Signing up a New User</h4>
                <p>
                    WSO2 API Manager provides extension points to trigger workflow tasks for many operations such as Application creation, subscription creation, user signup, etc. 
                </p>
            </div>
            <div class="linkSet2 middle" onclick="location.href='{{base_path}}/tutorials/scenarios/scenario5-developer-community-feature';">
                ![]({{base_path}}/assets/img/home/proxies.svg)
                <h4>Getting the Developer Community Involved</h4>
                <p>
                    WSO2 API Manager Developer Portal provides many features to assist developers to use the APIs published.
                </p>
            </div>
            <div class="linkSet2 last" onclick="location.href='{{base_path}}/tutorials/scenarios/scenario6-integrating-with-data-sources';">
                ![]({{base_path}}/assets/img/home/streaming.svg)
                <h4>Integrating with Data Sources</h4>
                <p>
                    When you create a data service in WSO2 Micro Integrator, the data that is stored in a storage system (such as the RDBMS) can be exposed in the form of a service.
                </p>
            </div>
        </div>
        <div class="linkWrapper">
            <div class="linkSet2" onclick="location.href='{{base_path}}/tutorials/scenarios/scenario7-analytics';">
                ![]({{base_path}}/assets/img/home/intigration.svg)
                <h4>Analytics</h4>
                <p>
                    Choreo API Manager Analytics can be used to fulfil the stats and analytics needs of the API Manager. 
                </p>
            </div>
            <div class="linkSet2 middle" onclick="location.href='{{base_path}}/tutorials/scenarios/scenario8-rate-limiting';">
                ![]({{base_path}}/assets/img/home/proxies.svg)
                <h4>Rate limiting</h4>
                <p>
                    WSO2 API Manager provides various levels of rate limiting to control the number of transactions at any given time.
                </p>
            </div>
            <div class="linkSet2 last" onclick="location.href='{{base_path}}/tutorials/scenarios/scenario9-realtime-data';">
                ![]({{base_path}}/assets/img/home/streaming.svg)
                <h4>Realtime Data with WebSocket API</h4>
                <p>
                    WSO2 Streaming Integrator(SI) is a streaming data processing server that integrates realtime streaming data and takes action based on the streaming data.
                </p>
            </div>
        </div>
        <div class="linkWrapper">
            <div class="linkSet2" onclick="location.href='{{base_path}}/tutorials/scenarios/scenario10-notifications-webhooks';">
                ![]({{base_path}}/assets/img/home/intigration.svg)
                <h4>Notifications Using Webhooks</h4>
                <p>
                    The API Manager enables you to provide information as webhooks so that companies can subscribe to these notifications without continuously polling. 
                </p>
            </div>
            <div class="linkSet2 middle" onclick="location.href='{{base_path}}/tutorials/scenarios/scenario11-graphql';">
                ![]({{base_path}}/assets/img/home/proxies.svg)
                <h4>GraphQL Support</h4>
                <p>
                    WSO2 API Manager supports creating GraphQL APIs using the GraphQL schema.
                </p>
            </div>
            <div class="linkSet2 last" onclick="location.href='{{base_path}}/tutorials/scenarios/scenario12-message-delivery';">
                ![]({{base_path}}/assets/img/home/streaming.svg)
                <h4>Guaranteed Message Delivery</h4>
                <p>
                    Store and forward messaging pattern is used to ensure guaranteed delivery of messages. Messages never get lost since they are stored in the message store.
                </p>
            </div>
        </div>
        <div class="linkWrapper">
            <div class="linkSet2" onclick="location.href='{{base_path}}/tutorials/scenarios/scenario13-integrate-with-connectors';">
                ![]({{base_path}}/assets/img/home/intigration.svg)
                <h4>Integrate with Services via Connectors</h4>
                <p>
                    When you integrate systems in your organization, it is also necessary to integrate with third-party systems to enhance your services. This is possible via Connectors. 
                </p>
            </div>
            <div class="linkSet2 middle" onclick="location.href='{{base_path}}/tutorials/scenarios/scenario14-external-key-manager';">
                ![]({{base_path}}/assets/img/home/proxies.svg)
                <h4>External Key Manager Support</h4>
                <p>
                    WSO2 API Manager comes with external key manager connectors to various identity providers such as Okta, Auth0, Keycloak, etc. Additionally, you can write a custom Key Manager implementation.
                </p>
            </div>
            <div class="linkSet2 last" onclick="location.href='{{base_path}}/tutorials/tutorials-overview';">
                ![]({{base_path}}/assets/img/home/streaming.svg)
                <h4>Other</h4>
                <p>
                    Look through the available tutorials for more product capabilities.
                </p>
            </div>
        </div>
    </div>
    <div class="section05">
        <h3>Deployment</h3>
        <div class="linkWrapper">
            <div class="linkSet2" onclick="location.href='{{base_path}}/install-and-setup/install-and-setup-overview/#deploying';">
                ![]({{base_path}}/assets/img/home/intigration.svg)
                <p>
                    See the instructions on setting up the API-M runtime for your selected deployment pattern. 
                </p>
                <a href='{{base_path}}/install-and-setup/install-and-setup-overview/#deploying'><h4>Deploy the API-M Runtime</h4></a>
            </div>
            <div class="linkSet2 middle" onclick="location.href='{{base_path}}/install-and-setup/install-and-setup-overview/#deploying_1';">
                ![]({{base_path}}/assets/img/home/proxies.svg)
                <p>
                    See the instructions on setting up the Micro Integrator runtime for your selected deployment pattern.
                </p>
                <a href='{{base_path}}/install-and-setup/install-and-setup-overview/#deploying_1'><h4>Deploy the API-M Runtime</h4></a>
            </div>
            <div class="linkSet2 last" onclick="location.href='{{base_path}}/install-and-setup/install-and-setup-overview/#deploying_2';">
                ![]({{base_path}}/assets/img/home/streaming.svg)
                <p>
                    See the instructions on setting up the Streaming Integrator runtime for your selected deployment pattern.
                </p>
                <a href='{{base_path}}/install-and-setup/install-and-setup-overview/#deploying_2'><h4>Deploy the Streaming Integrator Runtime</h4></a>
            </div>
        </div>
    </div>
</div>