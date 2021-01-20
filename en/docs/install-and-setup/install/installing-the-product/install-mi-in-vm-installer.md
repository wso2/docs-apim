# Installing via the Installer

Follow the steps given below to install the WSO2 Micro Integrator runtime and its monitoring Dashboard.

## Download and install

You can refer to the following video to get a quick understanding of how this is done.

<iframe width="560" height="315" src="https://www.youtube.com/embed/6dkMwUBr4uk" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Go to the WSO2 Enterprise Integrator [product page](https://wso2.com/integration/#), click **Download**, and then click the **Installer**.

The **product installer** that is compatible with your operating system will be downloaded.

Double-click to open the installation wizard, which will guide you through the installation. When you finish, all the runtimes of WSO2 Enterprise Integrator will be installed and ready for use.

## Running the MI server

If you installed the product using the installer, use the following instructions to start and stop the MI server.

### Starting the MI server

You can refer to the following video to get a quick understanding of how this is done.

<iframe width="560" height="315" src="https://www.youtube.com/embed/Kc6PKzk54f8" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

On **MacOS/Linux/CentOS**, open a terminal and execute one of the commands given below.

-  To <b>start</b> the Micro Integrator as a <b>standalone application</b>:

      ```bash
      sudo wso2mi
      ```
   
-  To <b>start</b> the Micro Integrator as a <b>service</b>:
      
      ```bash tab='On MacOS'
      sudo wso2mi-service start
      ```

      ```bash tab='On Linux'
      sudo service wso2mi start
      ```

      ```bash tab='On Centos'
      sudo wso2mi start
      ```

On **Windows**

-  Go to **Start Menu -> WSO2 -> Enterprise Integrator 7.1.0 Micro Integrator**. This will open a terminal and start the Micro Integrator.

!!! Tip
    If you have **installed the product using the installer** and you want to manually run the product startup script from the `MI_HOME/bin` directory, you need to use the following command:

    ```bash
    sudo sh launcher_micro-integrator.sh
    ```

    This script automatically assigns the JAVA HOME of your VM to the root user of your Micro Integrator instance.

### Stopping the MI server

-  To <b>stop</b> the Micro Integrator standalone application, go to the terminal and press <i>Ctrl+C</i>.
-  To <b>stop</b> the Micro Integrator service:
      
      ```bash tab='On MacOS'
      sudo wso2mi-service stop
      ```

      ```bash tab='On Linux'
      sudo service wso2mi stop
      ```

      ```bash tab='On CentOS'
      sudo wso2mi stop
      ```

## Running the MI dashboard

If you installed the product using the installer, use the following instructions to start and stop the Micro Integrator dashboard.

### Starting the dashboard server

On **MacOS/Linux/CentOS**, open a terminal and execute one of the commands given below.

-  To <b>start</b> the dashboard as a <b>standalone application</b>:

      ```bash
      sudo wso2mi-dashboard
      ```
   
-  To <b>start</b> the dashboard as a <b>service</b>:
      
      ```bash tab='On MacOS'
      sudo wso2mi-dashboard-service start
      ```

      ```bash tab='On Linux'
      sudo service wso2mi-dashboard start
      ```
      
      ```bash tab='On CentOS'
      sudo wso2mi-dashboard start
      ```

On **Windows**

-  Go to **Start Menu -> WSO2 -> Enterprise Integrator 7.1.0 Micro Integrator Monitoring Dashboard**. This will open a terminal and start the dashboard.

### Accessing the dashboard

Once you have [started the dashboard server](#starting-the-dashboard-server), you can access the dashboard using the following URL:

```bash
https://localhost:9743/dashboard
```

!!! Warning

     - In a non-production environment (with the self-signed certificate), you have to add the certificate of the micro integrator instance to the browser as a trusted source. For example, direct the browser to `https://localhost:9164/management` and add the site as trusted. This step will not be required with a custom production certificate.
     - We have identified issues with the Microsoft Edge browser, which prompts trusting the management URL (with the self-signed certificate) in a loop. Please try trusting the management URL in the same tab if you face this issue. If the issue still persists, consider switching the browser.

See the [Micro Integrator Dashboard](../../../administer-and-observe/working-with-monitoring-dashboard) documentation for information on how to sign in and use the dashboard.

### Stopping the dashboard server

-  To <b>stop</b> the dashboard standalone application, go to the terminal and press <i>Ctrl+C</i>.
-  To <b>stop</b> the dashboard service:
      
      ```bash tab='On MacOS'
      sudo wso2mi-dashboard-service stop
      ```

      ```bash tab='On Linux'
      sudo service wso2mi-dashboard stop
      ```

      ```bash tab='On CentOS'
      sudo wso2mi-dashboard stop
      ```

## Accessing the HOME directory

### MI_HOME

**MI_HOME** is the installation location of the Micro Integrator runtime. When you use the **installer**, the `MI_HOME` is located in a place specific to your OS as shown below:

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
         <td><code>/Library/WSO2/wso2ei/7.1.0/micro-integrator</code></td>
      </tr>
      <tr class="even">
         <td>Windows</td>
         <td><code>C:\Program Files\WSO2\Enterprise Integrator\7.1.0\micro-integrator</code></td>
      </tr>
      <tr class="odd">
         <td>Linux</td>
         <td><code>/usr/lib/wso2/wso2ei/7.1.0/micro-integrator</code></td>
      </tr>
      <tr class="even">
         <td>CentOS</td>
         <td><code>/usr/lib64/wso2/wso2ei/7.1.0/micro-integrator</code></td>
      </tr>
   </tbody>
</table>

### DASHBOARD_HOME

**DASHBOARD_HOME** is the installation location of the Micro Integrator dashboard. When you use the **installer**, the `DASHBOARD_HOME` is located in a place specific to your OS as shown below:

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
         <td><code>/Library/WSO2/wso2ei/7.1.0/micro-integrator-dashboard</code></td>
      </tr>
      <tr class="even">
         <td>Windows</td>
         <td><code>C:\Program Files\WSO2\Enterprise Integrator\7.1.0\micro-integrator-dashboard</code></td>
      </tr>
      <tr class="odd">
         <td>Linux</td>
         <td><code>/usr/lib/wso2/wso2ei/7.1.0/micro-integrator-dashboard</code></td>
      </tr>
      <tr class="even">
         <td>CentOS</td>
         <td><code>/usr/lib64/wso2/wso2ei/7.1.0/micro-integrator-dashboard</code></td>
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
<td>Go to <strong>Start Menu -&gt; WSO2 -&gt; Uninstall Enterprise Integrator 7.1.0</strong> or search <strong>Uninstall Enterprise Integrator 7.1.0</strong> and click the shortcut icon. This will uninstall the product from your computer.</td>
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
