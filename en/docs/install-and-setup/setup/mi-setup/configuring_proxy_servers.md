# Working with Proxy Servers

When using WSO2 Micro Integrator, there can be scenarios where you need to configure the Micro Integrator to route
messages through a proxy server. For example, if the Micro Integrator is behind a
firewall, your proxy service might need to talk to a server through a
proxy server.

## Routing messages through a proxy server

See the instructions given below.

### For non-blocking service calls

To configure the Micro Integrator to route messages through a proxy server
(for non-blocking service calls), add the parameters given below to the deployment.toml file and update the
values. This configuration ensures that all HTTP requests pass through
the configured proxy server.

```toml
[transport.http]
sender.proxy_host= "<hostname/ip>"
sender.proxy_port= <port>
```

### For blocking service calls

To configure the Micro Integrator to route messages through a proxy server
(for blocking service calls), add the parameters given below to the deployment.toml file and update the
values. This configuration ensures that all HTTP requests pass through
the configured proxy server.

```toml
[transport.blocking.http]
sender.parameter.'http.proxyHost'= "<hostname/ip>"
sender.parameter.'http.proxyPort'= <port>
```

!!! Info
    **Bypass the proxy server for blocking calls?**  
    In the case of blocking service calls, you can apply a system property in the Micro Integrator to bypass the proxy server and route messages directly to the hosts that should receive the messages. Explained below are two methods of applying the system property:

    -  Set the system property in the product startup script that is located in the `MI_HOME/bin/          ` directory
    as shown below. Note that the list of host names are separated by the pipe symbol ('\|').
    ```xml
    -Dhttp.nonProxyHosts =10.|localhost|127.0.0.1|.\.domain.com \
    ```

    -  Pass the system property when you start the server as shown below.
    ```xml
    ./micro-integrator.sh -Dhttp.nonProxyHosts =10.|localhost|127.0.0.1|.\.domain.com
    ```
        
!!! Note
    A proxy server might require HTTP basic authentication before it handles communication from the Micro Integrator.


## Configuring proxy profiles in WSO2 Micro Integrator

When using the Micro Integrator, there can be scenarios where you need to configure multiple proxy servers to route messages to different
endpoints. When you need to route messages to different endpoints through multiple proxy servers, you can configure proxy profiles.

To configure proxy profiles in WSO2 Micro Integrator, open the deployment.toml file and define multiple profiles based on the number of proxy servers you need to have:

```toml
[[transport.http.proxy_profile]]
target_hosts = [""]
proxy_host = ""
proxy_port = ""
proxy_username = ""
proxy_password = ""
bypass_hosts = [""]
```

!!! Tip
    When you define a profile, it is mandatory to specify the `target_hosts`, `proxy_host` and `proxy_port` parameters for each profile. 

When you configure a proxy profile, following are details of the parameters that you need to define in a `<profile>` :

<table>
<thead>
<tr class="header">
<th>Parameter</th>
<th>Description</th>
<th>Required</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>             targetHosts            </code></td>
<td><p>A host name or a comma-separated list of host names for a target endpoint.<br />
Host names can be specified as regular expressions that match a pattern. When <code>              targetHosts             </code> is specified as an asterisks (*), it will match all the hosts in the profile</p></td>
<td>Yes</td>
</tr>
<tr class="even">
<td><code>             proxyHost            </code></td>
<td>The host name of the proxy server.</td>
<td>Yes</td>
</tr>
<tr class="odd">
<td><code>             proxyPort            </code></td>
<td>The port number of the proxy server.</td>
<td>Yes</td>
</tr>
<tr class="even">
<td><code>             proxyUserName            </code></td>
<td>The user name for the proxy server authentication.</td>
<td>No</td>
</tr>
<tr class="odd">
<td><code>             proxyPassword            </code></td>
<td>The password for the proxy server authentication.</td>
<td>No</td>
</tr>
<tr class="even">
<td><code>             bypass            </code></td>
<td><p>A host name or a comma-separated list of host names that should not be sent via the proxy server.</p>
<p>For example, if you want all requests to <code>              *.                             sample.com                           </code> to be sent via a proxy server, but need to directly send requests to <code>                             hello.sample.com                           </code> , instead of going through the proxy server, you can add <code>                             hello.sample.com                           </code> as a bypass host name.</p>
<p>You can specify host names as regular expressions that match a pattern.</p></td>
<td>No</td>
</tr>
</tbody>
</table>