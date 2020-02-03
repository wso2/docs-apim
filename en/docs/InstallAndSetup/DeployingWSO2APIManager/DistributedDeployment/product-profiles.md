# Product Profiles

When a WSO2 product starts, it starts all components, features and related artifacts bundled with it. Multi-profile support allows you to run the product on a selected profile so that only the features specific to that profile along with common features start up with the server.

!!! tip
    Starting a product on a preferred profile only blocks/allows the relevant OSGI bundles. As a result, even if you start the server on a profile such as the `api-devportal` for example, you can still access the API Publisher web application.

!!! OSGI Bundle
    OSGI bundle is a tightly coupled, dynamically loadable collection of classes, jars, and configuration files that explicitly declare their external dependencies (if any). In OSGi, a bundle is the primary deployment format. Bundles are applications that are packaged in JARs, and can be installed, started, stopped, updated, and removed.


## API-M Profiles

The following are the different profiles available in WSO2 API Manager.

<table>
<thead>
<tr class="header">
<th>Profile</th>
<th>Command Option with Profile Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>Gateway worker</td>
<td><pre><code>-Dprofile=gateway-worker   </code></pre></td>
<td><div class="content-wrapper">
<p>Only starts the components related to the API Gateway.</p>
<p>You use this when the API Gateway acts as a worker node in a cluster. This profile starts the backend features for data processing and communicates with the management node.</p>
</div></td>
</tr>
<tr class="even">
<td>Key Manager</td>
<td><pre><code>-Dprofile=api-key-manager</code></pre></td>
<td><div class="content-wrapper">
<p>Only starts the features relevant to the Key Manager component of the API Manager.</p>
</div></td>
</tr>
<tr class="odd">
<td>Traffic Manager</td>
<td><div class="content-wrapper">
<pre><code>-Dprofile=traffic-manager</code></pre>
<p><br />
</p>
</div></td>
<td><div class="content-wrapper">
<p>Only starts the features relevant to the Traffic Manager component of the API Manager.</p>
<p>The Traffic Manager helps users to regulate API traffic, make APIs and applications available to consumers at different service levels, and secure APIs against security attacks. The Traffic Manager features a dynamic throttling engine to process throttling policies in real-time, including rate limiting of API requests.</p>
</div></td>
</tr>
<tr class="even">
<td>API Publisher</td>
<td><pre><code>-Dprofile=api-publisher</code></pre></td>
<td><div class="content-wrapper">
<p>Only starts the front end/backend features relevant to the API Publisher.</p>
<p><br />
</p>
</div></td>
</tr>
<tr class="odd">
<td>Developer Portal</td>
<td><pre><code>-Dprofile=api-devportal</code></pre></td>
<td><div class="content-wrapper">
<p>Only starts the front end/backend features relevant to the Developer Portal.</p>
<p><br />
</p>
</div></td>
</tr>
</tbody>
</table>

## Optimizing and starting the server

!!! note
    It is recommended to start the components in the following order: 

    1. Key Manager
    2. Publisher
    3. Developer Portal
    4. Traffic Manager
    5. Gateway

Create an optimized distribution for a particular API-M profile.

1.  Run the `<API-M_HOME>/bin/profileSetup.sh` script or `<API-M_HOME>/bin/profileSetup.bat` script based on your operating system, with the profile flag.

    **Sample commands**
    ``` java
    sh <API-M_HOME>/bin/profileSetup.sh  -Dprofile=<preferred-profile>
    ```
    **Example**
    
    For example you can execute the profile setup for the Publisher profile as follows:

    ``` java
    sh <API-M_HOME>/bin/profileSetup.sh  -Dprofile=api-publisher
    ```

2.  Start the server with the specified profile. 

     A sample command is shown below.

    **Sample commands**
    ``` java
    sh <API-M_HOME>/bin/wso2server.sh -Dprofile=<preferred-profile>
    ```
    **Example**
    
    For example you can start the Publisher profile as follows:

    ``` java
    sh <API-M_HOME>/bin/wso2server.sh -Dprofile=api-publisher
    ```

    ??? info "Click here to see the sample output when you start the Publisher profile."

        ``` java
            Starting to optimize API Manager for the API Publisher profile
            [2018-06-19 17:36:08:045] INFO - Disabled the <DataPublisher> from api-manager.xml file
            [2018-06-19 17:36:08:055] INFO - Disabled the <JMSConnectionDetails> from api-manager.xml file
            [2018-06-19 17:36:08:066] INFO - Disabled the <transportSender name="ws" class="org.wso2.carbon.websocket.transport.WebsocketTransportSender"> from axis2.xml file
            [2018-06-19 17:36:08:072] INFO - Disabled the <transportSender name="wss" class="org.wso2.carbon.websocket.transport.WebsocketTransportSender"> from axis2.xml file
            [2018-06-19 17:36:08:074] INFO - Removed the WebSocketInboundEndpoint.xml file from ../repository/deployment/server/synapse-configs/default/inbound-endpoints/
            [2018-06-19 17:36:08:076] INFO - Removed the SecureWebSocketInboundEndpoint.xml file from ../repository/deployment/server/synapse-configs/default/inbound-endpoints/
            [2018-06-19 17:36:08:082] INFO - Removed the authenticationendpoint.war file from ../repository/deployment/server/webapps
            [2018-06-19 17:36:08:085] INFO - Removed the api#am#admin#v0.13.war file from ../repository/deployment/server/webapps
            [2018-06-19 17:36:08:087] INFO - Removed the throttle#data#v1.war file from ../repository/deployment/server/webapps
            [2018-06-19 17:36:08:090] INFO - Removed the oauth2.war file from ../repository/deployment/server/webapps
            [2018-06-19 17:36:08:093] INFO - Removed the am#sample#pizzashack#v1.war file from ../repository/deployment/server/webapps
            [2018-06-19 17:36:08:097] INFO - Removed the api#identity#consent-mgt#v1.0.war file from ../repository/deployment/server/webapps
            [2018-06-19 17:36:08:099] INFO - Removed the am#sample#calculator#v1.war file from ../repository/deployment/server/webapps
            [2018-06-19 17:36:08:102] INFO - Removed the api#am#store#v0.13.war file from ../repository/deployment/server/webapps
            [2018-06-19 17:36:08:105] INFO - Removed the client-registration#v0.13.war file from ../repository/deployment/server/webapps
            [2018-06-19 17:36:08:131] INFO - Removed store directory from ../repository/deployment/server/jaggeryapps
            Finished the optimizations
            Starting the server...
        ```





