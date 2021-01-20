# Installing via the Installer

Follow the steps given below to install the WSO2 Streaming Integrator runtime.

## System requirements

| Type   | Requirement                                                                                     |
|--------|-------------------------------------------------------------------------------------------------|
| CPU    | You require a minimum of one CPU with 2 cores. It is recommended to have a CPU with 4 cores.    |
| Memory | ~ 4 GB minimum is recommended</br> </br>  ~ 2 GB heap size                                      |
| Disk   | ~ 1 GB minimum (excluding space allocated for log files and databases.)                         |

## Download and install

Go to the WSO2 Enterprise Integrator [product page](https://wso2.com/integration/#), click **Download**, and then click the **Installer**.

The **product installer** that is compatible with your operating system is downloaded.

Double-click to open the installation wizard that guides you through the installation. Once you finish, all the runtimes of WSO2 Enterprise Integrator are installed and ready for use.

## Running the SI server

If you installed the product using the installer, use the following instructions to start and stop the SI server.

### Starting the SI server

On **MacOS/Linux/CentOS**, open a terminal and execute one of the commands given below.

-  To <b>start</b> the Streaming Integrator as a <b>standalone application</b>:

      ```bash
      sudo wso2si
      ```
   
-  To <b>start</b> the Streaming Integrator as a <b>service</b>:
      
      ```bash tab='On MacOS'
      sudo wso2si-service start
      ```

      ```bash tab='On Linux'
      sudo service wso2si start
      ```

      ```bash tab='On Centos'
      sudo wso2si start
      ```

On **Windows**

-  Go to **Start Menu -> WSO2 -> Enterprise Integrator 7.1.0 Streaming Integrator**. This opens a terminal and starts the Streaming Integrator.

!!! Tip
    If you have **installed the product using the installer** and you want to manually run the product startup script from the `<SI_HOME>/bin` directory, you need to use the following command:<br/><br/>
    ```bash
    sudo sh launcher_streaming-integrator.sh
    ```<br/><br/>
    This script automatically assigns the JAVA HOME of your VM to the root user of your Streaming Integrator instance.
    
### Stopping the SI server

-  To <b>stop</b> the Streaming Integrator standalone application, go to the terminal and press <i>Ctrl+C</i>.

-  To <b>stop</b> the Streaming Integrator service:
      
      ```bash tab='On MacOS'
      sudo wso2si-service stop
      ```

      ```bash tab='On Linux'
      sudo service wso2si stop
      ```

      ```bash tab='On CentOS'
      sudo wso2si stop

## Accessing the HOME directory

Let's call the installation location of your product the **`<SI_HOME>`** directory.

If you used the **installer** to install the product, this is located in a place specific to your OS as shown below:

<table style="width:100%;">
   <colgroup>
      <col style="width: 9%" />
      <col style="width: 90%" />
   </colgroup>
   <thead>
      <tr class="header">
         <th>OS</th>
         <th>Home directory</th>
      </tr>
   </thead>
   <tbody>
      <tr class="odd">
         <td>Mac OS</td>
         <td><code>/Library/WSO2/EnterpriseIntegrator/7.1.0/streaming-integrator</code></td>
      </tr>
      <tr class="even">
         <td>Windows</td>
         <td><code>C:\Program Files\WSO2\Enterprise Integrator\7.1.0\streaming-integrator</code></td>
      </tr>
      <tr class="odd">
         <td>Ubuntu</td>
         <td><code>/usr/lib/wso2/wso2ei/7.1.0/streaming-integrator</code></td>
      </tr>
      <tr class="even">
         <td>CentOS</td>
         <td><code>/usr/lib64/wso2/wso2ei/7.1.0/streaming-integrator</code></td>
      </tr>
   </tbody>
</table>

## Uninstalling the product

If you used the **installer** to install WSO2 Enterprise Integrator, you can uninstall by following the steps given below:

<table>
<thead>
<tr class="header">
<th>OS</th>
<th>Instructions</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>Mac OS</td>
<td><div class="content-wrapper">
<p>Open a terminal and run the following command as the root user:</p>
  <code>sudo bash /Library/WSO2/wso2ei/7.1.0/uninstall.sh</code>
</div>
</div>
</div></td>
</tr>
<tr class="even">
<td>Windows</td>
<td>Go to <strong>Start Menu -&gt; WSO2 -&gt; Uninstall Enterprise Integrator 7.1.0</strong> or search <strong>Uninstall Enterprise Integrator 7.1.0</strong> and click the shortcut icon. This uninstalls the product from your computer.</td>
</tr>
<tr class="odd">
<td>Linux</td>
<td><div class="content-wrapper">
<p>Open a terminal and run the following command:</p>
<code>sudo dpkg --purge wso2ei-7.1.0</code>
</div>
</div>
</div></td>
</tr>
<tr class="even">
<td>CentOS</td>
<td><div class="content-wrapper">
<p>Open a terminal and run the following command:</p>
<code>sudo rpm -e wso2ei-7.1.0-1.el7.x86_64</code>
</div>
</div>
</div></td>
</tr>
</tbody>
</table>

!!! tip "What's Next?"
    Once you have successfully downloaded and installed WSO2 Streaming Integrator, you can proceed to do any of the following:<br/><br/>
    - If you were previously using WSO2 Stream Processor and want to migrate to WSO2 Streaming Integrator, follow the instructions in [Migrating from WSO2 Stream Processor]({{base_path}}/install-and-setup/upgrading-wso2-si/migrating-from-stream-processor).<br/><br/>
    - To deploy WSO2 Streaming Integrator as a single-node deployment or a cluster (based on your requirements), see [Deploying Streaming Integrator]({{base_path}}/install-and-setup/setup/si-deployment/deployment-guide).<br/><br/>
    - To set up WSO2 Streaming Integrator and make it ready to run in a production environment, see the [Production Checklist]({{base_path}}/install-and-setup/setup/si-setup/production-checklist).<br/><br/>
    