# Service Discovery

When you create an API Microgateway, the API Microgateway is capable of routing traffic to the URL of the API that you provide at the time of creating an API. The micro services have dynamic URLs. As the API Microgateway is immutable, the dynamic URL changes will not get reflected on the Microgateway. Therefore, in such a scenario you need to stop the Microgateway and restart it by providing the new URL. However, as the latter mentioned scenario is not practical in a real-world scenario, the API Microgateway is integrated with [etcd](https://github.com/etcd-io/etcd) for the purpose of discovering the target endpoints in order to route API traffic.

!!! info
    What is etcd?
    -   [etcd](https://github.com/etcd-io/etcd) is a distributed key-value store that provides a reliable way to store data across a cluster of machines.
    -   Each entry in the etcd is a key-value pair.
    Example:
    ``` java
    key - worldbank-key
    value - http://api.worldbank.org
    key - phoneverify  
    value - http://ws.cdyne.com/phoneverify/phoneverify.asmx
    ```

API Microgateway uses [etcd](https://github.com/etcd-io/etcd) to store a static key together with the corresponding dynamic value that represents the URL of the target endpoint. If the URL of the endpoint changes due to some reason, you need to update the etcd server by providing the new URL for the relevant key. Therefore, WSO2 API Microgateway should know the etcd key, which WSO2 API Microgateway uses to perform an etcd lookup, in order to obtain the correct URL that is needed to route the traffic.

### Enabling service discovery

Enable service discovery using etcd on WSO2 API Microgateway as follows:

1.  Make sure to install and set up all the [installation prerequisites]({{base_path}}/install-and-setup/install-on-vm/) .
2.  Configure and start the etcd server.
    
    1.  Download the [etcd distribution](https://github.com/etcd-io/etcd/releases) based on your OS and install it.
        
    2.  Start the etcd server.

        ``` java
        cd <etcd_HOME>
        etcd
        ```

        The following is a sample message that appears.

        ``` java
        2019-05-23 19:09:18.921356 I | embed: ready to serve client requests
        ```
        
    3.  Navigate to the `<etcd_HOME>` and put the endpoint URL to the etcd server using etcdctl tool, by executing the following command.
        
        ``` java tab="Format"
        etcdctl put <Key> <Value>        
        ``` 
          
        ``` java tab="Example"
        etcdctl put petstore http://petstore.swagger.io/v2/
        ```             

3.  Create an API Microgateway project (e.g., petstore-project).
    Navigate to a preferred folder where you want to create the Microgateway project, and then run the following command.


    ``` java tab="Format"
    micro-gw init <project-name>
    ```

    ``` java tab="Example"
    micro-gw init petstore-project
    ```

4.  Add the API definition with the etcd configurations in the `/petstore-project/api_definitions` directory.
    Let's copy the [sample open API definition](https://github.com/wso2/product-microgateway/blob/master/samples/petstore_basic.yaml) , define the etcd configurations, and add the API definition ( `petstore_basic.yaml` ) to the `api_definitions` folder.

    ``` java tab="Format"
    x-wso2-production-endpoints:
      urls:
        - etcd (<etcd_key>,<default_URL>)
    ```
    
    - `<etcd_key>` - The value of the key that you store in the etcd server for the purpose of mapping the endpoint URL.
    - `<default_URL>` - This is the URL that WSO2 API Microgateway redirects the requests to in the event it is unable to resolve the etcd key or/and is unable to find the etcd server.
    
    ``` java tab="Example"
    x-wso2-production-endpoints:
      urls:
        - etcd (petstore,https://www.example.com)
    ```

5.  Build the WSO2 API Microgateway project (e.g., petstore-project).

    ``` java tab="Format"
    micro-gw build <project-name>
    ```

    ``` java tab="Example"
    micro-gw build petstore-project
    ```

    This creates an executable file ( `/petstore-project/target/petstore-project.jar` ) that you can use to expose the API via WSO2 API Microgateway.

6.  Start WSO2 API Microgateway.
    

    ``` bash tab="Format"
    gateway <path-to-MGW-executable-jar-file> --etcdurl=<http-or-https-etcdurl> --etcdtimer=<etcd-timer> 
    ```
    
    ``` bash tab="Example - binary"
    gateway /Users/kim/Downloads/TestProj/petstore-project/target/petstore-project.jar --etcdurl=http://127.0.0.1:2379 --etcdtimer=10000
    ```
    
    ``` bash tab="Example - docker"
        docker run -d -p 9090:9090 -p 9095:9095 -e etcdurl=http://127.0.0.1:2379 -e etcdtimer=10000 docker.wso2.com/petstore:v1
    ```
    
    - `<etcd-url>` - Provide the etcd URL. If the etcd URL is secured (https), you need to add the etcd server certificate to the [Ballerina](https://ballerina.io/) truststore.

    - `<etcd-timer>` - This is the time period for the periodic timer task (in milliseconds). The default time period is 10 seconds. This parameter specifies the time interval for each periodic query to etcd; therefore, this value should be lower than the TTL of the token. etcd supports the following types of tokens.

        - **Simple tokens**  
            These tokens have a default time-to-live (TTL) of 5 minutes, but the TTL is configurable. In addition, the TTL refreshes each time a request goes to etcd.

            Example:
        If etcd is configured to use simple tokens with a TTL of 5 minutes, the `etcdTimer` parameter value should contain a value less than 5 minutes. If the etcdTimer value is 24000 (24000 ms = 4 minutes). Every 4 minutes the timer task is triggered, the etcd is queried, and it refreshes the TTL of the token.

        -   **JWT tokens**  
        This token does not have a TTL.
    

### Changing the API endpoint URL via etcd

For example, If the production endpoint URL changes and the corresponding etcd key is `etcddemoprod` , update the value related to the `etcddemoprod` key on the etcd server.
If the periodic timer task value is 10 seconds, within 10 seconds the periodic task gets executed and updates WSO2 API Microgateway with the new value. Thereby, in this scenario, if you are in the process of querying an API, WSO2 API Microgateway redirects your request to the new URL of the endpoint within 10 seconds.

Follow the instructions below to update the etcd with your new API endpoint URL:

   1.  Put the new endpoint URL for the corresponding key in the etcd server using the following command.
   
       ``` java tab="Format"
       etcdctl put <Key> <Value>
       ```
       
       ``` java tab="Example"
       etcdctl put petstore http://petstore.swagger.io/v2/
       ```

   2.  Invoke the API and requests will be directed to the new endpoint URL.
       
