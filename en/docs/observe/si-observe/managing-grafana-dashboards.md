# Managing Dashboards

WSO2 Streaming Integrator uses Grafana to host and view its pre-configured dashboards that are designed to view statistics relating to its performance as well as streaming activities. The pre-configured dashboards are imported to Grafana as JSON files. Once they are imported, you can organize them in folders, view them, and/or delete them.

## Importing dashboards

To import dashboards, follow the procedure below:

1. Download the required JSON file (i.e., based on the statistics you need to view) from [here](https://github.com/wso2/streaming-integrator/tree/master/modules/distribution/carbon-home/resources/dashboards).

2. Start Grafana and access it via `http://localhost:3000/`.

3. To load a new dashboard, click the plus icon (**+**) in the side panel. Then click **Import**.

4. In the **Import** page, click **Upload .json file**. Then browse and select the .json file of the preconfigured dashboard that you downloaded (i.e., in step 5, substep 1).

5. If required, change the unique identifier displayed in the **Unique Identifier (uid)**.

6. Click **Import**.


## Organizing dashboards in folders

!!! Before you begin:
    Download the related JSON file(s) of one or more dashboards from [here](https://github.com/wso2/streaming-integrator/tree/master/modules/distribution/carbon-home/resources/dashboards), and import them to Grafana. For instructions, see [Importing dashboards](#importing-dashboards).
    
The dashboards you import are saved in the **General** folder by default. If required, you can create a design a folder structure that matches your requirement and save the dashboards in the different folders of the structure based on your categorization of the dashboards.

**Creating new folders**

To create a new folder, follow the procedure below:

1. Start and access Grafana via `http://localhost:3000/`.

2. In the left pane, click the **Dashboards** icon, and then click **Manage**.

    ![Manage Grafana Dashboard]({{base_path}}/assets/img/streaming/managing-grafana-dashboard/manage-grafana-dashboard.png)
    
    This opens the **Dashboards**/**Manage** tab. 
    
    ![Managing Grafana Dashboard]({{base_path}}/assets/img/streaming/managing-grafana-dashboard/managing-dashboards.png)
    
3. Click **New Folder**. In the **Folder Name** field that appears, enter a name (e.g., `cdc-statistics`) for the new folder that you are creating. Then click **Create**.

4. Navigate back to the **Dashboards**/**Manage** tab. You can do this by clicking **Manage Dashboards** in the message that appears in the page of your new folder.

    ![New Folder]({{base_path}}/assets/img/streaming/managing-grafana-dashboard/new-folder-page.png)
    
    The new folder you created appears as shown in the following image.
    
    ![View New Folder]({{base_path}}/assets/img/streaming/managing-grafana-dashboard/view-new-folder.png)
    
**Moving dashboards between folders**

To move selected dashboards to a specific folder, follow the procedure below:

1. In the **Dashboards**/**Manage** tab, select the dashboards you want to move. Then click **Move**.

    ![Move dashboards]({{base_path}}/assets/img/streaming/managing-grafana-dashboard/move-dashboard.png)
    
2. In the **Choose Dashboard Folder** dialog box that appears, select the folder to which you want to move the selected dashboards.
    
    ![Select Dashboard Folder]({{base_path}}/assets/img/streaming/managing-grafana-dashboard/select-dashboard-folder.png)
    
3. Click **Move** to move the selected dashboards. A message appears to inform that the selected dashboards are successfully moved, and the **Dashboards**/**Manage** tab displays the selected dashboards under the folder you selected to move them.


## Deleting dashboards

!!! Before you begin:
    Download the related JSON file(s) of one or more dashboards from [here](https://github.com/wso2/streaming-integrator/tree/master/modules/distribution/carbon-home/resources/dashboards), and import them to Grafana. For instructions, see [Importing dashboards](#importing-dashboards).

In the **Dashboards**/**Manage** tab, select the dashboard(s) you want to delete. Then click **Delete**.

![Move dashboards]({{base_path}}/assets/img/streaming/managing-grafana-dashboard/delete-dashboard.png)

In the message that appears to confirm whether you want to delete the dashboard, click *Delete*.

## Viewing dashboards

To view a dashboard, follow the procedure below:

1. Navigate to the **Dashboards**/**Manage** tab. 

2. To expand the folder that contains the dashboard you want to view, click on it.

    ![Expand Folder]({{base_path}}/assets/img/streaming/managing-grafana-dashboard/expand-folder.png)
 
3. Click on the specific dashboard that you want to view.

    ![View Dashboard]({{base_path}}/assets/img/streaming/managing-grafana-dashboard/view-dashboard.png)

4. Once the dashboard opens, click on the bar shown below to expand it and specify the time range for which you want to view statistics.

    ![Select Time Range]({{base_path}}/assets/img/streaming/managing-grafana-dashboard/view-dashboard.png)
    
    Once you expand the time range bar, you can select the required time interval or specify a custom time interval.
    
    ![Select or Specify Time Range]({{base_path}}/assets/img/streaming/managing-grafana-dashboard/select-or-specify-time-range.png)
    
