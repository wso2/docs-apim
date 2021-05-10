# Sharing Applications

WSO2 API Manager provides the facility for users to share their applications and subscriptions with a specific logical group or groups such as an organization. As a result of application sharing, users in the group can view such shared applications.

WSO2 API Manager considers the organization name you enter when signing up to the API Store as the group ID. All the users specifying the same organization name belong to the same group. Therefore, such users that belong to a single group can view each others' subscriptions and applications provided that you have [enabled group sharing](#enabling-application-sharing).

Only the application owner is capable of editing and deleting the application in the shared group.

!!! Note
    If there is a requirement to edit or delete an application using a different user (for example, due to a reason such as where the application owner has already left the organization etc.), you can achieve this by [transferring the ownership of the application to that user who will be the new application owner]({{base_path}}/consume/manage-application/advanced-topics/changing-the-owner-of-an-application/).

WSO2 API Manager also provides the flexibility to change this default authentication implementation.

## Enabling application sharing

You can enable application sharing with users in a single group or between users in multiple groups by following the steps below.

1.  Shutdown the server if it is running.

2.  The following configuration changes must be done in the `<API-M_HOME>/repository/conf/deployment.toml` file according to the application sharing type required.

    **Default**

    ``` java
    [apim.devportal]
    enable_application_sharing = true
    application_sharing_type = "default"
            
    ```

    **SAML**

    ``` java
    [apim.devportal]
    enable_application_sharing = true
    application_sharing_type = "saml"
            
    ```

    **Custom**

    ``` java
    [apim.devportal]
    enable_application_sharing = true
    #application_sharing_type = "default"
    application_sharing_impl = "org.custom.group.extension.DefaultGroupIDExtractorImpl"
            
    ```

3.  Restart the server.

## Sharing an application with multiple users

Group IDs are extracted using a `GroupingExtractor` class, which is an implementation of `NewPostLoginExecutor` interface. The default implementation is done through the [DefaultGroupIDExtractorImpl](https://github.com/wso2/carbon-apimgt/blob/master/components/apimgt/org.wso2.carbon.apimgt.impl/src/main/java/org/wso2/carbon/apimgt/impl/DefaultGroupIDExtractorImpl.java) class. The organization claim is extracted using the group ID. If a particular user is in more than one organization, provide the organizations as a string separated by commas.

Share an application with multiple users who are in the same group or who are in multiple groups as follows:

1.  Start WSO2 API Manager, navigate to the WSO2 Developer Portal, and click **Sign-in**.

     `https://<hostname>:9443/devportal`

     [![Sign in to Developer Portal]({{base_path}}/assets/img/learn/application-sharing-signin.png)]({{base_path}}/assets/img/learn/application-sharing-signin.png)

2. Click **Create Account**.
      
     [![Create Account in Developer Portal]({{base_path}}/assets/img/learn/application-sharing-signup.png)]({{base_path}}/assets/img/learn/application-sharing-signup.png)

3.  Sign up to the API Developer Portal as two different users (e.g., user1, user2) belonging to the same organization.
    - Provide the username and proceed click **PROCEED TO SELF REGISTER** to Self Register.
    
    [![Application Sharing Username]({{base_path}}/assets/img/learn/application-sharing-username.png)]({{base_path}}/assets/img/learn/application-sharing-username.png)

    - Provide the user details and click **REGISTER**.
     
    [![Application Sharing Signup Form]({{base_path}}/assets/img/learn/application-sharing-signup-form.png)]({{base_path}}/assets/img/learn/application-sharing-signup-form.png)
        
4.  Sign in as **user1** and add application **App\_A**.

5.  Enter the Group ID as **org1** and press enter. Click **Save**. **App\_A** will be shared with all the users in **org1** group.

    !!! note
        - You can enter one group ID or multiple group IDs based on the groups with which you wish to share the application.

    [![Create an application]({{base_path}}/assets/img/learn/application-sharing.png)]({{base_path}}/assets/img/learn/application-sharing.png)

## Using application sharing

You can use application sharing as follows:

1.  Sign out of the API Developer Portal.

2.  Sign in to the API Developer Portal as **user2**.

     `https://<hostname>:9443/devportal`

3.  Click **Applications** to go to the applications page. 

     You will see App_A that was added by **user1**.
    
     [![Application list]({{base_path}}/assets/img/learn/application-sharing-sharedapp.png)]({{base_path}}/assets/img/learn/application-sharing-sharedapp.png)   
   
4.  Subscribe to the default API using App\_A.
     
     [![Subscribe to the default API]({{base_path}}/assets/img/learn/application-sharing-subscribe.png)]({{base_path}}/assets/img/learn/application-sharing-subscribe.png) 

5.  Sign in to the API Developer Portal as **user1.** 

     The subscriptions for App\_A by **user2** will be displayed.
    
     [![Subscription list]({{base_path}}/assets/img/learn/application-shared-subscriptions.png)]({{base_path}}/assets/img/learn/application-shared-subscriptions.png) 

## Extending the group ID extractor

The default implementation picks the organization's claim as the group ID. The organization names are returned in a string array. To use a different claim or a different type of group ID, you should create your own group ID extractor class by extending the `NewPostLoginExecutor` interface and overriding the following method.

``` java
String[] getGroupingIdentifierList(String response);
```

When a user signs in to the Developer Portal, the latter mentioned method is called, and it will return all the group IDs that correspond to the user who has logged in to the Developer Portal. After users sign in to the Developer Portal, they will be able to see their own applications, which they created, and also the applications that are shared with the group IDs that were returned by the `getGroupingIdentifierList` method.

After you have written your custom group extractor, add the JAR of the custom group extractor to the `<API-M_HOME>/repository/components/lib` directory and do the necessary configuration changes mentioned in [enabling application sharing](#enabling-application-sharing).


## Defining a custom user claim as the group extractor claim

To define a custom user claim URI as the default group extractor claim URI, add the following configuration under the `[apim.devportal]` configuration in the `<API-M_HOME>/repository/conf/deployment.toml` file.

**Format**

``` java
application_sharing_claim=[custom-claim]
```

**Example**
``` java
application_sharing_claim="http://wso2.org/claims/role"
```