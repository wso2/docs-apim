# Salesforce Inbound Endpoint Reference

The following configurations allow you to configure Salesforce Inbound Endpoint for your scenario. 

<style type="text/css">
.tg  {border-collapse:collapse;border-spacing:0;}
.tg td{font-family:Arial, sans-serif;font-size:14px;padding:10px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;border-color:black;}
.tg th{font-family:Arial, sans-serif;font-size:20px;font-weight:normal;padding:10px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;border-color:black;}
.tg .tg-0pky{border-color:inherit;text-align:left;vertical-align:top}
</style>
<table class="tg">
  <tr>
    <th class="tg-0pky">Parameter</th>
    <th class="tg-0pky">Description</th>
    <th class="tg-0pky">Required</th>
    <th class="tg-0pky">Possible Values</th>
    <th class="tg-0pky">Default Value</th>
  </tr>
  <tr>
    <td class="tg-0pky">sequential</td>
    <td class="tg-0pky">Whether the messages should be polled and injected sequentially.</td>
    <td class="tg-0pky">Yes</td>
    <td class="tg-0pky">true , false</td>
    <td class="tg-0pky">TRUE</td>
  </tr>
  <tr>
    <td class="tg-0pky">replay</td>
    <td class="tg-0pky"> Enabling this will read the event ID stored in the Registry DB or from the text file stored in the local machine.</td>
    <td class="tg-0pky">Yes</td>
    <td class="tg-0pky">enable or disable</td>
    <td class="tg-0pky">false</td>
  </tr>
  <tr>
    <td class="tg-0pky">packageVersion</td>
    <td class="tg-0pky">The version of the Salesforce API.</td>
    <td class="tg-0pky">Yes</td>
    <td class="tg-0pky">37.0</td>
    <td class="tg-0pky">-</td>
  </tr>
  <tr>
    <td class="tg-0pky">salesforceObject</td>
    <td class="tg-0pky">The name of the Push Topic or the Platform Event that is added to the Salesforce account.</td>
    <td class="tg-0pky">Yes</td>
    <td class="tg-0pky">/topic/Account</td>
    <td class="tg-0pky">-</td>
  </tr>
  <tr>
    <td class="tg-0pky">loginEndpoint</td>
    <td class="tg-0pky">The Endpoint of the Salesforce account.</td>
    <td class="tg-0pky">Yes</td>
    <td class="tg-0pky">https://login.salesforce.com</td>
    <td class="tg-0pky">https://login.salesforce.com</td>
  </tr>
  <tr>
    <td class="tg-0pky">userName</td>
    <td class="tg-0pky">The username for accessing the Salesforce account.</td>
    <td class="tg-0pky">Yes</td>
    <td class="tg-0pky">-</td>
    <td class="tg-0pky">-</td>
  </tr> 
  <tr>
    <td class="tg-0pky">password</td>
    <td class="tg-0pky"> The password provided here is a concatenation of the user password and the security token provided by Salesforce. For more information, see <a href="https://help.salesforce.com/articleView?id=user_security_token.htm&type=5">Information on creating a security token in Salesforce</a></td>
    <td class="tg-0pky">Yes</td>
    <td class="tg-0pky">eitest123xxxxxxx</td>
    <td class="tg-0pky">-</td>
  </tr>
  <tr>
    <td class="tg-0pky">waitTime</td>
    <td class="tg-0pky">The time to wait to connect to the Salesforce account.</td>
    <td class="tg-0pky">Yes</td>
    <td class="tg-0pky">5000</td>
    <td class="tg-0pky">5 * 1000 ms</td>
  </tr> 
  <tr>
    <td class="tg-0pky">connectionTimeout</td>
    <td class="tg-0pky">The time to wait to connect to the client.</td>
    <td class="tg-0pky">Yes</td>
    <td class="tg-0pky">20000</td>
    <td class="tg-0pky">20 * 1000 ms</td>
  </tr> 
  <tr>
    <td class="tg-0pky">soapApiVersion</td>
    <td class="tg-0pky">The version of the Salesforce SOAP API.</td>
    <td class="tg-0pky">Yes</td>
    <td class="tg-0pky">22.0</td>
    <td class="tg-0pky">-</td>
  </tr>
  <tr>
    <td class="tg-0pky">EventIDStoredFilePath</td>
    <td class="tg-0pky">When replay is enabled, do not define any value for this property (i.e., keep it blank), to replay from the last event ID stored in the config Registry DB (property- name of the Salesforce object (follow the example below for more understanding) resource path - connector/salesforce/event). When replay is enabled, specify the directory path of a text file to start replaying from the event ID stored in it.</td>
    <td class="tg-0pky">No</td>
    <td class="tg-0pky">/home/kasun/Documents/SalesForceConnector/a.txt</td>
    <td class="tg-0pky">-</td>
  </tr>   
</table>