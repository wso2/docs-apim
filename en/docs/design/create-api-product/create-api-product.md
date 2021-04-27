# Create an API Product

Let's create an API Product named customer leasing that includes resources from the Customer Info API & Leasing API, as discussed in the [previous example]({{base_path}}/design/create-api-product/api-product-overview/#how-it-works).

1. Sign in to the API Publisher.

     `https://<hostname>:9443/publisher` 

     (e.g., `https://localhost:9443/publisher`). 

2. Create the following two APIs by importing 
the attached OpenAPI definition (a.k.a Swagger definition) files.
     - Customer Info API - [customer-info-api.yaml]({{base_path}}/assets/attachments/learn/customer-info-api.yaml) 

     - Leasing API - [leasing-api.yaml]({{base_path}}/assets/attachments/learn/leasing-api.yaml)

     <html>
     <div class="admonition note">
     <p class="admonition-title">Note</p>
     <ul>
     <li><p>Ensure that you provide an endpoint for each API after it is imported. The API Product will reuse the endpoint specified at the API-level.</p></li>
     
     <li>It is not necessary to publish an API in order to use it to create an API Product.
     </li></ul>
     </div> 
     </html>
        
     After the APIs are created, the respective resources for each of the APIs will appear as follows:

     - Customer info API
         
         [![Customer info API]({{base_path}}/assets/img/learn/design-api/create-api-product/customer-info-api.png)]({{base_path}}/assets/img/learn/design-api/create-api-product/customer-info-api.png)
      
     - Leasing API
         
         [![Leasing API]({{base_path}}/assets/img/learn/design-api/create-api-product/leasing-api.png)]({{base_path}}/assets/img/learn/design-api/create-api-product/leasing-api.png)

     <html>
     <div class="admonition note">
     <p class="admonition-title">Note</p>
     
     <ul>
      <li><p>Only users with <b>publisher</b> permission are allowed to create an API Product.
     </p></li>

     <li><p>
     If you have not already signed in to the Publisher Portal as a user who has <b>publisher</b> permissions (e.g., <code>admin</code>), you need to sign out and sign in with this permission in order to be able to carry out the following instructions. </p></li>
     
    </ul>
     </div> 
     </html>

3. Click **API Products** on the left menu, and then click on **API Product**.

    [![Create API Product Menu]({{base_path}}/assets/img/learn/design-api/create-api-product/create-api-product.png)]({{base_path}}/assets/img/learn/design-api/create-api-product/create-api-product.png)

    The **Create an API Product** page appears.
    
4. Enter the API Product details.
    
     <html>
     <table>
     <tr>
     <td>
     Name
     </td>
     <td>
     customer-leasing
     </td>
     </tr>
     <tr>
     <td>
     Context
     </td>
     <td>
     customer-leasing
     </td>
     </tr>
     </table>
     </html>

     [![Define an API product]({{base_path}}/assets/img/learn/design-api/create-api-product/define-api-product.png)]({{base_path}}/assets/img/learn/design-api/create-api-product/define-api-product.png)
    
5.  Click **NEXT**.

     The Add Resources page appears. 

     [![Resources page appears]({{base_path}}/assets/img/learn/design-api/create-api-product/add-resources.png)]({{base_path}}/assets/img/learn/design-api/create-api-product/add-resources.png)
    
     - The leftmost pane shows the available list of APIs. 
     - The central pane lists the available resources of a given API, which is selected in the left pane. 
     - You can select a resource in the central pane and add it to the right pane, which shows the resources that will be added to the API Product.

6. Add resources from the `customer-info` API.

     1. Click the `customer-info` API in the left pane.
     2. Select the `GET /customers` and `GET /customers/{customerId}` resources in the central pane.
     3. Click **Add Selected** to add them to the right pane so that it can be used for the API Product.

     [![Add resources from the customer-info API]({{base_path}}/assets/img/learn/design-api/create-api-product/select-customer-info-resources.png)]({{base_path}}/assets/img/learn/design-api/create-api-product/select-customer-info-resources.png)

7. Add resources from the `leasing` API.
     1. Click the `leasing` API in the left pane.
     2. Select the `GET /assets/{assetId}` and `POST /assets` resources in the central pane.
     3. Click **Add Selected** to add them to the right pane so that it can be used for the API Product.

     [![Add resources from the leasing API]({{base_path}}/assets/img/learn/design-api/create-api-product/select-leasing-resources.png)]({{base_path}}/assets/img/learn/design-api/create-api-product/select-leasing-resources.png)
    
8. Click **PUBLISH** to create and publish the API Product. 

     The API Product will appear in the API Publisher, as shown below.

     [![API Product in the API Publisher]({{base_path}}/assets/img/learn/design-api/create-api-product/api-product-publisher-details.png)]({{base_path}}/assets/img/learn/design-api/create-api-product/api-product-publisher-details.png)

     The API Product will also appear in the Developer Portal, as shown below. 

     [![API Product in the Developer Portal]({{base_path}}/assets/img/learn/design-api/create-api-product/api-product-portal-listing.png)]({{base_path}}/assets/img/learn/design-api/create-api-product/api-product-portal-listing.png)

9. Sign in to the Developer Portal to subscribe and consume the API Product in the same way that you would do so for an API. 
     
     `https://<hostname>:9443/devportal` 

     (e.g., `https://localhost:9443/devportal`). 

     For more information on how to subscribe to an API, see [Subscribe to an API]({{base_path}}/consume/manage-subscription/subscribe-to-an-api/).
    
     
