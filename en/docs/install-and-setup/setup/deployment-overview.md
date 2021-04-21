# WSO2 API Manager Deployment Overview

WSO2 API Manager consists of an API management layer and an integration layer. The API management layer contains several components, which you can use in your deployment according to your requirement. The integration layer includes either the Micro Integrator runtime (for services integration) and the Streaming Integrator runtime (for streaming requirements) or both runtimes.

You can select one of the following deployment patterns depending on the workload of each component and the traffic that is expected to each of the components and runtimes.

## Standard HA deployment

This deployment consists of an API-M cluster with two nodes of the API-M runtime and two nodes each of the integration runtimes (Micro Integrator/Streaming Integrator). You can use this pattern if you expect to receive low traffic to your deployment. 

!!! Note 
    Two nodes of each component is used to ensure minimum high availability in all components.

<a href="{{base_path}}/assets/img/setup-and-install/basic-ha-deployment.png"><img src="{{base_path}}/assets/img/setup-and-install/basic-ha-deployment.png" alt="standard HA deployment" width="500"></a>

### API-M cluster

The API-M cluster consists of two <b>All-in-One</b> API-M nodes. See the following link for instructions on how to set up this cluster.

<ul>
    <li>
        <a href="{{base_path}}/install-and-setup/setup/single-node/configuring-an-active-active-deployment">API-M Cluster with Minimum High Availability</a>
    </li>
</ul>

### Integration clusters

The integration cluster may be a Micro Integrator cluster or a Streaming Integrator cluster or two clusters of each. See the following links for instructions on how to set up this cluster.

<ul>
    <li>
        <a href="{{base_path}}/install-and-setup/setup/mi-setup/deployment/deploying_wso2_ei">Micro Integrator Cluster with Minimum High Availability</a>
    </li>
    <li>
        <a href="{{base_path}}/install-and-setup/setup/si-deployment/deploying-si-as-minimum-ha-cluster">Streaming Integrator Cluster with Minimum High Availability</a>
    </li>
</ul>

## Standard HA deployment with multitenancy

This deployment consists of two API-M nodes and two nodes each of the integration runtimes (Micro Integrator/Streaming Integrator) **per tenant**. You can use this pattern when traffic from different tenants in the API-M cluster needs to be handled in isolation. This deployment also allows you to direct the traffic of each tenant to a separate integration cluster. 

Although API-M nodes are capable of handling in-jvm multitenancy, Micro Integrator/Streaming Integrator nodes are not. Therefore, to handle traffic to different tenants, you need to set up different clusters of the integration runtimes and configure traffic routing accordingly. 

!!! Note
    The basic deployment suggests two nodes of each runtime to ensure minimum high availability. However, you can independently scale them depending on the resource requirements for each tenant.

<a href="{{base_path}}/assets/img/setup-and-install/basic-ha-with-multitenancy.png"><img src="{{base_path}}/assets/img/setup-and-install/basic-ha-with-multitenancy.png" alt="standard HA with multitenancy" width="700"></a>

### API-M cluster

The API-M cluster consists of two <b>All-in-One</b> API-M nodes. See the following link for instructions on how to set up this cluster.

<ul>
    <li>
        <a href="{{base_path}}/install-and-setup/setup/single-node/configuring-an-active-active-deployment">API-M Cluster with Minimum High Availability</a>
    </li>
</ul>

### Integration cluster

The integration cluster consists of two nodes of the integration runtime for each of the tenants in the API-M cluster. See the following links for instructions on how to set up this cluster.

<ul>
    <li>
        <a href="{{base_path}}/install-and-setup/setup/mi-setup/deployment/deploying_wso2_ei">Micro Integrator Cluster with Minimum High Availability</a>
    </li>
    <li>
        <a href="{{base_path}}/install-and-setup/setup/si-deployment/deploying-si-as-minimum-ha-cluster">Streaming Integrator Cluster with Minimum High Availability</a>
    </li>
</ul>

## Simple scalable deployment

This pattern allows you to scale the deployment on demand. The **simple scalable deployment** pattern shown below illustrates a deployment that uses minimum resources. However, this setup can easily be scaled.

You need to set up three clusters of the different components and runtimes as they have different scaling requirements.

!!! Note
    The basic deployment suggests two nodes of each runtime to ensure minimum high availability. However, you can independently scale them depending on the requirements.

<a href="{{base_path}}/assets/img/setup-and-install/basic-scalable-deployment.png"><img src="{{base_path}}/assets/img/setup-and-install/basic-scalable-deployment.png" alt="simple scalability" width="650"></a>

### API-M cluster

The API-M layer of this deployment consists of two clusters of API-M components as follows:

<table>
    <tr>
        <th>
            Control Plane Cluster
        </th>
        <td>
            The APIM control plane consists of two nodes of the <b>Control Pane</b> API-M profile (Publisher, Devportal, Key Manager, Traffic Manager). The two node cluster is the simplest deployment for this pattern. If required you can scale the number of nodes.
        </td>
    </tr>
    <tr>
        <th>
            Gateway Cluster
        </th>
        <td>
            The Gateway profile of API-M is deployed as a separate cluster so that we can scale it to match the traffic requirements. The simplest deployment for this pattern consists of a two node Gateway cluster. If required you can scale the number of nodes.
        </td>
    </tr>
</table>

To set up this cluster, see the instructions on <a href="{{base_path}}/install-and-setup/setup/distributed-deployment/deploying-wso2-api-m-in-a-distributed-setup">Setting up a Distributed API-M deployment</a>.

### Integration cluster

The integration cluster consist of a minimum of two ndes of the integration runtime (Micro Integrator/Streaming Integrator). See the following links for instructions on how to set up this cluster.

<ul>
    <li>
        <a href="{{base_path}}/install-and-setup/setup/mi-setup/deployment/deploying_wso2_ei">Micro Integrator Cluster with Minimum High Availability</a>
    </li>
    <li>
        <a href="{{base_path}}/install-and-setup/setup/si-deployment/deploying-si-as-minimum-ha-cluster">Streaming Integrator Cluster with Minimum High Availability</a>
    </li>
</ul>
