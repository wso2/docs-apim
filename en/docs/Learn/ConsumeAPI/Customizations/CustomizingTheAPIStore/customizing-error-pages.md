# Customizing error Pages

In API Manager store/publisher and admin webapps, **jaggery.conf** is the Jaggery configuration file specifies the application specific configurations. In that file we can find following code block which have configured the error pages.

|                                                                                                                                                                                                             |
|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `                 "errorPages"                ` `                 :                `                                                                                                                        
                                                                                                                                                                                                              
 `                ` `                 {                `                                                                                                                                                      
                                                                                                                                                                                                              
 `                ` `                 "401"                ` `                 :                ` `                 "/site/pages/error-pages/401.html"                ` `                 ,                `  
                                                                                                                                                                                                              
 `                ` `                 "403"                ` `                 :                ` `                 "/site/pages/error-pages/403.html"                ` `                 ,                `  
                                                                                                                                                                                                              
 `                ` `                 "404"                ` `                 :                ` `                 "/site/pages/error-pages/404.html"                ` `                 ,                `  
                                                                                                                                                                                                              
 `                ` `                 "500"                ` `                 :                ` `                 "/site/pages/error-pages/500.html"                `                                       
                                                                                                                                                                                                              
 `                ` `                 }                `                                                                                                                                                      |

If such a specified error occurs due to an operation or page redirection inthe web application, it redirects to the specified html page. As an example, if you request for <https://localhost:9443/store/site/conf.site.json,> it gives a 403 response, it serves the html page site/pages/error-pages/403.html specified above.

<table>
<colgroup>
<col width="100%" />
</colgroup>
<tbody>
<tr class="odd">
<td><div class="container" title="Hint: double-click to select code">
<div class="line number1 index0 alt2">
<code class="java plain">                 &lt;html&gt;                </code>
</div>
<div class="line number2 index1 alt1">
<code class="java spaces">                </code> <code class="java plain">                 &lt;head&gt;                </code>
</div>
<div class="line number3 index2 alt2">
<code class="java spaces">                </code> <code class="java plain">                 &lt;/head&gt;                </code>
</div>
<div class="line number4 index3 alt1">

</div>
<div class="line number5 index4 alt2">
<code class="java spaces">                </code> <code class="java plain">                 &lt;body&gt;                </code>
</div>
<div class="line number6 index5 alt1">
<code class="java spaces">                </code> <code class="java plain">                 &lt;h2&gt;Error                </code> <code class="java value">                 403                </code> <code class="java plain">                 : Forbidden&lt;/h2&gt;                </code>
</div>
<div class="line number7 index6 alt2">
<code class="java spaces">                </code> <code class="java plain">                 &lt;br/&gt;                </code>
</div>
<div class="line number8 index7 alt1">
<code class="java spaces">                </code> <code class="java plain">                 &lt;p&gt;                </code>
</div>
<div class="line number9 index8 alt2">
<code class="java spaces">                </code> <code class="java plain">                 &lt;h4&gt;You don't have permission to access anything with that kind of request.  &lt;/h4&gt;                </code>
</div>
<div class="line number10 index9 alt1">
<code class="java spaces">                </code> <code class="java plain">                 &lt;/body&gt;                </code>
</div>
<div class="line number11 index10 alt2">
<code class="java plain">                 &lt;/html&gt;                </code>
</div>
</div></td>
</tr>
</tbody>
</table>

These error pages are located in &lt;API-M\_HOME&gt;/repository/deployment/server/jaggeryapps/store/site/pages/error-pages directory. You can customize these html pages according to your preference (adding css, javasccript or jquery functionalities).  And also you can create your own html pages to be viewed for errors occured by adding it to the jaggery.conf.


