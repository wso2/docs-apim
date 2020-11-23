# Micro Integrator Dashboard

The Micro Integrator dashboard provides a graphical view of the synapse artifacts that are deployed in a specified Micro Integrator server instance. You can also perform various management and administration tasks using the dashboard. The dashboard (as well as the [Micro Integrator CLI](../../administer-and-observe/using-the-command-line-interface)) communicates with the management API of WSO2 Micro Integrator to function.

You can use the dashboard to perform the following administration tasks related to your Micro Integrator deployment:

-   <b>View deployed artifacts</b>

    View details of the artifacts deployed in a Micro Integrator instance.

-   <b>Update deployed artifacts</b>

    You can activate/deactivate the following artifacts from the dashboard: <i>Proxy Services</i>, <i>Endpoints</i>, and <i>Message Processors</i>.

    You can enable/disable tracing and statistics for the following artifacts: <i>Proxy Services</i>, <i>Endpoints</i>, and <i>Message Processors</i>.

-   <b>View and update logs</b>

    You can view the log files generated for the Micro Integrator, download the log files, and also update loggers and log levels.

-   <b>Manage users</b>

    You can view details of users stored in the external user store. If you are logged in to the dashsboard with administrator credentials, you can also add new users, and remove users from the user store.

## Setting up the Dashboard

See the following topics in the installation guide for instructions on how to install and set up the Micro Integrator and the Dashboard:

<table>
    <tr>
        <td>
            <a href="../../setup/installation/install_in_vm_installer">Using the Installer</a>
        </td>
        <td>
            Download and run the <b>product installer</b> and then follow the instructions to start the Micro Integrator and the dashboard.
        </td>
    </tr>
    <tr>
        <td>
            <a href="../../setup/installation/install_in_vm_binary">Using the Binary</a>
        </td>
        <td>
            Download the binary distribution of the product, and then follow the instructions to start the Micro Integrator and the dashabord.
        </td>
    </tr>
</table>

## Signing in to the Dashboard

Once you [set up and start the dashboard](#setting-up-the-dashboard), you can access the dashboard URL from the following URL: `https://localhost:9743/dashboard/login`
  
1.  Copy the following dashboard URL to your browser:

    ```bash
    https://localhost:9743/dashboard/login
    ```

2.  Enter the following details to sign in.

    ![login form for monitoring dashboard](../assets/img/monitoring-dashboard/login.png)

    <table>
        <tr>
            <th>
                Host
            </th>
            <td>
                The host name for the running Micro Integrator instance. The default hostname is <b>localhost</b>.
            </td>
        </tr>
        <tr>
            <th>
                Port
            </th>
            <td>
                The port exposing the management API of your running Micro Integrator instance. The default HTTPS port is <b>9164</b>.
            </td>
        </tr>
        <tr>
            <th>
                User
            </th>
            <td>
                The user name to sign in.</br></br>
                <b>Note</b>: This should be a valid user name that is saved in the Micro Integrator server's user store. See <a href="../../setup/user_stores/setting_up_a_userstore">configuring user stores</a> for information.
            </td>
        </tr>
        <tr>
            <th>
                Password
            </th>
            <td>
                The password of the user name.
            </td>
        </tr>
    </table> 

    !!! Warning

        - In a non-production environment (with the self-signed certificate), you have to add the certificate of the micro integrator instance to the browser as a trusted source. For example, direct the browser to `https://localhost:9164/management` and add the site as trusted. This step will not be required with a custom production certificate.
        - We have identified issues with the Microsoft Edge browser, which prompts trusting the management URL (with the self-signed certificate) in a loop. Please try trusting the management URL in the same tab if you face this issue. If the issue still persists, consider switching the browser.

3.  Click <b>SIGN IN</b>.

You are redirected to the home page of the Micro Integrator dashboard.
     
<img src="../../assets/img/monitoring-dashboard/dashboard-artifact-home.png" width="700">

## Using the Dashboard

Once you sign in to the dashboard, you can view details of artifacts, update artifact, and perform various other administration tasks. Select the required option from the left-hand navigator.

<img src="../../assets/img/monitoring-dashboard/dashboard-artifact-list.png">

<!--
### Proxy Services

Select this option to manage proxy services deployed in the Micro Integrator instance.

<img src="../../assets/img/monitoring-dashboard/dashboard-proxy-service-1.png">

You can view details, and update the <b>status</b> and enable <b>tracing</b>/<b>statistics</b> for each proxy service.

<img src="../../assets/img/monitoring-dashboard/dashboard-proxy-service-2.png">

### Endpoints

Select this option to manage endpoint artifacts deployed in the Micro Integrator instance.

<img src="../../assets/img/monitoring-dashboard/dashboard-endpoint-1.png">

You can view details, update the <b>status</b>, and enable <b>tracing</b>/<b>statistics</b> for each endpoint.

<img src="../../assets/img/monitoring-dashboard/dashboard-endpoint-2.png">

### Inbound Endpoints

Select this option to manage inbound endpoint artifacts deployed in the Micro Integrator instance.

<img src="../../assets/img/monitoring-dashboard/dashboard-inbound-endpoint-1.png">

You can view details of each inbound endpoint as shown below.

<img src="../../assets/img/monitoring-dashboard/dashboard-inbound-endpoint-2.png">

### Message Processors

Select this option to manage message processor artifacts deployed in the Micro Integrator instance.

<img src="../../assets/img/monitoring-dashboard/dashboard-message-processor-1.png">

You can view details, update the <b>status</b>, and enable <b>tracing</b>/<b>statistics</b> for each message processor.

<img src="../../assets/img/monitoring-dashboard/dashboard-message-processor-1.png">

### Message Stores

Select this option to manage message store artifacts deployed in the Micro Integrator instance.

<img src="../../assets/img/monitoring-dashboard/dashboard-message-store-1.png">

You can view details of each message store as shown below.

<img src="../../assets/img/monitoring-dashboard/dashboard-message-store-2.png">

### API

Select this option to manage REST API artifacts deployed in the Micro Integrator instance.

<img src="../../assets/img/monitoring-dashboard/dashboard-api-1.png">

You can view details and update <b>tracing</b> for each API as shown below.

<img src="../../assets/img/monitoring-dashboard/dashboard-api-2.png">

### Templates

Select this option to manage templates artifacts deployed in the Micro Integrator instance.

<img src="../../assets/img/monitoring-dashboard/dashboard-template-1.png">

You can view details for each template as shown below.

<img src="../../assets/img/monitoring-dashboard/dashboard-template-2.png">

### Sequences

Select this option to manage sequence artifacts deployed in the Micro Integrator instance.

<img src="../../assets/img/monitoring-dashboard/dashboard-sequence-1.png">

You can view details and update <b>tracing</b> for each sequence as shown below.

<img src="../../assets/img/monitoring-dashboard/dashboard-template-2.png">

### Tasks

Select this option to manage scheduled tasks deployed in the Micro Integrator instance.

<img src="../../assets/img/monitoring-dashboard/dashboard-task-1.png">

You can view details for each task as shown below.

<img src="../../assets/img/monitoring-dashboard/dashboard-task-2.png">

### Local Entries

Select this option to manage local entries deployed in the Micro Integrator instance.

<img src="../../assets/img/monitoring-dashboard/dashboard-localentry-1.png">

You can view details for each local entry as shown below.

<img src="../../assets/img/monitoring-dashboard/dashboard-localentry-2.png">

### Data Services

Select this option to manage data services deployed in the Micro Integrator instance.

<img src="../../assets/img/monitoring-dashboard/dashboard-dataservice-1.png">

You can view details for each data service as shown below.

<img src="../../assets/img/monitoring-dashboard/dashboard-dataservice-2.png">

### Connectors

Select this option to manage connector artifacts deployed in the Micro Integrator instance.

<img src="../../assets/img/monitoring-dashboard/dashboard-connector-1.png">

You can view details for each connector as shown below.

<img src="../../assets/img/monitoring-dashboard/dashboard-connector-2.png">

### Carbon Applications

Select this option to see the list of composite applications deployed in the Micro Integrator instance.

<img src="../../assets/img/monitoring-dashboard/dashboard-capp.png">

### Log Files

Select this option to view and download log files of the Micro Integrator instance.

<img src="../../assets/img/monitoring-dashboard/dashboard-view-logs.png">

### Log Configs

Select this option to manage the log4j loggers of the Micro Integrator instance.

To view log configs and update log levels:

<img src="../../assets/img/monitoring-dashboard/dashboard-logger-1.png">

To add new loggers:

<img src="../../assets/img/monitoring-dashboard/dashboard-logger-2.png">

### Users

Select this option to manage the users of the Micro Integrator instance. These users are stored in the external user store connected to the Micro Integrator.

To view and remove users:

<img src="../../assets/img/monitoring-dashboard/dashboard-users-1.png" width="700">

To add new users:

<img src="../../assets/img/monitoring-dashboard/dashboard-users-2.png" width="700">
-->
