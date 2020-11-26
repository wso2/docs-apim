# Installing via the Installer

The following sections explain as to how to to use the WSO2 API Manager installer.


## Download and install the product

If the [installation prerequisites]({{base_path}}/install-and-setup/installation-guide/installation-prerequisites) are satisfied, follow the steps below:

1.  Go to the WSO2 API Manager [product page](https://wso2.com/api-management/) and download the WSO2 API Manager Installer.

    <div class="admonition note">
     <p class="admonition-title">Note</p>
     <p>
     Note that there are several options available to install the product on various environments. Use the available links for more information on each option.</p>
     </div> 

2.  Double-click to open the installation wizard (`.pkg` file), which will guide you through the installation. When you finish, the product will be installed and ready for use. 

## Access the HOME directory

Let's call the installation location of your product the **`<API-M_HOME>`** directory.

If you installed the product using the **installer**, this directory is located in a place specific to your OS as shown below:

<html>
<table>
<tr>
<th>

<b>OS</b>
</th>
<th>

<b>Home Directory</b>
</th>
</tr>
<tr><td>
Mac OS </td><td> <code> /Library/WSO2/APIManager/3.2.0 </code> </tr>
<tr><td> Windows </td><td> <code> C:\Program Files\WSO2\APIManager\3.2.0\ </code> </tr>
<tr><td>Ubuntu </td><td> <code> /usr/lib/wso2/APIManager/3.2.0 </code> </tr>
<tr><td> CentOS </td><td> <code> /usr/lib64/APIManager/3.2.0 </code></tr>
</table>
</html>

## Uninstall the product

If you installed the product using the **installer**, you can uninstall it by following the instructions below:

<html>
<table>
<tr>
<th>
<b>
OS
</b>
</th>
<th>
Instructions
</th>
</tr>

<tr> <td>Mac OS </td><td>

Open a terminal and run the following command as the root user:

<code>
sudo bash /Library/WSO2/APIManager/3.2.0/uninstall.sh
</code>
</td>
</tr>
<tr>
<td> Windows </td><td> Go to the  <b>Start Menu -> Programs -> WSO2 -> Uninstall API Manager 3.2.0</b>  or search  <b>Uninstall API Manager 3.2.0</b>  and click the shortcut icon. This will uninstall the product from your computer. </td>
</tr>
<tr>
<td> Ubuntu </td><td>

Open a terminal and run the following command:


<code>sudo apt-get purge wso2am-3.2.0
</code>
</td>
 </tr>
 <tr>
<td> CentOS </td><td>

Open a terminal and run the following command:

<code>sudo yum remove wso2am-3.2.0-x86_64
</code>
</td>
 <tr>
 </table>
</html>

## What's next?

-   See the instructions for [running the product]({{base_path}}/install-and-setup/installation-guide/running-the-product/).

