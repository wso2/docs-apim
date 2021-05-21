# Installing the API Manager Runtime

Follow the steps given below to install the WSO2 API Manager runtime.

## Before you begin

See the [Installation Prerequisites]({{base_path}}/install-and-setup/install/installation-prerequisites). 
Java Development Kit (JDK) is essential to run the product.

## Installing the API Manager

1.  Go to the [WSO2 API Manager website](https://wso2.com/api-management/), click **TRY IT NOW**, and then click **Zip Archive** to download the API Manager distribution as a ZIP file.
2.  Extract the archive file to a dedicated directory for the API Manager, which will hereafter be referred to as `<API-M_HOME>`.

## Setting up JAVA_HOME

You must set your `JAVA_HOME` environment variable to point to the directory where the Java Development Kit (JDK) is installed on the computer.

!!! info
    Environment variables are global system variables accessible by all the processes running under the operating system.

??? note "On Linux/OS X"

    1.  In your home directory, open the BASHRC file (.bash\_profile file on Mac) using editors such as vi, emacs, pico, or mcedit.
    2.  Assuming you have JDK 1.8.0\_xx in your system, add the following two lines at the bottom of the file, replacing `/usr/java/jdk1.8.0_xx` with the actual directory where the JDK is installed.

        ``` java
        On Linux:
        export JAVA_HOME=/usr/java/jdk1.8.0_xx
        export PATH=${JAVA_HOME}/bin:${PATH}
             
        On OS X:
        export JAVA_HOME=/System/Library/Java/JavaVirtualMachines/1.8.0.jdk/Contents/Home
        ```

    3.  Save the file.

        !!! info
        
            If you do not know how to work with text editors in a Linux SSH session, run the following command: `cat >> .bashrc.` Paste the string from the clipboard and press "Ctrl+D."


    4.  To verify that the `JAVA_HOME` variable is set correctly, execute the following command.

        ``` java
        On Linux:
        echo $JAVA_HOME
            
        On OS X:
        which java
        If the above command gives you a path like /usr/bin/java, then it is a symbolic link to the real location. To get the real location, run the following:
        ls -l `which java`
        ```
    The system returns the JDK installation path.

??? note "On Solaris"

    1.  In your home directory, open the BASHRC file in your favorite text editor such as vi, emacs, pico, or mcedit.
    2.  Assuming you have JDK 1.8.0\_xx in your system, add the following two lines at the bottom of the file, replacing `/usr/java/jdk1.8.0_xx` with the actual directory where the JDK is installed.

        ``` java
        export JAVA_HOME=/usr/java/jdk1.8.0_xx
        export PATH=${JAVA_HOME}/bin:${PATH}
        ```

        The file should now look like this:

        ![]({{base_path}}/assets/attachments/103334399/103334401.png)

    3.  Save the file.

        !!! info
            
            If you do not know how to work with text editors in an SSH session, run the following command: `cat >> .bashrc          `

        Paste the string from the clipboard and press "Ctrl+D."


    4.  To verify that the `JAVA_HOME` variable is set correctly, execute the following command:

        `echo $JAVA_HOME`

    5.  The system returns the JDK installation path.

??? note "On Windows"

    Typically, the JDK is installed in a directory under `C:/Program Files/Java` , such as `C:/Program Files/Java/jdk1.8.0_xx`. If you have multiple versions installed, choose the latest one, which you can find by sorting by date.

    You set up `JAVA_HOME` using the System Properties, as described below. Alternatively, if you just want to set `JAVA_HOME` temporarily for the current command prompt window, set it at the command prompt.

    **Setting up JAVA\_HOME using the system properties**

    1.  Right-click the **My Computer** icon on the desktop and click **Properties.**

        ![]({{base_path}}/assets/attachments/thumbnails/26838941/27042151)

    2.  In the System Properties window, click the **Advanced** tab, and then click **Environment Variables**.

        ![]({{base_path}}/assets/attachments/26838941/27042150.png)

    3.  Click **New** under **System variables** (for all users) or under **User variables** (just for the user who is currently logged in).

        ![]({{base_path}}/assets/attachments/thumbnails/26838941/27042154)

    4.  Enter the following information:
        -   In the **Variable name** field, enter: `JAVA_HOME`
        -   In the **Variable value** field, enter the installation path of the Java Development Kit, such as: `c:/Program Files/Java/jdk1.8.0_xx           `

    The `JAVA_HOME` variable is now set and will apply to any subsequent command prompt windows you open. If you have existing command prompt windows running, you must close and reopen them for the `JAVA_HOME` variable to take effect, or manually set the `JAVA_HOME` variable in those command prompt windows as described in the next section. To verify that the `JAVA_HOME` variable is set correctly, open a command window (from the **Start** menu, click **Run**, and then type `CMD` and click **Enter**) and execute the following command:

    `set JAVA_HOME`

    The system returns the JDK installation path.

## Setting system properties

If you need to set additional system properties when the server starts, you can take the following approaches:

-   **Set the properties from a script** : Setting your system properties in the startup script is ideal because it ensures that you set the properties every time you start the server. To avoid having to modify the script each time you upgrade, the best approach is to create your startup script that wraps the WSO2 startup script and adds the properties you want to set, rather than editing the WSO2 startup script directly.
-   **Set the properties from an external registry** : If you want to access properties from an external registry, you could create Java code that reads the properties at runtime from that registry. Be sure to store sensitive data such as username and password to connect to the registry in a property file instead of in the Java code and secure the properties file with the [secure vault](https://docs.wso2.com/display/ADMIN44x/Carbon+Secure+Vault+Implementation).

!!! info

    When using SUSE Linux, it ignores `/etc/resolv.conf` and only looks at the `/etc/hosts` file. This means that the server will throw an exception on startup if you have not specified anything besides localhost. To avoid this error, add the following line above `127.0.0.1 localhost` in the `/etc/hosts` file: `<ip_address><machine_name> localhost`.

## What's Next?

-   [Running the API-M Runtime]({{base_path}}/install-and-setup/install/installing-the-product/running-the-api-m).

