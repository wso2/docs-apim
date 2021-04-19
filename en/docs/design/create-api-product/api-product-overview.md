# API Product Overview

An API Product is a packaging mechanism that you can use when you need to bundle a preferred set of resources from multiple APIs and expose it as a separate API interface, which can be consumed by subscribers. API Products give Publishers the ability to repackage their existing APIs in various combinations to provide a tailor-made experience for their subscribers.

WSO2 API Manager allows Publishers to create API Products via the Publisher Portal. Subscribers will see the API Product via the Developer Portal as a separate entity, which is independent of the APIs with which it shares its resources. From a subscriber's perspective, the API Product will look and function in the same way as any of the standard APIs on the Developer Portal.

## How it works

Let's use the following  example to understand how API Products work in WSO2 API Manager.

**Example**

   [![Example for API Product]({{base_path}}/assets/img/learn/design-api/create-api-product/api-product-overview.png)]({{base_path}}/assets/img/learn/design-api/create-api-product/api-product-overview.png)
  
A financial institution has the following three APIs.

- **Customer Info API**

    This API is used to access and update the financial information of the customers. The API consists of the following resources.
      <html>
      <table>
      <thead>
      <tr>
      <th>Resources</th>
      <th>Description</th>
      </tr>
      </thead>
      <tbody>
      <tr>
      <td><strong>GET /customers</strong></td>
      <td>Get the list of all the existing customers.</td>
      </tr>
      <tr>
      <td><strong>GET /customers/{customerId}</strong></td>
      <td>Get details of a specific customer based on the customer ID.</td>
      </tr>
      <tr>
      <td><strong>POST /customers</strong></td>
      <td>Add a new customer.</td>
      </tr>
      <tr>
      <td><strong>PUT /customers/{customerId}</strong></td>
      <td>Update details of a specific customer based on his/her customer ID.</td>
      </tr>
      <tr>
      <td><strong>DELETE /customers/{customerId}</strong></td>
      <td>Delete a specific customer based on his/her customer ID.</td>
      </tr>
      </tbody>
      </table>
      </html>
  
- **Leasing API**

    Used to access and update the information regarding the leases of the institution. The API consists of the following 
    resources.
    
    <html>
    <table>
    <thead>
    <tr>
    <th>Resources</th>
    <th>Description</th>
    </tr>
    </thead>
    <tbody>
    <tr>
    <td><strong>GET /assets</strong></td>
    <td>Get the list of all existing assets that can be leased.</td>
    </tr>
    <tr>
    <td><strong>GET /assets/{assetId}</strong></td>
    <td>Get details of a specific asset based on an asset ID.</td>
    </tr>
    <tr>
    <td><strong>POST /assets</strong></td>
    <td>Add a new asset.</td>
    </tr>
    <tr>
    <td><strong>PUT /assets/{assetId}</strong></td>
    <td>Update a specific asset based on an asset ID.</td>
    </tr>
    <tr>
    <td><strong>DELETE /assets/{assetId}</strong></td>
    <td>Delete a specific asset based on an asset ID.</td>
    </tr>
    </tbody>
    </table>
    </html>
      
- **Credit API**
    
    Used to access and update the credit information with regard to a specific customer. The API consists of the following resources.      
     
     <html>
     <table>
      <thead>
      <tr>
      <th>Resources</th>
      <th>Description</th>
      </tr>
      </thead>
      <tbody>
      <tr>
      <td><strong>GET /accounts/{customerId}</strong></td>
      <td>Get the list of credit accounts for a customer based on his/her customer ID.</td>
      </tr>
      <tr>
      <td><strong>GET /accounts/{accountId}</strong></td>
      <td>Get details of a specific credit account based on an account ID.</td>
      </tr>
      <tr>
      <td><strong>POST /accounts/{customerId}</strong></td>
      <td>Add a new credit account for a customer based on a customer ID.</td>
      </tr>
      <tr>
      <td><strong>PUT /accounts/{accountId}</strong></td>
      <td>Update a specific credit account based on an account ID.</code></td>
      </tr>
      <tr>
      <td><strong>DELETE /accounts/{accountId}</strong></td>
      <td>Delete a specific credit account based on an account ID.</td>
      </tr>
      </tbody>
      </table>
      </html>
      
      
The resources of the above mentioned existing APIs can be reused and exposed via API Products as shown below.

- **Leasing API Product**

    <html>
    <table>
    <thead>
    <tr>
    <th>Resources</th>
    <th>Description</th>
    <th>API</th>
    </tr>
    </thead>
    <tbody>
    <tr>
    <td><strong>GET /customers</strong></td>
    <td>Get the list of all the existing customers.</td>
    <td rowspan="2" style="vertical-align : middle">Customer Info API</td>
    </tr>
    <tr>
    <td><strong>GET /customers/{customerId}</strong></td>
    <td>Get details of a specific customer based on the customer ID.</td>
    </tr>
    <tr>
    <td><strong>GET /assets</strong></td>
    <td>Get the list of all the existing assets that can be leased.</td>
    <td rowspan="2" style="vertical-align : middle">Leasing API</td>
    </tr>
    <tr>
    <td><strong>GET /assets/{assetId}</strong></td>
    <td>Get details of a specific asset based on the asset ID.</td>
    </tr>
    </tbody>
    </table>
    </html>
      
- **Credit API Product**

    <html>
    <table>
    <thead>
    <tr>
    <th>Resources</th>
    <th>Description</th>
    <th>API</th>
    </tr>
    </thead>
    <tbody>
    <tr>
    <td><strong>GET /customers</strong></td>
    <td>Get the list of all the existing customers.</td>
    <td rowspan="2" style="vertical-align : middle">Customer Info API</td>
    </tr>
    <tr>
    <td><strong>GET /customers/{customerId}</strong></td>
    <td>Get details of a specific customer based on the customer ID.</td>
    </tr>
    <tr>
    <td><strong>GET /accounts/{accountId}</strong></td>
    <td>Get details of a specific credit account based on the account ID.</td>
    <td rowspan="2" style="vertical-align : middle">Credit API</td>
    </tr>
    <tr>
    <td><strong>POST /accounts/{customerId}</strong></td>
    <td>Add a new credit account for a customer based on a customer ID.</td>
    </tr>
    </tbody>
    </table>
    </html>
      
In this example, a subset of the resources from different APIs have been combined to provide a customized hybrid offering that can appeal to different subscribers. This also ensures that only specific resources are exposed via the API Product.

## More information

Whenever a specific resource of an API is added to an API Product in WSO2 API Manager, the following attributes of the API resource are reused:

- OAuth scope
- Authentication scheme
- Throttling policy

 <html>
 <div class="admonition info">
 <p class="admonition-title">Info</p>
 <p> An API Product will share the resource(s) of an existing API.</p>
 </div> 
 </html>

When creating an API Product via the Publisher Portal, the Publisher can define a separate set of subscription-level throttling policies that are different from the subscription-level throttling policies that exist at the API-level.

An API Product will share the resource(s) of an existing API. As a result, the same backend endpoint that is defined by the respective resource's API is reused by the API Product. As the API Product may contain resources from multiple APIs, an API Product may route to multiple backend endpoints.

 <html>
 <div class="admonition note">
 <p class="admonition-title">Note</p>
 <p> API Products cannot define their own backend endpoints, apart from reusing the existing endpoints belonging to its API resources respective parent API.</p>
 </div> 
 </html>
    
After an API Product is created, it is published to the API Gateway as an independent Synapse API artifact.
