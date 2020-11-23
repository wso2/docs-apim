# Micro Integrator CLI

The Micro Integrator CLI allows you to monitor the synapse artifacts (deployed in a specified Micro Integrator server) and perform various management and administration tasks from the command line. The CLI (as well as the [dashboard](../../administer-and-observe/working-with-monitoring-dashboard)) communicates with the management API of WSO2 Micro Integrator to function.

## Installing the CLI

To download the CLI:

1.  Go to [**WSO2 Enterprise Integrator** website](https://wso2.com/integration/) -> **Download** -> **Other Resources**, and click **CLI Tooling**.
2.  If you are using a UNIX-based operating system (Linux, Solaris, and Mac OS X), be sure to set the `MI_CLI_HOME/bin` folder path as the PATH:

    ```bash
    export PATH=/path/to/mi/cli/directory/bin:$PATH
    ```

## Using the CLI

1. **Start the CLI**

    Execute the following command to start the CLI:

    ```bash
    mi
    ```

    The available commands are listed as follows:

    ```bash
    mi is a Command Line Tool for Management of WSO2 Micro Integrator

    Usage:
      mi [command]

    Available Commands:
      api              Manage deployed Apis
      compositeapp     Manage deployed Composite Apps
      connector        Manage connectors
      dataservice      Manage deployed data services
      endpoint         Manage deployed Endpoints
      help             Help about any command
      inboundendpoint  Manage deployed Inbound Endpoints
      localentry       Manage localentries
      log-level        Manage log4j2 properties
      logs             List / download log files
      messageprocessor Manage messageprocessors
      messagestore     Manage messagestores
      proxyservice     Manage deployed Proxy Services
      remote           Add, login to, logout of, remove, update or select Micro Integrator
      secret           Manage sensitive information
      sequence         Manage deployed Seqeunces
      task             Manage deployed Tasks
      template         Manage templates
      transaction      Retrieve transaction count information
      user             Manage users
      version          Version of the CLI

    Flags:
      -h, --help      help for ./mi
      -v, --verbose   Enable verbose mode
    ```

2. **Add MI servers**

    By default, the CLI connects to the management API of the Micro Integrator server that is running on <b>localhost</b>, which you can start using immediately. 

    However, when your Micro Integrator is running on a different host and port, or when you have multiple Micro Integrator servers running, you can connect them as remote servers to the CLI.

    Execute the following command to add servers:

    ```bash
    mi remote add <server-name> <hostname> <port>
    ```

    Find out more about the `mi remote` option in the [CLI Reference](#mi-remote).

3. **Select MI server**

    If your Micro Integrator server is not running on <b>localhost</b>, you need to first select the required server.

    Execute the following command to find all the servers that are connected to the CLI:

    ```bash
    mi remote show
    ```

    The connected servers are listed. See the following example:

    ```bash
    remotes:
      TestServer:
        remote_address: 192.168.1.15
        remote_port: "9165"
        access_token: ""
      default:
        remote_address: localhost
        remote_port: "9164"
        access_token: eyJraWQiOiJkMjU5MDU1YS1mYTBmLTRkZTAtYWM5OS01ZjY1YzZhMDc3ZGYiLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlzcyI6Imh0dHBzOlwvXC8xMjcuMC4wLjE6OTE2NFwvIiwiZXhwIjoxNTk0NDcwODIxfQ.Hp41iNSTSI_xCCc2iwJxYVMq-gIsDCZQqw2V7GlhIJjdTHcBR3ijm1x-S8dP6Q04oFaVnoulT2oJ7wKANwxXA9LD1ASXlmUGpsrfgFWtAtYtEqtN_MHHh2wTn6Y38VUx7d8fuqPYYoOV_f1Orh8rN_AzilIf2YhQj6qw5Gjw8Z4Zl9IlVazYtAk7ZcNsUyKB0xRLjfDdc_XhAt70wePgFLH0EmP0RuLaSDbkWfiAGeEw77RIrAudzMdIHr6RaaKo-fp4nLzSuCMo_IdbdgybdBYWbEq0OtzRSK2HlHWRqYAjRyecUHHDLL-fnZAONmfY6MF5RTYyaoV8izQeca1DUA
    current_remote: default
    ```

    To change the <b>current_remote</b> of the CLI, execute the following command:

    ```bash
    mi remote select <server-name>
    ```

4.  **Log in**

    Execute the following command to log in to the selected server. You will be prompted to enter the username and password.

    ```bash
    mi remote login
    ```

    Alternatively, you can pass the user name and password in a single command:

    !!! Note
        If you are on **Windows**, you must always log in with the following command.

    ```bash
    mi remote login [username] [password]
    ```

    To logout from the CLI, use the following command:

    ```bash
    mi remote logout
    ```

Once you are logged in to a Micro Integrator server's management API, you can use the available options and commands to manage artifact deployments and to perform other adminstration tasks.

## CLI Reference

### global flags

The following global flags can be used with all the `mi` options and commands. 

```bash
--verbose    Enable verbose logs (provides more information on execution).
--help, -h   Display information and usage examples of a command.
```

### mi

Use `mi` to initialize the CLI tool.

```bash
mi
```

### mi version

Use the `version` option to get the version of the running CLI tool.

```bash
mi version
```

### mi remote

Use `remote` to manages the remote servers connected to the CLI tool. The CLI can be connected to multiple running Micro Integrator servers, however, you can only log in to one at a time.

Usage

```bash
mi remote <COMMAND> <ARGUMENTS>
```

Commands and Arguments

```bash
add <server-name> <host> <api-port>      Connect a Micro Integrator server to the CLI.
remove <server-name>                     Remove a Micro Integrator server from the CLI. 
update <server-name> <host> <api-port>   Update the host and the management api port of a Micro Integrator server.
show                                 Show the Micro Integrator servers connected to the CLI.
select <server-name>                 Select one Micro Integrator server to manage.
login                                Log in to use the management API of the selected server (will be prompted for username and password). This should be a valid user that is stored in the Micro Integrator user store.
login <username> <password>          Log in to use the management API of the selected server (inline username and password).
```

Examples

```bash
# To add a Micro Integrator
mi remote add TestServer 192.168.1.15 9164

# To remove a Micro Integrator
mi remote remove TestServer

# To update a Micro Integrator
mi remote update TestServer 192.168.1.17 9164

# To show available Micro Integrators
mi remote show

# To select a Micro Integrator
mi remote select TestServer

# login to the current (selected)  Micro Integrator instance
mi remote login     # will be prompted for username and password

# login (with inline username and password)
mi remote login admin admin
```

### mi logs

Use `logs` to list all the log files created for the Micro Integrator server.

Usage

```bash
mi logs <COMMAND> <ARGUMENTS>
```

Commands and Arguments

```bash
show    Show the complete list of log files created.
```

Examples

```bash
# To list all the log files
mi logs show
```

### mi log-level

Use `log-level` to manage the logging configurations in a Micro Integrator server.

Usage

```bash
mi log-level <COMMAND> <ARGUMENTS>
```

Commands and Arguments

```bash
show [logger-name]                   Show information about a logger.
update [logger-name] [class-name] [log-level] Update the log level of existing logger or add new logger.  The possible values for log level: DEBUG, INFO, WARN, ERROR, TRACE, FATAL, OFF.
```

Examples

```bash
# Show information about a logger
mi log-level show org-apache-coyote

# Update the log level of an existing logger
mi log-level update org-apache-coyote DEBUG

# Add a new logger
mi log-level update synapse-api org.apache.synapse.rest.API DEBUG
```

### mi api

Use `api` to get details of API artifacts deployed in the Micro Integrator server.

Usage

```bash
mi api <COMMAND> <ARGUMENTS>
```

Commands and Arguments

```bash
show               Show the list of API artifacts deployed in the Micro Integrator server.
show [api-name]    Get information about a specific API that is deployed in the Micro Integrator server.
```

Examples

```bash
# To list all the apis
mi api show

# To get details about a specific api
mi api show sampleApi
```

### mi compositeapp

Use `compositeapp` to get details of the composite applications (CApps) that are deployed in the Micro Integrator server.

Usage

```bash
mi compositeapp <COMMAND> <ARGUMENTS>
```

Commands and Arguments

```bash
show                  Show the list of composite applications deployed in the Micro Integrator server.
show [app-name]       Show information about a specific composite application.
```

Examples:

```bash
# To list all the composite apps
mi compositeapp show

# To get details of a specific composite app
mi compositeapp show sampleApp
```

### mi endpoint

Use `endpoint` to manage endpoint aritfacts deployed in the Micro Integrator server.

Usage

```bash
mi endpoint <COMMAND> <ARGUMENTS>
```

Commands and Arguments

```bash
show                                            Show the list of endpoint artifacts deployed in the Micro Integrator server.
show [endpoint-name]                            Show information about a specific endpoint deployed in the Micro Integrator server.
update [endpoint-name] state [active|inactive]  Activate or deactive the status of a specific endpoint. Use 'active' or 'inactive' as values for the status. 
```

Examples

```bash
# To list all the endpoints
mi endpoint show

# To get details about a specific endpoint
mi endpoint show sampleEndpoint

# To deactive an endpoint
mi endpoint update sampleEndpoint state inactive

# To active an inactive endpoint
mi endpoint update sampleEndpoint state active
```

### mi inboundendpoint

Use `inboundendpoint` to get details of inbound endpoint artifacts deployed in the Micro Integrator server.

Usage

```bash
mi inboundendpoint <COMMAND> <ARGUMENTS>
```

Commands and Arguments

```bash
show                             Show the list of inbound endpoint artifacts deployed in the Micro Integrator server.
show [inboundendpoint-name]      Show information about a specific inbound endpoint deployed in the Micro Integrator server.
```

Examples:

```bash
# To list all the inbound endpoints
mi inboundendpoint show

# To get details about a specific inbound endpoint
mi inboundendpoint show sampleInboundEndpoint
```

### mi proxyservice

Use `proxyservice` to manage the proxy service artifacts deployed in the Micro Integrator server.

Usage

```bash
mi proxyservice <COMMAND> <ARGUMENTS>
```

Commands and Arguments

```bash
show                                                Show the list of proxy service artifacts deployed in the Micro Integrator server.
show [proxyservice-name]                            Show information about a specific proxy service deployed in the Micro Integrator server.
update [proxyservice-name] state [active|inactive]  Activate or deactive the status of a specific proxy service. Use 'active' or 'inactive' as the status value. 
```

Examples

```bash
# To list all the proxy services
mi proxyservice show

# To get details about a specific proxy service
mi proxyservice show sampleProxy

# To deactive a proxy service
mi proxyservice update sampleProxy state inactive

# To active an inactive proxy service
mi proxyservice update sampleProxy state active
```

### mi sequence

Use `sequence` to get details of the sequence artifacts deployed in the Micro Integrator server.

Usage

```bash
mi sequence <COMMAND> <ARGUMENTS>
```

Commands and Arguments

```bash
show                     Show the list of sequence artifacts deployed in the Micro Integrator server.
show [sequence-name]     Show information about a specific sequence deployed in the Micro Integrator server.
```

Examples

```bash
# To list all the sequences
mi sequence show

# To get details about a specific sequence
mi sequence show sampleProxy
```

### mi task

Use `task` to get details of the scheduled tasks deployed in the Micro Integrator server.

Usage

```bash
mi task <COMMAND> <ARGUMENTS>
```

Commands and Arguments

```bash
show                  Show the list of schedued task artifacts deployed in the Micro Integrator server.
show [task-name]      Show information about a specific scheduled task artifact deployed in the Micro Integrator server.
```

Examples

```bash
# To list all the tasks
mi task show

# To get details about a specific task
mi task show sampleTask
```

### mi dataservice

Use `dataservice` to get details of data service artifacts deployed in the Micro Integrator server.

Usage

```bash
mi dataservice <COMMAND> <ARGUMENTS>
```

Commands and Arguments

```bash
show                          Show the list of data service artifacts deployed in the Micro Integrator server.
show [data-service-name]      Show information about a specific data service artifact deployed in the Micro Integrator server.
```

Examples

```bash
# To list all the dataservices
mi dataservice show

# To get details about a specific task
mi dataservice show SampleDataService
```

### mi connector

Use `connector` to get details of connector artifacts deployed in the Micro Integrator server.

Usage

```bash
mi connector <COMMAND> <ARGUMENTS>
```

Commands and Arguments

```bash
show                      Show the list of connector artifacts deployed in the Micro Integrator server.
show [connector-name]     Show information about a specific connector that is deployed in the Micro Integrator server.
```

Examples

```bash
 # To list all the connectors
 mi connector show

 # To get details about a specific connector
 mi connector show sampleConnector
```

### mi template

Use `template` to get details of template artifacts (**Endpoint** templates and **Sequence** templates) that are deployed in the Micro Integrator server.

Usage 

```bash
mi template <COMMAND> <ARGUMENTS>
```

Commands and Arguments

```bash
show                                   Show all templates deployed in the Micro Integrator server.
show  [template-type]                  Show the list of templates matching the given template type, which are deployed in the Micro Integrator server. Use 'endpoint' or 'sequence' as the template type value.
show  [template-type] [template-name]  Show details of a specific template artifact. Specify both the template type and template name as arguments. Use 'endpoint' or 'sequence' as the template type value.
```

Examples

```bash
 # To list all the templates
 mi template show

 # To list all the endpoint templates
 mi template show endpoint

 # To list all the sequence templates
 mi template show sequence

 # To get details of a specific endpoint template
 mi template show endpoint sampleEndpointTemplate

 # To get details of a specific sequence template
 mi template show sequence sampleSequenceTemplate
```

### mi messageprocessor

Use `messageprocessor` to manage message processor artifacts deployed in the Micro Integrator server.

Usage

```bash
mi messageprocessor <COMMAND> <ARGUMENTS>
```

Commands and Arguments

```bash
show                                                    Show the list of messsage processor artifacts deployed in the Micro Integrator server.
show  [messageprocessor-name]                           Show information about a specific message processor artifact deployed in the Micro Integrator server.
update [messageprocessor-name] state [active|inactive]  Activate or deactive the status of a specific message processor. Use 'active' or 'inactive' as values for the status.
```

Examples

```bash
 # To list all the message processors
 mi messageprocessor show

 # To get details of a specific message processor
 mi messageprocessor show  sampleMessageProcessor

 # To deactive a message processor
mi messageprocessor update sampleMessageProcessor state inactive

# To active an inactive message processor
mi messageprocessor update sampleMessageProcessor state active
```

### mi messagestore

Use `messagestore` to get details of message store artifacts deployed in the Micro Integrator server.

Usage

```bash
mi messagestore <COMMAND> <ARGUMENTS>
```

Commands and Arguments

```bash
show                       Show the list of message store artifacts deployed in the Micro Integrator server.
show  [messagestore-name]  Show information of a specific message store artifact that is deployed in the Micro Integrator server.
```

Examples

```bash
 # To list all the message stores
 mi messagestore show

 # To get details of a specific message stores
 mi messagestore show  sampleMessageStore
```

### mi localentry

Use `localentry` to get details of local entry artifacts deployed in the Micro Integrator server.

Usage

```bash
mi localentry <COMMAND> <ARGUMENTS>
```

Commands and Arguments

```bash
show                     Show the list of localentry artifacts deployed in the Micro Integrator server.
show  [localentry-name]  Show information of a specific local entry artifact that is deployed in the Micro Integrator server.
```

Examples

```bash
# To list all the local entries
mi localentry show

# To get details of a specific local entry
mi localentry show  sampleLocalEntry
```

### mi user

Use `user` to manage the users in the Micro Integrator's user store. Note that only users assigned to the <b>admin</b> user role can manage other users in the user store.

Usage

```bash
mi user <COMMAND> <ARGUMENTS> <FLAGS>
```

Commands and Arguments

```bash
add [username]                           Add new user to the Micro Integrator user store. Specify (as arguments) the user name. You will be prompted to provide password, and whether the admin role should be assigned to the new user. Use 'true' or 'false' for the 'Is an admin [y/N]' argument.
remove [username]                        Remove an existing user by specifying the user name.
show                                     Show the list of users created in the user store.
show [username]                          Show details of a specific user that is in the user store.
show <FLAG>                              Show the list of users matching the regex pattern or user role that is specified as a flag.
```

Flags

```bash
-p, --pattern    Specify a regex as a user name pattern.
-r, --role       Specify a user role to fetch a users. You can use the 'admin' user role or any other role that is stored in the user store. 
```   

Examples

```bash
# To add a new user. This option is only available for admin users. 
mi user add userid 

# To remove a user
mi user remove userid

# To list all the users
mi user show

# To list user by user ID
mi user show userid

# To list users by user role
mi user show -r dev-role

# To list users matching a user name pattern. You can use the wild card symbol "*" (at the start and/or end of pattern) to define a pattern. Example: '*mi*'
mi user show -p [user name pattern]
```

### mi secret

Use `secret` to encrypt plain text secrets that you will use in server configurations (`deployment.toml` file) and synapse configurations. Secrets encrypted using the CLI are used when you want to dynamically inject encrypted secrets to the Micro Integrator.

Usage

```bash
mi secret <COMMAND> <ARGUMENTS> <FLAGS>
```

Commands and Arguments

```bash
init             Initialize the keystore that is used for encryption. You are prompted to give the 'keystore_path/keystore_file_name' when you initialize.
create           Create an encrypted secret. You will be prompted to provide an alias and the actual plain text secret that you want to encrypt.
create file      Create the encrypted secret and export it to a file.
create k8        Create the encrypted secret and export it to a .yaml file that you can use in a kubenetes environment.
```

Flags

```bash
-f      Use a .properties file to input multiple plain text secrets.
```

Examples

```bash
 # To initialize keystore information
 mi secret init

 # To encrypt secret and get output on console
 mi secret create

 # To encrypt secret and get output to file (stored in the <CLI_HOME>/security folder).
 mi secret create file

 # To encrypt secret and get output as a .yaml file (stored in the <CLI_HOME>/security folder).
 mi secret create k8

 # To bulk encrypt secrets defined in a properties file.
 mi secret create -f=</file_path>

 # To bulk encrypt secretes defined in a properties file and get a .yaml file (stored in the <CLI_HOME>/security folder).
 mi secret create k8 -f=</file_path>
```

### mi transaction

Use `transaction` to count the inbound transactions received by the Micro Integrator.

Usage

```bash
mi transaction <COMMAND> <ARGUMENTS> <FLAGS>
```

Commands and Arguments

```bash
count                                    Get transaction count for the current month.
count [year] [month]                     Get transaction count for the specified year and month.
report [start] [end] [--path[=<path>]]   Generate transaction report for the specified period and store in the specified location.
report [start] [end]                     Generate transaction report for the specified date and store in the current location.
report [start] [--path[=<path>]]         Generate transaction report from the specified date upto current date and store in the specified location.
```

Flags

```bash
-p, --path      Specify a directory path to create the transaction count report. Applicable only to the 'report' command.
```

Examples

```bash
 # To get the transaction count for the current month
 mi transaction count

 # To get the transaction count for 2020/05 [YYYY/MM]
 mi transaction count 2020 05

 # To generate transaction count report with data between 2020-01 and 2020-05 at the specified location
 mi transaction report 2020-01 2020-05 --path=</dir_path>

 # To generate transaction count report with data from 2020-01 (upto current date) at the specified location
 mi transaction report 2020-01 --path=</dir_path>

 # To generate transaction count report at the current location for data between 2020-01 and 2020-05
 mi transaction report 2020-01 2020-05

```
