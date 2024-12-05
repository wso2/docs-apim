# Directing the Root Context to the Developer Portal

WSO2 API Manager includes separate Web applications as the Publisher and the Developer Portal. The root context of the API Manager is set to go to the Publisher by default. For example, assume that the API Manager is hosted on a domain named `apis.com` with default ports. The URLs of the Developer Portal and Publisher will be as follows:

-   Developer Portal - `https://apis.com:9443/devportal`
-   Publisher - `https://apis.com:9443/publisher`

If you open the root context, which is `https://apis.com:9443` in your browser, it directs to the Publisher by default. You can set this to go to the Developer Portal as follows:

1.  Open the bundle `<API-M_HOME>/repository/components/plugins/org.wso2.am.styles_4.x.0.jar` by changing the .jar extension to .zip
2.  Extract the components into a desired directory.
3.  Open the `component.xml` file that is inside the `<Extracted Directory>/META-INF` directory.

    ```xml
    <context>
        <context-id>default-context</context-id>
        <context-name>devportal</context-name>
        <protocol>https</protocol>
        <description>API Publisher Default Context</description>
    </context>
    ```
    
4.  Change the &lt;context-name&gt; element, which points to Publisher by default, to Developer Portal:
5.  Archive the directory into a zip file from within the `<Extracted Directory>` and change the extension from .zip to .jar
6.  Restart the server.
7.  Open the default context (<https://apis.com:9443>) again in a browser and note that it directs to the Developer Portal.

!!! tip
    If you want to configure the Publisher and Developer Portal to pass proxy server requests, configure a [reverse proxy server]({{base_path}}/reference/faq/#how-can-i-set-up-a-reverse-proxy-server-to-pass-server-requests).
