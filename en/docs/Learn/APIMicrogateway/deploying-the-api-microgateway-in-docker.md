# Deploying the API Microgateway in Docker

!!! tip
Before you begin, make sure you have downloaded the following:

-   [WSO2 API Manager](https://wso2.com/api-management/)
-   [WSO2 Microgateway ToolKit](https://wso2.com/api-management/api-microgateway/)


1.  Start the API Manager and log in to the API Publisher ( `https://<hostname>:9443/publisher` ) using `admin` as the username and password.
2.  Create and [publish an API](https://docs.wso2.com/display/AM250/Create+and+Publish+an+API) (e.g. `Petstore` ).
3.  Log in to the API Store and create an application that supports [JWT tokens](https://docs.wso2.com/display/AM260/Microgateway+Quick+Start#MicrogatewayQuickStart-GenerateaJWTtokenandinvoketheAPI) .

4.  [Subscribe](https://docs.wso2.com/display/AM260/Subscribe+to+an+API) to the `Petstore` API and generate a JWT token to invoke the API.

5.  Create a `deployment.toml` file containing the relevant deployment configurations such as docker image name, registry, tag, etc. as shown below.

    ``` java
        [docker]
          [docker.dockerConfig]
            enable = true
            name = "Petstore"
            registry = 'docker.wso2.com'
            tag = 'v1'
            #buildImage = ''
            #dockerHost = ''
            #dockerCertPath = ''
            #baseImage = ''
            #enableDebug = ''
            #debugPort = ''
            #push = ''
            #username = ''
            #password = ''
          [docker.dockerCopyFiles]
            enable = true
            [[docker.dockerCopyFiles.files]]
                source = '<MICROGW_TOOLKIT_HOME>/resources/conf/micro-gw.conf'
                target = '/home/ballerina/conf/micro-gw.conf'
                isBallerinaConf = true
    ```

6.  Copy the `micro-gw.conf` file to the docker image as it contains the key manager configurations, JWT configurations, etc. This can be done by enabling the docker copy files configuration as shown above.
    Let’s create a project called `petstore_project` and provide the `deployment.toml` file as an input.
7.  Navigate to the `<MICROGW_TOOLKIT_HOME>/bin` directory and run the following command,

    ``` java
            ./micro-gw setup <project_name> -a <API_name> -v <version> --deployment-config deployment.toml
    ```

    For example,

    ``` java
            ./micro-gw setup petstore-project -a petstore -v 1.0.0 --deployment-config deployment.toml
    ```

    This commands creates the following folders under the `petstore_project` folder.

`├── petstore_project          `

`│   ├── conf          `

`│   │ └── deployment-config.toml          `

`│   ├── src          `

`│   │ ├── extension_filter.bal          `

`│   │ ├── petstore.bal          `

`│   │ ├── listeners.bal          `

`│   │ └── policies          `

`│   │    ├── application_10PerMin.bal          `

`│   │    ├── application_20PerMin.bal          `

`│   │    ├── application_50PerMin.bal          `

`│   │    ├── subscription_Bronze.bal          `

`│   │    ├── subscription_Gold.bal          `

`│   │    ├── subscription_Silver.bal          `

`│   │    ├── subscription_Unauthenticated.bal          `

`│   │    └── throttle_policy_initializer.bal          `

`│   ├── target          `

`│   └── temp          `

`│       └── hashes.json          `

`└── test.toml          `

8.  Build the project using the following command,

    ``` java
            ./micro-gw build <project_name>
    ```

    The docker image is created in your local registry and can be used to spawn an API Microgateway docker container.

9.  Run the docker container using the following command,

    ``` java
            docker run -d docker.wso2.com/<API_name>:<version>
    ```

        !!! info
    If you are working in a Mac environment, start the docker container with the following command to bind the docker container ports to the localhost or the docker host machine:

    ``` java
        docker run -d -p 9090:9090 -p 9095:9095 docker.wso2.com/<API_name>:<version>
    ```

    If you are working in a Linux environment, you can also start the docker container using the host network driver for your container as follows:

    ``` java
            docker run --network host -d docker.wso2.com/<api_name>:<version>
    ```

    For more information on working with Docker in different environments, see the relevant Docker documentation: [Docker for Mac](https://docs.docker.com/docker-for-mac/) , [Docker for Windows](https://docs.docker.com/docker-for-windows/) .

        !!! warning
    If you are working in a Mac environment, skip step 10.


10. Retrieve the docker container IP address as follows,

    ``` java
        docker ps - This provides the container id
        docker inspect <Container_ID> | grep "IPAddress"
    ```

11. Using a REST client or a cURL command, access the API using the following details:

        !!! note
    If you are working in a Mac environment, the URL is `https://<localhost>:9095/<API_name>/<version>/check` .


    URL - `https://<Container_IP>:9095/<API_name>/<version>/check `

    Headers - `Authorization Bearer <JWT_TOKEN> `

    Method - `GET`

!!! tip
As JWT is a self-contained access token, the Microgateway does not need to connect to the Key Manager. However, if you are using an Oauth2 access token, point the Microgateway to the Key Manager using the Key Manager details in the `micro-gw.conf` configuration file of the Microgateway. You can provide the Key Manager `serverUrl` as shown below. The `serverUrl` has to be accessible from the Microgateway.

``` java
    [keyManager]
    serverUrl="https://localhost:9443"
    username="admin"
    password="admin"
    tokenContext="oauth2"
    timestampSkew=5000
```


