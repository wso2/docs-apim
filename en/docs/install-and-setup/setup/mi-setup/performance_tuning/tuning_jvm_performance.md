# Java Virtual Machine Performance Tuning

You can tune the Java Virtual Machine (JVM) settings to make a production system more efficient.

You can configure the JVM parameters in the
`MI_HOME/bin/micro-integrator.bat        ` file (on Windows) or the
`MI_HOME/bin/micro-integrator.sh        ` file (on
Linux/Solaris). Following are the most important JVM parameters you need
to configure:

-   **Maximum Heap Memory Allocation (Xmx)** - This parameter sets the
    maximum heap memory allocated for the JVM. Increasing the memory
    allocation increases the memory available for the server, which
    results in increasing the maximum TPS and reducing the latency. We
    recommend atleast 2 GB of heap memory allocation for instances.  
    For example, If you want to set 2 GB as the maximum heap memory
    size, you need to configure the parameter as follows:

    ```
    -Xms2048m -Xmx2048m
    ```

    Here, **Xmx** is the maximum memory allocation pool for a JVM.
    **Xms** is the initial memory allocation pool.  

-   **Metaspace size** - In JDK 1.8.\*, class metadata is stored in the
    native heap, and this space is called Metaspace. By default class
    metadata allocation is only limited by the amount of available
    native memory. If you need to limit the amount of native memory used
    for class metadata, you need to set **MaxMetaspaceSize**.
    To ensure the stability of a production system, you can set the
    **MaxMetaspaceSize** parameter to 1GB as follows:

    ```
    -XX:MaxMetaspaceSize=1g
    ```

When an XML element has a large number of sub elements and the system
tries to process all the sub elements, the system can become unstable
due to a memory overhead. This is a security risk.

To avoid this issue, you can define a maximum level of entity
substitutions that the XML parser allows in the system. You do this
using the <b>entity expansion limit</b> as follows in the
`MI_HOME/bin/micro-integrator.bat        ` file (for Windows) or
the `MI_HOME/bin/micro-integrator.sh        ` file (for
Linux/Solaris). The default entity expansion limit is 64000.

```
-DentityExpansionLimit=10000
```