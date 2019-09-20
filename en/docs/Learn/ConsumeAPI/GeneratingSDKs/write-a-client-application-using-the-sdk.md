# Write a Client Application Using the SDK

A software development kit (SDK) is a set of software development tools that allows to create applications for a specific platform. If an API consumer wants to create an application, they can generate a client side SDK for a supported language/framework and use it to write a software application to consume the subscribed APIs. This tutorial shows you how to write a client application using an SDK.

!!! note
In this example, we use the sample API in WSO2 API Manager as a demonstration. To deploy the sample API, log in to the API Publisher and click the **Deploy Sample API** button. Note that the button only appears if no APIs have been created so far, in the given tenant space.

If a different API is used, the SDK functions to invoke the API are based on the specifications of that API.


1.  Follow the steps in [Invoke your first API](https://docs.wso2.com/display/AM260/Quick+Start+Guide#QuickStartGuide-InvokingyourfirstAPI) , to deploy the sample API, subscribe and generate keys.

        !!! info
    Access Token

    Once the keys are generated, copy the access token. You can use this token to invoke APIs that you subscribe to using the same application.


2.  Go to the API Store. Select your API and download the SDK for Java. For more details, see [Generating client SDKs in the API Store](https://docs.wso2.com/display/AM260/Generating+SDKs#GeneratingSDKs-GeneratingclientSDKsintheAPIStore) .
    ![](/assets/attachments/103333192/103333194.png)3.  In this example, you would have downloaded the `PizzaShackAPI_1.0.0_java.zip` file. This file name includes the API name, version, and language of the SDK. Unzip the `PizzaShackAPI_1.0.0_java.zip` file.

    ![](images/icons/grey_arrow_down.png){.expand-control-image} Expand to see the folder structure of the unzipped file...

    ``` java
        PizzaShackAPI_1.0.0_java
        ├── build.gradle
        ├── build.sbt
        ├── docs
        │   ├── DefaultApi.md
        │   ├── ErrorListItem.md
        │   ├── Error.md
        │   ├── MenuItem.md
        │   └── Order.md
        ├── git_push.sh
        ├── gradle
        │   └── wrapper
        │       ├── gradle-wrapper.jar
        │       └── gradle-wrapper.properties
        ├── gradle.properties
        ├── gradlew
        ├── gradlew.bat
        ├── LICENSE
        ├── pom.xml
        ├── README.md
        ├── settings.gradle
        └── src
            ├── main
            │   ├── AndroidManifest.xml
            │   └── java
            │       └── org
            │           └── wso2
            │               └── client
            │                   ├── api
            │                   │   ├── ApiCallback.java
            │                   │   ├── ApiClient.java
            │                   │   ├── ApiException.java
            │                   │   ├── ApiResponse.java
            │                   │   ├── auth
            │                   │   │   ├── ApiKeyAuth.java
            │                   │   │   ├── Authentication.java
            │                   │   │   ├── HttpBasicAuth.java
            │                   │   │   ├── OAuthFlow.java
            │                   │   │   └── OAuth.java
            │                   │   ├── Configuration.java
            │                   │   ├── JSON.java
            │                   │   ├── Pair.java
            │                   │   ├── PizzaShackAPI
            │                   │   │   └── DefaultApi.java
            │                   │   ├── ProgressRequestBody.java
            │                   │   ├── ProgressResponseBody.java
            │                   │   └── StringUtil.java
            │                   └── model
            │                       └── PizzaShackAPI
            │                           ├── Error.java
            │                           ├── ErrorListItem.java
            │                           ├── MenuItem.java
            │                           └── Order.java
            └── test
                └── java
                    └── org
                        └── wso2
                            └── client
                                └── api
                                    └── PizzaShackAPI
                                        └── DefaultApiTest.java
    ```

4.  [Build the SDK using maven](https://maven.apache.org/run-maven/) .
    When it’s done, you can include this SDK as a dependency in your software project. Details of this maven dependency are included in the README.md file.

    **Maven dependency** Expand source

    ``` java
            <dependency>
                <groupId>org.wso2</groupId>
                <artifactId>org.wso2.client.PizzaShackAPI</artifactId>
                <version>1.0.0</version>
                <scope>compile</scope>
            </dependency>
    ```

        !!! info
    Build using maven

    You can build the SDK using the `mvn clean install` command inside the root directory. For more information see [Maven Start Guide](https://maven.apache.org/guides/getting-started/) .


5.  After creating a maven project, import the following with respect to the SDK. These classes will be accessible from the code once the SDK is built using maven and will be included as maven dependencies in the project.

    ``` java
        import org.wso2.client.api.ApiClient;
        import org.wso2.client.api.PizzaShackAPI.DefaultApi;
        import org.wso2.client.model.PizzaShackAPI.Menu;
    ```

6.  Create an instance of the `DefaultApi` object in the java code. This instance is needed to get the API client which handles the operations related to consuming the API, using the resources of the API.

    ``` java
            DefaultApi defaultApi = new DefaultApi();
    ```

7.  The API client of the `DefaultApi` object instance is used to set HTTP request headers with the required data. Note that these HTTP request headers might differ from one API to another, depending on the implementation of the API. A sample is show below.

    ``` java
            ApiClient apiClient = defaultApi.getApiClient();
            apiClient.addDefaultHeader("Accept", "application/json");
    ```

8.  Include the access token as a header in the API client object, to invoke the API.

    ``` java
            String accessToken = "bc392b16-6ce2-3208-9023-8938fbc376ea";
            apiClient.addDefaultHeader("Authorization", "Bearer " + accessToken);
    ```

        !!! warning
    You need an access token to invoke the API. It is important to have a valid subscription before using the SDK, to obtain an access token. Note that the obtained access token has an [expiration time](https://docs.wso2.com/display/AM260/Working+with+Access+Tokens#WorkingwithAccessTokens-Changingthedefaulttokenexpirationtime) .


9.  Set the base path to the API client.

    ``` java
        apiClient.setBasePath("http://localhost:8280/pizzashack/1.0.0");
    ```

    The base path for the client application is the production (or sandbox) URL of the API,  found in the **Overview** tab of the API in the API Store.
    ![](/assets/attachments/103333192/103333193.png)
10. Once the `ApiClient` object has all the required data, set the `ApiClient` for the instance of the `DefaultApi` object.

    ``` java
            defaultApi.setApiClient(apiClient);
    ```

11. Finally, we can call the available function in the SDK to get the response from the API.

    ``` java
            List<MenuItem> menuItems = (List<MenuItem>) defaultApi.menuGet();
    ```

        !!! info
`MenuItem` is a model class generated with SDK


    Complete java code can be found below

-   [**Java Code**](#053390ce38504f7c8ebacf179b78ecc7)
-   [**pom file**](#fcd42564768d41e3b6421dfc286ae83e)

``` java
    import org.wso2.client.api.ApiClient;
    import org.wso2.client.api.ApiException;
    import org.wso2.client.api.PizzaShackAPI.DefaultApi;
    import org.wso2.client.model.PizzaShackAPI.MenuItem;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class APIClient {

    public static void main(String[] args) throws ApiException {
        DefaultApi defaultApi = new DefaultApi();
        String accessToken = "bc392b16-6ce2-3208-9023-8938fbc376ea";
        Map<String, String> headers = new HashMap<String, String>();
        headers.put("Accept", "application/json");
        headers.put("Authorization", "Bearer " + accessToken);
        ApiClient apiClient = defaultApi.getApiClient();
        apiClient.addDefaultHeader("Accept", "application/json");

        apiClient.addDefaultHeader("Authorization", "Bearer " + accessToken);
        apiClient.setLenientOnJson(true);
        apiClient.setBasePath("http://localhost:8280/pizzashack/1.0.0");
        defaultApi.setApiClient(apiClient);
        List<MenuItem> menuItems = (List<MenuItem>) defaultApi.menuGet();

        System.out.println(menuItems);
    }

}
```
``` java
    <?xml version="1.0" encoding="UTF-8"?>
    <project xmlns="http://maven.apache.org/POM/4.0.0"
     xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
     xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
        <modelVersion>4.0.0</modelVersion>
    <groupId>org.pizzashack.client</groupId>
    <artifactId>pizzashack-api</artifactId>
    <version>1.0-SNAPSHOT</version>

    <dependencies>
        <dependency>
            <groupId>org.wso2</groupId>
            <artifactId>org.wso2.client.PizzaShackAPI</artifactId>
            <version>1.0.0</version>
            <scope>compile</scope>
        </dependency>
    </dependencies>

</project>
```

