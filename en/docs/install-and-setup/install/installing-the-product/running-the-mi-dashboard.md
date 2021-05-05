# Running the Micro Integrator Dashboard

Follow the steps given below to install the WSO2 Micro Integrator runtime and its monitoring Dashboard.

## Before you begin

-     [Download and install]({{base_path}}/install-and-setup/install/installing-the-product/installing-mi-dashboard) the Micro Integrator dashboard.
-     Before starting the dashsboard, [start the Micro Integrator]({{base_path}}/install-and-setup/install/installing-the-product/running-the-mi).

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

Once you have [started the dashboard server](#starting-the-dashboard-server), you can access the dashboard using the following URL:

```bash
https://localhost:9743/dashboard
```

!!! Warning

     - In a non-production environment (with the self-signed certificate), you have to add the certificate of the micro integrator instance to the browser as a trusted source. For example, direct the browser to `https://localhost:9164/management` and add the site as trusted. This step will not be required with a custom production certificate.
     - We have identified issues with the Microsoft Edge browser, which prompts trusting the management URL (with the self-signed certificate) in a loop. Please try trusting the management URL in the same tab if you face this issue. If the issue still persists, consider switching the browser.

See the [Micro Integrator Dashboard]({{base_path}}/observe/mi-observe/working-with-monitoring-dashboard) documentation for information on how to sign in and use the dashboard.

## Stopping the dashboard server

To <b>stop</b> the dashboard standalone application, go to the terminal and press <i>Ctrl+C</i>.