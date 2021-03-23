# Downloading and Installing Siddhi Extensions

The Siddhi extensions supported for the Streaming Integrator are shipped with the product by
default. If you need to download and install a different version of an
extension, you can download it via the command line or manually as covered in the following sections.

## Downloading and installing Siddhi extensions via the command line

To manage Siddhi extensions via the command line, see the following topics.

### Identifying the Siddhi extensions to install/uninstall

The following are some actions that you are required to perform in order to identify the Siddhi extensions you need to install. Navigate to the `<SI_HOME>/bin` directory in the CLI to issue these commands.

- **Viewing the list of extensions that are currently installed**

    You can view the complete list of Siddhi extensions that are currently installed in your Streaming Integrator setup. All the extensions listed are completely installed with the dependencies.
    
    To perform this action, issue the appropriate command out of the following based on your operating system:
    
    - **For Windows**     : `extension-installer.bat list`
    - **For Linux/MacOS** : `./extension-installer.sh list`
    
    The following is a sample response log for this command.
    
    ![List of Installed Extensions]({{base_path}}/assets/img/streaming/downloading-and-installing-siddhi-extensions/list-response.png)
    
    
- **Viewing the installation status of all the supported Siddhi extensions**

    You can view the complete list of Siddhi extensions supported for WSO2 Streaming Integrator together with the current installation status for each extension.
    
    The installation status can be one of the following:
    
    |**Installation Status**|**Description**                                                    |
    |-----------------------|-------------------------------------------------------------------|
    |**INSTALLED**          |This indicates that the extension is completely installed. The installation includes the JAR of the extension itself as well as all its dependencies (if any).|
    |**NOT_INSTALLED**      |This indicates that the extension has not been installed. The JAR of the extension itself has not been installed. Dependencies (if any) may be already installed due to shared dependencies.|
    |**PARTIALLY_INSTALLED**|This indicates that the JAR of the extension itself has been installed, but one or more dependencies of the extension still need to be installed. When this status is displayed with an asterisk (i.e., `PARTIALLY_INSTALLED (*)`), it means that there are one or more dependencies that need to be manually installed for the extension.<br/><br/> If an extension has this status, you can view more information about the dependencies to be installed by checking the installation status of that specific extension individually.|

    To perform this action, issue the appropriate command out of the following based on your operating system:
    
    - **For Windows**     : `extension-installer.bat list --all`
    - **For Linux/MacOS** : `./extension-installer.sh list --all`
    
    The following is a sample response for this command.
    
    ![List of installed Siddhi extensions with status]({{base_path}}/assets/img/streaming/downloading-and-installing-siddhi-extensions/list-and-status-response.png)
        
- **Checking the installation status of a specific Siddhi extension**

    You can view the installation status of a specific extension individually together with details of dependencies that need to be manually downloaded (if any exist).

    To perform this action, issue the appropriate command out of the following based on your operating system:
    
    - **For Windows**     : `extension-installer.bat list <EXTENSION_NAME>`
    - **For Linux/MacOS** : `./extension-installer.sh list <EXTENSION_NAME>`   
    
    !!! info
        Here, the `<EXTENSION_NAME>` refers to the name of the extension. When you use the command line to view the list of extensions that are currently installed or to view the installation status of all the supported Siddhi extensions, the extension names are displayed in the `name` column.<br/><br/>e.g., The extension name of the gRPC extension is `grpc`.
        
    e.g., To view the installation status of the `cdc-oracle` extension (which is partially installed by default), issue the following command:
    
    - **For Windows**     : `extension-installer.bat list cdc-oracle`
    - **For Linux/MacOS** : `./extension-installer.sh list cdc-oracle`
    
    The sample response is as follows.
    
    ![List status for specific exension]({{base_path}}/assets/img/streaming/downloading-and-installing-siddhi-extensions/list-status-for-specific-extension.png)
    
### Installing Siddhi Extensions

#### Installing all extensions required for currently deployed Siddhi applications

If the Siddhi applications deployed in your WSO2 Streaming Integrator setup use Siddhi extensions that are not currently installed, you can automatically install all those extensions at once. To do this, issue the appropriate command out of the following based on your operating system.

- **For Windows**     : `extension-installer.bat install`
- **For Linux/MacOS** : `./extension-installer.sh install` 

e.g., If a Siddhi application that is currently deployed in your WSO2 Streaming Integrator setup uses the Amazon S3 extension, and if this extension is not already installed, you can issue the command given above. As a result, the following message appears in the terminal informing you of extensions that are used in Siddhi applications, but not installed. It also prompts you to specify whether you want to install them.

![Not-installed extensions in Siddhi applications]({{base_path}}/assets/img/streaming/downloading-and-installing-siddhi-extensions/not-installed-but-used-extensions.png)

If you enter `y` to specify that you want to proceed with the installation, the following message appears to inform you of the status of the installation and to prompt you to restart the WSO2 Streaming Integrator server once the installation is complete.

![installed missing extension]({{base_path}}/assets/img/streaming/downloading-and-installing-siddhi-extensions/installed-missing-extension-message.png)

#### Installing a specific Siddhi extension

If you want to install a specific Siddhi extension, issue the appropriate command out of the following based on your operating system.

- **For Windows**     : `extension-installer.bat install <EXTENSION_NAME>`
- **For Linux/MacOS** : `./extension-installer.sh install <EXTENSION_NAME>` 

!!! info
    Here, the `<EXTENSION_NAME>` refers to the name of the extension. When you use the command line to view the list of extensions that are currently installed or to view the installation status of all the supported Siddhi extensions, the extension names are displayed in the `name` column.<br/><br/>e.g., The extension name of the gRPC extension is `grpc`.
    
e.g., To install the `grpc` Siddhi extension, issue the following command.

- **For Windows**     : `extension-installer.bat install grpc`
- **For Linux/MacOS** : `./extension-installer.sh install grpc` 

The following message appears to inform you of the status of the installation and to prompt you to restart the WSO2 Streaming Integrator server once the installation is complete.

![install extension log]({{base_path}}/assets/img/streaming/downloading-and-installing-siddhi-extensions/install-extension-log.png)

### Uninstalling Siddhi Extensions

To uninstall a specific Siddhi application, issue the appropriate command out of the following based on your operating system.

- **For Windows**     : `extension-installer.bat uninstall <EXTENSION_NAME>`
- **For Linux/MacOS** : `./extension-installer.sh uninstall <EXTENSION_NAME>` 

!!! info
    Here, the `<EXTENSION_NAME>` refers to the name of the extension. When you use the command line to view the list of extensions that are currently installed or to view the installation status of all the supported Siddhi extensions, the extension names are displayed in the `name` column.<br/><br/>e.g., The extension name of the gRPC extension is `grpc`.
     
e.g., To un-install the `grpc` Siddhi extension, issue the following command.

- **For Windows**     : `extension-installer.bat uninstall grpc`
- **For Linux/MacOS** : `./extension-installer.sh uninstall grpc` 

A message appears to inform you of any other extension that shares dependencies with the extension being uninstalled. The message also prompts you to confirm whether you want to proceed with the installation or not.

![uninstall extension log]({{base_path}}/assets/img/streaming/downloading-and-installing-siddhi-extensions/uninstall-extension-log.png)

If you enter `y` and proceed with the un-installation, the following log appears to inform you of the progress of the un-installation and then prompt you to restart the Streaming Integrator server once the un-installation is complete.

![uninstall extension]({{base_path}}/assets/img/streaming/downloading-and-installing-siddhi-extensions/uninstall-extension.png)

## Downloading and installing Siddhi extensions manually

### Downloading Siddhi extensions

To download Siddhi extensions manually from the store and install them, follow the steps below.

To download the Siddhi extensions, follow the steps below

1. Open the [Siddhi Extensions page](https://store.wso2.com/store/assets/analyticsextension/list).
   The available Siddhi extensions are displayed as follows.  
   ![Siddhi Extension Home Page]({{base_path}}/assets/img/streaming/downloading-and-installing-siddhi-extensions/siddhi-extensions.png)

2. Click on the required extension. In this example, let's click on the **IBM MQ** extension.  
   ![Download Extension]({{base_path}}/assets/img/streaming/downloading-and-installing-siddhi-extensions/download-extension.png)

   In the dialog box that appears, enter your e-mail address and click **Submit**. The extension JAR is downloaded to 
   the default location in your machine (based on your settings).

3.  If you are not using the latest version of the Streaming Integrator, and you
    want to select the version of the extension that matches your current product version, expand **Version Support** 
    in the left navigator for the selected extension.

    !!! tip 
        Each extension has a separate **Version Support** navigator item for the Streaming Integrator, SP, CEP and DAS.
    ![Version Support]({{base_path}}/assets/img/streaming/downloading-and-installing-siddhi-extensions/extension-left-navigator.png)

4. If you need to download an older version of an extension, follow the substeps below.
   1. Once you have clicked on the required extension, click on the **Older Versions** tab. Then click on the link 
   displayed within the tab.  
    ![Older Versions]({{base_path}}/assets/img/streaming/downloading-and-installing-siddhi-extensions/extensions-older-versions.png)

    You are directed to the maven central page where all the available versions of the extension are listed.  
    ![All available versions]({{base_path}}/assets/img/streaming/downloading-and-installing-siddhi-extensions/central-maven-repository.png)

   2. Click on the relavent version. It directs you to the download page. To download the bundle, click on it.  
    ![Download Bundle]({{base_path}}/assets/img/streaming/downloading-and-installing-siddhi-extensions/maven-bundle.png)

### Installing Siddhi extensions

To install the Siddhi extension in your Streaming Integrator pack, place the extension JAR you downloaded in the 
`<SI_HOME>/lib` directory.

### Uninstalling Siddhi extensions

To uninstall a Siddhi extension, delete the relevant extension JAR in the `<SI_HOME>/lib` directory.