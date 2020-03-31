# Sharing Applications

WSO2 API Manager provides the facility for users to share their applications and subscriptions with a specific logical group/groups such as an organization. As a result of application sharing, users can view and modify applications and subscriptions belonging to other users in the same group or a different group.

WSO2 API Manager considers the organization name you enter when signing up to the API Store as the group ID. All the users specifying the same organization name belong to the same group. Therefore, such users that belong to a single group can view each others' subscriptions and applications provided that you have [enabled group sharing](#SharingApplications-Enablingapplicationsharing) . WSO2 API Manager also provides the flexibility to change this default authentication implementation.

-   [Enabling application sharing](#SharingApplications-Enablingapplicationsharing)
-   [Sharing an application with multiple users](#SharingApplications-Sharinganapplicationwithmultipleusers)
-   [Using application sharing](#SharingApplications-Usingapplicationsharing)
-   [Extending the group ID extractor](#SharingApplications-ExtendingthegroupIDextractor)

### Enabling application sharing

You can enable application sharing with users in a single group or between users in multiple groups by following the steps below.

1.  Shutdown the server if its running.
2.  Uncomment the `<GroupingExtractor>` element in the `<API-M_HOME>/repository/conf/api-manager.xml` file.

    ``` java
        <GroupingExtractor>org.wso2.carbon.apimgt.impl.DefaultGroupIDExtractorImpl</GroupingExtractor>
    ```

        !!! note
    This default extractor does not work with SAML SSO. To enable SAML SSO, you need to define the `GroupingExtractor` element as follows:

    ``` java
        <GroupingExtractor>org.wso2.carbon.apimgt.impl.SAMLGroupIDExtractorImpl</GroupingExtractor>
    ```


3.  Restart the server.

### Sharing an application with multiple users

Group IDs are extracted using a `GroupingExtractor` class which is an implementation of `NewPostLoginExecutor` interface. The default implementation is done through the [DefaultGroupIDExtractorImpl](https://github.com/wso2/carbon-apimgt/blob/6.x/components/apimgt/org.wso2.carbon.apimgt.impl/src/main/java/org/wso2/carbon/apimgt/impl/DefaultGroupIDExtractorImpl.java) class. The organization claim is extracted using the group ID. If a particular user is in more than one organization, provide the organizations as a string separated by commas.

Share an application with multiple users who are in the same group or who are in multiple groups as follows:

1.  Start WSO2 API Manager, navigate to the WSO2 Store, and click **Sign-up** .
    ![]({{base_path}}/assets/attachments/126559217/126559218.png)2.  Sign up to the API store as two different users (e.g., usera, userb) belonging to the same organizations. Click **Show Additional Details** to set the organization.

    ![]({{base_path}}/assets/attachments/126559217/126559219.png)
3.  Sign in as **usera** and add application **App\_A** .

4.  Enter the Group ID as **org1** and press enter. Click **Add** . App\_A will be shared with all the users in **org1** group.

        !!! note
    -   You can enter one group ID or multiple group IDs based on the groups with which you wish to share the application.

    -   If you have [enabled group sharing](#SharingApplications-Enablinggroupsharing) , but if you have not entered a group ID in the **Groups** section, WSO2 API-M will automatically share the application with the users who are in the same organization that you are in, because they are considered as part of the same group.


    ![]({{base_path}}/assets/attachments/126559217/126559220.png)
### Using application sharing

You can use application sharing as follows:

1.  Sign out of the API Store.
2.  Sign in to the API Store as **userb** .
3.  Go to the **Applications** tab. You will see App\_A which was added by **usera** .
    ![]({{base_path}}/assets/attachments/126559217/126559221.png)    Note that the name of the application creator is appended to the application name to differentiate the applications.
4.  Subscribe to the default API using App\_A.
    ![]({{base_path}}/assets/attachments/126559217/126559222.png)5.  Log in to the API Store as **usera.** The subscriptions for App\_A by **userb** will be displayed.
    ![]({{base_path}}/assets/attachments/126559217/126559223.png)
### Extending the group ID extractor

The default implementation picks the organization claim as the group ID. The organization names are returned in a string array. To use a different claim or a different type of group ID , you should create your own group ID extractor class by extending the `NewPostLoginExecutor` interface and overriding the following method.

``` java
    String[] getGroupingIdentifierList(String response);
```

When a user signs in to the store, the latter mentioned method is called and it will return all the group IDs that correspond to the user who has logged in to the store. After users sign in to the store, they will be able to see their own applications, which they created, and also the applications that are shared with the group IDs that were returned by the `getGroupingIdentifierList` method.
