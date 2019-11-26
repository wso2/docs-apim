# Grouping APIs with Microgateway Labels

If required, you can create a [WSO2 API Microgateway](https://wso2.com/api-management/api-microgateway/) distribution for a group of APIs. Therefore, if you need to group APIs, you need to create a label and attach the label to the specific APIs that need to be apart of the group.

<html>
<div class="admonition note">
<p class="admonition-title">Note</p>
<p>For more information on WSO2 API Microgateway, see <a href="https://docs.wso2.com/display/MG300/API+Microgateway+Documentation">API Microgateway Documentation</a>.</p>
</div> 
</html>

## Step 1 - Create a Microgateway label

1.  Sign in to the Admin Portal.
     
     `https://<hostname>:9443/admin` 
   
     Example: `https://localhost:9443/admin`

     Let's use `admin` as your username and password to sign in.

2.  Add a new Microgateway label.

     Click **LABELS** under **MICROGATEWAY**, and then click **ADD MICROGATEWAY**.

     [![Menu to add Microgateway label]({{base_path}}/assets/img/Learn/add-microgateway-label-menu.png)]({{base_path}}/assets/img/Learn/add-microgateway-label-menu.png)

3.  Create a new label, add a host, and click **Save.**

     <table>
     <tr>
     <td>Label
     </td>
      <td>
     MARKETING_STORE
     </td>
     </tr>
     <tr>
     <td>Host
     </td>
     <td><code>https://localhost:9095</code>
     </td>
     </tr>
     </table>

     [![Add a Microgateway label]({{base_path}}/assets/img/Learn/add-microgateway-label.png)]({{base_path}}/assets/img/Learn/add-microgateway-label.png)

## Step 2 - Assign the Microgateway label to an API

<html>
<div class="admonition note">
<p class="admonition-title">Note</p>
<p>Repeat this step multiple times if you wish to add multiple APIs to the API group.</p>
</div> 
</html>

1.  Sign in to the API Publisher using `admin` as the username and password.

     `https://<hostname>:9443/publisher` 
   
     Example: `https://localhost:9443/publisher`

2.  Create a new API or skip this step if you wish to use an existing API.
     Let's deploy the sample Pizzashack API by clicking **Deploy Sample API** (If you have not done so already).

3.  Click on the API to edit its configurations.

    ![Edit the API]({{base_path}}/assets/img/Learn/select-api.png)

4.  Click **Environments**.

5.  Select the newly created Microgateway label.

    [![Microgateway label in the Publisher]({{base_path}}/assets/img/Learn/Microgateway-label-publisher.png)]({{base_path}}/assets/img/Learn/Microgateway-label-publisher.png)

6.  Click **Save** to attach it to the Pizzashack API.

7. Similarly, you can assign the `MARKETING_STORE` Microgateway label for other APIs as well.

## Step 3 - View the Microgateway labels

1.  Sign in to the Developer Portal using `admin` as the username and password.

     `https://<hostname>:9443/devportal` 
   
     Example: `https://localhost:9443/devportal`

2.  The attached Microgateways appear in the **Overview** tab of the API.

    [![Microgateway label in the Developer Portal]({{base_path}}/assets/img/Learn/Microgateway-label-devportal.png)]({{base_path}}/assets/img/Learn/Microgateway-label-devportal.png)


