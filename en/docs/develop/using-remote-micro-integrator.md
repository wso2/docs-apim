# Using a Remote Micro Integrator

The light-weight Micro Integrator is already included in your WSO2 Integration Studio package, which allows you to [deploy and run the artifacts instantly](using-embedded-micro-integrator.md). 

The following instructions can be used to run your artifacts in a remote Micro Integrator instance.

## Deploy and run artifacts in a remote instance

1.	[Download and install](../../setup/installation/install_in_vm) the Micro Integrator server and on your computer. 
2.	[Export your packaged artifacts](packaging-artifacts.md) from WSO2 Integration Studio.
3.	Copy the exported CAR file to the `<MI_HOME>/repository/deployment/server/carbonapps/` folder where <MI_HOME> is the root folder of your Micro Integrator installation.

However, when your solutions are ready to be moved to your production environments, it is recommended to use a **CICD pipeline**.

## Redeploy artifacts in a remote instance

Hot deployment is enabled in the Micro Integrator by default. This allows you to redeploy artifacts without restarting the server. You can simply copy a new export of the packaged artifacts (CAR file) to the deployment directory (`<MI_HOME>/repository/deployment/server/carbonapps/` folder).

Note that if you have applied changes to the server configurations and libraries, the server will restart.