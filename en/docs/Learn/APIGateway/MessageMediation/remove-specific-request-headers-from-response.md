# Remove Specific Request Headers From Response

Web services may contain response headers with sensitive information. This tutorial explains how to remove HTTP request headers from the responses for security reasons

1.  Shutdown the server if it is already running.
2.  Open the `<API-M_HOME>/repository/deployment/server/synapse-configs/default/sequences/main.xml` file.
3.  Add the name of the header to be removed as a property, just before the beginning of `send` mediator, as shown below

    -   [**Template**](#c81c738a8ed5426ab8f2eb542fade0f8)
    -   [**Example**](#d25ba8927c0741ed919825e4a434afd3)

    ``` java
        <property name="<name of the header to be removed>" scope="transport" action="remove"/>
    ```

    ``` java
            <property name="Accept" scope="transport" action="remove"/>
            <property name="X-JWT-Assertion" scope="transport" action="remove"/>
            <property name="Cookie" scope="transport" action="remove"/> 
            <send/>
    ```

4.  Open the `<APIM_HOME>/repository/deployment/server/synapse-configs/default/sequences/fault.xml` file.
5.  Add the name of the header to be removed as a property property, just before the beginning of "CORS request handler" sequence, as shown below.

    -   [**Template**](#0bbb42b0535c432d8050e3ab0e740ca5)
    -   [**Example**](#dd5df51769cf452cbeb4829b8bb33ac2)

    ``` java
            <property name="<name of the header to be removed>" scope="transport" action="remove"/>
    ```

    ``` java
            <property name="Accept" scope="transport" action="remove"/>
            <property name="X-JWT-Assertion" scope="transport" action="remove"/>
            <property name="Cookie" scope="transport" action="remove"/>
            <sequence key="_cors_request_handler_"/>
    ```

6.  Start the server.

!!! note
**Note :** The above method removes only the specified headers from the response. If you need to remove all the headers, follow the instructions below.
1.  Open the `<APIM_HOME>/repository/deployment/server/synapse-configs/default/sequences/main.xml` file.

2.  Add the `TRANSPORT_HEADERS` property, after the beginning of the `<out>` sequence opening tag, as shown in the example below.

    **Example**

    ``` java
        <out>
        <property name="TRANSPORT_HEADERS" action="remove" scope="axis2"/>
    ```

3.  Open the `<APIM_HOME>/repository/deployment/server/synapse-configs/default/sequences/fault.xml` file.
4.  Add the `TRANSPORT_HEADERS` property before the `<send>` mediator, as shown in the example below.

    **Example**

    ``` java
            <property name="TRANSPORT_HEADERS" action="remove" scope="axis2"/>
            <send/>
    ```


