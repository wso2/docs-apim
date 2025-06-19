# Scaling the Gateway

Scaling the Gateway requires considering the load that the Gateways will handle. We recommend that a load test be carried out on the Gateways in the environment. For more information on what factors affect the load, and how the numbers have to be derived in order to scale, refer to the article on [Capacity Planning](https://wso2.com/library/articles/2015/12/article-capacity-planning-exercise-with-wso2-middleware-platform/) . Make sure to check the backends as well for the expected load.

### Clustering Gateways and Key Managers with key caching

For key validation, the Gateway can usually handle 3,000 transactions per second (TPS), whereas the Key Manager can only handle 500 TPS. To improve performance, the key cache is enabled on the Gateway by default, which allows the system to handle 3,000 TPS. However, if you need better security, you can enable the cache on the Key Manager instead. Note the following about clustering with key caching:

-   When the cache is enabled at the Gateway, you can have two Gateways per Key Manager.
-   When the cache is enabled at the Key Manager and disabled at the Gateway, you can have only one Gateway per Key Manager.
-   If both caches are disabled (not recommended), even with only one Gateway per Key Manager, the system may not be able to handle the load, as the Key Manager will only be able to handle 500 TPS.

For more information, see [Key cache]({{base_path}}/administer/product-configurations/configuring-caching/#key-cache) in the WSO2 API Manager documentation.

### Scaling Gateways and Traffic Managers

Based on performance tests conducted at WSO2 Labs, a single Traffic Manager (TM) can handle approximately 20,000 events per second under standard conditions. The recommended deployment ratio is 10 API Gateways per TM to maintain optimal performance. These results were obtained using 5 APIs, 10 Applications, and the default throttling policies shipped with WSO2 API Manager.

**Things to Consider When Deploying the TM:**

- TMs do not scale horizontally; therefore, use additional clusters to scale effectively.

- If more than 10 Gateways are required, organize them into dedicated clusters, each with up to 10 Gateways.

- The recommended 10-Gateway limit is not a hard limit and can be adjusted based on your requirements.

!!! note
    **Actual performance may vary depending on:**

    - Use of custom throttling policies with different criterias

    - Number of APIs, Policies and Applications deployed

### Scaling the Gateways and the Control Plane

When multiple Gateway nodes are simultaneously spawned, they establish connections with the Control Plane via the event hub to obtain the necessary runtime artifacts. However, in cases where the deployed API count is substantial and a large number of Gateway nodes are initiated simultaneously, the Control Plane might struggle to manage the increased load. As a best practice, it's advisable to maintain a proportional ratio of 10 Gateway nodes to 1 Control Plane node in such scenarios. It's important to note that this ratio does not imply that a Control Plane node can only handle 10 Gateway nodes.

If you find yourself dealing with a substantial number of Gateway nodes, it's recommended to set up multiple Control Plane nodes within a cluster. It's worth mentioning that Control Plane nodes do not have dynamic horizontal scaling capabilities (autoscaling capabilities). The recommendation is to have 2 Control Plane nodes. Additionally, you can address Control Plane bottlenecks by either allocating more resources to the Control Plane nodes or by starting Gateway nodes sequentially, ensuring that the maximum number of Gateways launched at a given time does not exceed 10.
