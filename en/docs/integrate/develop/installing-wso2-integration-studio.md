# Installing WSO2 Integration Studio

WSO2 Integration Studio provides a comprehensive development experience for building integration solutions.

### Installation prerequisites

<table>
    <tr>
        <td><b>Processor</b></td>
        <td>Intel Core i5 or equivalent </td>
    </tr>
    <tr>
        <td><b>RAM</b></td>
        <td>4 GB minimum, 8 GB recommended </td>
    </tr>
    <tr>
        <td><b>Disk Space</b></td>
        <td>Approximately 4 GB </td>
    </tr>
</table>

### Install and run WSO2 Integration Studio

You can refer to the following video to get a quick understanding of how this is done.

<iframe width="560" height="315" src="https://www.youtube.com/embed/jS47WsycaII" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Follow the steps given below.

1.  Download the [distribution](https://wso2.com/integration/integration-studio/) for your operating system.
2.  Extract the downloaded file to get the **IntegrationStudio**
    application. 
    !!! note
        * If you are a MacOS user, be sure to add it to the **Applications** directory.
        * If you are a Microsoft Windows user, extract it outside the **Programs** directory. This is done because the Integration Studio requires permission to write to files.
3.  Run the **IntegrationStudio** application to start the tool.

!!! info
    **Getting an error message?** See the [troubleshooting](#troubleshooting) tips.

### Get the latest updates

If you have already installed and set up WSO2 Integration Studio, you can get the latest updates as follows:

1.  Open WSO2 Integration Studio on your computer.
2.  Go to **Help** -> **Check for Updates**.

    <img src="{{base_path}}/assets/img/integrate/get-tooling-updates.png" alt="get tooling updates" width="300">

3.  Once the update check is completed, you can select all the available updates and install.

#### Checking the version

You can check the version of the Integration Studio as below.

* For MacOS : Integration Studio > About Integration Studio
* For Windows/Linux : Help > About Integration Studio

    <img src="{{base_path}}/assets/img/integrate/about-integration-studio.png" alt="get studio information" width="400">

### Troubleshooting

If you get an error message about the file being damaged or that you
cannot open the file when you try to start the tool on a MacOS, change the
MacOS security settings as described below.

1.  Go to **System Preferences** -\> **Security & Privacy** -\> **General**.
2.  Under **Allow apps downloaded from**, click **Anywhere** .
3.  Thereafter, select **IntegrationStudio** from the **Applications** menu in your Mac.

## What's next?

-   Take a [quick tour]({{base_path}}/integrate/develop/wso2-integration-studio) of the WSO2 Integration Studio interface.
-   [Build a simple integration use case]({{base_path}}/integrate/develop/integration-development-kickstart) to get familiar with the development workflow. 
-   Build [integration use cases]({{base_path}}/integrate/learn-overview) with WSO2 Integration Studio.
