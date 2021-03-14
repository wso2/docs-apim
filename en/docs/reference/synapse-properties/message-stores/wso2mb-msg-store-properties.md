# WSO2 MB Message Store
## Introduction
WSO2 Message Broker is used as the <b>message store</b> for the Micro Integrator.

## Properties

The following properties can be configured when [creating a WSO2 MB Message Store]({{base_path}}/integrate/develop/creating-artifacts/creating-a-message-store.md).

<table>
   <thead>
      <tr>
         <th>
            <p>Parameter Name</p>
         </th>
         <th>
            <p>Description</p>
         </th>
      </tr>
   </thead>
   <tbody>
      <tr>
         <td>Message Store Name</td>
         <td>Give a unique name for the JMS message store.</td>
      </tr>
      <tr>
         <td>Message Store Type</td>
         <td>Select <strong>WSO2 MB Message Store</strong> from the list of options.</td>
      </tr>
      <tr>
         <td>Initial Context Factory</td>
         <td>This specifies the JNDI initial context factory class ( <code>             java.naming.factory.initial            </code> ). This class implements the implement the <code>             java.naming.spi.InitialContextFactory            </code> interface. The value is set to <code>             org.wso2.andes.jndi.PropertiesFileInitialContextFactory            </code> , by default.</td>
      </tr>
      <tr>
         <td>Queue Connection Factory</td>
         <td>
            <div class="content-wrapper">
               <p>This is the connection factory URlfor connecting to WSO2 MB. By default, the value is set to <code>               amqp://admin:admin@clientID/carbon?brokerlist='tcp://localhost:5673'              </code> .</p>
               <b>Important!</b>
               <p>Be sure to change the port to 5675.</p>
            </div>
         </td>
      </tr>
      <tr>
         <td>JNDI Queue Name</td>
         <td>The name of the queue in the broker that will store messages.</td>
      </tr>
      <tr>
         <td>JMS API Specification Version</td>
         <td>The JMS API version to be used. Possible values are 1.1 or 1.0. The value is set to 1.1, by default.</td>
      </tr>
   </tbody>
</table>