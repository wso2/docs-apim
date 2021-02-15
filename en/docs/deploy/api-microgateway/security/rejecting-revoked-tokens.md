# Rejecting Revoked Tokens
Follow the below steps to enable Real-time and Persistent token revocation. This documentation explains the steps required to handle revoked JWTs. The same steps can be used for handling revoked opaque tokens. However, for opaque tokens, you only need to enable real-time notifications.

### Enabling revoked token notifications

Let's use the following sample scenario.

   - Both Real-time Notifications and Persistent Notifications are enabled.
   - Default etcd based persistent notifier implementation will be used.

!!! info
    **Before you begin** make sure to configure your Security Token Service (STS) and start it. In addition, when working with real-time notifications, you need to define the JMS map message payload in the following format.
    ```json
    "payloadData": [
      {
        "name": "revokedToken",
        "type": "STRING"
      },
      {
        "name": "ttl",
        "type": "STRING"
      }
    ]
    ```

1. Navigate to the `<MGW_HOME>/conf/micro-gw.conf` file and add the following configuration.

    ``` java tab="Real-time and Persistent Notifications"
    [tokenRevocationConfig]
      [tokenRevocationConfig.realtime]
        enableRealtimeMessageRetrieval = true
        jmsConnectionTopic = "tokenRevocation"
        jmsConnectioninitialContextFactory = "wso2mbInitialContextFactory"
        jmsConnectionProviderUrl= "amqp://admin:admin@carbon/carbon?brokerlist='tcp://localhost:5672'"
        jmsConnectionUsername = ""
        jmsConnectionPassword = ""
      [tokenRevocationConfig.persistent]
        enablePersistentStorageRetrieval = true
        type = "default"
        endpointURL = "https://localhost:9443/internal/data/v1"
        username = "admin"
        password = "admin"
    ```

    ``` java tab="Only Real-time Notifications"
    [tokenRevocationConfig]
      [tokenRevocationConfig.realtime]
        enableRealtimeMessageRetrieval = true
        jmsConnectionTopic = "tokenRevocation"
        jmsConnectioninitialContextFactory = "wso2mbInitialContextFactory"
        jmsConnectionProviderUrl= "amqp://admin:admin@carbon/carbon?brokerlist='tcp://localhost:5672'"
        jmsConnectionUsername = ""
        jmsConnectionPassword = ""
      [tokenRevocationConfig.persistent]
        enablePersistentStorageRetrieval = false
        type = "default"
        endpointURL = "https://localhost:9443/internal/data/v1"
        username = "admin"
        password = "admin"
    ```

    ``` java tab="Only Persistent Notifications"
    [tokenRevocationConfig]
      [tokenRevocationConfig.realtime]
        enableRealtimeMessageRetrieval = false
        jmsConnectionTopic = "tokenRevocation"
        jmsConnectioninitialContextFactory = "wso2mbInitialContextFactory"
        jmsConnectionProviderUrl= "amqp://admin:admin@carbon/carbon?brokerlist='tcp://localhost:5672'"
        jmsConnectionUsername = ""
        jmsConnectionPassword = ""
      [tokenRevocationConfig.persistent]
        enablePersistentStorageRetrieval = true
        type = "default"
        endpointURL = "https://localhost:9443/internal/data/v1"
        username = "admin"
        password = "admin"
    ```


    #### Realtime configurations

    <table>
      <thead>
      <tr>
      <th style="width: 40%">Property</th>
      <th style="width: 60%">Description</th>
      </tr>
      </thead>
      <tbody>
      <tr>
      <td>
      `enableRealtimeMessageRetrieval`
      </td>
      <td>
      This property is disabled by default. Set this property to `true` if you want to enable Real-time Notifications.
      </td>
      </tr>
      <tr>
      <td>
      `jmsConnectionTopic`
      </td>
      <td>
      This is the name of the topic in the JMS Message Broker that WSO2 API Microgateway listens to in order to identify messages related to revoked tokens.
      </td>
      </tr>
      <tr>
      <td>
      `jmsConnectioninitialContextFactory`

      `jmsConnectionProviderUrl`

      `jmsConnectionUsername`

      `jmsConnectionPassword`
      </td>
      <td>
      Similar to `jmsConnectionTopic` these are also JMS related configuration. As you can't use a custom implementation when using Real-time Notifications, you will not need to change these configurations.
      </td>
      </tr>
      </tbody>
    </table>


    #### Persistent configurations

    <table>
      <thead>
      <tr>
      <th style="width: 40%">Property</th>
      <th style="width: 60%">Description</th>
      </tr>
      </thead>
      <tbody>
      <tr>
      <td>
      `enablePersistentStorageRetrieval`
      </td>
      <td>Set this property to `true` if you want enable Persistent Notifications.</td>
      </tr>
      <tr>
      <td>
      `type`
      </td>
      <td>
      This property is set to `"default"` in the default configuration, so that you can use WSO2 API Manager eventhub as the default persistent storage. If you are using any other persistent storage, other than `default`, you need to define your custom implementation in the `<MGW_PROJECT>/extensions/token_revocation_extension.bal` file. Thereafter, you need to name set a preferred type name in this property.
      </td>
      </tr>
      <tr>
      <td>
      `hostname`
      </td>
      <td>
      The default value is `https://localhost:9443/internal/data/v1`. However, you can use etcd version 2,3 (`<etcd-server-access-URL>/v3/keys/jti/`) or even another persistent storage of your choice.
      </td>
      </tr>
      <tr>
      <td>
      `username`
      </td>
      <td>
      Enter the username of your persistent storage server (e.g., etcd server). The default value for the etcd server is "root".
      </td>
      </tr>
      <tr>
      <td>
      `password`
      </td>
      <td>
      Enter the password of your persistent storage server (e.g., etcd server). The default value for the etcd server is "root".
      </td>
      </tr>
      </tbody>
    </table>

    !!! note
        When working with persistent notifications, if you introduced new configurations in your custom implementation, then you have to provide the corresponding values for those properties in the `<MGW_HOME>/conf/micro-gw.conf` file under the `[tokenRevocationConfig.persistent]` section.

2. Generate a JWT token.
   Use one of the following methods to generate your JWT token.

    - **Use any third party secure token service (STS)**
        You need to add the public certificate of the token service that you used to sign the JWT token to the trust store of the WSO2 API Microgateway. The JWT should have the sub, aud, exp, and jti claims in order to be successfully validated with WSO2 API Microgateway.
    - **Use WSO2 API Manager**.
      [Obtain a JWT token using the WSO2 API Manager]({{apim_path}}/consume/manage-application/generate-keys/generate-api-keys/#generate-application-keys) .

3.  Extract the jti from the JWT token via the [https://jwt.io](https://jwt.io/) site.

4.  Start WSO2 API Manager or if you select etcd/other service as the persistent storage, configure and start the persistent storage service.

    <details>
      <summary>Click here for instructions to configure the etcd server.</summary>

      1.  Download the [etcd distribution](https://github.com/etcd-io/etcd/releases) based on your OS and unzip it.
          In this example, let's work with [etcd v3.3.13](https://github.com/etcd-io/etcd/releases/tag/v3.3.13) .

      2.  Navigate to the unzipped etcd distribution and start the etcd server.

          ```sh
          cd <etcd_HOME>
          ./etcd
          ```

          The following is a sample message that appear.

          ```text
          2019-05-23 19:09:18.921356 I | embed: ready to serve client requests
          ```

        **Note:**  
        If you are working in a production environment, start the etcd server with HTTPS enabled.
        ```sh
        ./etcd --name infra0 --data-dir infra0 --cert-file=<PATH_TO_CERT>/server.crt --key-file=<PATH_TO_CERT>/server.key --advertise-client-urls=https://localhost:2379 --listen-client-urls=https://localhost:2379
        ```

      3. Setup the required authentication with the service as follows:

          1. Create a user.

              ```sh tab="Format"
              ./etcdctl user add <username>
              ```
              
              ```sh tab="Example"
              ./etcdctl user add root
              ```

              ```text tab="Response"
              New password:
              User <username> created
              ```

          2. Create a user role.

              ```sh tab="Format"
              ./etcdctl role add <role_name>
              ```

              ```sh tab="Example"
              ./etcdctl role add root
              ```

              ```text tab="Response"
              Role <role_name> created
              ```

          3.  Assign the user to the user role.

              ```sh tab="Format"
              ./etcdctl user grant <username> --roles <role_name>
              ```
              
              ```sh tab="Example"
              ./etcdctl user grant root --roles root
              ```

              ```text tab="Response"
              User <username> updated
              ```

          4. Enable user authentication.

              ```sh tab="Command"
              ./etcdctl auth enable
              ```

              ```text tab="Response"
              Authentication Enabled
              ```

      4.  Optionally create a directory in the etcd server to store the revoked JWT IDs (jti). This directory can have any name (e.g., jti, jwt) however you have to add this directory name to the `hostname` property in persistent storage configuration.

          ```sh tab="Format"
          ./etcdctl -u <username> mkdir <directory_name>
          ```
              
          ```sh tab="Example"
          ./etcdctl -u root mkdir jti
          ```
      
      5.  Store the key value pair in the etcd server.

          ```sh tab="Format"
          ./etcdctl -u <username> set <jti> <ttl>
          ```

          ```sh tab="Example"
          ./etcdctl -u root set "3ad5672a-afca-4387-9ec5-fcf28785f803" 3600
          ```

          - `<jti>` - Enter the JWT ID (jti) that corresponds to the JWT token.
          - `<ttl>` - Enter the time-to-live (TTL) respective to the revoke token in milliseconds.
          - `<username>` - Username of the user created in previous steps.

    !!! info
        If you want to check whether you have stored your key-value pair correctly, run the following command.

        ```sh tab="Format"
        ./etcdctl  -u <username> get <jti>
        ```
        
        ```sh tab="Example"
        ./etcdctl  -u root get 3ad5672a-afca-4387-9ec5-fcf28785f803
        ```
    </details>

5.  Establish security between the persistent storage (etcd server), WSO2 API Microgateway, and the STS.

    !!! note
        This is only required if you are working in a production environment.

    1.  Create a self-signed certificate for the persistent storage.
    2.  Add the self-signed certificate to the Ballerina Trust Store ( `ballerinaTruststore.p12` ) in the WSO2 API Microgateway project and to the Client Trust Store ( `client-truststore.jks` ) in the STS (e.g., WSO2 API Manager).

6.  Create and publish an API.

    !!! note
        This step is only required if you do not already have an existing API.

    For this example, let's skip this step and use the [Petstore OpenAPI](https://github.com/wso2/product-microgateway/blob/master/samples/petstore_basic.yaml).

7.  Initialize an API Microgateway project (e.g., `petstore` ).

    ```sh tab="Format"
    micro-gw init <project-name>
    ```

    ```sh tab="Example"
    micro-gw init petstore
    ```

    ```text tab="Sample Response"
    Project 'petstore' is initialized successfully.
    ```

8.  Build the WSO2 API Microgateway project (e.g., petstore).

    1.  Add an API or multiple APIs to the project.
        Navigate to the `/petstore/api_definitions` directory. Add the API definition(s) to this directory. For this example, let's add the [petstore](https://github.com/wso2/product-microgateway/blob/master/samples/petstore_basic.yaml) open API definition.
    2.  Navigate to the `<MGW_HOME>/bin` directory and run the following command.

        ```sh tab="Format"
        micro-gw build <project-name>
        ```

        ```sh tab="Example"
        micro-gw build petstore
        ```

        ```text tab="Sample Response"
        Generating sources...[DONE]
        Compiling source
          wso2/petstore:3.2.0


        Creating balos
          target/balo/petstore-2020r1-java8-3.2.0.balo

        Running Tests

          wso2/petstore:3.2.0
          No tests found


        Generating executables
          target/bin/petstore.jar

        BUILD SUCCESSFUL
        Target: <PROJECT_LOCATION>petstore/target/petstore.jar
        ```

        This creates an executable file (`/petstore/target/petstore.jar `) that you can use to expose the API via WSO2 API Microgateway.

9.  Start WSO2 API Microgateway.

    ```sh tab="Format"
    gateway <path-to-MGW-executable-file>
    ```

    ```sh tab="Example"
    gateway /Users/kim/Downloads/TestProj/petstore/target/petstore.jar
    ```

    ```text tab="Sample Response"
    INFO  [wso2/gateway/src/gateway/utils] - [TokenRevocationJMS] [-] subscriber service for token revocation is started
    [ballerina/http] started HTTPS/WSS listener 0.0.0.0:9096
    [ballerina/http] started HTTP/WS listener 0.0.0.0:9090
    INFO  [wso2/gateway/src/gateway/utils] - [APIGatewayListener] [-] HTTP listener is active on port 9090
    [ballerina/http] started HTTPS/WSS listener 0.0.0.0:9095
    INFO  [wso2/gateway/src/gateway/utils] - [APIGatewayListener] [-] HTTPS listener is active on port 9095
    INFO  [wso2/gateway/src/gateway/utils] - [RevokedJwtRetrievalTask] [-] Revoked jwt retrieval successful. Stopping the timer task ...
    INFO  [wso2/gateway/src/gateway/utils] - [RevokedJwtRetrievalTask] [-] Revoked jwt retrieval task stopped successfully
    ```

10. Test the synchronization process of token revocation.

    1. Send the revoke request using the extracted jti as the token.

        ```sh tab="Format"
        curl -k -v -d "token=<jti>" -H "Authorization: Basic <base64-encoded-string>" -H "Content-Type: application/x-www-form-urlencoded" https://localhost:8243/revoke 
        ```

        ```sh tab="Example"
        curl -k -v -d "token=1e41eb69-b134-4158-ba16-9449ecaa2b3b" -H "Authorization: Basic U01OYVM0Tkg1UlJKSFJONDVoSzcxWElVbXdNYTo4ajRqTHFBUDZDNjNSTkFTVTdMZDEyeVUxbHNh" -H "Content-Type: application/x-www-form-urlencoded" https://localhost:8243/revoke 
        ```

        - `<jti>` - Enter the JWT ID (jti) that corresponds to the JWT token, which you obtained in [step 3](#step-3) , that you want to revoke.
        - `<base64-encoded-string>` - Use a base64 encoder (e.g., <https://www.base64encode.org/> ) to encode your client ID and client secret using the following format: `<clientId>:<clientSecret>` Thereafter, enter the encoded value for this parameter.

        The following response can be seen via the WSO2 API Microgateway console.

        ```text tab="Sample Response"
        2019-06-14 17:20:45,636 DEBUG [wso2/gateway] - [TokenRevocationJMS] [-] token revoked jms Message Received
        2019-06-14 17:20:45,638 DEBUG [wso2/gateway] - [TokenRevocationJMS] [-] Successfully added to revoked token map
        ```

    2. Use the revoked JWT token to send a request to WSO2 API Microgateway.

        ```sh tab="Format"
        curl -k -i -H "Authorization: Bearer <JWT-token>" https://localhost:9095/petstore/v1/pet/findByStatus?status=available
        ```

        ```sh tab="Example"
        curl -k -i -H "Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsIng1dCI6Ik5UQXhabU14TkRNeVpEZzNNVFUxWkdNME16RXpPREpoWldJNE5ETmxaRFUxT0dGa05qRmlNUT09In0=.eyJhdWQiOiJodHRwOlwvXC9vcmcud3NvMi5hcGltZ3RcL2dhdGV3YXkiLCJzdWIiOiJhZG1pbiIsImFwcGxpY2F0aW9uIjp7Im93bmVyIjoiYWRtaW4iLCJ0aWVyIjoiVW5saW1pdGVkIiwibmFtZSI6Ikp3dFRlc3QiLCJpZCI6Mn0sInNjb3BlIjoiYW1fYXBwbGljYXRpb25fc2NvcGUgZGVmYXVsdCIsImlzcyI6Imh0dHBzOlwvXC9sb2NhbGhvc3Q6OTQ0M1wvb2F1dGgyXC90b2tlbiIsImtleXR5cGUiOiJQUk9EVUNUSU9OIiwic3Vic2NyaWJlZEFQSXMiOltdLCJjb25zdW1lcktleSI6IkpGTjJiRkJyVzdJR2NBaVoydWVkUzM2UjdBY2EiLCJleHAiOjE1NjA1MTY1ODUsImlhdCI6MTU2MDUxMjk4NSwianRpIjoiM2FkNTY3MmEtYWZjYS00Mzg3LTllYzUtZmNmMjg3ODVmODAzIn0=.NVez5rLf2H05AeuAnelDSiDSqj0VwD8A-KtOKr3GxxnelpTM14iyk_k9uyGdsHQ50t9uemowwTCTR2FRo6aOVg3o-RBHzQx2BQEa0VH6JNN83KS0ySkIxjTbNVyCHbFMgFpK0xnhoJyZwnGYYbozwHv2MTJXKdMBose-PclIAgoqNFWDJfYD1YWkdKzeH7QSYnVl6cJWo562PER9a141ydL1jh0snz8QEGKA25PmuvkZ33ydnXSlV1PIBNiHSWL-gTlCmapcPpRqJ8gG8Ld_BGg5QHvqx8YQRTT9p_AHOrhXm-i02IKxYT0zBs6f6y9YDo3F6OeWdmDzItJu14xeqA==" https://localhost:9095/petstore/v1/pet/findByStatus?status=available
        ```

        Response in the Microgateway Console.

        ```text tab="Sample Response"
        2019-06-14 17:25:27,711 DEBUG [wso2/gateway] - [AuthnFilter] [-] Non-OAuth token found. Calling the auth scheme : jwt
        2019-06-14 17:25:27,711 DEBUG [wso2/gateway] - [AuthnFilter] [-] Processing request with the Authentication handler chain
        2019-06-14 17:25:27,712 DEBUG [ballerina/http] - Trying to authenticate with the auth provider: jwt
        2019-06-14 17:25:27,780 DEBUG [ballerina/auth] - Add authenticated user :admin to the cache
        2019-06-14 17:25:27,781 DEBUG [wso2/gateway] - [JWTAuthProvider] [-] jwt found from the jwt cache
        2019-06-14 17:25:27,781 DEBUG [wso2/gateway] - [JWTAuthProvider] [-] jti claim found in the jwt
        2019-06-14 17:25:27,782 DEBUG [wso2/gateway] - [JWTAuthProvider] [-] Checking for the JTI in the gateway invalid revoked token map.
        2019-06-14 17:25:27,782 DEBUG [wso2/gateway] - [JWTAuthProvider] [-] JTI token found in the invalid token map.
        2019-06-14 17:25:27,782 DEBUG [wso2/gateway] - [JWTAuthProvider] [-] JWT Authentication Handler returned with value : false
        2019-06-14 17:25:27,783 DEBUG [wso2/gateway] - [JWTAuthProvider] [-] JWT Token is revoked
        2019-06-14 17:25:27,783 DEBUG [wso2/gateway] - [AuthnFilter] [-] Authentication handler chain returned with value : false
        2019-06-14 17:25:27,784 DEBUG [wso2/gateway] - [AuthnFilter] [-] Removed header : Authorization from the request
        ```

        Response in the STS (e.g., WSO2 API Manager).

        ```text
        HTTP/1.1 401 Unauthorized
        content-type: application/json
        content-length: 146
        server: ballerina/0.990.5
        date: Fri, 14 Jun 2019 17:25:27 +0530

        {"fault":{"code":900901, "message":"Invalid Credentials", "description":"Invalid Credentials. Make sure you have given the correct access token"}}
        ```
