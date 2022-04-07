# Adding a Non-Blocking Send Operation

In this example, the Send mediator in a proxy service using the VFS transport is transferring a file to a VFS endpoint. 

**VFS** is a non-blocking transport by default, which means a new thread is spawned for each outgoing message. The `Property` mediator added before the `Send` mediator removes the `ClientAPINonBlocking` property from the message to perform the mediation in a single thread. This is required when the file being transferred is large and you want to avoid out-of-memory failures.

!!! example
    ```xml
    <inSequence>
       <property name="ClientApiNonBlocking"
               value="true"
               scope="axis2"
               action="remove"/>
       <send>
          <endpoint name="FileEpr">
             <address uri="vfs:file:////home/shammi/file-out"/>
          </endpoint>
       </send>
    </inSequence>
    ```