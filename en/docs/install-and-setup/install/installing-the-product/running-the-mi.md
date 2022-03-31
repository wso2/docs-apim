# Running the Micro Integrator Runtime

Follow the steps given below to run the WSO2 Micro Integrator (MI) runtime.

## Before you begin

[Download and install]({{base_path}}/install-and-setup/install/installing-the-product/installing-mi) the Micro Integrator.

## Starting the MI server

Follow the steps given below to start the server.

1.    Open a command prompt as explained below.

      <table>
            <tr>
                  <th>On <b>Linux/macOS</b></td>
                  <td>Establish an SSH connection to the server, log on to the text Linux console, or open a terminal window.</td>
            </tr>
            <tr>
                  <th>On <b>Windows</b></td>
                  <td>Click <b>Start &gt;Run</b>, type <b>cmd</b> at the prompt, and then press <b>Enter</b>.</td>
            </tr>
      </table>     

2.    Navigate to the `<MI_HOME>/bin` folder from your command line.
3.    Execute one of the commands given below.

      -   To start the server:
          
          ```bash tab="On macOS/Linux"
          sh micro-integrator.sh
          ```

          ```bash tab="On Windows"
          micro-integrator.bat
          ```
          
      -   To start the server in background mode:

          ```bash tab="On macOS/Linux"
          sh micro-integrator.sh start
          ```

          ```bash tab="On Windows"
          micro-integrator.bat --start
          ```

## Stopping the MI server

-     To stop the Micro Integrator standalone application, go to the terminal and press <i>Ctrl+C</i>.
-     To stop the Micro Integrator in background mode:

      ```bash tab="On macOS/Linux"
      sh micro-integrator.sh stop
      ```

      ```bash tab="On Windows"
      micro-integrator.bat --stop
      ```

## See Also

-   [Running the MI as a Windows Service]({{base_path}}/install-and-setup/install/installing-the-product/installing-mi-as-a-windows-service)