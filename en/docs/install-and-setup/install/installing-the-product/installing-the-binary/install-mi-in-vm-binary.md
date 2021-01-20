# Installing via the Binary

Follow the steps given below to install the WSO2 Micro Integrator runtime and its monitoring Dashboard by using the <b>binary distribution</b> of WSO2 Enterprise Integrator.

## Download and install

You can refer to the following video to get a quick understanding of how this is done.

<iframe width="560" height="315" src="https://www.youtube.com/embed/FxJApHXU63E" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>


Go to the WSO2 Enterprise Integrator [product page](https://wso2.com/integration/#), click **Download**, and then click **Zip Archive** to download the product distribution as a ZIP file.

Extract the download ZIP file to a location on your computer. 

-	The <b>micro-integrator</b> folder inside the extracted ZIP file will be your <b>MI_HOME</b> directory.
-	The <b>micro-integrator-dashboard</b> folder inside the extracted ZIP file will be your <b>DASHBOARD_HOME</b> directory.

## Prerequisites

**Setting the Java_Home**: Set up a [JDK that is compatible with WSO2 Enterprise Integrator](../install_prerequisites/#environment-compatibility) and point the `java_home` variable to your JDK instance.

## Running the MI server

### Starting the MI server

1.  Open a terminal and navigate to the `MI_HOME/bin/` directory, where `MI_HOME` is the home directory of the distribution you downloaded.
2.  Execute the relevant command:

    ```bash tab='On MacOS/Linux/CentOS'
    sh micro-integrator.sh
    ```
    
    ```bash tab='On Windows'
    micro-integrator.bat
    ```
      
By default, the HTTP listener port is 8290 and the default HTTPS listener port is 8253.

### Stopping the MI server

To stop the Micro Integrator runtime, press Ctrl+C in the command window.

## Running the MI dashboard

### Starting the dashboard server

1.  Open a terminal and navigate to the `DASHBOARD_HOME/bin/` directory, where `DASHBOARD_HOME` is the home directory of the distribution you downloaded.
2.  Execute the relevant command:

    ```bash tab='On MacOS/Linux/CentOS'
    sh dashboard.sh
    ```
    
    ```bash tab='On Windows'
    dashboard.bat
    ```

### Accessing the dashboard

Once you have [started the dashboard server](#starting-the-dashboard-server), you can access the dashboard using the following URL:

```bash
https://localhost:9743/dashboard
```

!!! Warning

     - In a non-production environment (with the self-signed certificate), you have to add the certificate of the micro integrator instance to the browser as a trusted source. For example, direct the browser to `https://localhost:9164/management` and add the site as trusted. This step will not be required with a custom production certificate.
     - We have identified issues with the Microsoft Edge browser, which prompts trusting the management URL (with the self-signed certificate) in a loop. Please try trusting the management URL in the same tab if you face this issue. If the issue still persists, consider switching the browser.

See the [Micro Integrator Dashboard](../../../administer-and-observe/working-with-monitoring-dashboard) documentation for information on how to sign in and use the dashboard.

### Stopping the dashboard server

To stop the dashboard runtime, press Ctrl+C in the command window.
