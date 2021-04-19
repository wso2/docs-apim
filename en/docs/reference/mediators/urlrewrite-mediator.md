# URLRewrite Mediator

The **URLRewrite Mediator** is used to modify and transform the URL
values available in messages. This can be done by defining a rewrite
action for each fragment of a selected property value. Alternatively,
you can rewrite the entire URL string at once.

!!! info
    The URLRewrite mediator is a [content aware]({{base_path}}/reference/mediators/about-mediators/#classification-of-mediators) mediator.

## Syntax

``` xml
<rewrite [inProperty="string"] [outProperty="string"]>
    <rewriterule>
        <condition>
        ...
        </condition>?
        <action [type="append|prepend|replace|remove|set"] [value="string"]
          [xpath="xpath"] [fragment="protocol|host|port|path|query|ref|user|full"] [regex="regex"]>+
    </rewriterule>+
</rewrite>
```

## Configuration

The parameters available to configure the URL Rewrite mediator are as
follows.

<table>
<thead>
<tr class="header">
<th>Parameter Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><strong>In Property</strong></td>
<td>This parameter is used to enter property of which the value should be considered the input URL. The rewrite rules are applied to the value of the property entered in this parameter to generate the result URL. If no property is entered, the rewrite rules will be applied to the <code>             To            </code> header of the message.</td>
</tr>
<tr class="even">
<td><div class="content-wrapper">
<strong>Out Property</strong>
</div></td>
<td>This parameter is used to enter the property to which the transformations done via the rewrite rules should be applied. If no property is entered, the transformations will be applied to the <code>             To            </code> header of the message.</td>
</tr>
</tbody>
</table>

The Rewrite mediator applies the URL transformations by evaluating a set
of rules on the message. To add a rule to the mediator, click **Add
Rule** . The rewrite rule will be added to the mediator tree as a child
of the URLRewrite mediator.

Click `         URLRewriteRule        ` in the mediator to configure the
rewrite rule you added.

A rule can consist of one or more rewrite actions and an optional
condition. The **Condition** parameter is used to enter the optional
condition. If a condition is specified, it will be evaluated before the
rewrite actions, and the rewrite actions will be executed only if the
condition evaluates to `         true        `.

The parameters available to configure a rewrite action are as follows.

<table>
<thead>
<tr class="header">
<th>Parameter Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><strong>Action</strong></td>
<td><p>This parameter is used to specify the action to be performed by the rewrite action. Each rewrite action is performed on a fragment entered in the <strong>Fragment</strong> parameter. Possible values are as follows.</p>
<ul>
<li><strong>Replace</strong>: If this is selected, the existing <b>in property</b> value fragment will be replaced by the result value.</li>
<li><strong>Remove</strong>: If this is selected, the result value will be removed from the <b>in property</b> value fragment.</li>
<li><strong>Append</strong>: If this is selected, the result value will be added to the end of the <b>in property</b> value fragment.</li>
<li><strong>Prepend</strong>: If this is selected, the result value will be added to the beginning of the <b>in property</b> value fragment.</li>
<li><strong>Set</strong>: If this is selected, the result value will be set as the <b>in property</b> value fragment.</li>
</ul></td>
</tr>
<tr class="even">
<td><strong>Fragment</strong></td>
<td><div class="content-wrapper">
<p>The fragment of the <b>in property</b> (i.e. input URL) for which the rewrite action should be performed. The available fragments are as follows.</p>
<ul>
<li><strong>Protocol</strong> :</li>
<li><strong>Host</strong></li>
<li><strong>Port</strong></li>
<li><strong>Path</strong></li>
<li><strong>Query</strong></li>
<li><strong>Ref</strong></li>
<li><strong>User</strong></li>
<li><strong>Full</strong></li>
</ul><b>Note</b> that this breakdown is inline with the URI specification (RFC2396). URL rewrite mediator enables rewriting each of the above segments separately and finally combining them to get the final URL value. It also supports rewriting the entire URL string at once.
</div></td>
</tr>
<tr class="odd">
<td><strong>Option</strong></td>
<td><p>This parameter is used to define the result value of the rewrite action. Select one of the following.</p>
<ul>
<li><strong>Value</strong> : If this is selected, the result value would be a static value.</li>
<li><strong>Expression</strong> : If this is selected, the result value will be evaluated using an expression.</li>
</ul></td>
</tr>
<tr class="even">
<td><strong>Value/Expression</strong></td>
<td>This parameter is used to enter the result value of the URLRewrite mediator as a static value or an expression, depending on what you selected for the <strong>Option</strong> parameter.</td>
</tr>
<tr class="odd">
<td><strong>Namespace Editor</strong></td>
<td>You can click this link to add namespaces when you are providing an expression. Then the <strong>Namespace Editor</strong> panel would appear where you can provide any number of namespace prefixes and URLs used in the XPath expression.</td>
</tr>
<tr class="even">
<td><strong>Regex</strong></td>
<td>This parameter is used to specify which part of the <b>in property</b> value fragment should be replaced by the result value if you selected <code>Replace</code> for the <strong>Action</strong> parameter.</td>
</tr>
<tr class="odd">
<td><strong>Delete</strong></td>
<td>Click <strong>Delete</strong> in the relevant row to remove a rewrite action.</td>
</tr>
</tbody>
</table>

## Example

In this example, the URLRewrite mediator has a rewrite action, which replaces the value `         soap        ` with value `         services        ` in the fragment `         path        ` of
the input URL. Since no in property or an out  property is specified,
the `         To        ` header of the  request is both the input  to
which the rewrite rule is applied and the target where the result URL is
set. This configuration is typically used when the address URL of a
request contains the context `         soap        ` which needs to be
converted since all the services are deployed under a context named
`         services        ` in the Micro Integrator. Thus, the URL
`                   http://localhost:8280/soap/StockQuoteProxy1                 `
is rewritten as
`         http://localhost:8280/                   services                 `
`         /StockQuoteProxy1        ` to ensure that the requests
are successfully delivered to the server.

``` java
<rewrite>
    <rewriterule>
        <action type="replace" regex="soap" value="services" fragment="path" />
    </rewriterule>
</rewrite>
```
