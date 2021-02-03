# Using the Embedded Micro Integrator

WSO2 Integration Studio contains an embedded Micro Integrator instance, which you can use for testing your integration solutions during the development process.

## Deploy and run artifacts in the (embedded) server

Once you have the [integration artifacts packaged]({{base_path}}/integrate/develop/packaging-artifacts) in a composite application, you can deploy and run them in the embedded Micro Integrator using a single click. 

1.  Select the composite application in the project explorer.
2.  Click the <img src="{{base_path}}/assets/img/integrate/common/play-head-icon.png" width="20"> icon in the menu palette to open the <b>Run As</b> dialog box.

3. Select <b>Run on Micro Integrator</b> and click <b>OK</b>.

    <img src="{{base_path}}/assets/img/integrate/testing-integrations/run-as-micro-integrator.png" width="700">

4. Select the artifacts from the composite application that you want to deploy.  
    <img src="{{base_path}}/assets/img/integrate/testing-integrations/testing_artifact_selection.png" width="700">

5.  Click **Finish**. The artifacts will be deployed in the WSO2 Micro Integrator and the server will start. 
	See the startup log in the **Console** tab:  
    <img src="{{base_path}}/assets/img/integrate/testing-integrations/testing_log.png" width="700">

6.  If you find errors in your mediation sequence, use the [debugging features]({{base_path}}/integrate/develop/debugging-mediation) to troubleshoot.

## View deployed endpoints in the (embedded) server

Use the <b>Runtime Services</b> tab in WSO2 Integration Studio to view the endpoint URLs of the artifacts deployed in the embedded Micro Integrator.

When you [deploy tha artifacts and start](#deploy-and-run-artifacts-in-the-embedded-server) the embedded Micro Integrator, the <b>Console</b> tab prints the server startup logs and the <b>Runtime Services</b> tab will open as shown below. 

<img src="{{base_path}}/assets/img/integrate/testing-integrations/deployed-endpoints.png">

If you have closed the tab and you want to open it again, go to <b>Window -> Show View -> Other</b> and select <b>Runtime Services</b>.

<img src="{{base_path}}/assets/img/integrate/testing-integrations/show-deployed-endpoints.png" width="300">

## Update (embedded) server configs and libraries

For some integrations, it is necessary to update the server configurations. For example, if you are integrating with an external broker, you need to update broker connection details and also add the broker's connection JARs to the server's `/lib` folder.

Click the <img src="{{base_path}}/assets/img/integrate/testing-integrations/server-configs-panel-icon.png" width="20"> icon to open the <b>Embedded Micro Integrator Configuration</b> dialog box shown below.

!!! Note 
	You can also paramterize configurations as [environment variables](../../setup/dynamic_server_configurations) and later [inject environment variables to the embedded Micro Integrator](#injecting-environment-variables-to-embedded-micro-integrator).

<img src="{{base_path}}/assets/img/integrate/testing-integrations/server-configs-panel.png">

In the upper section, update the server configuration file (`deployment.toml` file). In the lower section, add any requried third-party libraries to the `/lib` folder of the server.

## Encrypt static (embedded) server secrets

If you have secrets in the `deployment.toml` file, you can encrypt them using the <b>Cipher Tool</b>. 

1.  Open the [<b>Embedded Micro Integrator Configuration</b>](#update-embedded-server-configs-and-libraries) dialog box. 
2.  Update the static secrets in the `deployment.toml` file as explained in [encrypting server secrets](../../setup/security/encrypting_plain_text).
3.  Click <b>Encrypt Secrets</b>.
	
    <img src="{{base_path}}/assets/img/integrate/testing-integrations/encrypt-secrets.png">

This will run the Cipher Tool internally and encrypt the secrets. The plain-text values you entered are now replaced with the encrypted values.

<img src="{{base_path}}/assets/img/integrate/testing-integrations/encrypt-secrets-executed.png" width="700">

## Redeploy integration artifacts

Hot deployment is enabled in the Micro Integrator by default. This allows you to redeploy artifacts without restarting the server. However, if you have applied changes to the server configurations and libraries, the server will restart.

1.	Select the composite application that contains your artifacts.
2.	Click the <img src="{{base_path}}/assets/img/integrate/common/play-head-icon.png" width="20"> icon in the menu palette.

## Injecting environment variables to embedded Micro Integrator

WSO2 Micro Integrator supports environment variables for server configurations as well as synapse configurations (integration artifacts).

!!!	Note
	To be able to dynamically inject parameters to the embedded Micro Integrator, you must first define the relevant configurations as environment variables. See the following topics for instructions:

	- [Environment variables for server Configurations](../../setup/dynamic_server_configurations)
	- [Environment variables for synapse configurations]({{base_path}}/integrate/develop/injecting-parameters)

Follow the steps given below.

1.  [Deploy and run](#deploy-and-run-artifacts-in-the-embedded-server) the artifacts in the embedded Micro Integrator.

    !!! Tip
        Note that you need to run the embedded Micro Integrator at least once before proceeding to specify environment variables.

2.  You can now go to **Run** -> **Run Configurations** in the upper menu bar of your computer:

    ![run configurations menu]({{base_path}}/assets/img/integrate/run-configs-menu.png)

3.  In the **Run Configurations** dialog box that opens, select **Micro Integrator Server 1.2.0** that is listed under **Generic Server** in the navigator:

    ![run configurations dialog box]({{base_path}}/assets/img/integrate/run-configs-dialog-box.png)

4.  In the **Server** tab, select Micro Integrator 1.2.0 from the list if it is not already selected.
5.  Go to the **Environment** tab and click **New** to add an environment variable:

    ![run configurations environments]({{base_path}}/assets/img/integrate/run-configs-env.png)

6.  Enter the variable name and value as a key-value pair and click **OK**. In this example, let's use the server offset:

    !!! Tip
        The offset parameter in the `deployment.toml` file of the embedded Micro Integrator should be specified as follows:
        ```toml
        [server]
        offset="$env{offset}"
        ```

    ![run configurations environments]({{base_path}}/assets/img/integrate/run-configs-env-popup.png)


7.  Click **Apply** to apply the new environment variable.

    ![run configurations environments]({{base_path}}/assets/img/integrate/run-configs-env-apply.png)