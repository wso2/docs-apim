# Using a Remote Micro Integrator

The light-weight Micro Integrator is already included in your WSO2 Integration Studio package, which allows you to [deploy and run the artifacts instantly]({{base_path}}/integrate/develop/using-embedded-micro-integrator). 

The following instructions can be used to run your artifacts in a remote Micro Integrator instance.

## Deploy and run artifacts in a remote instance

1.	[Download and install]({{base_path}}/install-and-setup/install/installing-the-product/install-mi-in-vm-installer) the Micro Integrator server and on your computer. 
2.	[Package your Synapse artifacts]({{base_path}}/integrate/develop/packaging-artifacts) from WSO2 Integration Studio.

However, when your solutions are ready to be moved to your production environments, it is recommended to use a **CICD pipeline**.

!!! Note
    As an alternative, you can skip the steps given below and manually copy the exported CAR file to the `<MI_HOME>/repository/deployment/server/carbonapps/` folder, where `<MI_HOME>` is the root folder of your Micro Integrator installation.
    For more information on how to export a CAR file, see [Exporting Artifacts]({{base_path}}/integrate/develop/exporting-artifacts).

## Add a new remote instance

1.  Open the <b>Getting Started</b> view and click <b>Add Server</b> to open the <b>New Server</b> dialog box.
    
    <img src="{{base_path}}/assets/img/integrate/testing-integrations/is_getting_started_page.png" width="700">

2.  In the <b>New Server</b> dialog box that opens, expand the WSO2 folder and select the version of your server.

    <img src="{{base_path}}/assets/img/integrate/testing-integrations/new-server-choose-type.png" width="500">

3.  Click <b>Next</b>. In the CARBON_HOME field, provide the path to your product's home directory and then click <b>Next</b>.

4.  Review the default port details for your server and click <b>Next</b>.
    
    <img src="{{base_path}}/assets/img/integrate/testing-integrations/new-server-mi-port-settings.png" width="500">

    !!! Note
		If you selected an <b>Enterprise Integrator</b> server in the previous step, enter the port details required for an Enterprise Integrator.

    !!! Note
        If you are already running another server on these ports, give unused ports. See [Default ports](../../setup/changing_default_ports) of WSO2 Micro Integrator for more information.

## Deploy and run artifacts in a remote instance

1.  To deploy the C-App project to your server, select the composite application from the list, click <b>Add</b> to move it to the configured list, and then click <b>Finish</b>.
    <img src="{{base_path}}/assets/img/integrate/testing-integrations/new-server-add-capps.png" width="500">

2.  On the <b>Servers</b> tab, note that the server is currently stopped. Click the <img src="{{base_path}}/assets/img/integrate/common/play-head-icon.png" width="20"> icon on the tool bar. If prompted to save changes to any of the artifact files you created earlier, click <b>Yes</b>.

    <img src="{{base_path}}/assets/img/integrate/testing-integrations/new-server-start.png" width="500">   

## Deploy, redeploy, or remove artifacts in a remote instance

- To deploy/remove C-Apps, right-click the server, click <b>Add and Remove</b> and follow the instructions on the wizard.

    <img src="{{base_path}}/assets/img/integrate/testing-integrations/new-server-add-remove-capps.png" width="500">

- If you want to redeploy a C-App after modifying the included artifacts, select the already deployed C-App, right-click and click <b>Redeploy</b>.

!!! Note
	Hot deployment is enabled in the Micro Integrator by default. This allows you to redeploy artifacts without restarting the server.
	If you disabled hot deployment while adding the server, you need to restart the server as well.

## Disable graceful shutdown (Only for testing)

By default, the graceful shutdown capability is enabled in the Micro Integrator distribution. This means that the server will not immediately shut down when there are incomplete HTTP messaging transactions that are still active. These are transactions that are processed by the HTTP/S passthru transport.

For example, consider a delay in receiving the response from the backend (which should be returned to the messaging client). Because graceful shutdown is enabled, the Micro Integrator will wait until the time specified by the following parameter in the server configuration file (`deployment.toml` file) is exceeded before shutting down.

```toml
[transport.http]
socket_timeout = 180000
```

You can disable this feature by using the following system property when you start the server:

!!! Warning
	Disabling graceful shutdown is only recommended for a development environment for the purpose of making the development and testing process faster. Be sure to have graceful shutdown enabled when you move to production.

```bash
-DgracefulShutdown=false
``` 
