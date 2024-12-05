# Configure Pattern 2: Centralized API Management with Regional Data Planes

<a href="{{base_path}}/assets/img/setup-and-install/multi-dc-pattern-2.png"><img src="{{base_path}}/assets/img/setup-and-install/multi-dc-pattern-2.png" alt="Multi-DC Pattern 2" width="80%"></a>

## Configuring Main Region

The main region will be similar to the setup in a particular region as Pattern 1. Hence, the configuration will be similar except for the DB replication and event hub communication.

{!includes/deploy/steps-to-deploy-apim-in-a-distributed-setup-with-tm-separation.md!}

Since the control plane only resides in the main region, the gateway nodes and the traffic manager nodes in the sub regions should communicate with the main region via the control plane (event hub). Therefore, the following should be exposed to external usage.

<table>
<thead>
<tr class="header">
<th><b>Port</b></th>
<th><b>Component</b></th>
<th><b>Usage</b></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>9443</td>
<td>HTTPS</td>
<td>Load Balancer fronting the control plane nodes
Used in the endpoint which points to the internal API that resides in the event hub that is used to pull artifacts and information from the database by the GW and TM in the sub region</td>
</tr>
<tr class="even">
<td>5672</td>
<td>TCP</td>
<td>Each control plane instance in the HA setup
Used to establish JMS connection between the sub region components and event hub which is then used by sub region components to receive events.</td>
</tr>
</tbody>
</table>

## Configuring Sub-Region

### Step 1: Configure the Gateway nodes

Follow the guideline [here]({{base_path}}/install-and-setup/setup/distributed-deployment/deploying-wso2-api-m-in-a-distributed-setup-with-tm-separated/#configure-the-gateway-nodes) to configure the Gateway of the sub-region to connect with the Control Plane of the main region and the traffic manager of the sub-region. Take a note of the hostnames given below when configuring the Gateway node.

#### Connecting the Gateway to the Control Plane node

=== "Configuration for a setup with Single Control Plane"
    ``` toml
    # Key Manager configuration
    [apim.key_manager]
    service_url = "https://[main-region-cp-host]:${mgt.transport.https.port}/services/"
    username = "$ref{super_admin.username}"
    password = "$ref{super_admin.password}"

    # Event Hub configurations
    [apim.event_hub]
    enable = true
    username = "$ref{super_admin.username}"
    password = "$ref{super_admin.password}"
    service_url = "https://[main-region-cp-host]:${mgt.transport.https.port}/services/"
    event_listening_endpoints = ["tcp://main-region-cp-host:5672"]               
    ```

=== "Configuration for a setup containing Control Planes with High Availability"
    ``` toml
    # Key Manager configuration
    [apim.key_manager]
    service_url = "https://[main-region-cp-LB-host]/services/"
    username = "$ref{super_admin.username}"
    password = "$ref{super_admin.password}"

    # Event Hub configurations
    [apim.event_hub]
    enable = true
    username = "$ref{super_admin.username}"
    password = "$ref{super_admin.password}"
    service_url = "https://main-region-cp-LB-host/services/"
    event_listening_endpoints = ["tcp://main-region-cp-1-host:5672, tcp://main-region-cp-2-host:5672"]
    ```

#### Connecting the Gateway to the Traffic Manager node

=== "Configuration for a setup with Single Traffic Manager"
    ``` toml
    [apim.throttling]
    throttle_decision_endpoints = ["tcp://sub-region-1-tm-host:5672"]

    [[apim.throttling.url_group]]
    traffic_manager_urls = ["tcp://sub-region-1-tm-host:9611"]
    traffic_manager_auth_urls = ["ssl://sub-region-1-tm-host:9711"]            
    ```

=== "Configuration for a setup containing Traffic Manager with High Availability"
    ``` toml
    [apim.throttling]
    throttle_decision_endpoints = ["tcp://sub-region-1-tm-1-host:5672", "tcp://sub-region-1-tm-2-host:5672"]

    [[apim.throttling.url_group]]
    traffic_manager_urls = ["tcp://sub-region-1-tm-1-host:9611"]
    traffic_manager_auth_urls = ["ssl://sub-region-1-tm-1-host:9711"]

    [[apim.throttling.url_group]]
    traffic_manager_urls = ["tcp://sub-region-1-tm-2-host:9611"]
    traffic_manager_auth_urls = ["ssl://sub-region-1-tm-2-host:9711"]
    ```

### Step 2: Configure the Traffic Manager nodes

Follow the guideline [here]({{base_path}}/install-and-setup/setup/distributed-deployment/deploying-wso2-api-m-in-a-distributed-setup-with-tm-separated/#configure-the-traffic-manager-nodes) to configure the Traffic Manager of the sub-region to connect with the Control Plane of the main region. Take a note of the hostnames given below when configuring the Gateway node.

#### Configure the Traffic Manager to communicate with the Control Plane

=== "Configuration for a setup with Single Control Plane"
    ``` toml
    # Event Hub configurations
    [apim.event_hub]
    enable = true
    username = "$ref{super_admin.username}"
    password = "$ref{super_admin.password}"
    service_url = "https://main-region-cp-host:${mgt.transport.https.port}/services/"
    event_listening_endpoints = ["tcp://main-region-cp-host:5672"]
    ```

=== "Configuration for a setup containing Control Plane with High Availability"
    ``` toml
    # Event Hub configurations
    [apim.event_hub]
    enable = true
    username = "$ref{super_admin.username}"
    password = "$ref{super_admin.password}"
    service_url = "https://main-region-cp-LB-host/services/"
    event_listening_endpoints = ["tcp://main-region-cp-1-host:5672", "tcp://main-region-cp-2-host:5672"]
    ```

!!! Note
    &lt;main-region-cp-LB-host&gt; should be replaced by the host of the Load Balancer (LB) fronting the control plane nodes of the main region in an HA setup whereas &lt;main-region-cp-host&gt; should be replaced by the host of the control plane of the main region since the gateway nodes and the traffic manager nodes of the sub region will communicate with the main region control plane directly in a single control plane setup.
