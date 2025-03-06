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

    .description-section {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 30px;
        margin-left: 100px;
    }
    .tiles-container {
        display: flex;
        align-items: start;
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
            {"name": "Deploy on Kubernetes", "url": "install-and-setup/install/deploying-api-manager-with-kubernetes-or-openshift-resources/"},
            {"name": "SaaS", "url": "#"}
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
            {"name": "Designing APIs", "url": "design/design-api-overview/"},
            {"name": "Create an API Product", "url": "design/create-api-product/create-api-product/"},
            {"name": "Authentication", "url": "design/api-security/api-authentication/api-authentication-overview/"},
            {"name": "Authorization", "url": "design/api-security/authorization/api-authorization/"},
            {"name": "Rate Limiting", "url": "design/rate-limiting/introducing-throttling-use-cases/"},
            {"name": "Consuming APIs", "url": "consume/consume-api-overview/"},
            {"name": "Analytics", "url": "api-analytics/choreo-analytics/getting-started-guide/"},
            {"name": "CI/CD", "url": "install-and-setup/setup/api-controller/ci-cd-with-wso2-api-management/"}
        ],
        "more_btn": {"name": "View more", "url": "tutorials/tutorials-overview/"}
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
                            {% if tile.title == "Community and Support" %}
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
</div>
