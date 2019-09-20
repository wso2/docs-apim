# Change the Default Mediation Flow of API Requests

!!! note
This tutorial uses the WSO2 API Manager Tooling Plug-in .


The API Gateway has a [default mediation flow](_Adding_Mediation_Extensions_) for the API invocation requests that it receives. You can extend this default mediation flow to do additional custom mediation for the messages in the API Gateway. An extension is provided as a [synapse mediation sequence](https://docs.wso2.com/display/EI630/Mediation+Sequences) . You design all sequences using a tool such as the WSO2 API Manager Tooling Plug-in and then store the sequence in the Gateway's registry.

Let's see how to create a custom sequence using the WSO2 API Manager Tooling Plug-in and then deploy and use it in your APIs.

1.  Sign in to the API Publisher.

2.  Click **Add** to  create an API with the following information and then click **Next: Implement &gt;** .

    <table>
    <thead>
    <tr class="header">
    <th>Field</th>
    <th><br />
    </th>
    <th>Sample value</th>
    </tr>
    </thead>
    <tbody>
    <tr class="odd">
    <td>Name</td>
    <td><br />
    </td>
    <td>YahooWeather</td>
    </tr>
    <tr class="even">
    <td>Context</td>
    <td><br />
    </td>
    <td>/weather</td>
    </tr>
    <tr class="odd">
    <td>Version</td>
    <td><br />
    </td>
    <td>1.0</td>
    </tr>
    <tr class="even">
    <td>Resources</td>
    <td>URL pattern</td>
    <td>current/{country}/{zipcode}</td>
    </tr>
    <tr class="odd">
    <td><br />
    </td>
    <td>Request types</td>
    <td><p>GET method to return the current weather conditions of a zip code that belongs to a particular country</p></td>
    </tr>
    </tbody>
    </table>

    ![](/assets/attachments/103332556/103332553.png)

3.  The `Implement` tab opens. Select **Managed API** , provide the information given in the table below and click **Manage** .

    | Field               | Sample value                                                                                                                                                                                                                                                                                                                                                                                                                                     |
    |---------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
    | Endpoint type       | HTTP/REST endpoint                                                                                                                                                                                                                                                                                                                                                                                                                               |
    | Production endpoint | You can find the Yahoo weather API's endpoint from <https://developer.yahoo.com/weather/> . Copy the part before the '?' sign to get this URL: [https://query.yahooapis.com/v1/public/yql](https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22nome%2C%20ak%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys) 
                                                                                                                                                                                                                                                                                                                                                                                                                                                        
      To verify the URL, click the **Test** button next to it.                                                                                                                                                                                                                                                                                                                                                                                          |
    | Sandbox endpoint    | [https://query.yahooapis.com/v1/public/yql](https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22nome%2C%20ak%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys) To verify the URL, click the **Test** button next to it.                                                                                       |

    ![](/assets/attachments/103332556/103332552.png)

4.  Click **Next: Manage &gt;** to go to the `Manage` tab, provide the following information and click **Save & Publish** once you are done.

    <table>
    <thead>
    <tr class="header">
    <th>Field</th>
    <th>Sample value</th>
    </tr>
    </thead>
    <tbody>
    <tr class="odd">
    <td>Tier Availability</td>
    <td>Gold</td>
    </tr>
    <tr class="even">
    <td>Keep the default values for the other attributes</td>
    <td><br />
    </td>
    </tr>
    </tbody>
    </table>

    ![](/assets/attachments/103332556/103332551.png)

5.  Download and install the WSO2 API Manager Tooling Plug-in by following one of the three possible methods described in Installing the API Manager Tooling Plug-In if you have not done so already. Start Eclipse by double clicking on the Eclipse application, which is  inside the downloaded folder.

6.  Navigate to the **Window** menu, click **Perspective** , **Open Perspective,** and **Other** to open the Eclipse perspective selection window.
7.  On the dialog box that appears, click **WSO2 API Manager** and click **OK** .
    ![](/assets/attachments/103332556/103332544.png)
8.  On the APIM perspective, click the **Login** icon as shown below.
    ![](/assets/attachments/103332556/103332531.png)
9.  On the dialog box that appears, enter the URL, username, and password of the Publisher server.
    ![](/assets/attachments/103332556/103332526.png)
10. On the tree view that appears, expand the folder structure of the existing API.
11. Right-click on the `in` sequence folder and click **Create** to create a new `in` sequence.
    ![](/assets/attachments/103332556/103332527.png) This is because you want the custom sequence to be invoked in the `In` direction or the request path. If you want it to be involved in the `Out` or `Fault` paths, select the respective folder under `customsequences` .

        !!! tip
    **Tip** : If you prefer not to use the registry to upload the sequence or want to engage a sequence to all APIs in WSO2 API-M at once, you can do so by saving the mediation sequence XML file in the file system. See [Adding Mediation Extensions](_Adding_Mediation_Extensions_) for details.


12. Name the sequence `YahooWeatherSequence` .
13. Your sequence now appears on the Developer Studio console. From under the **Mediators** section, drag and drop a [**Property** mediator](https://docs.wso2.com/display/EI630/Property+Mediator) to your sequence and give the following values to the property mediator.

        !!! note
    The **Property Mediator** has no direct impact on the message, but rather on the message context flowing through Synapse. You can retrieve the properties set on a message later through the [Synapse XPath Variables](https://docs.wso2.com/display/EI630/Accessing+Properties+with+XPath#AccessingPropertieswithXPath-SynapseXPathVariables) or the `get-property()` extension function. In this sequence, we are using two property mediators and set a Synapse XPath variable and a `get-property()` function to the two mediators respectively to retrieve the properties set to the message context during the execution.


    <table>
    <tbody>
    <tr class="odd">
    <td>Property Name</td>
    <td>New Property</td>
    </tr>
    <tr class="even">
    <td>New Property Name</td>
    <td>YQL</td>
    </tr>
    <tr class="odd">
    <td>Value Type</td>
    <td>Expression</td>
    </tr>
    <tr class="even">
    <td>Value Expression</td>
    <td><div class="content-wrapper">
    <p>For the XPath expression, we take a query part in the Yahoo API's endpoint ( <a href="https://developer.yahoo.com/weather/" class="uri">https://developer.yahoo.com/weather/</a> ) and concatenate the ZIP code and country to it using the synapse <code>                 get-property                </code> XPath expression:</p>
    <div class="code panel pdl" style="border-width: 1px;">
    <div class="codeContent panelContent pdl">
    <pre class="java" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence"><code>concat(&#39;?q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22&#39;,syn:get-property(&#39;uri.var.zipcode&#39;),&#39;,&#39;,syn:get-property(&#39;uri.var.country&#39;),&#39;%22)&amp;format=json&#39;)</code></pre>
    </div>
    </div>
        !!! note
        <p>Note that the full URL of the Yahoo endpoint of is <a href="https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22nome%2C%20ak%22)&amp;format=json&amp;env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys">https://query.yahooapis.com/v1/public/yql? <strong>q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22nome%2C%20ak%22)</strong> &amp;format=json&amp;env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys</a></p>
        <p>and we are extracting the query part (q=) from the endpoint highlighted and provide the zip code and country with concatenation using the get-property Xpath to create the full URL of the endpoint.</p>

    </div></td>
    </tr>
    <tr class="odd">
    <td>Property Scope</td>
    <td><div class="content-wrapper">
    <p>Synapse</p>
        !!! note
        <p>Since this is a mediation level Property keep the Property Scope as <strong>Synapse</strong> . This is the default scope set when no Property Scope is defined.</p>

    </div></td>
    </tr>
    </tbody>
    </table>

    ![](/assets/attachments/103332556/103332533.png)

14. Similarly, add another property mediator with the following values. This is an HTTP transport property that appends its value to the address endpoint URL. Once you are done, save the sequence.

    <table>
    <tbody>
    <tr class="odd">
    <td>Property Name</td>
    <td>New Property</td>
    </tr>
    <tr class="even">
    <td>New Property Name</td>
    <td>REST_URL_POSTFIX</td>
    </tr>
    <tr class="odd">
    <td>Value Type</td>
    <td>Expression</td>
    </tr>
    <tr class="even">
    <td>Value Expression</td>
    <td>get-property('YQL')</td>
    </tr>
    <tr class="odd">
    <td>Property Scope</td>
    <td><div class="content-wrapper">
    <p>Axis2</p>
        !!! note
        <p>Since this is a transport level Property you need to set the Property Scope as <strong>Axis2</strong> .</p>

    </div></td>
    </tr>
    </tbody>
    </table>

    ![](/assets/attachments/103332556/103332532.png)

15. Navigate to the **File** menu, and click **Save** to save the sequence.
16. Right-click on the sequence and click **Commit File** to push the changes to the Publisher server.

        !!! note
    Alternatively, you can create a CAR file including the sequences and can deploy it in API Manager. For more information, see [Deploying Composite Applications in the Server](https://docs.wso2.com/display/ADMIN44x/Deploying+Composite+Applications+in+the+Server) , which is in the WSO2 Administration Guide.


17. Sign in to the API Publisher again, select the API that you created earlier, and click the **Edit** link right next to its name to go to the edit wizard.
    ![](/assets/attachments/103332556/103332530.png)
18. Navigate to the API's **Implement** tab, select the **Enable Message Mediation** check box and select the sequence that you created for the In flow. Next, click **Manage** and **Save & Publish** the API again.

        !!! tip
    **Tip** : It might take a few minutes for the sequence to be uploaded into the API Publisher. If it isn't there, please check again later.


    ![](/assets/attachments/103332556/103332550.png)

        !!! note
    When selecting a mediator, make sure that it is a non-blocking mediator as blocking mediators are not supported in API Gateway custom mediations. For more details, see [Adding Mediation Extensions](_Adding_Mediation_Extensions_) .


19. Sign in to the API Store, subscribe to the API that you just published, and generate the access tokens in order to invoke the API.
    ![](/assets/attachments/103332556/103332529.png)
20. Click the **API Console** tab of the API.
    It opens the integrated API Console using which you can invoke the API.
    ![](/assets/attachments/103332556/103332528.png)
21. Give the following values for the parameters and invoke the API. You can also give any other value of your choice.

    <table>
    <colgroup>
    <col width="50%" />
    <col width="50%" />
    </colgroup>
    <tbody>
    <tr class="odd">
    <td>country</td>
    <td><p>usa</p></td>
    </tr>
    <tr class="even">
    <td>zipcode</td>
    <td>95004</td>
    </tr>
    </tbody>
    </table>

    ![](/assets/attachments/103332556/103332549.png)
    Note the response that you get as a JSON object from Yahoo.

    ``` java
        {
          "query": {
            "count": 1,
            "created": "2017-05-04T12:49:03Z",
            "lang": "en-US",
            "results": {
              "channel": {
                "units": {
                  "distance": "mi",
                  "pressure": "in",
                  "speed": "mph",
                  "temperature": "F"
                },
                "title": "Yahoo! Weather - Aromas, CA, US",
                "link": "http://us.rd.yahoo.com/dailynews/rss/weather/Country__Country/*https://weather.yahoo.com/country/state/city-12797499/",
                "description": "Yahoo! Weather for Aromas, CA, US",
                "language": "en-us",
                "lastBuildDate": "Thu, 04 May 2017 05:49 AM PDT",
                "ttl": "60",
                "location": {
                  "city": "Aromas",
                  "country": "United States",
                  "region": " CA"
                },
                "wind": {
                  "chill": "50",
                  "direction": "245",
                  "speed": "4"
                },
                "atmosphere": {
                  "humidity": "98",
                  "pressure": "999.0",
                  "rising": "0",
                  "visibility": "7.5"
                },
                "astronomy": {
                  "sunrise": "6:9 am",
                  "sunset": "7:58 pm"
                },
                "image": {
                  "title": "Yahoo! Weather",
                  "width": "142",
                  "height": "18",
                  "link": "http://weather.yahoo.com",
                  "url": "http://l.yimg.com/a/i/brand/purplelogo//uh/us/news-wea.gif"
                },
                "item": {
                  "title": "Conditions for Aromas, CA, US at 05:00 AM PDT",
                  "lat": "36.878021",
                  "long": "-121.618973",
                  "link": "http://us.rd.yahoo.com/dailynews/rss/weather/Country__Country/*https://weather.yahoo.com/country/state/city-12797499/",
                  "pubDate": "Thu, 04 May 2017 05:00 AM PDT",
                  "condition": {
                    "code": "33",
                    "date": "Thu, 04 May 2017 05:00 AM PDT",
                    "temp": "51",
                    "text": "Mostly Clear"
                  },
                  "forecast": [
                    {
                      "code": "30",
                      "date": "04 May 2017",
                      "day": "Thu",
                      "high": "74",
                      "low": "55",
                      "text": "Partly Cloudy"
                    },
                    {
                      "code": "28",
                      "date": "05 May 2017",
                      "day": "Fri",
                      "high": "71",
                      "low": "53",
                      "text": "Mostly Cloudy"
                    },
                    {
                      "code": "30",
                      "date": "06 May 2017",
                      "day": "Sat",
                      "high": "65",
                      "low": "47",
                      "text": "Partly Cloudy"
                    },
                    {
                      "code": "12",
                      "date": "07 May 2017",
                      "day": "Sun",
                      "high": "62",
                      "low": "48",
                      "text": "Rain"
                    },
                    {
                      "code": "30",
                      "date": "08 May 2017",
                      "day": "Mon",
                      "high": "69",
                      "low": "46",
                      "text": "Partly Cloudy"
                    },
                    {
                      "code": "30",
                      "date": "09 May 2017",
                      "day": "Tue",
                      "high": "69",
                      "low": "48",
                      "text": "Partly Cloudy"
                    },
                    {
                      "code": "28",
                      "date": "10 May 2017",
                      "day": "Wed",
                      "high": "70",
                      "low": "52",
                      "text": "Mostly Cloudy"
                    },
                    {
                      "code": "30",
                      "date": "11 May 2017",
                      "day": "Thu",
                      "high": "72",
                      "low": "52",
                      "text": "Partly Cloudy"
                    },
                    {
                      "code": "30",
                      "date": "12 May 2017",
                      "day": "Fri",
                      "high": "72",
                      "low": "48",
                      "text": "Partly Cloudy"
                    },
                    {
                      "code": "34",
                      "date": "13 May 2017",
                      "day": "Sat",
                      "high": "71",
                      "low": "46",
                      "text": "Mostly Sunny"
                    }
                  ],
                  "description": "<![CDATA[<img src=\"http://l.yimg.com/a/i/us/we/52/33.gif\"/>\n<BR />\n<b>Current Conditions:</b>\n<BR />Mostly Clear\n<BR />\n<BR />\n<b>Forecast:</b>\n<BR /> Thu - Partly Cloudy. High: 74Low: 55\n<BR /> Fri - Mostly Cloudy. High: 71Low: 53\n<BR /> Sat - Partly Cloudy. High: 65Low: 47\n<BR /> Sun - Rain. High: 62Low: 48\n<BR /> Mon - Partly Cloudy. High: 69Low: 46\n<BR />\n<BR />\n<a href=\"http://us.rd.yahoo.com/dailynews/rss/weather/Country__Country/*https://weather.yahoo.com/country/state/city-12797499/\">Full Forecast at Yahoo! Weather</a>\n<BR />\n<BR />\n(provided by <a href=\"http://www.weather.com\" >The Weather Channel</a>)\n<BR />\n]]>",
                  "guid": {
                    "isPermaLink": "false"
                  }
                }
              }
            }
          }
        }
    ```

In this tutorial, you created a sequence to change the default mediation flow of API requests, deployed it in the API Gateway and invoked an API using the custom mediation flow.

!!! note
Please note that following mediators are not usable within custom sequences since they are not supported by API Gateway custom medications.

-   Call mediator in non-blocking mode
-   Send mediator


