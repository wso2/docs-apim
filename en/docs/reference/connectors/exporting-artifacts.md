## Exporting Integration Logic as a CApp

**CApp (Carbon Application)** is the deployable artifact on the integration runtime. Let us see how we can export integration logic we developed into a CApp along with the connector. 

### Creating Connector Exporter Project

To bundle a Connector into a CApp, a `Connector Exporter Project` is required. 

1. Navigate to **File** -> **New** -> **Other** -> **WSO2** -> **Extensions** -> **Project Types** -> **Connector Exporter Project**.<br> 
  <img src="{{base_path}}/assets/img/integrate/connectors/connector-exporter-project-1.png" title="Add Connector Exporter Project" width="400" alt="Add Connector Exporter Project" />

2. Enter a name for the Connector Exporter Project. 

3. In the next screen select, **Specify the parent from workspace** and select the specific Integration Project you created from the dropdown. 
  <img src="{{base_path}}/assets/img/integrate/connectors/connector-exporter-project-naming.png" title="Naming Connector Exporter Project" width="400" alt="Naming Connector Exporter Project" />

4. Now you need to add the Connector to Connector Exporter Project that you just created. Right-click the Connector Exporter Project and select, **New** -> **Add Remove Connectors** -> **Add Connector** -> **Add from Workspace** -> **Connector**

5. Once you are directed to the workspace, it displays all the connectors that exist in the workspace. You can select the relevant connector and click **Ok**. 
  <img src="{{base_path}}/assets/img/integrate/connectors/adding-connector-to-exporter-project-3.png" title="Selecting Connector from Workspace" width="400" alt="Selecting Connector from Workspace" />

### Creating a Composite Application Project

To export the `Integration Project` as a CApp, a `Composite Application Project` needs to be created. Usually, when an Integration project is created, this project can be created as part of that project by Integration Studio. If not, you can specifically create it by navigating to  **File** -> **New** -> **Other** -> **WSO2** -> **Distribution** -> **Composite Application Project**. 

### Exporting the Composite Application Project

1. Right-click the Composite Application Project and click **Export Composite Application Project**.

  <img src="{{base_path}}/assets/img/integrate/connectors/capp-project1.png" title="Export as a Carbon Application" width="400" alt="Export as a Carbon Application" />

2. Select an **Export Destination** where you want to save the .car file. 

3. In the next **Create a deployable CAR file** screen, select both the created Integration Project and the Connector Exporter Project to save and click **Finish**. The CApp is created at the specified location provided at the previous step. 
  <img src="{{base_path}}/assets/img/integrate/connectors/saving-projects.png" title="Create a deployable CAR file" width="600" alt="Create a deployable CAR file" />
