# Network and OS Level Performance Tuning

When it comes to performance, the OS that the server runs plays an
important role. This page describes the parameters that you can
configure to optimize the network and OS performance.

!!! Info
    If you are running MacOS Sierra and experience long startup times for WSO2 products, try mapping your Mac hostname to 127.0.0.1 and ::1 in the `/etc/hosts` file as described in [this blog post](http://shammijayasinghe.blogspot.com/2017/04/wso2-server-startup-taking-lot-of-time.html).

Following are the files and parameters you can configure to optimize performance:

-   Configure the following parameters in the `/etc/sysctl.conf` file of Linux for maximum
    concurrency. These parameters can be set to specify a larger port
    range, a more effective TCP connection timeout value, and a number
    of other important settings at the OS-level based on your
    requirement.  

    !!! Info
        Since all these settings apply at the OS level, changing settings
        can affect other programs running on the server. The sample values
        specified here might not be the optimal values for your production
        system. You need to apply the values and run a performance test to
        find the best values for your production system.
    

    <table>
    <colgroup>
    <col style="width: 33%" />
    <col style="width: 33%" />
    <col style="width: 33%" />
    </colgroup>
    <thead>
    <tr class="header">
    <th>Parameter</th>
    <th>Description</th>
    <th>Recommended Value</th>
    </tr>
    </thead>
    <tbody>
    <tr>
    <td>net.ipv4.tcp_fin_timeout</td>
    <td>This is the length of time (in seconds) that TCP takes to receive a final FIN before the socket is closed. Setting this is required to prevent DoS attacks.</td>
    <td>30</td>
    </tr>
    <tr>
    <td><code>               net.ipv4.tcp_tw_recycle              </code></td>
    <td><p>This enables fast recycling of TIME_WAIT sockets.</p>
        <b>Note</b>:
        <p>Change this with caution and ONLY in internal networks where the network connectivity speeds are faster.<br />
        It is not recommended to use <code>                net.ipv4.tcp_tw_recycle = 1               </code> when working with network address translation (NAT), such as if you are deploying products in EC2 or any other environment configured with NAT.</p>
    <p><br />
    </p></td>
    <td>1</td>
    </tr>
    <tr>
    <td><code>               net.ipv4.tcp_tw_reuse              </code></td>
    <td>This allows reuse of sockets in TIME_WAIT state for new connections when it is safe from the network stack’s perspective.</td>
    <td>1</td>
    </tr>
    <tr>
    <td><code>               net.core.rmem_default              </code></td>
    <td>This sets the default OS receive buffer size for all types of connections.</td>
    <td>524288</td>
    </tr>
    <tr>
    <td><code>               net.core.wmem_default              </code></td>
    <td>This sets the default OS send buffer size for all types of connections.</td>
    <td>524288</td>
    </tr>
    <tr>
    <td><code>               net.core.rmem_max              </code></td>
    <td>This sets the maximum OS receive buffer size for all types of connections.</td>
    <td>67108864</td>
    </tr>
    <tr>
    <td><code>               net.core.wmem_max              </code></td>
    <td>This sets the maximum OS send buffer size for all types of connections.</td>
    <td>67108864</td>
    </tr>
    <tr>
    <td><code>               net.ipv4.tcp_rmem              </code></td>
    <td>This specifies the receive buffer space for each TCP connection and has three values that hold the following information:<br />
    The first value is the minimum receiver buffer space for each TCP connection, and this buffer is always allocated to a TCP socket, even under high pressure on the system.<br />
    The second value is the default receive buffer space allocated for each TCP socket. This value overrides the <code>               /proc/sys/net/core/rmem_default              </code> value used by other protocols.<br />
    The last value is the maximum receive buffer space allocated for a TCP socket.</td>
    <td>4096 87380 16777216</td>
    </tr>
    <tr>
    <td><code>               net.ipv4.tcp_wmem              </code></td>
    <td><p>This specifies the send buffer space for each TCP connection and has three values that hold the following information:<br />
    The first value is the minimum TCP send buffer space available for a single TCP socket.<br />
    The second value is the default send buffer space allowed for a single TCP socket to use.<br />
    The third value is the maximum TCP send buffer space.</p>
    <p>Every TCP socket has the specified amount of buffer space to use before the buffer is filled up, and each of the three values are used under different conditions.</p></td>
    <td>4096 65536 16777216</td>
    </tr>
    <tr>
    <td><p><code>                net.ipv4.ip_local_port_range               </code></p></td>
    <td><p>This defines the local port range that is used by TCP and UDP to choose the local port. The first number is the first local port allowed for TCP and UDP traffic, and the second number is the last port number.<br />
    If your Linux server is opening a large number of outgoing network connections, you need to increase the default local port range. In Linux, the default range of IP port numbers allowed for TCP and UDP traffic is small, and if this range is not changed accordingly, a server can come under fire if it runs out of ports.</p></td>
    <td>1024 65535</td>
    </tr>
    <tr>
    <td><p><code>                fs.file-max               </code></p></td>
    <td>This is the maximum number of file handles that the kernel can allocate. The kernel has a built-in limit on the number of files that a process can open. If you need to increase this limit, you can increase the fs.file-max value although it can take up some system memory.</td>
    <td>2097152</td>
    </tr>
    </tbody>
    </table>

-   Configure the following parameters in the
    `/etc/security/limits.conf` file of Linux if
    you need to alter the maximum number of open files allowed for
    system users.

    ```
    * soft nofile 4096
    * hard nofile 65535
    ```

    !!! Info
        The \* character denotes that the limit is applicable to all system
        users in the server, and the values specified above are the default
        values for normal system usage.
    
    The hard limit is used to enforce hard resource limits and the soft
    limit is to enforce soft resource limits. The hard limit is set by
    the super user and is enforced by the Kernel. You cannot increase
    the hard limit unless you have super user privileges. You can
    increase or decrease the soft limit as necessary, but the maximum
    limit you can increase this is up to the hard limit value that is
    set.

-   Configure the following settings in the
    `           /etc/security/limits.conf          ` file of Linux if
    you need to alter the maximum number of processes a system user is
    allowed to run at a given time. Each carbon server instance you run
    requires upto 1024 threads with the default thread pool
    configuration. Therefore, you need to increase both the hard and
    soft nproc value by 1024 per carbon server.

    ```
    * soft nproc 20000
    * hard nproc 20000
    ```

    !!! Info
        The \* character denotes that the limit is applicable to all system
        users in the server, and the values specified above are the default
        values for normal system usage.