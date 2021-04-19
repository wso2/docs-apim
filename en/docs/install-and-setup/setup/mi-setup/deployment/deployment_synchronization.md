# Deployment Synchronization

When you have a [clustered deployment]({{base_path}}/install-and-setup/setup/mi-setup/deployment/deploying_wso2_ei/deploying_wso2_ei), the integration artifacts deployed in each server node of the cluster needs to be identical. This can be achieved by synchronizing the deployment directories of each server. That is, the `<MI_HOME>/repository/deployment/server` folder of each server needs to be shared.

Select one of the following approaches depending on the expected rate of change (of artifacts) in your cluster:

-   For a high rate of changes (i.e., if changes happen very frequently), use **Network File Share (NFS)**.
-   For a medium rate of change, use **Remote Synchronization (Rsync)**.
-   For a low rate of changes (i.e., if changes happen once a week):

    -   Use the **configuration management system** to handle artifacts.
    -   Use other deployment options (e.g., Puppet, Chef etc.).

Be sure to choose the deployment synchronization method that suits your production environment.

### Using Network File Share (NFS)

You can use a common shared file system such as Network File System (NFS) or any other shared file system as the content synchronization mechanism. You need to mount the `<EI_HOME>/repository/deployment/server` folder of the two nodes to the shared file system to share all the artifacts between both nodes. 

### Using Remote Synchronization (Rsync)

If you are unable to maintain a shared file system, you can synchronize the content using Rsync. The Rsync tool (which is a file copying tool) is another common approach for synchronizing artifacts across all cluster nodes. Therefore, you can first deploy artifacts in one node of the cluster and then use Rsync to copy those artifacts to other nodes as described below.

1.  Create a file called `nodes-list.txt`, which lists all the nodes in the deployment. The following is a sample of the file for two nodes.

    !!! Tip
        Different nodes are separated into individual lines.

    ```bash
    ubuntu@192.168.1.1:~/setup/192.168.1.1/ei_node/repository/deployment/server
    ubuntu@192.168.1.2:~/setup/192.168.1.2/ei_node/repository/deployment/server
    ```

2.  Create a file to synchronize the  `<EI_HOME>/repository/deployment/server/` directory between the nodes.

    You must create your own SSH key and define it as the `pem_file`. Alternatively, you can use an existing SSH key. Specify the `ei_server_dir` depending on the location in your local machine. Change the `logs.txt` file path and the lock location based on where they are located in your machine.

    Configure syncing the `<EI_HOME>/repository/tenant/` directory to share the tenant artifacts across the cluster.

    ```bash
    #!/bin/sh
    ei_server_dir=~/wso2ei-6.6.0/repository/deployment/server/
    pem_file=~/.ssh/carbon-440-test.pem


    #delete the lock on exit
    trap 'rm -rf /var/lock/depsync-lock' EXIT

    mkdir /tmp/carbon-rsync-logs/

    #keep a lock to stop parallel runs
    if mkdir /var/lock/depsync-lock; then
      echo "Locking succeeded" >&2
    else
      echo "Lock failed - exit" >&2
      exit 1
    fi

    #get the nodes-list.txt
    pushd `dirname $0` > /dev/null
    SCRIPTPATH=`pwd`
    popd > /dev/null
    echo $SCRIPTPATH

    for x in `cat ${SCRIPTPATH}/nodes-list.txt`
    do
    echo ================================================== >> /tmp/carbon-rsync-logs/logs.txt;
    echo Syncing $x;
    rsync --delete -arve "ssh -i  $pem_file -o StrictHostKeyChecking=no" $ei_server_dir $x >> /tmp/carbon-rsync-logs/logs.txt
    echo ================================================== >> /tmp/carbon-rsync-logs/logs.txt;
    done
    ```

3.  Execute the following command in your CLI to create a Cron job that executes the above file every minute for deployment synchronization.    

    ```bash
    *   *  *   *   *     /home/ubuntu/setup/rsync-for-depsync/rsync-for-ei-depsync.sh=
    ```
