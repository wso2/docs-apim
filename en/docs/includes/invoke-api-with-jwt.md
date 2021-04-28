Execute the following cURL command to Invoke the API using the JWT.

 ``` bash tab="Format"
 curl -X GET "https://<CHOREO-CONNECT_ROUTER_HOST>:<CHOREO-CONNECT_ROUTER_PORT>/<API-context>/<API-resource>" -H "accept:application/xml" -H "Authorization:Bearer $TOKEN" -k
 ```
 
 ``` bash tab="Example"
 curl -X GET "https://localhost:9095/v2/pet/findByStatus?status=available" -H "accept: application/xml" -H "Authorization:Bearer $TOKEN" -k
 ```

