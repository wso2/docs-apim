# Applying Security to a Proxy Service

The steps below demonstrate how you can apply security to a proxy service via WSO2 Integration Studio.

## Prerequisites

Be sure to [configure a user store]({{base_path}}/install-and-setup/setup/mi-setup/setup/user_stores/setting_up_a_userstore) for the Micro Integrator and add the required users and roles.

## Step 1: Creating the security policy file

Follow the instructions given below to create a **WS-Policy** resource in your registry project. This will be your security policy file.

1.  Once you have created a [registry resource project]({{base_path}}/integrate/develop/create-integration-project/#registry-resource-project), right-click the roject in the left navigation panel, click **New** , and then click **Registry Resource**. This will open the **New Registry Resource** window.  
    ![]({{base_path}}/assets/img/integrate/apply-security/119130870/119130887.png)
2.  Select the **From existing template** option as shown below and
    click **Next** .  
    ![]({{base_path}}/assets/img/integrate/apply-security/119130870/119130886.png)
3.  Enter a resource name and select the **WS-Policy** template along
    with the preferred registry path.  
    ![]({{base_path}}/assets/img/integrate/apply-security/119130870/119130885.png)
    ![]({{base_path}}/assets/img/integrate/apply-security/119130870/119130884.png)
4.  Click **Finish** . The policy file is now listed in the project
    explorer as shown below  
    ![]({{base_path}}/assets/img/integrate/apply-security/119130870/119130883.png)
      
5.  Double-click the policy file to open the file. Note that you get a
    **Design View** and **Source View** of the policy.

6.  Let's use the **Design View** to enable the required security scenario. For example, enable the **Sign and Encyrpt** security scenario as shown below.

    !!! Tip
        Click the icon next to the scenario to get details of the scenario.
    
    ![]({{base_path}}/assets/img/integrate/apply-security/119130870/119130882.png)

7.  You can provide also provide encryption properties, signature properties, and advanced rampart configurations as shown below.

    **Encryption/Signature Properties**

    ![]({{base_path}}/assets/img/integrate/apply-security/119130870/119130890.png)

    **Rampart Properties**

    ![]({{base_path}}/assets/img/integrate/apply-security/119130870/119130889.png)
    
    !!! Info 
        Change the tokenStoreClass in the policy file to 'org.wso2.micro.integrator.security.extensions.SecurityTokenStore'
        
        Also replace ServerCrypto class with 'org.wso2.micro.integrator.security.util.ServerCrypto' if present.
        
<!--
#### Specifying role-based access?

For certain scenarios, you can specify user roles. After you select the
scenario, scroll to the right to see the **User Roles** button.

![]({{base_path}}/assets/img/integrate/apply-security/119130870/119130874.png)

Either define the user roles inline or retrieve the user roles from the server.

-   **Define Inline**
    ![]({{base_path}}/assets/img/integrate/apply-security/119130870/119130872.png)

-   **Get from the server**
    ![]({{base_path}}/assets/img/integrate/apply-security/119130870/119130871.png)

!!! Info
    By default, the role names are not case sensitive. If you want to make them case sensitive, add the following property in the `<MI_HOME>/conf/deployment.yaml` file.        
     ```toml
     [authorization_manager]
     properties.CaseSensitiveAuthorizationRules = "true"
     ```
-->

## Step 2: Add the security policy to the proxy service

Follow the steps given below.

1.  You can either [create a new proxy service]({{base_path}}/integrate/develop/creating-artifacts/creating-a-proxy-service), or [import an existing proxy service]({{base_path}}/integrate/develop/importing-artifacts) to your workspace.
2.  Double-click the proxy service on the project explorer to open the
    file and click on the service on design view.
3.  In the **Properties** tab shown below and tick on **Security
    Enabled** property.  

    ![]({{base_path}}/assets/img/integrate/apply-security/119130870/119130879.png)

4.  Select the **Browse** icon for the **Service Policies** field. In
    the dialog box that opens, create a new record and click the
    **Browse** icon to open the **Resource Key** dialog as shown
    below.  

    ![]({{base_path}}/assets/img/integrate/apply-security/119130870/119130877.png)

5.  Click **workspace**, to add the security policy from the current
    workspace. You can select the path to the
    `sample_policy.xml` file that you created in the
    previous steps.  

    ![]({{base_path}}/assets/img/integrate/apply-security/119130870/119130876.png)

6.  Save the proxy service file.

## Step 3: Package the artifacts

See the instructions on [packaging the artifacts]({{base_path}}/integrate/develop/packaging-artifacts) into a composite application project.

## Step 4: Build and run the artifacts

See the instructions [deploying the artifacts]({{base_path}}/integrate/develop/deploy-and-run).

## Step 5: Testing the service

Create a Soap UI project with the relevant security settings and then send the request to the hosted service.

### General guidelines on testing with SOAP UI

1.  Create a “SOAP Project” in SOAP UI using the WSDL URL of the proxy service (eg: http://localhost:8280/services/SampleProxy?wsdl)

    <img src="{{base_path}}/assets/img/integrate/apply-security/soapui/create-soapui-project.png" width="600">

2.  Double click on the created SOAP project, click on “WS-Security-Configuration” -> “Keystores”, and add the WSO2 keystore.

    <img src="{{base_path}}/assets/img/integrate/apply-security/soapui/create-keystore.png" width="600">
    
3.  We need to enter keystore password for the keystore configuration. 
4.  Click on “Outgoing WS-Security Configuration”, and add a new policy by specifying a name. (Name can be anything).

    <img src="{{base_path}}/assets/img/integrate/apply-security/soapui/create-outgoing-wss-configuration.png" width="600">
    
5.  Add required WSS entries for the created configuration (What you need add will vary according to the policy you are using). Explanation about adding three main sections is given below.

    - Adding **Signature**  
    
    <img src="{{base_path}}/assets/img/integrate/apply-security/soapui/adding-signature-entry.png" width="600">
    
    - Adding **Timestamp**
    
    <img src="{{base_path}}/assets/img/integrate/apply-security/soapui/adding-timestamp-entry.png" width="600">
    
    - Adding **Encryption**
    
    <img src="{{base_path}}/assets/img/integrate/apply-security/soapui/adding-encryption-entry.png" width="600">
    
    !!! Info
        Note: Please note that the order of the WS entries matters. So always add the above one after the other (If you are adding only two sections, you need to maintain the order).
        
6.  Once we are done with WS security configurations, we have to specify the created WS-policy under “Outgoing WSS” at the request “Authorization”.

    <img src="{{base_path}}/assets/img/integrate/apply-security/soapui/invoking-with-out-policy.png" width="700">
   
7.  Now you can invoke the Proxy Service. 

!!! Info

    When defining Outgoing WS-Security Configuration, you need to pick on the WS entries based on your WS policy.
    
    Eg:
    
    - Non Repudiation policy needs only Timestamp and Signature. Confidentiality needs all three : Timestamp, Signature and Encryption.
    - For UsernameToken policy, you do not need to provide a Outgoing WS-Security Configuration. Providing the basic auth configuration is enough.
    
        <img src="{{base_path}}/assets/img/integrate/apply-security/soapui/invoking-username-token.png" width="700">