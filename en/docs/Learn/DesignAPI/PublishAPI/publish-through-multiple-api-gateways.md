# Publish through Multiple API Gateways

You can configure multiple API Gateway environments in WSO2 API Manager that publish to a single API Store when you require distributing the gateway load comes in. It helps you to distribute the API Gateway load to multiple nodes and also gives you some logical separation (e.g., production vs. sandbox) between the APIs in the API Store. When you publish an API through multiple Gateway environments, the APIs in the API Store will have different server hosts and ports.

The steps below explain how to configure and publish to multiple Gateways. In this guide, we set up three (3) WSO2 API Manager (WSO2 API-M) instances in the same server. In a typical production environment, the Gateways will ideally be in separate servers.

-   **Instance 1** : Acts as the node that provides the API Publisher, Store, and the Key Manager functionality.
-   **Instance 2** : Acts as a production Gateway node.
-   **Instance 3** : Acts as a sandbox Gateway node.

1.  Copy the WSO2 API Manager (WSO2 API-M) product pack into three (3) separate folders.
    Let's add offsets to the default ports of the two Gateway instances. A port offset ensures that there are no port conflicts when more than one WSO2 product runs on the same server.

2.  Open the `<API-M_HOME>/repository/conf/carbon.xml` file in the **second** API Manager instance, and add an offset of 1 to its default port. This increments its default server port, which is 9443, by 1.

    ``` java
        <Offset>1</Offset>
    ```

3.  Open the `<API-M_HOME>/repository/conf/carbon.xml` file in the **third** API Manager instance and add an offset of 2 to its default port. This increments its default server port, which is 9443, by 2.

    ``` java
            <Offset>2</Offset>
    ```

4.  Open the `<API-M_HOME>/repository/conf/api-manager.xml` files in the **second and the third** API Manager instances and set the `<EnableThriftServer>` property to `false` .
    This is done to disable the thrift server in the two Gateway instances. Thrift server is needed for the Key Manager functionality. It is not needed in the Gateway instances.

    ``` java
            <EnableThriftServer>false</EnableThriftServer>
    ```

5.  Open the `<API-M_HOME>/repository/conf/api-manager.xml` files in the **second and the third** Gateway instances and change the following.
    This is done for the two Gateway instances to be able to communicate with the Key Manager that is in the first API Manager instance.

    ``` java
            <AuthManager>
                <ServerURL>https://<IP of the first instance>:9443/services/</ServerURL>
                <Username>admin</Username>
                <Password>admin</Password>
                ...
            </AuthManager>
            ...
            <APIKeyValidator>
                 <ServerURL>https://<IP of the first instance>:9443/services/</ServerURL>
                 <Username>admin</Username>
                 <Password>admin</Password>
                 ....
                 <RevokeAPIURL>https://<IP of the first instance>:8243/revoke</RevokeAPIURL>
            </APIKeyValidator>
    ```

6.  Open the `<API-M_HOME>/repository/conf/api-manager.xml` files in **all** the Gateway instances and uncomment the following configuration:

    ``` java
            <ThriftClientPort>10397</ThriftClientPort>
    ```

    You are done configuring the two API Gateway instances.

7.  Open the `<API-M_HOME>/repository/conf/api-manager.xml` file in the **first** API Manager instance, add two API Gateway environments under the `<Environments>` element,  and comment out the `<environment>` element that comes by default.
    This is done to point to the two API Gateway instances from the first instance.

        !!! note
    -   There can be different types of environments, and the allowed values are `hybrid` , `production` , and `sandbox` .

        -   An API deployed on a `production` type gateway will only support production keys.

        -   An API deployed on a `sandbox` type gateway will only support sandbox keys

        -   An API deployed on a `hybrid` type gateway will support both production and sandbox keys.

    -   The `api-console` element specifies whether the environment should be listed in API Console or not.

    -   The Gateway environment names must be unique.


    **Example**

    ``` xml
               <Environment type="production" api-console="true">
                        <Name>Production Gateway</Name>
                        <Description>Production Gateway Environment</Description>
                        <ServerURL>https://localhost:9444/services/</ServerURL>
                        <Username>admin</Username>
                        <Password>admin</Password>
                        <GatewayEndpoint>http://localhost:8281,https://localhost:8244</GatewayEndpoint>
                </Environment>
                <Environment type="hybrid" api-console="true">
                        <Name>Production and Sandbox</Name>
                        <Description>Hybrid Gateway Environment</Description>
                        <ServerURL>https://localhost:9445/services/</ServerURL>
                        <Username>admin</Username>
                        <Password>admin</Password>
                        <GatewayEndpoint>http://localhost:8282,https://localhost:8245</GatewayEndpoint>
                </Environment>
    ```

        !!! tip
    If you have multiple gateways that support one type of key (e.g., when there are two gateways that support the production keys, as seen in the above code snippet.), the environments you add via the `<API-M_HOME>/repository/conf/api-manager.xml` file will be visible in a drop-down list of the API Console tab, which is in the API Store of instance 1. This allows subscribers to send API requests to any selected Gateway.

    ![]({{base_path}}/assets/attachments/103332478/103332476.png)

    To stop a given Gateway environment from being displayed in the API Console tab, you can set the `api-console` attribute to `false` in the `<Environment>` element in the `api-manager.xml` file.
    For example,

    ``` java
        <Environment type="production" api-console="false">
    ```


8.  Start all the WSO2 API-M instances.
    Make sure to start instance 1 first before starting the other two instances.
9.  Sign in to the API Publisher in the **first** WSO2 API-M instance and choose to edit an API.
    ![]({{base_path}}/assets/attachments/103332478/103332474.png)
10. Navigate to the **Manage** tab, expand the **API Gateways** section.
    Note that the two Gateway environments are listed there.
    ![]({{base_path}}/assets/attachments/103332478/103332473.png)
11. Select both Gateways and **Save and Publish** the API in order to be able to publish to both the gateways.
12. Sign in to the API Store (of the **first** instance) and click the API to open it.
    ![]({{base_path}}/assets/attachments/103332478/103332472.png)
13. In the API's **Overview** tab, note that it has two sets of URLs for the two Gateway instances:
    ![]({{base_path}}/assets/attachments/103332478/103332475.png)

You have published an API to the API Stores through multiple Gateway environments.

!!! tip
If you have published your API through more than one Gateway,

When you have generated keys for the Applications, the sample cURL command shows how to generate an access token using the Password Grant type provides the Gateway URL of the first published Gateway Environments listed in API Publisher as shown in the step 10.

![]({{base_path}}/assets/attachments/103332478/103332477.png)

Change this gateway URL according to the Gateway that you want to publish the API if you are using this cURL command to generate access tokens.

!!! note
If you wish to use the API-M pack that you used as the first instance to try-out other tutorials, please ensure to delete the API Gateway configurations that you added in [step 7](#PublishthroughMultipleAPIGateways-step6) , and uncomment the default `<Environment>` configurations in the `<API-M_HOME>/repository/conf/api-manager.xml` file.


