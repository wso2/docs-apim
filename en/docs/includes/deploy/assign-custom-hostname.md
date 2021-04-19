
<html>
<div class="admonition note">
<p class="admonition-title">Note</p>
<p>Repeat this step if you wish to add multiple APIs to the API group.</p>
</div> 
</html>

1.  Sign in to the API Publisher using `admin` as the username and password.

     `https://<hostname>:9443/publisher` 
   
     Example: `https://localhost:9443/publisher`

2.  Create a new API or skip this step if you wish to use an existing API.
     
     Let's deploy the sample Pizzashack API by clicking **Deploy Sample API** (If you have not done so already).

3.  Click on the API to edit its configurations.

     [![Edit the API](/../../../../assets/img/includes/deploy/select-api.png)](/../../../../assets/img/includes/deploy/select-api.png)

4.  Click **Deployments**.

5.  Select the newly created Gateway environment, Virtual Host (foods.com), and a Revision.

     [Create a new revision](/../../../../design/create-api/create-api-revisions) if no revisions exist.

6. Click **Deploy** to attach the Virtual Host to the Pizzashack API.
   
    !!! info
        Similarly, you can assign the same Virtual Host to other APIs as well.
