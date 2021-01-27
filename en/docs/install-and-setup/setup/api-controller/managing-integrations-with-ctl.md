# Managing Integrations with CTL

WSO2 API Controller, **apictl** allows you to monitor the Synapse artifacts (deployed in a specified Micro Integrator server) and perform various management and administration tasks from the command line.

!!! info
    **Before you begin** 

    -  Ensure that WSO2 Micro Integrator is started, if not follow the steps in [Installing via the Installer]({{base_path}}/install-and-setup/install/installing-the-product/install-mi-in-vm-installer).

    -  Make sure the CTL is downloaded and initialized, if not follow the steps in [Download and Initialize the CTL Tool]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller/#download-and-initialize-the-ctl-tool).

    -  Ensure that the Micro Integrator management endpoint is added to the environment configurations of CTL, before you start working with the following CTL commands. For more information, see [Add an Environment]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller/#add-an-environment).

## Login to a Micro Integrator

After adding an environment, you can login to the Micro Integrator instance of that environment using credentials.

1.  Run any of the following CTL commands to login to a Micro Integrator.

    -   **Command**

        ```go
        apictl mi login <environment-name> -k
        ```

        ```go
        apictl mi login <environment-name> -u <username> -k
        ```

        ```go
        apictl mi login <environment-name> -u <username> -p <password> -k
        ``` 

        !!! tip
            If you run `apictl mi login <environment-name>` you are prompted to provide both the username and the password.
            If you run `apictl mi login <environment-name> --username <username>`, you are prompted to provide the password.

        !!! info
            **Flags:**
            
            -    Optional :     
                `--username` or `-u` : Username for login  
                `--password` or `-p` : Password for login     
                `--password-stdin` : Get password from stdin  

        !!! example
            ```bash
            apictl mi login dev -k
            ```
            ```bash
            apictl mi login dev -u admin -p admin -k
            ```
            
            ```bash
            apictl mi login dev --username admin --password admin -k
            ```
                 
    -   **Response**

        ``` bash tab="Response Format"
        Logged into MI in '<environment-name>' environment 
        ```

        ```bash tab="Example Response"
        Logged into MI in dev environment
        ```

    !!! warning
        Using `--password` in CTL is not secure. You can use `--password-stdin` instead. For example,
        ```bash
        cat ~/.mypassword | ./apictl mi login dev --username admin --password-stdin -k
        ```          

## Logout from a Micro Integrator

1.  Run the following command to logout from the current session of the Micro Integrator.

    -   **Command** 

        ```go
        apictl mi logout <environment-name>
        ```

        !!! example
            ```go
            apictl mi logout dev
            ```
    
    -   **Response**

        ``` bash tab="Response Format"
        Logged out from MI in '<environment-name>' environment 
        ```

        ```bash tab="Example Response"
        Logged out from MI in dev environment
        ```

## Manage Users

### Get information about users

1.  List users of the Micro Integrator.

    -   **Command**
        ``` bash
        apictl mi get users -e <environment>
        ```

        !!! info
            **Flags:**

            -   Required :  
                `--environment` or `-e` : Environment of the Micro Integrator to be searched
            -   Optional :  
                `--format` : pretty-print using templates  
                `--pattern` or `-p` : Filter users by regex  
                `--role` or `-r` : Filter users by role

        !!! example
            ```bash
            apictl mi get users -e dev
            ```
            ```bash
            apictl mi get users -r admin -e dev
            ```
            ```bash
            apictl mi get users -p *tester* -e dev
            ```

    -   **Response**

        ```go
        USER ID
        admin
        capp-tester
        ```

2.  Get information on a specific user.

    -   **Command**
        ``` bash
        apictl mi get users [user-name] -e <environment>
        ```

        !!! info
            **Flags:**

            -   Required :  
                `--environment` or `-e` : Environment of the Micro Integrator to be searched
            -   Optional :  
                `--format` : pretty-print using templates

        !!! example
            ```bash
            apictl mi get users capp-tester -e dev
            ```

    -   **Response**

        ```go
        Name - capp-tester
        Is Admin - true
        Roles - Internal/everyone, admin
        ```

### Add a new user

You can use the command below to add a new user to a Micro Integrator.

-   **Command**
    ``` bash
    apictl mi add user [user-name] -e <environment>
    ```

    !!! info
        **Flags:**

        -   Required :  
            `--environment` or `-e` : Environment of the Micro Integrator to be searched

    !!! example
        ```bash
        apictl mi add user capp-tester -e dev
        ```

-   **Response**

    ```go
    Adding new user [ capp-tester ] status: Added
    ```

### Delete a user

You can use the command below to remove a user from the Micro Integrator.

-   **Command**
    ``` bash
    apictl mi delete user [user-name] -e <environment>
    ```

    !!! info
        **Flags:**

        -   Required :  
            `--environment` or `-e` : Environment of the Micro Integrator to be searched

    !!! example
        ```bash
        apictl mi delete user capp-tester -e dev
        ```

-   **Response**

    ```go
    Deleting user [ capp-tester ] status: Deleted
    ```

## Monitor Integration Artifacts

Follow the instructions below to display a list of artifacts or get information about a specific artifact in an environment using CTL:

### Composite Applications (CApps)

1.  List composite applications (CApps) in an environment.

    -   **Command**
        ``` bash
        apictl mi get composite-apps -e <environment>
        ```

        !!! info
            **Flags:**

            -   Required :  
                `--environment` or `-e` : Environment of the Micro Integrator to be searched
            -   Optional :  
                `--format` : pretty-print using templates

        !!! example
            ```bash
            apictl mi get composite-apps -e dev
            ```

    -   **Response**

        ```go
        NAME                            VERSION
        HealthCareCompositeExporter     1.0.0
        FoodServiceCApp                 2.0.0
        ```

2.  Get information on a specific composite application in an environment.

    -   **Command**
        ``` bash
        apictl mi get composite-apps [capp-name] -e <environment>
        ```

        !!! info
            **Flags:**

            -   Required :  
                `--environment` or `-e` : Environment of the Micro Integrator to be searched
            -   Optional :  
                `--format` : pretty-print using templates

        !!! example
            ```bash
            apictl mi get composite-apps HealthCareCompositeExporter -e dev
            ```

    -   **Response**

        ```go
        Name - HealthCareCompositeExporter
        Version - 1.0.0
        Artifacts :
        NAME                      TYPE
        sample-local-entry        local-entry
        email-connector           lib
        in-memory-message-store   message-store
        GrandOakEndpoint          endpoint
        sample_seq_template       template
        scheduled-msg-processor   message-processors
        sample_template           template
        HealthcareAPI             api
        sample-sequence           sequence
        PineValleyEndpoint        endpoint
        StockQuoteProxy           proxy-service
        sample-cron-task          task
        httpInboundEP             inbound-endpoint
        ```

### Integration APIs

1.  List integration APIs in an environment.

    -   **Command**
        ``` bash
        apictl mi get apis -e <environment>
        ```

        !!! info
            **Flags:**

            -   Required :  
                `--environment` or `-e` : Environment of the Micro Integrator to be searched
            -   Optional :  
                `--format` : pretty-print using templates

        !!! example
            ```bash
            apictl mi get apis -e dev
            ```

    -   **Response**

        ```go
        NAME              URL
        HealthcareAPI     http://localhost:8290/healthcare
        FoodService       http://localhost:8480/foodservice
        ```

2.  Get information on a specific integration API in an environment.

    -   **Command**
        ``` bash
        apictl mi get apis [api-name] -e <environment>
        ```

        !!! info
            **Flags:**

            -   Required :  
                `--environment` or `-e` : Environment of the Micro Integrator to be searched
            -   Optional :  
                `--format` : pretty-print using templates

        !!! example
            ```bash
            apictl mi get apis HealthcareAPI -e dev
            ```

    -   **Response**

        ```go
        Name - HealthcareAPI
        Version - N/A
        Url - http://localhost:8290/healthcare
        Stats - disabled
        Tracing - disabled
        Resources :
        URL                    METHOD
        /doctor/{doctorType}   [GET]
        /report                [GET]
        ```

### Connectors

1.  List connectors in an environment.

    -   **Command**
        ``` bash
        apictl mi get connectors -e <environment>
        ```

        !!! info
            **Flags:**

            -   Required :  
                `--environment` or `-e` : Environment of the Micro Integrator to be searched
            -   Optional :  
                `--format` : pretty-print using templates

        !!! example
            ```bash
            apictl mi get connectors -e dev
            ```

    -   **Response**

        ```go
        NAME        STATS         PACKAGE                       DESCRIPTION
        email       enabled       org.wso2.carbon.connector     WSO2 email connector library
        ```

### Data Services

1.  List data services in an environment.

    -   **Command**
        ``` bash
        apictl mi get data-services -e <environment>
        ```

        !!! info
            **Flags:**

            -   Required :  
                `--environment` or `-e` : Environment of the Micro Integrator to be searched
            -   Optional :  
                `--format` : pretty-print using templates

        !!! example
            ```bash
            apictl mi get data-services -e dev
            ```

    -   **Response**

        ```go
        NAME                WSDL 1.1                                                WSDL 2.0
        RESTDataService     http://localhost:8290/services/RESTDataService?wsdl     http://localhost:8290/services/RESTDataService?wsdl2
        ```

2.  Get information on a specific data service in an environment.

    -   **Command**
        ``` bash
        apictl mi get data-services [data-service-name] -e <environment>
        ```

        !!! info
            **Flags:**

            -   Required :  
                `--environment` or `-e` : Environment of the Micro Integrator to be searched
            -   Optional :  
                `--format` : pretty-print using templates

        !!! example
            ```bash
            apictl mi get data-services RESTDataService -e dev
            ```

    -   **Response**

        ```go
        Name - RESTDataService
        Group Name - RESTDataService
        Description - Exposing the data service as a REST service.
        WSDL 1.1 - http://localhost:8290/services/RESTDataService?wsdl
        WSDL 2.0 - http://localhost:8290/services/RESTDataService?wsdl2
        Queries :
        ID                  NAMESPACE
        ReadStudents        http://ws.wso2.org/dataservice/ReadStudents
        DeleteStudent       http://ws.wso2.org/dataservice
        ```

### Endpoints

1.  List endpoints in an environment.

    -   **Command**
        ``` bash
        apictl mi get endpoints -e <environment>
        ```

        !!! info
            **Flags:**

            -   Required :  
                `--environment` or `-e` : Environment of the Micro Integrator to be searched
            -   Optional :  
                `--format` : pretty-print using templates

        !!! example
            ```bash
            apictl mi get endpoints -e dev
            ```

    -   **Response**

        ```go
        NAME                    TYPE      ACTIVE
        GrandOakEndpoint        http      true
        PineValleyEndpoint      http      true
        ```

2.  Get information on a specific endpoint in an environment.

    -   **Command**
        ``` bash
        apictl mi get endpoints [endpoint-name] -e <environment>
        ```

        !!! info
            **Flags:**

            -   Required :  
                `--environment` or `-e` : Environment of the Micro Integrator to be searched
            -   Optional :  
                `--format` : pretty-print using templates

        !!! example
            ```bash
            apictl mi get endpoints GrandOakEndpoint -e dev
            ```

    -   **Response**

        ```go
        Name - GrandOakEndpoint
        Type - HTTP Endpoint
        Active - true
        Method - GET
        URI Template - http://localhost:9091/grand/doctors
        ```

### Inbound Endpoints

1.  List inbound endpoints in an environment.

    -   **Command**
        ``` bash
        apictl mi get inbound-endpoints -e <environment>
        ```

        !!! info
            **Flags:**

            -   Required :  
                `--environment` or `-e` : Environment of the Micro Integrator to be searched
            -   Optional :  
                `--format` : pretty-print using templates

        !!! example
            ```bash
            apictl mi get inbound-endpoints -e dev
            ```

    -   **Response**

        ```go
        NAME                 TYPE
        httpInboundEP        http
        ```

2.  Get information on a specific inbound endpoint in an environment.

    -   **Command**
        ``` bash
        apictl mi get inbound-endpoints [inbound-name] -e <environment>
        ```

        !!! info
            **Flags:**

            -   Required :  
                `--environment` or `-e` : Environment of the Micro Integrator to be searched
            -   Optional :  
                `--format` : pretty-print using templates

        !!! example
            ```bash
            apictl mi get inbound-endpoints httpInboundEP -e dev
            ```

    -   **Response**

        ```go
        Name - httpInboundEP
        Type - http
        Stats - enabled
        Tracing - enabled
        Parameters :
        NAME                                   VALUE
        inbound.http.port                      8697
        inbound.worker.pool.size.core          400
        inbound.worker.pool.size.max           500
        inbound.worker.thread.keep.alive.sec   60
        inbound.worker.pool.queue.length       -1
        inbound.thread.id                      PassThroughInboundWorkerPool
        ```

### Local Entries

1.  List local entries in an environment.

    -   **Command**
        ``` bash
        apictl mi get local-entries -e <environment>
        ```

        !!! info
            **Flags:**

            -   Required :  
                `--environment` or `-e` : Environment of the Micro Integrator to be searched
            -   Optional :  
                `--format` : pretty-print using templates

        !!! example
            ```bash
            apictl mi get local-entries -e dev
            ```

    -   **Response**

        ```go
        NAME                    TYPE
        sample-local-entry      Inline Text
        ```

2.  Get information on a specific local entry in an environment.

    -   **Command**
        ``` bash
        apictl mi get local-entries [local-entry-name] -e <environment>
        ```

        !!! info
            **Flags:**

            -   Required :  
                `--environment` or `-e` : Environment of the Micro Integrator to be searched
            -   Optional :  
                `--format` : pretty-print using templates

        !!! example
            ```bash
            apictl mi get local-entries sample-local-entry -e dev
            ```

    -   **Response**

        ```go
        Name - sample-local-entry
        Type - Inline Text
        Value - 0, 1
        ```

### Message Processors

1.  List message processors in an environment.

    -   **Command**
        ``` bash
        apictl mi get message-processors -e <environment>
        ```

        !!! info
            **Flags:**

            -   Required :  
                `--environment` or `-e` : Environment of the Micro Integrator to be searched
            -   Optional :  
                `--format` : pretty-print using templates

        !!! example
            ```bash
            apictl mi get message-processors -e dev
            ```

    -   **Response**

        ```go
        NAME                      TYPE                                     STATUS
        scheduled-msg-processor   Scheduled-message-forwarding-processor   active
        ```

2.  Get information on a specific message processor in an environment.

    -   **Command**
        ``` bash
        apictl mi get message-processors [message-processor-name] -e <environment>
        ```

        !!! info
            **Flags:**

            -   Required :  
                `--environment` or `-e` : Environment of the Micro Integrator to be searched
            -   Optional :  
                `--format` : pretty-print using templates

        !!! example
            ```bash
            apictl mi get message-processors scheduled-msg-processor -e dev
            ```

    -   **Response**

        ```go
        Name - scheduled-msg-processor
        Type - Scheduled-message-forwarding-processor
        File Name - scheduled-msg-processor-1.0.0.xml
        Message Store - in-memory-message-store
        Artifact Container - [ Deployed From Artifact Container: HealthCareCompositeExporter ]
        Status - active
        Parameters :
         client.retry.interval = 1000
         interval = 1000
         is.active = true
         max.delivery.attempts = 4
         max.delivery.drop = Disabled
         max.store.connection.attempts = -1
         member.count = 1
         store.connection.retry.interval = 1000
         target.endpoint = PineValleyEndpoint
         throttle = false
        ```

### Message Stores

1.  List message stores in an environment.

    -   **Command**
        ``` bash
        apictl mi get message-stores -e <environment>
        ```

        !!! info
            **Flags:**

            -   Required :  
                `--environment` or `-e` : Environment of the Micro Integrator to be searched
            -   Optional :  
                `--format` : pretty-print using templates

        !!! example
            ```bash
            apictl mi get message-stores -e dev
            ```

    -   **Response**

        ```go
        NAME                      TYPE                      SIZE
        in-memory-message-store   in-memory-message-store   0
        ```

2.  Get information on a specific message store in an environment.

    -   **Command**
        ``` bash
        apictl mi get message-stores [message-store-name] -e <environment>
        ```

        !!! info
            **Flags:**

            -   Required :  
                `--environment` or `-e` : Environment of the Micro Integrator to be searched
            -   Optional :  
                `--format` : pretty-print using templates

        !!! example
            ```bash
            apictl mi get message-stores in-memory-message-store -e dev
            ```

    -   **Response**

        ```go
        Name - in-memory-message-store
        File Name - in-memory-message-store-1.0.0.xml
        Container - [ Deployed From Artifact Container: HealthCareCompositeExporter ]
        Producer - org.apache.synapse.message.store.impl.memory.InMemoryProducer@3d288f9e
        Consumer - org.apache.synapse.message.store.impl.memory.InMemoryConsumer@5e6443d6
        Size - 0
        Properties :
        No Properties found
        ```

### Proxy Services

1.  List proxy services in an environment.

    -   **Command**
        ``` bash
        apictl mi get proxy-services -e <environment>
        ```

        !!! info
            **Flags:**

            -   Required :  
                `--environment` or `-e` : Environment of the Micro Integrator to be searched
            -   Optional :  
                `--format` : pretty-print using templates

        !!! example
            ```bash
            apictl mi get proxy-services -e dev
            ```

    -   **Response**

        ```go
        NAME                WSDL 1.1                                                WSDL 2.0
        StockQuoteProxy     http://localhost:8290/services/StockQuoteProxy?wsdl     http://localhost:8290/services/StockQuoteProxy?wsdl2
        ```

2.  Get information on a specific proxy service in an environment.

    -   **Command**
        ``` bash
        apictl mi get proxy-services [proxy-name] -e <environment>
        ```

        !!! info
            **Flags:**

            -   Required :  
                `--environment` or `-e` : Environment of the Micro Integrator to be searched
            -   Optional :  
                `--format` : pretty-print using templates

        !!! example
            ```bash
            apictl mi get proxy-services StockQuoteProxy -e dev
            ```

    -   **Response**

        ```go
        Name - StockQuoteProxy
        WSDL 1.1 - http://localhost:8290/services/StockQuoteProxy?wsdl
        WSDL 2.0 - http://localhost:8290/services/StockQuoteProxy?wsdl2
        Stats - disabled
        Tracing - disabled
        ```

### Sequences

1.  List sequences in an environment.

    -   **Command**
        ``` bash
        apictl mi get sequences -e <environment>
        ```

        !!! info
            **Flags:**

            -   Required :  
                `--environment` or `-e` : Environment of the Micro Integrator to be searched
            -   Optional :  
                `--format` : pretty-print using templates

        !!! example
            ```bash
            apictl mi get sequences -e dev
            ```

    -   **Response**

        ```go
        NAME                STATS               TRACING
        fault               disabled            disabled
        main                disabled            disabled
        sample-sequence     disabled            disabled
        ```

2.  Get information on a specific sequence in an environment.

    -   **Command**
        ``` bash
        apictl mi get sequences [sequence-name] -e <environment>
        ```

        !!! info
            **Flags:**

            -   Required :  
                `--environment` or `-e` : Environment of the Micro Integrator to be searched
            -   Optional :  
                `--format` : pretty-print using templates

        !!! example
            ```bash
            apictl mi get sequences sample-sequence -e dev
            ```

    -   **Response**

        ```go
        Name - sample-sequence
        Container - [ Deployed From Artifact Container: HealthCareCompositeExporter ]
        Stats - disabled
        Tracing - disabled
        Mediators - LogMediator, STRING
        ```

### Scheduled Tasks

1.  List scheduled tasks in an environment.

    -   **Command**
        ``` bash
        apictl mi get tasks -e <environment>
        ```

        !!! info
            **Flags:**

            -   Required :  
                `--environment` or `-e` : Environment of the Micro Integrator to be searched
            -   Optional :  
                `--format` : pretty-print using templates

        !!! example
            ```bash
            apictl mi get tasks -e dev
            ```

    -   **Response**

        ```go
        NAME
        sample-cron-task
        CheckPriceTask
        ```

2.  Get information on a specific scheduled task in an environment.

    -   **Command**
        ``` bash
        apictl mi get tasks [task-name] -e <environment>
        ```

        !!! info
            **Flags:**

            -   Required :  
                `--environment` or `-e` : Environment of the Micro Integrator to be searched
            -   Optional :  
                `--format` : pretty-print using templates

        !!! example
            ```bash
            apictl mi get tasks sample-cron-task -e dev
            ```

    -   **Response**

        ```go
        Name - sample-cron-task
        Trigger Type - cron
        Cron Expression - 0 30 1 * * ?
        ```

### Templates

1.  List all templates in an environment.

    -   **Command**
        ``` bash
        apictl mi get templates -e <environment>
        ```

        !!! info
            **Flags:**

            -   Required :  
                `--environment` or `-e` : Environment of the Micro Integrator to be searched
            -   Optional :  
                `--format` : pretty-print using templates

        !!! example
            ```bash
            apictl mi get templates -e dev
            ```

    -   **Response**

        ```go
        NAME                  TYPE
        sample_seq_template   Sequence
        sample_template       Endpoint
        ```

2.  List a specific type of template in an environment.

    -   **Command**
        ``` bash
        apictl mi get templates [template-type] -e <environment>
        ```

        !!! info
            **Flags:**

            -   Required :  
                `--environment` or `-e` : Environment of the Micro Integrator to be searched
            -   Optional :  
                `--format` : pretty-print using templates

        !!! example
            ```bash
            apictl mi get templates endpoint -e dev
            ```
            ```bash
            apictl mi get templates sequence -e dev
            ```

    -   **Response**

        ```go
        NAME
        sample_seq_template
        ```

3.  Get information on a specific template in an environment.

    -   **Command**
        ``` bash
        apictl mi get templates [template-type] [template-name] -e <environment>
        ```

        !!! info
            **Flags:**

            -   Required :  
                `--environment` or `-e` : Environment of the Micro Integrator to be searched
            -   Optional :  
                `--format` : pretty-print using templates

        !!! example
            ```bash
            apictl mi get templates endpoint sample_template -e dev
            ```

    -   **Response**

        ```go
        Name - sample_template
        Parameters : name, uri
        ```

## Change status of an Artifact

You can use the commands below to activate or deactivate endpoints, message processors or proxy services deployed in a Micro Integrator.

### Endpoint

1.  Activate an endpoint deployed in a Micro Integrator.

    -   **Command**
        ``` bash
        apictl mi activate endpoint [endpoint-name] -e <environment>
        ```

        !!! info
            **Flags:**

            -   Required :  
                `--environment` or `-e` : Environment of the Micro Integrator to be searched

        !!! example
            ```bash
            apictl mi activate endpoint GrandOakEndpoint -e dev
            ```

    -   **Response**

        ```go
        GrandOakEndpoint is switched On
        ```

2.  Deactivate an endpoint deployed in a Micro Integrator.

    -   **Command**
        ``` bash
        apictl mi deactivate endpoint [endpoint-name] -e <environment>
        ```

        !!! info
            **Flags:**

            -   Required :  
                `--environment` or `-e` : Environment of the Micro Integrator to be searched

        !!! example
            ```bash
            apictl mi deactivate endpoint GrandOakEndpoint -e dev
            ```

    -   **Response**

        ```go
        GrandOakEndpoint is switched Off
        ```

### Message Processor

1.  Activate a message processor deployed in a Micro Integrator.

    -   **Command**
        ``` bash
        apictl mi activate message-processor [message-processor-name] -e <environment>
        ```

        !!! info
            **Flags:**

            -   Required :  
                `--environment` or `-e` : Environment of the Micro Integrator to be searched

        !!! example
            ```bash
            apictl mi activate message-processor scheduled-msg-processor -e dev
            ```

    -   **Response**

        ```go
        scheduled-msg-processor : is activated
        ```

2.  Deactivate a message processor deployed in a Micro Integrator.

    -   **Command**
        ``` bash
        apictl mi deactivate message-processor [message-processor-name] -e <environment>
        ```

        !!! info
            **Flags:**

            -   Required :  
                `--environment` or `-e` : Environment of the Micro Integrator to be searched

        !!! example
            ```bash
            apictl mi deactivate message-processor scheduled-msg-processor -e dev
            ```

    -   **Response**

        ```go
        scheduled-msg-processor : is deactivated
        ```

### Proxy Service

1.  Activate a proxy service deployed in a Micro Integrator.

    -   **Command**
        ``` bash
        apictl mi activate proxy-service [proxy-name] -e <environment>
        ```

        !!! info
            **Flags:**

            -   Required :  
                `--environment` or `-e` : Environment of the Micro Integrator to be searched

        !!! example
            ```bash
            apictl mi activate proxy-service StockQuoteProxy -e dev
            ```

    -   **Response**

        ```go
        Proxy service StockQuoteProxy started successfully
        ```

2.  Deactivate a proxy service deployed in a Micro Integrator.

    -   **Command**
        ``` bash
        apictl mi deactivate proxy-service [proxy-name] -e <environment>
        ```

        !!! info
            **Flags:**

            -   Required :  
                `--environment` or `-e` : Environment of the Micro Integrator to be searched

        !!! example
            ```bash
            apictl mi deactivate proxy-service StockQuoteProxy -e dev
            ```

    -   **Response**

        ```go
        Proxy service StockQuoteProxy stopped successfully
        ```

## Manage Loggers used in Micro Integrator

### Get information on a specific logger

-   **Command**
    ``` bash
    apictl mi get log-levels [logger-name] -e <environment>
    ```

    !!! info
        **Flags:**

        -   Required :  
            `--environment` or `-e` : Environment of the Micro Integrator to be searched
        -   Optional :  
            `--format` : pretty-print using templates

    !!! example
        ```bash
        apictl mi get log-levels org-apache-coyote -e dev
        ```

-   **Response**

    ```go
    NAME                    LOG LEVEL           COMPONENT
    org-apache-coyote       WARN                org.apache.coyote
    ```

### Add a new logger

You can use the command below to add a new logger to a Micro Integrator.

-   **Command**
    ``` bash
    apictl mi add log-level [logger-name] [class-name] [log-level] -e <environment>
    ```

    !!! info
        **Flags:**

        -   Required :  
            `--environment` or `-e` : Environment of the Micro Integrator to be searched

    !!! example
        ```bash
        apictl mi add log-level synapse-api org.apache.synapse.rest.API DEBUG -e dev
        ```

-   **Response**

    ```go
    Successfully added logger for ('synapse-api') with level DEBUG for class org.apache.synapse.rest.API
    ```

### Update a logger

You can use the command below to update the log level of an existing logger.

-   **Command**
    ``` bash
    apictl mi update log-level [logger-name] [log-level] -e <environment>
    ```

    !!! info
        **Flags:**

        -   Required :  
            `--environment` or `-e` : Environment of the Micro Integrator to be searched

    !!! example
        ```bash
        apictl mi update log-level org-apache-coyote DEBUG -e dev
        ```

-   **Response**

    ```go
    Successfully added logger for ('org-apache-coyote') with level DEBUG
    ```

## Download log files

### List available log files

-   **Command**
    ``` bash
    apictl mi get logs -e <environment>
    ```

    !!! info
        **Flags:**

        -   Required :  
            `--environment` or `-e` : Environment of the Micro Integrator to be searched
        -   Optional :  
            `--format` : pretty-print using templates

    !!! example
        ```bash
        apictl mi get logs -e dev
        ```

-   **Response**

    ```go
    NAME                            SIZE
    wso2carbon.log                  429.5 KB
    correlation.log                 0 B
    wso2carbon-trace-messages.log   0 B
    wso2-mi-api.log                 11.9 KB
    patches.log                     15.7 KB
    audit.log                       0 B
    wso2-mi-service.log             10.3 KB
    http_access_.log                35.8 KB
    wso2error.log                   156.2 KB
    ```

### Download a specific log file

-   **Command**
    ``` bash
    apictl mi get logs [file-name] -p [download-location] -e <environment>
    ```

    !!! info
        **Flags:**

        -   Required :  
            `--environment` or `-e` : Environment of the Micro Integrator to be searched

        -   Optional :  
            `--path` or `-p`        : Path the file should be downloaded (default is current executable directory)

    !!! example
        ```bash
        apictl mi get logs wso2carbon.log -p log-files -e dev
        ```

-   **Response**

    ```go
    Log file downloaded to log-files/wso2carbon.log
    ```

## Monitor transactions

### Transaction Counts

You can use the command below to get information about the inbound transactions received by the Micro Integrator.

-   **Command**
    ``` bash
    apictl mi get transaction-counts -e <environment>
    ```
    ``` bash
    apictl mi get transaction-counts [year] [month] -e <environment>
    ```

    !!! info
        **Flags:**

        -   Required :  
            `--environment` or `-e` : Environment of the Micro Integrator to be searched
        -   Optional :  
            `--format` : pretty-print using templates

    !!! example
        ```bash
        apictl mi get transaction-counts -e dev
        ```
        ```bash
        apictl mi get transaction-counts 2021 01 -e dev
        ```

-   **Response**

    ```go
    YEAR        MONTH       TRANSACTION COUNT
    2021        1           126
    ```

### Transaction Reports

You can use the command below to generate the transaction count summary report based on the inbound transactions received by the Micro Integrator.

-   **Command**
    ``` bash
    apictl mi get transaction-reports [start] [end] -e <environment>
    ```

    !!! info
        **Flags:**

        -   Required :  
            `--environment` or `-e` : Environment of the Micro Integrator to be searched
        -   Optional :  
            `--path` or `-p`        : Path the file should be downloaded (default is current executable directory)

    !!! example
        ```bash
        apictl mi get transaction-reports 2020-05 2020-06 -e dev
        ```
        ```bash
        apictl mi get transaction-reports 2020-05 -e dev -p reports/mi
        ```

-   **Response**

    ```go
    Transaction Count Report created in reports/mi/transaction-count-summary-1610597725520763836.csv
    ```
