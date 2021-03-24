# Enabling distributed throttling

<!---TODO:@VirajSalaka Add concept page and mention it here--->
<!---TODO:@VirajSalaka Update image (old) and add to concept page--->

1.  Let's create a microgateway project.

    Create a project using the command given below.
  
    ``` java tab="Format"
    micro-gw init <project_name>
    ```

    ``` java tab="Example"
    micro-gw init petstore
    ```

    ```text tab="Response"
    Project 'petstore' is initialized successfully.
    ```

2.  Add the API definition(s) to `petstore/api_definitions` directory. A sample open API definition can be found [here](https://github.com/wso2/product-microgateway/blob/master/samples/petstore_basic.yaml). Then provide the API throttling tier using the following extension at the API level.
    
    ```yaml tab="Sample"
    x-wso2-throttling-tier : "5PerMin"    
    ```
    
3.  Create and deploy the throttling policy in the Traffic Manager. For this example you should deploy "5PerMin" policy in Traffic Manager.
    You can define following throttling policies:
    -   Advanced policies
    -   Application policies
    -   Subscription policies
    
    The relevant documentation can be found [here](https://apim.docs.wso2.com/en/latest/learn/rate-limiting/adding-new-throttling-policies/).

4.  Build the microgateway distribution for the project using the following command:

    ``` java tab="Format"
    micro-gw build <project_name>
    ```

    ``` java tab="Example"
    micro-gw build petstore
    ```

    ``` java tab="Response"
    BUILD SUCCESSFUL
    Target: /Users/praminda/Documents/workspace/mgw/320/rc2/petstore/target/petstore.jar
    ```

    Once the above command is executed, An executable file (`petstore/target/petstore.jar`) is created to expose the API via WSO2 API Microgateway

5.  Open `<MGW-RUNTIME-HOME>/conf/micro-gw.conf` file.

6.  Enable the `enabledGlobalTMEventPublishing` property found inside the `throttlingConfig` tag. This will allow the API Microgateway to connect with the central traffic manager.

    ``` toml
    [throttlingConfig]
      enabledGlobalTMEventPublishing=true
    ```

7.  In the "micro-gw.conf" file under \[throttlingConfig\]  configure the following. The purpose here is to configure 
    the message broker.

    <table>
      <thead>
        <tr>
          <th style="width: 30%">Property</th>
          <th style="width: 30%">Default Value</th>
          <th style="width: 40%">Description</th>
        </tr>
      </thead>
      <tbody>
        <tr>
        <td>`jmsConnectionProviderUrl`</td>
        <td>`amqp://admin:admin@carbon/carbon?brokerlist='tcp://localhost:5672'`</td>
        <td>The message broker connection URL of WSO2 API/Traffic Manager</td>
        </tr>
        <tr>
        <td>`jmsConnectionUsername`</td>
        <td>`""`</td>
        <td>The username used to establish the message broker connection</td>
        </tr>
        <tr>
        <td>`jmsConnectionPassword`</td>
        <td>`""`</td>
        <td>The password used to establish the message broker connection</td>
        </tr>
        </tbody>
    </table>
    
    The message broker connection URL. For e.g. a [WSO2 API instance can be used as the Traffic Manager]({{apim_path}}/install-and-setup/setup/distributed-deployment/product-profiles/). 
    In such an instance, the URL will point to the message broker inside the API Traffic Manager instance.
    In the `micro-gw.conf` file under `[throttlingConfig.binary]`, we should list down all the configurations related to
    event publishing.                   
        
    <table>
      <thead>
      <tr>
        <th style="width: 30%">Property</th>
        <th style="width: 30%">Default value</th>
        <th style="width: 40%">Description</th>
      </tr>
      </thead>
      <tbody>
        <tr>
          <td>`enabled`</td>
          <td>`true`</td>
          <td>Enable the binary event publisher. If it is `false`, http event publisher will be enabled</td>
        </tr>
        <tr>
          <td>`username`</td>
          <td>`"admin"`</td>
          <td>The user name used for authentication prior to publishing events via binary publisher</td>
        </tr>
        <tr>
          <td>`password`</td>
          <td>`"admin"`</td>
          <td>The password used for authentication prior to publishing events via binary publisher</td>
        </tr>
      </tbody>
    </table>
    
    The binary receiver URL(s) needs to be added as an Array using the key `[[throttlingConfig.binary.URLGroup]]`. 
    If multiple receivers are provided, the microgateway will publish events to all of them in parallel.
     
    <table>
      <thead>
      <tr>
        <th style="width: 30%">Property</th>
        <th style="width: 30%">Default value</th>
        <th style="width: 40%">Description</th>
      </tr>
      </thead>
      <tbody>
        <tr>
          <td>`receiverURL`</td>
          <td>`"tcp://localhost:9611"`</td>
          <td>The URL to which the thorttle events are sent.</td>
        </tr>
        <tr>
          <td>`authURL`</td>
          <td>`"ssl://localhost:9711"`</td>
          <td>The URL to which the credentials required for authentication, are sent.</td>
        </tr>
      </tbody>
    </table>

8.  If you are using API Manager 3.2.0 or later version, you need to configure the API Manager Eventhub. This step is 
    not required if you need to do only the resource level throttling or API level throttling.
    <!---TODO:@VirajSalaka Add the Event hub configuration guide URL--->
    
9.  Finally, the added configurations in `micro-gw.conf` would look like this. 
    
    ``` toml tab="Sample"
    [throttlingConfig]
      enabledGlobalTMEventPublishing=true
      jmsConnectionProviderUrl = "amqp://admin:admin@carbon/carbon?brokerlist='tcp://localhost:5672'"

      [throttlingConfig.binary]
        enabled = true
        username = "admin"
        password = "admin"
        [[throttlingConfig.binary.URLGroup]]
          receiverURL = "tcp://localhost:9611"
          authURL = "ssl://localhost:9711"
    
    [apim.eventHub]
      enable = true
      serviceUrl = "https://localhost:9443"
      internalDataContext="/internal/data/v1/"
      username="admin"
      password="admin"
      eventListeningEndpoints = "amqp://admin:admin@carbon/carbon?brokerlist='tcp://localhost:5672'"
    ```  
                                                                                                                                     
10.  Execute the following command to start WSO2 API Microgateway with new configurations.

    ```java tab="Format"
    gateway <path-to-executable-file>
    ```

    ```java tab="Example"
    gateway /Users/kim/petstore/target/petstore.jar
    ```

### Conditional throttling

There can be situations where certain APIs require more granular level of throttling. Assume you want to provide limited access to a certain IP range or a type of client application (identified by User-Agent header). For these scenarios, a simple throttle policy with API/resource level limits is not sufficient. To address complex throttling requirements as above, microgateway is capable of throttling requests based on several conditions. The following types of conditions are supported.

1.  Specific IP or IP range conditions.     
    This condition can be used to provide specific limits to a certain IP address or a range of IP addresses.

1.  Header conditions.      
    This condition can be used to set specific limits to a certain header value.

1.  Query parameter conditions.     
    Same as the header conditions, this allows applying a specific limit to a certain query parameter value.

1.  JWT claim conditions.       
    This type of condition will evaluate the [backend jwt]({{base_path}}/deploy/api-microgateway/passing-enduser-attributes-to-the-backend-using-jwt) and check if it has a specific claim value in it to set the throttle limit.

#### Configure and enable conditional throttling

1.  Open `micro-gw.conf` file in `<MGW_HOME>/conf` directory.
1.  Add/Enable below configurations to enable the required condition type.

    ```toml
    [throttlingConfig]
      enabledGlobalTMEventPublishing = true
      enableHeaderConditions = true
      enableQueryParamConditions = true
      enableJwtClaimConditions = true
    ```    

1.  Define the Advance Throttle Policy containing the required conditions in WSO2 API Manager. To do this follow [Adding a new advanced throttling policy]({{apim_path}}/design/rate-limiting/adding-new-throttling-policies/#adding-a-new-advanced-throttling-policy)
1.  Conditional throttle policies are an advanced set of API and Resource level policies. Therefore you need to define the required policy to apply in the OpenAPI definition. To do that, define `x-wso2-throttling-tier` extension with the Advance Throttle Policy name you defined in API Manager in the above step. This extension can be defined in both API and Resource levels.

    ```yaml tab="API level sample"
    x-wso2-basePath: /petstore/v1
    x-wso2-throttling-tier: IPPolicy
    x-wso2-production-endpoints:
      urls:
        - https://petstore.swagger.io/v2
    ```

    ```yaml tab="Resource level sample"
    paths:
      "/pet/findByStatus":
          get:
            summary: Finds Pets by status
            x-wso2-throttling-tier: 10kPerMin
    ```
