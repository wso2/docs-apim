# Add Custom Filters
Filters is a set of execution points in the request flow that intercept the request before it goes to the 
backend service. They are engaged while the request is processed within the enforcer. The defined set of filters 
are applied to all the APIs deployed in the Choreo-Connect. And these filters are engaged inline and if the request 
fails at a certain filter, the request will not be forwarded to the next filter and the backend. 
The inbuilt set of filters are the authentication filter and the throttling filter.

Custom filters can be added to the existing filters within enforcer, and they can be positioned as the end user wish.
These filters would be engaged for all the APIs deployed within Choreo-Connect. 

Choreo-Connect provides a java interface to implement custom filters. Then the developer needs to compile the 
filter implementation as a jar file and mount it to the `/home/wso2/lib/dropins` directory within enforcer. When
the enforcer starts, the jar files in that directory would be added to the classpath. Using Java Service Provider
Interface, the classloading happens in enforcer. Further details on how to implement, can be found below.
 
## How to add a custom filter

1. Create a java project with `org.wso2.choreo.connect.enforcer.commons` dependency. 
   - For maven,
   ```xml
   <dependency>
       <groupId>org.wso2.am.choreo.connect</groupId>
       <artifactId>org.wso2.choreo.connect.enforcer.commons</artifactId>
       <version>1.0.0</version>
   </dependency>
   ```

2. Use the following interface to implement custom filter.

    ```java
    package org.wso2.choreo.connect.enforcer.commons;
    
    import org.wso2.choreo.connect.enforcer.commons.model.APIConfig;
    import org.wso2.choreo.connect.enforcer.commons.model.RequestContext;
    
    import java.util.Map;
    
    /**
        * Filters are the request interceptors that applies API Management capabilities at the gateway layer. This is the
        * Interface to implement chain of filters at the gateway.
        */
    public interface Filter {
    
        default void init(APIConfig apiConfig, Map<String, String> configProperties){};
    
        boolean handleRequest(RequestContext requestContext);
    }
    ```

    Here is the sample filter implementation which reads the property called `CustomProperty` from Filter 
    Configuration and add it as a header to the request.

    ```java
    package org.example.tests;
    
    import org.wso2.choreo.connect.enforcer.commons.model.APIConfig;
    import org.wso2.choreo.connect.enforcer.commons.model.RequestContext;
    import org.wso2.choreo.connect.enforcer.commons.Filter;
    
    import java.util.Map;
    
    public class CustomFilter implements Filter {
        private static final Logger log = LoggerFactory.getLogger(CustomFilter.class);
        private Map<String, String> configProperties;
    
        @Override
        public void init(APIConfig apiConfig, Map<String, String> configProperties) {
            this.configProperties = configProperties;
        }
    
        @Override
        public boolean handleRequest(RequestContext requestContext) {
            String headerValue = configProperties.get("CustomProperty");
            requestContext.addOrModifyHeaders("Custom-header-1", headerValue);
            return true;
        }
    }
    ```

3. Since we use JAVA SPI (Service Provider Interface), We need to provide the provider configuration file 
`META-INF/services/org.wso2.choreo.connect.enforcer.commons.Filter`. If you are using maven, create the file this
file inside the <Project>/src/main/resources directory. The content of the file needs to be the qualified class name
of the filter implementation.

    ```
    org.example.tests.CustomFilter
    ```

4. Build the project and create the jar.

5. Edit the enforcer related configuration within config.toml file to include the custom filter. The classname needs to
be the fully qualified className. The position denotes the final filter position in the chain, when all the filters 
are added. By default, the first position is taken by Authentication Filter and the Thorttle Filter is placed as the 
second filter. As the below example configuration contains `1` as the Position, it would be executed prior to 
the Authentication Filter.

    ```toml
    [[enforcer.filters]]
        # ClassName of the filter
        className = "org.example.tests.CustomFilter"
        # Position of the filter within final filter-chain
        position = 3
        # Custom Configurations
        [enforcer.filters.configProperties]
            CustomProperty = "foo"
    ```

6. The mount the jar file containing Custom Filter to the `/home/wso2/lib/dropins`. (If you are using docker-compose 
file within the distribution, then add the jar file to 
`docker-compose/resources/enforcer/dropins` directory.)

7. Deploy the choreo-connect distribution and the filter would be engaged in Runtime.
