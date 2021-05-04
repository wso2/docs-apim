# WSO2 API Controller (APICTL)

The **WSO2 API Controller (apictl)** is the command-line tool of WSO2 API Manager. This allows you to move APIs, API Products, and Applications across API-M environments and to perform CI/CD operations. It can also be used to perform these same tasks on a Kubernetes deployment. Also, apictl can be used as a developer CLI tool for Choreo Connect. Furthermore, it can be used with the Micro Integrator (WSO2 MI) for monitoring integration artifacts and performing management/administrative tasks from the command line.

## Get Started

Follow the steps given below to get started:

1.  Go to the [**WSO2 API Manager** website](https://wso2.com/integration/) -> **Download** -> **Other Resources**, and click **APICTL**.

2.  Extract the downloaded distribution and initialize apictl by executing the following command from your terminal.

    ```bash
    apictl init
    ```

3. **Add environments**

    Execute the following command to add API-M or Micro Integrator servers:

    ```bash
    apictl add env <environment-name>
    ```

    Find out more about the `apictl add env` option in the [APICTL Reference](#apictl-add).

3. **Log in**

    Execute the following command to log in to the required server environment. You are prompted to enter the username and password.

    ```bash
    apictl login <environment-name>
    ```

    Alternatively, you can pass the user name and password in a single command:

    !!! Note
        If you are on **Windows**, you must always log in with the following command.

    ```bash
    apictl login <environment-name> -u <username> -p <password>
    ```

    To logout from apictl, use the following command:

    ```bash
    apictl logout <environment-name>
    ```

Once you are logged in, you can use the available options and commands.

## APICTL Reference

You can execute the following command to see the available sub commands:

```bash
apictl
```

Listed below are all the apictl commands available.

### apictl global flags

The following global flags can be used with all the `apictl` options and subcommands. 

<table>
    <tr>
        <th>
            <code>-h</code>, <code>--help</code>
        </th>
        <td>
            Get help for apictl commands and options.
        </td>
    </tr>
    <tr>
        <th>
            <code>-k</code>, <code>--insecure</code>
        </th>
        <td>
            Allow connections to SSL endpoints without certifications.
        </td>
    </tr>
    <tr>
        <th>
            <code>--verbose</code>
        </th>
        <td>
            Enable verbose mode.
        </td>
    </tr>
</table>

###  apictl version

Use the `version` option to get the version of the running apictl tool.

```bash
apictl version
```

### apictl init

Use `init` to initialize the CLI tool.

```bash
apictl init
```

### apictl add

Add a new environment (API-M or MI) and its related endpoints to the configuration file of apictl. This will connect apictl with the added environments.

-   Usage

    ```bash
    apictl add [option] [argument] [flag]
    ```

-   Option

    <table>
        <tr>
            <th>
                <code>env</code>
            </th>
            <td>
                Specifies that a new environment is being added.
            </td>
        </tr>
    </table>

-   Argument

    <table>
        <tr>
            <th>
                <code>environment name</code>
            </th>
            <td>
                Enter the name of given to the environment.
            </td>
        </tr>
    </table>

-   Flags

    <table>
        <tr>
            <th>
                <code>--apim</code>
            </th>
            <td>
                Use this flag to add an API-M environment.
            </td>
        </tr>
        <tr>
            <th>
                <code>--registration</code>
            </th>
            <td>
                If the <code>--apim</code> flag is not used, use this flag to specify the API-M server url.
            </td>
        </tr>
        <tr>
            <th>
                <code>--publisher</code>
            </th>
            <td>
                If the <code>--apim</code> flag is not used, use this flag to specify the API-M Publisher url.
            </td>
        </tr>
        <tr>
            <th>
                <code>--devportal</code>
            </th>
            <td>
                If the <code>--apim</code> flag is not used, use this flag to specify the API-M Developer Portal url.
            </td>
        </tr>
        <tr>
            <th>
                <code>--admin</code>
            </th>
            <td>
                If the <code>--apim</code> flag is not used, use this flag to specify the API-M Admin Portal url.
            </td>
        </tr>
        <tr>
            <th>
                <code>--token</code>
            </th>
            <td>
                If the <code>--apim</code> flag is not used, use this flag to specify the API-M Token url.
            </td>
        </tr>
        <tr>
            <th>
                <code>--mi</code>
            </th>
            <td>
                Use this flag to add a Micro Integrator environment.
            </td>
        </tr>
        <tr>
            <th>
                <code>--environment</code>
            </th>
            <td>
                This flag is mandatory when passing an environment.
            </td>
        </tr>
        <tr>
            <th>
                <code>-e</code>
            </th>
            <td>
                This flag is mandatory when passing an environment.
            </td>
        </tr>
    </table>

### apictl login

Log in to an API Manager environment using credentials.

-   Usage

    ```bash
    apictl login [argument] [global-flags]
    ```

-   Arguments

    <table>
        <tr>
            <th>
                <code>environment</code>
            </th>
            <td>
                Specify the name of the environment to which you want to log in.
            </td>
        </tr>
    </table>

-   Flags

    <table>
        <tr>
            <th>
                <code>-u</code>, <code>--username string</code>
            </th>
            <td>
                Username to login.
            </td>
        </tr>
        <tr>
            <th>
                <code>-p</code></code>, <code>---password string</code>
            </th>
            <td>
                The login password.
            </td>
        </tr>
        <tr>
            <th>
                <code>--password-stdin </code>
            </th>
            <td>
                Get the login password from stdin.
            </td>
        </tr>
    </table>

### apictl logout

Log out from an API Manager environment.

-   Usage

    ```bash
    apictl logout [argument] [global-flags]
    ```

-   Arguments

    <table>
        <tr>
            <th>
                <code>environment</code>
            </th>
            <td>
                Log in to the API-M runtime instance.
            </td>
        </tr>
    </table>

### apictl get

Displays a list containing all the APIs, all the API Products, applications of a specific user, or a list of all the environments.

-   Usage

    ```bash
    apictl get [option] [argument] [flag] [argument] 
    ```

-   Options

    <table>
        <tr>
            <th>
                <code>envs</code>
            </th>
            <td>
                Display the list of environments.
            </td>
        </tr>
        <tr>
            <th>
                <code>apis</code>
            </th>
            <td>
                Display a list of APIs in an environment.
            </td>
        </tr>
        <tr>
            <th>
                <code>api-products</code>
            </th>
            <td>
                Display a list of API Products in an environment.
            </td>
        </tr>
        <tr>
            <th>
                <code>apps</code>
            </th>
            <td>
                Display a list of Applications in an environment specific to an owner.
            </td>
        </tr>
        <tr>
            <th>
                <code>api-revisions</code>
            </th>
            <td>
                Display a list of Revisions for the API.
            </td>
        </tr>
        <tr>
            <th>
                <code>keys</code>
            </th>
            <td>
                Generate access token to invoke the API or API product.
            </td>
        </tr>
    </table>

-   Argument

    <table>
        <tr>
            <th>
                <code>environment name</code>
            </th>
            <td>
                Enter the name of given to the environment.
            </td>
        </tr>
    </table>

-   Flags

    <table>
        <tr>
            <th>
                <code>-e</code>
            </th>
            <td>
                Use this flag to specify from which environment to get the APIs, API products, or APPs.
            </td>
        </tr>
        <tr>
            <th>
                <code>--environment</code>
            </th>
            <td>
                Use this flag to specify from which environment to get the APIs, API products, or APPs.
            </td>
        </tr>
    </table>

### apictl import

Import an API, API product, or application to a specific environment.

-   Usage

    ```bash
    apictl import [option] [argument] [flag] [argument] 
    ```

-   Subcommands

    <table>
        <tr>
            <th>
                <code>api</code>
            </th>
            <td>
                Specify an API to import.
            </td>
        </tr>
        <tr>
            <th>
                <code>api-product</code>
            </th>
            <td>
                Specify an API product to import.
            </td>
        </tr>
        <tr>
            <th>
                <code>app</code>
            </th>
            <td>
                Specify an application to import.
            </td>
        </tr>
    </table>

-   Flags

    <table>
        <tr>
            <th>
                <code>-f</code>
            </th>
            <td>
                Use this flag to specify file path of the API, API product, or App.
            </td>
        </tr>
    </table>

### apictl export

Export APIs, API Products, and Applications of a specific user in the specified environment.

-   Usage

    ```bash
    apictl export [option] [argument] [flag] [argument] 
    ```

-   Options

    <table>
        <tr>
            <th>
                <code>api</code>
            </th>
            <td>
                Specifies the API to export.
            </td>
        </tr>
        <tr>
            <th>
                <code>apis</code>
            </th>
            <td>
                Specifies the APIs to export.
            </td>
        </tr>
        <tr>
            <th>
                <code>api-product</code>
            </th>
            <td>
                Specify an API product to export.
            </td>
        </tr>
        <tr>
            <th>
                <code>app</code>
            </th>
            <td>
                Specify an application to export.
            </td>
        </tr>
    </table>

-   Flags

    <table>
        <tr>
            <th>
                <code>-n</code>
            </th>
            <td>
                Name of the API, API product, or APP to export.
            </td>
        </tr>
        <tr>
            <th>
                <code>-v</code>
            </th>
            <td>
                The version of the API you are exporting.
            </td>
        </tr>
        <tr>
            <th>
                <code>-r</code>
            </th>
            <td>
                The user role that is assigned.
            </td>
        </tr>
        <tr>
            <th>
                <code>-e</code>
            </th>
            <td>
                The environment from which the APIs, API product, or App is being exported.
            </td>
        </tr>
    </table>

### apictl delete

Delete APIs, API Products, and Applications of a specific user in the specified environment.

-   Usage

    ```bash
    apictl delete [option] [argument] [flag] [argument] 
    ```

-   Options

    <table>
        <tr>
            <th>
                <code>api</code>
            </th>
            <td>
                Specifies the API to delete.
            </td>
        </tr>
        <tr>
            <th>
                <code>api-product</code>
            </th>
            <td>
                Specify an API product to delete.
            </td>
        </tr>
        <tr>
            <th>
                <code>app</code>
            </th>
            <td>
                Specify an application to delete.
            </td>
        </tr>
    </table>

-   Flags

    <table>
        <tr>
            <th>
                <code>-n</code>
            </th>
            <td>
                Name of the API, API product, or APP to delete.
            </td>
        </tr>
        <tr>
            <th>
                <code>-v</code>
            </th>
            <td>
                The version of the API you are deleting.
            </td>
        </tr>
        <tr>
            <th>
                <code>-r</code>
            </th>
            <td>
                The user role that is assigned.
            </td>
        </tr>
        <tr>
            <th>
                <code>-e</code>
            </th>
            <td>
                The environment from which the APIs, API product, or App is being deleted.
            </td>
        </tr>
    </table>

### apictl change-status

Change the lifecycle status of an API in an environment

-   Usage

    ```bash
    apictl change-status [option] [argument] [flag] [argument] 
    ```

-   Options

    <table>
        <tr>
            <th>
                <code>api</code>
            </th>
            <td>
                Specifies the API for which you want to change the status.
            </td>
        </tr>
    </table>

-   Flags

    <table>
        <tr>
            <th>
                <code>-a</code>
            </th>
            <td>
                The new status that should apply to the API.
            </td>
        </tr>
        <tr>
            <th>
                <code>-n</code>
            </th>
            <td>
                The name of the API for which the new status should apply.
            </td>
        </tr>
        <tr>
            <th>
                <code>-v</code>
            </th>
            <td>
                The version of the API you are deleting.
            </td>
        </tr>
        <tr>
            <th>
                <code>-r</code>
            </th>
            <td>
                The user role that is assigned.
            </td>
        </tr>
        <tr>
            <th>
                <code>-e</code>
            </th>
            <td>
                The environment from which the APIs, API product, or App is being deleted.
            </td>
        </tr>
    </table>

### apictl bundle

Archive API, Application, or API Product projects to a zip format. The bundle name will have the project name and version.

-   Usage

    ```bash
    apictl bundle [flag] [argument] 
    ```

-   Flags

    <table>
        <tr>
            <th>
                <code>-s</code>
            </th>
            <td>
                The source of the API, or API project directory that should be bundled and archived.
            </td>
        </tr>
        <tr>
            <th>
                <code>--source</code>
            </th>
            <td>
                The source of the API, or API product directory that should be bundled and archived.
            </td>
        </tr>
        <tr>
            <th>
                <code>--d</code>
            </th>
            <td>
                The destination where the bundled ZIP file of the API/API product director is saved.
            </td>
        </tr>
        <tr>
            <th>
                <code>--destination</code>
            </th>
            <td>
                The destination where the bundled ZIP file of the API/API product director is saved.
            </td>
        </tr>
    </table>

### apictl mg

Deploy, Update, Undepoly an apictl project to/from Choreo Connect.

-   Usage

    ```bash
    apictl mg [subcommand] [argument] [flag]
    ```

-   Subcommands

    <table>
        <tr>
            <th>
                <code>add</code>
            </th>
            <td>
                Adds a Choreo Connect environment.
            </td>
        </tr>
        <tr>
            <th>
                <code>deploy</code>
            </th>
            <td>
                Deploy an API (apictl project) in Choreo Connect.
            </td>
        </tr>
        <tr>
            <th>
                <code>get</code>
            </th>
            <td>
                List APIs deployed in the Choreo Connect environment.
            </td>
        </tr>
        <tr>
            <th>
                <code>login</code>
            </th>
            <td>
                Log in to the Choreo Connect environment.
            </td>
        </tr>
        <tr>
            <th>
                <code>logout</code>
            </th>
            <td>
                Log out from the Choreo Connect environment.
            </td>
        </tr>
        <tr>
            <th>
                <code>remove</code>
            </th>
            <td>
                Remove an environment from the Choreo Connect environment.
            </td>
        </tr>
        <tr>
            <th>
                <code>undeploy</code>
            </th>
            <td>
                Undeploy an API in Choreo Connect.
            </td>
        </tr>
    </table>

### apictl set

Set configuration parameters. You can use one of the following flags.

-   Usage

    ```bash
    apictl set [flag] [argument] 
    ```

-   Flags

    <table>
        <tr>
            <th>
                <code>--http-request-timeout</code>
            </th>
            <td>
                Specify the request timout in milliseconds.
            </td>
        </tr>
        <tr>
            <th>
                <code>--tls-renegotiation-mode</code>
            </th>
            <td>
                Specify the regeneration mode: never, once, or freely.
            </td>
        </tr>
        <tr>
            <th>
                <code>--export-directory</code>
            </th>
            <td>
                The directory path where APIs should be saved.
            </td>
        </tr>
        <tr>
            <th>
                <code>--vcs-deletion-enabled</code>
            </th>
            <td>
                Enable/Disable project deletion via vcs.
            </td>
        </tr>
        <tr>
            <th>
                <code>--vcs-config-path</code>
            </th>
            <td>
                The directory path to the custom vcs configuration file.
            </td>
        </tr>
        <tr>
            <th>
                <code>--vcs-deployment-repo-path</code>
            </th>
            <td>
                The directory path to the deployment repo for vcs.
            </td>
        </tr>
        <tr>
            <th>
                <code>--vcs-source-repo-path</code>
            </th>
            <td>
                The directory path to the source repo for vcs.
            </td>
        </tr>
    </table>

### apictl k8s

Managing APIs in a Kubernetes API-M environment.

-   Usage

    ```bash
    apictl k8s [subcommand] [option] [argument] [flag] [argument] 
    ```

-   Subcommands

    <table>
        <tr>
            <th>
                <code>add api</code>
            </th>
            <td>
                Add an API to the kubernetes cluster.
            </td>
        </tr>
        <tr>
            <th>
                <code>update api</code>
            </th>
            <td>
                Update an API to the kubernetes cluster
            </td>
        </tr>
        <tr>
            <th>
                <code>delete api</code>
            </th>
            <td>
                Delete resources related to kubernetes.
            </td>
        </tr>
        <tr>
            <th>
                <code>gen</code>
            </th>
            <td>
                Generate deployment directory for K8S operator.
            </td>
        </tr>
    </table>

-   Flags

    <table>
        <tr>
            <th>
                <code>-n</code>
            </th>
            <td>
                The name of the API that should be added or updated in the K8s environment.
            </td>
        </tr>
        <tr>
            <th>
                <code>-f</code>
            </th>
            <td>
                THe file path to the Swagger resource.
            </td>
        </tr>
        <tr>
            <th>
                <code>--namespace=[value]</code>
            </th>
            <td>
                The namespace associated with the API that should be added or updated in the K8s environment.
            </td>
        </tr>
    </table>

### apictl aws

AWS Api-gateway related commands such as init. Be sure to install and configure the AWS CLI before executing the aws init command. See the [AWS documentation](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-welcome.html) for more information.

-   Usage

    ```bash
    apictl aws [subcommand] [flag] [argument] 
    ```

-   Subcommands

    <table>
        <tr>
            <th>
                <code>init</code>
            </th>
            <td>
                Initialize an API project for an AWS API.
            </td>
        </tr>
    </table>

-   Flags

    <table>
        <tr>
            <th>
                <code>-n</code>
            </th>
            <td>
                The name of the API project that should be initialized.
            </td>
        </tr>
        <tr>
            <th>
                <code>-s</code>
            </th>
            <td>
                The stage of the environment.
            </td>
        </tr>
        <tr>
            <th>
                <code>--stage</code>
            </th>
            <td>
                The stage of the environment.
            </td>
        </tr>
    </table>

### apictl vcs

Checks status and deploys projects to the specified environment. To 
use this command, 'git' must be installed in the system.'

-   Usage

    ```bash
    apictl vcs [subcommand] [flag] [argument] 
    ```

-   Subcommands

    <table>
        <tr>
            <th>
                <code>init</code>
            </th>
            <td>
                Initializes a GIT repository with API Controller.
            </td>
        </tr>
        <tr>
            <th>
                <code>deploy</code>
            </th>
            <td>
                Deploys projects to the specified environment.
            </td>
        </tr>
        <tr>
            <th>
                <code>status</code>
            </th>
            <td>
                Shows the list of projects that are ready to deploy.
            </td>
        </tr>
    </table>

-   Flags

    <table>
        <tr>
            <th>
                <code>-e</code>
            </th>
            <td>
                The environment to which a project should be deployed.
            </td>
        </tr>
    </table>

### apictl undeploy

Undeploy an API/API Product revision that is available in the specified environment from the specified gateway.

-   Usage

    ```bash
    apictl undeploy [option] [argument] [flag] [argument] 
    ```

-   Options

    <table>
        <tr>
            <th>
                <code>api</code>
            </th>
            <td>
                Specifies the API to be undeployed.
            </td>
        </tr>
    </table>

-   Flags

    <table>
        <tr>
            <th>
                <code>-n</code>
            </th>
            <td>
                Name of the API, API product, or APP to undeploy.
            </td>
        </tr>
        <tr>
            <th>
                <code>-v</code>
            </th>
            <td>
                The version of the API you are undeploying.
            </td>
        </tr>
        <tr>
            <th>
                <code>-r</code>
            </th>
            <td>
                The user role that is assigned.
            </td>
        </tr>
        <tr>
            <th>
                <code>-rev</code>
            </th>
            <td>
                ....
            </td>
        </tr>
        <tr>
            <th>
                <code>-g</code>
            </th>
            <td>
                The APIs matching the listed labels are undeployed.
            </td>
        </tr>
        <tr>
            <th>
                <code>-e</code>
            </th>
            <td>
                The environment from which the API is being undeployed.
            </td>
        </tr>
    </table>

### apictl mi

Use this command to manage Micro Integrator artifacts. You can get, add, update, delete, activate, and deactivate integration artifacts and logs.

-   Usage

    ```bash
    apictl mi [subcommand] [option] [argument] [global-flag]
    ```

-   Subcommands

    <table>
        <tr>
            <th>
                <code>login</code>
            </th>
            <td>
                Login to a Micro Integrator.
            </td>
        </tr>
        <tr>
            <th>
                <code>logout</code>
            </th>
            <td>
                Logout from a Micro Integrator.
            </td>
        </tr>
        <tr>
            <th>
                <code>get</code>
            </th>
            <td>
                 Get information about artifacts deployed in a Micro Integrator instance.
            </td>
        </tr>
        <tr>
            <th>
                <code>add</code>
            </th>
            <td>
                 Add new users or loggers to a Micro Integrator instance.
            </td>
        </tr>
        <tr>
            <th>
                <code>delete</code>
            </th>
            <td>
                Delete users from a Micro Integrator instance.
            </td>
        </tr>
        <tr>
            <th>
                <code>update</code>
            </th>
            <td>
                Update log level of Loggers in a Micro Integrator instance.
            </td>
        </tr>
        <tr>
            <th>
                <code>activate</code>
            </th>
            <td>
                Activate artifacts deployed in a Micro Integrator instance.
            </td>
        </tr>
        <tr>
            <th>
                <code>deactivate</code>
            </th>
            <td>
                Deactivate artifacts deployed in a Micro Integrator instance.
            </td>
        </tr>
    </table>

-   Options

    <table>
        <tr>
            <th>
                <code>apis</code>
            </th>
            <td>
                Get details of APIs deployed in the Micro Integrator.
            </td>
        </tr>
        <tr>
            <th>
                <code>connectors</code>
            </th>
            <td>
                Get details of integration connectors deployed in the Micro Integrator.
            </td>
        </tr>
        <tr>
            <th>
                <code>data-services</code>
            </th>
            <td>
                Get details of data services deployed in the Micro Integrator.
            </td>
        </tr>
        <tr>
            <th>
                <code>mi get endpoints</code>
            </th>
            <td>
                Get details of endpoints deployed in the Micro Integrator.
            </td>
        </tr>
        <tr>
            <th>
                <code>inbound-endpoints</code>
            </th>
            <td>
                Get details of inbound endpoints deployed in the Micro Integrator.
            </td>
        </tr>
        <tr>
            <th>
                <code>local-entries</code>
            </th>
            <td>
                Get details of local entries deployed in the Micro Integrator.
            </td>
        </tr>
        <tr>
            <th>
                <code>message-processors</code>
            </th>
            <td>
                Use this option with the <code>get</code> or <code>activate</code> subcommands to get details or to activate the status.
            </td>
        </tr>
        <tr>
            <th>
                <code>message-stores</code>
            </th>
            <td>
                Get details of message stores deployed in the Micro Integrator.
            </td>
        </tr>
        <tr>
            <th>
                <code>proxy-services</code>
            </th>
            <td>
                Get details of proxy services deployed in the Micro Integrator.
            </td>
        </tr>
        <tr>
            <th>
                <code>tasks</code>
            </th>
            <td>
                Get details of scheduled tasks deployed in the Micro Integrator.
            </td>
        </tr>
        <tr>
            <th>
                <code>templates</code>
            </th>
            <td>
                Get details of templates deployed in the Micro Integrator.
            </td>
        </tr>
        <tr>
            <th>
                <code>log-levels</code>
            </th>
            <td>
                Use this option with the <code>mi get</code>, <code>mi add</code>, or <code>mi update</code> commands to manage loggers in the Micro Integrator environment.
            </td>
        </tr>
    </table>

### apictl secret

Encrypt secrets to be used in the Micro Integrator.

-   Usage

    ```bash
    apictl secret [subcommand] [argument]
    ```

-   Subcommands

    <table>
        <tr>
            <th>
                <code>init</code>
            </th>
            <td>
                Initializes the keystore used for encryption.
            </td>
        </tr>
        <tr>
            <th>
                <code>create</code>
            </th>
            <td>
                Encrypt the secrets.
            </td>
        </tr>
    </table>

