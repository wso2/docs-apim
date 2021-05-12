# API-M Distributed Deployment - Overview

Before deploying WSO2 API Manager (WSO2 API-M), let's understand how the WSO2 API-M distributed deployment works.
According to the recommended [deployment patterns]({{base_path}}/install-and-setup/setup/deployment-overview/#simple-scalable-deployment), a distributed deployment includes API-M server nodes that separately run the [API-M profiles]({{base_path}}/install-and-setup/setup/distributed-deployment/product-profiles). An API-M profile is a runtime instance that only runs specific components of the runtime.

## API-M Profiles

Listed below are the different profiles available in WSO2 API Manager. 

<table>
    <tr>
        <th>
            Profile
        </td>
        <th>
            Description
        </td>
    </tr>
    <tr>
        <td>
            Gateway Profile
        </td>
        <td>
            <p>Only starts the components related to the API Gateway.</p>
<p>Use this when the API Gateway acts as a worker node in a cluster. This profile starts the backend features for data processing and communicates with the management node.</p>
        </td>
    </tr>
    <tr>
        <td>
            Control Plane Profile
        </td>
        <td>
            Starts all the API-M components (Traffic Manager, Key Manager, Publisher, Developer Portal) excluding the Gateway.
        </td>
    </tr>
    <tr>
        <td>
            Traffic Manager Profile
        </td>
        <td>
            Only starts the Traffic Manager component.
        </td>
    </tr>
</table>

## API-M Components

Listed below are the five components of the API-M runtime and its function. 

<table>
    <tr>
        <th>
            Component
        </th>
        <th>
            Description
        </th>
    </tr>
    <tr>
        <td>
            Gateway
        </td>
        <td>
            Responsible for securing, protecting, managing, and scaling API calls.
        </td>
    </tr>
    <tr>
        <td>
            Key Manager
        </td>
        <td>
            Responsible for all security and key-related operations.
        </td>
    </tr>
    <tr>
        <td>
            Traffic Manager
        </td>
        <td>
            Used to make a decision on throttling. It also works as an event hub for broadcasting controller events such as throttling events, block conditions, revoke token retrieval events, API events, API policy events, application events, application policy events, application keys events, subscription events, and subscription policy events.
        </td>
    </tr>
    <tr>
        <td>
            Publisher
        </td>
        <td>
            Enables API providers to easily publish their APIs, share documentation, provision API keys, and gather feedback on API features, quality, and usage.
        </td>
    </tr>
    <tr>
        <td>
            Developer Portal
        </td>
        <td>
            Enables consumers to self-register, discover API functionality, subscribe to APIs, evaluate them, and interact with API publishers.
        </td>
    </tr>
</table>

## What's Next?

<<<<<<< HEAD
-   Find out more about [API-M profiles]({{base_path}}/install-and-setup/setup/distributed-deployment/product-profiles).
-   See the instructions on [Configuring a Distributed API-M Deployment]({{base_path}}/install-and-setup/setup/distributed-deployment/deploying-wso2-api-m-in-a-distributed-setup).
=======
-   Find out more about running [API-M profiles]({{base_path}}/install-and-setup/setup/distributed-deployment/product-profiles).
-   See the instructions on [Configuring a Distributed API-M Deployment]({{base_path}}/install-and-setup/setup/distributed-deployment/deploying-wso2-api-m-in-a-distributed-setup).
>>>>>>> f670ecf50 (distributed deployment and profiles)
