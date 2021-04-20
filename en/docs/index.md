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
        <div class="rightImage">
            <iframe width="560" height="315" src="https://www.youtube-nocookie.com/embed/JejVjoaAc38?controls=0" 
            frameborder="0" allow="accelerometer; clipboard-write; encrypted-media; gyroscope" allowfullscreen></iframe>
        </div>
    </div>
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
        <div class="linkSet2" onclick="location.href='{{base_path}}/get-started/key-concepts';">
            <h3>Overview</h3>
            <p>
                Introduces WSO2 API Manager and quickly describes what it can do.
            </p>
            <a href='{{base_path}}/get-started/overview'><h4>Read a Short Overview</h4></a>
        </div>
        <div class="linkSet2 middle" onclick="location.href='{{base_path}}/tutorials/tutorials-overview';">
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
            <div class="linkSet2" onclick="location.href='{{base_path}}/tutorials/user-scenario';">
                ![]({{base_path}}/assets/img/home/intigration.svg)
                <h4>Easily and securely expose APIs to internal and external consumers</h4>
                <p>
                    Centrally control access and traffic flows to your APIs, ensuring only the right people get the right information at the right time. 
                </p>
            </div>
            <div class="linkSet2 middle" onclick="location.href='{{base_path}}/tutorials/user-scenario';">
                ![]({{base_path}}/assets/img/home/proxies.svg)
                <h4>Enable design and runtime governance for the entire API lifecycle</h4>
                <p>
                    Build APIs from existing services, manage APIs from internally built applications and from third-party providers, and monitor their usage and performance from inception to retirement.
                </p>
            </div>
            <div class="linkSet2 last" onclick="location.href='{{base_path}}/tutorials/user-scenario';">
                ![]({{base_path}}/assets/img/home/streaming.svg)
                <h4>Provide enhanced API security and policy enforcement</h4>
                <p>
                    Implement industry-standard authorization flows such as OAuth, OpenID Connect, and JWTs out of the box, and integrate with your existing identity access or key management tools.
                </p>
            </div>
        </div>
        <div class="linkWrapper">
            <div class="linkSet2" onclick="location.href='{{base_path}}/tutorials/user-scenario';">
                ![]({{base_path}}/assets/img/home/intigration.svg)
                <h4>Get business insights and intelligence through APIs</h4>
                <p>
                    Provide real-time access to API usage and performance statistics to decision-makers to optimize your developer support, continuously improve your services, and drive further adoption to reach your business goals. 
                </p>
            </div>
            <div class="linkSet2 middle" onclick="location.href='{{base_path}}/tutorials/user-scenario';">
                ![]({{base_path}}/assets/img/home/proxies.svg)
                <h4>Flexible deployment models and seamless service discovery</h4>
                <p>
                    Deploy in the cloud, in your private data centers, or anywhere in between, while cataloging your services in a single location to make it easy for your developers to find what they need to efficiently build their applications.
                </p>
            </div>
            <div class="linkSet2 last" onclick="location.href='{{base_path}}/tutorials/user-scenario';">
                ![]({{base_path}}/assets/img/home/streaming.svg)
                <h4>Support modern services and integrate API workflows with your CI/CD pipeline</h4>
                <p>
                    Strategically adopt modern service delivery and development paradigms including REST, GraphQL, and Async API, without leaving behind the legacy systems that made you successful in the first place.
                </p>
            </div>
        </div>
    </div>
    <div class="section05">
        <h3>Deployment</h3>
        <p>
            WSO2 API Manager includes multiple components. This allows you set up the API Manager following a range of deployment patterns. This section describes all the possible deployment patterns and guides you how to select the most appropriate pattern based on your requirement.
        </p>
        <div class="DeploymentWrapper">
            <div class="Deploymentlinks">
                <ul>
                    <li><a href='{{base_path}}/install-and-setup/install-and-setup-overview/#deploying'>Deploy API Manager Runtime</a></li>
                </ul>
            </div>
            <div class="Deploymentlinks middle">
                <ul>
                    <li><a href='{{base_path}}/install-and-setup/install-and-setup-overview/#deploying_1'>Deploy the Micro Integrator</a></li>
                </ul>
            </div>
            <div class="Deploymentlinks last">
                <ul>
                    <li><a href='{{base_path}}/install-and-setup/install-and-setup-overview/#deploying_2'>Deploy the Streaming Integrator</a></li>
                </ul>
            </div>
        </div>
    </div>
