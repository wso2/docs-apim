# Publish to Multiple External API Stores

You can share an API with application developers who are subscribed to the API Stores of other tenants. This allows you to advertise your APIs to a wider community. Subscribers of other tenant stores can view and browse your APIs; however, the users must visit your (the original publisher's) Store to subscribe to the APIs.

The following diagram illustrates the process involved when an API Publisher publishes to multiple API Stores.

![Illustrates the process involved when an API Publisher publishes to multiple API Stores]({{base_path}}/assets/attachments/103332470/103332466.png)

The API Publisher of Tenant\_1, who is located in Node\_1, is publishing an API to it's API Store. In addition to that the API Publisher publishes the API to the following three external stores.

-   API Store of Tenant\_2 in same node.
-   API Store of Tenant\_3 in same node.
-   API Store of Tenant\_1 in Node 2

The capability to publish to external API Stores is not configured by default. Follow the steps below to configure it. In this guide, we use two separate instances of WSO2 API Manager and we publish from one instance to the Store of the other instance.

1.  Copy the WSO2 API Manager product pack to two different locations.
    If needed, you can download the WSO2 API Manager product pack from [here](http://wso2.com/products/api-manager/) .
2.  Go to the `<API-M_HOME>/repository/conf/carbon.xml` file of the **second** instance and change its port by an offset of 1.
    The port offset is set to avoid the port conflicts that occur when you run more than one WSO2 product on the same host.

    ``` xml
        <Offset>1</Offset>
    ```

3.  Start both API-M servers.
    Let's publish from the first instance of WSO2 API Manager to the Store of the second instance, which in this tutorial we consider as the external API Store.
4.  Sign in to the WSO2 API-M management console of the **first** instance ( `https://<Server Host>:9443/carbon` ) as admin.

        !!! tip
    In a **multi-tenant environment** , you must sign in using the tenant's credentials.


5.  Click **Main&gt; Resources &gt; Browse** .
    ![Menu option to navigate to the Browse option]({{base_path}}/assets/attachments/103332470/103332465.png)
    The Registry opens.

6.  Go to the `/_system/governance/apimgt/externalstores/external-api-stores.xml` resource.
    ![Navigating to the external-api-stores.xml file]({{base_path}}/assets/attachments/103332470/103332464.png)

7.  Click the **Edit as Text** link, uncomment the `<StoreURL>` element under the `<ExternalAPIStores>` element, and add the details of each external API store that you need to publish APIs to.
    In this example,

    -`http://localhost:9764/store` is the API Store of the second WSO2 API Manager instance.
    -   You publish to its super tenant's Store (admin/admin).
    -   For this tutorial change the `DisplayName` to `Store2` , so that it is clear that we are referring to the second WSO2 API-M instance, which we are using as the external Store.
    -   The port is 9764 as you incremented it by 1 in [step 2](#PublishtoMultipleExternalAPIStores-step2) .
    -   If the second WSO2 API Manager instance has multiple tenants and you want to publish to a tenant's Store, the tenant's Store URL and credentials must be given here.

    ``` java
        <ExternalAPIStores>
            <StoreURL>http://localhost:9763/store</StoreURL>
                <ExternalAPIStore id="Store2" type="wso2" className="org.wso2.carbon.apimgt.impl.publishers.WSO2APIPublisher">
                    <DisplayName>Store2</DisplayName>
                    <Endpoint>http://localhost:9764/store</Endpoint>
                    <Username>admin</Username>
                    <Password>admin</Password>
                </ExternalAPIStore>
        </ExternalAPIStores>
    ```

        !!! tip
    If you want to configure more than one external store, change the configuration in `<ExternalAPIStore>` and add it to the **external-api-stores.xml** .

    For example, if we have three API Stores, and one is a super tenant and other two are tenant stores, you can configure these three external stores as shown below.

    ``` java
        <ExternalAPIStores>
        <!--Configuration to set the store URL of the current running APIM deployment. 
        APIs published to external stores will be redirected to this URL-->
        
            <StoreURL>http://<ip_address>:<port>localhost:9763/store</StoreURL>

            <ExternalAPIStore id="SLStore" type="wso2" className="org.wso2.carbon.apimgt.impl.publishers.WSO2APIPublisher">
                <DisplayName>SL-Store</DisplayName>
                <Endpoint>http://<ip_address>:<port>/store</Endpoint>
                <Username>admin</Username>
                <Password>admin</Password>
            </ExternalAPIStore>
              
            <ExternalAPIStore id="USStore" type="wso2" className="org.wso2.carbon.apimgt.impl.publishers.WSO2APIPublisher">
                <DisplayName>US-Store</DisplayName>
                <Endpoint>http://<ip_address>:<port>/store</Endpoint>
                <Username>{tenantadmin_username}@{tenant_domain}</Username>
                <Password>{tenantadmin_password}</Password>
            </ExternalAPIStore>


            <ExternalAPIStore id="UKStore" type="wso2" className="org.wso2.carbon.apimgt.impl.publishers.WSO2APIPublisher">
                <DisplayName>UKStore</DisplayName>
                <Endpoint>http://l<ip_address>:<port>/store</Endpoint>
                <Username>{tenantadmin_username}@{tenant_domain}</Username>
                <Password>{tenantadmin_password}</Password>
            </ExternalAPIStore>
        

    </ExternalAPIStores>
    ```
        !!! tip
    In a **multi-tenant environment** , each tenant can publish to different external Stores by changing the above file in their tenant space. For more information on how APIs appear and are available for subscription in a multi-tenant environment, see [API visibility and subscription](Key-Concepts_103328852.html#KeyConcepts-APIvisibilityandsubscription) . Note that publishing to an external Store only means that the API is advertised there. To subscribe, you must always register and sign in to the original publisher's tenant Store.


    Note the following in the configuration above:

    <table>
    <thead>
    <tr class="header">
    <th>Element</th>
    <th>Description</th>
    </tr>
    </thead>
    <tbody>
    <tr class="odd">
    <td><p><code>                &lt;ExternalAPIStore id=&quot;&quot; type=&quot;&quot; className=&quot;&quot;&gt;               </code></p></td>
    <td><div class="content-wrapper">
    <p><code>                 id                </code> : The external store identifier, which is a unique value.<br />
    <code>                 type                </code> : The type of the Store. This can be a WSO2-specific API Store or an external one, which has a different implementation from the default API Store.<br />
    <code>                 className                </code> : The implementation class inside the WSO2 API Manager distribution.</p>
        !!! info
        <p>The default className specified is <code>                 org.wso2.carbon.apimgt.impl.publishers.WSO2APIPublisher                </code> , which is used when WSO2 specific API Store is used. However, if you are using an external API Store, the class should be customized by extending the <code>                                   org.wso2.carbon.apimgt.api.model.APIPublisher                                 </code> interface, and the fully qualified class name of the new implementation should be used as the <code>                 className                </code> parameter.</p>

    </div></td>
    </tr>
    <tr class="even">
    <td><p><code>                &lt;StoreURL&gt;               </code></p></td>
    <td>The URL of the API Store of the current API-M deployment. This is the URL to the API in the original publisher's store. APIs that are published to external stores are redirected to this URL.</td>
    </tr>
    <tr class="odd">
    <td><code>               &lt;DisplayName&gt;              </code></td>
    <td>The name of the external API Store that is displayed in the Publisher UI.</td>
    </tr>
    <tr class="even">
    <td><p><code>                &lt;Endpoint&gt;               </code></p></td>
    <td>The URL of the external API Store.</td>
    </tr>
    <tr class="odd">
    <td><code>               &lt;Username&gt;              </code> and <code>               &lt;Password&gt;              </code></td>
    <td><p>The credentials of a user who has permissions to create and publish APIs.</p></td>
    </tr>
    </tbody>
    </table>

        !!! info
    The registry changes are applied dynamically. You do not need to restart the server.


8.  Click **Save Content** .

9.  Sign in to the API Publisher of the first instance as admin/admin and if you do not have any APIs that are in the published state created, [create an API](_Create_and_Publish_an_API_) .

        !!! tip
    In a multi-tenant environment, sign in to the API Publisher using your tenant's credentials.


10. Click on the newly created or existing API.
    Here you see a new tab named **External API Stores** added to the API Publisher console.

        !!! info
    This tab is only visible when viewing API's that are in the published state.


    ![View of the link to External API Stores tab]({{base_path}}/assets/attachments/103332470/103332463.png)

        !!! note
    -   You can select multiple external API stores and click **Save** to publish your API to them.
    -   If the API creator updates the API after publication to external stores, either the creator or a publisher can simply push those changes to the published stores by selecting the stores, and clicking **Save** again.
    -   If the API creator deletes the API, each external store that it is published to receives a request to delete the API.


11. Select the Store that you want to publish to (in this case, Store2) and click **Save** .
    ![Selecting the External API Store]({{base_path}}/assets/attachments/103332470/103332467.png)

12. Sign in to the external API Store (in this case, `http://localhost:                       9764                      /store` ) and click on the API that you just published.

    A link appears as **Visit Publisher Store** , which directs you to the original publisher’s store (in this case, `http://localhost:                       9763                      /store` ) through which you can subscribe to the API.
    ![]({{base_path}}/assets/attachments/103332470/103332462.png)

You have successfully added multiple external stores to your registry and published your APIs to them.
