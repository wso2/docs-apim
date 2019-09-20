# Adding Custom Properties to APIs

Usually, APIs have a pre-defined set of properties such as the name, version, context, etc. However, there may be instances where you want to add specific custom properties to your API. You can do this in either of the following ways:

-   [Add custom properties via the API Publisher](#AddingCustomPropertiestoAPIs-AddcustompropertiesviatheAPIPublisher)
-   [Add custom properties via the REST API](#AddingCustomPropertiestoAPIs-AddcustompropertiesviatheRESTAPI)

When adding custom properties, note the following:

-   Property name should be unique.

-   Property name should not contain spaces.

-   Property name cannot be case-sensitive .

-   Property name cannot be any of the following as they are reserved keywords: provider, version, context, status, description, subcontext, doc, lcState, name, tags.

After the custom properties have been added, you can [search for APIs using custom property values](#AddingCustomPropertiestoAPIs-Searchusingcustomproperties) .

### Add custom properties via the API Publisher

1.  Sign in to the API Publisher as an API creator using the following URL: `https://<localhost>:9443/publisher` .
2.  [Create a new API](https://docs.wso2.com/display/AM260/Create+and+Publish+an+API) or edit an existing API.
3.  In the **Manage** tab, expand the **API Properties** area, enter a custom property name and value (e.g. property name: environment, property value: preprod) and click the plus (+) sign to add it.
    ![Add custom API properties]/assets/attachments/103333404/103333406.png "Add custom API properties")4.  Save the API.

### Add custom properties via the REST API

You can use the [existing REST API](https://docs.wso2.com/display/AM210/apidocs/publisher/#!/operations#APICollection#apisPost) to add a new API with custom properties. Add the following element to the request body including the relevant properties,

`"additionalProperties : {"environment": "preprod", "secured": "true"}        `

### Search using custom properties

You can use the following format to search for an API using the custom properties:

`<property_name>:<property_value>        `

For example, if you want to search for the **environment** property with a specific value (e.g., preprod) in the Publisher, you can search as shown below:

![Search for APIs with custom properties]/assets/attachments/103333404/103333408.png "Search for APIs")
When you click on the name of the API in the above screen, you are taken to the respective API Overview page that has details with regard to the API properties that you added.

![API overview with API properties highlighted]/assets/attachments/103333404/103333405.png "API overview")