# Running the Streaming Integrator Runtime

Follow the steps given below to install the WSO2 Streaming Integrator (SI) runtime by using the <b>binary distribution</b>.

## Before you begin

[Download and install]({{base_path}}/install-and-setup/install/installing-the-product/installing-si) the Streaming Integrator runtime.

## Starting the SI server

Follow the steps given below to start the Streaming Integrator server

1.  Open a terminal and navigate to the `<SI_HOME>/bin` folder.
2.  Execute one of the commands given below.

    ```bash tab='On MacOS/Linux/CentOS'
    sh server.sh
    ```
    
    ```bash tab='On Windows'
    server.bat --run
    ```
      
By default, the HTTP listener port is 8290 and the default HTTPS listener port is 8253.

## Stopping the SI server

To stop the Streaming Integrator runtime, press Ctrl+C in the command window.

