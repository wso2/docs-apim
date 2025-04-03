# API Manager Analytics

API Manager analytics provides insights into the API usage, performance, and other key metrics to help API publishers and consumers make informed decisions. The analytics dashboard provides a comprehensive view of the API traffic, user engagement, and other relevant data. This section provides an overview of the analytics features available in WSO2 API Manager and guidance on how to use them effectively.

## Architecture

<a href="{{base_path}}/assets/img/analytics/analytics-architecture.png" >
  <img src="{{base_path}}/assets/img/analytics/analytics-architecture.png" alt="APIM Analytics Architecture"/>
</a>

Analytics architecture consists with the following components

- **Inbound Analytics**
- **Outbound Analytics** 
    - **AI Analytics**

### Inbound Analytics

As above diagram shows, Inbound Analytics consists with analytics data that are collected between the user and API Proxy. This includes apiContext, proxyResponseCode, proxyResponseCode, apiType etc.

### Outbound Analytics

Outbound Analytics consists with analytics data that are collected between the API Proxy and the backend service. This includes targetResponseCode, backendLatency, destination etc.

### AI Analytics

AI Analytics shows the Outbound analytics data that are specific to AI APIs. This includes aiTokenUsage, vendorName, vendorVersion, model, promptTokens, completionTokens and totalTokens.

WSO2 API Manager supports multiple platforms to monitor and analyze API traffic. This includes:

- [**Choreo Analytics**](choreo-analytics/api-analytics-architecture.md) - A SaaS based API analytics platform that provides real-time insights into API traffic, performance, and user engagement.
- [**ELK Base Analytics Solution**](on-prem/elk-installation-guide.md) - Native support for Elasticsearch, Logstash, and Kibana (ELK) stack to monitor and analyze API traffic.
- [**DataDog Based Analytics Solution**](on-prem/datadog-installation-guide.md) - Integration with DataDog to monitor and analyze API traffic.