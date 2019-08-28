# Initializing projects using the CLI Tool

The WSO2 API Manager Command Line Interface(CLI) tool can be used to create APIs without using the API Publisher portal. You can use this feature to create an API specification when you already have a Swagger or Open API specification of your API.

-   [Create a new API project](#InitializingprojectsusingtheCLITool-CreateanewAPIproject)
-   [Generate API projects using a Swagger/Open API specification](#InitializingprojectsusingtheCLITool-GenerateAPIprojectsusingaSwagger/OpenAPIspecification)
-   [Change the default API template](#InitializingprojectsusingtheCLITool-ChangethedefaultAPItemplate)
-   [Generate APIs with dynamic data](#InitializingprojectsusingtheCLITool-GenerateAPIswithdynamicdata)

!!! note
Deploy the API import/export tool

The page: **Migrating the APIs and Applications to a Different Environment** was not found. Please check/update the page name used in the 'multiexcerpt-include macro.


### Create a new API project

1.  Open a terminal window and navigate to the path you need to create the project.
2.  Execute the command given below to initialize a new API project.

    -   [**Command**](#c7c6d99ddaf04440a91fb22d394201cb)
    -   [**Sample**](#2f958070258943e893a7ed4836bb2e58)
    -   [**Output**](#78bdf8eda9c14d499dad03985075fa60)

    ``` java
        apimcli init <Project Path>
    ```

    ``` java
            apimcli init SampleAPI
    ```

    ``` java
            Initializing a new WSO2 API Manager project in /home/user/work/SampleAPI
            Project initialized
            Open README file to learn more
    ```

3.  A project folder with the following structure will be created in the given directory.

    ``` java
            ├── api_params.yaml
            ├── Docs
            │   └── FileContents
            ├── Image
            ├── Meta-information
            │   ├── api.yaml
            │   └── swagger.yaml
            ├── README.md
            └── Sequences
                ├── fault-sequence
                ├── in-sequence
                └── out-sequence
    ```

    <table>
    <thead>
    <tr class="header">
    <th>File/folder</th>
    <th>Description</th>
    </tr>
    </thead>
    <tbody>
    <tr class="odd">
    <td><code>               api.yaml              </code></td>
    <td>The specification of the created API.</td>
    </tr>
    <tr class="even">
    <td><code>               swagger.yaml              </code></td>
    <td>The swagger file generated when the API is created.</td>
    </tr>
    <tr class="odd">
    <td><code>               api_params.yaml              </code></td>
    <td><div class="content-wrapper">
    <p>Contains environment-specific details.</p>
        !!! note
        <p>To set a CI/CD pipeline you need to edit the configurations in this file. For instructions on how to use it, see Migrating the APIs to a Different Environment .</p>

    </div></td>
    </tr>
    <tr class="even">
    <td><pre><code>Sequences
        ├── fault-sequence
        ├── in-sequence
        └── out-sequence</code></pre></td>
    <td>To add custom sequences, save them in xml format and add them to the corresponding folder. E.g., To add a custom in-sequence, save the custom sequence as <code>               SampleSequence.xml              </code> and add it to the <code>               Sequences/in-sequence/              </code> directory.</td>
    </tr>
    </tbody>
    </table>

4.  Open the `           api.yaml          ` file. You can edit the mandatory configurations listed below.

    | Field                                        | Description                                             |
    |----------------------------------------------|---------------------------------------------------------|
    | `               apiName              `       | The name of API without spaces.                         |
    | `               context              `       | Context of the API in API Manager with a leading slash. |
    | `               productionUrl              ` | Production endpoint for API.                            |
    | `               sandboxUrl              `    | Sandbox endpoint for API.                               |

    For more information about the configurations, go to the [gist](https://gist.github.com/kasvith/01e704611b6c301f470ab0e3b5cb0607) .

    **api.yaml**

    ``` java
        id:
          providerName: admin
          apiName: ""
          version: 1.0.0
        type: HTTP
        context: ""
        availableTiers:
        - name: Unlimited
        status: CREATED
        visibility: public
        transports: http,https
        productionUrl: http://localhost:8080
        sandboxUrl: http://localhost:8081
    ```

5.  After editing the mandatory fields, you can import the API using the following command.

    ``` java
            apimcli import-api --file ./SampleAPI --environment dev
    ```

    For more information, see Migrating the APIs to a Different Environment .

        !!! note
    To publish the API immediately after importing, set the `           status          ` field to " `           PUBLISHED"          `


### Generate API projects using a Swagger/Open API specification

1.  You can user Swagger2 and OpenAPI3 specifications to generate an API. File format should be yaml or json. A sample command is given below.

    ``` java
        apimcli init --oas <Path to API specification>/SampleAPI
    ```

2.  To import the created API to your preferred environment, use the command given below.

    ``` java
            apimcli import-api -f <Path to API> -e <Environment>
    ```

!!! tip
You can also initialize an API project from a remote Swagger/Open API specification. The sample command is given below.

``` java
    apimcli init --oas https://petstore.swagger.io/v2/swagger.json PetstoreAPI
```


### Change the default API template

APIs are generated using a default template specified in the `         HOME/.wso2apimcli/default_api.yaml        ` file. You can edit this file to change how the API projects are initialized. This file contains the same notation as the `         api.yaml        ` file.

### Generate APIs with dynamic data

You can initialize APi projects with dynamic data using an additional definition file. The definition file will have the field names (e.g., apiName, version) as variables. A sample is shown below.

**sample-additional-definition.yaml**

``` java
    id:
      providerName: admin
      apiName: $APINAME
      version: $APIVERSION
```

Execute the following command to create the project.

``` java
    apimcli init MyAPI --definition <path>/definition.yaml
```

When executing the command, the CLI tool automatincally injects the values to the API definition.

!!! note
To make this work you will need to set up required environment variables according to your OS. In a Linux/Unix environment, it can be done using

``` java
    export APINAME=MyAPI
    export APIVERSION=1.0.0
```


