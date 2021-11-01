# Sample Interceptor Services

## Sample 1: JSON to XML transformation for a Legacy Backend - Book Store

Let's say we have a legacy backend "Book Store". The resource `/books` with the method `POST` accepts an XML request to add a new book.
The value of the header `password` should be `admin` otherwise it returns `401` HTTP status code.
If book got added successfully then the returned HTTP code is `200`.

Let's say our requirement is to make the API to accepts JSON payload and if book get created success, respond it with the
HTTP status code `201` and we are happy about the response returned from the backend so no need to modify the response.

Following diagram describes what we are planning to do as in our requirements.

<img src="{{base_path}}/assets/img/deploy/mgw/interceptor-example-json-to-xml.png" alt="Interceptor sample JSON to XML" width="880px"/>

Since we read the request body in request interceptor, we need to add `request_body` in the `includes` section of Open API Definition of the API.
We are using the same microservice to handle both request and response interception.

```yaml
x-wso2-request-interceptor:
  scheme: https
  host: xml-interceptor
  port: 9081
  includes:
    - request_body
x-wso2-response-interceptor:
  scheme: https
  host: xml-interceptor
  port: 9081
```

### Try out the sample

You can find the implementation of the interceptor service in the [Choreo Connect GitHub Repository](https://github.com/wso2/product-microgateway).
Clone the repository and change to the cloned path.

1. Start the Choreo-Connect docker compose setup if you have not started yet.
1. Change to the directory `samples/interceptors/` and start the docker compose setup with the legacy backend and interceptor service.
    ```shell
    docker compose up
    ```

#### Directly invoke the backend

The port of the backend server is bind to the host in the docker-compose.yaml. So we can test it first.
Check the HTTP status code as well.

```shell
curl -X POST http://localhost:9080/books -d '<name>The Prisoner</name>' -H 'password: admin' -v
```

The response body should be `created` with the status code `200`.

```shell
curl -X POST http://localhost:9080/books -d '<name>The Prisoner</name>' -H 'password: 1234' -v
```

The response body should be `<response>Error</response>` with the status code `401`.

#### Invoke the API

Now lets init the API and add the interceptor cert to the project. We have already added the CA cert of the Choreo Connect Router.
```shell
apictl init bookstore --oas bookstore-api.yaml
mkdir -p bookstore/Endpoint-certificates/interceptors/
cp certs/interceptor.crt bookstore/Endpoint-certificates/interceptors/
```

Create adapter environment if not already exists.
```shell
apictl mg add env dev --adapter https://localhost:9843 
```

Deploy the API.
```shell
apictl mg login dev -u admin -p admin -k
apictl mg deploy api -f bookstore -e dev -k
```

Let's invoke the API with the JSON body `{"name":"The Prisoner"}`.

```shell
TOKEN=$(curl -X POST "https://localhost:9095/testkey" -H "Authorization: Basic YWRtaW46YWRtaW4=" -k -v)
curl "https://localhost:9095/abc-stores/books" -H "accept: application/xml" -H "Authorization:Bearer $TOKEN" -H 'password: admin' -d '{"name":"The Prisoner"}' -v -k
```

The response body is `created` with status code `201` with the provided JSON body. We have successfully modified the HTTP status code without touching the
response body of the backend.

```shell
curl "https://localhost:9095/abc-stores/books" -H "accept: application/xml" -H "Authorization:Bearer $TOKEN" -H 'password: 1234' -d '{"name":"The Prisoner"}' -v -k
```

The response body is `<response>Error</response>` with status code `401`. This is the expected behaviour since we were happy with error scenario.
Hence, we could successfully transform our legacy backend with our new requirements successfully.
