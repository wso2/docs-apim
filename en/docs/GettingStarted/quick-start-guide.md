# Quick Start Guide

WSO2 API Manager is a complete solution for designing and publishing APIs, creating and managing a developer community, and for securing and routing API traffic in a scalable manner. It leverages proven components from the WSO2 platform to secure, integrate and manage APIs. In addition, it integrates with the [WSO2 analytics platform](http://wso2.com/analytics) and provides out of the box reports and alerts, giving you instant insights into the APIs behavior.

##### Before you begin....

!!! tip

1.  Install [Oracle Java SE Development Kit (JDK)](http://java.sun.com/javase/downloads/index.jsp) version 1.7.\* or 1.8.\* and set the `          JAVA_HOME         ` environment variable. Refer [Installing the product](https://docs.wso2.com/display/AM210/Installing+the+Product) documentation to set `          JAVA_HOME         ` environment variable for different operating systems
2.  [Download the latest version of WSO2 API Manager](https://wso2.com/api-management/install/) .
3.  Start WSO2 API Manager by going to the `          <API-M_HOME>/bin         ` directory using the command-line and then executing `          wso2server.bat         ` (for Windows) or `          wso2server.sh         ` (for Linux.)


##### Let's get started....

Follow the steps in this section to quickly deploy a sample API, publish it, subscribe to it, and invoke it.

1.  Open the API Publisher ( `          https://<hostname>:9443/publisher         ` ) and sign in with **`           admin/admin          `** credentials.
2.  Exit from API creation tutorial by clicking the close icon(X) on top right corner.
    ![](attachments/103328418/103328310.png){width="900"}
3.  Click the **Deploy Sample API** button. It deploys a sample API called `           PizzaShackAPI          ` into the API Manager.

        !!! note
    
        This **Deploy Sample API** option is available only when there are no APIs in API Publisher. If you have already created a API, this option will not be available.
    

    ![](attachments/103328418/103328344.png){width="700"}

4.  Click `           PizzaShackAPI          ` to open it.
    ![](attachments/103328418/103328343.png)

5.  Go to the **Lifecycle** tab and note that the **State** is `           PUBLISHED          ` . The API is already published to the API Store.

    ![](attachments/103328418/103328342.png)

6.  Sign in to the API Store ( `           https://<hostname>:9443/store          ` ) with the `                       admin/admin                     ` credentials and click on the `           PizzaShackAPI          ` API.
    ![](attachments/103328418/103328341.png)

        !!! tip
    
        API Store Walkthrough
    
        You can click "API Store walkthrough" to view the interactive tutorial to invoke the API.
        ![](attachments/103328418/103328300.png)
    

7.  Select the default application and an available tier, and click **Subscribe.**
    ![](attachments/103328418/103328340.png){width="900"}

8.  When the subscription is successful, click **View Subscriptions** on the information message that appears. Click the **Production Keys** tab and click **Generate Keys** to generate an [access token](_Key_Concepts_) to invoke the API.

    ![](attachments/103328418/103328399.png){width="900"}

    You have now successfully subscribed to an API. Let's invoke the API using the integrated Swagger-based API Console.

9.  Click the **APIs** menu again and click the `           PizzaShackAPI          ` to open it. When the API opens, click its **API Console** tab.
    ![](attachments/103328418/103328339.png){width="900"}
    Expand the GET method (which retrieves the menu) and click **Try it out** .
    ![](attachments/103328418/103328338.png){width="1100"}
    Note the response for the API invocation. It returns the list of menu items.
    ![](attachments/103328418/103328337.png)

You have deployed a sample API, published it to the API Store, subscribed to it, and invoked the API using our integrated API Console.
