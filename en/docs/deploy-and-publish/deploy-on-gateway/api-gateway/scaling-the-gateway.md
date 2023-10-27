# Scaling the Gateway

Scaling the Gateway requires considering the load that the Gateways will handle. We recommend that a load test be carried out on the Gateways in the environment. For more information on what factors affect the load, and how the numbers have to be derived in order to scale, refer to the article on [Capacity Planning](https://wso2.com/library/articles/2015/12/article-capacity-planning-exercise-with-wso2-middleware-platform/) . Make sure to check the backends as well for the expected load.

### Clustering Gateways and Key Managers with key caching

For key validation, the Gateway can usually handle 3,000 transactions per second (TPS), whereas the Key Manager can only handle 500 TPS. To improve performance, the key cache is enabled on the Gateway by default, which allows the system to handle 3,000 TPS. However, if you need better security, you can enable the cache on the Key Manager instead. Note the following about clustering with key caching:

-   When the cache is enabled at the Gateway, you can have two Gateways per Key Manager.
-   When the cache is enabled at the Key Manager and disabled at the Gateway, you can have only one Gateway per Key Manager.
-   If both caches are disabled (not recommended), even with only one Gateway per Key Manager, the system may not be able to handle the load, as the Key Manager will only be able to handle 500 TPS.

For more information, see [Key cache]({{base_path}}/administer/product-configurations/configuring-caching/#key-cache) in the WSO2 API Manager documentation.

### Scaling Gateways and Traffic Managers

Based on the performance numbers attained at the WSO2 Labs, the recommended ratio is 10 Gateways to 1 Traffic Manager (10:1, one Traffic Manager is tested to have successfully handled the load of 10 Gateways, one Gateway handling the load  of ~5000 TPS). Note that Traffic Managers do not scale horizontally . If the requirement arises to have more than 10 Gateways, WSO2 recommends  to have Traffic Managers placed in dedicated clusters of a maximum of 10 Gateways each. However, the number of Gateways in a cluster is not a hard limit and can vary according to your requirement.

