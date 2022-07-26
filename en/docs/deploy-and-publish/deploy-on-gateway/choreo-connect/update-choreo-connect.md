# Update Choreo Connect

WSO2 introduces [WSO2 Updates](https://updates.docs.wso2.com/en/latest/) , which is a command-line utility that allows you to get the latest updates that are available for a particular product release. These updates include the latest bug fixes and security fixes that are released by WSO2 after a particular product version is released. Therefore, you do not need to wait and upgrade to the next product release to get these bug fixes.

You can easily upgrade Choreo Connect [Using WSO2 Updates 2.0](https://updates.docs.wso2.com/en/latest/updates/update-tool/). The docker images related to Choreo Connect updates are reside in [WSO2 private docker registry](https://docker.wso2.com/) and the image tags are having the following format for Choreo Connect components.

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

For more details on components' versioning, you may follow through the documentation on [Docker image tags with Updates 2.0
](https://updates.docs.wso2.com/en/latest/updates/using-wso2-docker-images/).

You can use the following steps the upgrade Choreo Connect for a particular update level.

1. Use your subscription details to login to the [Updates Portal](https://updates.docs.wso2.com/en/latest/updates/updates-portal/) and decide the correct docker image tag that you will use to update. You will be able to see the information like General description, Implementation details, Impact, Bug fixes and specific Instructions on each update via the **Updates Portal** . 
2. Run all the security and compliance checks on the selected Docker image and verify its compliance with your security requirements.
3. Rollout the docker image to a lower environment and test.
4. Use the image in higher environments as required.
