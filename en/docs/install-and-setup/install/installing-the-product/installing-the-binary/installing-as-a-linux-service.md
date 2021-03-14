# Installing as a Linux Service

!!! warning
    - The following instructions are **not applicable to Red Hat Linux distributions** such as Fedora because those distributions contain the chkconfig package instead of the `update-rc.d` package for service management. 
    - **To support the Red Hat based Linux OS you need to** use `chkconfig` for the register services and you need to also include the service definition in the chkconfig's run level information. For more information, see [chkconfig](https://linux.die.net/man/8/chkconfig).

!!! note

    **Before you begin:**

    - See [our compatibility matrix]({{base_path}}/install-and-setup/ProductCompatibility) to check the compatible JDK versions. 
    - Set up the `JAVA_HOME` environment variable.

#### Setting up CARBON\_HOME

Extract the WSO2 product to a preferred directory in your machine and set the environment variable `CARBON_HOME` to the extracted directory location.

#### Running the product as a Linux service

1.  To run the product as a service, create a startup script and add it to the boot sequence. The basic structure of the startup script has three parts (i.e., start, stop and restart) as follows:

    ``` java
    #!/bin/bash
   
    case “$1″ in
    start)
      echo “Starting the Service”
    ;;
    stop)
      echo “Stopping the Service”
    ;;
    restart)
      echo “Restarting the Service”
    ;;
    *)
      echo $”Usage: $0 {start|stop|restart}”
    exit 1
    esac
    ```

    Given below is a sample startup script. `<API-M_HOME>` can vary depending on the WSO2 product's directory.

    ``` java
    #! /bin/sh
    export JAVA_HOME="/usr/lib/jvm/jdk1.8.0_xx"
    startcmd='<API-M_HOME>/bin/wso2server.sh start > /dev/null &'
    restartcmd='<API-M_HOME>/bin/wso2server.sh restart > /dev/null &'
    stopcmd='<API-M_HOME>/bin/wso2server.sh stop > /dev/null &'

    case "$1" in
    start)
       echo "Starting the WSO2 Server ..."
       su -c "${startcmd}" user1
    ;;
    restart)
       echo "Re-starting the WSO2 Server ..."
       su -c "${restartcmd}" user1
    ;;
    stop)
       echo "Stopping the WSO2 Server ..."
       su -c "${stopcmd}" user1
    ;;
    *)
       echo "Usage: $0 {start|stop|restart}"
    exit 1
    esac
    ```

    In the above script, the server is started as a user by the name user1 rather than the root user. For example, `su -c "${startcmd}" user1`

2.  Add the script to `/etc/init.d/` directory.

    !!! info

        If you want to keep the scripts in a location other than `/etc/init.d/` folder, you can add a symbolic link to the script in `/etc/init.d/` and keep the actual script in a separate location. Say your script name is prodserver and it is in `/opt/WSO2/` folder, then the commands for adding a link to `/etc/init.d/` is as follows:

    -   Make executable: `sudo chmod a+x /opt/WSO2/prodserver            `

    -   Add a link to `/etc/init.d/` : `sudo ln -snf /opt/WSO2/prodserver /etc/init.d/prodserver           `


3.  Install the startup script to respective runlevels using the `update-rc.d` command. For example, give the following command for the sample script shown in step1:

    ``` java
     sudo update-rc.d prodserver defaults 
    ```

    The `defaults` option in the above command makes the service to start in runlevels 2, 3, 4 and 5 and to stop in runlevels 0,1 and 6.

    A **runlevel** is a mode of operation in Linux (or any Unix-style operating system). There are several runlevels in a Linux server and each of these runlevels is represented by a single digit integer. Each runlevel designates a different system configuration and allows access to a different combination of processes.

4.  You can now st art, stop and restart the server using `service <service name>{start|stop|restart}` command. 

    You will be prompted for the password of the user (or root) who was used to start the service.


