
Follow the instructions below to enable publishing the AsyncAPI definition to the service catalog in WSO2 API Manager:

1. Configure the API Manager port.

     You have to define the port to which the Streaming Integrator publishes the AsyncAPI definition.

     1. Open the `<API-M_HOME>/repository/conf/deployment.toml` file.

     2. Uncomment `offset` in the `[server]` section and set it to `5` as shown below.

         ```
         [server]
         offset=5
         ```
   
2. Configure the basic details needed to publish to the service catalog.

     1. Open the `<SI_HOME>/conf/server/deployment.yaml` file. 
     
     2. Update the `service.catalog.configs:` section as follows:

        ```
        service.catalog.configs:
            enabled: true
            hostname: localhost
            port: 9448
            username: admin
            password: admin
        ```
         In the above configuration -
         
           - You are enabling the AsyncAPI generation functionality by setting the `enabled` parameter to `true`. 
            
           - You are specifying `9448` as the port because you configured a port offset of 5 in the previous step. The default port of the API Manager is `9443`.
