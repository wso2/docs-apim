# File Upload via Multipart Requests

#### File uploads with other data

First, use the requestBody keyword to describe the request payload containing a file. Under content, you can use the multipart media type to describe a file sent with other data.

!!! note
    The following example shows how to upload a file via multipart request in [OAS3](https://swagger.io/docs/specification/describing-request-body/file-upload/) . If you are using an OAS2 API definition, please refer to [this swagger document](https://swagger.io/docs/specification/2-0/file-upload/) on multipart form file uploads.

``` yml
    requestBody:
      content:
        multipart/form-data:
          schema:
            type: object
            properties:
              orderId:
                type: integer
              userId:
                type: integer
              fileName:
                type: string
                format: binary
```

#### Multiple File Upload

You can use the multipart media type to define uploading an array of files.

``` yml
    requestBody:
      content:
        multipart/form-data:
          schema:
            type: object
            properties:
              filename:
                type: array
                items:
                  type: string
                  format: binary
```
