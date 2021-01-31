# Setting Maximum Backend Throughput Limits

The maximum backend throughput setting limits the total number of calls a particular API in the API Manager is allowed to make to the backend. While the [other throttling levels]({{base_path}}/design/rate-limiting/setting-throttling-limits) define the quota the API invoker gets, they do not ensure that the backend is protected from overuse. The maximum backend throughput setting limits the quota the backend can handle. The counters maintained when evaluating the maximum backend throughput are shared across all nodes of the Gateway cluster and apply across all users using any application that accesses that particular API.

Please follow below steps to set a maximum backend throughput for a given API.

1.  Sign in to the WSO2 API Publisher `https://<hostname>:9443/publisher`.

2.  Click on the API which you want to set the maximum backend throughput.

    <a href="{{base_path}}/assets/img/learn/select-api.png" ><img src="{{base_path}}/assets/img/learn/select-api.png" alt="Select API" title="Select API" width="40%" /></a>  
    
3.  Navigate to **Runtime Configurations** tab.

4.  Select the **Specify** option for the maximum backend throughput and specify the limits of the Production and Sandbox endpoints separately, as the two endpoints can come from two servers with different capacities.

    <a href="{{base_path}}/assets/img/learn/learn-throttling-maxtps.png" ><img src="{{base_path}}/assets/img/learn/learn-throttling-maxtps.png" alt="Max backend throughput" title="Max backend throughput" width="100%" /></a> 
    
5.  Save the API.

    <a href="{{base_path}}/assets/img/learn/save-api.png" ><img src="{{base_path}}/assets/img/learn/save-api.png" alt="Save API " title="Save API" width="40%" /></a> 
    
    
When the maximum backend throughput quota is reached for a given API, anymore requests won't be accepted for that particular API. Following error message will be returned for all the throttled out requests.

```json
{
  "fault": {
    "code": 900801,
    "message": "API Limit Reached",
    "description": "API not accepting requests"
  }
}

```  