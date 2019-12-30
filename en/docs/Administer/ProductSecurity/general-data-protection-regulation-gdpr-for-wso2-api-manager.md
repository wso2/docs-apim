# General Data Protection Regulation (GDPR) for WSO2 API Manager

The Forget-Me tool pre-packed with API-M 2.2.0 can be used to remove identities of an **external user** who is deleted according to the system administrator's request. This tool removes user identities stored in the database and also in log files in order to meet GDPR requirements. The following sections guide you through configuring and running this tool in WSO2 API Manager.

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

For information on changing these configurations, see [Configuring the config.json file](https://docs.wso2.com/display/ADMIN44x/Removing+References+to+Deleted+User+Identities+in+WSO2+Products#RemovingReferencestoDeletedUserIdentitiesinWSO2Products-Configuringtheconfig.jsonfile) in the Product Administration Guide.

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
    <td><p>The configuration directory to use when the tool is run.</p>
    <p>If you do not specify a value for this option, the default conf directory will be used.</p></td>
    <td>No</td>
    <td><br />
    </td>
    <td><code>               -d /users/alex/forgetme/config              </code></td>
    </tr>
    <tr class="odd">
    <td>T</td>
    <td>The tenant domain</td>
    <td>No</td>
    <td><code>               carbon.super              </code></td>
    <td><p><code>                -T example-company               </code></p></td>
    </tr>
    <tr class="even">
    <td>TID</td>
    <td><div class="content-wrapper">
    <p>The tenant ID</p>
        !!! note
        <p>Note</p>

    </div></td>
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
    <td>The pseudonym with which the username should be replaced.</td>
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
    <td><code>               -carbon “usr/bin/wso2am/wso2am2.2.0”              </code></td>
    </tr>
    </tbody>
    </table>

4.  All references to the user are removed from WSO2 API Manager. You can view the generated reports inside the `<API-M_HOME>/repository/components/tools/forget-me/conf` directory.

#### Running the toolkit in standalone mode

This tool can run standalone and therefore cater to multiple products. This means that if you are using multiple WSO2 products and need to delete the user's identity from all products at once, you can do so by running the tool in standalone mode.
For information on how to build and run the Forget-Me tool, see [Removing References to Deleted User Identities in WSO2 Products](https://docs.wso2.com/display/ADMIN44x/Removing+References+to+Deleted+User+Identities+in+WSO2+Products) in the WSO2 Administration Guide.

### Running the tool in API Manager Analytics

Shown below is an example data stream used by API Manager Analytics. Note that the userId/username, emails and the ip are personally identifiable information (PII) of the user.

| Stream Name                                                                          | Attribute List                                           |
|--------------------------------------------------------------------------------------|----------------------------------------------------------|
| `org.wso2.analytics.apim.ipAccessSummary`| -`userId` 
  -`ip`|
| `org.wso2.analytics.apim.alertStakeholderInfo` | -`userId` 
  -`emails`|

These PII references can be removed from the Analytics database by using the Forget-Me tool. Follow the steps given below.

1.  Add the relevant drivers for your Analytics-specific databases to the `<API-M_ANALYTICS_HOME>/repository/components/tools/forget-me/lib` directory. For example, if you have changed your Analytics databases from the default H2 instances to MySQL, copy the MySQL driver to this given directory.
2.  Create a folder named `'streams'` in the `<API-M_ANALYTICS_HOME>/repository/components/tools/forget-me /conf/` directory.
3.  Create a new file named `streams.json` with content similar to what is shown below based on the streams used, and store it in the /streams directory that you created in the previous step. This file holds the details of the streams and the attributes with PII that we need to remove from the database.

    ``` java
        {
            "streams": [
                {
                    "streamName": "org.wso2.analytics.apim.ipAccessSummary",
                    "attributes": ["userId", "ip"],
                    "id": "userId"
                },
                {
                    "streamName": "org.wso2.analytics.apim.alertStakeholderInfo",
                    "attributes": ["userId", "emails"],
                    "id": "userId"
                }
            ]
        }
    ```

    The above configuration includes the following:

    -   **Stream Name** : The name of the stream.
    -   **Attributes:** The list of attributes that contain PII.
    -   **id** : The ID attribute, which holds the value that needs to be anonymized (replaced with a pseudonym).

4.  Create a new file named `config.json` to `<API-M_ANALYTICS_HOME>/repository/components/tools/forget-me/conf/` directory with the content shown below .

    ``` js
            {
                "processors": [
                    "analytics-streams"
                ],
                "directories": [
                    {
                        "dir": "streams",
                        "type": "analytics-streams",
                        "processor": "analytics-streams"
                    }
                ]
            }
    ```

5.  Open a command prompt and navigate to the `<API-M_ANALYTICS_HOME>/bin` directory.
6.  Execute one of the following commands depending on your operating system:

    -   On Linux/Mac OS: `./forgetme.sh -U <username>`
    -   On Windows: `forgetme.bat -U <username>`


