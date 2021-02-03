# Installing via the Binary

Follow the steps given below to install the WSO2 Streaming Integrator runtime by using the <b>binary distribution</b> of WSO2 Enterprise Integrator.

## Download and install

Go to the WSO2 Enterprise Integrator [product page](https://wso2.com/integration/#), click **Download**, and then click **Zip Archive** to download the product distribution as a ZIP file.

Extract the download ZIP file to a location on your computer. The <b>streaming-integrator</b> folder inside the extracted ZIP file will be your <b>SI_HOME</b> directory.

## Prerequisites

**Setting the Java_Home**: Set up a [JDK that is compatible with WSO2 Enterprise Integrator]({{base_path}}/install-and-setup/setup/si-setup/environment-compatibility) and point the `java_home` variable to your JDK instance.

## Running the SI server

### Starting the SI server

1.  Open a terminal and navigate to the `<SI_HOME>/bin/` directory, where `<SI_HOME>` is the home directory of the distribution you downloaded.

2.  Execute the relevant command:

    ```bash tab='On MacOS/Linux/CentOS'
    sh streaming-integrator.sh
    ```
    
    ```bash tab='On Windows'
    streaming-integrator.bat
    ```
      
By default, the HTTP listener port is 8290 and the default HTTPS listener port is 8253.

### Stopping the SI server

To stop the Streaming Integrator runtime, press Ctrl+C in the command window.

!!! tip "What's Next?"
    Once you have successfully downloaded and installed WSO2 Streaming Integrator, you can proceed to do any of the following:<br/><br/>
    - If you were previously using WSO2 Stream Processor and want to migrate to WSO2 Streaming Integrator, follow the instructions in [Migrating from WSO2 Stream Processor]({{base_path}}/install-and-setup/upgrading-wso2-si/migrating-from-stream-processor).<br/><br/>
    - To deploy WSO2 Streaming Integrator as a single-node deployment or a cluster (based on your requirements), see [Deploying Streaming Integrator]({{base_path}}/install-and-setup/setup/si-deployment/deployment-guide).<br/><br/>
    - To set up WSO2 Streaming Integrator and make it ready to run in a production environment, see the [Production Checklist]({{base_path}}/install-and-setup/setup/si-setup/production-checklist).<br/><br/>

