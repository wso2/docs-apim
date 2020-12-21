**Deploying on WSO2 Enterprise Integrator 7**

You can copy the composite application to the <PRODUCT-HOME>/repository/deployment/server/carbonapps folder and start the server. Micro Integrator will be started and the composite application will be deployed. You can further refer to the application deployed through the CLI tool. You can download the CLI tool from [here](https://wso2.com/integration/micro-integrator/) from the `Other Resources` section. Make sure you first export the PATH as below.

  ```
    $ export PATH=/path/to/mi/cli/directory/bin:$PATH
  ```

1. Log in to Micro Integrator using the following command.

    ```
    ./mi remote login
    ```

2. Provide default credentials admin for both username and password.
3. In order to view the APIs deployed, execute the following command.

    ```
    ./mi api show
    ```

??? note "Click here for instructions on deploying on WSO2 Enterprise Integrator 6"
    1. You can copy the composite application to the <PRODUCT-HOME>/repository/deployment/server/carbonapps folder and start the server. 

    2. WSO2 EI server starts and you can login to the Management Console https://localhost:9443/carbon/ URL. Provide login credentials. The default credentials will be admin/admin. 

    3. You can see that the API is deployed under the API section. 