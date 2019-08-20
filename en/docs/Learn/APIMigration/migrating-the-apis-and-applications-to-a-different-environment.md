# Migrating the APIs and Applications to a Different Environment

WSO2 API Manager (WSO2 API-M) allows you to maintain multiple environments running on the same WSO2 API-M version. This feature allows you to import and export applications or APIs between your environments. For example, if you have an application or API running in the development environment, you can import it and export to the test(QA) environment. Thereby, APIs and applications do not have to be created from scratch in different environments.

-   [Getting Started](#MigratingtheAPIsandApplicationstoaDifferentEnvironment-GettingStarted)
-   [Migrating APIs to different environments](#MigratingtheAPIsandApplicationstoaDifferentEnvironment-MigratingAPIstodifferentenvironments)
-   [Migrating applications to different environments](#MigratingtheAPIsandApplicationstoaDifferentEnvironment-Migratingapplicationstodifferentenvironments)
-   [Reset user](#MigratingtheAPIsandApplicationstoaDifferentEnvironment-Resetuser)
-   [Check the version of the CLI](#MigratingtheAPIsandApplicationstoaDifferentEnvironment-ChecktheversionoftheCLI)
-   [Set HTTP request timeout](#MigratingtheAPIsandApplicationstoaDifferentEnvironment-SetHTTPrequesttimeout)
-   [Set export directory](#MigratingtheAPIsandApplicationstoaDifferentEnvironment-Setexportdirectory)
-   [Understanding the API import/export tool](#MigratingtheAPIsandApplicationstoaDifferentEnvironment-UnderstandingtheAPIimport/exporttool)

### Getting Started

!!! note
After running the CLI tool make sure to add an environment before you start working with the import/export CLI commands, because all APIs and applications need to be imported or exported to a specific environment.


-   [Running the CLI tool](#MigratingtheAPIsandApplicationstoaDifferentEnvironment-RunningtheCLItool)
-   [Adding an environment](#MigratingtheAPIsandApplicationstoaDifferentEnvironment-Addinganenvironment)
-   [Removing an environment](#MigratingtheAPIsandApplicationstoaDifferentEnvironment-Removinganenvironment)
-   [List environments](#MigratingtheAPIsandApplicationstoaDifferentEnvironment-Listenvironments)

#### Running the CLI tool

-   [Step 1 - Deploy the API import/export tool](#MigratingtheAPIsandApplicationstoaDifferentEnvironment-Step1-DeploytheAPIimport/exporttool)
-   [Step 2- Run the CLI tool](#MigratingtheAPIsandApplicationstoaDifferentEnvironment-Step2-RuntheCLItool)

##### Step 1 - Deploy the API import/export tool

1.  Download the latest version of WSO2 API Manager from [http://wso2.com/products/api-manager/](http://wso2.com/api-management/try-it/) .

2.  Download the latest WSO2 API import/export tool ( `           api-import-export-2.6.0-v0.war          ` ) from [here](https://docs.wso2.com/download/attachments/28718536/api-import-export-2.6.0-v0.war?version=1&modificationDate=1539978461000&api=v2) .

        !!! warning
    Note that the import/export tool attached is specific to this version of WSO2 API Manager.


3.  Copy the downloaded `           api-import-export-2.6.0-v0.war          ` file to the `           <API-M_HOME>/repository/deployment/server/webapps          ` folder.

4.  Start the API Manager.
    If the server is already started, the file is automatically deployed as hot deployment is enabled.

##### Step 2- Run the CLI tool

1.  Navigate to the API Management Tooling page - <https://wso2.com/api-management/tooling/>
2.  Click **Download** under **CLI** .
3.  Select a generated archive suitable for your platform (i.e., Mac, Windows, Linux) and extract it the CLI tool that you downloaded to a desired location and `          cd         ` into it.
4.  Start WSO2 API Manager.

5.  Navigate to the working directory where the executable resides.

6.  Execute the following command to start the CLI tool.

    ``` java
        ./apimcli
    ```

7.  Add the location of the extracted folder to your system's `           $PATH          ` variable to be able to access the executable from anywhere.

        !!! note
    For further instructions execute the following command.

    ``` java
        apimcli --help
    ```


##### Global flags for CLI tool

The following are some global flags that you can use with the CLI tool.

``` java
          --verbose
               Enable verbose logs (Provides more information on execution)
          --insecure, -k
              Allow connections to SSL sites without certs
          --help, -h
              Display information and example usage of a command
```

#### Adding an environment

You can add environments by either manually editing the `         $HOME/.wso2apimcli/main_config.yaml        ` file or by running the following CLI command.

``` java
    apimcli add-env
```

The directory structure for the configuration files ( `         $HOME/.wso2apimcli        ` ) will be created upon execution of the `         apimcli        ` command.

1.  Make sure that WSO2 API Manager is started and that the CLI import/export tool is running.
2.  Run the following CLI command to add an environment.

    -   [**Command Format**](#Format-AddEvn)
    -   [**Example**](#Example-AddEnv)
    -   [**Response**](#ReponseAddEnv)

    -   [**Linux Format**](#LinuxFormatAddEnv)
    -   [**Mac Format**](#MacFormatAddEnv)

    ``` java
            apimcli add-env -n <environment-name> \
                                    --registration <registration-endpoint> \
                                    --apim <API-Manager-endpoint> \
                                    --token <token-endpoint> \
                                    --import-export <endpoint-for-environment> \
                                    --admin <admin-REST-API-endpoint> \
                                    --api_list <API-listing-REST-API-endpoint> \
                                    --app_list <application-listing-REST-API-endpoint>
    ```

    ``` java
            apimcli add-env -n <environment-name> --registration <registration-endpoint> --apim <API-Manager-endpoint> --token <token-endpoint> --import-export <endpoint-for-environment> --admin <admin-REST-API-endpoint> --api_list <API-listing-REST-API-endpoint> --app_list <application-listing-REST-API-endpoint>
    ```

    **Flags:**

    -   Required flags:
        -   `                 --name, -n                `
            There are no short flags for the following flags.
        -   `                  --registration                 `

        -   `                  --apim                 `

        -   `                  --token                 `

        -   `                  --import-export                 `

        -   `                  --admin                 `

        -   `                  --api_list                 `

        -   `                  --app_list                 `

    -   [**Linux**](#Linux1)
    -   [**Mac OS**](#MacOS)

    **Example 1**

    ``` java
            apimcli add-env -n production \
                                  --registration https://localhost:9443/client-registration/v0.14/register \
                                  --apim https://localhost:9443 \
                                  --token https://localhost:8243/token \
                                  --import-export https://localhost:9443/api-import-export-2.6.0-v0 \
                                  --admin https://localhost:9443/api/am/admin/v0.14 \
                                  --api_list https://localhost:9443/api/am/publisher/v0.14/apis \
                                  --app_list https://localhost:9443/api/am/store/v0.14/applications
    ```

    **Example 2**

    ``` java
            apimcli add-env -n dev \
                                  --registration https://localhost:9444/client-registration/v0.14/register \
                                  --apim https://localhost:9444 \
                                  --token https://localhost:8244/token \
                                  --import-export https://localhost:9444/api-import-export-2.6.0-v0 \
                                  --admin https://localhost:9444/api/am/admin/v0.14 \
                                  --api_list https://localhost:9444/api/am/publisher/v0.14/apis \
                                  --app_list https://localhost:9444/api/am/store/v0.14/applications
    ```

    **Example 1**

    ``` java
            apimcli add-env -n production --registration https://localhost:9443/client-registration/v0.14/register --apim https://localhost:9443 --token https://localhost:8243/token --import-export https://localhost:9443/api-import-export-2.6.0-v0 --admin https://localhost:9443/api/am/admin/v0.14 --api_list https://localhost:9443/api/am/publisher/v0.14/apis --app_list https://localhost:9443/api/am/store/v0.14/applications
    ```

    **Example 2**

    ``` java
            ./apimcli add-env -n dev --registration https://localhost:9444/client-registration/v0.14/register --apim https://localhost:9444 --token https://localhost:8244/token --import-export https://localhost:9444/api-import-export-2.6.0-v0 --admin https://localhost:9444/api/am/admin/v0.14 --api_list https://localhost:9444/api/am/publisher/v0.14/apis --app_list https://localhost:9444/api/am/store/v0.14/applications
    ```

    -   [**Response Format**](#ResponseFormat)
    -   [**Example Response**](#ExampleResponse)

    ``` java
            Successfully added environment '<environment-name>'
    ```

    ``` java
            Successfully added environment 'production'
    ```

#### Removing an environment

1.  Make sure that WSO2 API Manager is started and that the CLI import/export tool is running.
2.  Run the following CLI command to remove an environment.

    -   [**Command Format**](#Format-RemoveEnv)
    -   [**Example**](#Example-RemoveEnv)
    -   [**Response**](#Response-RemoveEnv)

    ``` java
            apimcli remove-env -n <environment-name>            
    ```

    ``` java
            apimcli remove-env --name <environment-name>
    ```

    **Flags:**

    -   Required flags
        -   `                 --name, -n                `

    ``` java
            apimcli remove-env -n production
    ```

    -   [**Format**](#ResFormatRemove)
    -   [**Example**](#ResRemoveEx)

    ``` java
            Successfully removed environment '<environment-name>'
            Execute 'apimcli add-env --help' to see how to add a new environment
    ```

    ``` java
            Successfully removed environment 'uat'
            Execute 'apimcli add-env --help' to see how to add a new environment
    ```

#### List environments

1.  Make sure that WSO2 API Manager is started and that the CLI import/export tool is running.
2.  Run the following CLI command to list the environments.
    There are no flags for the following CLI command.

    -   [**Command**](#CommandENVList)
    -   [**Response**](#ResENVList)

    ``` java
            apimcli list envs
    ```

    ``` java
            Environments available in file '/Users/kim/.wso2apimcli/main_config.yaml'
    +------------+------------------------+-----------------------------------------------------------+------------------------------+
    |    NAME    |   PUBLISHER ENDPOINT   |                   REGISTRATION ENDPOINT                   |        TOKEN ENDPOINT        |
    +------------+------------------------+-----------------------------------------------------------+------------------------------+
    | dev        | https://localhost:9443 | https://localhost:9443/client-registration/v0.14/register | https://localhost:8243/token |
    | production | https://localhost:9444 | https://localhost:9444/client-registration/v0.14/register | https://localhost:8244/token |
    +------------+------------------------+-----------------------------------------------------------+------------------------------+
    ```
### Migrating APIs to different environments

-   [Exporting an API](#MigratingtheAPIsandApplicationstoaDifferentEnvironment-ExportinganAPI)
-   [Importing an API](#MigratingtheAPIsandApplicationstoaDifferentEnvironment-ImportinganAPI)
-   [Importing/exporting an API in a tenanted environment](#MigratingtheAPIsandApplicationstoaDifferentEnvironment-Importing/exportinganAPIinatenantedenvironment)
-   [List APIs](#MigratingtheAPIsandApplicationstoaDifferentEnvironment-ListAPIs)

#### Exporting an API

1.  Make sure that WSO2 API Manager is started and that the CLI import/export tool is running.
2.  Run the following CLI command to export an existing API as a `          .zip         ` archive.

-   [**Command Format**](#Format-exportAPI)
-   [**Example**](#Example-exportAPI)
-   [**Response**](#Reponse-exportAPI)

``` java
    apimcli export-api -n <API-name> -v <version> -r <provider> -e <environment> -u <username> -p <password> -k
```

``` java
    apimcli export-api --name <API-name> --version <version> --provider <provider> --environment <environment> --username <username> --password <password> --insecure
```

!!! note
The username and password are optional flags. You will be prompted to enter your credentials if you do not provide these flags.
**Flags:**

-   Required flags:
    -   `               --name, -n              `
    -   `               --version, -v              `
    -   `               --provider, -r              `
    -   `               --environment, -e              `
    -   `               --insecure, -k : This a               llows connections to SSL sites without certificates                             `
-   Optional flags:
    -   `               --username, -u              `
    -   `               --password, -p              `

``` java
    apimcli export-api -n PhoneVerification -v 1.0.0 -r admin -e dev -u admin -p admin -k
```

``` java
    Succesfully exported API!
    Find the exported API at /Users/kim/.wso2apimcli/exported/apis/dev/PhoneVerification_1.0.0.zip
```

#### Importing an API

You can use the archive created in the previous section to import APIs to an API Manager instance.

1.  Make sure that WSO2 API Manager is started and that the CLI import/export tool is running.

        !!! note
    For Secure Endpoint Enabled APIs:

    If you have enabled secure endpoints when creating the API and your username or/and password differs in the two environments, please follow the steps below before importing the API.

    1. Unzip the .zip archive created in the previous section.

    2. Go to the `           PizzaShackAPI-1.0.0/Meta-information          ` directory and open the `           api.json          ` file.

    3. Modify the `           endpointUTPassword          ` with your endpoint password and save the `           api.json          ` file.

    4. Compress the `           PizzaShackAPI-1.0.0          ` folder to a folder named `           myExportedAPI                       .                     `


-   Run the following CLI command to import an API.

    -   [**Command Format**](#Format-importAPI)
    -   [**Example**](#Example-importAPI)
    -   [**Response**](#ResponseImport)

    ``` java
        apimcli import-api -f <file> -e <environment> -u <username> -p <password> -k
    ```

    ``` java
            apimcli import-api --file <file> --environment <environment> --username <username> --password <password> --insecure
    ```

        !!! note
        The username and password are optional flags. You will be prompted to enter your credentials if you do not provide these flags.
    **Flags:**

    -   Required flags:
        -   `                                   --file, -f : The file path of the exported API. For example, if your file path is                 ` /Users/kim/.wso2apimcli/exported/apis/dev/PhoneVerification\_1.0.0.zip., then you need to enter `                 dev/PhoneVerification_1.0.0.zip                ` as the value for this flag.
        -   `                 --environment, -e : The environment to which you what to import the API to.                `
        -   `                 --insecure, -k : This a                 llows connections to SSL sites without certificates                                 `
    -   Optional flags:
        -   `                 --username, -u                `
        -   `                 --password, -p                `

    ``` java
        apimcli import-api -f dev/PhoneVerification_1.0.0.zip -e production -u admin -p admin -k
    ```

    **Sample Response**

    ``` java
            ZipFilePath: /Users/kim/.wso2apimcli/exported/apis/dev/PhoneVerification_1.0.0.zip
            Successfully imported API 'dev/PhoneVerification_1.0.0.zip'
            Succesfully imported API!
    ```

        !!! tip
    You must add a parameter named `           --preserve-provider          ` to the CLI command and set its value to false if the API is imported to a different domain than its exported one. This parameter sets the provider of the imported API to the user who is issuing the CLI command. Here's an example:

    -   [**Command Format**](#Format-preserve)
    -   [**Example**](#Example-preserve)

    ``` java
        apimcli import-api -k -f <file> -e <environment> -u <username> -p <password> --preserve-provider <preserve_provider>
    ```

    ``` java
            apimcli import-api --insecure --file <file> --environment <environment> -u <username> -p <password> --preserve-provider=<preserve_provider>
    ```

        !!! note
        The username and password are optional flags. You will be prompted to enter your credentials if you do not provide these flags.
    **Flags:**

    -   Required flags:
        -   `                 --insecure, -k :                 This a                 llows connections to SSL sites without certificates                `
        -   `                 --file, -f                `
        -   `                 --environment, -e :                 The environment to which you what to import the API to.                `
        -   `                 --preserve-provider (This does not have a short flag)                `
    -   Optional flags:
        -   `                 --username, -u                `
        -   `                 --password, -p                `

    ``` java
        apimcli import-api -k -f dev/PhoneVerification_1.0.0.zip -e production -u admin -p admin --preserve-provider=false
    ```

        !!! note
    The `           --preserve-provider          ` flag is used to decide whether to keep the actual Provider as the provider of the API or change the provider to the user who is importing the API to a different environment.

    As an example, If `           --preserve-provider          ` is set to true, when importing an API created by user-1 in environment-1 will be preserved as the provider when and after importing that API to environment-2 by user-2. If `           --preserve-provider          ` is set to false, when importing that API created by user-1 to the environment-2, the provider will be changed (not preserved) to user-2 who is importing the API.

        !!! info
    Troubleshooting

    After importing, if the APIs are not visible in the API Publisher UI, do the following to re-index the artifacts in the registry.

    1.  Rename the `             <lastAccessTimeLocation>            ` element in the `             <API-M_2.6.0_HOME>            ` / `             repository/conf/registry.xml            ` file. If you use a **clustered/distributed API Manager setup** , change the file in the API Publisher node. For example, change the `             /_system/local/repository/components/org.wso2.carbon.registry/indexing/lastaccesstime            ` registry path to `             /_system/local/repository/components/org.wso2.carbon.registry/indexing/lastaccesstime_1                           .                         `

    2.  Shut down the API Manager 2.6.0, backup and delete the `             <API-M_2.6.0_HOME>            ` / `             solr            ` directory.

        For more information, see [Upgrading the API Manager to 2.6.0](https://docs.wso2.com/display/AM260/Upgrading+from+the+Previous+Release_2xx) .


#### Importing/exporting an API in a tenanted environment

!!! note
The environments that you create will be common to the admin and the tenants. Therefore, you do not need to create environments again when exporting and importing APIs between tenanted environments.


-   To export an API from a tenant, follow the steps in [Export an API](#MigratingtheAPIsandApplicationstoaDifferentEnvironment-ExportanAPI) . Use the tenant-specific encoded credentials in the CLI command. Here's an example:

    -   [**Command Format**](#Format-exportAPITenant)
    -   [**Example**](#Example-exportAPITenant)
    -   [**Response**](#ResponseExportAPITenant)

    ``` java
        apimcli export-api -n <API-name> -v <version> -r <provider> -e <environment> -u <username> -p <password> -k
    ```

    ``` java
            apimcli export-api --name <API-name> -version <version> --provider <provider> --environment <environment> --username <username> --password <password> --insecure
    ```

        !!! note
        The username and password are optional flags. You will be prompted to enter your credentials if you do not provide these flags.
    **Flags:**

    -   Required flags:
        -   `                 --name, -n                `
        -   `                 --version, -v                `
        -   `                 --provider, -r                `
        -   `                 --environment, -e                 :                 The environment to which you what to export the API to.                `
        -   `                 --insecure, -k : This a                 llows connections to SSL sites without certificates                ` `                                 `
    -   Optional flags:
        -   `                 --username, -u                `
        -   `                 --password, -p                `

    ``` java
        apimcli export-api -n PizzaShackAPI -v 1.0.0 -r chris@test.com -e dev -u chris@test.com -p chris123 -k
    ```

    **Sample Response**

    ``` java
            Succesfully exported API!
            Find the exported API at /Users/kim/.wso2apimcli/exported/apis/dev/PizzaShackAPI_1.0.0.zip
    ```

-   To import the API in another tenant, follow the steps in Importing an API. Use the encoded credentials for this tenant in the CLI command. Here's an example:

    -   [**Command Format**](#Format-importAPI)
    -   [**Example**](#Example-importAPI)
    -   [**Response**](#Response-importAPITenant)

    ``` java
            apimcli import-api -f <file> -e <environment> -u <username> -p <password>
    ```

    ``` java
            apimcli import-api --file <file> --environment <environment> --username <username> --password <password> --preserve-provider <preserve_provider>
    ```

        !!! note
        The username and password are optional flags. You will be prompted to enter your credentials if you do not provide these flags.
    **Flags:**

    -   Required flags:
        -   `                 --file, -f                `
        -   `                 --environment, -e : The environment to which you what to import the API to.                `
        -   `                 --insecure, -k : This a                 llows connections to SSL sites without certificates                `
        -   `                 --preserve-provider                `
    -   Optional flags:
        -   `                 --username, -u                `
        -   `                 --password, -p                `

    ``` java
        apimcli import-api -f dev/PizzaShackAPI_1.0.0.zip -e production -u nick@example.com -p nick123 --preserve-provider=false -k
    ```

    ``` java
            ZipFilePath: /Users/kim/.wso2apimcli/exported/apis/dev/PizzaShackAPI_1.0.0.zip
            Successfully imported API 'dev/PizzaShackAPI_1.0.0.zip'
            Succesfully imported API!
    ```

    Note that the `           --preserve-provider          ` flag value should be set to `           false          ` .

#### List APIs

1.  Make sure that WSO2 API Manager is started and that the CLI import/export tool is running.
2.  Run the following CLI command to list the APIs.

-   [**Command Format**](#Format-listAPI)
-   [**Example**](#Example-listAPI)
-   [**Response**](#Response-listAPI)

``` java
    apimcli list apis -e <environment> -u <username> -p <password> -k            
```

``` java
    apimcli list apis --environment <environment> --username <username> --password <password> --insecure
```

**Flags:**

-   Required flags:
    -   `               --environment, -e              `
    -   `               --insecure, -k                             `
-   Optional flags:
    -   `               --username, -u              `
    -   `                --password, -p               `

                !!! note
        The username and password are optional flags. You will be prompted to enter your credentials if you do not provide these flags.


``` java
    apimcli list apis -e dev -u admin -p admin -k
```

``` java
    Environment: dev
    No. of APIs: 2
    +-------------------+---------+--------------+-----------+----------+--------------------------------------+
    |       NAME        | VERSION |   CONTEXT    |  STATUS   | PROVIDER |                  ID                  |
    +-------------------+---------+--------------+-----------+----------+--------------------------------------+
    | PhoneVerification | 1.0.0   | /phoneverify | PUBLISHED | admin    | 2f25b332-4007-4c83-8249-b14b8af04848 |
    | PizzaShackAPI     | 1.0.0   | /pizzashack  | PUBLISHED | admin    | 59e81b69-24d2-4fc4-9aaa-40665e119261 |
    +-------------------+---------+--------------+-----------+----------+--------------------------------------+
```

------------------------------------------------------------------------

### Migrating applications to different environments

-   [Managing application lifecycle](#MigratingtheAPIsandApplicationstoaDifferentEnvironment-Managingapplicationlifecycle)
-   [Exporting an application](#MigratingtheAPIsandApplicationstoaDifferentEnvironment-Exportinganapplication)
-   [Importing an application](#MigratingtheAPIsandApplicationstoaDifferentEnvironment-Importinganapplication)
-   [Importing applications in a single tenant environment](#MigratingtheAPIsandApplicationstoaDifferentEnvironment-Importingapplicationsinasingletenantenvironment)
-   [Importing applications in a multi-tenant environment](#MigratingtheAPIsandApplicationstoaDifferentEnvironment-Importingapplicationsinamulti-tenantenvironment)
-   [List apps](#MigratingtheAPIsandApplicationstoaDifferentEnvironment-Listapps)

#### Managing application lifecycle

The lifecycle of an application could be defined as the stages of an application between the development and production environments. The feature facilitates to manage the application life cycle by allowing the user to migrate the applications within desired environments. The user should have admin permissions in order to use this.
![](attachments/103333635/103333639.png)

#### Exporting an application

You can export applications in the API Store and download them as a zipped file.

1.  Make sure that WSO2 API Manager is started and that the CLI import/export tool is running.
2.  Run the following CLI command to export an existing application as a `          .zip         ` archive.

-   [**Command Format**](#Format-exportApp)
-   [**Example**](#Example-exportapp)
-   [**Response**](#Response-exportapp)

``` java
    apimcli export-app -n <application-name> -o <owner> -e <environment> -u <username> -p <password> -k
```

``` java
    apimcli export-app --name <application-name> --owner <owner> --environment <environment> --username <username> --password <password> --insecure
```

!!! note
The username and password are optional flags. You will be prompted to enter your credentials if you do not provide these flags.
**Flags:**

-   Required flags:
    -   `               --name, -n              `
    -   `               --owner, -o              `
    -   `               --environment, -e : The environment to which you what to export the application to.              `
    -   `               --insecure, -k : This a               llows connections to SSL sites without certificates              `
-   Optional flags:
    -   `               --username, -u              `
    -   `               --password, -p              `

``` java
    apimcli export-app -n SampleApp -o admin -e dev -u admin -p admin -k
```

``` java
    Succesfully exported Application!
    Find the exported Application at /Users/kim/.wso2apimcli/exported/apps/dev/admin_SampleApp.zip
```

The zipped file will be as follows:

`         <exported-Application>.zip        `
`         └── <Application-Name>        `
`         └── <Application-Name>.json        `

#### Importing an application

You can import an application to your environment as a zipped application. When you import an application as a zipped file, a new application is created within the target environment.

1.  Make sure that WSO2 API Manager is started and that the CLI import/export tool is running.
2.  Run the following CLI command to import an existing ap plicatio n as a `          .zip         ` archive.

-   [**Command Format**](#Format-importApp)
-   [**Example**](#Example-importapp)
-   [**Response**](#Reponse-importapp)

``` java
    apimcli import-app -f <file> -e <environment> -s <skip_subscriptions> -o <owner> -r <preserve_owner> -k            
```

``` java
    apimcli import-app --file <file> --environment <environment> --skipSubscriptions <skip_subscriptions> --owner <owner> --preserveOwner <preserve_owner> --insecure
```

!!! note
The username and password are optional flags. You will be prompted to enter your credentials if you do not provide these flags.
**Flags:**

-   Required flags
    -   `                                                --file, -f : The file path of the exported App. For example, if your file path is /Users/kim/.wso2apimcli/exported/apps/dev/admin_SampleApp.zip                ` `               ,              ` then you need to enter `               dev/               admin_SampleApp.zip              ` as the value for this flag.
    -   `               --environment, -e : The environment to which you what to import the application to.              `
    -   `               --insecure, -k : This a               llows connections to SSL sites without certificates              ` `                             `
-   Optional flags
    -   `               --skipSubscriptions, -s              `
        You can opt to skip importing the subscriptions of the application by defining this flag. This parameter is set to false by default.
    -   `               --owner, -o              ` The owner of the imported application can be specified by providing an username of a valid user based on your preference. The application importer can set the preferred owner’s username as the value of the `               --owner              ` or `               -o              ` flag.
    -   `               --preserveOwner, -r              `
        You can also import the application by preserving the application owner information, from the previous environment. The application importer can add the --preserveOwner or -r flag in order to define that this flag is set to true. This parameter is set to false by default. Therefore, the default value is used when you do not define this flag. If you import the application without specifying any of the optional flags, you will be added as the owner of the application in the imported environment. If both the `               --owner              ` and the `               --preserveOwner              ` flags are set, then the `               --owner              ` flag gets higher priority over the `               --preserveOwner              ` flag. `              `

``` java
    apimcli import-app -f dev/admin_SampleApp.zip -e production -o admin --preserveOwner --skipSubscriptions -u admin -p admin -k
```

``` java
    ZipFilePath: /Users/kim/.wso2apimcli/exported/apps/dev/admin_SampleApp.zip
    Completed importing the Application 'dev/admin_SampleApp.zip'
    Succesfully imported Application!
```

#### Importing applications in a single tenant environment

There are three options to import applications in a single tenant environment.

-   Application A in environment 1 is migrated to environment 2. Some APIs may not be available in environment 2 (API B in this case) and the relevant subscriptions are not added in such cases (skipped).
    ![](attachments/103333635/103333637.png)

-   A different owner can be specified while importing an application to environment 2,  without preserving the original user of environment 1.
    ![](attachments/103333635/103333638.png)
-   The original owner of the application can be preserved when the application is imported to environment 2 by adding the `           --preserveOwner          ` flag.
    ![](attachments/103333635/103333636.png)

#### 
Importing applications in a multi-tenant environment

In a situation where an application has API subscriptions in different tenant domains, such subscriptions are added if the relevant APIs with the target tier, are available in the importing environment. Note that the provider of the API may not be the same in the importing environment.

#### List apps

1.  Make sure that WSO2 API Manager is started and that the CLI import/export tool is running.
2.  Run the following CLI command to list the apps.

-   [**Command Format**](#Format-listApps)
-   [**Example**](#Example-listApps)
-   [**Response**](#Response-listApps)

``` java
    apimcli list apps -e <environment> -u <username> -o <owner> -p <password> -k             
```

``` java
    apimcli list apps --environment <environment> --owner <owner> --username <username> --password <password> --insecure
```

**Flags:**

-   Required flags
    -   `               --environment, -e              `
    -   `               --owner, -o              `
    -   `               --insecure, -k : This a               llows connections to SSL sites without certificates                             `
-   Optional flags
    -   `               --username, -u              `
    -   `               --password, -p              `

!!! note
The username and password are optional flags. You will be prompted to enter your credentials if you do not provide these flags.

``` java
    apimcli list apps -e dev -o admin -u admin -p admin -k
```

``` java
    Environment: production
    No. of Applications: 2
    +--------------------------------------+--------------------+-------+----------+----------+
    |                  ID                  |        NAME        | OWNER |  STATUS  | GROUP-ID |
    +--------------------------------------+--------------------+-------+----------+----------+
    | e13b5bcf-dee5-48fe-9f23-bf46fc17a378 | DefaultApplication |       | APPROVED |          |
    | 153ad3d3-fa26-4dda-af54-27eee3327848 | TestApp            |       | APPROVED |          |
    +--------------------------------------+--------------------+-------+----------+----------+
```

------------------------------------------------------------------------

### Reset user

1.  Make sure that WSO2 API Manager is started and that the CLI import/export tool is running.
2.  Run the following CLI command to reset user details.

    -   [**Command Format**](#Format-ResetUser)
    -   [**Example**](#Example-ResetUser)
    -   [**Response**](#ResponseClearUser)

    ``` java
            apimcli reset-user -e <environment>
    ```

    ``` java
            apimcli reset-user --environment <environment>
    ```

    **Flags:**

    -   Required flags
        -   `                 --environment, -e                `

    ``` java
            apimcli reset-user -e dev
    ```

    ``` java
            Successfully cleared user data for environment: dev
    ```

### Check the version of the CLI

1.  Make sure that WSO2 API Manager is started and that the CLI import/export tool is running.
2.  Run the following CLI command to check the version of the CLI.
    There are no flags for the following CLI command.

    -   [**Command**](#Format-CLIver)
    -   [**Example**](#Example-CLIver)

    ``` java
            apimcli version
    ```

    ``` java
            apimcli Version: 1.1.0
    ```

### Set HTTP request timeout

1.  Make sure that WSO2 API Manager is started and that the CLI import/export tool is running.
2.  Run the following CLI command to set the HTTP request timeout.

    -   [**Command Format**](#Format-RstTime)
    -   [**Example**](#Example-RstTime)

    ``` java
            apimcli set --http-request-timeout <http-request-timeout>
    ```

    **Flags:**

    -   `                --http-request-timeout               `

    ``` java
            apimcli set --http-request-timeout 10000
    ```

### Set export directory

1.  Make sure that WSO2 API Manager is started and that the CLI import/export tool is running.
2.  Run the following CLI command to the change the default location of the export directory.

    -   [**Command Format**](#Format-expDir)
    -   [**Example**](#Example-expDir)

    ``` java
            apimcli set --export-directory <export-directory-path>
    ```

    **Flags:**

    -   `                --export-directory               `

    ``` java
            apimcli set --export-directory /Users/mariangela/Downloads/MyExports
    ```

------------------------------------------------------------------------

### Understanding the API import/export tool

The API import/export tool uses a RESTful API, protected by basic authentication.

!!! note
Only the following types of users are allowed to access the API import/export tool.

-   A user with the admin role.
-   A user with a role that has the API-M Admin, Login, and API Create permissions.

    ![](images/icons/grey_arrow_down.png){.expand-control-image} Click here to see a screen shot of the above listed permissions.

    ![](attachments/103333635/103333643.png)

To allow access to the import/export feature only for a particular tenant, log in to WSO2 API Manager's Management Console and add the downloaded archive file as a web application to the server.

!!! note
The 'admin' role is the default role which is specified in the Realm configuration in the `         <API-M-HOME>/repository/conf/user-mgt.xml        ` file. It will be changed if you have changed the value of the `         <AdminRole>        ` parameter as shown below.

``` java
    <Realm>
            <Configuration>
            <AddAdmin>true</AddAdmin>
                <AdminRole>admin</AdminRole>            
             .....
           </Configuration>
    </Realm>
```


#### The export functionality

The API export functionality retrieves the information required for the requested API from the registry and databases and generates a ZIP file, which the exporter can download. This exported ZIP file has the following structure:

![Structure of the exported ZIP file](attachments/103333635/103333641.png)
The structure of the ZIP file is explained below:

| Sub directory/File | Description                                                                                                                                 |
|--------------------|---------------------------------------------------------------------------------------------------------------------------------------------|
| Meta Information   | -   `                api.json:               ` contains all the basic information required for an API to be imported to another environment 
                                                                                                                                               
  -   `                swagger.json:               ` contains the API swagger definition                                                       |
| Documents          | -   `                docs.json:               ` contains the summary of all the documents available for the API                             
                                                                                                                                               
  -   Add the uploaded files for API documentation also                                                                                        |
| Image              | Thumbnail image of the API                                                                                                                  |
| WSDL               | WSDL file of the API                                                                                                                        |
| Sequences          | The sequences available for the API                                                                                                         |

#### The import functionality

The import functionality uploads the exported ZIP file of the API to the target environment. It creates a new API with all the registry and database resources exported from the source environment. Note the following:

-   The lifecycle status of an imported API will always be `          CREATED         ` even when the original API in the source environment has a different state. This is to enable the importer to modify the API before publishing it.
-   Tiers and sequences are provider-specific. If an exported tier is not already available in the imported environment, that tier is not added to the new environment. However, if an exported sequence is not available in the imported environment, it is added.
-   The importer can decide whether to keep the original provider’s name or replace it. Set the `                     --preserve-provider                   ` flag to true to keep it. If you set it to false, the original provider is replaced by the user who is sending the CLI command.
-   Cross-tenant imports are not allowed by preserving the original provider. For example, if an API is exported from tenant A and imported to tenant B, the value of the `          --preserve-provider         ` flag must always be `          false         ` .

