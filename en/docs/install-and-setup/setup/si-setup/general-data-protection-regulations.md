# General Data Protection Regulations (GDPR) for Streaming Integrator

The General Data Protection Regulation (GDPR) is a new legal framework formalized by the European Union (EU) in 2016. This regulation is effective since 28, May 2018, and can affect any organization that processes Personally Identifiable Information (PII) of individuals who live in Europe. Organizations that fail to demonstrate GDPR compliance are subjected to financial penalties.

!!!info
    Do you want to learn more about GDPR?

    If you are new to GDPR, we recommend that you take a look at our article
    series on ***Creating a Winning GDPR Strategy.***

    - Part 1 - [Introduction to GDPR](https://wso2.com/library/article/2017/12/introduction-to-gdpr/)

    - Part 2 - [7 Steps for GDPR Compliance](https://wso2.com/library/article/2017/12/7-steps-for-gdpr-compliance/)

    - Part 3 - [Identity and Access Management to the Rescue](https://wso2.com/library/article/2018/2/identity-and-access-management-to-the-rescue/)

    - Part 4 - [GDPR Compliant Consent Design](https://wso2.com/library/articles/2018/03/creating-a-winning-gdpr-strategypart-4-gdpr-compliant-consent-design/)

    For more resources on GDPR, see the white papers, case studies, solution briefs, webinars, and talks published on
    our [WSO2 GDPR homepage](https://wso2.com/solutions/regulatory-compliance/gdpr/). You can also find the original
    GDPR legal text [here](http://eur-lex.europa.eu/legal-content/en/TXT/?uri=CELEX%3A32016R0679).


## Removing personally identifiable information via the Forget-me tool

In the Streaming Integrator, streams specify the schema for events to be selected into the streaming integration event flow to be processed. This schema can include user IDs and other PII (Personally Identifiable Information) that you want to delete from log files and such. This can be done via the [Forget-me Tool](#Forget-me_Tool_Overview).


**Step 1: Configure the config.json file**

The `<SI_HOME>/wso2/tools/identity-anonymization-tool-x.x.x/conf/config.json` file specifies the locations from which persisted data needs to be removed.

The `log-file` processor is specified in the configuration file of the Forget-Me tool as shown on the sample below in order to remove data with PII from the logs. If you have configured logs with PII to be saved in another location, you can add it to this list of processors.

``` js
{
  "processors" : [
    "log-file"
  ],
  "directories": [
    {
      "dir": "log-config",
      "type": "log-file",
      "processor" : "log-file",
      "log-file-path" : "logs",
      "log-file-name-regex" : "(.)*"
    }
  ]
}
```

This extract shows the default configuration of the Streaming Integrator. The Streaming Integrator only saves PII in log files by default. Therefore, this configuration allows the Forget-me tool to delete these logs that are saved in the `<SI_HOME>/wso2/server/logs` directory.

**Step 2: Execute the Forget-me tool**

To execute the Forget-me tool, issue the following command pointing to the `<SP_HOME>` directory.

`forget-me -U <USERNAME> -d <CONF_DIR> -carbon <SP_HOME>`


## Removing references to deleted user identities

This section covers how to remove references to deleted user identities in the Streaming Integrator by running the [Forget-me tool](#forget-me-tool-overview).


!!! tip "Before you begin:"
    - Note that this tool is designed to run in offline mode (i.e., the server should be shut down or run on another machine) in order to prevent unnecessary load to the server. If this tool runs in online mode (i.e., when the server is running), DB lock situations on the H2 databases may occur.
    - If you have configured any JDBC database other than the H2 database provided by default, copy the relevant JDBC driver to the `<SP_HOME>/wso2/tools/identity-anonymization-tool/lib` directory.

1. Open a new terminal window and navigate to the `<SP_HOME>/bin` directory.

2. Execute one of the following commands depending on your operating system:
    - On Linux/Mac OS: `./forgetme.sh -U <username>`
    - On Windows: `forgetme.bat -U <username>`

!!!note
    The commands specified above use only the `-U <username>` option, which is the only required option to run the tool. There are several other optional command line options that you can specify based on your requirement. The supported options are described in detail below.

    <table>
       <thead>
          <tr class="header">
             <th>Command Line Option</th>
             <th>Description</th>
             <th>Required</th>
             <th>Sample Value</th>
          </tr>
       </thead>
       <tbody>
          <tr class="odd">
             <td>U</td>
             <td>The name of the user whose identity references you want to remove.</td>
             <td>Yes</td>
             <td><code>               -U john.doe              </code></td>
          </tr>
          <tr class="even">
             <td>d</td>
             <td>The configuration directory to use when the tool is run.<br />
                If you do not specify a value for this option, the <code>               &lt;SP_HOME&gt;/wso2/tools/identity-anonymization-tool-x.x.x/conf              </code> directory (which is the default configuration directory of the tool) is used.
             </td>
             <td>No</td>
             <td><code>               -d &lt;TOOL_HOME&gt;/conf              </code></td>
          </tr>
          <tr class="odd">
             <td>T</td>
             <td>
                <div class="content-wrapper">
                   <p>The tenant domain of the user whose identity references you want to remove.</p>
                   <p>If you specify a tenant domain via this option, use the <code>TID</code> option to specify the ID of which the references must be removed.</p>
                </div>
             </td>
             <td>No</td>
             <td>
                <p><code>                -T acme-company               </code></p>
                <p>The default value is <code>                carbon.super               </code></p>
             </td>
          </tr>
          <tr class="even">
             <td>TID</td>
             <td>
                <div class="content-wrapper">
                   <p>The tenant ID of the user whose identity references you want to remove.</p>
                   <p>It is required to specify a tenant ID if you have specified a tenant domain via the <code>TID</code> option.</p>
                </div>
             </td>
             <td>No</td>
             <td><code>               -TID 2346              </code></td>
          </tr>
          <tr class="odd">
             <td>D</td>
             <td>The user store domain name of the user whose identity references you want to remove.</td>
             <td>No</td>
             <td>
                <p><code>                -D Finance-Domain               </code></p>
                <p>The default value is <code>                PRIMARY               </code> .</p>
             </td>
          </tr>
          <tr class="even">
             <td>pu</td>
             <td>The pseudonym with which the user name of the user whose identity references you want to remove should be replaced. If you do not specify a pseudonym when you run the tool, a random UUID value is generated as the pseudonym by default.</td>
             <td>No</td>
             <td>
                <p><code>                -pu “123-343-435-545-dfd-4”               </code></p>
             </td>
          </tr>
          <tr class="odd">
             <td>carbon</td>
             <td>
                <p>The CARBON HOME. This should be replaced with the variable <code>                $CARBON_HOME               </code> in directories configured in the main configuration file.</p>
             </td>
             <td>No</td>
             <td><code>               -carbon “/usr/bin/wso2sp/wso2sp4.1.0              </code></td>
          </tr>
       </tbody>
    </table>

## Creating GDPR compliant Siddhi applications

The obfuscation/removal of such PII (Personally Identifiable Information) can be handled in the Streaming Integrator via Siddhi Applications that can either modify or remove records that contain the PII. These Siddhi Applications can be written in  a way to match the original queries that captured data for persistence so that the same data can be modified or removed as required. For more information about writing Siddhi Queries, see [Siddhi Query Guide](https://siddhi-io.github.io/siddhi/documentation/siddhi-4.x/query-guide-4.x/).

The following sections explain how obfuscation/deletion of sensitive data can be managed via Siddhi queries in a custom Siddhi application developed based on a specific user case.

- [Obfuscating PII](#CreatingGDPRCompliantSiddhiApplications-ObfuscatingPII)
- [Deleting PII](#CreatingGDPRCompliantSiddhiApplications-DeletingPII)

### Obfuscating PII

Let's consider a Siddhi application that includes the following store definition to persist streaming data.

`define table customerTable (customerId string, customerName string, entryVector int);`

In this example, the customer ID is considered PII, and a customer with the `XXX` ID wants that ID to be hidden in the system so that he/she cannot be personally identified with it. Therefore, you need to obfuscate the value for the `customerId` attribute. This can be done by creating an algorithm to create a hashed value or a pseudonym to replace a specific value for the `customerId` attribute.

Let's consider that such an algorithm exists (e.g., as a function named `anonymize`). To invoke this function, you need to add a new query to the Siddhi application as shown in the sample below.

`define table customerTable (customerId string, customerName string, entryVector int);`
`define stream UpdateStream (customerId string);`


`from UpdateStream`
`select *`
**`update customerTable`**
**`set customerTable.customerName = anonymize(customerTable.customerName)`**
**`on customerTable.customerId == XXX;`**

In the above Siddhi application, the query in bold is triggered when a new event is received in the `UpdateStream` stream where the value for the `customerId` attribute is `XXX`. Once it is triggered, the `XXX` customer ID is replaced with a pseudonym.

For more information about writing custom functions, see [Siddhi Query Guide - Writing Custom Extensions](https://siddhi-io.github.io/siddhi/documentation/siddhi-4.x/query-guide-4.x/#writing-custom-extensions).

### Deleting PII

Let's assume that the customer ID in the scenario described above needs to be deleted. To do this, you can write a Siddhi query to delete the value for the `customerId` attribute when is equal to `XXX` as shown below.

`define table customerTable (customerId string, customerName string, entryVector int);`
`define stream DeleteStream (customerId string);`


**`from DeleteStream`**
**`delete customerTable`**
**`on customerTable.customerId == customerId;`**


In the above Siddhi application, the query in bold is triggered when a new event is received in the `DeleteStream` stream where the value for the `customerId` attribute is XXX. Once it is triggered, the `XXX` customer ID is deleted.

For more information about the Delete operator used here, see [Siddhi Query Guide - Delete](https://siddhi-io.github.io/siddhi/documentation/siddhi-4.x/query-guide-4.x/#delete).


## Forget-me tool overview

The Forget-me tool is shipped with the Streaming Integrator by default in the `<SI_HOME>/wso2/tools/identity-anonymization-tool-x.x.x` directory. If required, you can change the default location of the configurations of this tool or make changes to the default configurations. You can also run the Forget-me tool in the standalone mode.


### Changing the default configurations location

You can change the default location of the tool configurations if required. You may want to do this if you are working with a multi-product environment where you want to manage configurations in a single location for ease of use. Note that this is **optional** .

To change the default configurations location for the embedded tool, do the following:

1. Open the `forgetme.sh` file found inside the `<SI_HOME>/bin` directory.

2. The location path is the value given after `-d` within the following line. Modify the value after `-d` to change the location.

    !!! info
        The default location path is `$CARBON_HOME/repository/components/tools/forget-me/conf`.


    ``` java
        sh $CARBON_HOME/repository/components/tools/identity-anonymization-tool/bin/forget-me -d $CARBON_HOME/repository/components/tools/identity-anonymization-tool/conf -carbon $CARBON_HOME $@
    ```

### Changing the default configurations of the tool

All configurations related to this tool can be found inside the `<SI_HOME>/wso2/tools/identity-anonymization-tool/conf` directory. The default configurations are set up as follows:

- **Read Logs**: `<SI_HOME>/wso2/server/logs`, `<SI_TOOLING_HOME>/wso2/server/logs`

- **Read Datasource**: `<SI_HOME>/conf/server/deployment.yaml` file, `<SI_TOOLING_HOME>/conf/server/deployment.yaml` file

- **Default datasources**: `WSO2_CARBON_DB, WSO2_METRICS_DB`, `WSO2_PERMISSIONS_DB`, `WSO2_DASHBOARD_DB`, `BUSINESS_RULES_DB`, `SAMPLE_DB`, `WSO2_STATUS_DASHBOARD_DB`

- **Log file name regex**: The regex patterns defined in all the files in the `<SI_HOME>/wso2/tools/identity-anonymization-tool/conf/log-config` directory are considered.

For information on changing these configurations, see [Configuring the config.json file](https://docs.wso2.com/display/ADMIN44x/Removing+References+to+Deleted+User+Identities+in+WSO2+Products#RemovingReferencestoDeletedUserIdentitiesinWSO2Products-Configuringtheconfig.jsonfile) in the Product Administration Guide.

### Running the Forget-me tool in the standalone mode

This tool can run standalone and therefore cater to multiple products. This means that if you are using multiple WSO2 products and need to delete the user's identity from all products at once, you can do so by running the tool in standalone mode.

For information on how to build and run the Forget-Me tool, see [Removing References to Deleted User Identities in WSO2 Products](https://docs.wso2.com/display/ADMIN44x/Removing+References+to+Deleted+User+Identities+in+WSO2+Products) in the WSO2 Administration Guide.