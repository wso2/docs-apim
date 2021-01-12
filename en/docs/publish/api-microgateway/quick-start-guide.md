# Quick Start Guide

## Design Your First API

This section is a step-by-step guide to create, publish, and invoke an API using WSO2 API Microgateway.

### Before you begin...

1. Install [docker](https://docs.docker.com/engine/install/).
2. Install the [docker-compose](https://docs.docker.com/compose/install/).

### Objectives
1. Setup Microgateway and CLI tool (APICTL).
2. Create and deploy an API project.
3. Invoke the API using a generated key.

 Let's get started...
 
### Step 1 - Setup Microgateway and CLI tool(APICTL)

1.  Download the CLI tool(APICTL) and the microgateway distribution from the 
    [github release page's](https://github.com/wso2/product-microgateway/releases) Assets and 
    extract them to a folder of your choice.
    
    From here onwards, CLI tool extracted location will be referred as `CLI_HOME` and Microgateway distribution extracted 
    location would be referred as `MG_HOME`.

2.  Using your command line client tool add the 'CLI_HOME' folder to your PATH variable.

    ``` bash
    export PATH=$PATH:<CLI_HOME>
    ```

### Step 2 - Create and deploy an API project

1.  Let's create our first project with name "petstore" by adding the 
    [open API definition](https://petstore.swagger.io/v2/swagger.json) of the petstore . 
    You can do that by executing the following command using your command line tool.
    
    ``` bash
    apictl init petstore --oas https://petstore.swagger.io/v2/swagger.json
    ```

    The project is now initialized. You should notice a directory with name "petstore" being created in the location 
    where you executed the command. 

2.  Now lets start the microgateway on docker by executing the docker compose script inside the `MG_HOME`. 
    Navigate to `MG_HOME` and execute the following command.

    ``` bash
    docker-compose up -d
    ```
    
    Once containers are up and running, we can monitor the status of the containers using the following command
    
    ``` bash
    docker ps | grep mg-
    ```

3.  Now let's deploy our first API to Microgateway using the project created in the step 3. 
    Navigate to the location where the petstore project was initialized.
    Execute the following command to deploy the API in the microgateway.
       
    ``` bash
    apictl mg deploy --host https://localhost:9843 --file petstore  -u admin -p admin -k
    ```
    
    !!! note  
        The user credentials can be configured in the configurations of the `MG_HOME` distribution. 
        `admin:admin` is the default accepted credentials by the microgateway adapter.
        Go to `MG_HOME/resources/conf/config.toml` and modify as below.
        
        ``` toml
        [[adapter.server.users]]
        username = "admin"
        password = "admin"
        ``` 
        
### Step 3 - Invoke the API

1.  The next step would be to invoke the API using a REST tool. Since APIs on the Microgateway are by default secured. 
    We need a valid token in order to invoke the API. 
    Use the following sample token accepted by the microgateway to access the API. 
    Lets set the token to command line as a variable.
    
    ``` bash
    TOKEN=eyJ4NXQiOiJNell4TW1Ga09HWXdNV0kwWldObU5EY3hOR1l3WW1NNFpUQTNNV0kyTkRBelpHUXpOR00wWkdSbE5qSmtPREZrWkRSaU9URmtNV0ZoTXpVMlpHVmxOZyIsImtpZCI6Ik16WXhNbUZrT0dZd01XSTBaV05tTkRjeE5HWXdZbU00WlRBM01XSTJOREF6WkdRek5HTTBaR1JsTmpKa09ERmtaRFJpT1RGa01XRmhNelUyWkdWbE5nX1JTMjU2IiwiYWxnIjoiUlMyNTYifQ==.eyJhdWQiOiJBT2syNFF6WndRXzYyb2QyNDdXQnVtd0VFZndhIiwic3ViIjoiYWRtaW5AY2FyYm9uLnN1cGVyIiwibmJmIjoxNTk2MDA5NTU2LCJhenAiOiJBT2syNFF6WndRXzYyb2QyNDdXQnVtd0VFZndhIiwic2NvcGUiOiJhbV9hcHBsaWNhdGlvbl9zY29wZSBkZWZhdWx0IiwiaXNzIjoiaHR0cHM6Ly9sb2NhbGhvc3Q6OTQ0My9vYXV0aDIvdG9rZW4iLCJrZXl0eXBlIjoiUFJPRFVDVElPTiIsImV4cCI6MTYyNzU0NTU1NiwiaWF0IjoxNTk2MDA5NTU2LCJqdGkiOiIyN2ZkMWY4Ny01ZTI1LTQ1NjktYTJkYi04MDA3MTFlZTJjZWMifQ==.otDREOsUUmXuSbIVII7FR59HAWqtXh6WWCSX6NDylVIFfED3GbLkopo6rwCh2EX6yiP-vGTqX8sB9Zfn784cIfD3jz2hCZqOqNzSUrzamZrWui4hlYC6qt4YviMbR9LNtxxu7uQD7QMbpZQiJ5owslaASWQvFTJgBmss5t7cnurrfkatj5AkzVdKOTGxcZZPX8WrV_Mo2-rLbYMslgb2jCptgvi29VMPo9GlAFecoMsSwywL8sMyf7AJ3y4XW5Uzq7vDGxojDam7jI5W8uLVVolZPDstqqZYzxpPJ2hBFC_OZgWG3LqhUgsYNReDKKeWUIEieK7QPgjetOZ5Geb1mA==
    ``` 

2.  We can now invoke the API running on the microgateway using cURL as below.

    ``` bash
    curl -X GET "https://localhost:9095/v2/pet/findByStatus?status=available" -H "accept: application/json" -H "Authorization:Bearer $TOKEN" -k
    ```

Congratulations! You have successfully created your first API, and invoked it via the API Microgateway.
