# Update Choreo Connect

Choreo Connect components are available as public Docker images in [WSO2](https://hub.docker.com/u/wso2) organization in the Docker hub whereas you will be able to find images corresponding to [Choreo Connect releases](https://github.com/wso2/product-microgateway/releases). 

However, if you have a WSO2 Subscription you will be able to use latest Docker images with updates, which includes bug fixes, features, improvements, etc. on top of generally available releases. This documentation is about how you can use those particular updates.

## Docker Image Tags

The Docker images related to Choreo Connect updates reside in [WSO2 private Docker registry](https://docker.wso2.com/) and the image tags have the following format for Choreo Connect components.

<table>
    <thead>
        <tr>
            <th>Component Name</th>
            <th>Image tag format</th>
            <th>Example</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>
                <a href="{{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/getting-started/choreo-connect-overview/#router">Router</a>
            </td>
            <td>
                <code>choreo-connect-router:{WSO2_PRODUCT_VERSION}.{UPDATE_LEVEL}</code>
            </td>
            <td>
                <code>choreo-connect-router:1.1.0.3</code>
            </td>
        </tr>
        <tr>
            <td>
                <a href="{{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/getting-started/choreo-connect-overview/#enforcer">Enforcer</a>
            </td>
            <td>
                <code>choreo-connect-enforcer:{WSO2_PRODUCT_VERSION}.{UPDATE_LEVEL}</code>
            </td>
            <td>
                <code>choreo-connect-enforcer:1.1.0.3</code>
            </td>
        </tr>
        <tr>
            <td>
                <a href="{{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/getting-started/choreo-connect-overview/#adapter">Adapter</a>
            </td>
            <td>
                <code>choreo-connect-enforcer:{WSO2_PRODUCT_VERSION}.{UPDATE_LEVEL}</code>
            </td>
            <td>
                <code>choreo-connect-adapter:1.1.0.3</code>
            </td>
        </tr>  
    </tbody>
</table>

!!! Info
    For more details on versioning, you may follow through the documentation on [Docker image tags with Updates 2.0](https://updates.docs.wso2.com/en/latest/updates/using-wso2-docker-images/).

You will be able to use the **Updates Portal** to see more details about these update levels in Docker image tags, which will be covered in the next section.

## Updates Portal

Use your subscription details to login to the Updates Portal via [https://updates-info.wso2.com](https://updates-info.wso2.com/). You will be able to see the information like General description, Implementation details, Impact, Bug fixes and specific Instructions on each update in the **Update Levels** section by choosing Choreo Connect as the product and appropriate product version.

!!! Info
    For more information on this, refer to the official documentation for [Updates Portal](https://updates.docs.wso2.com/en/latest/updates/updates-portal/).
