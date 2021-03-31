# Troubleshooting in Production Environments

The following sections will guide you to troubleshoot various issues that may arise in your [Micro Integrator deployment]({{base_path}}/install-and-setup/setup/mi-setup/deployment/deploying_wso2_ei).

## Analyzing a stack trace

When your Java process starts to spin your CPU, you must immediately
analyze the issue using the following two commands and obtain the
invaluable information required to tackle the issue. This is done based
on the process ID (pid).

1.  `jstack <pid> > thread-dump.txt`
2.  `ps -C java -L -o pcpu,cpu,nice,state,cputime,pid,tid > thread-usage.txt`

> OS X users can alternatively use the command `ps M <PID>` instead.
    
These commands provide you with the **thread-dump.txt** file and the
**thread-usage.txt** file. After obtaining these two files, do the
following.

1.  Find the thread ID (the one that belongs to the corresponding PID)
    that takes up the highest CPU usage by examining the
    **thread-usage.txt** file.

    ```bash
    %CPU CPU  NI S     TIME   PID   TID
    .......... 
    0.0   -   0 S 00:00:00  1519  1602
    0.0   -   0 S 00:00:00  1519  1603
    24.8  -   0 R 00:06:19  1519  1604
    2.4   -   0 S 00:00:37  1519  1605
    0.0   -   0 S 00:00:00  1519  1606
    ..........
    ```

    In this example, the thread ID that takes up the highest CPU usage
    is 1604.

2.  Convert the decimal value (in this case 1604) to hexadecimal. You
    can use an [online
    converter](http://easycalculation.com/decimal-converter.php) to do
    this. The hexadecimal value for 1604 is 644.
3.  Search the **thread-dump.txt** file for the hexadecimal obtained in
    order to identify the thread that spins. In this case, the
    hexadecimal value to search for is 644. The **thread-dump.txt** file
    should have that value as a thread ID of one thread.
4.  That thread usually has a stack trace, and that's the lead you need in order
    to find the issue. In this example, the stack trace of the thread
    that spins is as follows.

    ```bash
    "HTTPS-Sender I/O dispatcher-1" prio=10 tid=0x00007fb54c010000 nid=0x644 runnable [0x00007fb534e20000]
     java.lang.Thread.State: RUNNABLE
     at org.apache.http.impl.nio.reactor.IOSessionImpl.getEventMask(IOSessionImpl.java:139)
     - locked <0x00000006cd91fef8> (a org.apache.http.impl.nio.reactor.IOSessionImpl)
     at org.apache.http.nio.reactor.ssl.SSLIOSession.updateEventMask(SSLIOSession.java:300)
     at org.apache.http.nio.reactor.ssl.SSLIOSession.inboundTransport(SSLIOSession.java:402)
     - locked <0x00000006cd471df8> (a org.apache.http.nio.reactor.ssl.SSLIOSession)
     at org.apache.http.impl.nio.reactor.AbstractIODispatch.inputReady(AbstractIODispatch.java:121)
     at org.apache.http.impl.nio.reactor.BaseIOReactor.readable(BaseIOReactor.java:160)
     at org.apache.http.impl.nio.reactor.AbstractIOReactor.processEvent(AbstractIOReactor.java:342)
     at org.apache.http.impl.nio.reactor.AbstractIOReactor.processEvents(AbstractIOReactor.java:320)
     at org.apache.http.impl.nio.reactor.AbstractIOReactor.execute(AbstractIOReactor.java:280)
     at org.apache.http.impl.nio.reactor.BaseIOReactor.execute(BaseIOReactor.java:106)
     at org.apache.http.impl.nio.reactor.AbstractMultiworkerIOReactor$Worker.run(AbstractMultiworkerIOReactor.java:604)
     at java.lang.Thread.run(Thread.java:722)
    ```

## Capturing the state of the system

**Carbondump** is a tool that is used to collect all the necessary data from a
running WSO2 product instance at the time of an error.
The carbondump generates a ZIP archive with the collected data that
helps to analyze the system and to determine the problem that caused the
error. Therefore, it is recommended that you run this tool as soon as an
error occurs in the your product instance.

As with any other java product, if your WSO2 Micro Integrator cluster fails due to a resource exhaustion, the heap and thread dumps will always point you towards the cause of the leak. Therefore, it is important to be able to retrieve heap and thread dumps from an environment at the point when an error occurs. This will avoid the necessity of reproducing the exact issue again (specially, in the case of production issues). A resource exhaustion can happen for two reasons:

- Due to a bug in the system.
- An actual limitation of resources based on low configuration values.

You can easily create a heap dump and thread dump using the CarbonDump tool that is shipped with your product. These will also provide information about the product version and any patch inconsistencies.

!!! info
    If you are using an Ubuntu version 10.10 or above and if you get an error on being unable to attach the process, execute the following command to rectify it: 

    `echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope`

    This changes the yama/ptrace_scope variable of the kernel temporarily (i.e., until the next reboot). For more information, see the [Oracle documentation](https://bugs.java.com/bugdatabase/view_bug.do?bug_id=7050524).

When using the tool, you have to provide the process ID (pid) of the
product instance and the `MI_HOME` location,
which is where your unzipped Micro Integrator distribution files reside. The
command takes the following format:

```bash
sh carbondump.sh [-carbonHome path] [-pid of the carbon instance]
```

For example,

- In Linux: `sh carbondump.sh -carbonHome /home/user/wso2ei-<version>/ -pid 5151`
    
- In Windows: `carbondump.bat -carbonHome c:\wso2ei-<version>\ -pid 5151`

The tool captures the following information about the system:

-   Operating system information (**kernel version**)
    -   Installed modules lists and their information
    -   List of running tasks in the system
-   Memory information of the Java process (**Java heap memory dump**)
    -   Histogram of the heap
    -   Objects waiting for finalization
    -   Java heap summary. GC algo used, etc.
    -   Statistics on permgen space of Java heap
-   Information about the running Micro Integrator instance (**Product name and
    version**)
    -   Carbon framework version (This includes the patched version)
    -   MI_HOME, JAVA_HOME
    -   Configuration files
    -   Log files
    -   H2 database files
-   Thread dump
-   Checksum values of all the files found in the MI_HOME.

## Viewing process threads in Solaris

This information is useful to understandand whether the database
processes are not fully utilizing the CPU's threading capabilities. It
gives you a better understanding on how 11g and 10g takes advantage of
threading and how you can validate those queries from the system.

The following information provides insight on whether a Solaris process
is parallelized and is taking advantage of the threading within the CPU.

1.  Open a command line in Solaris.
2.  Run `           prstat          ` and have a look to the last
    column, labeled `           PROCESS/NLWP          ` . NLWP is a
    reference to the number of lightweight processes and are the number
    of threads the process is currently using with Solaris as there is a
    one-to-one mapping between lightweight processes and user threads. A
    single thread process will show `           1          ` there while
    a multi-threaded one will show a larger number. See the following
    code block for an example.  

    ``` java
    PID USERNAME  SIZE   RSS STATE  PRI NICE      TIME  CPU PROCESS/NLWP       
    ...
    12905 root     4472K 3640K cpu0    59    0   0:00:01 0.4% prstat/1
    18403 monitor   474M  245M run     59   17   1:01:28 9.1% java/103
    4102 oracle     12G   12G run     59    0   0:00:12 4.5% oracle/1
    ```

    If you observe the `           PROCESS/NLWP          ` value in the
    example above, you can identify that `           prstat          `
    and `           oracle          ` are single thread processes, while
    `           java          ` is a multi-threaded process.

3.  Alternatively, you can analyze individual thread activities of a
    multi-threaded process by using the `           -L          ` and
    `           -p          ` options such as
    `           prstat -L -p pid          ` . This displays a line for
    each thread sorted by the CPU activity. In that case, the last column is
    labeled `           PROCESS/LWPID          `, where LWPID is the
    thread ID. If more than one thread shows significant activity, your
    process is actively taking advantage of multi-threading.
