# Setting Up a Distributed APIM Environment with the WSO2 API Manager Enterprise Package

The WSO2 API Manager Enterprise Package comprises the **API Control Plane**, **Traffic Manager**, and **Universal Gateway**.
This guide walks you through setting up a distributed APIM environment using the WSO2 API Manager Enterprise Package.

## Prerequisites

- Docker Engine 20.10.x or newer
- Docker Compose v2.x or newer

## Setting Up the Environment

Ensure **Docker** and **Docker Compose** are installed correctly and running.

### Step 1 - Clone the Repository

Clone the [WSO2 API Manager Samples](https://github.com/wso2/samples-apim) repository.

```
git clone https://github.com/wso2/samples-apim
```

### Step 2 - Prepare the Components
   
Navigate to the `apim-distributed-dev-setup` directory.

```
cd samples-apim/apim-distributed-dev-setup
```

1. **Download the WSO2 API Manager Enterprise Package** from the [WSO2 API Manager downloads page](https://wso2.com/api-manager/) for API Control Plane, Traffic Manager and Universal Gateway components.
2. **Extract the downloaded compressed files** to `apim-distributed-dev-setup/components` directory and **rename** the extracted folders to `wso2am-acp`, `wso2am-tm`, and `wso2am-universal-gw`.

    ```
    mv wso2am-acp-4.5.0 wso2am-acp
    mv wso2am-tm-4.5.0 wso2am-tm
    mv wso2am-universal-gw-4.5.0 wso2am-universal-gw
    ```

    !!! note "Note"
        The directory names must strictly follow the naming convention: `wso2am-acp`, `wso2am-tm`, and `wso2am-universal-gw`.

### Step 3 - Start the Distributed Setup

Run the following command to initialize the MySQL database and start the APIM components:

```
sh run.sh start --seed
```

!!! info "Info"

    The `--seed` argument ensures that the database scripts located in `apim-distributed-dev-setup/conf/mysql/scripts` are executed during startup to initialize the databases.

    Each APIM component starts with the following network port offset:

    - wso2am-acp: Zero offset
    - wso2am-tm: Offset of 1
    - wso2am-universal-gw: Offset of 2

If the database scripts have already been executed, you can start the setup without the `--seed` argument:
```
sh run.sh start
```

### Step 4 - Access the Portals
Once the services are up and running, you can access the portals using the following URLs, and **Gateway** can be accessed using `https://localhost:8245`

- **Developer Portal**: `https://localhost:9443/devportal`
- **Publisher Portal**: `https://localhost:9443/publisher`

### Step 5 - Stop the Services

To stop all running services, execute:
```
sh run.sh --stop
```

## Environment Configuration

The `deployment.toml` file of each component, located in `apim-distributed-dev-setup/conf/{wso2am-acp, wso2am-tm, wso2am-universal-gw}/repository/conf`, is used as the deployment configuration when starting each component.
If you want to change any deployment configurations, modify the `deployment.toml` file in the respective component's directory and restart the setup.

## Troubleshooting

- If you encounter any issues, check the logs in the `apim-distributed-dev-setup/logs/` directory of each component for more information.
- To terminate all WSO2 Java services:
    ```
    ps -ef | grep 'wso2' | grep -v grep | awk '{print $2}' | xargs -r kill -9
    ```
- If you encounter database issues, try restarting the setup.
