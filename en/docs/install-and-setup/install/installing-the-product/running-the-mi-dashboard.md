# Running the Micro Integrator Dashboard

Follow the steps given below to run the WSO2 Micro Integrator runtime and its monitoring Dashboard.

## Before you begin

Follow the steps given below before you start.

1.  Download and install the servers:

    -     [Download and install]({{base_path}}/install-and-setup/install/installing-the-product/installing-mi-dashboard) the Micro Integrator dashboard.
    -     [Download and install]({{base_path}}/install-and-setup/install/installing-the-product/installing-mi) the Micro Integrator.

2.  Set up the Micro Integrator:

    1.  Open the `deployment.toml` file (stored in the `<MI_HOME>/conf/` folder) of the Micro Integrator, and add the following configuration.

        ```toml
        [dashboard_config]
        dashboard_url = "https://localhost:9743/dashboard/api/"
        heartbeat_interval = 5
        group_id = "mi_dev"
        node_id = "dev_node_2"
        ```

    2.  Be sure to change the host and port number of the `dashboard_url` in the above configuration if you have changed the default host and port for the dashboard.

    !!! Info
        See the section on [configuring the MI servers for the dashboard]({{base_path}}/observe/mi-observe/working-with-monitoring-dashboard/#step-2-configure-the-mi-servers) for more information.

3.  [Start the Micro Integrator]({{base_path}}/install-and-setup/install/installing-the-product/running-the-mi).

## Starting the dashboard server

Follow the steps given below.

1.    Open a terminal and navigate to the `<MI-DASHBOARD_HOME>/bin` folder.
2.    Execute one of the commands given below.

      ```bash tab="On MacOS/Linux"
      ./dashboard.sh
      ```

      ```bash tab="On Windows"
      dashboard.bat
      ```

## Accessing the dashboard

Once you have [started the dashboard server](#starting-the-dashboard-server):

1.  Access the dashboard using the following URL:

    ```bash
    https://localhost:9743/dashboard
    ```

    ![login form for monitoring dashboard]({{base_path}}/assets/img/integrate/monitoring-dashboard/login.png)

2.  Enter the following details to sign in:

    <table>
        <tr>
            <th>
                Username
            </th>
            <td>
                The user name to sign in.</br></br>
                <b>Note</b>: This should be a valid username that is saved in the Micro Integrator server's user store. By default, the 'admin' user name is configured in the default user store.</br></br> 
                See <a href="{{base_path}}/install-and-setup/setup/mi-setup/user_stores/setting_up_a_userstore">configuring user stores</a> for information.
            </td>
        </tr>
        <tr>
            <th>
                Password
            </th>
            <td>
                The password of the user name. By default, 'admin' is the user name and password. 
            </td>
        </tr>
    </table>

2.  Be sure that the Micro Integrator servers are [already configured and started](#before-you-begin) before you sign in.

See the [Micro Integrator Dashboard]({{base_path}}/observe/mi-observe/working-with-monitoring-dashboard) documentation for information on the dashboard's cabapabilties and how to use them.

## Stopping the dashboard server

To <b>stop</b> the dashboard standalone application, go to the terminal and press <i>Ctrl+C</i>.