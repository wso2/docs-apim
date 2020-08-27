# General Data Protection Regulation (GDPR) for WSO2 API Manager

The Forget-Me tool pre-packed with API-M 3.2.0 can be used to 
obfuscate the identities of an **external user** who is deleted according to the system administrator's request. This tool removes user identities stored in the database and also in log files in order to meet GDPR requirements. The following sections guide you through configuring and running this tool in WSO2 API Manager.

-   [Changing the default configurations of the tool.](#GeneralDataProtectionRegulation(GDPR)forWSO2APIManager-Changingthedefaultconfigurationsofthetool.)
-   [Changing the default configurations location](#GeneralDataProtectionRegulation(GDPR)forWSO2APIManager-Changingthedefaultconfigurationslocation)
-   [Running the tool in API Manager](#GeneralDataProtectionRegulation(GDPR)forWSO2APIManager-RunningthetoolinAPIManager)
    -   [Running the toolkit in standalone mode](#GeneralDataProtectionRegulation(GDPR)forWSO2APIManager-Runningthetoolkitinstandalonemode)
-   [Running the tool in API Manager Analytics](#GeneralDataProtectionRegulation(GDPR)forWSO2APIManager-RunningthetoolinAPIManagerAnalytics)

### Changing the default configurations of the tool.

All configurations related to this tool can be found inside the `<API-M_HOME>/repository/components/tools/forget-me/conf` directory. The default configurations are set up as follows:

-   Read Logs: `<API-M_HOME>/repository/logs`

-   Read Datasource: `<API-M_HOME>/repository/conf/datasources/`

-   Default datasource name: `WSO2AM_DB, WSO2_CARBON_DB`

-   Log file name regex: `(.)*(log|out)`

#### Configuring the master configuration file
This is the master configuration file. You can configure this file depending on the metadata database tables, access logs, audit logs, or any other log files on which you want the Identity Anonymization tool to run.Following is a sample config.json file:

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

You can configure the following in the config.json file based on your requirement:

* processors - A list of processors on which you want the tool run. The processors that you can specify are pre-defined. Possible values are RDBMS and log-file.
* directories - The definitions of directories on which you want the tool to run. When you specify a directory definition, be sure to either specify the directory path relative to the location of the config.json file, or specify the absolute path to the directory.
* processor - The type of processor to use to process instructions in the corresponding directory.
* extensions - The extensions to be initialized prior to starting a processor.

### Changing the default configurations location

To change the default configurations location for the pre-packed tool, do the following:

1.  Open the `forgetme.sh` file found inside the `<API-M_HOME>/bin` folder. This file will contain the following.

    ``` java
    sh $CARBON_HOME/repository/components/tools/forget-me/bin/forget-me -d $CARBON_HOME/repository/components/tools/forget-me/conf $@
    ```

2.  The location path is the value given after `-d` within the following line. Modify the value after `-d` to change the location. The default location path is `$CARBON_HOME/repository/components/tools/forget-me/conf` .

### Running the tool in API Manager

This tool is packaged with WSO2 API Manager by default. Follow the steps below to run this tool.

!!! note
    Before you begin...

    -   Note that this tool is designed to run in offline mode (i.e., the server should be shut down or run on another machine) in order to prevent unnecessary load to the server. If this tool runs in online mode (i.e., when the server is running), DB lock situations on the H2 databases may occur. This DB lock may happen if at least one of your databases point to H2. Let's say you have User, REG and AM databases pointed to Mysql but your Carbon DB is in H2, then also you can get this DB lock error when running in online mode.
    -   If you have configured a database other than the default H2 database, copy the relevant driver to the `<API-M_HOME>/repository/components/tools/forget-me/lib` directory.
    -   The tool is designed to replace all references to a deleted user's identity with either a randomly generated UUID value, or a pseudonym that you specify when you run the tool. Thus you need to manually delete the user and then use this tool to clear the residuals in tables.


1.  Open a new terminal window and navigate to the `<API-M_HOME>/bin` directory.

2.  Execute one of the following commands depending on your operating system:

    -   On Linux/Mac OS: `./forgetme.sh -U <username> `
    -   On Windows: `forgetme.bat -U <username>`

!!! info
    The command specified above uses only the `-U <username>` option, which is the only mandatory option to run the tool. There are several other optional command line options that you can specify based on your requirement. The supported options are described in detail below.


3.  The following is the list of all the command line options that can be used with this command.

    <table>
    <thead>
    <tr class="header">
    <th>Command line option</th>
    <th>Description</th>
    <th>Required</th>
    <th>Default Value</th>
    <th>Sample value</th>
    </tr>
    </thead>
    <tbody>
    <tr class="odd">
    <td>U</td>
    <td>The name of the user whose identity references you want to remove.</td>
    <td>Yes</td>
    <td><br />
    </td>
    <td><code>               -U alex.doe              </code></td>
    </tr>
    <tr class="even">
    <td>d</td>
    <td><p>The configuration directory to use when the tool is run.</p></td>
    <td>No</td>
    <td> <code>  APIM_HOME/repository/components/tools/forget-me/conf </code></td>
    <td><code>               -d /users/alex/forgetme/config              </code></td>
    </tr>
    <tr class="odd">
    <td>T</td>
    <td>The tenant domain of the user whose identity references you want to remove</td>
    <td>No</td>
    <td><code>               carbon.super              </code></td>
    <td><p><code>                -T example-company               </code></p></td>
    </tr>
    <tr class="even">
    <td>TID</td>
    <td>
    <p>The tenant ID of the user whose identity references you want to remove.</p>
    </td>
    <td>No</td>
    <td><br />
    </td>
    <td><code>               -TID 1234              </code></td>
    </tr>
    <tr class="odd">
    <td>D</td>
    <td>The userstore domain</td>
    <td>No</td>
    <td><code>               PRIMARY              </code></td>
    <td><p><code>                -D Finance-domain               </code></p></td>
    </tr>
    <tr class="even">
    <td>pu</td>
    <td>The pseudonym with which the username should be replaced.<html><div class="admonition note"><p class="admonition-title">Note</p><p> Let's say you run the tool to replace all references to a particular deleted user’s identity, and then you add the same user back to the system for some reason, and later you want to delete the user again and replace all references to the user with the same pseudonym that was used the first time. To do this you need to specify a pseudonym when you run the tool the first time and ensure that you use that same pseudonym when you run the tool the second time. </p></div></html></td>
    <td>No</td>
    <td>A random UUID value is generated as the pseudonym.</td>
    <td><p><code>                -pu “123-343-435-545-dfd-4”               </code></p></td>
    </tr>
    <tr class="odd">
    <td>carbon</td>
    <td><p>The CARBON HOME.</p>
    <br />

    <p>This should be replaced with the variable <code>                $CARBON_HOM               </code> E in directories configured in the main configuration file.</p></td>
    <td>No</td>
    <td><br />
    </td>
    <td><code>               -carbon “usr/bin/wso2am/wso2am3.2.0”              </code></td>
    </tr>
    </tbody>
    </table>

4.  All references to the user are removed from WSO2 API Manager. You can view the generated reports inside the `<API-M_HOME>/repository/components/tools/forget-me/conf` directory. Reports will be generated with the naming convention of `Report-<PROCESSOR>-<TIMESTAMP>.txt`  in your current working directory.
    eg: Report-log-file-1598483873677.txt

#### Running the toolkit in standalone mode

This tool can run standalone and therefore cater to multiple products. This means that if you are using multiple WSO2 products and need to delete the user's identity from all products at once, you can do so by running the tool in standalone mode.
For information on how to build and run the Forget-Me tool, see [Removing References to Deleted User Identities in WSO2 Products](https://docs.wso2.com/display/ADMIN44x/Removing+References+to+Deleted+User+Identities+in+WSO2+Products) in the WSO2 Administration Guide.

### GDPR for API Manager Analytics

For information on GDPR for API Manager Analytics, please refer [General Data Protection Regulation (GDPR) for WSO2 API Manager Analytics]({{base_path}}/learn/analytics/general-data-protection-regulation-gdpr-for-wso2-api-manager-analytics).
