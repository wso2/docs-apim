# All-in-One Deployment Overview

An all-in-one deployment contains all the API-M components in one runtime instance. This is easy to set up and requires less resources when compared with a distributed deployment. Although a distributed deployment provides high performance and a high level of scalability, it may be too complex if you want to a small to medium scale API management solution. The all-in-one deployment is ideal if you want to start small and iteratively build up a robust API management platform.

-   [Single Node Deployment](#single-node-deployment)
-   [Active - Active Deployment](#active-active-deployment)

## Single Node Deployment

In this setup, API traffic is served by one all-in-one instance of WSO2 API Manager.

<a href="{{base_path}}/assets/img/setup-and-install/single-node-apim-deployment.png"><img src="{{base_path}}/assets/img/setup-and-install/single-node-apim-deployment.png" alt="single-node api-m deployment"></a>

| Pros                                                                                                               | Cons                                                                                             |
|--------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------|
|    Production support is required only for a single API Manager node (you receive 24\*7 WSO2 production support). 
    Deployment is up and running within hours.                                                                      
    Can handle up to 43 million API calls a day (up to 500 API calls a second)                                      
    Minimum hardware/cloud infrastructure requirements (only one node).                                             
    Suitable for anyone new to API Management.                                                                      |    Deployment does not provide High Availability.                                               
     Not network friendly. Deploying on a demilitarized zone (DMZ) would require a Reverse Proxy.  |

!!! info
    For more information on manually configuring a single node API-M production server, see [Configuring a Single Node]({{base_path}}/install-and-setup/deploying-wso2-api-manager/single-node/configuring-a-single-node/).


## Active - Active Deployment

In this setup, API traffic is served by two single node (all-in-one) instances of WSO2 API Manager.

<a href="{{base_path}}/assets/img/setup-and-install/active-active-apim-deployment.png"><img src="{{base_path}}/assets/img/setup-and-install/active-active-apim-deployment.png" alt="active-active apim deployment"></a>

| Pros                                                                                                    | Cons                                                                        |
|---------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------|
|    The system is highly available.                                                                     
    Production support is required for 2 API Manager nodes (you receive 24\*7 WSO2 production support).  
    Can handle up to 86 million API calls a day ( up to 1000 API calls a second)                         
    Deployment is up and running within hours.                                                           |    Not network friendly. Deploying on a DMZ would require a Reverse Proxy. |

!!! info
    For more information on manually configuring active-active API-M production servers, see [Configuring an Active-Active Deployment]({{base_path}}/install-and-setup/deploying-wso2-api-manager/single-node/configuring-an-active-active-deployment/).
