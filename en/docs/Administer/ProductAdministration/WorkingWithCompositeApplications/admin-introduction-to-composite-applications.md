# admin\_Introduction to Composite Applications

Any WSO2 product can have numerous artifacts such as Axis2 services, data services, endpoints, mediators, registry resources, BPEL workflows etc. Usually, these artifacts are created in a development environment and then moved one by one to staging /production environments. This manual process is time-consuming. Instead, you can bundle the configuration files and artifacts that are in one environment to a Composite Application (C-App) and migrate configurations across environments by deploying the C-App in the new environments.

A C-App is a collection of artifacts deployable on different WSO2 product runtimes. Composite Application Archive (CAR) files, which have the extension .car are used in some deployment options. A C-App and CAR file can have multiple artifacts bundled in it but the runtime that you choose to deploy it in deploys only the artifacts that match its server role. For example, an ESB runtime does not deploy a data service that is bundled in the CAR file unless the default configuration is altered. Therefore, when you deploy a C-App or CAR in a particular WSO2 product, but all its artifacts might not be deployed in that particular product instance.

### The structure of a C-App

A typical C-App contains individual directories for its artifacts, along with a file named `artifacts.xml` , which contains metadata about the artifacts that are inside the C-App. The diagram below depicts the structure of a sample C-App:

![](attachments/126562738/126562741.png)
Given below is a sample `artifacts.xml` file:

![](attachments/126562738/126562740.png)

The sample file contains the name of the C-App, its version and the artifact type according to which the deployer for the artifact is identified. For C-Apps, the artifact type of the sample is " `carbon/application"` . In addition, it also contains details about the artifacts that are bundled in the CAR file. If it's an Axis2 service, the file extension used is `.aar` , if it is a web app, it is `.war` etc. The artifact type changes accordingly. For example, if it's an Axis2 service, the type is " `service/axis2` " and if it's a web app, the type is " `web/application` " or " `webapp/jaxws` ".

### What is the `serverRole` property

Although a C-App can have a collection of different artifacts, the runtime that you choose to deploy it in deploys only the artifacts that match its `serverRole` property. For example, you do not deploy a data service to an ESB runtime. W hen a C-App is being deployed, it reads the `serverRole` property that is in the `<PRODUCT_HOME>/repository/conf/carbon.xml` file and deploys only the artifacts that match the `serverRole` value in the file.

Each product has a different default `serverRoles` property as follows:

| WSO2 product                   | `serverRole` value | Sample artifacts    |
|--------------------------------|---------------------------------------------|---------------------|
| WSO2 Application Server        | ApplicationServer                           | foo.aar, jax-wx.war |
| WSO2 Enterprise Service Bus    | EnterpriseServiceBus                        | proxy.xml           |
| WSO2 Identity Server           | IdentityServer                              |                     |
| WSO2 Data Services Server      | DataServicesServer                          |                     |
| WSO2 Governance Registry       | GovernanceRegistry                          |                     |
| WSO2 Business Activity Monitor | BusinessActivityMonitor                     |                     |
| WSO2 Business Process Server   | BusinessProcessServer                       | my\_bpel.zip        |
| WSO2 Business Rules Server     | BusinessRulesServer                         |                     |
| WSO2 Gadget Server             | GadgetServer                                |                     |

You can set the serverRole property in several ways as follows:

-   [Using the Management Console to set the serverRole property](#admin_IntroductiontoCompositeApplications-UsingtheManagementConsoletosettheserverRoleproperty)
-   [Using the carbon.xml file to set the serverRole property](#admin_IntroductiontoCompositeApplications-Usingthecarbon.xmlfiletosettheserverRoleproperty)
-   [Using a system property to set the serverRole property](#admin_IntroductiontoCompositeApplications-UsingasystempropertytosettheserverRoleproperty)

#### Using the Management Console to set the `serverRole` property

This is the easiest and the most recommended way to configure your server roles.

1.  Log in to the Management Console of your product and click **Server Roles** in the **Configure** tab.
2.  Click **Add New Server Role** , e nter the r ole name and click **Add** . You can add any textual name as a server role without special characters except underscore.
    ![](attachments/41255091/41517078.png)
3.  Note that the newly added server role is displayed in the list.
    ![](attachments/41255091/41517077.png) You can delete the server role by clicking **Delete** .

        !!! tip
    **Tip** : You cannot undo a deletion once performed. Users can even delete a default server role. Once deleted, the server role manager will not pick up the deleted server role from the `carbon.xml` file, next time the server starts.

        !!! tip
    **Tip** : The server roles that you set through the Management Console cannot be changed using other methods. Server roles are stored in the registry when they are configured through the Management Console. Values in the Registry are always given priority over others.


#### Using the `carbon.xml` file to set the `serverRole` property

Find the `serverRoles` element in `<PRODUCT_HOME>/repository/conf/carbon.xml` file. For example,

``` java
    <ServerRoles>
         <Role>DataServicesServer</Role>
    </ServerRoles>
```

You can also set multiple server roles. For example, if you want the server to deploy both Web services and data services, you can assign both roles to it as follows:

``` java
    <ServerRoles>
         <Role>appserver1</Role>
         <Role>dataservices1</Role>
    </ServerRoles>
```

Also, ensure that the current server has capability to deploy Axis2 services and data services. When you deploy a C-App on this server, all artifacts that have the above two server roles get deployed.

#### Using a system property to set the `serverRole` property

You can use the system property `ServerRoles` to specify the server roles that can be acted by the current product instance. When you start the server, pass the server roles as a comma-separated list. For example,

``` java
    sh wso2server.sh -DserverRoles=appserver1,dataservices1
```
