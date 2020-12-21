# SMPP Inbound Endpoint Reference

The following configurations allow you to configure SMPP Inbound Endpoint for your scenario. 

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
    <td class="tg-0pky">host</td>
    <td class="tg-0pky"> IP address of the SMSC.</td>
    <td class="tg-0pky">Yes</td>
    <td class="tg-0pky">N/A</td>
    <td class="tg-0pky">N/A</td>
  </tr>
  <tr>
    <td class="tg-0pky">port</td>
    <td class="tg-0pky">Port to access the SMSC.</td>
    <td class="tg-0pky">Yes</td>
    <td class="tg-0pky">N/A</td>
    <td class="tg-0pky">N/A</td>
  </tr>
  <tr>
    <td class="tg-0pky">systemType</td>
    <td class="tg-0pky">Identifies the type of ESME system requesting to bind as a receiver with the SMSC.</td>
    <td class="tg-0pky">Yes</td>
    <td class="tg-0pky">"" - (NULL)<br>                        
                        CMT - Cellular Messaging<br>
                        CPT - Cellular Paging<br>                        
                        VMN - Voice Mail Notification<br>                        
                        VMA - Voice Mail Alerting<br>                        
                        WAP - Wireless Application Protocol<br>                        
                        USSD - Unstructured Supplementary Services Data</td>
    <td class="tg-0pky">"" - (NULL)</td>
  </tr>
  <tr>
    <td class="tg-0pky">systemId</td>
    <td class="tg-0pky">Identifies the ESME system requesting to bind as a receiver with the SMSC.</td>
    <td class="tg-0pky">Yes</td>
    <td class="tg-0pky">N/A</td>
    <td class="tg-0pky">N/A</td>
  </tr>
  <tr>
    <td class="tg-0pky">password</td>
    <td class="tg-0pky">The password may be used by the SMSC to authenticate the ESME requesting to bind.</td>
    <td class="tg-0pky">Yes</td>
    <td class="tg-0pky">N/A</td>
    <td class="tg-0pky">N/A</td>
  </tr>
  <tr>
    <td class="tg-0pky">addressNpi</td>
    <td class="tg-0pky">Numbering Plan Indicator for ESME address.</td>
    <td class="tg-0pky">Yes</td>
    <td class="tg-0pky">Unknown<br>
                        ISDN (E163/E164)
                        Data (X.121)
                        Telex (F.69)<br>                        
                        Land Mobile (E.212)<br>                        
                        National
                        Private
                        ERMES<br>
                        Internet (IP)<br>                        
                        WAP Client Id (to be defined by WAP Forum)</td>
    <td class="tg-0pky">N/A</td>
  </tr> 
  <tr>
    <td class="tg-0pky">addressTon</td>
    <td class="tg-0pky">Indicates Type of Number of the ESME address.</a></td>
    <td class="tg-0pky">Yes</td>
    <td class="tg-0pky">Unknown<br>                        
                        International
                        National
                        Network Specific<br>                        
                        Subscriber Number<br>                        
                         Alphanumeric
                        Abbreviated</td>
    <td class="tg-0pky">N/A</td>
  </tr>
  <tr>
    <td class="tg-0pky">bindType</td>
    <td class="tg-0pky">An ESME bound as a Receiver or Transceiver is authorised to receive short messages from the SMSC.</td>
    <td class="tg-0pky">Yes</td>
    <td class="tg-0pky">BIND_RX<br>
                        BIND_TRX</td>
    <td class="tg-0pky">N/A</td>
  </tr> 
  <tr>
    <td class="tg-0pky">addressRange</td>
    <td class="tg-0pky">A single ESME address or a range of ESME addresses served via this SMPP receiver session.</td>
    <td class="tg-0pky">No</td>
    <td class="tg-0pky">N/A</td>
    <td class="tg-0pky">null</td>
  </tr> 
  <tr>
    <td class="tg-0pky">enquireLinktimer</td>
    <td class="tg-0pky">Used to check whether SMSC is connected or not.</td>
    <td class="tg-0pky">No</td>
    <td class="tg-0pky">N/A</td>
    <td class="tg-0pky">10000</td>
  </tr>
  <tr>
    <td class="tg-0pky">transactiontimer</td>
    <td class="tg-0pky">Time elapsed between SMPP request and the corresponding response.</td>
    <td class="tg-0pky">No</td>
    <td class="tg-0pky">N/A</td>
    <td class="tg-0pky">200</td>
  </tr>
  <tr>
    <td class="tg-0pky">reconnectInterval</td>
    <td class="tg-0pky">The Initial retry interval to reconnect with the SMSC while SMSC is not available.</td>
    <td class="tg-0pky">No</td>
    <td class="tg-0pky">N/A</td>
    <td class="tg-0pky">3000ms</td>
  </tr>
  <tr>
    <td class="tg-0pky">retryCount</td>
    <td class="tg-0pky">The number of times to retry to connect with SMSC, while connection with the SMSC is closed. If you want to retry forever, give the retry count value as less than 0.</td>
    <td class="tg-0pky">No</td>
    <td class="tg-0pky">N/A</td>
    <td class="tg-0pky">5</td>
  </tr>
  <tr>
    <td class="tg-0pky">exponentialFactor</td>
    <td class="tg-0pky">Start with Initial reconnectInterval delay until first retry attempt is made but if that one
                        fails, we should wait (reconnectInterval * exponentialFactor) times more. For example<br>                        
                        let’s say we start with exponentialFactor 2 and 100ms delay until first retry attempt is<br>                        
                        made but if that one fails as well, we should wait two times more (200ms). And later 400ms, 800ms…</td>
    <td class="tg-0pky">No</td>
    <td class="tg-0pky">N/A</td>
    <td class="tg-0pky">5</td>
    </tr>
  <tr>
    <td class="tg-0pky">maximumBackoffTime</td>
    <td class="tg-0pky">The above one is an exponential function that can grow very fast. Thus it’s useful to set maximum backoff time at some reasonable level, e.g. 10 seconds:</td>
    <td class="tg-0pky">No</td>
    <td class="tg-0pky">N/A</td>
    <td class="tg-0pky">10000ms</td>
    </tr>  
</table>