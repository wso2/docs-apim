# Monitoring API Logs

WSO2 API-M enables a simple way to observe requests and responses going through the WSO2 API Gateway by introducing this light weight feature called API Logs. Since Correlation Logs cause lower performance on the API gateway, API Logs can be used to collect HTTP call logs without a considerable performance hit. There are 4 log levels where each log level has a set of properties.

<table>
    <tr>
        <th>Log Level</th>
        <th>Properties</th>
    </tr>
    <tr>
        <td>OFF</td>
        <td>None</td>
    </tr>
    <tr>
        <td>BASIC</td>
        <td>API Context, Resource, Correlation ID, Flow, Source IP, HTTP Method, HTTP Status Code</td>
    </tr>
    <tr>
        <td>STANDARD</td>
        <td>BASIC properties + Headers</td>
    </tr>
    <tr>
        <td>FULL</td>
        <td>STANDARD properties + Payload</td>
    </tr>
</table>

API Logs is disabled by default and can be enabled per API without restarting the server. There are 2 ways to configure API Logs.

1. [Configure API Logs using Devops REST API]({{base_path}}/observe/api-manager/monitoring-api-logs/#configure-api-logs-using-devops-rest-api)
2. [Configure API Logs using API Controller (APICTL)]({{base_path}}/observe/api-manager/monitoring-api-logs/#configure-api-logs-using-api-controller-apictl)

After enabling API Logs for an API, logs can be observed in `<APIM_HOME>/repository/logs/api.log` file. Each log contains in-line JSON object with properties assigned with given log level. A sample sets of logs is given below.

1. BASIC Log Level

    ```
    [2022-02-07 14:10:57,687]  INFO {API_LOG} pizzashack - {"sourceIP":"127.0.0.1","verb":"GET","correlationId":"684794db-c208-4777-ab93-c2b2422981fe","apiTo":"pizzashack/1.0.0/menu","flow":"REQUEST_IN"}
    [2022-02-07 14:10:57,777]  INFO {API_LOG} pizzashack - {"sourceIP":"127.0.0.1","verb":"GET","correlationId":"684794db-c208-4777-ab93-c2b2422981fe","apiTo":"pizzashack/1.0.0/menu","flow":"REQUEST_OUT"}
    [2022-02-07 14:10:58,601]  INFO {API_LOG} pizzashack - {"verb":"GET","correlationId":"684794db-c208-4777-ab93-c2b2422981fe","apiTo":"pizzashack/1.0.0/menu","flow":"RESPONSE_IN","statusCode":200}
    [2022-02-07 14:10:58,603]  INFO {API_LOG} pizzashack - {"verb":"GET","correlationId":"684794db-c208-4777-ab93-c2b2422981fe","apiTo":"pizzashack/1.0.0/menu","flow":"RESPONSE_OUT","statusCode":200}
    ```

2. STANDARD Log LeveL

    ```
    [2022-02-08 15:00:57,703]  INFO {API_LOG} pizzashack - {"headers":["accept=application/json","Accept-Encoding=gzip, deflate, br","Accept-Language=en-US,en;q=0.9","activityid=73bac4b5-c774-4aab-ba60-6d41451819ce","Connection=keep-alive","Host=localhost:8243","Internal-Key=eyJraWQiOiJnYXRld2F5X2NlcnRpZmljYXRlX2FsaWFzIiwiYWxnIjoiUlMyNTYifQ.eyJzdWIiOiJhZG1pbkBjYXJib24uc3VwZXIiLCJpc3MiOiJodHRwczpcL1wvbG9jYWxob3N0Ojk0NDNcL29hdXRoMlwvdG9rZW4iLCJrZXl0eXBlIjoiUFJPRFVDVElPTiIsInN1YnNjcmliZWRBUElzIjpbeyJzdWJzY3JpYmVyVGVuYW50RG9tYWluIjpudWxsLCJuYW1lIjoiUGl6emFTaGFja0FQSSIsImNvbnRleHQiOiJcL3Bpenphc2hhY2tcLzEuMC4wIiwicHVibGlzaGVyIjoiYWRtaW4iLCJ2ZXJzaW9uIjoiMS4wLjAiLCJzdWJzY3JpcHRpb25UaWVyIjpudWxsfV0sImV4cCI6MTY0NDM3MjY1MSwidG9rZW5fdHlwZSI6IkludGVybmFsS2V5IiwiaWF0IjoxNjQ0MzEyNjUxLCJqdGkiOiI5MzRkMDczNC01NDU0LTQ4NmUtYjAyNi0yMDA0OGI5OTljOWIifQ.CWEjFKiBY6iOQYRihluc4pjJyKJFJ_gudbZI1JyVgHPyK1mNoZnHRAdFFWe-nUUgRQOvU3HifHmPgDG-YeL52K2ZESMaEgKuyML3ml0oYiXTjjPSQEE9aewV59BWmsZwN_wU0FShxATtLjQtXlwQmN57lI73R2OANqvs0bjKKhWzu84iYtV-IIPdJfhPMWQzwC3JGh0PnLIg8rdpgZhRCQNQrePDhnPFqU9FDCF6DqriMxqraF_9Lv0hRpool_Rkmbf2rG1dcyEpeLGIY2cVL_tFV6Ldwyce8EA3jdDliaFm8w3oDPrNKfG_gFQY2wpISxai6rg4Pe2PmULb0Km03g","Origin=https://localhost:9443","Referer=https://localhost:9443/","sec-ch-ua=\" Not;A Brand\";v=\"99\", \"Google Chrome\";v=\"97\", \"Chromium\";v=\"97\"","sec-ch-ua-mobile=?0","sec-ch-ua-platform=\"Linux\"","Sec-Fetch-Dest=empty","Sec-Fetch-Mode=cors","Sec-Fetch-Site=same-site","User-Agent=Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/97.0.4692.71 Safari/537.36"],"sourceIP":"127.0.0.1","verb":"GET","correlationId":"73bac4b5-c774-4aab-ba60-6d41451819ce","apiTo":"pizzashack/1.0.0/menu","flow":"REQUEST_IN"}
    [2022-02-08 15:00:57,793]  INFO {API_LOG} pizzashack - {"headers":["accept=application/json","Accept-Encoding=gzip, deflate, br","Accept-Language=en-US,en;q=0.9","activityid=73bac4b5-c774-4aab-ba60-6d41451819ce","Connection=keep-alive","Host=localhost:8243","Origin=https://localhost:9443","Referer=https://localhost:9443/","sec-ch-ua=\" Not;A Brand\";v=\"99\", \"Google Chrome\";v=\"97\", \"Chromium\";v=\"97\"","sec-ch-ua-mobile=?0","sec-ch-ua-platform=\"Linux\"","Sec-Fetch-Dest=empty","Sec-Fetch-Mode=cors","Sec-Fetch-Site=same-site","User-Agent=Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/97.0.4692.71 Safari/537.36"],"sourceIP":"127.0.0.1","verb":"GET","correlationId":"73bac4b5-c774-4aab-ba60-6d41451819ce","apiTo":"pizzashack/1.0.0/menu","flow":"REQUEST_OUT"}
    [2022-02-08 15:00:58,438]  INFO {API_LOG} pizzashack - {"headers":["Connection=keep-alive","Content-Type=application/json","Date=Tue, 08 Feb 2022 09:30:58 GMT","Keep-Alive=timeout=60","Server=WSO2 Carbon Server","Transfer-Encoding=chunked"],"verb":"GET","correlationId":"73bac4b5-c774-4aab-ba60-6d41451819ce","apiTo":"pizzashack/1.0.0/menu","flow":"RESPONSE_IN","statusCode":200}
    [2022-02-08 15:00:58,440]  INFO {API_LOG} pizzashack - {"headers":["Access-Control-Allow-Headers=authorization,Access-Control-Allow-Origin,Content-Type,SOAPAction,apikey,Internal-Key,Authorization","Access-Control-Allow-Methods=GET","Access-Control-Allow-Origin=*","Access-Control-Expose-Headers=","activityid=73bac4b5-c774-4aab-ba60-6d41451819ce","Connection=keep-alive","Content-Type=application/json","Date=Tue, 08 Feb 2022 09:30:58 GMT","Keep-Alive=timeout=60","Server=WSO2 Carbon Server","Transfer-Encoding=chunked"],"verb":"GET","correlationId":"73bac4b5-c774-4aab-ba60-6d41451819ce","apiTo":"pizzashack/1.0.0/menu","flow":"RESPONSE_OUT","statusCode":200}
    ```

3. FULL Log Level 

    ```
    [2022-02-08 15:09:45,235]  INFO {API_LOG} pizzashack - {"headers":["accept=application/json","Accept-Encoding=gzip, deflate, br","Accept-Language=en-US,en;q=0.9","activityid=64b0b90d-7c24-4b7b-9000-1d0b78eb04c4","Connection=keep-alive","Content-Length=185","Content-Type=application/json","Host=localhost:8243","Internal-Key=eyJraWQiOiJnYXRld2F5X2NlcnRpZmljYXRlX2FsaWFzIiwiYWxnIjoiUlMyNTYifQ.eyJzdWIiOiJhZG1pbkBjYXJib24uc3VwZXIiLCJpc3MiOiJodHRwczpcL1wvbG9jYWxob3N0Ojk0NDNcL29hdXRoMlwvdG9rZW4iLCJrZXl0eXBlIjoiUFJPRFVDVElPTiIsInN1YnNjcmliZWRBUElzIjpbeyJzdWJzY3JpYmVyVGVuYW50RG9tYWluIjpudWxsLCJuYW1lIjoiUGl6emFTaGFja0FQSSIsImNvbnRleHQiOiJcL3Bpenphc2hhY2tcLzEuMC4wIiwicHVibGlzaGVyIjoiYWRtaW4iLCJ2ZXJzaW9uIjoiMS4wLjAiLCJzdWJzY3JpcHRpb25UaWVyIjpudWxsfV0sImV4cCI6MTY0NDM3MjgyNywidG9rZW5fdHlwZSI6IkludGVybmFsS2V5IiwiaWF0IjoxNjQ0MzEyODI3LCJqdGkiOiI4OTJkODEwZS0xZmUxLTQ4OTItOTVjOS0xMDE5M2I3MzYwM2YifQ.Uvh6a11Cs3RakrvT0G8IvGm78-I512AeJ0r4N4xFydEVdAbGKZRkA_Z6Ox2U2pEClNPnvm8lXCwuIGtAQfmApl5bRGmOJtj-5UjiEYNUnPcefewOZc7ObJ6ct3hHK0jbHrlVwP1OREf5yyRQJdBxT9EImOQjz4uDe0gGD8jydyODE51_d-6hPLa4qkAQijlsGlKyqw1-j5YHfFWBpb3an3et5tvNTTdM428QyFPBvB7K-aLVrNaZdpwmv3F3T-F394SgyiN0sdyeDBomZm_x0JQWrN_AGJ7WIlcNGJ0Y4NCKXQjPI2i0LmRRtpCs4WMJGkovDYTxeWpQpm3lA2ksEw","Origin=https://localhost:9443","Referer=https://localhost:9443/","sec-ch-ua=\" Not;A Brand\";v=\"99\", \"Google Chrome\";v=\"97\", \"Chromium\";v=\"97\"","sec-ch-ua-mobile=?0","sec-ch-ua-platform=\"Linux\"","Sec-Fetch-Dest=empty","Sec-Fetch-Mode=cors","Sec-Fetch-Site=same-site","User-Agent=Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/97.0.4692.71 Safari/537.36"],"sourceIP":"127.0.0.1","payload":"{\n  \"customerName\": \"customer\",\n  \"delivered\": true,\n  \"address\": \"address\",\n  \"pizzaType\": \"regular\",\n  \"creditCardNumber\": \"0000-0000-0000-0000\",\n  \"quantity\": 1,\n  \"orderId\": \"001\"\n}","verb":"POST","correlationId":"64b0b90d-7c24-4b7b-9000-1d0b78eb04c4","apiTo":"pizzashack/1.0.0/order","flow":"REQUEST_IN"}
    [2022-02-08 15:09:45,238]  INFO {API_LOG} pizzashack - {"headers":["accept=application/json","Accept-Encoding=gzip, deflate, br","Accept-Language=en-US,en;q=0.9","activityid=64b0b90d-7c24-4b7b-9000-1d0b78eb04c4","Connection=keep-alive","Content-Length=185","Content-Type=application/json","Host=localhost:8243","Origin=https://localhost:9443","Referer=https://localhost:9443/","sec-ch-ua=\" Not;A Brand\";v=\"99\", \"Google Chrome\";v=\"97\", \"Chromium\";v=\"97\"","sec-ch-ua-mobile=?0","sec-ch-ua-platform=\"Linux\"","Sec-Fetch-Dest=empty","Sec-Fetch-Mode=cors","Sec-Fetch-Site=same-site","User-Agent=Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/97.0.4692.71 Safari/537.36"],"sourceIP":"127.0.0.1","payload":"{\n  \"customerName\": \"customer\",\n  \"delivered\": true,\n  \"address\": \"address\",\n  \"pizzaType\": \"regular\",\n  \"creditCardNumber\": \"0000-0000-0000-0000\",\n  \"quantity\": 1,\n  \"orderId\": \"001\"\n}","verb":"POST","correlationId":"64b0b90d-7c24-4b7b-9000-1d0b78eb04c4","apiTo":"pizzashack/1.0.0/order","flow":"REQUEST_OUT"}
    [2022-02-08 15:09:45,357]  INFO {API_LOG} pizzashack - {"headers":["Connection=keep-alive","Content-Type=application/json","Date=Tue, 08 Feb 2022 09:39:45 GMT","Keep-Alive=timeout=60","Location=https://localhost:9443/am/sample/pizzashack/v1/api/order/c952947d-52cf-403f-b2bb-bec7e26c0252","Server=WSO2 Carbon Server","Transfer-Encoding=chunked"],"payload":"{\"orderId\":\"c952947d-52cf-403f-b2bb-bec7e26c0252\",\"pizzaType\":\"regular\",\"quantity\":1,\"customerName\":\"customer\",\"creditCardNumber\":\"0000-0000-0000-0000\",\"address\":\"address\",\"delivered\":true}","verb":"POST","correlationId":"64b0b90d-7c24-4b7b-9000-1d0b78eb04c4","apiTo":"pizzashack/1.0.0/order","flow":"RESPONSE_IN","statusCode":201}
    [2022-02-08 15:09:45,358]  INFO {API_LOG} pizzashack - {"headers":["Access-Control-Allow-Headers=authorization,Access-Control-Allow-Origin,Content-Type,SOAPAction,apikey,Internal-Key,Authorization","Access-Control-Allow-Methods=POST","Access-Control-Allow-Origin=*","Access-Control-Expose-Headers=","activityid=64b0b90d-7c24-4b7b-9000-1d0b78eb04c4","Connection=keep-alive","Content-Type=application/json","Date=Tue, 08 Feb 2022 09:39:45 GMT","Keep-Alive=timeout=60","Location=https://localhost:9443/am/sample/pizzashack/v1/api/order/c952947d-52cf-403f-b2bb-bec7e26c0252","Server=WSO2 Carbon Server","Transfer-Encoding=chunked"],"payload":"{\"orderId\":\"c952947d-52cf-403f-b2bb-bec7e26c0252\",\"pizzaType\":\"regular\",\"quantity\":1,\"customerName\":\"customer\",\"creditCardNumber\":\"0000-0000-0000-0000\",\"address\":\"address\",\"delivered\":true}","verb":"POST","correlationId":"64b0b90d-7c24-4b7b-9000-1d0b78eb04c4","apiTo":"pizzashack/1.0.0/order","flow":"RESPONSE_OUT","statusCode":201}
    ```

Properties, listed above, are mostly used for debugging and users can decide the log level according to their need and purpose. However, API Logs allows to log additional properties which can be used for advanced debugging scenarios. Follow the steps below to configure additional properties.

1. Open `<API-M_HOME>/repository/conf/log4j2.properties` file.
2. Modify the pattern layout of API_LOGFILE appender by adding %X{`<additional-property-name>`}. Currently, API-M supports following additional properties.
    1. apiContext
    2. apiVersion
    3. resourceName
    4. tenantDomain
    5. logCorrelationId
3. Save and close `log4j2.properties` file.

```bash tab="Example"
appender.API_LOGFILE.layout.pattern = [%d] %5p %c | %X{apiContext} | %X{tenantDomain} | %m%ex%n
```

```bash tab="Sample log"
[2022-02-08 15:56:21,984]  INFO API_LOG | pizzashack | carbon.super | {"sourceIP":"127.0.0.1","verb":"OPTIONS" "correlationId":"721e62a0-e7d4-4b98-bb6a-e04ea7e9fd7d","apiTo":"pizzashack/1.0.0/menu","flow":"REQUEST_IN"}
```

!!!Note
    Additional properties will be logged outside of the in-line JSON object.

## Configure API Logs using Devops REST API

Devops REST API can be used to configure log level of APIs. It only allows the user with super admin permissions to invoke Devops REST API. For more instructions, see [WSO2 Devops API v0]({{base_path}}/reference/product-apis/devops-apis/devops-v0/devops-v0/).

1. Get log level details of APIs.

    ```bash tab="cURL commands"
    curl -X GET 'http://<HOST_NAME>:<PORT>/api/am/devops/v0/tenant-logs/{tenant-domain}/apis' -H 'Authorization: Basic <base64Encode(username:password)>' -k
    curl -X GET 'http://<HOST_NAME>:<PORT>/api/am/devops/v0/tenant-logs/{tenant-domain}/apis?log-level=<log-level>' -H 'Authorization: Basic <base64Encode(username:password)>' -k
    ```
    
    ```bash tab="Sample cURL command"
    curl -X GET 'https://localhost:9443/api/am/devops/v0/tenant-logs/carbon.super/apis?log-level=off' -H 'Authorization: Basic YWRtaW46YWRtaW4=' -k
    ```
    
    ```bash tab="Sample response"
    {"apis":[{"context":"/pizzashack/1.0.0","logLevel":"OFF","apiId":"64f06bef-0019-4bf4-875a-76c03b10d2fc"}]}
    ```

2. Get log level of an API.
    
    ```bash tab="cURL command"
    curl -X GET 'http://<HOST_NAME>:<PORT>/api/am/devops/v0/tenant-logs/{tenant-domain}/apis/{api-id}' -H 'Authorization: Basic <base64Encode(username:password)>' -k
    ```
    
    ```bash tab="Sample cURL command"
    curl -X GET 'https://localhost:9443/api/am/devops/v0/tenant-logs/carbon.super/apis/64f06bef-0019-4bf4-875a-76c03b10d2fc' -H 'Authorization: Basic YWRtaW46YWRtaW4=' -k
    ```
    
    ```bash tab="Sample response"
    {"apis":[{"context":"/pizzashack/1.0.0","logLevel":"OFF","apiId":"64f06bef-0019-4bf4-875a-76c03b10d2fc"}]}
    ```

3. Set log level of an API.

    ```bash tab="cURL command"
    curl -X PUT 'http://<HOST_NAME>:<PORT>/api/am/devops/v0/tenant-logs/{tenant-domain}/apis/{api-id}' -H 'Authorization: Basic <base64Encode(username:password)>' -H 'Content-Type: application/json' -d '{"logLevel": "<logLevel>"}' -k
    ```
    
    ```bash tab="Sample cURL command"
    curl -X PUT 'https://localhost:9443/api/am/devops/v0/tenant-logs/carbon.super/apis/64f06bef-0019-4bf4-875a-76c03b10d2fc' -H 'Authorization: Basic YWRtaW46YWRtaW4=' -H 'Content-Type: application/json' -d '{"logLevel": "full"}' -k
    ```
    
    ```bash tab="Sample response"
    {"logLevel":"FULL"}
    ```

## Configure API Logs using API Controller (APICTL)

APICTL provides the functionality to get and set the log level of APIs. It only allows the user with super admission permissions to configure API Logs. For more instructions, refer to the following doc pages.

1. [Get the log level of APIs or an API in an environment]({{base_path}}/install-and-setup/setup/api-controller/managing-apis-api-products/managing-apis-and-api-products/#get-the-log-level-of-apis-or-an-api-in-an-environment)
2. [Set the log level of an API in an environment]({{base_path}}/install-and-setup/setup/api-controller/managing-apis-api-products/managing-apis-and-api-products/#set-the-log-level-of-an-api-in-an-environment)