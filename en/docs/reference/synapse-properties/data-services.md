# Data Services 

The data in your organization can be a complex pool of information that is stored in heterogeneous systems (such as an RDBMS). Data services are created for the purpose of decoupling the data from its infrastructure. In other words, when you create a data service in WSO2 Micro Integrator, the data that is stored in a storage system (such as the RDBMS) can be exposed in the form of a service. This allows users (that may be any application or system) to access the data without interacting with the original source of the data. Data services are, thereby, a convenient interface for interacting with the database layer in your organization.

A data service in WSO2 Micro Integrator is a SOAP-based web service by default. However, you also have the option of creating REST resources, which allows applications and systems consuming the data service to have both SOAP-based and RESTful access to your data.

### Datasources

Your organization's data can be stored in various data storage systems, which are the datasources. The following datasources are currently supported: Relational databases and CSV files.

### RESTful data services

You can enable RESTful access to your data by defining RESTful resources for the relevant data in your data service. REST resources in the Micro Integrator support both JSON and XML media types out of the box. Therefore, a resource can receive requests and send responses in either medium. You can secure your resources with HTTP(S) Basic Auth via [WSO2 Identity Server](http://wso2.com/products/identity-server/).

### OData Services

RESTful data services in WSO2 Micro Integrator supports OData ([OData](http://www.odata.org/) protocol version 4 - OASIS standards),
which makes RESTful data access easier. In a normal data service, you
will write SQL queries for CRUD operations that will be performed on the
data. In other words, to be able to GET, UPDATE, POST, or DELETE data in
a database, the data service should have separate SQL queries written
for each purpose. However, when you enable OData for your RESTful data
service, these CRUD operations will be enabled automatically, which
allows RESTful data access using CRUD operations out of the box.

Currently, OData support is only available for RDBMS datasources. You can use the following endpoint URL: `http://localhost:9763/odata/{dataserviceName}/{datasourceId}/`

### Data Federation

A data service has the ability to aggregate the data that is stored in various, disparate datasources and present the data as a single output. For example, the data of employees in a company may be stored in various data stores (details of employment history, details of the physical office, contact information, etc.). Data federation allows users to consume all this data through a single request to the data service. The data service will aggregate the relevant data from each of the disparate datasources and present it as one response to the request. Data federation can be achieved in two ways:

-   Expose multiple datasources using a single data service.
-   Use Nested Queries in your data service. This will allow you to feed
    the result you get from one query as input to another query. That
    is, data can be combined into a single response or resource.

### Distributed Transactions

A distributed transaction is a set of operations that should be performed on two or more distributed RDBMS data stores. If the operation on one data store (node) fails, the entire set of operations will fail in all the data stores. In other words, a distributed transaction is an example of a batch process, where multiple requests are grouped into one server call and processed as one unit by the data service.

Data services in WSO2 Micro Integrator supports distributed transactions, which allows
data consumers to perform such transactions easily by using one data
service as the interface. Note that distributed transactions can only be
performed for IN-ONLY operations that will insert, update, or delete
data in the data stores. These are not applicable to operations for
retrieving data.

A transaction manager is set up in the middle of these transactions for
effective coordination and management. This feature uses the Java
Transaction API (JTA), which allows distributed transactions to be
carried out across multiple XA resources in a Java environment. You can
also override this transaction manager.

### Batch Processing

A data service is an interface that receives requests from data
consumers and performs the requested tasks in the relevant data stores.
Batch processing allows a data service to group multiple requests into a
batch and process it as a single request. Batch processing can only be
used for IN-ONLY operations that will insert, update, or delete data in
the data stores, and not for operations that retrieve data.

Data services in WSO2 Micro Integrator support two scenarios of batch requesting: Client-side batch requests and server-side batch requests.

For example, consider the task of entering details of new employees into
a database table. Typically, the client consuming the data can do this
by sending separate requests with each employee record. Alternatively,
the client can group the individual requests into a single batch, and
send one batch request to the data service. In this example, the data
service will have one operation defined for inserting data into the
database. However, when batch processing is enabled, it is possible to
insert multiple records into that database, using this operation.
Therefore, the client can invoke this operation using a single request,
to insert multiple records. This is client-side batch requesting.

Consider another example where the client needs to enter the employee’s
bank details along with the personal details, but the bank details
should be inserted to a different data store. In this example, the data
service will have two separate operations for inserting data into two
separate data stores, and the client is invoking both operations using
a single request (also called a request box). This is server-side batch
requesting.

Note that batch requests are transactional if the data store is an RDBMS or another system that supports transactions. Transactional requests succeed or fail as a batch. That is, if one individual request
fails, all the requests in the batch will fail to make sure that the
data is synchronized. Server-side batch requests work for local
transactions (performed on one node of the data store), as well as distributed transactions (performed on multiple nodes of the data store).

### Data Transformation

XSLT transformation is used in data services to transform the result of an already defined operation into a different result. The user can define the transformation xslt and provide the url of the transformation file in the result element.

### Managed Data Access

Most businesses require secure and managed data access across these federated data stores.

### Streaming

Data service streaming helps manage large data chunks sent back to the
client by the data service as the response to a request. When streaming
is enabled, the data is sent to the client as it is generated without
memory building up in the server. By default, streaming is enabled in
data services.

### Namespaces

The service namespace uniquely identifies a Web service and is specified by the `<targetNamespace>` element in the WSDL that
represents the service. A data service is simply a Web service with
specialized functionality. When developing a data service, you get to
apply namespaces at various levels. As a data service implementation is
based on XML, namespace handling is useful for making sure that there
are no conflicting element names in the XML. Although namespaces are
optional for data services, in some scenarios they are necessary.
