# Scenario Overview

**Union Station** is a major multimodal railway transportation hub. It is one of the busiest stations in the country and serves thousands of passengers a day. The train shed, platforms, and tracks are owned by **GOGO transit**, and they operate the station. Trains are owned by the companies named **Quantis**, **ColTrain**, and **RailCo**. To provide a digital ecosystem, all four companies are planning to develop their day to day business operations with WSO2 technology. These development ranges from providing different kinds of APIs to external/internal users, providing real time notifications, stream data processing, integrating with partners/external systems etc.

<img src="{{base_path}}/assets/img/tutorials/scenario-tutorials/scenario-overview.png" alt="Scenario Overview" title="Scenario Overview" width="65%" />

These tutorials will demonstrate how WSO2 technology can be used to cater to their different requirements.

## Prerequisites

Docker and Docker compose need to be installed. Please refer [https://docs.docker.com/compose/install/](https://docs.docker.com/compose/install/) for more information. Allocate a minimum of 4 CPU cores and 4GB Memory for Docker resources.

## Requirements

- WSO2 Experience : Intermediate
- Technologies used : 
    - WSO2 API Manager 4.0.0
    - WSO2 Micro Integrator
    - WSO2 Streaming Integrator
    - Sample backends and clients written in Spring boot and hosted in Tomcat
    - MySQL

## Deployment

<img src="{{base_path}}/assets/img/tutorials/scenario-tutorials/scenario-deployment.png" alt="Scenario Deployment" title="Scenario Deployment" width="65%" />

A basic infrastructure has already been created for you to try out the scenarios. To run the setup please follow these steps.

1. Clone https://github.com/wso2/samples-apim/tree/master/apim-tutorial 
2. Start the setup using the command `docker-compose up -d`.
3. You can view the logs using the command `docker-compose logs -d`.
4. It might take 5-10 mins for setup to complete (if it is the first time, based on your download speed it might take longer). 
5. When you see the below log you can start working on the scenarios.
    ```
    “==Data population completed==”
    ```

### API Manager Setup

The API Manager setup consists of 3 tenants for Quantis, ColTrain, and RailCo and Gogo Transit uses the super tenant domain. Tenants, Users, and APIs will be created automatically when Docker compose starts.

<img src="{{base_path}}/assets/img/tutorials/scenario-tutorials/scenario-tenants.png" alt="Scenario Tenants" title="Scenario Tenants" width="65%" />

You can log in to the Publisher Portal and Developer Portal using each tenant's credentials. 

Publisher portal: https://localhost:9443/publisher/
Developer portal: https://localhost:9443/devportal 

The following default users are created. For the ease of use, every tenant has 3 common users (admin, apiprovider, devuser) for Admin, Publisher, and Developer Portal. 

<table>
    <tr>
        <th>
        </th>
        <th>Admin
        </th>
        <th>Publisher
        </th>
        <th>Developer Portal
        </th>
    </tr>
    <tr>
        <td>Quantis
        </td>
        <td>admin@qunatis.com
        </td>
        <td>
            <ul>
                <li>apiprovider@qunatis.com</li>
                <li>andy@qunatis.com</li>
        </td>
        <td>
            <ul>
                <li>devuser@qunatis.com</li>
                <li>bob@qunatis.com</li>
                <li>sindy@qunatis.com</li>
                <li>logan@qunatis.com</li>
            </ul>
        </td>
    </tr>
    <tr>
        <td>ColTrain
        </td>
        <td>admin@coltrain.com
        </td>
        <td>
            <ul>
                <li>apiprovider@coltrain.com</li>
                <li>bill@coltrain.com</li>
        </td>
        <td>
            <ul>
                <li>devuser@coltrain.com</li>
                <li>george@coltrain.com</li>
            </ul>
        </td>
    </tr>
    <tr>
        <td>RailCo
        </td>
        <td>admin@railco.com
        </td>
        <td>
            <ul>
                <li>apiprovider@railco.com</li>
                <li>jill@railco.com</li>
        </td>
        <td>
            <ul>
                <li>devuser@railco.com</li>
                <li>tom@railco.com</li>
            </ul>
        </td>
    </tr>
</table>

(admin user password: admin , other user password : user123)

### Micro Integrator and Streaming Integrator Setup 

The Micro Integrator and Streaming Integrator containers that were created when you started the setup will contain the services and client .jar files that will be used throughout this tutorial.

### Others

- Apache Tomcat - This will host the services that will be used as backends, clients that will be used throughout the tutorial.
- MySQL - This MySQL database will be used by Micro Integrator. An initial database will be created when the container spins up.


## Scenarios

<table>
    <tr>
        <td>
            <ul>
                <li><a href="{{base_path}}/tutorials/scenarios/scenario1-create-rest-api">Scenario 1: Create a REST API from an OpenAPI Definition<a></li>
                <li><a href="{{base_path}}/tutorials/scenarios/scenario2-access-control">Scenario 2: Engage Access Control to the API<a></li>
                <li><a href="{{base_path}}/tutorials/scenarios/scenario3-implementing-an-api">Scenario 3: Implementing an API<a></li>
                <li><a href="{{base_path}}/tutorials/scenarios/scenario4-user-signup-approval-flow">Scenario 4: Signing up a New User<a></li>
                <li><a href="{{base_path}}/tutorials/scenarios/scenario5-developer-community-feature">Scenario 5: Getting the Developer Community Involved<a></li>
                <li><a href="{{base_path}}/tutorials/scenarios/scenario6-integrating-with-data-sources">Scenario 6: Integrating with Data Sources<a></li>
                <li><a href="{{base_path}}/tutorials/scenarios/scenario7-analytics">Scenario 7: Analytics<a></li>
            </ul>
        </td>
        <td>
            <ul>
                <li><a href="{{base_path}}/tutorials/scenarios/scenario8-rate-limiting">Scenario 8: Rate Limiting<a></li>
                <li><a href="{{base_path}}/tutorials/scenarios/scenario9-realtime-data">Scenario 9: Realtime Data with WebSocket API<a></li>
                <li><a href="{{base_path}}/tutorials/scenarios/scenario10-notifications-webhooks">Scenario 10: Notifications Using Webhooks<a></li>
                <li><a href="{{base_path}}/tutorials/scenarios/scenario11-graphql">Scenario 11: GraphQL Support<a></li>
                <li><a href="{{base_path}}/tutorials/scenarios/scenario12-message-delivery">Scenario 12: Gauranteed Message Delivery<a></li>
                <li><a href="{{base_path}}/tutorials/scenarios/scenario13-integrate-with-connectors">Scenario 13: Integrate with Services via Connectors<a></li>
                <li><a href="{{base_path}}/tutorials/scenarios/scenario14-external-key-manager">Scenario 14: External Key Manager Support<a></li>
            </ul>
        </td>
    </tr>
</table>
