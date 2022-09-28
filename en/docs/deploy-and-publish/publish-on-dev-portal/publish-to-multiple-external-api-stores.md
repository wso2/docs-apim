# Publish to Multiple External Developer Portals

You can share an API with application developers who are subscribed to the Developer Portals of other tenants. Thereby, this allows you to advertise your APIs to a wider community. Subscribers of other tenant developer portals can view and browse your APIs; however, the users must visit your (the original publisher's) Developer Portal to subscribe to the APIs.

The following diagram illustrates the process involved when an API Publisher publishes to multiple Developer Portals.

<img src="{{base_path}}/assets/img/learn/publish-to-multiple-developer-portals.png" alt="Illustrates the process involved when an API Publisher publishes to multiple Developer Portals" title="Illustrates the process involved when an API Publisher publishes to multiple Developer Portals" width="45%" />

<a name="step8"> </a>

The API Publisher of Tenant\_1, that is located in Node\_1, publishes an API to it's API Developer Portal. In addition, the API Publisher publishes the API to the following three external Developer Portals.

-   API Developer Portal of Tenant\_2 in same node.
-   API Developer Portal of Tenant\_3 in same node.
-   API Developer Portal of Tenant\_1 in node 2.

!!! note

    The capability to publish to external Developer Portals is not configured by default. 

Follow the steps below to be able to publish to external Developer Portals. 

In this guide, let's use two separate instances of WSO2 API Manager, and let's publish from one instance to the Developer Portal of the other instance.

1.  Copy the WSO2 API Manager product pack to two different locations.

     If needed, you can download the WSO2 API Manager product pack from [here](https://wso2.com/api-manager/).

2.  Go to the `<API-M_HOME>/repository/conf/deployment.toml` file of the **second** instance and change its port by an offset of 1.

     The port offset is set to avoid the port conflicts that occur when you run more than one WSO2 product on the same host.

    ``` toml
    [server]
    offset=1
    ```

3.  Start both API-M servers.

     Let's consider the second instance as the external API Developer Portal. Let's publish from the first instance of WSO2 API Manager to the Developer Portal of the second instance.

4.  Sign in to the WSO2 API-M Admin Portal of the **first** instance (`https://<server-host>:9443/admin`) as `admin`.

    !!! tip
        In a **multi-tenant environment**, you must sign in using the tenant's credentials.


5. Navigate to  **Settings > Advanced > Advanced Configurations**.

    <img src="{{base_path}}/assets/img/learn/advance-configuration-in-admin-portal.png" alt="Advanced Configurations in Admin Portal" title="Advanced Configurations in Admin Portal" width="70%" />

6. Add the details of each external API Developer Portal that you need to publish APIs to.

    ``` json
       "ExternalAPIStores": {
            "StoreURL": "http://localhost:9443/devportal",
            "ExternalAPIStore": 
            [
                {
                    "id": "DeveloperPortal2",
                    "type": "wso2",
                    "className": "org.wso2.carbon.apimgt.impl.publishers.WSO2APIPublisher",
                    "DisplayName": "DeveloperPortal2",
                    "Endpoint": "http://localhost:9444/devportal",
                    "Username": "admin",
                    "Password": "admin"
                }
            ]
       }
    ```
    In this example,

    - `http://localhost:9444/devportal` is the API Developer Portal of the second WSO2 API Manager instance.
    -   You publish to its super tenant's Developer Portal (admin/admin).
    -   For this tutorial, change the `DisplayName` to `DeveloperPortal2` , so that it is clear that we are referring to the second WSO2 API-M instance, which we are using as the external Developer Portal.
    -   The port is 9444 as you incremented it by 1 in step 2.
    -   If the second WSO2 API Manager instance has multiple tenants and you want to publish to a tenant's Developer Portal, the tenant's Developer Portal URL and credentials must be given here.



    !!! tip

        If you want to configure more than one external Developer Portal, add that to `ExternalAPIStore` array in `ExternalAPIStores` JSON object.

        For example, if you have three Developer Portals, and one is a super tenant and other two are tenant Developer Portals, you can configure these three external Developer Portals as follows:

        ``` json
           "ExternalAPIStores": {
                "StoreURL": "http://<ip_address>:<port>/devportal",
                "ExternalAPIStore": 
                [
                    {
                        "id": "SLStore",
                        "type": "wso2",
                        "className": "org.wso2.carbon.apimgt.impl.publishers.WSO2APIPublisher",
                        "DisplayName": "SL-Store",
                        "Endpoint": "http://<ip_address>:<port>/devportal",
                        "Username": "admin",
                        "Password": "admin"
                    },
                    {
                        "id": "USStore",
                        "type": "wso2",
                        "className": "org.wso2.carbon.apimgt.impl.publishers.WSO2APIPublisher",
                        "DisplayName": "US-Store",
                        "Endpoint": "http://<ip_address>:<port>/devportal/apis?tenant={tenant_domain}",
                        "Username": "{tenantadmin_username}@{tenant_domain}",
                        "Password": "{tenantadmin_password}"
                    },
                    {
                        "id": "UKStore",
                        "type": "wso2",
                        "className": "org.wso2.carbon.apimgt.impl.publishers.WSO2APIPublisher",
                        "DisplayName": "UKStore",
                        "Endpoint": "http://<ip_address>:<port>/devportal/apis?tenant={tenant_domain}",
                        "Username": "{tenantadmin_username}@{tenant_domain}",
                        "Password": "{tenantadmin_password}"
                    }
                ]
           }
        ```
        
        To setup an external API store from a tenant other than the super tenant, you need to configure the `ExternalAPIStores` JSON object as follows:
        
        ```json
        "ExternalAPIStores": {
            "StoreURL": "http://<ip_address>:<port>/devportal/apis?tenant={tenant_domain_of_first_deployment}",
            "ExternalAPIStore":
            [
                {
                    "id": "DeveloperPortal2",
                    "type": "wso2",
                    "className": "org.wso2.carbon.apimgt.impl.publishers.WSO2APIPublisher",
                    "DisplayName": "DeveloperPortal2",
                    "Endpoint": "http://<ip_address>:<port>/devportal/apis?tenant={tenant_domain_of_second_deployment}",
                    "Username": "{tenantadmin_username}@{tenant_domain_of_second_deployment}",
                    "Password": "{tenantadmin_password}"
                }
            ]
        }
        ```
    
    !!! tip
        In a **multi-tenant environment**, each tenant can publish to different external Developer Portals by changing the above file in their tenant space. For more information on how APIs appear and are available for subscription in a multi-tenant environment, see [API visibility]({{base_path}}/get-started/key-concepts#api-visibility). Note that publishing to an external Developer Portal only means that the API is advertised there. To subscribe, you must always register and sign in to the original publisher's tenant Developer Portal.


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
    <td><p><code>                id</code> <code>type</code> <code>className               </code></p></td>
    <td><div class="content-wrapper">
    <p><code>                 id                </code> : The external Developer Portal identifier, which is a unique value.<br />
    <code>                 type                </code> : The type of the Developer Portal. This can be a WSO2-specific API Developer Portal or an external one, which has a different implementation from the default API Developer Portal.<br />
    <code>                 className                </code> : The implementation class inside the WSO2 API Manager distribution.</p>

      <div class="admonition info">
      <p class="admonition-title">Info</p>
      <p>The default <code>className</code> specified is <code>                 org.wso2.carbon.apimgt.impl.publishers.WSO2APIPublisher</code>, which is used when WSO2 specific API Developer Portal is used. However, if you are using an external API Developer Portal, you need to customize the class by extending the <code>     org.wso2.carbon.apimgt.api.model.APIPublisher</code> interface and you should use the fully qualified class name of the new implementation as the <code>className</code> parameter.</p>
      </div>
        
    </div></td>
    </tr>
    <tr class="even">
    <td><p><code>                StoreURL               </code></p></td>
    <td>The URL of the current API-M deployment's API Developer Portal. This is the URL to the API in the original publisher's Developer Portal. APIs that are published to external Developer Portals are redirected to this URL.</td>
    </tr>
    <tr class="odd">
    <td><code>               DisplayName              </code></td>
    <td>The name of the external API Developer Portal that is displayed in the Publisher UI.</td>
    </tr>
    <tr class="even">
    <td><p><code>                Endpoint               </code></p></td>
    <td>The URL of the external API Developer Portal.</td>
    </tr>
    <tr class="odd">
    <td><code>               Username              </code> and <code>               Password              </code></td>
    <td><p>The credentials of a user who has permission to create and publish APIs.</p></td>
    </tr>
    </tbody>
    </table>

    !!! info

        The Advanced Configuration changes are applied dynamically. You do not need to restart the server.


7.  Click **Save Content**.

8. Sign in to the Publisher of the first instance as `admin`/`admin` and if you do not have any APIs that are in the published state created, [create an API]({{base_path}}/design/create-api/create-rest-api/create-a-rest-api/).

    !!! tip
            In a multi-tenant environment, sign in to the API Publisher using your tenant's credentials.


9. Click on the newly created or existing API.
    
     Here you see a new tab named **External Developer Portals** added to the API Publisher console.

    !!! info

        This tab is only visible when viewing API's that are in the `PUBLISHED` state.

    [![List External Developer Portal]({{base_path}}/assets/img/learn/external-dev-portals.png)]({{base_path}}/assets/img/learn/external-dev-portals.png)

    !!! note

        -   You can select multiple external API Developer Portals and click **Save** to publish your API to them.

        -   If the API creator updates the API after publishing the API to the external Developer Portals, either the creator or a publisher can simply push those changes to the published Developer Portals by selecting the Developer Portals, and clicking **Save** again.
            
        -   If the API creator deletes the API, every external Developer Portal that it is published to receives a request to delete the API.


10. Select the Developer Portal that you want to publish to (in this case, `DeveloperPortal2`) and click **Save**.

     [![Publish to external Developer Portal]({{base_path}}/assets/img/learn/publish-to-external-devportal.png)]({{base_path}}/assets/img/learn/publish-to-external-devportal.png)

11. Sign in to the external API Developer Portal (in this case, `http://localhost:9444/devportal`) and click on the API that you just published.

    A link appears as **Visit Publisher Developer Portal** which directs you to the original publisher’s Developer Portal (in this case, `http://localhost:9443/devportal`) through which you can subscribe to the API.

You have successfully added multiple external Developer Portals to your registry and published your APIs to them.
