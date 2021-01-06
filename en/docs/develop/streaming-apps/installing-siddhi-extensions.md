# Installing Siddhi Extensions

Streaming Integrator Tooling uses Siddhi extensions to connect with various data sources. Siddhi extensions can be installed or un-installed using the Extension Installer.

!!!Tip
    The Extension Installer can install/un-install extensions within Streaming Integrator Tooling. When deploying Siddhi applications in Streaming Integrator Server, these have to be manually done. For more information, see [Downloading and Installing Siddhi Extensions]({{base_path}}/streaming/connectors/downloading-and-Installing-Siddhi-Extensions).

## Managing Siddhi extensions

The following topics cover how to manage Siddhi extensions in Streaming Integrator Tooling

### Finding the Siddhi extensions to install/uninstall

To access the Extension installer and find the extensions you need to install/uninstall, follow the steps below:

1. To start Streaming Integrator Tooling, navigate to the `<SI_TOOLING_HOME>/bin` directory and issue the appropriate command out of the following based on your operating system:

    - For Windows: `tooling.bat`

    - For Linux: `./tooling.sh`


2. Click **Tools** menu option, and then click **Extension Installer**.

    ![Extensions Installer option in the Tools menu]({{base_path}}/assets/img/streaming/installing-siddhi-extensions/tools-menu.png)

    The **Extension Installer** dialog box opens as shown below.

    ![Extension Installer]({{base_path}}/assets/img/streaming/streaming-integrator-studio-overview/extension-installer.png)


3. Locate the extension that you want to install/un-install. You can enter the name, or a part of the name of the relevant extension in the **Search** field. It filters one or more extensions that match the entered key word.

    !!!info
        The status of the extension can be one of the following.<br/><br/>
        - **Installed**<br/>This indicates that the extension is completely installed. The installation includes the JAR of the extension itself as well as all its dependencies (if any).<br/><br/>
        - **Not-Installed**<br/>This indicates that the extension has not been installed. The JAR of the extension itself has not been installed. Dependencies (if any) may be already installed due to shared dependencies. For more information about shared dependencies, see step 2 of [Un-installing an extension](#un-installing-an-extension).<br/><br/>
        - **Partially-Installed**<br/>This indicates that the JAR of the extension itself has been installed, but one or more dependencies of the extension still need to be installed.<br/> If these extensions need to be manually installed, it is indicated by an information icon next to the status. For more information, see [Manually installable dependencies](#manually-installable-dependencies).<br/><br/>
        - **Restart-Required**<br/>This indicates that you need to restart Streaming Integrator Tooling in order to complete the installation/un-installation of the extension.


### Installing an extension

1. To install an extension, click **Install** for it.

    ![Not Installed Extension]({{base_path}}/assets/img/streaming/installing-siddhi-extensions/a-not-installed-extension.png)

    Then click **Install** in the confirmation dialog box that appears to confirm whether you want to proceed with the installation.


2. Once the installation is complete, restart Streaming Integrator Tooling.

    After restarting Streaming Integrator Tooling, you can open the Extension installer and view the extension you installed with the updated status.

    ![Status Change as Installed]({{base_path}}/assets/img/streaming/installing-siddhi-extensions/installed-status.png)


### Un-installing an extension

1. To un-install an extension, click **UnInstall** for it.

    ![Installed Extension]({{base_path}}/assets/img/streaming/installing-siddhi-extensions/an-installed-extension.png)

    Then click **UnInstall** in the confirmation dialog box that appears to confirm whether you want to proceed to un-install the extension.


2. If the extension you are un-installing has shared dependencies with one or more other extensions, a message appears with information as shown in the example below.

    ![Shared Dependencies Exist Dialog Box]({{base_path}}/assets/img/streaming/installing-siddhi-extensions/shared-dependencies-exist-dialog-box.png)

    The names of the other extensions are in bold. The dependencies each extension shares with the extension you are deleting are listed under the extension name. In this example, the extension being un-installed shares the `mysql-connector-java` dependency with the `rdbms-mysql` extension, and the `siddhi-io-cdc` dependency with the `cdc-oracle`, `cdc-postgresql`, `cdc-mssql`, and `cdc-mongodb` extensions.


    If you want to proceed, click **Confirm**.

    !!! note
        If you click **Confirm** the other extensions that use the shared dependencies lose some of their dependencies. Therefore, if you need to continue to use those extensions, you need to reinstall them.

    If there are no shared dependencies, click **UnInstall** in the confirmation dialog that appears to confirm whether you want to proceed to un-install the extension.


3. Once the un-installation is completed, restart Streaming Integrator Tooling for the un-installation to be effective.


## Manually installable dependencies

Certain dependencies of some extensions cannot be automatically downloaded via the Extension Installer. These dependencies should be manually downloaded and installed in order to complete the installation of the extensions that use them.

When there is at least one such dependency for an extension, an icon is displayed next to the status of the extension as shown below.
    
![Manually Installable Dependencies Available for Extension]({{base_path}}/assets/img/streaming/installing-siddhi-extensions/manually-installable-dependencies-available.png)

Click this information to open a dialog box as shown below with information about the dependency.
    
![Manually Installable Dependency Instructions]({{base_path}}/assets/img/streaming/installing-siddhi-extensions/manually-installable-instructions.png)

The dialog box displays all the dependencies that need to be manually installed. For each dependency, the dialog box provides the following information.

- **Instructions** to download (and depending on the dependency, to convert) the JAR of the dependency.

- **Installation Location** where the downloaded JAR (and depending on the dependency, the converted OSGi bundle) needs to be placed in order to install the dependency. The following table especifies the directory in which you need to place the JAR/OSGi bundle depending on the installation location.

    |**Installation Location**|**Directory**|
    |---------------------|-----------------------------------------------------------------------------------------------------------------------------------------------|
    |**bundle in runtime**|Place the OSGi bundle you downloaded/converted in either the `<SI_HOME>/lib` or the `<SI_HOME>/bundles` directory based on the instructions.|
    |**jar in runtime**   |Place the non-OSGi bundle you downloaded in the `<SI_HOME>/jars` directory.                                                                 |
    |**jar in samples**   |Place the non-OSGi bundle you dowloaded in the `<SI_HOME>/samples/sample-clients/lib` directory.                                            |


## Configuring Extension Dependencies

Configurations of extensions are loaded from the `<SI_HOME>/wso2/server/resources/extensionsInstaller/extensionDependencies.json` configuration file.

When you are working with [custom extensions]({{base_path}}/admin/writing-Custom-Siddhi-Extensions#writing-custom-siddhi-extensions), and if you want a custom extension to be installable from the Extension Installer, you need to add the configuration of the extension to this configuration file.

The configuration of an extension is a JSON object that looks as follows:

```json
    "<extension_name>": {
      "extension": {...},
      "dependencies": [
        {...},
        {...}
      ]
    }
```

`<extension_name>` which is the key of this JSON object, is the uniquely identifiable name of the extension. The extension is described under [`extension`](#extension).

#### `extension`

This _object_ contains information about the extension, denoted by the following properties.

<table>
  <tr>
    <th>Property</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>
      <code>name</code>
    </td>
    <td>
      The uniquely identifiable name of the extension.
    </td>
  </tr>
  <tr>
    <td>
      <code>displayName</code>
    </td>
    <td>
      The displayable name of the extension.
    </td>
  </tr>
  <tr>
    <td>
      <code>version</code>
    </td>
    <td>
      The version of the extension.
    </td>
  </tr>
</table>

The following is an example of the `extension` object, taken from the configuration of the `jms` extension.

```json
  "jms": {

    "extension": {
      "name": "jms",
      "displayName": "JMS",
      "version": "2.0.2"
    },

    "dependencies": [...]
  }
```


#### `dependencies`

This is an _array_. Each member of this _array_ is an _object_ that denotes information of a dependency of the extension via the following properties.

!!! info
        The jar of the Siddhi extension itself should be added as a dependency too. e.g., In the configuration of the `jms` extension, you can see that `siddhi-io-jms` has been listed as a dependency under `dependencies`.

<table>
  <tr>
    <th>
      Property
    </th>
    <th>
      Description
    </th>
  </tr>
  <tr>
    <td>
      <code>name</code>
    </td>
    <td>
      The uniquely identifiable name of the dependency. If this dependency denotes the jar of the Siddhi extension itself, it starts with <code>siddhi-</code>.
    </td>
  </tr>
  <tr>
    <td>
      <code>version</code>
    </td>
    <td>
      The version of the dependency.
    </td>
  </tr>
  <tr>
    <td><code>download</code></td>
    <td>
      <p>This denotes download information of the dependency via the following properties.</p>
      <ul>
        <li><code>autoDownloadable</code>: This specifies whether the dependency is auto downloadable via the <code>true</code> and <code>false</code> values. If the value is <code>false</code>, the property is <a href="#manually-installable-dependencies">manually installable</a>.</li>
        <li><code>url</code>: <strong>If the dependency is auto downloadable</strong>, this specifies the URL via which the JAR of the dependency is downloaded.</li>
        <li><code>instructions</code>: <strong>If the dependency is only <a href="#manually-installable-dependencies">manually installable</a></strong>, this property provides instructions to download (and if applicable, convert) the JAR of the dependency.</li>
      </ul>
    </td>
  </tr>
  <tr>
    <td>
      <code>usages</code>
    </td>
    <td>
      <p>This is an <i>array</i>. Each member of this <i>array</i> is an <i>object</i> that denotes a directory where the jar of the dependency needs to be placed. Each such directory (location) is denoted by the following properties:</p>
      <ul>
        <li><code>type</code>: The type of the JAR. Possible values are as follows:<br/><li style="margin-left:2em"><code>BUNDLE</code>: This means that the dependency JAR is an OSGi bundle.</li><li style="margin-left:2em"><code>JAR</code>: This means that the dependency JAR is not converted to an OSGi bundle.</li></li><br/>
        <li><code>usedBy</code>: This indicates whether the JAR is used in runtime or in samples. For more information, see the explanation of <b>installation locations</b> under <a href="#manually-installable-dependencies">Manually installable dependencies</a></li>
      </ul>
    </td>
  </tr>
  <tr>
    <td>
      <code>lookupRegex</code>
    </td>
    <td>
      The regex pattern for the file name of the JAR. This is useful for to looking up and detecting whether the JAR is available in the locations mentioned under <code>usages</code>.
    </td>
  </tr>
</table>

The following examples, taken from the configuration of the `jms` extension, show the members of the `dependencies` array.

**Example 1: Auto downloadable dependency**

This denotes the `hawtbuf` dependency of the `jms` extension, which is auto downloadable from the URL specified in `download.url`.

```json
  "jms": {
    "extension": {...},

    "dependencies": [

      {
        "name": "hawtbuf",
        "version": "1.9",
        "download": {
          "autoDownloadable": true,
          "url": "https://repo1.maven.org/maven2/org/fusesource/hawtbuf/hawtbuf/1.9/hawtbuf-1.9.jar"
        },
        "usages": [
          {
            "type": "BUNDLE",
            "usedBy": "RUNTIME"
          },
          {
            "type": "JAR",
            "usedBy": "SAMPLES"
          }
        ],
        "lookupRegex": "hawtbuf([_-])1.9.jar"
      },

      ...
    ]
  }
```

**Example 2: Manually installable dependency**

This denotes the `activemq-client` dependency of the `jms` extension. This dependency needs to be manually downloaded, and the conversions should be done based on the given `download.instructions`.

```json
  "jms": {
    "extension": {...},

    "dependencies": [
      ...,

      {
        "name": "activemq-client",
        "version": "5.9.0",
        "download": {
          "autoDownloadable": false,
          "instructions": "Download the jar from 'https://repo1.maven.org/maven2/org/apache/activemq/activemq-client/5.9.0/activemq-client-5.9.0.jar' and convert ..."
        },
        "usages": [
          {
            "type": "BUNDLE",
            "usedBy": "RUNTIME"
          }
        ],
        "lookupRegex": "activemq([_-])client([_-])5.9.0(.*).jar"
      }
    ]
  }
```