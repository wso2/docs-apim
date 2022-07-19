### Step 3 - Add a Choreo Connect Environment to apictl

To use apictl for Choreo Connect, a Choreo Connect environment needs to be added to apictl. This environment will hold the adapter URL for further commands.

``` bash
apictl mg add env dev --adapter https://localhost:9843
```

!!! info

    Note `mg` in the above command. The apictl commands that starts as `apictl mg` are Choreo Connect specific. If a command does not have `mg` after `apictl` then the command could probably be common to both Choreo Connect and API Manager, but it could also be API Manager specific. 

!!! tip

    The apictl commands here onwards are executed with the -k flag to avoid SSL verification with the Choreo Connect.

    To communicate via HTTPS without skipping SSL verification (without -k flag), add the cert in the Choreo Connect truststore into the `<USER_HOME>/.wso2apictl/certs` folder.

### Step 4 - Log in to the Choreo Connect Environment in apictl

You can use the following command to log in to the above Choreo Connect cluster (in other words log in to the Choreo Connect adapter). When you log in, an access token will be retrieved from Choreo Connect and saved in apictl.

``` bash
apictl mg login dev -k
```

or

``` bash
apictl mg login dev -u admin -p admin -k
```

### Step 5 - Deploy the API

Now let's deploy the API to Choreo Connect by executing the following command.     

``` bash
apictl mg deploy api -f <path_to_the_API_project_just_created>/petstore -e dev -k
```  
