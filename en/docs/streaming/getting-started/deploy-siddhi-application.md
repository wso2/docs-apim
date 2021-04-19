# Step 3: Deploy the Siddhi Application

The `SweetFactoryApp` that you created in [Step 2: Create the Siddhi Application]({{base_path}}/streaming/getting-started/create-the-siddhi-application) is now ready to be deployed in the Streaming Integrator server, exported as a Docker image, or deployed in Kubernetes.

## Deploying in Streaming Integrator server

To deploy your Siddhi application in the Streaming Integrator server, follow the procedure below:

!!!info
    To deploy the Siddhi application, you need to run both the Streaming Integrator server and Streaming Integrator Tooling. The home directories of the Streaming Integrator server is referred to as `<SI_HOME>` and the home directory of Streaming Integrator Tooling is referred to as `<SI_TOOLING_HOME>`.

1. Start the Streaming Integrator server by navigating to the `<SI_HOME>/bin` directory from the CLI, and issuing the appropriate command based on your operating system:</br>
   - For Windows: `server.bat --run`</br>
   - For Linux/Mac OS:  `./server.sh`

2. In the Streaming Integrator Tooling, click **Deploy** and then click **Deploy to Server**.

    ![Deploy to Server Menu Option]({{base_path}}/assets/img/streaming/quick-start-guide-101/deploy-to-server-menu.png)

    The **Deploy Siddhi Apps to Server** dialog box opens as follows.

    ![Deploy Siddhi Apps to Server]({{base_path}}/assets/img/streaming/quick-start-guide-101/deploy-to-server-dialog-box.png)

3. In the **Add New Server** section, enter information as follows:

    | Field           | Value                            |
    |-----------------|----------------------------------|
    | **Host**        | Your host                        |
    | **Port**        | `9443`                           |
    | **User Name**   | `admin`                          |
    | **Password**    | `admin`                          |

    ![Add Server]({{base_path}}/assets/img/streaming/quick-start-guide-101/add-server.png)

    Then click **Add**.

4. Select the check boxes for the **SweetFactoryApp.siddhi** Siddhi application and the server you added as shown below.

    ![Deploy Siddhi Apps to Server]({{base_path}}/assets/img/streaming/quick-start-guide-101/select-siddhi-app-and-server.png)

5. Click **Deploy**.

    As a result, the `SweetFactoryApp` Siddhi application is saved in the `<SI_HOME>/deployment/siddhi-files` directory, and the following is message displayed in the dialog box.

    ![Siddhi App successfully deployed]({{base_path}}/assets/img/streaming/quick-start-guide-101/siddhi-app-successfully-deployed.png)


## Deploying in Docker

To export the `SweetFactoryApp` Siddhi application as a Docker artifact, follow the procedure below:

1. Open the Streaming Integrator Tooling.

2. Click **Export** in the top menu, and then click **For Docker**.

    ![Export as Docker/Kubernetes Menu]({{base_path}}/assets/img/streaming/exporting-siddhi-applications/export-docker-k8s-menu.png)

    As a result, **Step 1** of the **Export Siddhi Apps for Docker image** wizard opens as follows.
    
    ![Export as Docker dialog box]({{base_path}}/assets/img/streaming/quick-start-guide-101/export-as-docker-dialog-box.png)
    
3. Select the **SweetFactoryApp.siddhi** check box and click **Next**.
    
4. In **Step 2**, you can template values of the Siddhi Application.
    
    ![Template Siddhi Apps dialog box]({{base_path}}/assets/img/streaming/quick-start-guide-101/template-siddhi-apps-dialog-box.png)
    
    Click **Next** without templating any value of the Siddhi application.

    !!!info
        For detailed information about templating the values of a Siddhi Application, see [Exporting Siddhi Apps for Docker Image]({{base_path}}/develop/streaming-apps/exporting-siddhi-applications#exporting-siddhi-apps-for-docker-image).
    
5. In **Step 3**, you can update configurations of the Streaming Integrator.
    
    ![Update Streaming Integrator Configurations dialog box]({{base_path}}/assets/img/streaming/quick-start-guide-101/update-streaming-integrator-configurations-dialog-box.png)
    
    Leave the default configurations, and click **Next**.
    
6. In **Step 4**, you can provide arguments for the values that were templated in **Step 2**.
    
    ![Populate Arguments Template dialog box]({{base_path}}/assets/img/streaming/quick-start-guide-101/populate-arguments-template-dialog-box.png)
    
    There are no values to be configured because you did not template any values in **Step 2**. Therefore click **Next**.
    
7. In **Step 5**, you can choose additional dependencies to be bundled. This is applicable when Sources, Sinks and etc. with additional dependencies are used in the Siddhi Application (e.g., a Kafka Source/Sink, or a MongoDB Store).
    In this scenario, there are no such dependencies. Therefore nothing is shown as additional JARs.
    
    ![Bundle Additional Dependencies dialog box]({{base_path}}/assets/img/streaming/quick-start-guide-101/bundle-additional-dependencies-dialog-box.png)
    
    Click **Export**. The Siddhi application is exported as a Docker artifact in a zip file to the default location in your machine, based on your operating system and browser settings.
    
!!! tip "What's Next?"
    Now you can run the `SweetFactoryApp` in the Streaming Integrator server. To do this, proceed to [Step 4: Running the Siddhi Application]({{base_path}}/streaming/getting-started/test-siddhi-application)