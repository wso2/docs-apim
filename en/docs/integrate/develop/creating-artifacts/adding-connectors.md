# Adding Connectors

You can develop configurations with connectors, and deploy the configurations and connectors as composite application archive (CAR) files in WSO2 Micro Integrator using WSO2 Integration Studio.

!!! Info
    In addition to the below methods, you can enable a connector by creating a configuration file in the `MI_HOME/repository/deployment/server/synapse-configs/default/imports` directory with the following configurations. Replace the value of the `name` property with the name of your connector, and name the configuration file `{org.wso2.carbon.connector}<CONNECTOR_NAME>.xml` (e.g., `{org.wso2.carbon.connector}salesforce.xml`).
    ```xml
    <import xmlns="http://ws.apache.org/ns/synapse"
            name="salesforce"
            package="org.wso2.carbon.connector"
            status="enabled"/>
    ```

## Instructions

See the topics given below.

### Importing Connectors

Follow the steps below to import connectors into WSO2 Integration Studio:

1.  If you have already created an [ESB Config project]({{base_path}}/integrate/develop/create-integration-project/#esb-config-project), right click the ESB Config project where you want to use the connector and click **Add or Remove Connector/Module**.
2.  On the wizard that appears, select **Add Connector/module** and click **Next**.
    -   If you have not downloaded the connector, search on the required connector in **WSO2 Connector Store** view, and click on the download icon to import the connector into the workspace. Then, click on **Finish**.
    -   If you have already downloaded the connectors, select the **Add from File System** option and browse to the connector file from the file system. Click **Finish**. The connector is imported into the workspace and available for use with all the projects in the workspace.
3.  After importing the connectors into WSO2 Integration Studio, the connector operations are available in the tool palette. You can drag and drop connector operations into your sequences and proxy services.

### Packaging Connectors

Follow the steps below to create a composite application archive (CAR) file containing the connectors:

1.  Click **File > New > Other** and select **Connector Exporter Project** under **WSO2 > Extensions > Project Types** and click **Next**. 
2.  If you are using a maven multi module project right click on the project and select **New > Connector Exporter**.
3.  Enter a project name and click **Finish**.
4.  Right-click on the created connector exporter project, point to **New** and then click **Add/Remove Connectors**.
5.  Select **Add Connector/module** and click **Next**. Then, click on the **Workspace** option. This will list down the connectors that have been imported into WSO2 Integration Studio.
6.  Select the connector and click **OK** and then click **Finish**.

You can export this connector file as a CAR file just as other ESB artifacts. See [exporting artifacts]({{base_path}}/integrate/develop/exporting-artifacts) for instructions.

### Removing Connectors

Follow the steps below to remove connectors from WSO2 Integration Studio:

1.  Right-click on the relevant ESB Config project and click **Add or Remove Connector/Module**.
2.  On the wizard that appears, select **Remove Connector/module** and click **Next**.
3.  Select the connectors you want to remove and click **Finish**.

## Tutorials

-	See the tutorial on [Connecting Web APIs/Cloud Services]({{base_path}}/integrate/tutorials/using-the-gmail-connector/#importing-the-email-connector-into-wso2-integration-studio).
