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

### Starting an API-M profile

You can start an API Manager profile in the following methods, based on your requirement

-   [Method 1 - Optimizing before starting the server](#method-1-optimizing-before-starting-the-server)
-   [Method 2 - Optimizing while starting the server](#method-2-optimizing-while-starting-the-server)

!!! note
    It is recommended to start the components in the following order: 

    1. Traffic Manager
    2. Key Manager
    3. Publisher
    4. Developer Portal
    5. Gateway
    
#### Method 1- Optimizing before starting the server

Create an optimized distribution for a particular API-M profile.

1.  Run the `<API-M_HOME>/bin/profileSetup.sh` script or `<API-M_HOME>/bin/profileSetup.bat` script based on your operating system, with the profile flag.

    ``` tab="Sample Format"
    sh <API-M_HOME>/bin/profileSetup.sh  -Dprofile=<preferred-profile>
    ```
    
    ``` tab="Example:Linux/Solaris/MacOS"
    sh <API-M_HOME>/bin/profileSetup.sh  -Dprofile=api-publisher
    ```
    
    ``` tab="Example:Windows"
    <PRODUCT_HOME>/bin/profileSetup.bat -Dprofile=api-publisher
    ```
    
2. Copy the respective databasee connector JAR to `/lib` directory.
   
     For example, if you are using a MySQL database,

     1. Download the MySQL connector JAR file and extract it.
     
     2. Copy it to the `<API-M_HOME>/repository/components/lib/` directory.

3. Create the required databases, namely the API-M database (`apimgtdb` also known as `WSO2_AM_DB`) and the shared database (`WSO2_SHARED_DB` also known as `shareddb`).

4. Update the default DB configurations to match your environment.

     Change the following DB configurations, which is in the `<API-M_HOME>/repository/conf/deployment.toml` file.

     ```
     [database.apim_db]
     type = "mysql"
     hostname = "localhost"
     name = "apimgt_db"
     port = "3306"
     username = "root"
     password = "root"

     [database.shared_db]
     type = "mysql"
     hostname = "localhost"
     name = "shared_db"
     port = "3306"
     username = "root"
     password = "root"
     ```

5.  Start the server with the specified profile.

    The pack in place is updated after the initial optimization, and the product pack would have fetched irrelevant files for this profile. The `--optimize` option is used to optimize the pack again.
    
    Configuration optimization is one of the steps in profile optimization process. This replaces the `deployment.toml` file with a pre-configured profile-specific TOML file that exists in the pack. If required, you can skip this step from the profile optimization process via passing the additional `--skipConfigOptimization` option. This prevents the existing `deployment.toml` file in the pack from being overridden.  
    
    ``` tab="Sample Format"
    sh <API-M_HOME>/bin/wso2server.sh -Dprofile=<preferred-profile> --optimize --skipConfigOptimization
    ```
    
    ``` tab="Example:Linux/Solaris/MacOS"
    sh <API-M_HOME>/bin/wso2server.sh -Dprofile=api-publisher --optimize --skipConfigOptimization
    ```
    
    ``` tab="Example:Windows"
    <PRODUCT_HOME>/bin/wso2server.bat -Dprofile=api-publisher --optimize --skipConfigOptimization
    ```    

#### Method 2 - Optimizing while starting the server

1.  Start the server using the script based on your operating system, using the command given below.

    ``` tab="Sample Format"
    sh <PRODUCT_HOME>/bin/wso2server.sh --optimize -Dprofile=<preferred-profile>
    ```
    
    ``` tab="Example:Linux/Solaris/MacOS"
    sh <PRODUCT_HOME>/bin/wso2server.sh --optimize -Dprofile=api-publisher
    ```
    
    ``` tab="Example:Windows"
    <PRODUCT_HOME>/bin/wso2server.bat --optimize -Dprofile=api-publisher
    ```  
    

    ??? info "Click here to see the sample output when you optimize the server for Publisher profile while starting in Publisher profile."

        ``` java
        [2020-02-26 11:50:39] INFO - Starting to optimize API Manager for the API Publisher profile
        [2020-02-26 11:50:39] INFO - Starting to optimize configs in deployment.toml
        [2020-02-26 11:50:39] INFO - Renamed the existing ../repository/conf/deployment.toml file as deployment.toml
                    .backup
        [2020-02-26 11:50:39] INFO - Renamed the existing ../repository/resources/conf/deployment-templates/api-publisher.toml file as deployment.toml
        [2020-02-26 11:50:39] INFO - Removed the WebSocketInboundEndpoint.xml file from ../repository/deployment/server/synapse-configs/default/inbound-endpoints/
        [2020-02-26 11:50:39] INFO - Removed the SecureWebSocketInboundEndpoint.xml file from ../repository/deployment/server/synapse-configs/default/inbound-endpoints/
        [2020-02-26 11:50:39] INFO - Removed the api#identity#consent-mgt#v1.0.war file from ../repository/deployment/server/webapps
        [2020-02-26 11:50:39] INFO - Removed the throttle#data#v1.war file from ../repository/deployment/server/webapps
        [2020-02-26 11:50:39] INFO - Removed the am#sample#pizzashack#v1.war file from ../repository/deployment/server/webapps
        [2020-02-26 11:50:39] INFO - Removed the api#am#store#v0.16.war file from ../repository/deployment/server/webapps
        [2020-02-26 11:50:39] INFO - Removed the api#am#store.war file from ../repository/deployment/server/webapps
        [2020-02-26 11:50:39] INFO - Removed the api#identity#recovery#v0.9.war file from ../repository/deployment/server/webapps
        [2020-02-26 11:50:39] INFO - Removed the api#identity#user#v1.0.war file from ../repository/deployment/server/webapps
        [2020-02-26 11:50:39] INFO - Removed the api#identity#oauth2#dcr#v1.1.war file from ../repository/deployment/server/webapps
        [2020-02-26 11:50:39] INFO - Removed the am#sample#calculator#v1.war file from ../repository/deployment/server/webapps
        [2020-02-26 11:50:39] INFO - Removed devportal directory from ../repository/deployment/server/jaggeryapps
        Finished the optimizations
        Starting the server...
        JAVA_HOME environment variable is set to /Library/Java/JavaVirtualMachines/jdk1.8.0_152.jdk/Contents/Home
        CARBON_HOME environment variable is set to /Users/samithac/WSO2/RND-Projects/16-profile-optimization-fix/setup/wso2am-3.1.0-beta
        Using Java memory options: -Xms256m -Xmx1024m
        [2020-02-26 11:50:41,936]  INFO {org.wso2.config.mapper.ConfigParser} - Applying Configurations upon new Templates
        [2020-02-26 11:50:41,938]  WARN {org.wso2.config.mapper.ConfigParser} - Overriding files in configuration directory /Users/samithac/WSO2/RND-Projects/16-profile-optimization-fix/setup/wso2am-3.1.0-beta
        [2020-02-26 11:50:42,759]  INFO {org.wso2.config.mapper.ConfigParser} - Writing Metadata Entries...
        [2020-02-26 11:50:47,604]  INFO - CarbonCoreActivator Starting WSO2 Carbon...
        [2020-02-26 11:50:47,612]  INFO - CarbonCoreActivator Operating System : Mac OS X 10.14.6, x86_64
        [2020-02-26 11:50:47,613]  INFO - CarbonCoreActivator Java Home        : /Library/Java/JavaVirtualMachines/jdk1.8.0_152.jdk/Contents/Home/jre
        [2020-02-26 11:50:47,613]  INFO - CarbonCoreActivator Java Version     : 1.8.0_152
        ```
    
    ``` tab="Sample Format"
    sh <PRODUCT_HOME>/bin/wso2server.sh --optimize -Dprofile=<preferred-profile> --skipConfigOptimization
    ```
    
    ``` tab="Example:Linux/Solaris/MacOS"
    sh <PRODUCT_HOME>/bin/wso2server.sh --optimize -Dprofile=api-publisher --skipConfigOptimization    
    ```
    
    ``` tab="Example:Windows"
    <PRODUCT_HOME>/bin/wso2server.bat --optimize -Dprofile=api-publisher --skipConfigOptimization
    
    ```  
        
Before running this command (with the `--skipConfigOptimization` option) you are expected to do the configuration 
changes in the `deployment.toml` file manually in the pack. Passing this option allows you to preserve the configurations that you previously manually applied while optimizing the profile.

!!! note
    Profile optimization using scripts is the recommended approach. Manually optimizing and including the usage of the `--skipConfigOptimization` option should be done only in the cases where it can't be avoided. 