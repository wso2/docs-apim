# admin\_Monitoring SOAP Messages

The SOAP Tracer provided by WSO2 is a tool that displays all the SOAP messages, including the message requests and responses that goes through your system, when serviced are invoked.

This functionality is provided by the following feature:

**Name** : WSO2 Carbon - SOAP Tracer Feature
**Identifier** : org.wso2.carbon.soaptracer.feature.group

!!! info
Note that by default this feature is turned off. You have to enable tracing when you use it as explained in the following section. Turning on the **SOAP Tracer** feature may impose a significant performance overhead. This is because all the SOAP messages will always be completely built (deferred building will not be done) and stored in the database by WSO2 Data Services. Hence this option should be used with caution.


### Enabling the SOAP Tracer

Follow the instructions below to access the SOAP Tracer.

1.  Log in to the management console and select **Monitor -&gt; SOAP Tracer** .
    ![](attachments/126562899/126562902.png)
2.  In the drop-down menu, select **Yes** .
    ![](attachments/126562899/126562905.png)
3.  The tracer will show the messages of the operations that were invoked. For example,
    ![](attachments/126562899/126562901.png)
    By using the SOAP Tracer, you can see the SOAP messages with their time-stamps, service name, operation invoked and the number of requests to the server. The most recent SOAP messages are listed at the top. When a particular SOAP message is selected, its "Request" and "Response" can be viewed.

        !!! info
    Note

    This tracer does not apply to operations invoked in the admin services. They are filtered out.


4.  If you want to find a message, fill in the Filter field with a word (or a part of word) in the message and click **Search** .
    ![](attachments/126562899/126562904.png)
5.  You will see the message in the **Messages** list and its full description will be shown in the **Request** or **Response** text area. For example,
    ![](attachments/126562899/126562900.png)

