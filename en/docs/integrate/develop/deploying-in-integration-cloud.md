# Deploying in WSO2 Integration Cloud

Once you have developed an integration solution, you can host it on the
Integration Cloud to make it available for multiple users. To understand
how to host a solution on Integration Cloud, follow the steps below:

## Before you begin

- [Register as a user of the Integration Cloud](https://wso2.com/integration/cloud/).
- [Download WSO2 Integration Studio](https://wso2.com/integration/tooling/).

## Step 1: Create an Application

1.  Create an integration application as follows:
    1.  Open **WSO2 Integration Studio**. In the **Getting Started** page,
        click the **Hello World Service** template to start creating a
        new application based on this template.  
        ![Cloud]({{base_path}}/assets/img/integrate/create_project/integration_cloud/1.hello_world_service.png)
    2.  In the **Create Project Using Hello World Service Template**
        dialog box, enter a name for the application. In this example,
        let's enter **HelloWorldApps** as the name.  
        ![Cloud]({{base_path}}/assets/img/integrate/create_project/integration_cloud/2.specify-application-name.png)  
    3.  Click **Finish** to add the project for the application.

2.  The project currently has the configurations derived from the
    template. Let's modify them as follows:

    !!! Info
        The purpose of this step is to change the default values. You can skip it if required.

    1.  In the left navigator, open the `HelloWorldApps/src/main/synapse-config/api/HelloWorld.xml` file. Then click on the **PayloadFactory** icon to open the **Payload Factory Mediator** configuration in the **Properties** tab.
        ![Cloud]({{base_path}}/assets/img/integrate/create_project/integration_cloud/3.open_properties.png)

    2.  In the **Payload** field, replace the existing value  with `{"data": "HelloWorld"}`.

## Step 2: Deploy in WSO2 Integration Cloud

1.  Before deploying the composite application, you need to know the key of the organization to which you are deploying. To get the
    organization ID, sign in to the Integration Cloud and access your organization as follows:

    !!! Info
        If you already know the key of the organization to which the application needs to be deployed, you can skip this step.
    
    1.  Sign in to the [Integration Cloud](https://wso2.com/integration/cloud/) with your credentials.
    2.  Click the following icon tray in the right end of the top
        bar.  
        ![Cloud]({{base_path}}/assets/img/integrate/create_project/integration_cloud/4.icon_tray.png)  
        Then click **Organizations** to open the **Manage
        Organizations** page.  
        ![Cloud]({{base_path}}/assets/img/integrate/create_project/integration_cloud/5.access_organization.png)  
        The keys of the available organizations are displayed as shown below.  
        ![Cloud]({{base_path}}/assets/img/integrate/create_project/integration_cloud/6.manage_organizations.png)

2.  Deploy the `Hello World Application` that you
    created as follows:
    1.  In WSO2 Integration Studio, open your workbench. Then
        right-click on **HelloWorldAppsCompositeApplication** , and then
        click **Deploy to Integration Cloud** . The **WSO2 Integration
        Cloud - Authentication** wizard opens as follows.    
        ![Cloud]({{base_path}}/assets/img/integrate/create_project/integration_cloud/7.wso2-integration-cloud-wizard.png)
    2.  Enter the following information in the wizard:  
        -   **Organization Key** : The key of the organization to which
            you want to deploy the application. The required
            organization key needs to be already registered under your
            Integration Cloud account.
        -   **Email** : The email address with which you are registered
            in the Integration Cloud.
        -   **Password** : The password with which you sign in to the
            Integration Cloud.
    3.  Click **Finish**. The **WSO2 Platform Distribution** wizard opens.
    4.  In the **WSO2 Platform Distribution** wizard, select the applications that you want to include in the CAR file that you
        are deploying to the Integration Cloud. For this example, select **HelloWorldApps** as shown below.  
        ![Cloud]({{base_path}}/assets/img/integrate/create_project/integration_cloud/8.select-helloworld-artifacts.png)
    5.  Click **Next**, and then click **Finish** . A message appears
        to inform you that your application is being deployed to the
        cloud. Once the deployment is complete, the following message
        appears.  
        ![Cloud]({{base_path}}/assets/img/integrate/create_project/integration_cloud/9.deployment-status.png)
3.  Access your organization on Integration Cloud as you did in step 1.
    The **HelloWorldAppsComposite Application** you deployed is
    displayed as follows.  
    ![Cloud]({{base_path}}/assets/img/integrate/create_project/integration_cloud/10.deployed-application.png)
4.  To create a new version, repeat step 2, sub steps a-c. Then follow
    the steps below to create a new version.
    1.  In the page where you select deployable artifacts, select
        **HelloWorldAppsConfigs** and click **Next**.
    2.  In the next page, select the **Create New Version** option
        and update the value displayed in the **Application Version**
        field.  
        ![Cloud]({{base_path}}/assets/img/integrate/create_project/integration_cloud/11.change-version.png)
    3.  Click **Finish** .
    4.  Sign in to the [Integration
        Cloud](https://integration.cloud.wso2.com/appmgt/site/pages/index.jag)
        and click on the **HelloWorldApps** application.  
        ![Cloud]({{base_path}}/assets/img/integrate/create_project/integration_cloud/12.open-application.png) 
        The application opens, and the updated version is displayed as
        shown below.  
        ![Cloud]({{base_path}}/assets/img/integrate/create_project/integration_cloud/13.updated-versions.png)