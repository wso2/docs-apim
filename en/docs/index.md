---
template: templates/single-column.html
---

<style>
    @font-face {
    font-family: 'Material Icons';
    font-style: normal;
    font-weight: 400;
    src: url(https://wso2.cachefly.net/wso2/sites/all/fonts/docs/flUhRq6tzZclQEJ-Vdg-IuiaDsNcIhQ8tQ.woff2) format('woff2');
    }

    .material-icons {
    font-family: 'Material Icons';
    font-weight: normal;
    font-style: normal;
    font-size: 24px;
    line-height: 1;
    letter-spacing: normal;
    text-transform: none;
    display: inline-block;
    white-space: nowrap;
    word-wrap: normal;
    direction: ltr;
    -webkit-font-feature-settings: 'liga';
    -webkit-font-smoothing: antialiased;
    }

    .content {
        width: 100%;
        margin: 0 auto;
        display: flex;
        justify-content: left;
        align-items: left;
        flex-wrap: wrap;
    }

    .card {
        height: 275px;
        color: #404040;
        background: #f8f8f8;
        padding-left: 1.2rem;
        padding-bottom: 0.7rem;
        -webkit-box-shadow: 0px 5px 4px 0px rgba(105, 113, 120, 0.4);
        -moz-box-shadow: 0px 5px 4px 0px rgba(105, 113, 120, 0.4);
        box-shadow: 0px 5px 4px 0px rgba(105, 113, 120, 0.4);
        border-radius: 10px;
        font-size: 16px;
        transition: all 0.6s ease;
        position: relative;
        justify-content: left;
        align-items: left;
        flex-direction: row;
        transition: all 0.3s ease;
        width: 100%;
    }

    .card-wrapper {
        width: 100%;
        display: flex;
        max-width: 400px;
    }

    .component-wrapper {
        width: 100%;
        display: flex;
        justify-content: space-between;
    }

    .card-content {
        justify-content: left;
        display: flex;
        align-items: left;
        text-align: left;
        flex-direction: column;
    }

    .card .title {
        font-family: Montserrat, sans-serif;
        font-style: normal;
        font-size: 18px;
        margin: 2;
        text-align: left;
        font-weight: 600;
        white-space: nowrap;
        text-transform: none;
        display: flex;
    }

    .card-icon {
        height: 30px;
        max-width: 80px;
        border-radius: 0%;
        display: flex;
        align-items: center;
        color: #ff5003;
        transition: all 0.8s ease;
    }

    .removeTopMargin {
        margin-top: 0;
    }

    .rowAlignment {
        justify-content: space-between;
        display: flex;
        flex-direction: row;
    }

    .rowAlignmentProductNameIcon {
        justify-content: left;
        align-items: left;
        display: flex;
        gap: 10px;
        flex-direction: row;
        margin-bottom: 0;
    }

    .description-section {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 30px;
        margin-left: 100px;
    }

    .component-section {
        display: grid;
        justify-content: space-between;
        flex-direction: row;
        grid-template-columns: 400px 4fr;
        gap: 150px;
    }
    .tiles-container {
        display: flex;
        align-items: start;
        flex-wrap: wrap;
        justify-content: space-between;
    }
    .tile {
        display: inline-block;
        vertical-align: top;
        background-color: rgba(255, 255, 255, 0.03);
        padding: 50px;
        border-radius: 5px;
        box-shadow: 0px 0px 5px rgba(0, 0, 0, 0.2);
        transition: transform 0.2s ease-in-out;
        position: relative;
        display: flex;
        flex-direction: column;
        justify-content: flex-start;
        margin: 0 0 25px 25px;
    }
    .tile:hover {
        transform: scale(1.01);
    }
    .tile-header {
        display: flex;
        justify-content: space-between;
        border-bottom: 1px solid rgb(215, 215, 215);
    }
    .tile h3 {
        font-size: 0.9rem;
        margin-top: 0px;
    }
    .tile-icon {
        margin-left: 30px;
        font-size: 1rem;
    }
    .links-list li {
        list-style-type: none;
    }
    .link {
        display: inline-block;
        margin-left: -30px;
        color: var(--text-color) !important;
        text-decoration: none;
    }
    .link:hover {
        color: rgb(255, 112, 67) !important;
        text-decoration: none;
    }
    .link:before {
        content: '→';
        font-weight: bold;
        margin-right: 5px;
    }
    .button-container {
        text-align: right;
    }
    .view-all-button {
        display: inline-block;
        background-color: none;
        color: var(--text-color) !important;
        text-decoration: none;
        border-radius: 5px;
    }
    .view-all-button:hover {
        color: rgb(255, 112, 67) !important;
    }

    .section05 {
        display: flex;
        justify-content: center;
        margin-top: 50px;
    }

    .leftContent {
        margin-right: 50px;
    }

    @media (max-width: 1386px) {
        .md-main .md-sidebar.md-sidebar--primary {
            width: 0;
        }
    }

    @media (max-width: 1219px) {
        .md-content, .md-nav {
            margin-top: 0;
        }
        .md-container {
            margin-top: 2.4rem;
        }
        .md-main__inner {
            padding-top: 1.5rem;
        }
    }

    /* Mobile responsiveness */
    @media (max-width: 768px) {
        .description-section {
            flex-direction: column;
            margin-left: 0;
            text-align: center;
        }

        .md-main .md-content {
            width: 100%;
            float: none;
            margin-left: 0;
            margin-top: 10px;
        }

        .component-section {
            grid-template-columns: 1fr;
            gap: 20px;
        }

        .tile-header h3 {
            font-size: 1rem;
        }

        .card-wrapper {
            width: 100%;
        }

        .card {
            height: auto;
        }

        .button-container {
            text-align: center;
        }
    }

    @media (max-width: 480px) {
        .card {
            height: auto;
            padding: 15px;
        }

        .description-section {
            margin-left: 0;
            margin-right: 0;
        }

        .view-all-button {
            width: 100%;
            padding: 10px 0;
            text-align: center;
        }
    }
</style>

{% set tiles = [
    [{
        "title": "Get Started",
        "icon": "🚀",
        "links": [
            {"name": "Overview", "url": "get-started/overview/"},
            {"name": "Key Concepts", "url": "get-started/key-concepts/"},
            {"name": "Quick Start Guide", "url": "get-started/api-manager-quick-start-guide/"},
            {"name": "About this Release", "url": "get-started/about-this-release/"}
        ]
    },
    {
        "title": "Deployment Options",
        "icon": "🔗",
        "links": [
            {"name": "Deploy on VM", "url": "install-and-setup/install/installing-the-product/running-the-api-m/"},
            {"name": "Deploy on Kubernetes", "url": "install-and-setup/install/deploying-api-manager-with-kubernetes-resources/"},
            {"name": "SaaS", "url": "https://wso2.com/bijira/docs/"}
        ]
    }],
    [{
        "title": "Setup",
        "icon": "🏗️",
        "links": [
            {"name": "Install", "url": "install-and-setup/install/installing-the-product/installing-api-m-runtime/"},
            {"name": "Deploy", "url": "install-and-setup/setup/deployment-overview/"},
            {"name": "Upgrade WSO2 API Manager", "url": "install-and-setup/upgrading-wso2-api-manager/upgrading-api-manager/"}
        ]
    },
    {
        "title": "Developer Resources",
        "icon": "🔧",
        "links": [
            {"name": "Product Rest APIs", "url": "reference/product-apis/overview/"},
            {"name": "Tooling", "url": "reference/apictl/wso2-api-controller/"},
            {"name": "SDKs", "url": "consume/generating-sdks/generate-sdks-in-dev-portal/"},
            {"name": "Configuration Catalog", "url": "reference/config-catalog/"}
        ]
    }
    ],
    [
    {
        "title": "Guides",
        "icon": "📖",
        "links": [
            {"name": "Designing APIs", "url": "manage-apis/design/design-api-overview/"},
            {"name": "Create an API Product", "url": "manage-apis/design/create-api-product/create-api-product/"},
            {"name": "Authentication", "url": "manage-apis/design/api-security/api-authentication/api-authentication-overview/"},
            {"name": "Authorization", "url": "manage-apis/design/api-security/authorization/api-authorization/"},
            {"name": "Rate Limiting", "url": "manage-apis/design/rate-limiting/introducing-throttling-use-cases/"},
            {"name": "Consuming APIs", "url": "consume/consume-api-overview/"},
            {"name": "Analytics", "url": "monitoring/api-analytics/choreo-analytics/getting-started-guide/"},
            {"name": "CI/CD", "url": "install-and-setup/setup/api-controller/ci-cd-with-wso2-api-management/"}
        ],
        "more_btn": {"name": "View More", "url": "tutorials/tutorials-overview/"}
    },
    {
        "title": "Community and Support",
        "icon": "❓",
        "links": [
            {"name": "GitHub", "url": "https://github.com/wso2/api-manager/issues"},
            {"name": "Discord Channel", "url": "https://discord.com/invite/wso2"},
            {"name": "Enterprise Support", "url": "https://wso2.com/subscription/"}
        ]
    }
    ]
] %}

<div class="homePage">
    <div class="description-section">
        <div class="leftContent">
            </br>
            <p>
                WSO2 API Manager is a complete platform for building, integrating, and exposing your digital services as managed APIs in the cloud, on-premise, and hybrid architectures to drive your digital transformation strategy. 
            </p>
            <p>
                It allows API developers to design, publish, and manage the lifecycle of APIs and API product 
                managers to create API products from one or more APIs.
            </p>
        </div>
        <div class="md-main .md-content " style="float:right; width: 55%; align:right;  flex-shrink: 0;min-width: 30%; max-height: 100%; max-width:40%; margin-left:5px; margin-top:50px; margin-right:90px">
        <iframe width="800" height="250" src="https://www.youtube.com/embed/nr1cFyxVdDw" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
        </div>
    </div>
    <div class="section05">
        <div class="tiles-container">
            {% for column in tiles %}
            <div class="tiles-column">
                {% for tile in column %}
                <div class="tile">
                    <div class="tile-header">
                        <h3>{{ tile.title }}</h3>
                        <span class="tile-icon">{{ tile.icon }}</span>
                    </div>
                    <ul class="links-list">
                        {% for link in tile.links %}
                        <li>
                            {% if tile.title == "Community and Support" or link.name == "SaaS" %}
                                <a href="{{ link.url }}" target="_blank" class="link">{{ link.name }}</a>
                            {% else %}
                                <a href="{{ base_path }}/{{ link.url }}" class="link">{{ link.name }}</a>
                            {% endif %}
                        </li>
                        {% endfor %}
                    </ul>
                    {% if tile.more_btn %}
                    <div class="button-container">
                        <a href="{{base_path}}/{{ tile.more_btn.url }}" class="view-all-button">{{ tile.more_btn.name }}</a>
                    </div>
                    {% endif %}
                </div>
                {% endfor %}
            </div>
            {% endfor %}
        </div>
    </div>
    <div>
        <h3>Components</h3>
        <hr/>
        <p>WSO2 API Manager offers multiple components designed to work together to solve the challenges of diverse infrastructure requirements. A unified control plane supporting multiple gateways provides deployment flexibility, minimizes downtime, and provides scalability and resource optimization by allowing independent component management, flexible deployment packages, and seamless upgrades and maintenance. For more information see <a href="{{base_path}}/get-started/apim-architecture/">Architecture.</a></p>
        </br>
        </br>
        <div class="component-section">
            <div>
                <div>
                    <h4>Control Plane</h4>
                    </br>
                </div>
                <div class="content">
                    <!-- begin card -->
                    <div class="card-wrapper">
                        <div class="card">
                            <div class="card-content">
                                <div class="rowAlignment">
                                    <div class="rowAlignmentProductNameIcon">
                                        <div class="card-icon">
                                            <i class="material-icons md-36">supervisor_account</i>
                                        </div>
                                        <p class="title"><b>WSO2 API Control Plane</b></p>
                                    </div>
                                </div>
                                <hr/>
                                <p class="removeTopMargin">A Unified control plane which centrally manages and governs APIs across multiple Gateways</p>
                                <div>
                                    <ul>
                                        <li><a href="{{base_path}}/get-started/apim-architecture/#api-control-plane">WSO2 API Control Plane Overview</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- end card -->
                </div>
            </div>
            <div>
                <div>
                    <h4>Data Plane</h4>
                    </br>
                </div>
                <div class="content">
                    <!-- begin card -->
                    <div class="card-wrapper">
                        <div class="card">
                            <div class="card-content">
                                <div class="rowAlignment">
                                    <div class="rowAlignmentProductNameIcon">
                                        <div class="card-icon">
                                            <i class="material-icons md-36">public</i>
                                        </div>
                                        <p class="title"><b>WSO2 Universal Gateway</b></p>
                                    </div>
                                </div>
                                <hr/>
                                <p class="removeTopMargin">Secure and proxy API traffic with enterprise-grade features</p>
                                <div>
                                    <ul>
                                        <li><a href="{{base_path}}/get-started/apim-architecture/#universal-gateway">WSO2 Universal Gateway Overview</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- end card -->
                    <!-- begin card -->
                    <div class="card-wrapper">
                        <div class="card">
                            <div class="card-content">
                                <div class="rowAlignment">
                                    <div class="rowAlignmentProductNameIcon">
                                        <div class="card-icon">
                                            <i class="material-icons md-36">cloud</i>
                                        </div>
                                        <p class="title"><b>WSO2 Kubernetes Gateway</b></p>
                                    </div>
                                </div>
                                <hr/>
                                <p class="removeTopMargin">Designed to build, deploy, and manage APIs in a cloud environment</p>
                                <div>
                                    <ul>
                                        <li><a href="{{base_path}}/get-started/apim-architecture/#kubernetes-gateway">WSO2 Kubernetes Gateway Overview</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- end card -->
                    <!-- begin card -->
                    <div class="card-wrapper">
                        <div class="card">
                            <div class="card-content">
                                <div class="rowAlignment">
                                    <div class="rowAlignmentProductNameIcon">
                                        <div class="card-icon">
                                            <i class="material-icons md-36">cloud_circle</i>
                                        </div>
                                        <p class="title"><b>WSO2 Immutable Gateway</b></p>
                                    </div>
                                </div>
                                <hr/>
                                <p class="removeTopMargin">An API Gateway for micro services, which is cloud-native, decentralized and developer centric</p>
                                <div>
                                    <ul>
                                        <li><a href="{{base_path}}/get-started/apim-architecture/#immutable-gateway">WSO2 Immutable Gateway Overview</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- end card -->
                    <!-- begin card -->
                    <div class="card-wrapper">
                        <div class="card">
                            <div class="card-content">
                                <div class="rowAlignment">
                                    <div class="rowAlignmentProductNameIcon">
                                        <div class="card-icon">
                                            <i class="material-icons md-36">device_hub</i>
                                        </div>
                                        <p class="title"><b>Federated Gateways</b></p>
                                    </div>
                                </div>
                                <hr/>
                                <p class="removeTopMargin">Manage APIs spaning multiple cloud platforms, on-premises systems, or regions</p>
                                <div>
                                    <ul>
                                        <li><a href="{{base_path}}/manage-apis/deploy-and-publish/deploy-on-gateway/federated-gateways/deploy-on-aws-api-gateway/">AWS API Gateway</a></li>
                                        <li><a href="{{base_path}}/tutorials/integrating-with-solace/">Solace Broker</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- end card -->
                </div>
            </div>
        </div>
    </div>
</div>
