# Configuring a Custom Datasource

When adding a datasource, if you select the custom datasource type, the following screen will appear:

![]({{base_path}}/assets/attachments/43977374/44172375.png)
Following are descriptions of the custom datasource fields:

-   **Data Source Type** : Custom
-   **Custom Data Source Type** : Specify whether the data is in a table or accessed through a query as described [below](#ConfiguringaCustomDatasource-CusDSType) .
-   **Name** : Enter a unique name for this datasource
-   **Description** : Description of the datasource
-   **Configuration** : XML configuration of the datasource

### Custom datasource type

When creating a custom datasource, specify whether the datasource type is DS\_CUSTOM\_TABULAR (the data is stored in tables), or DS\_CUSTOM\_QUERY (non-tabular data accessed through a query). More information about each type are explained below.

#### Custom tabular datasources

Tabular datasources are used for accessing tabular data, that is, the data is stored in rows in named tables that can be queried later. To implement tabular datasources, the interface `org.wso2.carbon.dataservices.core.custom.datasource.TabularDataBasedDS` is used. For more information, see a sample implementation of a tabular custom datasource at `InMemoryDataSource` .

A tabular datasource is typically associated with a SQL data services query. WSO2 products use an internal SQL parser to execute SQL against the custom datasource. For more information, see a sample data service descriptor at `InMemoryDSSample` . Carbon datasources also support tabular data with the `org.wso2.carbon.dataservices.core.custom.datasource.CustomTabularDataSourceReader` datasource reader implementation. If you have Data Services Server installed, for more information see the `<PRODUCT_HOME>\repository\conf\datasources\custom-datasources.xml` file, which is a sample Carbon datasource configuration.

#### Custom query datasources

Custom query-based datasources are used for accessing non-tabular data through a query expression. To implement query-based datasources, the `org.wso2.carbon.dataservices.core.custom.datasource.CustomQueryBasedDS` interface is used. You can create any non-tabular datasource using the query-based approach. Even if the target datasource does not have a query expression format, you can create and use your own. For example, you can support any NoSQL type datasource using this type of a datasource.

For more information, see a sample implementation of a custom query-based datasource at `EchoDataSource` , and a sample data service descriptor with custom query datasources in `InMemoryDSSample` . Carbon datasources also support query-based data with the `org.wso2.carbon.dataservices.core.custom.datasource.CustomQueryDataSourceReader` datasource reader implementation. If you have Data Services Server installed, for more information, see the `<PRODUCT_HOME>\repository\conf\datasources\custom-datasources.xml` file, which is a sample Carbon datasource configuration.

In the `init` methods of all custom datasources, user-supplied properties will be parsed to initialize the datasource accordingly. Also, a property named `<__DATASOURCE_ID__>` , which contains a UUID to uniquely identify the current datasource, will be passed. This can be used by custom datasource authors to identify the datasources accordingly, such as datasource instances communicating within a server cluster for data synchronization.

Shown below is an example configuration of a custom datasource of type `<DS_CUSTOM_TABULAR>` :

![]({{base_path}}/assets/attachments/43977374/44172376.png)
After creating datasources, they will appear on the **Data Sources** page. You can edit and delete them as needed by clicking **Edit** or **Delete** links.


