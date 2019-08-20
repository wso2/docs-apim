# Generating server stubs and client SDKs in the API Publisher

Software Development Kits (SDKs) contain the necessary toolkits to create a client application to invoke a particular API. If an API consumer wants to create an application, they can generate a server stub or client side SDK for a supported language/framework and use it to write a software application to consume the subscribed APIs.

!!! note
SDK generation is not supported with the APIs that are created using OpenAPI 3.0 support.


The API Publisher has an embedded [swagger editor](http://editor.swagger.io/#/) with the ability to generate server code and client SDKs then and there.

!!! note
Client SDK and Server Stub generation in API Publisher is only supported for Rest APIs.


1.  Open an existing API and choose to edit it.
2.  Click **Edit Source** to open the embedded swagger editor.
3.  To generate and download a server stub, click **Generate Server** and select a server stub from the list.
    API deveopers can use the **Generate Server** option to generate the REST API structure based on the swagger definition. The actual backend implementation can be developed on top of the code generated using swagger code generator. You can select from a list of frameworks to generate the actual backend implementation stub of the REST API.
4.  To generate and download a client SDK, click **Generate Client** and select a client from the list.

The generated server stubs and client SDKs are generated using [Swagger Codegen](http://swagger.io/swagger-codegen/) .

It is recommended to add the `         securityDefinitions        ` in the swagger definition to be able to pass access tokens when invoking an API. Edit the source of the API from the API Publisher and add the code given below.

`          securityDefinitions:         `

`         ` `          default         ` `          :         `

`         ` `          type: oauth2         `

`         ` `          authorizationUrl:         ` `          '                     https://:          >/authorize'         `

`         ` `          flow: implicit         `

`         ` `          scopes: {}         `

`          security:         `

`         ` `          -         ` `          default         ` `          : []         `
