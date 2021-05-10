# General Data Protection Regulation (GDPR) for WSO2 API Manager

The Forget-Me Tool, which is also referred to as the Identity Anonymization Tool, is pre-packed with WSO2 API Manager. You can use the Forget-Me Tool to obfuscate the identities of an **external user** who was deleted based on the request of the system administrator. This tool removes the user identities stored in the database and in log files in order to meet the GDPR requirements.

## Removing the references of the deleted user identities

Follow the instructions below to remove the references of the deleted user identities stored in WSO2 product databases and log files:

### Step 1 - Optionally, build the Forget-Me Tool

!!! note
    - **Skip** this step if you are **only working with WSO2 API Manager** because you can make use of the pre-packed Forget-Me Tool. 
    
    - This step is **mandatory** in the following scenarios -
         - When you are **working with multiple WSO2 products** and you need to delete the user's identity from all the products at once.
         - When you are **working with a WSO2 product that does not have the Forget-Me Tool pre-packed in it**.

Follow the instructions below to build the Forget-Me Tool:

1. Clone the [https://github.com/wso2/identity-anonymization-tool](https://github.com/wso2/identity-anonymization-tool) repository to a preferred location.

2. Navigate to the `identity-anonymization-tool` directory in the source that you checked out.

    `cd identity-anonymization-tool`

3. Build the Forget-Me Tool.

     Run the following Maven command to build the standalone Forget-Me Tool.

     `mvn clean install`

     This downloads all the dependencies and builds the tool in your local repository. You can find the `org.wso2.carbon.privacy.forgetme.tool-SNAPSHOT.zip` file created in the `identity-anonymization-tool/components/org.wso2.carbon.privacy.forgetme.tool/target` directory.

4. Unzip the `org.wso2.carbon.privacy.forgetme.tool-x.x.x-SNAPSHOT.zip` file. Where `x.x.x` refers to the Forget-Me Tool version.

     This creates the `identity-anonymization-tool-x.x.x-SNAPSHOT` directory with a directory. The path to the `identity-anonymization-tool-x.x.x-SNAPSHOT` directory will be referred to as `<TOOL_HOME>` throughout this section.

### Step 2 - Change the default configurations of the tool

All configurations related to this tool can be found inside the `conf` directory. When working with WSO2 API-M, it will be in the `<API-M_HOME>/repository/components/tools/forget-me/conf` directory, and when working with the standalone Forget-Me Tool, it will be in the `<TOOL_HOME>/conf` directory.

??? info "More information on the configuration related directories and files in the Forget-Me Tool"
    The following table describes the purpose of the most important configuration related directories and files of the tool, which are in the `<API-M_HOME>/repository/components/tools/forget-me/conf` and `<TOOL_HOME>/conf` directories.

    <table>
    <tr>
    <th><b>Description/File Name</b>
    </th>
    <th><b>Purpose</b>
    </th>
    </th>

    <tr>
    <td>config.json
    </td>
    <td>This is the master configuration file. You can configure this file depending on the Metadata database tables, access logs, audit logs, or any other log files on which you want the Forget-Me Tool to run. 
    </br>For information on how to configure this file, see <a href="#masterconfig">Configure the master configuration file</a>.
    </td>
    </tr>

    <tr>
    <td>datasources
    </td>
    <td>This is the default directory where configured datasources are searched for when you run the Forget-Me Tool.
    If necessary, you can define your own datasource configurations depending on the databases that you want to connect to, and specify the defined datasource configuration location using the command line arguments.
    </td>
    </tr>

    <tr>
    <td>log-config/patterns.xml
    </td>
    <td>This file should contain all the Regex patterns that can be used to find and replace the references to the deleted user identities in the log file entries.
    </td>
    </tr>

    <tr>
    <td>sql
    </td>
    <td>This directory should include all the SQL files that contain the required queries to replace or delete the references to the deleted user identities.
    </td>
    </tr>
    </table>

<a name="masterconfig"></a>
**Configure the master configuration file**

The following is a sample master configuration (`config.json`) file. You can configure this file depending on the Metadata database tables, access logs, audit logs, or any other log files on which you want the Forget-Me Tool to run.

``` js
{
  "processors" : [
    "log-file", "rdbms"
  ],
  "directories": [
    {
      "dir": "log-config",
      "type": "log-file",
      "processor" : "log-file",
      "log-file-path" : "logs",
      "log-file-name-regex" : "wso2carbon.log"
    },
    {
      "dir": "sql",
      "type": "rdbms",
      "processor" : "rdbms"
    }
  ],
  "extensions": [
    {
      "dir": "datasources",
      "type": "datasource",
      "processor" : "rdbms",
      "properties" : [
        {"identity": "WSO2_CARBON_DB"}
      ]
    }
  ]
}
```

You can configure the following in the `config.json` file based on your requirement:

- **`processors`** - A list of processors on which you want the tool run. The processors that you can specify are pre-defined. Possible values are `RDBMS` and `log-file`.
- **`directories`** - The definitions of directories on which you want the tool to run. When you specify a directory definition, be sure to either specify the directory path relative to the location of the `config.json` file or specify the absolute path to the directory.

    ??? info "Example code snippet to define multiple directories in the standalone Forget-Me Tool when working with multiple WSO2 products"
        ```
        "directories": [
            {
            "dir": "log-config",
            "type": "log-file",
            "processor" : "log-file",
            "log-file-path" : "<EI_HOME>/repository/logs",
            "log-file-name-regex" : "(.)*(log|out)"
            },
            {
            "dir": "sql",
            "type": "rdbms",
            "processor" : "rdbms"
            },
            {
            "dir": "log-config",
            "type": "log-file",
            "processor" : "log-file",
            "log-file-path" : "<IOT_HOME>/repository/logs",
            "log-file-name-regex" : "(.)*(log|out)"
            },
            {
            "dir": "sql",
            "type": "rdbms",
            "processor" : "rdbms"
            }
        ],
        ```

- **`processor`** - The type of processor to use to process the instructions in the corresponding directory.
- **`extensions`** - The extensions to be initialized before starting a processor.

The default configurations are set up as follows:

- **Read Logs**: 
     
     The default read logs are available in the `<API-M_HOME>/repository/logs` *(Relevant to API-M)* and `<TOOL_HOME>/logs` *(Relevant to the standalone Forget-Me Tool)* directory. 
     
     You can change this location in the `directories` → `log-file-path` section of the log-file processor.

- **Read Datasource** : 
         
     A datasource is used to establish a connection to a database. When working with WSO2 API-M, you can configure the datasources in the `<API-M_HOME>/repository/conf/datasources/` directory. If you are using the standalone Forget-Me Tool, you can configure the datasources in the `<TOOL_HOME>/conf/datasources/` directory.
    
     You can point to the latter mentioned datasources in the `config.json` file using the `extensions` section as shown below:
    
    ``` js
    "extensions": [
        {
        "dir": "datasources",
        "type": "datasource",
        "processor" : "rdbms",
        "properties" : [
            {"identity": "WSO2_CARBON_DB"}
        ]
        }
    ]
    ```
     As shown in the above code snippet, you need to specify the absolute path of the datasources that you defined in the `dir` section. 
     
     Define the following in the `properties` section of the `config.json` file as shown below:

    ``` java tab="Format"
    "<key>": "<value>"
    ```

    ``` java tab="Example"
    "identity": "WSO2_CARBON_DB"
    ```
         
    - `<key>` - Define the name of the directory in which the database scripts reside. By default, the database scripts reside in the sub-folders that are available in the `<API-M_HOME>/repository/components/tools/forget-me/conf/sql` *(Relevant to API-M)* and `<TOOL_HOME>/conf/sql` *(Relevant to the standalone Forget-Me Tool)* directories. 
    
         If you wish, you can add any additional database scripts in the relevant existing sub-folders itself or you can add them in a new sub-folder within the `sql` directory.

    - `<value>` - Define the database name on which you need to execute those scripts.

- **Default datasource name**: `WSO2AM_DB, WSO2_CARBON_DB`

- **Log file name regex**: `(.)*(log|out)`

### Step 3 - Change the default location of the configurations

!!! note
    **Skip** this step when you are **working with the standalone Forget-Me Tool**.

Change the default configurations location for the pre-packed tool as follows:

1. Navigate to the `<API-M_HOME>/bin` directory.

2. Open the Forget-Me Tool start-up script. 

     Open the `forgetme.sh` (Linux/Mac OS) file. This file will contain the following.

    ``` java
    sh $CARBON_HOME/repository/components/tools/forget-me/bin/forget-me -d $CARBON_HOME/repository/components/tools/forget-me/conf $@
    ```

2.  The location path is the value given after `-d` within the following line. Modify the value after `-d` to change the location. 
 
     The default location path is `$CARBON_HOME/repository/components/tools/forget-me/conf`.

### Step 4 - Run the tool

Run the Forget-Me tool based on the WSO2 products that you have in your deployment.

!!! note
    Before you begin...

    -   This tool is designed to run in offline mode (i.e., the server should be shut down or run on another machine) in order to prevent unnecessary load to the server. </br>If this tool runs in online mode (i.e., when the server is running), DB lock situations on the H2 databases may occur. This DB lock may happen if at least one of your databases point to H2. 
    </br>For example, if you have the User, REG, and AM databases pointing to MySQL, but your Carbon DB is in H2, then also you can get a DB lock error when running in online mode.
    -   If you have configured a database other than the default H2 database, copy the relevant driver to the following directory based on your deployment.
         - If you are only working with WSO2 API Manager -

             `<API-M_HOME>/repository/components/tools/forget-me/lib`

         - If you are working with the standalone Forget-Me Tool -

             `<TOOL_HOME>/lib`

    -   The tool is designed to replace all references to a deleted user's identity with either a randomly generated UUID value, or a pseudonym that you specify when you run the tool. Therefore, you need to manually delete the user and then use this tool to clear the residuals in tables.

#### Run the Forget-Me Tool in WSO2 API Manager

Follow the instructions below to run the Forget-Me Tool, which is packaged with WSO2 API Manager by default:

1. Open a new terminal window and navigate to the `<API-M_HOME>/bin` directory.

2. Execute one of the following commands depending on your operating system:

    -   On Linux/Mac OS: `./forgetme.sh -U <username>`
    -   On Windows: `forgetme.bat -U <username>`

    !!! info
        The command specified above uses only the `-U <username>` option, which is the only mandatory option to run the tool. There are several other optional command-line options that you can specify based on your requirement. For more information, see [Supported command-line options when running the Forget-Me Tool](#supported-command-line-options-when-running-the-forget-me-tool)

3. All references to the user are removed from WSO2 API Manager. You can view the generated reports inside the `<API-M_HOME>/repository/components/tools/forget-me/conf` directory. Reports will be generated with the naming convention of `Report-<PROCESSOR>-<TIMESTAMP>.txt`  in your current working directory.
    
     Example:  `Report-log-file-1598483873677.txt`

#### Run the Forget-Me Tool for other WSO2 products

Follow the instructions below to run the Forget-Me Tool in standalone mode:

1. Open a new terminal window and navigate to the `<TOOL_HOME>/bin` directory.

2. Execute one of the following commands depending on your operating system:

    -   On Linux/Mac OS: `./forgetme.sh -U <username>`
    -   On Windows: `forgetme.bat -U <username>`

    !!! info
        The command specified above uses only the `-U <username>` option, which is the only mandatory option to run the tool. There are several other optional command-line options that you can specify based on your requirement. For more information, see [Supported command-line options when running the Forget-Me Tool](#supported-command-line-options-when-running-the-forget-me-tool)

3. All references to the user are removed from the respective WSO2 products. You can view the generated reports inside the `<TOOL_HOME>/conf` directory. Reports will be generated with the naming convention of `Report-<PROCESSOR>-<TIMESTAMP>.txt`  in your current working directory.
    
     Example:  `Report-log-file-1598483873677.txt`
     
#### Supported command-line options when running the Forget-Me Tool

The following is the list of all the command-line options that can be used with this command.

<table>
<thead>
<tr class="header">
<th><b>Command-line option</b></th>
<th><b>Description</b></th>
<th><b>Required</b></th>
<th><b>Default Value</b></th>
<th><b>Sample value</b></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>U</td>
<td>The name of the user whose identity references you want to remove.</td>
<td>Yes</td>
<td><br />
</td>
<td><code>-U alex.doe</code></td>
</tr>
<tr class="even">
<td>d</td>
<td>The configuration directory to use when the tool is run.</td>
<td>No</td>
<td> When using only API-M -</br><code>&lt;APIM_HOME&gt;/repository/components/tools/forget-me/conf</code></br>
When working with the standalone Forget-Me Tool-</br><code> &lt;TOOL_HOME&gt;/conf</code></td>
<td><code>-d /users/alex/forgetme/config</code></td>
</tr>
<tr class="odd">
<td>T</td>
<td>The tenant domain of the user whose identity references you want to remove</td>
<td>No</td>
<td><code>carbon.super</code></td>
<td><code>-T example-company</code</td>
</tr>
<tr class="even">
<td>TID</td>
<td>
The tenant ID of the user whose identity references you want to remove.
</td>
<td>No</td>
<td><br />
</td>
<td><code>-TID 1234</code></td>
</tr>
<tr class="odd">
<td>D</td>
<td>The userstore domain</td>
<td>No</td>
<td><code>PRIMARY</code></td>
<td><code>-D Finance-domain</code></td>
</tr>
<tr class="even">
<td>pu</td>
<td>The pseudonym with which the username should be replaced.<html><div class="admonition note"><p class="admonition-title">Note</p><p> If you run the tool to replace all references to a particular deleted user’s identity, then you add the same user back to the system for some reason, and later you want to delete the user again and replace all the references to the user with the same pseudonym that was used the first time, you need to specify a pseudonym when you run the tool the first time and ensure that you use that same pseudonym when you run the tool the second time. </p></div></html></td>
<td>No</td>
<td>A random UUID value is generated as the pseudonym.</td>
<td><code>-pu “123-343-435-545-dfd-4”</code></td>
</tr>
<tr class="odd">
<td>carbon</td>
<td>Define the absolute path of the WSO2 product in which you need to remove the references of the deleted user identities.
<br />
<p>This value will replace the variable <code>$CARBON_HOME</code> in the directories that are configured in the main configuration file.</p></td>
<td>No</td>
<td><br />
</td>
<td><code>-carbon “usr/bin/wso2am/wso2am4.0.0”</code></td>
</tr>
</tbody>
</table>
