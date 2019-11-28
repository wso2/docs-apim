# Product Profiles

When a WSO2 product starts, it starts all components, features and related artifacts bundled with it. Multi-profile support allows you to run the product on a selected profile so that only the features specific to that profile along with common features start up with the server.

!!! tip
Starting a product on a preferred profile only blocks/allows the relevant OSGI bundles. As a result, even if you start the server on a profile such as the `api-devportal` for example, you can still access the API Publisher web application.

!!! info
OSGI Bundle

OSGI bundle is a tightly coupled, dynamically loadable collection of classes, jars, and configuration files that explicitly declare their external dependencies (if any). In OSGi, a bundle is the primary deployment format. Bundles are applications that are packaged in JARs, and can be installed, started, stopped, updated, and removed.


-   [API-M Profiles](#ProductProfiles-API-MProfiles)
-   [Starting an API-M profile](#ProductProfiles-StartinganAPI-Mprofile)
    -   [Method 1- Optimizing before starting the server](#ProductProfiles-Method1-Optimizingbeforestartingtheserver)
    -   [Method 2 - Optimizing while starting the server](#ProductProfiles-Method2-Optimizingwhilestartingtheserver)
-   [How multi-profiling works](#ProductProfiles-Howmulti-profilingworks)

### API-M Profiles

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
<p>You use this when the API Gateway acts as a worker node in a cluster. This profile starts the backend features for data processing and communicating with the manager node.</p>
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

### Starting an API-M profile

You can start an API Manager profile in the following methods, based on your requirement

-   [Method 1- Optimizing before starting the server](#ProductProfiles-Method1-Optimizingbeforestartingtheserver)
-   [Method 2 - Optimizing while starting the server](#ProductProfiles-Method2-Optimizingwhilestartingtheserver)

!!! info
It is recommended to start the components in the following order: Key Manager, Publisher, Developer Portal, Traffic Manager, and Gateway.


#### Method 1- Optimizing before starting the server

Create an optimized distribution for a particular API-M profile.

1.  Run the `<PRODUCT_HOME>/bin/profileSetup.sh` script or `<PRODUCT_HOME>/bin/profileSetup.bat` script based on your operating system, with the profile flag.

    -   [**Sample commands**](#079827d8c1d84ff1819b83512255f00e)
    -   [**Example**](#94cb7f5f7ca345b38935a151bce7ade1)

    ``` java
        sh <PRODUCT_HOME>/bin/profileSetup.sh  -Dprofile=<preferred-profile>
    ```

    **Starting the Publisher profile**

    ``` java
            sh <PRODUCT_HOME>/bin/profileSetup.sh  -Dprofile=api-publisher 
    ```

2.  Start the server with the specified profile. A sample command is shown below.

    -   [**Sample commands**](#1caa2187ee11400988eed8f095bd6639)
    -   [**Example**](#9626a09cc8974d19b3c7ce86dfdb3ed4)

    ``` java
            sh <PRODUCT_HOME>/bin/wso2server.sh -Dprofile=<preferred-profile>
    ```

    **Starting the Publisher profile**

    ``` java
            sh <PRODUCT_HOME>/bin/wso2server.sh -Dprofile=api-publisher
    ```

#### Method 2 - Optimizing while starting the server

1.  Start the server using the script based on your operating system, using the command given below.

    -   [**Sample commands**](#8480e9325dec42eb82f98b679afa8816)
    -   [**Example**](#88dfa68c4bb148ac8afc74a1fd49607c)

    ``` java
            sh <PRODUCT_HOME>/bin/wso2server.sh --optimize -Dprofile=<preferred-profile>
    ```

    **Starting the Publisher profile**

    ``` java
            sh <PRODUCT_HOME>/bin/wso2server.sh --optimize -Dprofile=api-publisher
    ```

    ![](images/icons/grey_arrow_down.png){.expand-control-image} Click here to see the sample output when you start the Publisher profile

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

!!! note
Note that registry indexing for the Traffic Manager and Gateway worker profiles are disabled when you run the profile optimization. To enable registry indexing, open the `<PRODUCT_HOME>/repository/conf/registry.xml` file. Set the value of the `<startIndexing>` parameter in the `<indexingConfiguration>` section to true as shown below.

``` java
    <indexingConfiguration>
    <startIndexing>true</startIndexing>
    . . .
    </indexingConfiguration>
```


### How multi-profiling works

Starting a product on a preferred profile starts only a subset of features bundled in the product. In order to identify what feature bundles apply to which profile, each product maintains a set of `bundles.info` files in the `<PRODUCT_HOME>/repository/components/<profile-name>/configuration/org.eclipse.equinox.simpleconfigurator` directories. The `bundles.info` files contain references to the actual bundles. Note that `<profile-name>` in the directory path refers to the name of the profile. For example, when there's a product profile named webapp, references to all the feature bundles required for webapp profile to function are in a `bundles.info` file saved in the `<PRODUCT_HOME>/repository/components/webapp/configuration/org.eclipse.equinox.simpleconfigurator` directory.

Note that when you start the server without using a preferred profile, the server refers to the `<PRODUCT_HOME>/repository/components/default/configuration/org.eclipse.equinox.simpleconfigurator/bundles.info` file by default. This file contains references to all bundles in the `<PRODUCT_HOME>/repository/components/plugins` directory, which is where all components/bundles of a product are saved.


