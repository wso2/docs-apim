# Working with Service Catalog

Service Catalog is one of the main attributes which enables the API-first Integration in WSO2 API Manager. Through the Service Catalog, integration services are made discoverable to the API Management layer so that API proxies can directly be created using them.

## Getting Started with Service Catalog

1. Go to the **Publisher Portal** (https://localhost:9443/publisher)
2. Click on the **Hamburger Icon** on the top left corner of the page.
3. Select the **Service Catalog** Menu as follows.

![Service Catalog Menu]({{base_path}}/assets/img/integrate/service-catalog/go-to-service-catalog.png)

If this is the first time you work with the Service Catalog, you will see the following **onboarding page** where you can easily get started with your first integration service.

![Service Catalog Onboarding Page]({{base_path}}/assets/img/integrate/service-catalog/service-catalog-onboarding-page.png)

There are 2 options where you can either

1. Deploy a sample service by clicking on the **Add Sample Service** button or,
2. Deploy your own Integration Service through the Micro Integrator. You can get the relevant instructions by clicking on the **Get Started** button. 

## Manage Services

#### Discover Services

Once you have services deployed, you can view the list of available services by accessing the Service Catalog Menu. 

1. Click on the **Hamburger Icon** in the top left corner of the web page.
2. Select the **Service Catalog** Menu.

Here you will not see an onboarding page but a listing of the deployed services as follows. You can **view** and **search** for all the deployed services from this interface. To search for services, click on the search icon on the top right corner of the listing table shown in the diagram below.

![Service Catalog Listing Page]({{base_path}}/assets/img/integrate/service-catalog/service-catalog-listing.png)

#### View information of a specific Service

You can view the detailed information of a specific service by clicking on the **Service** name from the service listing page.

Click on **Hamburger Icon** -> Select **Service Catalog** -> Click on the **service name**

![Click on service name]({{base_path}}/assets/img/integrate/service-catalog/service-name.png)

You will be directed to the **service overview** page as follows where you can view service information such as service name, version, description, usages in APIs and other important metadata.

![Service Overview]({{base_path}}/assets/img/integrate/service-catalog/service-overview.png)

##### Download a Service Definition

Through the service overview page, it is possible to download the service definition. For this you can click on the **Download** button against the Service Definition as shown below.

Click on the **service name** from the listing -> Go to **Service Definition** -> Click **Download**

![Download Service]({{base_path}}/assets/img/integrate/service-catalog/download-service.png)

##### View the Service Definition

To view the definition of a service, you can click on the **View Definition** button in the service overview page.

Click on the **service name** from the listing -> Go to **Service Definition** -> Click **View Definition**

![View service definition]({{base_path}}/assets/img/integrate/service-catalog/view-service-definition.png)

#### View APIs that use a specific Service

In order to view the list of APIs that use a specific service, you can click on the **Number of Usages** in the **service listing** page or click on the link depicting the number of usages in the **service overview** page as shown below.

![API usage in Service Listing page]({{base_path}}/assets/img/integrate/service-catalog/service-listing-usage.png)

![API usage in Service Overview page]({{base_path}}/assets/img/integrate/service-catalog/service-overview-usage.png)

You can access the relevant API from the API usage list by clicking on the API name as shown below.

![API usage list]({{base_path}}/assets/img/integrate/service-catalog/service-usage-view.png)

## Create an API from a Service

You can create an API from a service by clicking on the **Create API** button in the service listing page or the service overview page.

![Create API from Service]({{base_path}}/assets/img/integrate/service-catalog/create-api-from-service.png)

Provide the API Name, Context and Version where all fields are mandatory, and click **Create API**. You will then be directed to the overview page of the API created from the service.
