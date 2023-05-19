# Production Deployment Checklist

Given below is a checklist that will guide you to set up your production environment for WSO2 Micro Integrator.

<table>
   <thead>
      <tr class="header">
         <th>Guideline</th>
         <th>Details</th>
      </tr>
   </thead>
   <tbody>
      <tr class="odd">
         <td>Security hardening</td>
         <td>
            <div class="content-wrapper">
               <p>Guidelines for hardening the security of a WSO2 deployment in a production environment can be discussed under three high-level categories:</p>
               <ul>
                  <li>Product-level security</li>
                  <li>OS-level security</li>
                  <li>Network-level security<br />
                     <br />
                  </li>
               </ul>
               <div class="panel" style="border-width: 1px;">
                  <div class="panelHeader" style="border-bottom-width: 1px;">
                     <strong>Related links</strong>
                  </div>
                  <div class="panelContent">
                     <p><a href="{{base_path}}/install-and-setup/setup/deployment-best-practices/security-guidelines-for-production-deployment-mi">Security Guidelines for a Production Deployment</a></p>
                  </div>
               </div>
            </div>
         </td>
      </tr>
      <tr class="even">
         <td>Hostname</td>
         <td>
            <div class="content-wrapper">
               By default, WSO2 products identify the hostname of the current machine through the Java API. However, it is recommended to configure the hostname by setting the <code>hostname</code> parameter in the <code>deployment.toml</code> file.
               <div class="code panel pdl" style="border-width: 1px;">
                  <div class="codeContent panelContent pdl">
                     <div class="sourceCode" id="cb1" data-syntaxhighlighter-params="brush: xml; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: xml; gutter: false; theme: Confluence">
                        <pre class="sourceCode xml"><code class="sourceCode xml"><span id="cb1-1"><a href="#cb1-1"></a><span class="kw">[server]</br>hostname="localhost"</span></span></code></pre>
                     </div>
                  </div>
               </div>
               <div class="panel" style="border-width: 1px;">
                  <div class="panelHeader" style="border-bottom-width: 1px;">
                     <strong>Related links</strong>
                  </div>
                  <div class="panelContent">
                     <p><a href="{{base_path}}/install-and-setup/setup/deployment-best-practices/changing-the-hostname-mi">Changing the hostname</a></p>
                  </div>
               </div>
            </div>
         </td>
      </tr>
      <tr class="odd">
         <td>Registry and governance</td>
         <td>
            <div class="content-wrapper">
               <p>The Micro Integrator runtime uses a file-based registry instead of a database.</p>
               <ul>
                  <li>
                     <a href="{{base_path}}/install-and-setup/setup/mi-setup/deployment/file_based_registry">File-based registry</a> for the Micro Integrator runtime.
                  </li>
               </ul>
            </div>
         </td>
      </tr>
      <tr class="even">
         <td>Performance Tuning</td>
         <td>
            <div class="content-wrapper">
               <p>Most of the performance tuning recommendations are common to all WSO2 products. However, each WSO2 product may have additional guidelines for optimizing the performance of product-specific features.</p>
               <ul>
                  <li>
                     Performance tuning - WSO2 Micro Integrator
                           <ul><li> <a href="{{base_path}}/install-and-setup/setup/mi-setup/performance_tuning/tuning_jvm_performance" alt="Tuning JVM Performance">Tuning JVM Performance</a></li>
                           <li><a href="{{base_path}}/install-and-setup/setup/mi-setup/performance_tuning/network_os_performance">Tuning Network and OS Performance</a></li>
                           <li><a href="{{base_path}}/install-and-setup/setup/mi-setup/performance_tuning/jdbc_tuning"> Tuning JDBC Configurations</a></li>
                           <li><a href="{{base_path}}/install-and-setup/setup/mi-setup/performance_tuning/http_transport_tuning">  Tuning the HTTP Transport</a></li>
                           <li><a href="{{base_path}}/install-and-setup/setup/mi-setup/performance_tuning/jms_transport_tuning"> Tuning the JMS Transport</a></li>
                           <li><a href="{{base_path}}/install-and-setup/setup/mi-setup/performance_tuning/tuning-the-vfs-transport"> Tuning the VFS Transport</a></li>
                           <li><a href="{{base_path}}/install-and-setup/setup/mi-setup/performance_tuning/rabbitmq_transport_tuning"> Tuning the RabbitMQ Transport</a></li>
                           <li><a href="{{base_path}}/install-and-setup/setup/mi-setup/performance_tuning/tuning-inbound-endpoints"> Tuning the Inbound Endpoints</a></li>
                     </ul>
                  </li>
               </ul>
            </div>
         </td>
      </tr>
      <tr class="odd">
         <td>Firewalls</td>
         <td>
            <div class="content-wrapper">
               <p>The following ports must be accessed when operating within a firewall:</p>
               <b>Micro Integrator Ports</b>
               <ul>
                  <li>8290 - Default HTTP port used by the Micro Integrator for proxy services and APIs.</li>
                  <li>8253 - Default HTTPS port used by the Micro Integrator for proxy services and APIs.</li>
                  <li>9164 - Default HTTPS port used by the Micro Integrator Management APIs.</li>
               </ul>
            </div>
         </td>
      </tr>
      <tr class="even">
         <td>Proxy servers</td>
         <td>
            If the runtime is hosted behind a proxy such as ApacheHTTPD, you can configure the runtime  to use the proxy server. For instructions, see configuring a <a href="{{base_path}}/install-and-setup/setup/mi-setup/configuring_proxy_servers">proxy server for the Micro Integrator runtime</a>.
         </td>
      </tr>
      <tr class="odd">
         <td>High availability</td>
         <td>
            <p>Configure your deployment with high availability.</p>
            <p>In the cloud native deployment, high availability should be achieved via the container orchestration system (Kubernetes).</p>
         </td>
      </tr>
      <tr class="even">
         <td>Data backup and archiving</td>
         <td>Implement a <a href="{{base_path}}/install-and-setup/setup/deployment-best-practices/backup-recovery">backup and recovery strategy</a> for your system.</td>
      </tr>
   </tbody>
</table>
