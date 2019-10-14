# Configuring a JNDI Datasource

Java Naming and Directory Interface (JNDI) is a Java Application Programming Interface (API) that provides naming and directory functionality for Java software clients, to discover and look up data and objects via a name. It helps decoupling object creation from the object look-up. When you have registered a datasource with JNDI, others can discover it through a JNDI look-up and use it.

When adding a datasource, to expose a RDBMS datasource as a JNDI datasource, click **Expose as a JNDI Data Source** to display the JNDI fields as follows:

![]({{base_path}}/assets/attachments/43977372/44172372.png)
Following are descriptions of the JNDI fields:

-   **Name** : Name of the JNDI datasource that will be visible to others in object look-up.
-   **Use Data Source Factory** : To make the datasource accessible from an external environment, you must use a datasource factory. When this option is selected, a reference object will be created with the defined datasource properties. The datasource factory will create the datasource instance based on the values of the reference object when accessing the datasource from an external environment. In the datasource configuration, this is set as: `<jndiConfig useDataSourceFactory="true">` .
-   **JNDI Properties** : Properties related to the JNDI datasource (such as password).
    When you select this option, set the following properties:
    -`java.naming.factory.initial` :  Selects the registry service provider as the initial context.
    -`java.naming.provider.url` : Specifies the location of the registry when the registry is being used as the initial context.


