# Promoting Applications Through CICD

WSO2 API Manager (WSO2 API-M) allows you to maintain multiple environments running on the same WSO2 API-M version. This feature allows you to import and export applications between your environments. For example, if you have an application running in the development environment, you can import it and export to the test(QA) environment. Thereby, applications do not have to be created from scratch in different environments.

-   [Getting Started](#PromotingApplicationsThroughCICD-GettingStarted)
-   [Migrating applications to different environments](#PromotingApplicationsThroughCICD-Migratingapplicationstodifferentenvironments)
-   [Reset user](#PromotingApplicationsThroughCICD-Resetuser)
-   [Check the version of the CLI](#PromotingApplicationsThroughCICD-ChecktheversionoftheCLI)
-   [Set HTTP request timeout](#PromotingApplicationsThroughCICD-SetHTTPrequesttimeout)
-   [Set export directory](#PromotingApplicationsThroughCICD-Setexportdirectory)

### Getting Started

!!! note
After running the CLI tool make sure to add an environment before you start working with the import/export CLI commands, because all applications need to be imported or exported to a specific environment.


------------------------------------------------------------------------

### Migrating applications to different environments

-   [Managing application lifecycle](#PromotingApplicationsThroughCICD-Managingapplicationlifecycle)
-   [Exporting an application](#PromotingApplicationsThroughCICD-Exportinganapplication)
-   [Importing an application](#PromotingApplicationsThroughCICD-Importinganapplication)
-   [Importing applications in a single tenant environment](#PromotingApplicationsThroughCICD-Importingapplicationsinasingletenantenvironment)
-   [Importing applications in a multi-tenant environment](#PromotingApplicationsThroughCICD-Importingapplicationsinamulti-tenantenvironment)
-   [List apps](#PromotingApplicationsThroughCICD-Listapps)

#### Managing application lifecycle

The lifecycle of an application could be defined as the stages of an application between the development and production environments. The feature facilitates to manage the application life cycle by allowing the user to migrate the applications within desired environments. The user should have admin permissions in order to use this.
![](/assets/attachments/103333635/103333639.png)

#### Exporting an application

You can export applications in the API Store and download them as a zipped file.

1.  Make sure that WSO2 API Manager is started and that the CLI import/export tool is running.
2.  Run the following CLI command to export an existing application as a `.zip` archive.

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
    -`--name, -n              `
    -`--owner, -o              `
    -`--environment, -e : The environment to which you what to export the application to.              `
    -`--insecure, -k : This a               llows connections to SSL sites without certificates              `
-   Optional flags:
    -`--username, -u              `
    -`--password, -p              `

``` java
    apimcli export-app -n SampleApp -o admin -e dev -u admin -p admin -k
```

``` java
    Succesfully exported Application!
    Find the exported Application at /Users/kim/.wso2apimcli/exported/apps/dev/admin_SampleApp.zip
```

The zipped file will be as follows:

`<exported-Application>.zip        `
`└── <Application-Name>        `
`└── <Application-Name>.json        `

#### Importing an application

You can import an application to your environment as a zipped application. When you import an application as a zipped file, a new application is created within the target environment.

1.  Make sure that WSO2 API Manager is started and that the CLI import/export tool is running.
2.  Run the following CLI command to import an existing ap plicatio n as a `.zip` archive.

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
    -`--file, -f : The file path of the exported App. For example, if your file path is /Users/kim/.wso2apimcli/exported/apps/dev/admin_SampleApp.zip,` then you need to enter `dev/               admin_SampleApp.zip` as the value for this flag.
    -`--environment, -e : The environment to which you what to import the application to.              `
    -`--insecure, -k : This a               llows connections to SSL sites without certificates`
-   Optional flags
    -`--skipSubscriptions, -s              `
        You can opt to skip importing the subscriptions of the application by defining this flag. This parameter is set to false by default.
    -`--owner, -o` The owner of the imported application can be specified by providing an username of a valid user based on your preference. The application importer can set the preferred owner’s username as the value of the `--owner` or `-o` flag.
    -`--preserveOwner, -r              `
        You can also import the application by preserving the application owner information, from the previous environment. The application importer can add the --preserveOwner or -r flag in order to define that this flag is set to true. This parameter is set to false by default. Therefore, the default value is used when you do not define this flag. If you import the application without specifying any of the optional flags, you will be added as the owner of the application in the imported environment. If both the `--owner` and the `--preserveOwner` flags are set, then the `--owner` flag gets higher priority over the `--preserveOwner` flag. ``

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
    ![](/assets/attachments/103333635/103333637.png)

-   A different owner can be specified while importing an application to environment 2,  without preserving the original user of environment 1.
    ![](/assets/attachments/103333635/103333638.png)
-   The original owner of the application can be preserved when the application is imported to environment 2 by adding the `--preserveOwner` flag.
    ![](/assets/attachments/103333635/103333636.png)

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
    -`--environment, -e              `
    -`--owner, -o              `
    -`--insecure, -k : This a               llows connections to SSL sites without certificates                             `
-   Optional flags
    -`--username, -u              `
    -`--password, -p              `

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
        -`--environment, -e                `

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

    -`--http-request-timeout               `

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

    -`--export-directory               `

    ``` java
            apimcli set --export-directory /Users/mariangela/Downloads/MyExports
    ```

------------------------------------------------------------------------


