
# API Categories

API categories can be used to group APIs. In earlier versions this was possible by using tagwise groups. With the new addition of API categories feature tagwise grouping feature is now deprecated and the users are advised to use API categories instead.

### Add API Category

a. Through Admin Portal UI

1. Goto admin portal and select API Category > API Categories from the left menu.
    
    ![](../assets/img/api_category_left_tag.png)

2. Click on Add New Category on top left corner of the main panel.

    ![](../assets/img/click_add_category.png)

3. Give a name and a description for the category and save it.

    ![](../assets/img/add_category.png)

b. Through admin REST API

curl -k -X POST -H "Authorization: Bearer <ACCESS_TOKEN>" -H "Content-Type: application/json" https://localhost:9443/api/am/admin/v0.16/api-categories -d @category-data.json

NOTE : ACCESS_TOKEN should have admin_operations scope

Sample payload :
{
"name": "Sales",
"description": "Sales category"
}

### Attach API Category to an API

Select an API and goto Design Configurations tab. From the category drop down select the API category and save the API.

![](../assets/img/api_categories_dropdown.png)

![](../assets/img/attach_category.png)

### List APIs in Devportal

Expand tag cloud menu. Select the API category under API Categories listing. APIs belonging to the selected category will be listed.

![](../assets/img/devportal_listing.png)