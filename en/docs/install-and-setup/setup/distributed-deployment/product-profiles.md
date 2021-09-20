# Running the API-M Profiles

When the API-M server is started, all components, features, and related artifacts bundled with it are started. Multi-profile support allows you to run the product on a selected profile so that only the features specific to that profile along with common features startup with the server.

!!! Tip
    Starting a product on a preferred profile only blocks/allows the relevant OSGI bundles. As a result, even if you start the server on a profile such as the `api-devportal` for example, you can still access the API Publisher web application.
    
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

!!! note
    The `api-publisher` and `api-devportal` profiles have been deprecated.

## Starting an API-M profile

You can start an API Manager profile in the following methods, based on your requirement.
    
### Method 1- Optimizing before starting the server

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

    If the product pack is "in-place updated" using the "WSO2 in-place updates tool" after the initial profile optimization, it would have fetched irrelevant files for this profile. With the `--optimize` option, the pack will be profile-optimized again and it will make sure that the pack will be in a correctly optimized state. 
       
    Configuration optimization is one of the steps in the profile optimization process. This replaces the `deployment.toml` file with a preconfigured profile-specific TOML file that exists in the pack. If required, you can skip this step from the profile optimization process via passing the additional `--skipConfigOptimization` option. This prevents the existing `deployment.toml` file in the pack from being overridden.  
    
    ``` tab="Sample Format"
    sh <API-M_HOME>/bin/api-manager.sh -Dprofile=<preferred-profile> --optimize --skipConfigOptimization
    ```
    
    ``` tab="Example:Linux/Solaris/MacOS"
    sh <API-M_HOME>/bin/api-manager.sh -Dprofile=gateway-worker --optimize --skipConfigOptimization
    ```
    
    ``` tab="Example:Windows"
    <PRODUCT_HOME>/bin/api-manager.bat -Dprofile=gateway-worker --optimize --skipConfigOptimization
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


??? info "Click here to see the sample output when you optimize the server for Publisher profile while starting in Publisher profile."

    ``` java
    [2021-08-26 11:30:57] INFO - Starting to optimize API Manager for the Gateway worker profile
    [2021-08-26 11:30:57] INFO - Starting to optimize configs in deployment.toml
    [2021-08-26 11:30:57] INFO - Renamed the existing ../repository/conf/deployment.toml file as deployment.toml.backup
    [2021-08-26 11:30:58] INFO - Copied the existing ../repository/resources/conf/deployment-templates/gateway-worker.toml file as ../repository/conf/deployment.toml
    [2021-08-26 11:30:58] INFO - Removed the api#am#devportal file from ../repository/deployment/server/webapps
    [2021-08-26 11:30:58] INFO - Removed the api#identity#consent-mgt#v1.0.war file from ../repository/deployment/server/webapps
    [2021-08-26 11:30:58] INFO - Removed api#identity#consent-mgt#v1.0 directory from ../repository/deployment/server/webapps
    [2021-08-26 11:30:58] INFO - Removed the api#am#service-catalog#v0 file from ../repository/deployment/server/webapps
    [2021-08-26 11:30:58] INFO - Removed the api#identity#oauth2#dcr#v1.1 file from ../repository/deployment/server/webapps
    [2021-08-26 11:30:58] INFO - Removed the api#identity#oauth2#v1.0 file from ../repository/deployment/server/webapps
    [2021-08-26 11:30:58] INFO - Removed the oauth2.war file from ../repository/deployment/server/webapps
    [2021-08-26 11:30:58] INFO - Removed oauth2 directory from ../repository/deployment/server/webapps
    [2021-08-26 11:30:58] INFO - Removed the api#am#gateway#v2 file from ../repository/deployment/server/webapps
    [2021-08-26 11:30:58] INFO - Removed the am#sample#calculator#v1 file from ../repository/deployment/server/webapps rm: ../repository/deployment/server/webapps/oauth2: No such file or directory
    [2021-08-26 11:30:58] INFO - Removed the oauth2 file from ../repository/deployment/server/webapps
    [2021-08-26 11:30:58] INFO - Removed the internal#data#v1 file from ../repository/deployment/server/webapps
    [2021-08-26 11:30:58] INFO - Removed the api#am#devportal.war file from ../repository/deployment/server/webapps
    [2021-08-26 11:30:58] INFO - Removed the am#sample#pizzashack#v1 file from ../repository/deployment/server/webapps rm: ../repository/deployment/server/webapps/api#identity#consent-mgt#v1.0: No such file or directory
    [2021-08-26 11:30:58] INFO - Removed the api#identity#consent-mgt#v1.0 file from ../repository/deployment/server/webapps
    [2021-08-26 11:30:58] INFO - Removed the api#am#admin file from ../repository/deployment/server/webapps
    [2021-08-26 11:30:58] INFO - Removed the api#identity#recovery#v0.9.war file from ../repository/deployment/server/webapps
    [2021-08-26 11:30:58] INFO - Removed api#identity#recovery#v0.9 directory from ../repository/deployment/server/webapps
    [2021-08-26 11:30:58] INFO - Removed the api#identity#oauth2#v1.0.war file from ../repository/deployment/server/webapps
    [2021-08-26 11:30:58] INFO - Removed the api#am#service-catalog#v0.war file from ../repository/deployment/server/webapps
    [2021-08-26 11:30:58] INFO - Removed the internal#data#v1.war file from ../repository/deployment/server/webapps rm: ../repository/deployment/server/webapps/api#identity#recovery#v0.9: No such file or directory
    [2021-08-26 11:30:58] INFO - Removed the api#identity#recovery#v0.9 file from ../repository/deployment/server/webapps
    [2021-08-26 11:30:58] INFO - Removed the api#am#publisher.war file from ../repository/deployment/server/webapps
    [2021-08-26 11:30:58] INFO - Removed api#am#publisher directory from ../repository/deployment/server/webapps rm: ../repository/deployment/server/webapps/api#am#publisher: No such file or directory
    [2021-08-26 11:30:58] INFO - Removed the api#am#publisher file from ../repository/deployment/server/webapps
    [2021-08-26 11:30:58] INFO - Removed the accountrecoveryendpoint file from ../repository/deployment/server/webapps
    [2021-08-26 11:30:58] INFO - Removed the keymanager-operations file from ../repository/deployment/server/webapps
    [2021-08-26 11:30:58] INFO - Removed the api#identity#user#v1.0.war file from ../repository/deployment/server/webapps
    [2021-08-26 11:30:59] INFO - Removed api#identity#user#v1.0 directory from ../repository/deployment/server/webapps
    [2021-08-26 11:30:59] INFO - Removed the api#identity#oauth2#dcr#v1.1.war file from ../repository/deployment/server/webapps
    [2021-08-26 11:30:59] INFO - Removed the am#sample#calculator#v1.war file from ../repository/deployment/server/webapps
    [2021-08-26 11:30:59] INFO - Removed the client-registration#v0.17.war file from ../repository/deployment/server/webapps
    [2021-08-26 11:30:59] INFO - Removed client-registration#v0.17 directory from ../repository/deployment/server/webapps rm: ../repository/deployment/server/webapps/client-registration#v0.17: No such file or directory
    [2021-08-26 11:30:59] INFO - Removed the client-registration#v0.17 file from ../repository/deployment/server/webapps
    [2021-08-26 11:30:59] INFO - Removed the api#am#admin.war file from ../repository/deployment/server/webapps rm: ../repository/deployment/server/webapps/api#identity#user#v1.0: No such file or directory
    [2021-08-26 11:30:59] INFO - Removed the api#identity#user#v1.0 file from ../repository/deployment/server/webapps
    [2021-08-26 11:30:59] INFO - Removed the keymanager-operations.war file from ../repository/deployment/server/webapps
    [2021-08-26 11:30:59] INFO - Removed the authenticationendpoint file from ../repository/deployment/server/webapps
    [2021-08-26 11:30:59] INFO - Removed publisher directory from ../repository/deployment/server/jaggeryapps
    [2021-08-26 11:30:59] INFO - Removed admin directory from ../repository/deployment/server/jaggeryapps
    [2021-08-26 11:30:59] INFO - Removed devportal directory from ../repository/deployment/server/jaggeryapps
    Finished the optimizations
    Starting the server...

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
