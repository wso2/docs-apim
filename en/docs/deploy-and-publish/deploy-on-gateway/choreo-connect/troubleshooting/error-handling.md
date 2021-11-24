# Error Handling

### Error Codes

In the event of errors occurring during runtime, the Router responds with specific error codes to identify the exact error. The table below lists and describes such error codes. To find more about above error codes, see [Envoy's response flags documentation]({{envoy_path}}/configuration/observability/access_log/usage#config-access-log-format-response-flags).

| Error Code | Envoy Error Code | Description                                                         |
|------------|------------------|---------------------------------------------------------------------|
| 102500     | UAEX             | Router couldn't connect to the Enforcer                             |
| 102503     | UF               | Upstream connection failed                                          |
| 102504     | UT               | Upstream connection timeout                                         |
| 102505     | UO               | Upstream overflow                                                   |
| 102506     | URX              | Upstream maximum connect attempts reached                           |
| 102507     | NC               | Upstream not configured for the resource                            |
| 102508     | UH               | No healthy upstream                                                 |
| 102509     | UR               | Upstream connection reset by the remote                             |
| 102510     | UC               | Upstream connection termination                                     |
| 102511     | LR               | Connection reset by the gateway                                     |
| 102512     | IH               | Strictly checked header validation failure                          |
| 102513     | SI               | Stream idle timeout                                                 |
| 102514     | DPE              | HTTP protocol error in downstream request                           |
| 102515     | UPE              | HTTP protocol error in upstream request                             |
| 102516     | UMSDR            | Upstream request reached max stream duration                        |
| 103500     | -                | Interceptor service connect failure or invalid response status code |
| 103501     | -                | Invalid encoded body from interceptor service                       |
