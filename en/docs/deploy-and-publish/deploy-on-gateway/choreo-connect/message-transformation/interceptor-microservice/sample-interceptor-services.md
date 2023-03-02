# Sample Interceptor Services

## Sample 1 - JSON to XML transformation for a Legacy Backend - Book Store

Let's consider a legacy backend named "Book Store". The resource `/books` with the method `POST` accepts an XML
request to add a new book. If the header `x-user: admin` is not present in the request to the server, it responds
with the `401` HTTP status code. If the book insertion is successful, it is `200`.

The requirement is to make the API accept a JSON payload and if the book gets created successfully,
respond to it with the HTTP status code `201`. Since the response returned from the backend is satisfactory, there is no need to modify the response.

The following diagram describes what the scenario that we are attempting to implement based on the requirements.

<img src="{{base_path}}/assets/img/deploy/mgw/interceptor-example-json-to-xml.png" alt="Interceptor sample JSON to XML" width="880px"/>

Since you read the request body in request interceptor, you need to add `request_body` in the `includes` section of Open API Definition of the API.
The same microservice is used to handle both request and response interception.

```yaml
x-wso2-request-interceptor:
  serviceURL: https://xml-interceptor:9081
  includes:
    - request_body
x-wso2-response-interceptor:
  serviceURL: https://xml-interceptor:9081
```

## Try out the sample

You can find the implementation of the interceptor service in the [Choreo Connect GitHub Repository](https://github.com/wso2/product-microgateway).
Clone the repository and change to the cloned path.

1. Start the Choreo-Connect Docker compose setup if you have not started it yet. For instructions, see [Deploying Choreo Connect as a Standalone Gateway on Docker]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/getting-started/deploy/cc-as-a-standalone-gateway-on-docker/#quick-start-guide-docker).

2. Find the sample interceptor implementations in the directory [samples/interceptors](https://github.com/wso2/product-microgateway/tree/main/samples/interceptors#readme).
   You can find implementations for following languages or tools.
      - Ballerina
      - Node.js
      - Java
      - Go
      - WSO2 Micro Integrator

3. Change to the directory `samples/interceptors/<PROGRAMMING_LANGUAGE>` and start the Docker compose setup with the legacy backend and interceptor service.
    ```shell
    docker-compose up
    ```

### Directly invoke the backend

The port of the backend server is bound to the host in the docker-compose.yaml. So we can test it first.
Check the HTTP status code in the response.

```shell
curl -X POST http://localhost:9080/books -d '<name>The Prisoner</name>' -H 'x-user: admin' -v
```

The response body should be `created` with the status code `200`.

```shell
curl -X POST http://localhost:9080/books -d '<name>The Prisoner</name>' -H 'x-user: john' -v
```

The response body should be `<response>Error</response>` with the status code `401`.

### Invoke the API

First, change the directory to `samples/interceptors`.
Now lets initialize the API and add the interceptor certificate to the project. You have already added the CA cert of the Choreo Connect router.
```shell
apictl init bookstore --oas bookstore-api.yaml
mkdir -p bookstore/Endpoint-certificates/interceptors/
cp resources/certs/interceptor.pem bookstore/Endpoint-certificates/interceptors/
```

Create adapter environment if it does not already exist.
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
curl "https://localhost:9095/abc-stores/books" \
  -H "Authorization:Bearer $TOKEN" \
  -H "content-type: application/json" \
  -d '{"name":"The Prisoner"}' -v -k
```

The response body is `created` with status code `201` with the provided JSON body. You have now successfully modified the HTTP status code without touching the
response body of the backend.
