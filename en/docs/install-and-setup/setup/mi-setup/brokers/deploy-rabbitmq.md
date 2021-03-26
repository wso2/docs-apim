# Deploying RabbitMQ

You can integrate WSO2 Micro Integrator with RabbitMQ to implement asynchronous messaging patterns. The following topics explain the process of setting up a single-node RabbitMQ deployment, which you can use for testing purposes. Refer the [production guidelines](#using-rabbitmq-in-production) when you deploy RabbitMQ in production.

## RabbitMQ single-node deployment

Follow the steps given below to set up a single-node RabbitMQ deployment. Note that this is only for testing purposes.

!!! Note
     **Before you begin**, note that the following guide is tested on the following version.

     - RabbitMQ version 3.8.2 
     - On Unix OS

1. Download the RabbitMQ distribution to the desired location. 

	   You can copy the following URL to your browser to start the download.
	    ```bash
	    https://github.com/rabbitmq/rabbitmq-server/releases/download/v3.8.2/rabbitmq-server-generic-unix-3.8.2.tar.xz
	    ```
    
2. Extract the distribution. 

	   You can open a terminal, navigate to the download location, and execute the following command.
	    ```bash
	    tar -xf rabbitmq-server-generic-unix-3.8.2.tar.xz
	    ```

3. Install the `erlang` distribution:

    ```bash
    wget -O- https://packages.erlang-solutions.com/ubuntu/erlang_solutions.asc | sudo apt-key add -
    echo "deb https://packages.erlang-solutions.com/ubuntu bionic contrib" | sudo tee /etc/apt/sources.list.d/rabbitmq.list && \
    sudo apt update && \
    sudo apt -y install erlang
    ```

4. Navigate to the `<RABBITMQ_HOME>/sbin` folder (where `<RABBITMQ_HOME>` is the location of the extracted RabbitMQ distribution) and execute the following command.

    ```bash
    sudo ./rabbitmq-server -detached
    ```
    
5. To enable the management plugin, execute the following command:

    ```bash
    sudo ./rabbitmq-plugins enable rabbitmq_management
    ```
    
6. Visit the following url to view the UI:

    ```bash
    http://localhost:15672/#/
    ```
    
## Using RabbitMQ in production

When you move your RabbitMQ deployment to production, be sure to follow the instructions and guidelines specified in the official [RabbitMQ Documentation](https://www.rabbitmq.com/download.html).

For **high availability** in your RabbitMQ deployment, note the following:

-  RabbitMQ servers need to be clustered. Refer the [RabbitMQ Clustering Guide](https://www.rabbitmq.com/clustering.html).
-  The minimum of three nodes are recommended for a RabbitMQ cluster. This is because RabbitMQ uses [Quorum-based distributed consensus](https://www.rabbitmq.com/clustering.html#node-count).
-  RabbitMQ **queues** need to be mirrored for high availability and fault tolerance. Refer [Mirrored Queues](https://www.rabbitmq.com/ha.html) for details.
 