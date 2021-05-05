# Configure Multiple Gateways with Choreo Connect

Choreo Connect supports the configuration of multiple gateways with APIM or stand-alone mode. Basically, there are two types of deployments to setup multiple gateways.

1. [Single adapter pattern](#single-adapter-pattern)
2. [Distributed adapter pattern](#distributed-adapter-pattern)

## Single adapter pattern

You can use single adapter pattern to expose multiple gateway environments through a single adapter.

![]({{base_path}}/assets/img/deploy/mgw/single-adapter-pattern.png)

## Distributed adapter pattern

You can use distributed adapter pattern to distribute the control of the environments to separate adapters.

![]({{base_path}}/assets/img/deploy/mgw/distributed-adapter-pattern.png)

## Configuration of environments

For instance, if you are configuring a single adapter for two environments "choreo-connect-1" and "choreo-connect-2" with APIM.

1. Add the environments to `environmentLabels` in `<CHOREO-CONNECT_HOME>/docker-compose/choreo-connect-with-apim/conf/config.toml` under `controlPlane`.

    ```toml
    [controlPlane]
      enabled = true
      serviceUrl = "https://apim:9443/"
      username="admin"
      password="$env{cp_admin_pwd}"
      environmentLabels = ["Default","choreo-connect-1","choreo-connect-2"]
    ```

2. Add the required router, adapter, enforcer instances to the `<CHOREO-CONNECT_HOME>/docker-compose/choreo-connect-with-apim/docker-compose.yaml` file with the desired ports. Following `docker-compose.yaml` file is an example for a single adapter pattern deployment. 

    ```yaml
    version: "2.4"
    services:
      apim:
        image: wso2/wso2am:4.0.0-alpine
        healthcheck:
          test: ["CMD", "nc", "-z","localhost", "9443"]
          interval: 10s
          retries: 50
        ports:
          - "9763:9763"
          - "9443:9443"
          - "5672:5672"
          - "8243:8243"
        volumes:
          - ./conf/deployment.toml:/home/wso2carbon/wso2am-4.0.0/repository/conf/deployment.toml
      router1:
        image: wso2/choreo-connect-router:0.9.0
        logging:
          options:
            max-size: "20m"
            max-file: "5"
        environment:
          - ROUTER_ADMIN_HOST=0.0.0.0
          - ROUTER_ADMIN_PORT=9000
          - ROUTER_CLUSTER=default_cluster
          - ROUTER_LABEL=choreo-connect-1
          - ROUTER_PRIVATE_KEY_PATH=/home/wso2/security/keystore/mg.key
          - ROUTER_PUBLIC_CERT_PATH=/home/wso2/security/keystore/mg.pem
          - ADAPTER_HOST=adapter
          - ADAPTER_PORT=18000
          - ADAPTER_CA_CERT_PATH=/home/wso2/security/truststore/mg.pem
          - ENFORCER_HOST=enforcer1
          - ENFORCER_PORT=8081
          - ENFORCER_CA_CERT_PATH=/home/wso2/security/truststore/mg.pem
        volumes:
          - ../resources/router/security:/home/wso2/security
        ports:
          - "9095:9095"
          - "9000:9000"
          - "9090:9090"
        links:
          - adapter
          - enforcer1
      router2:
        image: wso2/choreo-connect-router:0.9.0
        logging:
          options:
            max-size: "20m"
            max-file: "5"
        environment:
          - ROUTER_ADMIN_HOST=0.0.0.0
          - ROUTER_ADMIN_PORT=9000
          - ROUTER_CLUSTER=default_cluster
          - ROUTER_LABEL=choreo-connect-2
          - ROUTER_PRIVATE_KEY_PATH=/home/wso2/security/keystore/mg.key
          - ROUTER_PUBLIC_CERT_PATH=/home/wso2/security/keystore/mg.pem
          - ADAPTER_HOST=adapter
          - ADAPTER_PORT=18000
          - ADAPTER_CA_CERT_PATH=/home/wso2/security/truststore/mg.pem
          - ENFORCER_HOST=enforcer2
          - ENFORCER_PORT=8081
          - ENFORCER_CA_CERT_PATH=/home/wso2/security/truststore/mg.pem
        volumes:
          - ../resources/router/security:/home/wso2/security
        ports:
          - "9096:9095"
          - "9001:9000"
          - "9091:9090"
        links:
          - adapter
          - enforcer2
      adapter:
        image: wso2/choreo-connect-adapter:0.9.0
        logging:
          options:
            max-size: "20m"
            max-file: "5"
        depends_on:
          apim:
            condition: service_healthy
        volumes:
          - ../resources/adapter/security:/home/wso2/security
          - ./conf/log_config.toml:/home/wso2/conf/log_config.toml
          - ./conf/config.toml:/home/wso2/conf/config.toml
        environment:
          - ADAPTER_PRIVATE_KEY_PATH=/home/wso2/security/keystore/mg.key
          - ADAPTER_PUBLIC_CERT_PATH=/home/wso2/security/keystore/mg.pem
          - cp_admin_pwd=admin
          - adapter_admin_pwd=admin
        ports:
          - "18000:18000"
          - "9843:9843"
        links:
          - apim
      enforcer1:
        image: wso2/choreo-connect-enforcer:0.9.0
        logging:
          options:
            max-size: "20m"
            max-file: "5"
        volumes:
          - ../resources/enforcer/security:/home/wso2/security
          - ./conf/log4j2.properties:/home/wso2/conf/log4j2.properties
          - ../resources/enforcer/dropins:/home/wso2/lib/dropins
        links:
          - adapter
          - apim
        environment:
          - ENFORCER_PRIVATE_KEY_PATH=/home/wso2/security/keystore/mg.key
          - ENFORCER_PUBLIC_CERT_PATH=/home/wso2/security/keystore/mg.pem
          - TRUSTED_CA_CERTS_PATH=/home/wso2/security/truststore
          - ADAPTER_HOST_NAME=adapter
          - ADAPTER_HOST=adapter
          - ADAPTER_XDS_PORT=18000
          - ENFORCER_LABEL=choreo-connect-2
          - ENFORCER_REGION=UNKNOWN
          - XDS_MAX_MSG_SIZE=4194304
          - XDS_MAX_RETRIES=3
          - JAVA_OPTS=${JAVA_OPTS} -Dhttpclient.hostnameVerifier=AllowAll
          - apim_admin_pwd=admin
          - enforcer_admin_pwd=admin
          - tm_admin_pwd=admin
          - analytics_authURL=https://localhost:8080
          - analytics_authToken=
        ports:
          - "8081:8081"
      enforcer2:
        image: wso2/choreo-connect-enforcer:0.9.0
        logging:
          options:
            max-size: "20m"
            max-file: "5"
        volumes:
          - ../resources/enforcer/security:/home/wso2/security
          - ./conf/log4j2.properties:/home/wso2/conf/log4j2.properties
          - ../resources/enforcer/dropins:/home/wso2/lib/dropins
        links:
          - adapter
          - apim
        environment:
          - ENFORCER_PRIVATE_KEY_PATH=/home/wso2/security/keystore/mg.key
          - ENFORCER_PUBLIC_CERT_PATH=/home/wso2/security/keystore/mg.pem
          - TRUSTED_CA_CERTS_PATH=/home/wso2/security/truststore
          - ADAPTER_HOST_NAME=adapter
          - ADAPTER_HOST=adapter
          - ADAPTER_XDS_PORT=18000
          - ENFORCER_LABEL=choreo-connect-2
          - ENFORCER_REGION=UNKNOWN
          - XDS_MAX_MSG_SIZE=4194304
          - XDS_MAX_RETRIES=3
          - JAVA_OPTS=${JAVA_OPTS} -Dhttpclient.hostnameVerifier=AllowAll
          - apim_admin_pwd=admin
          - enforcer_admin_pwd=admin
          - tm_admin_pwd=admin
          - analytics_authURL=https://localhost:8080
          - analytics_authToken=
        ports:
          - "8082:8081"
    ```
    
    !!! note
        If you are configuring a distributed adapter deployment, you need to define the separate adapters along with the routers and the enforcers deployed in the same environment.

3. Start Choreo Connect deployment from docker-compose.

4. Add the gateway environments "choreo-connect-1" and "choreo-connect-2" from the Gateways in the APIM admin portal.

    ![]({{base_path}}/assets/img/deploy/mgw/add-gateway-environment.png)

5. Deploy the API on the defined gateway.