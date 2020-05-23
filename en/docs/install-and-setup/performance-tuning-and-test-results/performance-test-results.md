# Performance Test Results

## Summary

The performance of WSO2 API Manager was measured using the following APIs, which invoke a simple “Netty HTTP Echo Service”. As the name suggests, the Netty service echoes back any request posted to the service.

- Echo API: This is a secured API, which directly invokes the back-end service.

- Mediation API: This is also a secured API, which has a “sequence” as a mediation extension to modify the message.

Tests were done using 100, 200, 300, 1000, and 2000 concurrent users. Concurrent Users mean that there are multiple users accessing the API Gateway at the same time. Different Message Sizes (Payload) were used for the tests with different back-end service delays. The message sizes used are 50B, 1KiB, 10KiB, and 100KiB. The back-end delays were 0ms, 30ms, 500ms, and 1s.

## Deployment used for the test

![]({{base_path}}/assets/img/setup-and-install/apim_performance_test_all_in_one_deployment.png)

| Name | EC2 Instance Type | vCPU | Mem(GiB) |  
|---|---|---|---|
| Apache JMeter Client | c5.large | 2 | 2 |
| Apache JMeter Server 01 | c5.xlarge | 4 | 4 |
| Apache JMeter Server 02 | c5.xlarge | 4 | 4 |
| MySQL | db.m5.large | 2 | 8 |
| Netty HTTP Backend  | c5.xlarge | 4 | 4 |

vCPU for the instance running API Manager is 2 CPU
Token Type: JWT 
The operating system is Ubuntu 18.04
MySQL version in RDS instance was 5.7

## Results

You could find the complete results in this [location.](https://github.com/wso2/product-apim/blob/performance-test-43-2019-11-29_15-07-18/performance/benchmarks/summary.md)

Following is an extraction of the result. With WSO2 API Manager an average user use ~1KiB messages and most of the back-ends usually responds in ~30ms. 

![]({{base_path}}/assets/img/setup-and-install/performance-result-graph.png)

Since WSO2 API Manager 3.0.0 supports JDK 11, we have done a seperate test to get the performance numbers and they can be found in [here.](https://github.com/wso2/product-apim/blob/performance-test-44-2019-11-29_15-07-18/performance/benchmarks/summary.md)