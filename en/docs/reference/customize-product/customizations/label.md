
# Labels

You can use Labels to group and categorize APIs for any purpose. Labels do not use a naming convention. Therefore, the admin does not need to take into consideration any naming conventions when using Label based grouping. Administrators can use any naming conventions for the Labels depending on the usecase. 

Initially, the Admins will define Labels. Then, API providers will add Labels to APIs when designing them via the API Publisher. Labels allow API providers to categorize APIs that have similar attributes or based on the business usecase of the APIs.

## Step 1 - Add Label

You can add a Label using any of the following methods:

- Add a Label using the Admin Portal UI
- Add a Label using the Admin REST API. (You can use the POST resource in the **Labels (Individual)** section [here]({{base_path}}/reference/product-apis/admin-apis/admin-v4/admin-v4))

### Add a Label using the Admin Portal UI

1. Sign in to the Admin Portal.
   
    [https://localhost:9443/admin](https://localhost:9443/admin) 

2. Navigate to **Label** section.
    
    <img src="{{base_path}}/assets/img/develop/new_label_left_tag.png" width="250" alt="Labels menu">
    
3. Click **Add Label**.

    [![Add API category page]({{base_path}}/assets/img/develop/new_click_add_label.png)]({{base_path}}/assets/img/develop/new_click_add_label.png)

4. Enter a name and a description for the Label.

     | Field          |  Value                 |
     |----------------|------------------------|
     |  Name          |  Health                |
     |  Description   |  Health related APIs   |

    <img src="{{base_path}}/assets/img/develop/new_add_label.png" width="500" alt="Add Label">

5. Click **Save**.

## Step 2 - Attach the Label to an API

1. Sign in to the Publisher.

    [https://localhost:9443/publisher](https://localhost:9443/publisher) 

2. Click on an API.

3. Click **Portal Configurations > Basic Info**. 

     <img src="{{base_path}}/assets/img/develop/api-portal-config-basic-info.png" width="235" alt="Add API category">

4. Add/Remove Labels from the side menu.

     [![Add API categories]({{base_path}}/assets/img/develop/attach_label.png)]({{base_path}}/assets/img/develop/attach_label.png)
