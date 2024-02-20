# Running the API-M Profiles

When the API-M server is started, all components, features, and related artifacts bundled with it are started. Multi-profile support allows you to run the product on a selected profile so that only the features specific to that profile along with common features startup with the server.

!!! Tip
    Starting a product on a preferred profile only blocks/allows the relevant OSGI bundles. As a result, even if you start the server on a profile, you can still access the API Publisher web application.
    
    An **OSGI Bundle** is a tightly coupled, dynamically loadable collection of classes, jars, and configuration files that explicitly declare their external dependencies (if any). In OSGi, a bundle is the primary deployment format. Bundles are applications that are packaged in JARs and can be installed, started, stopped, updated, and removed.

## Before you begin

See the following topics to understand how API-M profiles are used in a distributed deployment:

-   [Distributed Deployment - Overview]({{base_path}}/install-and-setup/setup/distributed-deployment/understanding-the-distributed-deployment-of-wso2-api-m)
-   [Configuring a Distributed API-M Deployment]({{base_path}}/install-and-setup/setup/distributed-deployment/deploying-wso2-api-m-in-a-distributed-setup)

## Profile startup commands

Listed below are the startup commands for starting each of the API-M profiles.

<table>
    <tr>
        <th>
            Profile
        </td>
        <th>
            Command
        </td>
    </tr>
    <tr>
        <td>
            Gateway Profile
        </td>
        <td><pre><code>-Dprofile=gateway-worker</code></pre></td>
    </tr>
    <tr>
        <td>
            Control Plane Profile
        </td>
        <td><pre><code>-Dprofile=control-plane</code></pre></td>
    </tr>
    <tr>
        <td>
            Traffic Manager Profile
        </td>
        <td><pre><code>-Dprofile=traffic-manager</code></pre></td>
    </tr>
</table>


## Starting an API-M profile

You can start an API Manager profile in the following methods, based on your requirement.
    
### Method 1- Optimizing before starting the server

!!! note
    Make sure to update the API-M pack to the latest using the "WSO2 in-place updates tool" before running the profile
    optimization. If you update the server after running the profile optimization, you may need to follow [Method 2](#method-2-optimizing-while-starting-the-server), as
    the updates would have fetched irrelevant files for this profile


Create an optimized distribution for a particular API-M profile.

1.  Run the `<API-M_HOME>/bin/profileSetup.sh` script or `<API-M_HOME>/bin/profileSetup.bat` script based on your operating system, with the profile flag.

    ``` tab="Sample Format"
    sh <API-M_HOME>/bin/profileSetup.sh  -Dprofile=<preferred-profile>
    ```
    
    ``` tab="Example:Linux/Solaris/MacOS"
    sh <API-M_HOME>/bin/profileSetup.sh  -Dprofile=gateway-worker
    ```
    
    ``` tab="Example:Windows"
    <PRODUCT_HOME>/bin/profileSetup.bat -Dprofile=gateway-worker
    ```
    
2. Copy the respective database connector JAR to `/lib` directory.
   
     For example, if you are using a MySQL database,

     1. Download the MySQL connector JAR file and extract it.
     
     2. Copy it to the `<API-M_HOME>/repository/components/lib/` directory.

3. Create the required databases, namely the API-M database (`apimgtdb` also known as `WSO2_AM_DB`) and the shared database (`WSO2_SHARED_DB` also known as `shareddb`).

4. Update the default DB configurations to match your environment.

     Change the following DB configurations, which are in the `<API-M_HOME>/repository/conf/deployment.toml` file.

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

    ``` tab="Sample Format"
    sh <API-M_HOME>/bin/api-manager.sh -Dprofile=<preferred-profile>
    ```
    
    ``` tab="Example:Linux/Solaris/MacOS"
    sh <API-M_HOME>/bin/api-manager.sh -Dprofile=gateway-worker
    ```
    
    ``` tab="Example:Windows"
    <API-M_HOME>/bin/api-manager.bat -Dprofile=gateway-worker
    ```    

### Method 2 - Optimizing while starting the server

Start the server using the script based on your operating system, using the command given below.

!!! warning
    Before running this command you are expected to do the configuration changes in the `deployment.toml` file manually in the pack.

``` tab="Sample Format"
sh <PRODUCT_HOME>/bin/api-manager.sh --optimize -Dprofile=<preferred-profile>
```

``` tab="Example:Linux/Solaris/MacOS"
sh <PRODUCT_HOME>/bin/api-manager.sh --optimize -Dprofile=gateway-worker
```

``` tab="Example:Windows"
<PRODUCT_HOME>/bin/api-manager.bat --optimize -Dprofile=gateway-worker
```  

??? info "Click here to see the sample output when you optimize the server for Gateway profile while starting in Gateway worker profile."
    ``` java
    [2023-02-23 16:46:52] INFO - Starting to optimize API Manager for the Gateway worker profile
    [2023-02-23 16:46:52] INFO - Starting to optimize configs in deployment.toml
    [2023-02-23 16:46:52] INFO - Renamed the existing ../repository/conf/deployment.toml file as deployment.toml.backup
    [2023-02-23 16:46:52] INFO - Copied the existing ../repository/resources/conf/deployment-templates/gateway-worker.toml file as ../repository/conf/deployment.toml
    [2023-02-23 16:46:52] INFO - Renamed the existing ../repository/resources/conf/templates/repository/conf/tomcat/carbon/WEB-INF/web.xml.j2 file as web.xml.j2.backup
    [2023-02-23 16:46:53] INFO - Renamed the existing ../repository/resources/conf/templates/repository/conf/tomcat/carbon/WEB-INF/web_TM_GW.xml.j2 file as web.xml.j2
    [2023-02-23 16:46:53] INFO - Removed the file ../repository/resources/conf/templates/repository/deployment/server/webapps/authenticationendpoint/WEB-INF/web.xml.j2
    [2023-02-23 16:46:53] INFO - Removed the file ../repository/resources/conf/templates/repository/deployment/server/webapps/accountrecoveryendpoint/WEB-INF/web.xml.j2
    [2023-02-23 16:46:53] INFO - Removed the api#identity#consent-mgt#v1.0.war file from ../repository/deployment/server/webapps
    [2023-02-23 16:46:53] INFO - Removed the publisher file from ../repository/deployment/server/webapps
    [2023-02-23 16:46:53] INFO - Removed the oauth2.war file from ../repository/deployment/server/webapps
    [2023-02-23 16:46:53] INFO - Removed the api#am#devops#v0.war file from ../repository/deployment/server/webapps
    [2023-02-23 16:46:53] INFO - Removed the admin file from ../repository/deployment/server/webapps
    [2023-02-23 16:46:53] INFO - Removed the api#am#devportal.war file from ../repository/deployment/server/webapps
    [2023-02-23 16:46:53] INFO - Removed the api#am#service-catalog#v1.war file from ../repository/deployment/server/webapps
    [2023-02-23 16:46:53] INFO - Removed the api#identity#recovery#v0.9.war file from ../repository/deployment/server/webapps
    [2023-02-23 16:46:53] INFO - Removed the api#identity#oauth2#v1.0.war file from ../repository/deployment/server/webapps
    [2023-02-23 16:46:53] INFO - Removed the internal#data#v1.war file from ../repository/deployment/server/webapps
    [2023-02-23 16:46:53] INFO - Removed the api#am#publisher.war file from ../repository/deployment/server/webapps
    [2023-02-23 16:46:53] INFO - Removed the package.json file from ../repository/deployment/server/webapps
    [2023-02-23 16:46:54] INFO - Removed the accountrecoveryendpoint file from ../repository/deployment/server/webapps
    [2023-02-23 16:46:54] INFO - Removed the api#identity#user#v1.0.war file from ../repository/deployment/server/webapps
    [2023-02-23 16:46:54] INFO - Removed the api#identity#oauth2#dcr#v1.1.war file from ../repository/deployment/server/webapps
    [2023-02-23 16:46:54] INFO - Removed the am#sample#calculator#v1.war file from ../repository/deployment/server/webapps
    [2023-02-23 16:46:54] INFO - Removed the client-registration#v0.17.war file from ../repository/deployment/server/webapps
    [2023-02-23 16:46:54] INFO - Removed the api#am#admin.war file from ../repository/deployment/server/webapps
    [2023-02-23 16:46:54] INFO - Removed the lerna.json file from ../repository/deployment/server/webapps
    [2023-02-23 16:46:54] INFO - Removed the devportal file from ../repository/deployment/server/webapps
    [2023-02-23 16:46:54] INFO - Removed the keymanager-operations.war file from ../repository/deployment/server/webapps
    [2023-02-23 16:46:54] INFO - Removed the authenticationendpoint file from ../repository/deployment/server/webapps
    Finished the optimizations
    ```


Passing the `--skipConfigOptimization` option allows you to preserve the configurations that you previously manually applied while optimizing the profile.

``` tab="Sample Format"
sh <PRODUCT_HOME>/bin/api-manager.sh --optimize -Dprofile=<preferred-profile> --skipConfigOptimization
```

``` tab="Example:Linux/Solaris/MacOS"
sh <PRODUCT_HOME>/bin/api-manager.sh --optimize -Dprofile=gateway-worker --skipConfigOptimization    
```

``` tab="Example:Windows"
<PRODUCT_HOME>/bin/api-manager.bat --optimize -Dprofile=gateway-worker --skipConfigOptimization
```  

!!! Note
    Profile optimization using scripts is the recommended approach. Manually optimizing and including the usage of the `--skipConfigOptimization` option should be done only in the cases where it can't be avoided. 
