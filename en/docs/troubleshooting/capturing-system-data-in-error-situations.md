# Capturing System Data in Error Situations

Carbon Dump is a tool for collecting all the necessary data(i.e., heap and thread dumps) from a running Carbon instance at the time of an error for a head dump and thread stack analysis. The Carbon Dump generates a ZIP archive with the collected data, which helps the WSO2 support team to analyze your system and determine the problem which caused the error. Therefore, it is recommended that you run this tool as soon as an error occurs in the Carbon instance.

As with any other java product, if your WSO2 product cluster fails due to a resource exhaustion, the heap and thread dumps will always point you towards the cause of the leak. Therefore, it is important to be able to retrieve heap and thread dumps from an environment at the point when an error occurs. This will avoid the necessity of reproducing the exact issue again (specially, in the case of production issues). A resource exhaustion can happen for two reasons:

-   Due to a bug in the system.
-   An actual limitation of resources based on low configuration values.

You can easily create a heap dump and thread dump using the CarbonDump tool that is shipped with your product. These will also provide information about the product version and any patch inconsistencies.

!!! note
If you are using an Ubuntu version 10.10 or above and if you get an error on being unable to attach the process, execute the following command to rectify it: `$ echo 0 |` sudo `tee /proc/sys/kernel/` yama `/ptrace_scope        `

This changes the yama `/ptrace_scope` variable of the kernel temporarily (i.e., until the next reboot). For more information, go to [Oracle documentation](http://bugs.java.com/bugdatabase/view_bug.do?bug_id=7050524) .


When using the tool, you have to provide the process ID (pid) of the Carbon instance and the &lt;PRODUCT\_HOME&gt; which is where your unzipped Carbon distribution files reside. The command takes the following format:

``` java
    sh carbondump.sh [-carbonHome path] [-pid of the carbon instance]
```

For example,

``` java
    In Linux: sh carbondump.sh -carbonHome /home/user/wso2carbon-3.2.0/ -pid 5151
    In Windows: carbondump.bat -carbonHome c:\wso2carbon-3.2.0\ -pid 5151
```
The tool captures the following information about the system:

-   Operating system information \*\* OS (kernel) version
    -   Installed modules lists and their information
    -   List of running tasks in the system
-   Memory information of the Java process \*\* Java heap memory dump
    -   Histogram of the heap
    -   Objects waiting for finalization
    -   Java heap summary. GC algo used, etc.
    -   Statistics on permgen space of Java heap
-   Information about the running Carbon instance \*\* Product name and version
    -   Carbon framework version (This includes the patched version)
    -   &lt;PRODUCT\_HOME&gt;, &lt;JAVA\_HOME&gt;
    -   configuration files
    -   log files
    -   H2 database files
-   Thread dump
-   Checksum values of all the files found in the $CARBON\_HOME

