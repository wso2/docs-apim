After the APIs are exposed via Choreo Connect, you can invoke an API with a valid token (JWT or opaque access token).

Let's use the following command to generate a JWT to access the API, and set it to the variable `TOKEN`. 

```
TOKEN=$(curl -X POST "https://localhost:9095/testkey" -H "Authorization: Basic YWRtaW46YWRtaW4=" -k -v)
```
