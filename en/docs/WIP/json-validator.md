JSON Request / Response validator in APIM 3.0

Overview:

Wso2 API Manager provides a swaggerSchemavalidator handler to validate the request, response payloads against the JSON schema which is defined in the swagger.json file. If a user enables the schema validation property either publisher UI or REST API, the particular handler is engaged into the API synapse config file and all the request goes through the particular validator handler and validates the request before forwarding it to the backend and also it works for the other way round like validates the response payload against the defined response schema before responding back to the client.

How it works:

Whenever an API client attempts creating a REST resource, there are some validation rules to consider. For example, the user tries to create a Pet resource. The particular resource is defined in the swagger as in below.


```
"/pet": {

      "post": {

        "tags": [

          "pet"

        ],

        "summary": "Add a new pet to the store",

        "description": "",

        "operationId": "addPet",

        "requestBody": {

          "$ref": "#/components/requestBodies/Pet"

        },

        "responses": {

          "405": {

            "description": "Invalid input"

          }

        },

        "security": [

          {

            "petstore_auth": [

              "write:pets",

              "read:pets"

            ]

          }

        ]

      }

 ```

According to the swagger definition, the request payload should be validated against pet schema

Please find relevant pet schema

```

"Pet": {

        "title": "a Pet",

        "description": "A pet for sale in the pet store",

        "type": "object",

        "required": [

          "name",

          "photoUrls"

        ],

        "properties": {

          "id": {

            "type": "integer",

            "format": "int64"

          },

          "name": {

            "type": "string",

            "example": "doggie"

          },

          "photoUrls": {

            "type": "array",

            "xml": {

              "name": "photoUrl",

              "wrapped": true

            }            

      }\
```

For example name and photoUrls fields should be required and name should be string, photoUrls should be array and properties should be integer type and int64 format. Otherwise, validator fails with bad request issue and block the request to reaching the backend.

Likewise, the response payload is validated against the defined response schema

Business values:

It's often necessary for applications to validate JSON objects, to ensure that required properties are present and that additional constraints (such as a price never being less than one dollar) are met.

Actually the client-side validation is incredibly important. Basically, it validates all the requests and reduces backend failures. Sometimes attackers may try malicious payloads to break the gateway. But this feature evaluates the payload and check whether it is compatible with the defined schema.

How it works:

Technical view of the feature

When API is published, the relevant swagger file is created as a local entry so that the gateway can access the swagger. Once the API request/response comes into the validator handler it builds the message and extracts the payload. Furthermore, the particular handler extracts the relevant schema and create an inline schema model and handover to the third party library. It validates the request/response against the schema and passes back the response. If it's an invalid request payload, handler creates 400 bad requests unless directs to the backend. If it is an invalid response, handler creates 500 error response.

![](https://lh3.googleusercontent.com/LCatP2jxYpne2FM3xmt_sMyqzDGDGb52n40pZ3u58nmmKDQCSJBikGjJWrj0wTaOoJ2lAR-prHKqxY9enh_YhPV8z3OSJ0kkC4DGGkxV8N9vWV34hIgq8f1PjLclcIiWAHlnkpgk)

User view of the feature

Request Validation:

Sending Valid request

![](https://lh5.googleusercontent.com/D6n-SOMacjN3CgFwnOjZ8YFp1_q9YleN8DELq8uiD7yIb_D1PNw3yMVmJZHwo2wQhMMHQonFRpW6s0WZTr_fchGytSmCC8rqqvxkcV00pB8j78GWwohQyOt-OoMU0NjJ_I0PW25i)

Sending invalid request (this should be 400 and I asked the marketing team to correct it in diagrams)

![](https://lh3.googleusercontent.com/K1auhWydTnQ0S-Q2jCdGU_VGQueHJk-dMIJ1oxopEVuC5dBrVdtbaYBq2xKBsyTcOvUAmSee_NM6wxmaUI4hSwtIAfS35mzmYbXCzdQRpKTbJ_oVqqPEhvFZZRUwmQvsyVAHRd5N)

Response Validation:

Valid response from the backend

![](https://lh4.googleusercontent.com/oPaZX6LEWhlcUPSr0_Lc19Ip7IlgAbEjOGADHTmMcf5k-EMPB2NJlq_7980-RE-Zqkv2NA1Zc5t1wJ99e27GcOuiaIoTJfuWehkEeKOCzWIvw8XAbMSYYNIvew7-TDx7UsQOGW6t)

Invalid response from the backend

![](https://lh4.googleusercontent.com/Uw1lj-oSHbSqE3NXVeYHWhWeFl8kt-6wsxce2q3pnYuxWP8QbizYlAg0afgVVkLjOtTao431mq15fhJQu1wVInz_0KT7pz95kmwLJPvT9MD872ZXZ-QzbWKst4YR-FuQIy_l54bE)

How do we enable the feature:

1.  Go inside the API Runtime configuration page. By default schema validation property is set to false. You can enable it as below.

![](https://lh3.googleusercontent.com/KpDEl7_SFOhQG8SjM_2JtazkBlyacO9hnTcnA9_G9O9_dUbO9W9HIGMqkXTwvjyH9rojX9vyYy4ahnmI3hrzYCYSPBywDXi3KRXflGxdwUKML810KmUBux0w-zPF_FQLvdT53vnt)

Samples:

Sending invalid request

1.Sample Swagger - PetStore Sample

====================

Refer the swagger file [1]

<https://github.com/OAI/OpenAPI-Specification/blob/master/examples/v2.0/json/petstore.json>

REQUEST:

=============

curl -k -X POST "https://10.100.7.69:8243/api/1.0.0/pets" -H "accept: application/json" -H "Content-Type: application/json" -H "Authorization: Bearer 7cf0b315-6513-3caf-a8ab-b32e8c671d42" -d "{ \"tag\": \"string\"}"

<am:fault xmlns:am="<http://wso2.org/apimanager>">

<am:code>400</am:code>

<am:message>Bad Request</am:message>

<am:description>#: required key [name] not found</am:description>

</am:fault>

![](https://lh3.googleusercontent.com/-LK35gBLanXQVeVUH4SgY9JNdKI-gq8H7HL_aOkft8JsSfuDBepBb2O3a5Nvezb_to5opnFpAW7Uy7qlt7ZZlbvGiS0l3CCowUW2COswqNqWDvKMWT7sqvN9UrlSaYNlQTx9N-sf)

RESPONSE:

==========

curl -k -X POST "https://10.100.7.69:8243/apiwww/1.0.0/pets" -H "accept: application/json" -H "Content-Type: application/json" -H "Authorization: Bearer 7cf0b315-6513-3caf-a8ab-b32e8c671d42" -d "{ \"name\": \"string\", \"tag\": \"string\"}"

<am:fault xmlns:am="<http://wso2.org/apimanager>">

<am:code>400</am:code>

<am:message>Bad Response</am:message>

<am:description>#: #: only 1 subschema matches out of 2</am:description>

</am:fault>

2\. Default Sample - Create an API and edit the swagger.json as in bellow.

Invalid response from the backend

![](https://lh4.googleusercontent.com/ZlmSrMiHi5DjLzAchjjnCNTEZFrMqe4Wg__XJ2rKt6_EL1_EGks7jWLnVS8vjep5ZnLnvrpRKg-3EyWzpWbmtN12znIdrDR1goHiMR1hckdDfDxrvipYq0-_Sqn1cjH4Nxj3D073)

Request :

curl -k -X POST "https://10.100.7.69:8243/apinew/1.0.0/addPayload" -H "accept: application/json" -H "Content-Type: application/json" -H "Authorization: Bearer 16d2ad94-9e24-3cc7-866e-da126b0cce41" -d "{ \"payload\": \"eded\"}"

Response:

<am:fault xmlns:am="http://wso2.org/apimanager">\
  <am:code>400</am:code>\
  <am:message>Bad Request</am:message>\
  <am:description>#/payload: expected type: Number, found: String</am:description>\
</am:fault>

![](https://lh6.googleusercontent.com/CTuQWWcvJ1oTw8BScrat84FO-GXsvhRwu8L6UivFGH1w9Q_9U8IZHdjf7AIddVfvhsKc4PPZOhzZTzUl-yp0o4i8kYJ4sSNaPHdUeQze5U_o5-2IPLmU0jlVSwKy73-_FXT-COfD)