# Production Deployment Checklist

Given below is a checklist that will guide you to set up your production environment for WSO2 API-M.

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
                     <p><a href="{{base_path}}/install-and-setup/setup/deployment-best-practices/security-guidelines-for-production-deployment">Security Guidelines for a Production Deployment</a></p>
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
                     <p><a href="{{base_path}}/install-and-setup/setup/deployment-best-practices/changing-the-hostname">Changing the hostname</a></p>
                  </div>
               </div>
            </div>
         </td>
      </tr>
      <tr class="odd">
         <td>Registry and governance</td>
         <td>
            <div class="content-wrapper">
               <p>The API-M runtime uses a database registry for persistent storage of configurations. It is recommended to  switch to a database like Oracle, MySQL, or MSSQL.</p>
               <p>Note that the default setup does not include database backup procedures. The production setup should obviously need to have regular database backup procedures configured.</p>
               <ul>
                  <li>
                     <a href="{{base_path}}/install-and-setup/setup/setting-up-databases/overview">Database registry</a> for the API-M runtime.
                  </li>
               </ul>
               <p>The Micro Integrator runtime uses a file-based registry instead of a database.</p>
               <ul>
                  <li>
                     <a href="{{base_path}}/install-and-setup/setup/mi-setup/deployment/file_based_registry">File-based registry</a> for the Micro Integrator. runtime.
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
                     Performance Tuning - WSO2 API-M runtime
                  </li>
                  <li>
                     Performance tuning - WSO2 Micro Integrator
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
               <b>API-M Ports</b>
               <ul>
                  <li>9443 - Used by the management console and services that use the servlet transport.</li>
                  <li>9763 - Used by the services that use servlet transport.</li>
                  <li>9999 - Used for JMX monitoring.</li>
                  <li>8280 - Default HTTP port used by ESB for proxy services.</li>
                  <li>8243 - Default HTTPS port used by ESB for proxy services.</li>
               </ul>
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
            If the runtime is hosted behind a proxy such as ApacheHTTPD, you can configure the runtime  to use the proxy server. See the following topics for instructions:
            <ul>
               <li>Configuring a <a href="{{base_path}}/install-and-setup/setup/setting-up-proxy-server-and-the-load-balancer/configuring-the-proxy-server-and-the-load-balancer">proxy server for the API-M runtime</a>.</li>
               <li>Configuring a <a href="{{base_path}}/install-and-setup/setup/mi-setup/configuring_proxy_servers">proxy server for the Micro Integrator runtime</a>.</li>
            </ul>
         </td>
      </tr>
      <tr class="odd">
         <td>High availability</td>
         <td>
            <p>Configure your deployment with high availability. Refer the <a href="{{base_path}}/install-and-setup/setup/deployment-overview">recommended deployment patterns</a> and select an option that fits your requirements.</p>
            <p>In the cloud native deployment, high availability should be achieved via the container orchestration system (Kubernetes).</p>
         </td>
      </tr>
      <tr class="even">
         <td>Data backup and archiving</td>
         <td>Implement a <a href="{{base_path}}/install-and-setup/setup/deployment-best-practices/backup-recovery">backup and recovery strategy</a> for your system.</td>
      </tr>
   </tbody>
</table>
