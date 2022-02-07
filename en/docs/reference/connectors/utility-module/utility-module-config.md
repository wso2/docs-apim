# Utility Module Reference

Utility Module in WSO2 Enterprise Integrator help to perform basic utility function such as math, string, date, and signature. The connecotr will conpute the result and save it to a property.

The following operations can be performed with this module.
## string.Length

You can use the string.Length to find out the length of a string.

### Operation details

<table>
<thead>
  <tr>
    <th>Name</th>
    <th>Parameter</th>
    <th>Value</th>
    <th>Description</th>
  </tr>
</thead>
<tbody>
  <tr>
    <td>Input String</td>
    <td>string</td>
    <td></td>
    <td>The string that length is needed. The string can contain any charcters. It will also consider whitespace characters for length</td>
  </tr>
  <tr>
    <td>Target Property</td>
    <td>target</td>
    <td>default value: "length"</td>
    <td>Specify the property name to which the result should be saved.</td>
  </tr>
</tbody>
</table>

### Sample configuration

Given below is a sample request.

  ```
  {"string":"utility module"}
  ```

A sample synapse configuration for the string.Length operation is shown below.

  ```xml
    <Utility.string.Length>
        <string>{json-eval($.string)}</string>
        <target>length</target>
    </Utility.string.Length>  
  ```

The following is the sample response, for the request given  above.

  ```
  length=14
  ```

## string.LowerCase

You can use the string.LowerCase to change the case of the string to lowercase.

### Operation details

<table>
<thead>
  <tr>
    <th>Name</th>
    <th>Parameter</th>
    <th>Value</th>
    <th>Description</th>
  </tr>
</thead>
<tbody>
  <tr>
    <td>Input String</td>
    <td>string</td>
    <td></td>
    <td>The string that need to be transformed to lowercase.</td>
  </tr>
  <tr>
    <td>Target Property</td>
    <td>target</td>
    <td>default value: "lower"</td>
    <td>Specify the property name to which the result should be saved.</td>
  </tr>
</tbody>
</table>

### Sample configuration

Given below is a sample request.

  ```
  {"string":"UTILITY MODULE"}
  ```

A sample synapse configuration for the string.LowerCase operation is shown below.

  ```xml
    <Utility.string.LowerCase>
      <string>json-eval($.string)</string>
      <target>lowercase</target>
    </Utility.string.LowerCase>
  ```

The following is the sample response, for the request given  above.

  ```
  lowercase="utility module"
  ```

## string.UpperCase

You can use the string.UpperCase to change the case of the string to uppercase.

### Operation details

<table>
<thead>
  <tr>
    <th>Name</th>
    <th>Parameter</th>
    <th>Value</th>
    <th>Description</th>
  </tr>
</thead>
<tbody>
  <tr>
    <td>Input String</td>
    <td>string</td>
    <td></td>
    <td>The string that need to be transformed to uppercase.</td>
  </tr>
  <tr>
    <td>Target Property</td>
    <td>target</td>
    <td>default value: "upper"</td>
    <td>Specify the property name to which the result should be saved.</td>
  </tr>
</tbody>
</table>

### Sample configuration

Given below is a sample request.

  ```
  {"string":"utility module"}
  ```

A sample synapse configuration for the string.UpperCase operation is shown below.

  ```xml
    <Utility.string.UpperCase>
      <string>json-eval($.string)</string>
      <target>uppercase</target>
    </Utility.string.UpperCase>
  ```

The following is the sample response, for the request given above.

  ```
  uppercase="UTILITY MODULE"
  ```

## string.RegexMatcher

You can use the string.RegexMatcher to check whether the given string is in the desired format. It returns true if the string matches with the regular expression.

### Operation details

<table>
<thead>
  <tr>
    <th>Name</th>
    <th>Parameter</th>
    <th>Value</th>
    <th>Description</th>
  </tr>
</thead>
<tbody>
  <tr>
    <td>Input String</td>
    <td>string</td>
    <td></td>
    <td>The string that need to be checked with the regular expression.</td>
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
    <td>Default value: "match"</td>
    <td>Specify the property name to which the result should be saved.</td>
  </tr>
</tbody>
</table>

### Sample configuration

Given below is a sample request.

  ```
  {"string":"utility module"}
  ```

A sample synapse configuration for the string.RegexMatcher operation is shown below.

  ```xml
    <Utility.string.RegexMatcher>
      <regex>u.*m.*e</regex>
      <string>json-eval($.string)</string>
      <target>isMatching</target>
    </Utility.string.RegexMatcher>
  ```

The following is the sample response, for the request given  above.

  ```
  isMatching="true"
  ```

## string.UUID

You can use the string.UpperCase to change the case of the string to uppercase.

### Operation details

<table>
<thead>
  <tr>
    <th>Name</th>
    <th>Parameter</th>
    <th>Value</th>
    <th>Description</th>
  </tr>
</thead>
<tbody>
  <tr>
    <td>Target Property</td>
    <td>target</td>
    <td>default value: "uuid"</td>
    <td>Specify the property name to which the generated random UUID should be saved.</td>
  </tr>
</tbody>
</table>

A sample synapse configuration for the string.UUID operation is shown below.

  ```xml
    <Utility.string.UUID>
      <target>uuid</target>
    </Utility.string.UUID>
  ```

The following is the sample response, for the request given  above.

  ```
  uuid="07801d34-bbaf-43aa-8d70-98b4ead1b198"
  ```

## date.GetDate

You can use the date.GetDate to get the current date and time in a preferred date format.

### Operation details

<table>
<thead>
  <tr>
    <th>Name</th>
    <th>Parameter</th>
    <th>Value</th>
    <th>Description</th>
  </tr>
</thead>
<tbody>
  <tr>
    <td>Date Format</td>
    <td>format</td>
    <td>default value:"yyyy-MM-dd HH:mm:ss"</td>
    <td>The format in which the date is needed. Refer to Java date format patterns.</td>
  </tr>
  <tr>
    <td>Target Property</td>
    <td>target</td>
    <td>Default value: "date"</td>
    <td>Specify the property name to which the current date should be saved.</td>
  </tr>
</tbody>
</table>

### Sample configuration

A sample synapse configuration for the date.GetDate operation is shown below.

  ```xml
    <Utility.date.GetDate>
      <format>yy/MM/dd HH:mm:ss</format>
      <target>date</target>
    </Utility.date.GetDate>
  ```

The following is the sample response, for the request given  above.

  ```
  date="22/02/01 08:32:40"
  ```

## math.GetRandomInt

You can use the math.GetRandomInt to get a random integer in a given range.

### Operation details

<table>
<thead>
  <tr>
    <th>Name</th>
    <th>Parameter</th>
    <th>Value</th>
    <th>Description</th>
  </tr>
</thead>
<tbody>
  <tr>
    <td>Lower Bound</td>
    <td>lowerBound</td>
    <td></td>
    <td>Lower bound for the random integer. If it is left blank, it will consider it as 0.</td>
  </tr>
  <tr>
    <td>Upper Bound</td>
    <td>upperBound</td>
    <td></td>
    <td>Upper bound for the random integer. If it is left as blank, it will consider it as infinity.</td>
  </tr>
  <tr>
    <td>Target Property</td>
    <td>target</td>
    <td>Default value: "random"</td>
    <td>Specify the property name to which the generated random integer should be saved.</td>
  </tr>
</tbody>
</table>

### Sample configuration

A sample synapse configuration for the math.GetRandomInt operation is shown below.

  ```xml
    <Utility.math.GetRandomInt>
      <lowerBound>100</lowerBound>
      <upperBound>1000</upperBound>
      <target>random</target>
    </Utility.math.GetRandomInt>
  ```

The following is the sample response, for the request given  above.

  ```
  random=785
  ```

## signature.Generate

You can use the signature.Generate to generate a HMAC signature for the payload of the request.

### Operation details

<table>
<thead>
  <tr>
    <th>Name</th>
    <th>Parameter</th>
    <th>Value</th>
    <th>Description</th>
  </tr>
</thead>
<tbody>
  <tr>
    <td>Payload</td>
    <td>payload</td>
    <td>default value: Body</td>
    <td>Dropdown menu to select whether the payload is from the body of the request or a custom payload.<br/>The HTTP MIME types that are supported are, <br/>"application/json",<br/>"application/xml",<br/>"text/plain"</td>
  </tr>
  <tr>
    <td>Custom Payload</td>
    <td>customPayload</td>
    <td></td>
    <td>The field to enter a custom payload when payload is selected as "Custom Payload".</td>
  </tr>
  <tr>
    <td>Secret</td>
    <td>secret</td>
    <td></td>
    <td>The secret used to genearte signature for the paylaod using an algorithm.</td>
  </tr>
  <tr>
    <td>Algorithm</td>
    <td>algorithm</td>
    <td>default value: "HMACSHA1"</td>
    <td>The algorithm that is used to genearte the signature.<br/>The following algorithms are supported,<br/>"HMACSHA1",<br/>"HMACSHA256",<br/>"HMACSHA384",<br/>"HMACSHA512",<br/>"HMACMD5" </td>
  </tr>
  <tr>
    <td>Target Property</td>
    <td>target</td>
    <td>Default value: "sign"</td>
    <td>Specify the property name to which the signature should be saved.</td>
  </tr>
</tbody>
</table>

### Sample configuration

Given below is a sample request.

  ```
  {"string":"utility module"}
  ```

A sample synapse configuration for the signature.Generate operation is shown below.

  ```xml
    <Utility.signature.Generate>
      <payload>Body</payload>
      <secret>123</secret>
      <algorithm>HMACSHA1</algorithm>
      <target>signature</target>
    </Utility.signature.Generate>
  ```

The following is the sample response, for the request given  above.

  ```
  signature="32423411140bdebed0b017e738797be452481dbb"
  ```

## signature.Verify

You can use the signature.Generate to generate a HMAC signature for the payload of the request.

### Operation details

<table>
<thead>
  <tr>
    <th>Name</th>
    <th>Parameter</th>
    <th>Value</th>
    <th>Description</th>
  </tr>
</thead>
<tbody>
  <tr>
    <td>Payload</td>
    <td>payload</td>
    <td>default value: Body</td>
    <td>Dropdown menu to select whether the payload is from the body of the request or a custom payload.<br/>The HTTP MIME types that are supported are, <br/>"application/json",<br/>"application/xml",<br/>"text/plain"</td>
  </tr>
  <tr>
    <td>Signature</td>
    <td>signature</td>
    <td></td>
    <td>The field to enter a custom payload when payload is selected as "Custom Payload".</td>
  </tr>
  <tr>
    <td>Secret</td>
    <td>secret</td>
    <td></td>
    <td>The secret used to genearte signature for the paylaod using an algorithm.</td>
  </tr>
  <tr>
    <td>Algorithm</td>
    <td>algorithm</td>
    <td>default value: "HMACSHA1"</td>
    <td>The algorithm that is used to genearte the signature.<br/>The following algorithms are supported,<br/>"HMACSHA1",<br/>"HMACSHA256",<br/>"HMACSHA384",<br/>"HMACSHA512",<br/>"HMACMD5" </td>
  </tr>
  <tr>
    <td>Target Property</td>
    <td>target</td>
    <td>Default value: "verify"</td>
    <td>Specify the property name to which the signature should be saved.</td>
  </tr>
</tbody>
</table>

### Sample configuration

Given below is a sample request.

  ```
  {"string":"utility module"}
  ```

A sample synapse configuration for the signature.Verify operation is shown below.

  ```xml
    <Utility.signature.Verify>
      <payload>Body</payload>
      <signature>32423411140bdebed0b017e738797be452481dbb</signature>
      <secret>123</secret>
      <algorithm>HMACSHA1</algorithm>
      <target>verify</target>
    </Utility.signature.Verify>
  ```

The following is the sample response, for the request given  above.

  ```
  verify="true"
  ```