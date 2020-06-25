#Response caching

The API Manager uses [WSO2 ESB's cache mediator](https://docs.wso2.com/display/EI650/Cache+Mediator) to cache response messages for each API. Caching improves performance, because the backend server does not have to process the same data for a request multiple times. You need to set an appropriate timeout period to offset the risk of stale data in the cache.

##Enabling Response Caching for an API

You need to enable response caching when creating a new API or editing an existing API using the API Publisher.

Please follow below steps to enable response caching for an API.

1.  [Create an API]({{base_path}}/learn/design-api/create-api/create-a-rest-api/).

2.  Navigate to the **Runtime Configurations** tab where you find the response caching configuration. Then turn on Response caching and give a timeout value. This enables the default response caching settings.

    ![]({{base_path}}/assets/img/learn/enable-response-caching.png)

    
    !!! note
        When creating a new API by using a Swagger or Open API definition, response caching can be set up by defining an API-M supported Open API extension **“x-wso2-response-cache”**.

        !!! example
            ```yaml
             x-wso2-response-cache: 
                enabled: true
                cacheTimeoutInSeconds: 400
            ```
            
3.  If you want to change the default response caching settings, edit the following cache mediator properties in the `<API-M_HOME>/repository/resources/api_templates/velocity_template.xml` file:

    <table>
    <colgroup>
    <col width="30%" />
    <col width="70%" />
    </colgroup>
    <thead>
    <tr class="header">
    <th>Property</th>
    <th>Description</th>
    </tr>
    </thead>
    <tbody>
    <tr class="odd">
    <td><code>             collector            </code></td>
    <td><ul>
    <li><code>               true              </code> : specifies that the mediator instance is a response collection instance.</li>
    <li><code>               false              </code> : specifies that the mediator instance is a cache serving instance.<br />
    </li>
    </ul></td>
    </tr>
    <tr class="even">
    <td><p><code>              max MessageSize             </code></p></td>
    <td>Specifies the maximum size of a message to be cached in bytes. An optional attribute, with the default value set to <code>             unlimited            </code> .</td>
    </tr>
    <tr class="odd">
    <td><code>             maxSize            </code></td>
    <td>Defines the maximum number of elements to be cached.</td>
    </tr>
    <tr class="even">
    <td><p><code>              hashGenerator             </code></p></td>
    <td><p>Defines the hash generator class.</p>
    <p>When caching response messages, a hash value is generated based on the request's URI, transport headers and the payload (if available). WSO2 has a default <code>              REQUESTHASHGenerator             </code> class written to generate the hash value. See sample <a href="attachments/103333424/103333429.java">here</a> .</p>
    <p>If you want to change this default implementation (for example, to exclude certain headers), you can write a new hash generator implementation by extending the <code>              REQUESTHASHGenerator             </code> and overriding its <code>              getDigest()             </code> method. Once done, add the new class as the <code>              hashGenerator             </code> attribute of the <code>              &lt;cache&gt;             </code> element in the <code>              velocity_template.xml             </code> file.</p></td>
    </tr>
    </tbody>
    </table>

!!! note
    When running a distributed deployment, you need to enable the JSON stream builders on the API Gateway and maintain the standard builders on the API Dev portal node.

Follow the instructions below to enable the stream builders in the API gateway:

1.  Open the `<API-M_HOME>/repository/conf/deployment.toml` file.
2.  Add following configuration.

    ``` java
        [message_builder]
        json = "org.apache.synapse.commons.json.JsonStreamBuilder"
    ```

## Invalidating Cached Responses Remotely

You can invalidate all cached response remotely by using any [JMX monitoring tool such as Jconsole](https://ei.docs.wso2.com/en/latest/micro-integrator/administer-and-observe/jmx_monitoring) using the exposed MBeans. You can use the `InvalidateMediatorCache()` operation of the `org.wso2.carbon.mediation` MBean for this as shown below.

![JMX monitoring through JConsole]({{base_path}}/assets/img/learn/jmx-monitoring-through-jsoncole.png)

