# Configuring System Parameters for Siddhi Extensions

The pre-written Siddhi extensions supported by the Streaming Integrator are configured with default values for system 
parameters. If you need to override those values, you can refer to those extensions from the 
`<SI_HOME>/conf/<RUNTIME>/deployment.yaml` file and add the system parameters with the required values as key-value 
pairs. To do this, follow the procedure below:

1. Open the `<SI_HOME>/conf/server/deployment.yaml` file.    

2. The extensions belong to the Siddhi component. Therefore, to edit the Siddhi component, add a main section to the 
   file named `siddhi`. Then add a subsection named `extensions` to indicate that the configurations related to Siddhi 
   extensions as shown below.

   ``` xml
   siddhi:
     extensions:
   ```

3. For each separate extension you want to configure, add a sub-section named `extension` under the `extensions` subsection.
    ``` xml
    siddhi:
      extensions:
        - extension:
    ```

4. Under each `extension` subsection, add two key-value pairs as follows.

    | Key                                      | Value                                                                       |
    |------------------------------------------|-----------------------------------------------------------------------------|
    | `name`      | The name of the extension. e.g., `tcp` |
    | `namespace` | The archetype of the extension. e.g., `source` |

    !!! info
        The archetypes of extensions supported are `source`, `sink`, `execution`, `io`, `map` , `script`, and `store`.
    

5. Add a subsection named properties to overide the system properties. Then add the system properties with the required 
   values as key value pairs, as shown below.

    ``` xml
    siddhi: 
      extensions: 
        - extension: 
            name: [extension-name]
            namespace: [extension-namespace]
            properties: 
              [key]: [value]
    ```

Following are examples for overriding default values for system properties.

**Example 1: Defining host and port for TCP**

``` xml
siddhi: 
  extensions: 
    - extension: 
        name: tcp
        namespace: source
        properties: 
          host: 0.0.0.0
          port: 5511
```

**Example 2: Overwriting the default RDBMS configuration**

``` xml
siddhi:
  extensions:
    - extension:
        name: rdbms
        namespace: store
        properties:
          mysql.batchEnable: true
          mysql.batchSize: 1000
          mysql.indexCreateQuery: "CREATE INDEX {{TABLE_NAME}}_INDEX ON {{TABLE_NAME}} ({{INDEX_COLUMNS}})"
          mysql.recordDeleteQuery: "DELETE FROM {{TABLE_NAME}} {{CONDITION}}"
          mysql.recordExistsQuery: "SELECT 1 FROM {{TABLE_NAME}} {{CONDITION}} LIMIT 1"
```
