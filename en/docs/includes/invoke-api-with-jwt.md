
Execute the following cURL command to Invoke the API using the JWT.

 ``` bash tab="Format"
 curl -X GET "https://<MGW-runtime-hostname>:<MGW-runtime-port>/<API-context>/<API-resource>" -H "accept:application/xml" -H "Authorization:Bearer $TOKEN" -k
 ```
 
 ``` bash tab="Example"
 curl -X GET "https://localhost:9095/petstore/v1/pet/1" -H "accept: application/xml" -H "Authorization:Bearer $TOKEN" -k
 ```
 
