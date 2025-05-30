# Configuring a Distributed API-M Deployment with Key Manager Separated from the API Control Plane

WSO2 API-M can be deployed as an [all-in-one deployment]({{base_path}}/install-and-setup/setup/single-node/all-in-one-deployment-overview) or as a distributed deployment. In the distributed setup, the respective component distributions, namely WSO2 API Control Plane, WSO2 Universal Gateway and WSO2 Traffic Manager are deployed as separate nodes. 

Given below are the API-M nodes you can have in a distributed deployment with Key Manager separated from the API Control Plane.

!!! Tip
    To enable high availability, you need a minimum of two nodes running each component distribution.

<table>
    <tr>
        <th>
            API-M Component Distribution
        </th>
        <th>
            Description
        </th>
    </tr>
    <tr>
        <td>
            WSO2 API Control Plane
        </td>
        <td>
            API-M nodes running the Control Plane component. The WSO2 API Control Plane includes the Key Manager, Publisher Portal, Developer Portal components.
        </td>
    </tr>
    <tr>
        <td>
            WSO2 Universal Gateway
        </td>
        <td>
            API-M nodes running the Gateway component.
        </td>
    </tr>
    <tr>
        <td>
            WSO2 Traffic Manager
        </td>
        <td>
            API-M nodes running the Traffic Manager component.
        </td>
    </tr>
    <tr>
        <td>
            Key Manager Component
        </td>
        <td>
            If required you can configure a separate WSO2 API Control Plane node to run the Key Manager component. That is, the API Control Plane nodes run the Publisher Portal and Developer Portal while the Key Manager runs on a separate node.
        </td>
    </tr>
</table>

<a href="{{base_path}}/assets/img/setup-and-install/deployment-km.png"><img src="{{base_path}}/assets/img/setup-and-install/deployment-km.png" width="100%"></a>

{!includes/deploy/steps-to-deploy-apim-in-a-distributed-setup-with-km-separation.md!}
