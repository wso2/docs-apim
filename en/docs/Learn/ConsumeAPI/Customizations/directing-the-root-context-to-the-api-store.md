# Directing the Root Context to the API Store

WSO2 API Manager includes separate Web applications as the API Publisher and the API Store. The root context of the API Manager is set to go to the API Publisher by default. For example, assume that the API Manager is hosted on a domain named `         apis.com        ` with default ports. The URLs of the API Store and API Publisher will be as follows:

-   API Store - [https://apis.com:9443/store](https://apis.com:9443/store/)
-   API Publisher - [https://apis.com:9443/publisher](https://apis.com:9443/publisher/)

If you open the root context, which is <https://apis.com:9443> in your browser, it directs to the API Publisher by default. You can set this to go to the API Store as follows:

1.  Open the bundle `          <AM_HOME>/repository/components/plugins         ` / `          org.wso2.am.styles_1.x.x.jar         ` .
2.  Open the `          component.xml         ` file that is inside `          META-INF         ` directory.
3.  Change the &lt;context-name&gt; element, which points to publisher by default, to store:

    ``` html/xml
        <context>
                <context-id>default-context</context-id>
                <context-name>store</context-name>
                <protocol>http</protocol>
                <description>API Publisher Default Context</description>
         </context>
    ```

4.  Restart the server.
5.  Open the default context ( <https://apis.com:9443> ) again in a browser and note that it directs to the API Store.

!!! tip
**Tip** : If you want to configure the API Publisher and Store to pass proxy server requests, configure a [reverse proxy server](https://docs.wso2.com/display/AM260/FAQ#FAQ-HowcanIsetupareverseproxyservertopassserverrequests?) .


