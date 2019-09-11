# admin\_Removing References to Deleted User Identities in WSO2 Products

When it comes to data protection in enterprise systems, a key requirement outlined in the General Data Protection Regulation (GDPR) is the right of the data subject to be forgotten, which gives users the right to request an organization to remove their personal data when requested.

To comply with the GDPR *right to be forgotten* requirement, all products in the [WSO2 platform](https://wso2.com/platform) support removing references to personally identifiable information (PII) of a user when a user is deleted from the system. You can use the [Identity Anonymization tool](https://github.com/wso2/identity-anonymization-tool.git) to remove references to a user’s PII that can generally be stored in metadata database tables, access logs, audit logs as well as any other log files in any WSO2 product.
The tool is designed to replace all references to a deleted user's identity with either a randomly generated UUID value, or a pseudonym that you specify when you run the tool.

!!! info
Note

The following WSO2 products have the Identity Anonymization tool packaged in the product distribution by default. Therefore, if you are using any of the following products, see the relevant product documentation page for product specific instructions on how to run the tool.

-   WSO2 Identity Server 5.5.0
    For information on how to run the tool, see [Removing References to Deleted User Identities](https://docs.wso2.com/display/IS550/Removing+References+to+Deleted+User+Identities) .
-   WSO2 Enterprise Integrator 6.2.0
    For information on how to run the tool, see [General Data Protection Regulation (GDPR) for WSO2 Enterprise Integrator](https://docs.wso2.com/display/EI6xx/General+Data+Protection+Regulation+%28GDPR%29+for+WSO2+EI) .
-   WSO2 API Manager 2.2.0
    For information on how to run the tool, see [General Data Protection Regulation (GDPR) for WSO2 API Manager](https://docs.wso2.com/display/AM220/General+Data+Protection+Regulation+%28GDPR%29+for+WSO2+API+Manager) .
-   WSO2 Data Analytics Server 3.2.0
    For information on how to run the tool, see [General Data Protection Regulations (GDPR) for WSO2 Data Analytics Server](https://docs.wso2.com/display/DAS320/General+Data+Protection+Regulations+%28GDPR%29+for+WSO2+Data+Analytics+Server) .
-   WSO2 Stream Processor 4.1.0
    For information on how to run the tool, see [General Data Protection Regulations (GDPR) for WSO2 Stream Processor](https://docs.wso2.com/display/SP410/General+Data+Protection+Regulations+%28GDPR%29+for+WSO2+Stream+Processor) .
-   WSO2 IoT Server 3.3.0
    For information on how to run the tool, see [General Data Protection Regulation for WSO2 IoT Server](https://docs.wso2.com/display/IOTS330/General+Data+Protection+Regulation+for+WSO2+IoT+Server) .


WSO2 also supports extending this tool to include additional modules from which you would want to remove deleted user identities. For information on how to extend the tool, see [Extending the Identity Anonymization Tool](https://docs.wso2.com/display/ADMIN44x/Extending+the+Identity+Anonymization+Tool) .

The following topics walk you through the process of building the tool and configuring the appropriate files and directories so that you can run the tool in standalone mode to successfully remove references to a deleted user's identity from one or more WSO2 products.

-   [Building the Identity Anonymization tool](#admin_RemovingReferencestoDeletedUserIdentitiesinWSO2Products-BuildToolBuildingtheIdentityAnonymizationtool)
-   [Configuring the master configuration file](#admin_RemovingReferencestoDeletedUserIdentitiesinWSO2Products-MasterConfigConfiguringthemasterconfigurationfile)
-   [Running the tool](#admin_RemovingReferencestoDeletedUserIdentitiesinWSO2Products-Runningthetool)

!!! tip
Prerequisites

-   [Download](https://maven.apache.org/download.cgi) and install Apache Maven.


### Building the Identity Anonymization tool

Follow the steps below to build the tool:

1.  Clone the <https://github.com/wso2/identity-anonymization-tool> repository to a required location.
2.  In the source that you checked out, navigate to `identity-anonymization-tool` , and run `mvn clean install` . This downloads all dependencies and builds the tool in your local repository. You can find the `org.wso2.carbon.privacy.forgetme.tool-SNAPSHOT.zip` file created in the `identity-anonymization-tool/components/org.wso2.carbon.privacy.forgetme.tool/target` directory.
3.  Unzip the `org.wso2.carbon.privacy.forgetme.tool-SNAPSHOT.zip` file. This creates the `identity-anonymization-tool-SNAPSHOT` directory with a directory. The path to the `identity-anonymization-tool-SNAPSHOT` directory will be referred to as `<TOOL_HOME>` throughout this section.

    The following table describes the purpose of the most important configuration related directories and files of the tool, which are in the `<TOOL_HOME>/conf` directory:

    <table>
    <thead>
    <tr class="header">
    <th>Directory/File name</th>
    <th>Purpose</th>
    </tr>
    </thead>
    <tbody>
    <tr class="odd">
    <td><code>               config.json              </code></td>
    <td>This is the master configuration file.<br />
    You can configure this file depending on the metadata database tables, access logs, audit logs, or any other log files on which you want the Identity Anonymization tool to run. For information on how to configure this file, see <a href="#admin_RemovingReferencestoDeletedUserIdentitiesinWSO2Products-MasterConfig">Configuring the master configuration file</a> .</td>
    </tr>
    <tr class="even">
    <td><code>               datasources              </code></td>
    <td><p>This is the default directory where configured datasources are searched for when you run the Identity Anonymization tool.<br />
    If necessary, you can define your own datasource configurations depending on the databases that you want to connect to, and specify the defined datasource configuration location using command line arguments.</p></td>
    </tr>
    <tr class="odd">
    <td><code>               log-config/patterns.xml              </code></td>
    <td>This file should contain all the regex patterns that can be used to find and replace references to deleted user identities in log file entries.</td>
    </tr>
    <tr class="even">
    <td><code>               sql              </code></td>
    <td>This directory should include all the SQL files that contain required queries to replace or delete references to deleted user identities.</td>
    </tr>
    </tbody>
    </table>

### Configuring the master configuration file

The master configuration file of the Identity Anonymization tool is the `config.json` file. Following is a sample config.json file:

``` java
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

-`processors` - A list of processors on which you want the tool run. The processors that you can specify are pre-defined. Possible values are `RDBMS` and `log-file` .
-`directories` - The definitions of directories on which you want the tool to run. When you specify a directory definition, be sure to either specify the directory path relative to the location of the `config.json` file, or specify the absolute path to the directory.
-`processor` - The type of processor to use to process instructions in the corresponding directory.
-`extensions` - The extensions to be initialized prior to starting a processor.

### Running the tool

Navigate to the `<TOOL_HOME>/bin` directory, and execute one of the following commands depending on your operating system:

-   On Linux/Mac OS: `./forgetme.sh -U <username>`
-   On Windows: `forgetme.bat -U <username>`

!!! info
Note

The commands specified above use only the `-U <username>` option, which is the only mandatory option to run the tool. There are several other optional command line options that you can specify based on your requirement. The supported options are described in detail below.


Following are details of all possible command line options that you can use when you run the tool:

<table>
<thead>
<tr class="header">
<th>Command Line Option</th>
<th>Description</th>
<th>Required</th>
<th>Sample Command</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>U</td>
<td>The user name of the user whose identity references you want to remove.</td>
<td>Yes</td>
<td><p>On Linux/Mac OS: <code>               ./forgetme.sh -U Sam              </code><br />
<br />
On Windows: <code>               forgetme.bat -U Sam              </code></p></td>
</tr>
<tr class="even">
<td>d</td>
<td>The configuration directory to use when the tool is run.<br />
If you do not specify a value for this option, the default configuration directory of the tool will be used.</td>
<td>No</td>
<td><p>On Linux/Mac OS: <code>               ./forgetme.sh -U Sam -d &lt;TOOL_HOME&gt;/conf              </code></p>
<p>On Windows: <code>               forgetme.bat -U Sam               -d &lt;TOOL_HOME&gt;/conf              </code></p></td>
</tr>
<tr class="odd">
<td>T</td>
<td><div class="content-wrapper">
<p>The tenant domain of the user whose identity references you want to remove . The default value is <code>                carbon.super               </code> . <code>                               </code> For information on working with tenants in WSO2 products, see <a href="https://docs.wso2.com/display/ADMIN44x/Working+with+Multiple+Tenants">Working with Multiple Tenants</a> .</p>
!!! note
<p>Note</p>
<p>If you specify the tenant domain as a command line option, it is mandatory to specify the tenant ID of the particular user.</p>

</div></td>
<td>No</td>
<td><p>On Linux/Mac OS: <code>               ./forgetme.sh -U Sam               -T sam.com -TID 1              </code></p>
<p><br />
On Windows: <code>               forgetme.bat -U Sam               -T sam.com -TID 1              </code></p></td>
</tr>
<tr class="even">
<td>TID</td>
<td><div class="content-wrapper">
<p>The tenant ID of the user whose identity references you want to remove .</p>
!!! note
<p>Note</p>
<p>If you specify the tenant domain as a command line option, it is mandatory to specify the tenant ID of the particular user.</p>

</div></td>
<td>No</td>
<td><p>On Linux/Mac OS: <code>               ./forgetme.sh -U Sam -T sam.com -TID 1              </code></p>
<p><br />
On Windows: <code>               forgetme.bat -U Sam -T sam.com -TID 1              </code></p></td>
</tr>
<tr class="odd">
<td>D</td>
<td>The user store domain name of the user whose identity references you want to remove . The default value is <code>              PRIMARY             </code> .</td>
<td>No</td>
<td><p>On Linux/Mac OS: <code>               ./forgetme.sh -U Sam -D Finance-Domain              </code></p>
<p><br />
On Windows: <code>               forgetme.bat -U Sam               -D Finance-Domain              </code></p>
<p><br />
</p></td>
</tr>
<tr class="even">
<td>pu</td>
<td><div class="content-wrapper">
<p>The pseudonym with which you want to replace references to a deleted user’s identity. If you do not specify a pseudonym when you run the tool, a random UUID value is generated as the pseudonym by default to anonymize references to the deleted user’s identity.</p>
!!! note
<p>Note</p>
<p>A valid pseudonym can contain the following characters:</p>
<ul>
<li><p>Uppercase characters {A-Z}</p></li>
<li>Lowercase characters {a-z}</li>
<li><p>Numbers {0-9}</p></li>
</ul>

<p>Following is a sample scenario where it is useful to specify a pseudonym:<br />
Let's say you run the tool to replace all references to a particular deleted user’s identity, and then you add the same user back to the system for some reason, and later you want to delete the user again and replace all references to the user with the same pseudonym that was used the first time. To do this you need to specify a pseudonym when you run the tool the first time and ensure that you use that same pseudonym when you run the tool the second time.<br />
</p>
</div></td>
<td>No</td>
<td><p>On Linux/Mac OS: <code>               ./forgetme.sh -U Sam -pu 123-343-435-545-dfd-4              </code></p>
<p><br />
On Windows: <code>               forgetme.bat -U Sam               -pu 123-343-435-545-dfd-4              </code></p></td>
</tr>
<tr class="odd">
<td>carbon</td>
<td><p>The CARBON HOME directory path on which you want to run the tool. You should replace this with the variable <code>               $CARBON_HOME              </code> used in directories you have configured in the master configuration file.</p></td>
<td>No</td>
<td><p>On Linux/Mac OS: <code>               ./forgetme.sh -U Sam -carbon /usr/bin/wso2is/wso2is5.5.0              </code></p>
<p><br />
On Windows: <code>               forgetme.bat -U Sam               -carbon /usr/bin/wso2is/wso2is5.5.0              </code></p></td>
</tr>
</tbody>
</table>

When you specify the required command line options and run the tool, it generates relevant execution reports with the `Report-<PROCESSOR>-<TIMESTAMP>.txt` naming convention in your current working directory.


