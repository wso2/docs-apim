# admin\_Monitoring Message Flows

Message Flows provide graphical or textual views of the globally-engaged handlers in the system at a given time. This functionality is provided by the following feature:

**Name** : WSO2 Carbon - Message Flows Feature
**Identifier** : org.wso2.carbon.message.flows.feature.group

Modules use handlers to engage in different message flows at defined phases. You can observe the handlers invoked in each phase of each flow in real time. For example, the Apache/Rampart module defines handlers in the security phase of each flow, which handles the security aspects of the messages that are transferred through these flows. Therefore, if the Rampart module is engaged, you can see the Apache/Rampart handlers in the message flows in real time.

Follow the instructions below to access the Message Flows.

1.  Log in to the management console and select **Monitor -&gt; Message Flows** .
2.  The **Message Flows** page displays a graphical view of the message flows. There are four different flows defined in the system:
    1.  **In Flow** : A correct message coming into the system.
    2.  **Out Flow** : A correct message going out of the system.
    3.  **In Fault Flow** : A faulty message coming into the system.
    4.  **Out Fault Flow** : A faulty message going out of the system.
3.  In each flow, a message passes through a set of phases to reach the service. These phases vary according to the currently engaged modules within the system. The interface displays the current phases in each and every flow as shown in the diagram below.
    ![](/assets/attachments/126562874/126562875.png)
4.  In the graphical view of the message flows, click the links to get a view of the engaged handlers in each phase. For example, the figure below shows the handlers engaged in the Addressing phase at system start up.
    ![](/assets/attachments/126562874/126562880.png)
5.  You can see the text view of message flows by clicking **Show Text View** .
    ![](/assets/attachments/126562874/126562877.png)
6.  The page with the text view of message flows appears. The textual view provides the name and the fully qualified classes of all handlers within each and every phase.
    ![](/assets/attachments/126562874/126562878.png)

