# Utility Module Reference

The Utility Module in WSO2 Enterprise Integrator helps to perform basic utility functions such as math, string, date, and signature. The connector will compute the result and save it to a property.

The following operations can be performed with this module.

## string.Length

You can use the `string.Length` operation to retrieve the length of a string.

### Operation details

<table>
<thead>
  <tr>
    <th><b>Name</b></th>
    <th><b>Parameter</b></th>
    <th><b>Default Value</b></th>
    <th><b>Description</b></th>
  </tr>
</thead>
<tbody>
  <tr>
    <td>Input String</td>
    <td>inputString</td>
    <td></td>
    <td>The string for which you need to identify the length. The string can contain any characters. It will also consider whitespace characters when calculating the length.</td>
  </tr>
  <tr>
    <td>Target Property</td>
    <td>target</td>
    <td><code>length</code></td>
    <td>Specify the property name to which the result should be saved.</td>
  </tr>
</tbody>
</table>

### Sample configuration

The following is a sample request, Synapse configuration, and response for the given request.

``` tab="Request"
{"string":"utility module"}
```

```xml tab="Synapse Configuration"
<utility.string.Length>
    <inpuString>{json-eval($.string)}</inputString>
    <target>length</target>
</utility.string.Length>  
```

``` tab="Request"
length=14
```

## string.LowerCase

You can use the `string.LowerCase` operation to change the case of the string to lowercase.

### Operation details

<table>
<thead>
  <tr>
    <th><b>Name</b></th>
    <th><b>Parameter</b></th>
    <th><b>Default Value</b></th>
    <th><b>Description</b></th>
  </tr>
</thead>
<tbody>
  <tr>
    <td>Input String</td>
    <td>inputString</td>
    <td></td>
    <td>The string that needs to be transformed to lowercase.</td>
  </tr>
  <tr>
    <td>Target Property</td>
    <td>target</td>
    <td><code>lower</code></td>
    <td>Specify the property name to which the result should be saved.</td>
  </tr>
</tbody>
</table>

### Sample configuration

The following is a sample request, Synapse configuration, and response for the given request.

``` tab="Request"
{"string":"UTILITY MODULE"}
```

```xml tab="Synapse Configuration"
<utility.string.LowerCase>
  <inputString>json-eval($.string)</inputString>
  <target>lowercase</target>
</utility.string.LowerCase>
```

``` tab="Request"
lowercase="utility module"
```

## string.UpperCase

You can use the `string.UpperCase` operation to change the case of the string to uppercase.

### Operation details

<table>
<thead>
  <tr>
    <th><b>Name</b></th>
    <th><b>Parameter</b></th>
    <th><b>Default Value</b></th>
    <th><b>Description</b></th>
  </tr>
</thead>
<tbody>
  <tr>
    <td>Input String</td>
    <td>inputString</td>
    <td></td>
    <td>The string that needs to be transformed to uppercase.</td>
  </tr>
  <tr>
    <td>Target Property</td>
    <td>target</td>
    <td><code>upper</code></td>
    <td>Specify the property name to which the result should be saved.</td>
  </tr>
</tbody>
</table>

### Sample configuration

The following is a sample request, Synapse configuration, and response for the given request.

``` tab="Request"
{"string":"utility module"}
```

```xml tab="Synapse Configuration"
<utility.string.UpperCase>
  <inputString>json-eval($.string)</inputString>
  <target>uppercase</target>
</utility.string.UpperCase>
```

``` tab="Request"
uppercase="UTILITY MODULE"
```

## string.RegexMatcher

You can use the `string.RegexMatcher` operation to check whether the given string is in the desired format. It returns true if the string matches with the regular expression (Regex).

### Operation details

<table>
<thead>
  <tr>
    <th><b>Name</b></th>
    <th><b>Parameter</b></th>
    <th><b>Default Value</b></th>
    <th><b>Description</b></th>
  </tr>
</thead>
<tbody>
  <tr>
    <td>Input String</td>
    <td>inputString</td>
    <td></td>
    <td>The string that needs to be checked with the regular expression.</td>
  </tr>
  <tr>
    <td>Regular Expression</td>
    <td>regex</td>
    <td></td>
    <td>The regular expression of the desired string.</td>
  </tr>
  <tr>
    <td>Target Property</td>
    <td>target</td>
    <td><code>match</code></td>
    <td>Specify the property name to which the result should be saved.</td>
  </tr>
</tbody>
</table>

### Sample configuration

The following is a sample request, Synapse configuration, and response for the given request.

``` tab="Request"
{"string":"utility module"}
```

```xml tab="Synapse Configuration"
<utility.string.RegexMatcher>
  <regex>u.*m.*e</regex>
  <inputString>json-eval($.string)</inputString>
  <target>isMatching</target>
</utility.string.RegexMatcher>
```

``` tab="Request"
isMatching="true"
```

## string.UUID

You can use the `string.UUID` operation to generate a random UUID.

### Operation details

<table>
<thead>
  <tr>
    <th><b>Name</b></th>
    <th><b>Parameter</b></th>
    <th><b>Default Value</b></th>
    <th><b>Description</b></th>
  </tr>
</thead>
<tbody>
  <tr>
    <td>Target Property</td>
    <td>target</td>
    <td><code>uuid</code></td>
    <td>Specify the property name to which the generated random UUID should be saved.</td>
  </tr>
</tbody>
</table>

### Sample configuration

The following is a sample configuration and response.

```xml tab="Synapse Configuration"
<utility.string.UUID>
  <target>uuid</target>
</utility.string.UUID>
```

``` tab="Request"
uuid="07801d34-bbaf-43aa-8d70-98b4ead1b198"
```

## date.GetDate

You can use the `date.GetDate` operation to get the current date and time in a preferred date format.

### Operation details

<table>
<thead>
  <tr>
    <th><b>Name</b></th>
    <th><b>Parameter</b></th>
    <th><b>Default Value</b></th>
    <th><b>Description</b></th>
  </tr>
</thead>
<tbody>
  <tr>
    <td>Date Format</td>
    <td>format</td>
    <td>default value:<code>yyyy-MM-dd HH:mm:ss</code></td>
    <td>The format in which the date is needed. Refer to Java date format patterns.</td>
  </tr>
  <tr>
    <td>Target Property</td>
    <td>target</td>
    <td><code>date</code></td>
    <td>Specify the property name to which the current date should be saved.</td>
  </tr>
</tbody>
</table>

### Sample configuration

The following is a sample Synapse configuration and response.

```xml tab="Synapse Configuration"
<utility.date.GetDate>
  <format>yy/MM/dd HH:mm:ss</format>
  <target>date</target>
</utility.date.GetDate>
```

``` tab="Request"
date="22/02/01 08:32:40"
```

## math.GetRandomInt

You can use the `math.GetRandomInt` operation to get a random integer in a given range.

### Operation details

<table>
<thead>
  <tr>
    <th><b>Name</b></th>
    <th><b>Parameter</b></th>
    <th><b>Default Value</b></th>
    <th><b>Description</b></th>
  </tr>
</thead>
<tbody>
  <tr>
    <td>Lower Bound</td>
    <td>lowerBound</td>
    <td></td>
    <td>Lower bound for the random integer. If it is kept blank, the lower bound will be considered as 0.</td>
  </tr>
  <tr>
    <td>Upper Bound</td>
    <td>upperBound</td>
    <td></td>
    <td>Upper bound for the random integer. If it is kept blank, it will consider the upper bound as infinity.</td>
  </tr>
  <tr>
    <td>Target Property</td>
    <td>target</td>
    <td><code>random</code></td>
    <td>Specify the property name to which the generated random integer should be saved.</td>
  </tr>
</tbody>
</table>

### Sample configuration

The following is a sample Synapse configuration and response.

```xml tab="Synapse Configuration"
<utility.math.GetRandomInt>
  <lowerBound>100</lowerBound>
  <upperBound>1000</upperBound>
  <target>random</target>
</utility.math.GetRandomInt>
```

``` tab="Request"
random=785
```

## signature.Generate

You can use the `signature.Generate` operation to generate a HMAC signature for the payload of the request.

### Operation details

<table>
<thead>
  <tr>
    <th><b>Name</b></th>
    <th><b>Parameter</b></th>
    <th><b>Default Value</b></th>
    <th><b>Description</b></th>
  </tr>
</thead>
<tbody>
  <tr>
    <td>Payload</td>
    <td>payload</td>
    <td><code>Body</code></td>
    <td>Dropdown menu to select whether the payload is from the body of the request or a custom payload.<br/>The following are the supported HTTP MIME types. <br/><code>application/json</code><br/><code>application/xml</code><br/><code>text/plain</code></td>
  </tr>
  <tr>
    <td>Custom Payload</td>
    <td>customPayload</td>
    <td></td>
    <td>The field to enter a custom payload when the payload is selected as <code>Custom Payload</code>.</td>
  </tr>
  <tr>
    <td>Secret</td>
    <td>secret</td>
    <td></td>
    <td>The secret used to generate the signature for the payload using an algorithm.</td>
  </tr>
  <tr>
    <td>Algorithm</td>
    <td>algorithm</td>
    <td><code>HMACSHA1</code></td>
    <td>The algorithm that is used to generate the signature.<br/>The following are the supported algorithms:<br/><code>HMACSHA1</code><br/><code>HMACSHA256</code><br/><code>HMACSHA384</code><br/><code>HMACSHA512</code><br/><code>HMACMD5</code></td>
  </tr>
  <tr>
    <td>Target Property</td>
    <td>target</td>
    <td><code>sign</code></td>
    <td>Specify the property name to which the signature should be saved.</td>
  </tr>
</tbody>
</table>

### Sample configuration

The following is a sample request, Synapse configuration, and response for the given request.

``` tab="Request"
{"string":"utility module"}
```

```xml tab="Synapse Configuration"
<utility.signature.Generate>
  <payload>Body</payload>
  <secret>123</secret>
  <algorithm>HMACSHA1</algorithm>
  <target>signature</target>
</utility.signature.Generate>
```

``` tab="Request"
signature="32423411140bdebed0b017e738797be452481dbb"
```

## signature.Verify

You can use the `signature.Verify` operation to verify the payload using the HMAC signature in the header of the request. Thereby, this is used to ensure that the payload is not modified.

### Operation details

<table>
<thead>
  <tr>
    <th><b>Name</b></th>
    <th><b>Parameter</b></th>
    <th><b>Default Value</b></th>
    <th><b>Description</b></th>
  </tr>
</thead>
<tbody>
  <tr>
    <td>Payload</td>
    <td>payload</td>
    <td><code>Body</code></td>
    <td>Dropdown menu to select whether the payload is from the body of the request or a custom payload.<br/>The following are the supported HTTP MIME types. <br/><code>application/json</code><br/><code>application/xml</code><br/><code>text/plain</code></td>
  </tr>
  <tr>
    <td>Custom Payload</td>
    <td>customPayload</td>
    <td></td>
    <td>The field to enter a custom payload when the payload is selected as <code>Custom Payload</code>.</td>
  </tr>
  <tr>
    <td>Signature</td>
    <td>signature</td>
    <td></td>
    <td>The HMAC signature of the payload.</td>
  </tr>
  <tr>
    <td>Secret</td>
    <td>secret</td>
    <td></td>
    <td>The secret used to generate the signature for the payload using an algorithm.</td>
  </tr>
  <tr>
    <td>Algorithm</td>
    <td>algorithm</td>
    <td><code>HMACSHA1</code></td>
    <td>The algorithm that is used to genearte the signature.<br/>The following algorithms are supported,<br/><code>HMACSHA1</code><br/><code>HMACSHA256</code><br/><code>HMACSHA384</code><br/><code>HMACSHA512</code><br/><code>HMACMD5</code></td>
  </tr>
  <tr>
    <td>Target Property</td>
    <td>target</td>
    <td><code>verify</code></td>
    <td>Specify the property name to which the signature should be saved.</td>
  </tr>
</tbody>
</table>

### Sample configuration

The following is a sample request, Synapse configuration, and response for the given request.

``` tab="Request"
{"string":"utility module"}
```

```xml tab="Synapse Configuration"
<utility.signature.Verify>
  <payload>Body</payload>
  <signature>32423411140bdebed0b017e738797be452481dbb</signature>
  <secret>123</secret>
  <algorithm>HMACSHA1</algorithm>
  <target>verify</target>
</utility.signature.Verify>
```

``` tab="Request"
verify="true"
```
