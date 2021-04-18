# Introduction to Multitenancy

The goal of multitenancy is to maximize resource sharing by allowing multiple users (tenants) to log in and use a single server/cluster at the same time, in a tenant-isolated manner. That is, each user is given the experience of using his/her own server, rather than a shared environment. Multitenancy ensures optimal performance of the system's resources such as memory and hardware and also secures each tenant's personal data.

You can register tenant domains using the Management Console of WSO2 products.

!!! info
    When multitenancy is enabled and a tenant becomes inactive for a long period of time, the tenant is unloaded from the server's memory. By default, the time period is 30 minutes. After that, the tenant has to log in again before sending requests to the server.

    You change the default time period allowed for tenant inactiveness by adding `-Dtenant.idle.time=<time_in_minutes>` java property to the product's startup script ( `./api-manager.sh` file for Linux and `api-manager.bat` for Windows) as shown below:

    ``` java
        JAVA_OPTS \
        -Dtenant.idle.time=30 \
    ```

-   [Architecture](#architecture)
-   [Resource sharing](#resource-sharing)
-   [Tenant loading policy](#tenant-loading-policy)
-   [Restrictions](#restrictions)
-   [Request dispatching](#request-dispatching)
-   [Scaling](#scaling)

### Architecture

The multi-tenant architecture of WSO2 products allows you to deploy Web applications, Web services, ESB mediators, mashups etc. in an environment that supports the following:

-   **Tenant isolation:** Each tenant has its own domain, which the other tenants cannot access.
-   **Data isolation:** Each tenant can manage its data securely in an isolated manner.
-   **Execution isolation:** Each tenant can carry out business processes and workflows independent of the other tenants. No action of a tenant is triggered or inhibited by another tenant.
-   **Performance Isolation:** No tenant has an impact on the performance of another tenant.

A tenant is an isolated domain. The users within this domain can manage their own data and perform their own transactions without being affected by actions carried out in other domains.

These domains are allocated server space from the complete server space of a WSO2 product instance which is referred to as the *super tenant*.

The super tenant as well as each individual tenant has its own configuration and context module.

Each tenant has its own security domain. A domain has a set of users, and permissions for those users to access resources. Thus, a tenant is restricted by the users and permissions of the domain assigned to it. The artifact repositories of the tenants are separated from each other.

 [![]({{base_path}}/assets/img/administer/multitenant-architecture.png)]({{base_path}}/assets/img/administer/multitenant-architecture.png)

An individual tenant can carry out the following activities within the boundaries of its own configuration and context module:

-   Deploying artifacts
-   Applying security
-   User management
-   Data management
-   Request throttling
-   Response caching

WSO2 Carbon provides a number of Admin services which have special privileges to manage the server. These admin services are deployed in the super tenant. Other tenants can make use of these admin services to manage their deployment. The admin services operate in a tenant aware fashion. Thus, privileges and restrictions that apply to any client using an admin service are taken into account.

### Resource sharing

WSO2 Carbon supports the following methods for sharing resources among tenants:

-   **Private Jet mode** : This method allows the load of a tenant ID to be deployed in a single tenant mode. A single tenant is allocated an entire service cluster. The purpose of this approach is to allow special privileges (such as priority processing and improved performance) to a tenant.
-   **Separation at hardware level** : This method allows different tenants to share a common set of resources, but each tenant has to run its own operating system. This approach helps to achieve a high level of isolation, but it also incurs a high overhead cost.
-   **Separation at JVM level** : This method allows tenants to share the same operating system. This is done by enabling each tenant to run a separate JVM instance in the operating system.
-   **Native multitenancy** : This method involves allowing all the tenants to share a single JVM instance. This method minimises the overhead cost.

### Tenant loading policy

Lazy loading is a design pattern used specifically in cloud deployments to prolong the initialization of an object or artifact until it is requested by a tenant or an internal process. In WSO2 products based on Carbon 4.4.0 or later versions, you have the option of setting the required tenant loading policy by enabling either **Lazy Loading** or **Eager Loading** of tenants. Additionally, you can separately control the loading policy for web applications and axis2 services deployed in your tenants using the **GhostDeployment** setting.

See [Configuring the Tenant Loading Policy](https://docs.wso2.com/display/ADMIN44x/Configuring+the+Tenant+Loading+Policy) for more information.

### Restrictions

The following restrictions are imposed to ensure that each individual tenant has the required level of isolation and maintains fine-grained security control over its own services without affecting the other tenants.

-   Only the super tenant can modify its own configuration. In addition, it can add, view and delete tenants.
-   When a tenant logs into the system, it can only access artifacts deployed under its own configuration. One tenant cannot manipulate the code of another tenant.
-   The super admin or tenant admin can add user stores to their own domain. Dynamic configurations are possible only for secondary user stores and the primary user store is not configurable at run time. This is because primary user stores are available for all tenants and allowing changes to the configuration at run time can lead to instability of the system. Therefore, the primary user store is treated as a static property in the implementation and it should be configured prior to run time.
-   A tenants code cannot invoke sensitive server side functionality. This is achieved via Java security.
-   Tenants share the transports provided by the system. They are not allowed to create their own transports.

### Request dispatching

This section describes how the multi tenancy architecture described above works in a request dispatching scenario.

When a Carbon server receives a request, the message is first received by the handlers and dispatchers defined for the server configuration (i.e. super tenant). The server configuration may include handlers that implement cross tenant policies and Service Level Agreement (SLA) management. For example, a priority based dispatcher can be applied at this stage to offer differentiated qualities of service to different clients. Once the relevant handlers and dispatchers are applied, the request is sent to the tenant to which it is addressed. Then the message dispatchers and handlers specific to that tenant will be applied.

The following example further illustrates how message dispatching is carried out in a multi tenant server.

For example, two tenants named foo.com and bar.com may deploy a service named MyService. When this service is hosted on the two tenants, they would have the following URLs.

`http://example.com/t/foo.com/services/MyService`
`http://example.com/t/bar.com/services/MyService`

The name of the tenant in the URL allows the tenant to be identified when the Carbon server receives a message which is addressed to a specific client. Alternatively, you may configure a CNAME record in DNS (Domain Name System) as an alias for this information.

If a request is addressed to the `MyService` service hosted by `foo.com` , the message handlers and dispatchers of the super tenant will be applied and the tenant `foo.com` will be identified by the tenant name in the URL. Then the request will be sent to `foo.com` where it will be processed.

### Scaling

The multi tenancy architecture described above mainly refers to a scenario where a single instance of a Carbon server acts as a single multi tenant node. In a situation where a very high load of requests are handled, you may need multiple multi tenant nodes. In order to operate with multiple multi tenant nodes, you need load balancing. The load balancer you use also needs to be tenant-aware.
