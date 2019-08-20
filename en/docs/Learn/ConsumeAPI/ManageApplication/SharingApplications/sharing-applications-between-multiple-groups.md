# Sharing Applications Between Multiple Groups

WSO2 API Manager provides the facility for users to share their applications and subscriptions with a specific logical group/groups such as an organization. Users can view and modify applications and subscriptions belonging to other users in the same group.

By default, API Manager considers the organization name you enter when signing up to the API Store as the group ID. All the users specifying the same organization name belong to the same group and therefore, can view each others' subscriptions and applications. API Manager also provides flexibility to change this default authentication implementation

-   [Enabling Multi-Group Sharing](#SharingApplicationsBetweenMultipleGroups-EnablingMulti-GroupSharing)
-   [Using the group sharing feature](#SharingApplicationsBetweenMultipleGroups-Usingthegroupsharingfeature)
-   [Extending the group ID extractor](#SharingApplicationsBetweenMultipleGroups-ExtendingthegroupIDextractor)

### Enabling Multi-Group Sharing

You can enable application sharing between multiple groups by following the steps below.

1.  Shutdown the server if its running
2.  Uncomment the `           <GroupingExtractor>          ` element in the `           <API-M_HOME>/repository/conf/api-manager.xml          ` file.

    ``` java
        <GroupingExtractor>org.wso2.carbon.apimgt.impl.DefaultGroupIDExtractorImpl</GroupingExtractor>
    ```

        !!! note
    This default extractor does not work with SAML SSO. To enable SAML SSO, you need to write a custom implementation using the [SAMLGroupIDExtractorImpl.java](https://github.com/sambaheerathan/carbon-apimgt/blob/multiGrpId/components/apimgt/org.wso2.carbon.apimgt.impl/src/main/java/org/wso2/carbon/apimgt/impl/SAMLGroupIDExtractorImpl.java) class


3.  Restart the server.

### Using the group sharing feature

Group IDs are extracted using a `         GroupingExtractor        ` class which is an implementation of `         NewPostLoginExecutor        ` interface. The default implementation is done through the `                   DefaultGroupIDExtractorImpl                 ` class. The organization claim is extracted using the group ID. If a particular user is in more than one organization, provide the organizations as a string separated by commas.

The steps below show how to use the group sharing feature

1.  Start WSO2 API Manager and click **Sign-up** .
    ![](attachments/103333711/103333712.png)2.  Sign up to the API store as two different users(e.g., usera, userb) belonging to the the same organizations. Click **Show Additional Details** to set the organization.

    ![](attachments/103333711/103333713.png)
3.  Sign in as **usera** and add application App\_A.

4.  Enter the Group ID as **org1** and press enter. Click **Add** . App\_A will be shared with all the users in **org1** group.
    ![](attachments/103333711/103333714.png)
5.  Sign out of the API Store. Sign in as **userb** .
6.  Go to the **Applications** tab. You will see App\_A which was added by **usera** .
    ![](attachments/103333711/103333715.png)    Note that the name of the application creator is appended to the application name to differentiate the applications.
7.  Subscribe to the default API using App\_A.
    ![](attachments/103333711/103333716.png)8.  Log in to the API Store as **usera.** The subscriptions for App\_A by **userb** will be displayed.
    ![](attachments/103333711/103333717.png)
### Extending the group ID extractor

The default implementation picks the organization claim as the group ID. The organization names are returned in a string array. To use a different claim or a different type of group ID , should create your own group ID extractor class by extending `         NewPostLoginExecutor        ` interface and overriding the method below.

``` java
    String[] getGroupingIdentifierList(String response);
```

This particular method will be called when a user is logging into the store and it will return all the groupIds for the logged in user. After logging in users will be able to see the applications created by themselves, and the applications shared with groupIds returned by `         getGroupingIdentifierList        ` Method.
