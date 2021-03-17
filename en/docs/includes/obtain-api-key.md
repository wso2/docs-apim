After the APIs are exposed via WSO2 API Microgateway, you can invoke an API with a valid token(JWT or opaque access token) or an API key.  Let's use WSO2 API Microgateway's API key endpoint to obtain an API key in order to access the API.
   
The below command will retrieve an APIKey token and set it to the shell variable `TOKEN`.
        
``` bash
TOKEN=$(curl -X get "https://localhost:9095/apikey" -H "Authorization:Basic YWRtaW46YWRtaW4=" -k)
```
