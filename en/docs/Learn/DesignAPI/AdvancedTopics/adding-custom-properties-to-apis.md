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
2.  [Create a new API](../../../DesignAPI/CreateAPI/create-a-rest-api/) or edit an existing API.
3.  In the **Properties** tab, Click the **ADD NEW PROPERTY**, enter a custom property name and value (e.g. property name: environment, property value: preprod) and click **ADD** to add it.
    <html>
     <head>
     </head>
     <body>
     <img src="../../../../assets/img/Learn/add-new-property.png" alt="Add custom API properties" title="Add custom API properties" width="800" height="300"/>
     </body>
     </html>
4.  Save the API.

### Add custom properties via the REST API

You can use the [existing REST API](../../../../../../Develop/ProductAPIs/restful-apis/) to add a new API with custom properties. Add the following element to the request body including the relevant properties,

`"additionalProperties : {"environment": "preprod", "secured": "true"}        `

### Search using custom properties

You can use the following format to search for an API using the custom properties:

`<property_name>:<property_value>        `

For example, if you want to search for the **environment** property with a specific value (e.g., preprod) in the Publisher, you can search as shown below:
<html>
     <head>
     </head>
     <body>
     <img src="../../../../assets/img/Learn/search-apis-with-custom-properties.png" alt="Search for APIs with custom properties" title="Search for APIs with custom properties" width="600" height="300"/>
     </body>
</html>

When you click on the name of the API in the above screen, you are taken to the respective API Overview page. Click on the **Properties** tab to list the API properties that you have added.

<html>
     <head>
     </head>
     <body>
     <img src="../../../../assets/img/Learn/view-custom-api-properties.png" alt="Search for APIs with custom properties" title="Search for APIs with custom properties"/>
     </body>
</html>