# Bot Detection

There is a possibility that hackers may invoke services without any proper authentication by using tools such as port scanning. Therefore, WSO2 API Manager (WSO2 API-M) provides a bot detection mechanism in place. There is an unadvertised service deployed in the Gateway that logs and sends events to API-M Analytics if it receives any traffic. Thereby, this helps Publishers to protect their data from bot attackers and improve the security of the data.

If hackers (e.g., bot attackers) try to invoke the unadvertised service, WSO2 API Manager will log the API calls in the `<API-M_HOME>/repository/logs/wso2-BotDetectedData.log` file. The following is a sample log record.
```
INFO BotDetectionMediator MessageId : urn:uuid:535437f1-a178-4722-a232-164e4a7e0207 | Request Method : POST | Message Body : <soapenv:Body xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"><jsonObject/></soapenv:Body> | client Ip : 127.0.0.1 | Headers set : [Accept=*/*, activityid=4b932127-d07e-43c3-bee2-4f5344074185, Content-Length=2, Content-Type=application/json, Host=localhost:8243, User-Agent=curl/7.58.0]  
```

 <html>
  <div class="admonition info">
  <p class="admonition-title">Info</p>
  <p>You can view the above logs without configuring API Manager Analytics</p>
  </div> 
  </html>


 <html>
  <div class="admonition note">
  <p class="admonition-title">Note</p>
  <p>If you wish to work with a third-party monitoring tool, then you can use the  details in the <code><API-M_HOME>/repository/logs/wso2-BotDetectedData.log</code> trace log and build an alert mechanism to receive alerts. </p>
  </div> 
  </html>

