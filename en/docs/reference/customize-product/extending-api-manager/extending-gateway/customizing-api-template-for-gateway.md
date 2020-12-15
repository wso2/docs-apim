# Customizing API Template

When an API is [published]({base_path}/learn/design-api/publish-api/publish-an-api/), corresponding synapse configuration of the API is generated and deployed in `<APIM_HOME>repository/deployment/server/synapse-configs/default/api/` location of the gateway in `<provider_name>--<API_name>_v<API_version>.xml` file format(eg: admin--PizzaShackAPI_v1.0.0.xml). 
 
An API's gateway configuration file(Synapse configuration) content contains API metadata, API resource information, properties etc and it is generated based on the API template file which can be found in `<APIM_HOME>/repository/resources/api_templates/velocity_template.xml` location. You can modify the default API template definition in order to customize the synapse configurations of the APIs that are being deployed to gateway.

## Engaging a custom handler based on API Properties

In API Manager, you can implement and engage custom handlers to customize the default mediation flow of API requests. See [Writing a custom handler]() for more information. The [API properties]({base_path}/learn/design-api/create-api/adding-custom-properties-to-apis/) can be used to conditionally engage these custom handlers for APIs.

Following steps illustrate how you can enable a custom handler for a selected set of APIs which are having a particular property value. 

1.  Open `<APIM_HOME>/repository/resources/api_templates/velocity_template.xml` file and locate the `handlers` definition.

2.  Add following definition to engage the custom handler.

    In this example, `org.wso2.apimgt.custom.CustomAPIAuthenticationHandler` will be engaged as the custom handler for APIs which are having `custom_authentication` property value.
    
    **Example 1** - Engaging as a new handler

    ```
    <handlers xmlns="http://ws.apache.org/ns/synapse">
    
     ##Engage the Custom handler based on 'custom_authentication' propert value
     #if($apiObj.additionalProperties.get('custom_authentication') == "true"))
       <handler class="org.wso2.apimgt.custom.CustomAPIAuthenticationHandler"/>
     #end
     
    #foreach($handler in $handlers)
    <handler xmlns="http://ws.apache.org/ns/synapse" class="$handler.className">
        #if($handler.hasProperties())
        #set ($map = $handler.getProperties() )
        #foreach($property in $map.entrySet())
        <property name="$!property.key" value="$!property.value"/>
        #end
        #end
    </handler>
    #end
    ## check and set enable schema validation
    #if($enableSchemaValidation)
    <handler class="org.wso2.carbon.apimgt.gateway.handlers.security.SchemaValidator"/>
    #end
    </handlers>
    ```

    **Example 2** - Switching the custom handler with one of the default handlers
    
    ```
    <handlers xmlns="http://ws.apache.org/ns/synapse">
    #foreach($handler in $handlers)
    
    ##Switch the custom handler with default authentication handler for APIs which are having `custom_authentication=true` property 
            #if(($handler.className =="org.wso2.carbon.apimgt.gateway.handlers.security.APIAuthenticationHandler") && ($apiObj.additionalProperties.get('custom_authentication') == "true"))
                            <handler class="org.wso2.apimgt.custom.CustomAPIAuthenticationHandler"/>
            #else
                    <handler xmlns="http://ws.apache.org/ns/synapse" class="$handler.className">
                            #if($handler.hasProperties())
                            #set ($map = $handler.getProperties() )
                            #foreach($property in $map.entrySet())
                            <property name="$!property.key" value="$!property.value"/>
                            #end
                            #end
                    </handler>
            #end
    #end
    </handlers>
    ```
        
    Likewise, you can implement the logic to conditionally enable/disable custom or default handlers.
    
    !!!Info
    
        If you are using a [distributed API Manager deployment]({base_path}/install-and-setup/deploying-wso2-api-manager/distributed-deployment/understanding-the-distributed-deployment-of-wso2-api-m/) (i.e., Publisher, Devportal, Gateway and Key Manager components are running on separate JVMs), edit the template in the Publisher node. 
     
 3. Save the changes.
 
 4. Add `custom_authentication=true` as an [additional property]({base_path}/learn/design-api/create-api/adding-custom-properties-to-apis/) for those APIs which you need to enable the custom handler.
 
    <a href="{{base_path}}/assets/img/develop/extensions/custom_properties.png" ><img src="{{base_path}}/assets/img/develop/extensions/custom_properties.png" alt="Add Custom Property" 
           title="Add Custom Property" width="80%" /></a>
           
5.  Publish the API to gateway, and you will notice that the custom handler has been enabled for APIs which are configured with the custom property.

    ```xml
    <handlers>
            <handler class="org.wso2.apimgt.custom.CustomAPIAuthenticationHandler"/>
            ....
    </handlers>   
    ```

## API Template Variables

Following set of variables are available at API template level. You can use these variable values to implement your own customization logic.

<table>
    <thead>
    <tr class="header">
    <th>Variable Name</th>
    <th>Description</th>
    </tr>
    </thead>
    <tbody>
    <tr class="odd">
        <td>apiName</td>
        <td>Name of the API</td>
    </tr>
    <tr class="odd">
        <td>apiVersion</td>
        <td>The version of the API</td>
    </tr>
    <tr class="odd">
        <td>apiContext</td>
        <td>The context of the API</td>
    </tr>  
    <tr class="odd">
        <td>apiIsBlocked</td>
        <td>Is API blocked or not</td>
    </tr>  
    <tr class="odd">
        <td>endpoint_config</td>
        <td>API Endpoint configuration in json</td>
    </tr>   
    <tr class="odd">
        <td>handlers</td>
        <td>The default handler set</td>
    </tr> 
    </tbody>
    </table>
