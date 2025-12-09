# Configuring XSLT Mediation with Xalan

When Xalan is selected instead of Saxon for the XSLT message transformation, it does not support the `ends-with{% raw %}(){% endraw %}` function that was used in the XSLT transformation.

You may encounter an error similar to the following.

```
TID: {% raw %}[{% endraw %}36{% raw %}]{% endraw %} {% raw %}[{% endraw %}{% raw %}]{% endraw %} {% raw %}[{% endraw %}2021-06-08 21:41:47,551{% raw %}]{% endraw %} ERROR {% raw %}{{% endraw %}org.apache.synapse.mediators.transform.XSLTMediator{% raw %}}{% endraw %} - Fatal error occurred in stylesheet parsing. ; Line{% raw %}#:{% endraw %} 91; Column{% raw %}#:{% endraw %} 60
javax.xml.transform.TransformerException: Could not find function: ends-with
 at org.apache.xpath.compiler.XPathParser.error(XPathParser.java:610)
 at org.apache.xpath.compiler.XPathParser.FunctionCall(XPathParser.java:1507)
 at org.apache.xpath.compiler.XPathParser.PrimaryExpr(XPathParser.java:1446)
```

This issue can be resolved by using the below system parameter.

```
-Djavax.xml.transform.TransformerFactory=net.sf.saxon.TransformerFactoryImpl \
```
