# Upgrading from Streaming Integrator 1.0.0

To upgrade from Streaming Integrator 1.0.0 to Streaming Integrator 1.1.0, follow the steps below:

!!! tip "Before you begin:"
    Download Streaming Integrator 1.1.0 version from the [Streaming Integrator Page](https://wso2.com/integration/streaming-integrator/)

## Step 1: Deploy the Siddhi applications

To deploy the Siddhi applications you have been running in Streaming Integrator 1.0.0 to Streaming Integrator 1.1.0, follow the procedure below:

1. Open the `<SI 1.0.0_HOME>/wso2/server/deployment/siddhi-files` directory. Then copy all the siddhi files in it.

2. Paste all the Siddhi files that you copied in the `<SI 1.1.0_HOME>/wso2/server/deployment/siddhi-files` directory.

Now your Siddhi applications are deployed in Streaming Integrator 1.1.0.

## Step 2: Update configuration files

To configure Streaming Integrator 1.1.0 the same way as Streaming Integrator 1.0.0, open the `<SI 1.0.0_HOME>/conf/server/deployment.yaml` file. Then read each line, and update the `<SI 1.1.0_HOME>/conf/server/deployment.yaml` file with the same values

!!! note
    The deployment.yaml files must not be copied directly between servers due to certain differences in the parameters included in the two Streaming Integrator versions.

## Step 3: Start the SI 1.1.0 server and install required extensions

The purpose of this step is to Start the Streaming Integrator and identify any further reqirements to run the Siddhi applications that are deployed in it.

1. Navigate to the `<SI 1.1.0_HOME>/bin` directory and issue the appropriate command based on your operating system:

    - **For Windows**     : `server.bat`
    - **For Linux/MacOS** :`./server.sh`
    
    If any of the deployed Siddhi applications uses a Siddhi extension that is not currently installed, it is indicated via an error in the start up logs as shown in the example below:
    
    ![Missing Extension Error]({{base_path}}/assets/img/streaming/upgrading-from-previous-version/missing-extension-error.png)
   
2. To install all the missing extensions that are required to run the Siddhi applications currently deployed, navigate to the `<SI 1.1.0_HOME>/bin` directory and issue the appropriate command based on your operating system:

    - **For Windows**     : `extension-installer.bat install`
    - **For Linux/MacOS** : `./extension-installer.sh install` 
    
    As a result, the following message is logged.
    
    ![Not-installed extensions in Siddhi applications]({{base_path}}/assets/img/streaming/downloading-and-installing-siddhi-extensions/not-installed-but-used-extensions.png)
    
    If you enter `y` to specify that you want to proceed with the installation, the following message appears to inform you of the status of the installation and to prompt you to restart the WSO2 Streaming Integrator server once the installation is complete.
    
    ![installed missing extension]({{base_path}}/assets/img/streaming/downloading-and-installing-siddhi-extensions/installed-missing-extension-message.png)
    
    !!! info
        The Extension Installer tool is currently unable to install a few of the supported Siddhi applications. Therefore, if the start-up logs indicate a missing extension, but you are unable to install that extension via the Extension Installer tool, you can [install it manually]({{base_path}}/downloading-and-Installing-Siddhi-Extensions/#downloading-and-installing-siddhi-extensions-manually).<br/><br/>We will be upgrading the Extension Installer to handle all the supported Siddhi extensions in a future release.

## Step 4: Test the migration

To test the migration, simulate events for the Siddhi applications you have deployed and verify whether they generate the expected results. For instructions to simulate events, see [Testing Siddhi Applications]({{base_path}}/develop/streaming-apps/testing-a-siddhi-application). 

