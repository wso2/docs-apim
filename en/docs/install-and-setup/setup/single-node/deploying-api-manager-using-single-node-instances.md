# Deploying API Manager using Single Node Instances

In a typical production deployment, API Manager is deployed as components (Publisher, Store, Gateway, Key Manager and Traffic Manager). While this provides very high performance and a high level of scalability, it may be too complex if you want to run API Manager as a small to medium scale API Management solution. A WSO2 API-M single node deployment, which has all the API-M components in one instance, would be simple to set up and requires less resources when compared with a distributed deployment. It is ideal for any organization that wants to start small and iteratively build up a robust API Management Platform.

WSO2 provides two options for organizations that are interested in setting up a small to medium scale API Management solution.

-   Setting up on WSO2 API Cloud, which is a subscription based API Management solution. You can access this service by creating an account in [WSO2 API Cloud](http://wso2.com/cloud/api-cloud/) .

-   If you are interested in setting up a single node API Manager instance, which has all the API-M components in one instance,  on-premise, you can [download](https://wso2.com/api-manager/) the latest version of API Manager and follow the instructions given below to set up the instance.

### Prerequisites

|          |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
|----------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Hardware | Ensure that the minimum hardware requirements mentioned in the [hardware requirements](https://docs.wso2.com/display/ADMIN44x/Production+Deployment+Guidelines) section are met. Since this is an all-in-one deployment, it is recommended to use a higher hardware specification. You can further fine tune your operating system for production by [tuning performance](https://docs.wso2.com/display/AM210/Tuning+Performance) . For more information on installing the product on different operating systems, see [Installing the Product](https://docs.wso2.com/display/AM210/Installing+the+Product) . |
| Software | Oracle JDK 1.8                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |

You can deploy a single node API Manager instance in the following methods:

-   [Single node deployment](#DeployingAPIManagerusingSingleNodeInstances-Singlenodedeployment)
-   [Active/active deployment](#DeployingAPIManagerusingSingleNodeInstances-Active/activedeployment)

### Single node deployment

In this setup, API traffic is served by one all-in-one instance of WSO2 API Manager.

![]({{base_path}}/assets/attachments/103334465/103334466.png)

| Pros                                                                                                               | Cons                                                                                             |
|--------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------|
| -   Production support is required only for a single API Manager node (you receive 24\*7 WSO2 production support). 
 -   Deployment is up and running within hours.                                                                      
 -   Can handle up to 43 million API calls a day (up to 500 API calls a second)                                      
 -   Minimum hardware/cloud infrastructure requirements (only one node).                                             
 -   Suitable for anyone new to API Management.                                                                      | -   Deployment does not provide High Availability.                                               
  -   Not network friendly. Deploying on a demilitarized zone (DMZ) would require a Reverse Proxy.  |

!!! info
For more information on manually configuring the production servers from scratch, see \_Configuring a Single Node .


### 
Active/active deployment

In this setup, API traffic is served by two single node (all-in-one) instances of WSO2 API Manager.

![]({{base_path}}/assets/attachments/103334465/103334467.png)
!!! info
For more information on manually configuring the production servers from scratch, see \_Configuring an Active-Active Deployment .


| Pros                                                                                                    | Cons                                                                        |
|---------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------|
| -   The system is highly available.                                                                     
 -   Production support is required for 2 API Manager nodes (you receive 24\*7 WSO2 production support).  
 -   Can handle up to 86 million API calls a day ( up to 1000 API calls a second)                         
 -   Deployment is up and running within hours.                                                           | -   Not network friendly. Deploying on a DMZ would require a Reverse Proxy. |


