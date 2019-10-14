# admin\_Customizing the Management Console

See the following topics to do customizations to the management console:

-   [Changing the management console's URL](#admin_CustomizingtheManagementConsole-Changingthemanagementconsole'sURL)
-   [Configuring the session time-out](#admin_CustomizingtheManagementConsole-Configuringthesessiontime-out)
-   [Changing the management console's interface](#admin_CustomizingtheManagementConsole-Changingthemanagementconsole'sinterface)

### Changing the management console's URL

When you start a WSO2 server, the URL of the management console will be printed on the terminal. The URL format is as follows: `https://<Server Host>:<Management Console Port>/carbon/.` When accessing the management console from the same server where it is installed, you can type `localhost` instead of the IP address.

You can change the URL by modifying the value of the `<MgtHostName>` property in the `<EI_HOME>/conf/carbon.xml` file. When the host is internal or not resolved by a DNS, map the hostname alias to its IP address in the `/etc/hosts` file of your system, and then enter that alias as the value of the `<MgtHostName>` property in `carbon.xml` . For example:

``` java
    In /etc/hosts:
    127.0.0.1       localhost
In carbon.xml:
<MgtHostName>localhost</MgtHostName>
```
### Configuring the session time-out

If you leave the management console unattended for a defined time, its login session will time out. The default timeout value is 15 minutes, but you can change this in the `<PRODUCT_HOME>/repository/conf/tomcat/carbon/WEB-INF/web.xml` file as follows.

``` html/xml
    <session-config>
       <session-timeout>15</session-timeout>
    </session-config>
```

### Changing the management console's interface

The user interfaces of every Carbon product allows you to configure, monitor, tune, and maintain the product. The components that formulate the design and style of these user interfaces are defined in resource (JAR) files.

The user interface of every Carbon product consists of two layers:

-   The common product layout/design inherited from the Carbon platform: All the common templates, styles (CSS files), and images are stored in the Carbon core UI bundle, which is named `org.wso2.carbon.ui-<version-number>.jar` ( `<version-number>` is the particular version of the bundle). This bundle is responsible for the overall look and feel of the entire Carbon platform.

-   The styles/images unique to each product: Each Carbon product (that is built on Carbon kernel) has another style bundle, which contains all the overriding style sheets and images: `org.wso2.<product-name>.styles-<version-number>.jar` .

You can customize the user interfaces by modifying these resource files. You need to create a fragment bundle for the original resource file. Then, you can pack the modified resource files in the required bundle. The files in the required bundle will get precedence and will override the files in the original bundle.

You can use this same technique to customize any aspect of the user interfaces. The advantage of this technique is that you will not lose your customizations when you apply official patches to the product by replacing the original bundles.

For example, when you access the Management Console using the following URL, by default, it has the WSO2 product logo as shown below: <https://10.100.5.72:9443/carbon/>

!!! info
Note that the images and instructions given on this page are valid for WSO2 products that are based on Carbon 4.4.x.


![current logo of the Management Console]({{base_path}}/assets/attachments/126562834/126562837.png)

Follow the steps below to customize the above management console by changing the logo.

1.  Open the `<PRODUCT_HOME>/repository/components/plugins/` directory. You need to find the bundle that contains the resource files that you want to modify. In this case, the logo and the related CSS files are contained in the `org.wso2.carbon.ui_<version-number>.jar` file. Copy the `org.wso2.carbon.ui_<version-number>.jar` file to a separate location on your computer, and extract the file. Note the symbolic name of this bundle, which is ' `org.wso2.carbon.ui_<version-number>` '.

2.  Create a new Maven project using your IDE. Be sure to include the symbolic name of the original bundle that you extracted in the previous step (which is ' `org.wso2.carbon.ui_<version-number>` ') in the Maven project name. For example, you can use `org.wso2.carbon.ui_<version-number>_patch` as the Maven project name.

3.  Add the following content to the `pom.xml` file of the `org.wso2.carbon.ui_<version-number>_patch` project. In this `pom.xml` file, be sure to replace the `<version-number>` of `org.wso2.carbon.ui_<version-number>_patch` with the correct version value.

    ``` xml
        <?xml version="1.0" encoding="UTF-8"?>
        <project xmlns="http://maven.apache.org/POM/4.0.0"
                 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                 xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
            <modelVersion>4.0.0</modelVersion>
        <groupId>org.wso2.carbon</groupId>
        <artifactId>org.wso2.carbon.ui_<version-number>_patch</artifactId>
        <version>1.0.0</version>
        <packaging>bundle</packaging>

        <build>
            <plugins>
                <plugin>
                    <groupId>org.apache.felix</groupId>
                    <artifactId>maven-bundle-plugin</artifactId>
                    <version>3.0.1</version>
                    <extensions>true</extensions>
                    <configuration>
                        <instructions>
                            <Bundle-SymbolicName>${project.artifactId}</Bundle-SymbolicName>
                            <Bundle-Name>${project.artifactId}</Bundle-Name>
                            <Export-Package>web.admin.*</Export-Package>
                        </instructions>
                    </configuration>
                </plugin>
            </plugins>
        </build>
    </project>
    ```
4.  Create directories in your Maven project as explained below.

    1.  Create the `/web` folder under the `/src/main/resources` directory of the `org.wso2.carbon.ui_<version-number>_patch` project.

    2.  Then, create the /admin directory under /web.

    3.  Finally, create the `/css`, `/images` , and `/layout` directories under `/admin` .

    Your `org.wso2.carbon.ui_<version-number>_patch` project should now look as shown below.
    ![]({{base_path}}/assets/attachments/126562834/126562838.png)
5.  Create a new CSS file (e.g. `customizations.css` ) with the following content.

    ``` css
        #header div#header-div div.left-logo {
            background-image: url( ../images/new-logo.png );
            background-repeat: no-repeat;
            background-position: left top;
            background-size: contain;
            height: 40px;
            width: 300px;
            margin-top: 23px;
            margin-left: 20px;
            float: left;
        }
    ```

        !!! tip
    This file includes the logo customization styles.


6.  Add the `customizations.css` file to the `<org.wso2.carbon.ui_<version-number>_patch>/src/main/resources/web/admin/css/` directory.

7.  Locate the `template.jsp` file that is in the `org.wso2.carbon.ui_<version-number>.jar` bundle, which you extracted in step 1 above. You will find `template.jsp` file inside the `<org.wso2.carbon.ui_<version-number>.jar>/web/admin/layout/` directory. Then, copy this file to the `<org.wso2.carbon.ui_<version-number>_patch>/src/main/resources/web/admin/layout/` directory.

8.  Locate the following line in the `<org.wso2.carbon.ui_<version-number>_patch>/src/main/resources/web/admin/layout/template.jsp` file, which you added in the previous step:

    ``` java
        <link href="<%=globalCSS%>" rel="stylesheet" type="text/css" media="all"/>
    ```

9.  Replace the above line with the following:

    ``` java
            <link href="../admin/css/customizations.css" rel="stylesheet" type="text/css" media="all"/>
    ```

10. Add the below image as the new logo (e.g. `new-logo.png` ) to the `<org.wso2.carbon.ui_<version-number>_patch>/src/main/resources/web/admin/images/` directory.

    ![new logo]({{base_path}}/assets/attachments/126562834/126562836.png)

11. Create another Maven project using your IDE. Be sure to include the symbolic name of the original bundle that you extracted in step 1 above (which is ' `org.wso2.carbon.ui_<version-number>` ') in the project name. For example, you can use `org.wso2.carbon.ui_<version-number>_fragment` as the Maven project name.

        !!! info
    This creates a project for the fragment bundle. Since the symbolic name of the original bundle is ‘ `org.wso2.carbon.ui` ’, the fragment host value of this bundle should be the same (e.g. `org.wso2.carbon.ui_<version-number>_fragment` ). This fragment bundle will not contain anything (expect the `pom.xml` file) when it is built.


12. Add the following content to the `pom.xml` file of the `org.wso2.carbon.ui_<version-number>_fragment` project. In this `pom.xml` file, replace the `<version-number>` of `org.wso2.carbon.ui_<version-number>_patch` and `org.wso2.carbon.ui_<version-number>_fragment` with the correct version value.

        !!! info
    This `pom.xml` file of the fragment bundle defines properties, which includes the required bundle value (i.e. ‘ `org.wso2.carbon.ui_<version-number>_patch` ’).


    ``` xml
        <?xml version="1.0" encoding="UTF-8"?>
        <project xmlns="http://maven.apache.org/POM/4.0.0"
                 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                 xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
            <modelVersion>4.0.0</modelVersion>
        <groupId>org.wso2.carbon</groupId>
        <artifactId>org.wso2.carbon.ui_<version-number>_fragment</artifactId>
        <version>1.0.0</version>
        <packaging>bundle</packaging>

        <build>
            <plugins>
                <plugin>
                    <groupId>org.apache.felix</groupId>
                    <artifactId>maven-bundle-plugin</artifactId>
                    <version>3.0.1</version>
                    <extensions>true</extensions>
                    <configuration>
                        <instructions>
                            <Bundle-SymbolicName>${project.artifactId}</Bundle-SymbolicName>
                            <Bundle-Name>${project.artifactId}</Bundle-Name>
                            <Require-Bundle>org.wso2.carbon.ui_<version-number>_patch</Require-Bundle>
                            <Fragment-Host>org.wso2.carbon.ui</Fragment-Host>
                        </instructions>
                    </configuration>
                </plugin>
            </plugins>
        </build>
    </project>
    ```
13. Now you can build the two projects. Open a terminal, navigate to the relevant project directory (listed above), and execute the following command: mvn `clean install.`
    -`org.wso2.carbon.ui_<version-number>_fragment`

    -`org.wso2.carbon.ui_<version-number>_patch`

14. Once the project is built, copy the two JAR files listed below (from the `<PROJECT_HOME>/target/` directory) to the `<PRODUCT_HOME>/repository/components/dropins/` directory.
    -`org.wso2.carbon.ui_<version-number>_fragment-1.0.0.jar`

    -`org.wso2.carbon.ui_<version-number>_patch-1.0.0.jar`

15. Restart the WSO2 product server.
16. Access the management console of your WSO2 product using the following URL: <https://10.100.5.12:9443/carbon/> . You view the new logo, which the patch bundle contains as shown below.

    ![Management Console with the new logo]({{base_path}}/assets/attachments/126562834/126562839.png)

