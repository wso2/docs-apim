# admin\_Deploying Composite Applications in the Server

After packaging artifacts into a Composite Application, you can deploy it to the server [using the Tooling interface](#admin_DeployingCompositeApplicationsintheServer-DeployingusingtheToolinginterface) .

Alternatively, you can also do this using one of the following options:

-   [Deploying using the Tooling interface](#admin_DeployingCompositeApplicationsintheServer-DeployingusingtheToolinginterface)
-   [Deploying via the product's Management Console](#admin_DeployingCompositeApplicationsintheServer-Deployingviatheproduct'sManagementConsole)
-   [Deploying via hot deployment](#admin_DeployingCompositeApplicationsintheServer-Deployingviahotdeployment)
-   [Deploying using the Maven plug-in](#admin_DeployingCompositeApplicationsintheServer-DeployingusingtheMavenplug-in)

**Before you begin** , [package your artifacts into a Composite Application](https://docs.wso2.com/display/ADMIN44x/Packaging+Artifacts+into+Composite+Applications) . Note that the examples here are given using WSO2 ESB, but the steps are the same for any WSO2 server.

!!! info
You need to give the same name, which you gave for the artifact in the `artifacts.xml` file of the Composite Application.


#### 
Deploying using the Tooling interface

!!! info
If you have already added a WSO2 product server instance to Tooling, right click on it in the **Servers** tab, and c lick **Add and Remove...**

![add and remove to an already-added server](/assets/attachments/126562765/126562767.png)

Then, select the Composite Application you want to deploy from the **Available** list, click **Add** to move it into the **Configured** list, and then click **Finish** .

![select the composite app you want to deploy](/assets/attachments/126562765/126562768.png)


1.  In the Tooling interface, navigate to **Developer Studio Dashboard** , and click **Server** under **Add Server** .

2.  In the **Define a New Server** dialog box, expand the WSO2 folder and select the version of your server. In this case, it is `WSO2 ESB Server 5.0.0` .
    ![](/assets/attachments/53121319/53284204.png)3.  Click **Next** . In the CARBON\_HOME field, provide the path to your product's home directory and then click **Next** again. For example,
    ![](/assets/attachments/53121319/53284218.png)4.  Review the default port details for your server and click **Next** .
    Typically, you can leave these unchanged but if you are already running another server on these ports, give unused ports here.

        !!! tip
    **Tip** : See [Default Ports of WSO2 Products](https://docs.wso2.com/display/ADMIN44x/Default+Ports+of+WSO2+Products) for more information.


    ![](/assets/attachments/53121319/53284206.png)
5.  To deploy the C-App project to your server, select **SampleServicesCompositeApplication** from the list, click **Add** to move it into the **Configured** list, and then click **Finish** .

6.  Note that your server is now added to the Tooling interface.

    ![](/assets/attachments/53121319/53285006.png)
7.  On the **Servers** tab, note that the server is currently stopped. Click the "start the server" icon on the **Servers** tab's toolbar. If prompted to save changes to any of the artifact files you created earlier, click **Yes** .
    ![](/assets/attachments/53121319/53285075.png)
8.  As the server starts, the **Console** tab appears. Note messages indicating that the Composite app was successfully deployed. The C-App is now available in the product's Management Console, under **Manage -&gt; Carbon Applications -&gt; List** .

!!! tip
If you want to remove a Composite Application, which you already deployed, click the WSO2 product server instance in the **Servers** tab to expand it, right-click on the Composite Application, which you want to remove, and click **Remove** as shown below.

![remove a deployed Composite Application](/assets/attachments/126562765/126562769.png)


If you do not use the Tooling interface to deploy your artifacts to the server, you can alternatively do that using the product's Management Console or via hot deployment.

#### Deploying via the product's Management Console

You can also deploy a C-App via the product's Management Console. To do this you will first need to [create a CAR file](https://docs.wso2.com/display/ADMIN44x/Packaging+Artifacts+into+Composite+Applications#PackagingArtifactsintoCompositeApplications-CreatingaCompositeApplicationArchive(CAR)file) and then deploy the created CAR file as follows:

1.  Click the **Main** tab on the Management Console, go to **Manage** -&gt; **Carbon Applications** and then click **Add** .

    The **Add Carbon Applications** screen appears.

2.  Click **Choose File** , select your CAR file and click **Upload** .
    The CAR files that you upload are dropped to the `<PRODUCT_HOME>/tmp/carbonapps/{tenant-ID}/` directory.

3.  Refresh the browser to see that the CAR file has been deployed.

4.  Click the **Main** tab on the Management Console, go to **Manage** -&gt; **Carbon Applications** and then click **List** . If successfully deployed, the CAR file appears here.

!!! tip
It is not recommended to use the Management Console to edit the artifacts that have been deployed to your server using a CAR file.


#### Deploying via hot deployment

You can deploy a C-App by d irectly saving it to the `<PRODUCT_HOME>/repository/deployment/server/carbonapps/deployment/` directory. If you are running products in a cluster, use the [Deployment Synchronizer](http://docs.wso2.org/display/CLUSTER44x/Configuring+Deployment+Synchronizer) to keep the configurations on all nodes of the cluster in sync.

#### Deploying using the Maven plug-in

1.  Open the `pom.xml` file of the **Composite Application Project** . In the **Source** view, search for `maven-car-deploy-plugin` under the `<plugins>` element and edit the `<trustStorePath>` so that it points to the actual location within the product folder structure. See below for an example:

    ``` xml
        <plugin>
           <groupId>org.wso2.maven</groupId>
           <artifactId>maven-car-deploy-plugin</artifactId>
           <version>1.1.1</version>
           <extensions>true</extensions>
           <configuration>
              <carbonServers>
                  <CarbonServer>
                      <trustStorePath>/Users/Gillian/ESB/wso2esb-5.0.0/repository/resources/security/wso2carbon.jks</trustStorePath>
                      <trustStorePassword>wso2carbon</trustStorePassword>
                      <trustStoreType>JKS</trustStoreType>
                      <serverUrl>https://localhost:9443</serverUrl>
                      <userName>admin</userName>
                      <password>admin</password>
                      <operation>deploy</operation>
                  </CarbonServer>
                </carbonServers>
            </configuration>
        </plugin>
    ```

2.  Using command prompt, navigate to the **ESB Config Project** folder and build the project using the following command:

    ``` xml
            mvn clean install
    ```

        !!! info
    If you have more than one project bundled in your C-App project, you need to build each of those projects using the above command.


3.  Build and deploy the **Composite Application Project** using one of the following:

    -   Open the `pom.xml` file of the **Composite Application Project** . In the **Source** view, add the following line in the `<properties>` section:

        ``` xml
                <maven.car.deploy.skip>true</maven.car.deploy.skip>
        ```

        OR

    -   Using command prompt, navigate to the **Composite Application Project** folder and use the following command:

        ``` xml
                    mvn clean deploy -Dmaven.deploy.skip=true -Dmaven.car.deploy.skip=false 
        ```

        When you access the ESB management console, you can see the artifacts in your Composite Application Project are deployed to your ESB server.

                !!! info
        When you deploy a Composite Application, the ESB artifacts are deployed in the below order.

        1.  Local entries
        2.  Endpoints
        3.  Sequences
        4.  Message stores
        5.  Templates
        6.  Proxy services
        7.  Tasks
        8.  Events
        9.  Message processors
        10. APIs
        11. Inbound endpoints
        12. Other types


        ![](/assets/attachments/126562765/126562766.png){height="250"}

!!! tip
When **deleting a C-App** , it is not recommended to delete individual artifacts of the CAR file. The recommended practice is to delete the entire C-App.

You can delete a C-App from the Management Console or by deleting the CAR archive from `<PRODUCT_HOME>/repository/carbonapps/{tenant-ID}` . `{tenant-ID}` is 0 in a single-tenant environment as 0 is the super tenant ID. Manual undeployment in a multi-tenanted environment is not recommended if you are unaware of the tenant ID.


