# Grouping APIs with Labels

It is possible to create a Microgateway distribution for a group of APIs. In order to group APIs, a label needs to be created and attached to the APIs that need to be in a single group.

-   [Creating and attaching a Microgateway to an API](#GroupingAPIswithLabels-CreatingandattachingaMicrogatewaytoanAPI)
-   [Generating a Microgateway distribution for a label](#GroupingAPIswithLabels-GeneratingaMicrogatewaydistributionforalabel)
-   [Viewing Microgateway labels in the API Store](#GroupingAPIswithLabels-ViewingMicrogatewaylabelsintheAPIStore)

#### Creating and attaching a Microgateway to an API

1.  Log in to the Admin portal ( `https://<hostname>:9443/admin` ). Use `admin` as the username and password.

2.  To add a new Microgateway label, click **LABELS** under **MICROGATEWAY** , and then click **ADD MICROGATEWAY** .
    ![](attachments/103333763/103333764.png)
3.  Create a new label (e.g. MARKETING\_STORE), add a host (e.g. `https://localhost:9095` ) and click **Save.**

    ![](attachments/103333763/103333765.png)

4.  Navigate to the API Publisher ( `https://<hostname>:9443/publisher` ). Sign in using `admin` as the username and password.
5.  Deploy the sample Pizzashack API by clicking **Deploy Sample API** if you have not already done.
6.  Choose to edit the created Pizzashack API.

    ![](attachments/103333763/103333766.png)

7.  Navigate to the **Manage** section and click **Gateway Environments** .

8.  Select the newly created label to attach it to the Pizzashack API.
    ![](attachments/103333763/103333767.png)
9.  Click **Save & Publish** .
10. Similarly, you can select MARKETING\_STORE label for few other Published APIs.

#### Generating a Microgateway distribution for a label

1.  Run the initial setup command for the MARKETING\_STORE label after navigating to a preferred workspace folder.

    ``` java
        micro-gw setup <project name> -l <label name> 
    ```

    Here is a sample:

    ``` java
            micro-gw setup marketing_project -l MARKETING_STORE 
    ```

2.  Build the microgateway distribution for the project using the following command:

    ``` java
            micro-gw build marketing_project
    ```

    Once the above command is executed, the generated source files are built and a Microgateway distribution is created under the **target** folder.

3.  Next, unzip the `micro-gw-marketing-project.zip` and run the `gateway` shell script inside the **bin** folder of the extracted zip using the following command:

    ``` java
            bash gateway 
    ```

    The Microgateway starts for the APIs grouped with `MARKETING_STORE` label you just created.

    ``` java
            micro-gw-marketing-project/bin$ bash gateway
    ballerina: HTTP access log enabled
    ballerina: initiating service(s) in '/home/user/workspace/marketing-project/target/micro-gw-marketing-project/exec/marketing-project.balx'
    2018-06-29 21:16:44,142 INFO  [wso2/gateway:0.0.0] - Subscribing writing method to event stream 
    ballerina: started HTTPS/WSS endpoint 0.0.0.0:9096
    ballerina: started HTTPS/WSS endpoint 0.0.0.0:9095
    ballerina: started HTTP/WS endpoint 0.0.0.0:9090
    ```
#### Viewing Microgateway labels in the API Store

1.  Log in to the API Store ( `https://<hostname>:9443/store` ). Use `admin` as the username and password.
2.  Any attached Microgateways are shown in the **Overview** tab of the API.

    ![](attachments/103333763/103333768.png)


