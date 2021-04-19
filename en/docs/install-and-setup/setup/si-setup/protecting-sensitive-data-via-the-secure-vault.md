# Protecting Sensitive Data via the Secure Vault

The Streaming Integrator uses several artifacts for its functionality including deployment configurations for tuning its operation as well as deployable artifacts for extending its functionality. In each of these scenarios, there can be situations where the data specified is of a sensitive nature e.g., access tokens, passwords, etc.

## Securing sensitive data in deployment configurations

The Streaming Integrator offers the Cipher tool to encrypt sensitive data in deployment configurations. This tool works in conjunction with WSO2 Secure Vault to replace sensitive data that is in plain text with an alias. The actual value is then encrypted and securely stored in the SecureVault. At runtime, the actual value is retrieved from the alias and used. For more information, see [WSO2 Secure Vault](https://github.com/wso2/carbon-secvault/blob/master/README.md).

1. Open the `<SI_HOME>|<SI_TOOLING_HOME>/conf/server/secrets.properties` file and enter the following information:

    1. Enter the required sensitive data element with the value in plain text as shown in the example below.
        `wso2.sample.password1=plainText ABC@123`

    2. Enter the alias to be used in the required configuration file instead of the actual value of sensitive data you specified in the previous step as shown in the example below.
        `password: ${sec:wso2.sample.password1}`

2. To encrypt the sensitive data element and store it in the secure vault, run the Cipher tool by issuing the following command.
    `sh <SI_HOME>|<SI_TOOLING_HOME>/bin/ciphertool.sh -runtime server`


## Protecting sensitive data in Siddhi applications

A parameter named ref is used to secure sensitive information in Siddhi applications that are deployed in the Streaming Integrator. For Siddhi applications that use storage technologies supported by [Carbon Data sources](configuring-datasources), it is also possible to use Carbon data sources instead of specifying the connection parameters directly on the Siddhi file.

### Using the ref parameter

Siddhi 4.0 supports the ref parameter that enables the user to specify parts of their definition outside the Siddhi App. Extensions that support this functionality include:

- Stores
- Sources
- Sinks

This method of securing sensitive data involves defining the store parameters required via a connection instance in the `<SI_HOME>|<SI_TOOLING_HOME>/conf/server/deployment.yaml` file, and referring to those from Siddhi applications via the `ref` parameter.

**Example**

In the `<SI_HOME>/conf/server/deployment.yaml` file, some connection parameters are defined for a store named `store1` as follows:

```
siddhi:
   refs:
      -
         ref:
            name: 'store1'
            type: 'rdbms'
            properties:
                jdbc.url: 'jdbc:h2:./repository/database/ANALYTICS_EVENT_STORE'
                username: 'root'
                password: ${sec:store1.password}
                field.length='currentTime:100'
                jdbc.driver.name: 'org.h2.Driver'
```

The Siddhi application includes the following configuration:

```
@Store(ref='store1')
@PrimaryKey('id')
@Index('houseId')
define table SmartHomeTable (id string, value float, property bool, plugId int, householdId int, houseId int, currentTime string);
```

Here `@Store(ref='store1')` refers to `store1` defined in the `deployment.yaml` file. As a result, the properties defined for this store are applicable to the Siddhi application when it is connected to the store.

### Using carbon datasources

Currently, Carbon Data sources only support relational data source definitions. You can also define RDBMS Store artifacts using Carbon Data sources or JNDI instead of directly specifying the connection parameters. Then the datasource definitions defined in the `<SI_HOME>|<SI_TOOLING_HOME>/conf/server/deployment.yaml` file can be secured via the process described under [Securing sensitive data in deployment configurations](#securing-sensitive-data-in-deployment-configurations).
