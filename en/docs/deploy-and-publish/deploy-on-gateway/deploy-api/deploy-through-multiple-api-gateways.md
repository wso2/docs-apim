# Publish Through Multiple API Gateways

If you need to distribute the Gateway load that comes in, you can configure multiple API Gateway environments in WSO2 API Manager to publish to a single Developer Portal. This helps you to distribute the API Gateway load to multiple nodes and also gives you some logical separation (e.g., production vs. sandbox) between the APIs in the Developer Portal. When you publish an API through multiple Gateway environments, the APIs in the API Developer Portal will have different server hosts and ports.

In the following guide, let's set up three (3) WSO2 API Manager (WSO2 API-M) instances on the same server. 

-   **Instance 1** : Acts as the node that provides the Control Plane functionality, such as the Publisher, Developer Portal, and the Key Manager functionality.
-   **Instance 2** : Acts as a production Gateway node.
-   **Instance 3** : Acts as a sandbox Gateway node.

!!! note

    In a typical production environment, the Gateways will ideally be in separate servers.

## Step 1 - Configure the Control Plane

Open the `<API-M_HOME>/repository/conf/deployment.toml` file in the **first** API Manager instance, add two API Gateway environments by adding two `[[apim.gateway.environment]]` sections and comment out the `[[apim.gateway.environment]]` section that comes by default.
     
 This is done to point to the two API Gateway instances from the first instance.

!!! note

    -   There can be different types of environments, and the allowed values are `hybrid`,`production`, and `sandbox`.

    -   An API deployed on a `production` type Gateway will only support production keys.
    -   An API deployed on a `sandbox` type Gateway will only support sandbox keys.
    -   An API deployed on a `hybrid` type Gateway will support both production and sandbox keys.
    -   The `api-console` element specifies whether the environment should be listed in API Console or not.
    -   The Gateway environment names must be unique.

**Example**

```toml
[[apim.gateway.environment]]
name = "Production Gateway"
type = "production"
display_in_api_console = true
description = "Production Gateway Environment"
show_as_token_endpoint_url = true
service_url = "https://localhost:9444/services/"
username= "admin"
password= "admin"
http_endpoint = "http://localhost:8281"
https_endpoint = "https://localhost:8244"

[[apim.gateway.environment]]
name = "Default"
type = "hybrid"
display_in_api_console = true
description = "Hybrid Gateway Environment"
show_as_token_endpoint_url = true
service_url = "https://localhost:9445/services/"
username= "admin"
password= "admin"
http_endpoint = "http://localhost:8282"
https_endpoint = "https://localhost:8245"
```

!!! tip
        If you have multiple Gateways that support one type of key (e.g., when there are two Gateways that support the production keys, as seen in the above code snippet), the environments you add via the `<API-M_HOME>/repository/conf/deployment.toml` file will be visible in a drop-down list of the API **Try Out** tab, which is in the Developer Portal of instance 1. This allows subscribers to send API requests to any selected Gateway.

[![API tryout tab]({{base_path}}/assets/img/learn/devportal-tryout-multiple-gateways.png)]({{base_path}}/assets/img/learn/devportal-tryout-multiple-gateways.png)

!!! note
    To stop a given Gateway environment from being displayed in the API Try Out tab, you can set the `display_in_api_console` attribute to `false` in the `apim.gateway.environment` element, which is in the `deployment.toml` file.

    **Example**

    ``` toml
    [[apim.gateway.environment]]
    display_in_api_console = false
    ```

## Step 2 - Configure the two Gateway nodes

As mentioned above, the **second and the third** instances will serve as the Gateway instances.

### Step 2.1 - Configure port offset

!!! note
    This is only applicable when all three instances are running on the same server.

1.  Open the `<API-M_HOME>/repository/conf/deployment.toml` file in the **second** API Manager instance, and add an offset of 1 to its default port. 
     This increments its default server port, which is 9443, by 1.

    ``` toml
    [server]
    offset=1
    ```

2.  Open the `<API-M_HOME>/repository/conf/deployment.toml` file in the **third** API Manager instance and add an offset of 2 to its default port. 

     This increments its default server port, which is 9443, by 2.

    ``` toml
    [server]
    offset=2
    ```

### Step 2.1 - Configure the Gateway instances

Carry out the following instructions in the **second** and the **third** instances to configure the Gateway instances so that it can communicate with the Control Plane node:

{!includes/install_setup/configuring_gateway_node.md!}

## Step 3 - Start the instances

Start all the WSO2 API-M instances.

Make sure to start instance 1 first before starting the other two instances.

## Step 4 - Publish an API via Multiple API Gateways

1.  Sign in to the API Publisher in the **first** WSO2 API-M instance and click to edit an API.

    <a href="{{base_path}}/assets/img/learn/pizzashak-api-publisher.png"><img src="{{base_path}}/assets/img/learn/pizzashak-api-publisher.png" title="Pizza Shack Publisher" width="30%" alt="Pizza Shack Publisher"/></a>
     
2.  Click **Deployments** and click **Deploy New Revision**.

    <a href="{{base_path}}/assets/img/learn/api-revisions-mutiple-gateways.png"><img src="{{base_path}}/assets/img/learn/api-revisions-mutiple-gateways.png" title="API Revisions Multiple Gateways" width="80%" alt="API Revisions Multiple Gateways"/></a>
    
    Note that the two Gateway environments are listed there

    <a href="{{base_path}}/assets/img/learn/multiple-gateways-revision-dialog.png"><img src="{{base_path}}/assets/img/learn/multiple-gateways-revision-dialog.png" title="Multiple Gateways Dialog" width="40%" alt="Multiple Gateways Dialog"/></a>

3.  Select both Gateways and click deploy.

    <a href="{{base_path}}/assets/img/learn/multiple-gateways-revision-dialog-filled.png"><img src="{{base_path}}/assets/img/learn/multiple-gateways-revision-dialog-filled.png" title="Filled Multiple Gateways Dialog" width="40%" alt="Filled Multiple Gateways Dialog"/></a>

4.  Sign in to the Developer Portal (of the **first** instance) and click on the respective API to open it.

    <a href="{{base_path}}/assets/img/learn/pizzashack-api-devportal.png"><img src="{{base_path}}/assets/img/learn/pizzashack-api-devportal.png" title="Dev Portal Pizza Shack" width="30%" alt="Dev Portal Pizza Shack"/></a>
     
    In the **Overview** tab that corresponds to the API, note that it has two sets of URLs for the two Gateway instances:

    <a href="{{base_path}}/assets/img/learn/multiple-gateways-devportal-overview.png"><img src="{{base_path}}/assets/img/learn/multiple-gateways-devportal-overview.png" title="Multiple Gateways Deploy Overview" width="50%" alt="Multiple Gateways Deploy Overview"/></a>

You have successfully published an API to the API Developer Portals through multiple Gateway environments.

## Step 5 - Generated the keys for the applications

Use the following sample cURL command to generate an access token for the Gateway URL of the initially published Gateway Environments, which was listed in API Publisher in step 10, using the Password Grant type.

<a href="{{base_path}}/assets/img/learn/generate-access-tokens.png"><img src="{{base_path}}/assets/img/learn/generate-access-tokens.png" title="Generate Access Token" width="55%" alt="Generate Access Token"/></a>

Change the Gateway URL based on the Gateway that you need to publish the API.


!!! note
    If you wish to use the API-M pack that you used as the first instance to try-out other tutorials, please ensure to delete the API Gateway configurations that you added in step 2.1, and uncomment the default `[[apim.gateway.environment]]` configurations in the `<API-M_HOME>/repository/conf/deployment.toml` file.
