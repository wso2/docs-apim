# Adding a Non-Blocking Send Operation

In this example, the `Send` mediator in a proxy service using the VFS transport is transferring a file to a VFS endpoint. 

**VFS** is a non-blocking transport by default, which means a new thread is spawned for each outgoing message.

Let's create a new policy using the example provided below. Go ahead and create your own content by following the example and save it as a `.xml` file. Note that the `Property` mediator added before the `Send` mediator removes the `ClientAPINonBlocking` property from the message in order to perform the mediation in a single thread. This is required when the file being transferred is large and you want to avoid out-of-memory failures.

!!! example
    ```xml
    <sequence xmlns="http://ws.apache.org/ns/synapse" name="non-blocking-send">
      <property name="ClientApiNonBlocking"
               value="true"
               scope="axis2"
               action="remove"/>
      <send>
         <endpoint name="FileEpr">
            <address uri="vfs:file:////home/shammi/file-out"/>
         </endpoint>
      </send>
    </sequence>
    ```

Let's assume that the policy file that you created by considering the example above is `addNonBlockingSend.xml`. We will next create a policy using this policy file. You can refer to [Create a Policy]({{base_path}}/design/api-policies/create-policy/) to learn more about how to achieve this. When creating the policy, make sure to only select the `Request` flow when filling out the general details of the create policy form. Thus created policy can then be attached to the request flow of any API operation (refer [Attach Policies]({{base_path}}/design/api-policies/attach-policy/) for further details).
