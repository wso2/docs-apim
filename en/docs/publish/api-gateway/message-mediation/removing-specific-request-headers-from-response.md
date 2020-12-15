# Removing Specific Request Headers From Response

Web services may contain response headers with sensitive information. The following explains how to remove HTTP request headers from the responses for security reasons.

To remove request headers from responses for per API or globally, add the name of the header to be removed as a property in your custom `out` sequence.
  
!!! example
    ``` bash tab="Template"
    <property name="<name of the header to be removed>" scope="transport" action="remove"/>
    ```

    ``` bash tab="Sample"
    <property name="CustomTransportHeader" scope="transport" action="remove"/>
    ```
Check out [Changing the Default Mediation Flow of API Requests]({{base_path}}/learn/api-gateway/message-mediation/changing-the-default-mediation-flow-of-api-requests) to learn on how to
add the above mediation policy per API or globally.

## Handling Error Responses

To handle error responses, follow the instructions below. 

1.  To address the scenario where the API does not exist, open the `<API-M_HOME>/repository/deployment/server/synapse-configs/default/sequences/main.xml` file.
3.  Add the name of the header to be removed as a property, just before the beginning of `send` mediator, as shown below.
    
    !!! example

        ``` bash tab="Template"
        <property name="<name of the header to be removed>" scope="transport" action="remove"/>
        <send/>
        ```

        ``` bash tab="Sample"
        <property name="Accept" scope="transport" action="remove"/>
        <property name="X-JWT-Assertion" scope="transport" action="remove"/>
        <property name="Cookie" scope="transport" action="remove"/> 
        <send/>
        ```

4.  To address the scenario where an error occurs during execution of API requests, open the `<API-M_HOME>/repository/deployment/server/synapse-configs/default/sequences/fault.xml` file.
5.  Add the name of the header to be removed as a property property, just before the beginning of `CORS Request Handler` sequence, as shown below.

    !!! example

        ``` bash tab="Template"
        <property name="<name of the header to be removed>" scope="transport" action="remove"/>
        <sequence key="_cors_request_handler_"/>
        ```

        ``` bash tab="Sample"
        <property name="Accept" scope="transport" action="remove"/>
        <property name="X-JWT-Assertion" scope="transport" action="remove"/>
        <property name="Cookie" scope="transport" action="remove"/>
        <sequence key="_cors_request_handler_"/>
        ```
          

!!! note
    The above method removes only the specified headers from the response. If you need to remove all the headers, follow the instructions below.

    1.  Open the `<API-M_HOME>/repository/deployment/server/synapse-configs/default/sequences/main.xml` file.

    2.  Add the `TRANSPORT_HEADERS` property, after the beginning of the `<out>` sequence opening tag, as shown in the example below.

        !!! example

            ``` xml
            <out>
            <property name="TRANSPORT_HEADERS" action="remove" scope="axis2"/>
            ```

    3.  Open the `<API-M_HOME>/repository/deployment/server/synapse-configs/default/sequences/fault.xml` file.
    4.  Add the `TRANSPORT_HEADERS` property before the `<send>` mediator, as shown in the example below.

        !!! example

            ``` xml
            <property name="TRANSPORT_HEADERS" action="remove" scope="axis2"/>
            <send/>
            ```
