# Deploying a SOAP API(Pass-through)  in Choreo Connect

WSO2 Choreo Connect supports the deployment of an existing SOAP and WSDL based services exposd via the gateway. The organizations that have SOAP/WSDL based services can easily proxy their existing services while providing key features like API Security, rate limiting, observability, etc.. without the cost of a major migration. 

You can deploy a SOAP API (SOAP to SOAP pass-through) in the following ways depending on the Choreo Connect **mode** you have chosen.


|**Mode**         | **Method**    |
|--------------|-----------|
|[Choreo Connect with WSO2 API Manager as a Control Plane]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/concepts/apim-as-control-plane/)   | [Via WSO2 API Manager Publisher Portal](#via-wso2-api-manager-publisher-portal)  |
|[Choreo Connect as a Standalone Gateway]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/concepts/as-a-standalone-gateway/)  |[Via apictl for Standalone Mode](#via-apictl-for-standalone-mode) |


## Via WSO2 API Manager Publisher Portal

Follow the instructions below to deploy a SOAP API in a Choreo Connect instance run with WSO2 API Manager as the Control Plane.

!!! info "Before you begin"

    This guide assumes that you already have a Choreo Connect instance configured to run with API Manager. If not,

    - To start Choreo Connect with an existing API Manager instance, follow the steps mentioned in the [Using Choreo Connect Deployed on Docker with WSO2 API Manager Guide]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/getting-started/deploy/cc-on-docker-with-apim-as-control-plane)

    - To start a complete deployment setup that includes a WSO2 API Manager instance and a Choreo Connect instance already configured to work with API Manager, follow the steps in the [Quick Start Guide]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/getting-started/quick-start-guide-docker-with-apim).

### Step 1 - Create a SOAP API using API Manager publisher portal.

Create a SOAP API Pass-through using the WSDL definition of your SOAP service by following the below method described in WSO2 API Manager.

- [Create a SOAP API Pass-through using WSO2 API Manager Publisher Portal.]({{base_path}}/design/create-api/create-rest-api/expose-a-soap-service-as-a-rest-api/#expose-a-soap-service-as-a-rest-api)


### Step 2 - Deploy the SOAP API using API Manager publisher portal.

Follow [this]({{base_path}}/deploy-and-publish/deploy-on-gateway/deploy-api/deploy-an-api/) guide to easily deploy the API that you just created in the previous step.


### Step 3 - Invoke the API

After the API is deployed in WSO2 API Manager publisher portal, it gets exposed in the Choreo Connect gateway. You can invoke the API with a valid access token.

To invoke the API through WSO2 API Manager, you can follow the steps below.

1. Publish the API from the publisher portal - [Publish API]({{base_path}}/deploy-and-publish/publish-on-dev-portal/publish-an-api/)
2. Login to **Developer portal** and subscribe this API to an Application and then invoke it by generating an access token - You can follow steps(Step 5 & Step 6) [here]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/getting-started/quick-start-guide-docker-with-apim/#step-4-invoke-the-api-from-publisher) to invoke the SOAP API through WSO2 API Manager.
    
    !!! Note
        When invoking SOAP API (Pass through) via WSO2 API Manager, you will see a UI like below.

        [![Invoke Soap API]({{base_path}}/assets/img/deploy/mgw/invoke-soap-api.png)]({{base_path}}/assets/img/deploy/mgw/invoke-soap-api.png)

        Here you can need to provide the values for following parameters.

        1. **SOAP Request(body)** - The SOAP request body that you will be using to invoke the SOAP endpoint (SOAP Envelope). 
        For this example you may provide:
            ``` xml
            <soap:Envelope
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                xmlns:xsd="http://www.w3.org/2001/XMLSchema"
                xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
                <soap:Body>
                    <CheckPhoneNumber
                        xmlns="http://ws.cdyne.com/PhoneVerify/query">
                        <PhoneNumber>18006785432</PhoneNumber>
                        <LicenseKey>18006785432</LicenseKey>
                    </CheckPhoneNumber>
                </soap:Body>
            </soap:Envelope>
            
            ```
        2. **SOAPAction (header)** - The SOAPAction HTTP request header field can be used to indicate the intent of the SOAP HTTP request. The value is a URI identifying the intent. If you are using SOAP 1.1, you must provide this value.
        For example you may provide this as,
            ``` uri
            http://ws.cdyne.com/PhoneVerify/query/CheckPhoneNumber
            ```

!!! tip
    If you want to invoke the using a test key API without publishing, you may follow the methods below.
        
    1. Via WSO2 API Manager publisher portal - [Test a REST API]({{base_path}}}/design/create-api/create-rest-api/test-a-rest-api/)
    2. Generating a Enforcer test key - [Enforcer Test Key Authentication]({{base_path}}}/deploy-and-publish/deploy-on-gateway/choreo-connect/security/generate-a-test-jwt/)

!!! tip
    In the above documentation, we explained the testing of SOAP APIs using `cURL` commands and WSO2 API Manager UI. If you want to test your SOAP API using a SOAP client like SOAP UI, you can read on [Test an API Using a SOAP Client]({{base_path}}/consume/invoke-apis/invoke-apis-using-tools/invoke-an-api-using-a-soap-client/).


## Via apictl for Standalone Mode

The WSO2 API Controller (apictl) does not provide a straight forward method for generating a `apictl` project for SOAP APIs. However you can use a project extracted from the WSO2 API Manager(you may download the project for API created in above guide) or a sample swagger for SOAP APIs. This guide will continue using a sample swagger for SOAP API.

The swagger definition for our `PhoneVerify` example as follows.

``` yaml
info:
  title: PhoneVerification
  version: 1.0.0
paths:
  /*:
    post:
      consumes:
      - text/xml
      - application/soap+xml
      parameters:
      - description: SOAP request.
        in: body
        name: SOAP Request
        required: true
        schema:
          type: string
      - description: SOAPAction header for soap 1.1
        in: header
        name: SOAPAction
        required: false
        type: string
      responses:
        "200":
          description: OK
      security:
      - default: []
      x-wso2-application-security:
        optional: false
        security-types:
        - oauth2
security:
- default: []
securityDefinitions:
  default:
    authorizationUrl: https://test.com
    flow: implicit
    type: oauth2
swagger: "2.0"
x-wso2-application-security:
  optional: false
  security-types:
  - oauth2
x-wso2-auth-header: Authorization
x-wso2-basePath: /phoneverify/1.0.0
x-wso2-cors:
  accessControlAllowCredentials: false
  accessControlAllowHeaders:
  - authorization
  - Access-Control-Allow-Origin
  - Content-Type
  - SOAPAction
  - apikey
  - Internal-Key
  accessControlAllowMethods:
  - GET
  - PUT
  - POST
  - DELETE
  - PATCH
  - OPTIONS
  accessControlAllowOrigins:
  - '*'
  corsConfigurationEnabled: false
x-wso2-production-endpoints:
  type: http
  urls:
  - http://ws.cdyne.com/phoneverify/phoneverify.asmx
x-wso2-response-cache:
  cacheTimeoutInSeconds: 300
  enabled: false
x-wso2-sandbox-endpoints:
  type: http
  urls:
  - http://ws.cdyne.com/phoneverify/phoneverify.asmx
x-wso2-transports:
- http
- https
```

Following steps will show you how to create the `apictl` project, deploy it on the Choreo Connect gateway and invoke it using a test token, for our `PhoneVerify` example.

!!! Info "Before you begin"
    Please make sure you have completed [Download and initilaize]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller/#download-and-initialize-the-ctl-tool) `apictl` and Choreo Connet is up and running in [standalone mode]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/getting-started/deploy/cc-deploy-overview/#choreo-connect-deployment-options). 


### Step 1 - Initialize the apictl project

Use the follwing command to initialize the `apictl` project. You may use the above sample swagger provided.

```bash
apictl init PhoneVerify --oas <path to swagger.yaml>
```

It will create you a project with following file structure in the current working directory.

```text
PhoneVerify
├── api_meta.yaml
├── api.yaml
├── Client-certificates
├── Definitions
│   └── swagger.yaml
├── deployment_environments.yaml
├── Docs
├── Image
├── Interceptors
├── libs
├── Policies
└── README.md
```

### Step 2 - Set the project type as `SOAP`

In the `api.yaml` file of the created project, change the `type` as `SOAP`.

```yaml
data:
  ...
  type: SOAP
  ...
```

### Step 3 - Deploy the API

Execute the following commands to get your API project deployed in Choreo Connect gateway.

1. Add a Choreo Connect Environment to `apictl`
    ```bash
    apictl mg add env dev --adapter https://localhost:9843
    ```

2. Log in to the Choreo Connect Environment in `apictl`
    ```bash
    apictl mg login dev -u admin -p admin -k
    ```

3. Deploy the API
    ```bash
    apictl mg deploy api -f PhoneVerify -e dev -k
    ```

!!! Note
    More details on above commands can be find the the documentation page [Managing Choreo Connect]({{base_path}}/install-and-setup/setup/api-controller/managing-choreo-connect/managing-choreo-connect-with-ctl/) under CI/CD documentations.

### Step 4 - Invoke the API

After the APIs are exposed via Choreo Connect, you can invoke an API with a valid access token.

Let's use the following command to generate a JWT to access the API, and set it to the variable TOKEN.

```bash
TOKEN=$(curl -X POST "https://localhost:9095/testkey" -H "Authorization: Basic YWRtaW46YWRtaW4=" -k -v)
```

!!! Info
    Refer [Enforcer Test Key Authentication]({{base_path}}}/deploy-and-publish/deploy-on-gateway/choreo-connect/security/generate-a-test-jwt/) to learn more on above command.

Execute the following cURL command to Invoke the API using the access token.

```bash
curl -X 'POST' 'https://localhost:9095/phoneverify/1.0.0' -H 'Content-Type: text/xml' -H "Authorization: Bearer $TOKEN" -H "SOAPAction: http://ws.cdyne.com/PhoneVerify/query/CheckPhoneNumber" -d @request.xml -k -v
```

A sample content for `request.xml` file referred in above cURL command looks like follows.

```xml
<soap:Envelope
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:xsd="http://www.w3.org/2001/XMLSchema"
	xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
	<soap:Body>
		<CheckPhoneNumber
			xmlns="http://ws.cdyne.com/PhoneVerify/query">
			<PhoneNumber>18006785432</PhoneNumber>
			<LicenseKey>18006785432</LicenseKey>
		</CheckPhoneNumber>
	</soap:Body>
</soap:Envelope>
```
