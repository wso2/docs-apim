# Adding Links to Navigate Between the Store and Publisher

By default, there are no links in the UIs of the API Store and API Publisher applications to traverse between the two apps.

**To add a link in the WSO2 API Publisher to the WSO2 API Store:**

1.  Set the `<DisplayURL>` to `true` , and provide the URL of the Store in the `<API-M_HOME>/repository/conf/api-manager.xml` file.

        !!! tip
    If you are using a **distributed/clustered API Manager setup** , this configuration must be done in the API Publisher node/s.


    **Example**

    ``` java
        <APIStore>  
               <DisplayURL>true</DisplayURL>     
               <URL>https://<hostname>:9443/store</URL>
        </APIStore>
    ```

    -`<hostname>` - The hostname of the API Publisher node.

2.  Restart the WSO2 API-M server.
    Note that a URL that points to the API Store appears on the top, right-hand corner of the WSO2 API Publisher.
    Example:
    ![](/assets/attachments/103333412/103333413.png)
!!! tip
-   For information on clustering, see [Clustering WSO2 API Manager](http://docs.wso2.org/display/CLUSTER44x/Clustering+API+Manager) .
-   For information on deployment patterns, see [Deployment Patterns of WSO2 API Manager](http://docs.wso2.com/display/CLUSTER44x/API+Manager+Deployment+Patterns) .


