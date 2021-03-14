# Deploying Siddhi Applications

After creating and testing a Siddhi application, you need to deploy it in the Streaming Integrator server. You can also deploy it in Docker and Kubernetes.

To deploy your Siddhi application in the Streaming Integrator server, follow the procedure below:

!!!info
    To deploy the Siddhi application, you need to run both the Streaming Integrator server and Streaming Integrator Tooling. The home directories of the Streaming Integrator server is referred to as `<SI_HOME>` and the home directory of Streaming Integrator Tooling is referred to as `<SI_TOOLING_HOME>`.

1. Start the Streaming Integrator server by navigating to the `<SI_HOME>/bin` directory from the CLI, and issuing the appropriate command out of the following, based on your operating system.

   - On Windows: `server.bat --run`
   - On Linux/Mac OS:  `./server.sh`

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

4. Select the check boxes for the Siddhi applications that you want to deploy as shown below. Then select the check boxes for the servers in which you want to deploy them.

    ![Deploy Siddhi Apps to Server]({{base_path}}/assets/img/streaming/quick-start-guide-101/select-siddhi-app-and-server.png)

5. Click **Deploy**.

    As a result, the Siddhi application(s) yoiu selected is saved in the `<SI_HOME>/deployment/siddhi-files` directory, and the following is message displayed in the dialog box.

    ![Siddhi App successfully deployed]({{base_path}}/assets/img/streaming/quick-start-guide-101/siddhi-app-successfully-deployed.png)