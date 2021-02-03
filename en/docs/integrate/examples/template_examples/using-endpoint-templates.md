# Using Endpoint Templates

For example, let's say we have two address endpoints with the following hypothetical configurations:

```xml tab='Endpoint 1'
<endpoint name="ep1" xmlns="http://ws.apache.org/ns/synapse">
  <address uri="http://run.mocky.io/v3/8ca6aa42-ee0a-47a8-8007-e93abbb95b87">
    <suspendOnFailure>
      <errorCodes>10001,10002</errorCodes>
      <progressionFactor>1.0</progressionFactor>
    </suspendOnFailure>
    <markForSuspension>
      <retriesBeforeSuspension>5</retriesBeforeSuspension>
      <retryDelay>0</retryDelay>
    </markForSuspension>
  </address>
</endpoint>
```

```xml tab='Endpoint 2'
<endpoint name="ep2" xmlns="http://ws.apache.org/ns/synapse">
  <address uri="http://run.mocky.io/v3/c72a5cfd-871b-43fc-8202-54fa18097341">
    <suspendOnFailure>
      <errorCodes>10001,10003</errorCodes>
      <progressionFactor>2.0</progressionFactor>
    </suspendOnFailure>
    <markForSuspension>
      <retriesBeforeSuspension>3</retriesBeforeSuspension>
      <retryDelay>0</retryDelay>
    </markForSuspension>
  </address>
</endpoint>
```

Note that these two endpoints have different set of error codes and different progression factors for suspension. Furthermore, the number of retries is different between them. By defining an endpoint template, these two endpoints can be converged to a generalized form. This is illustrated in the following:

```
<template xmlns="http://ws.apache.org/ns/synapse" name="ep_template">
   <parameter name="name"/>
   <parameter name="uri"/>
   <parameter name="codes"/>
   <parameter name="factor"/>
   <parameter name="retries"/>
   <endpoint name="$name">
      <address uri="$uri">
         <suspendOnFailure>
            <errorCodes>$codes</errorCodes>
            <progressionFactor>$factor</progressionFactor>
         </suspendOnFailure>
         <markForSuspension>
            <retriesBeforeSuspension>$retries</retriesBeforeSuspension>
            <retryDelay>1</retryDelay>
         </markForSuspension>
      </address>
   </endpoint>
</template>
```

!!! Note
    - The endpoint template uses parameters as inputs. Hence, these parameters can be refered using the `$` prefix within the template. Unlike sequence templates, endpoint templates are always parameterized using `$` prefixed values (not XPath expressions). e.g., You can refer to a parameter named `codes` as `$codes`.
    - `$name` and `$uri` are default parameters that a template can use anywhere within the endpoint template (usually as parameters for endpoint name and address attributes).

The template is now complete. Therefore, you can use template endpoints to create two concrete endpoint instances with different parameter values for this scenario as shown below.

``` xml tab='Endpoint 1'
<endpoint name="ep1" template="ep_template" uri="http://run.mocky.io/v3/8ca6aa42-ee0a-47a8-8007-e93abbb95b87">
  <parameter name="codes" value="10001,10002"/>
  <parameter name="retries" value="2"/>
  <parameter name="factor" value="1.0"/>
</endpoint>
```

``` xml tab='Endpoint 2'
<endpoint name="ep2" template="ep_template" uri="http://run.mocky.io/v3/c72a5cfd-871b-43fc-8202-54fa18097341">
  <parameter name="codes" value="10001,10003"/>
  <parameter name="retries" value="3"/>
  <parameter name="factor" value="2.0"/>
</endpoint>
```
### Synapse configuration

In this example, the endpoint template is configured to invoke the endpoints based on the API invocation. According to this configuration, the endpoint name, URI, codes, retries, and factor are parameterized.

```xml tab='REST API'
<?xml version="1.0" encoding="UTF-8"?>
<api xmlns="http://ws.apache.org/ns/synapse"
     name="TestAPI"
     context="/test"
     version="1.0"
     version-type="context">
   <resource methods="GET" uri-template="/foo">
      <inSequence>
         <call>
            <endpoint template="ep_template"
                      uri="http://run.mocky.io/v3/8ca6aa42-ee0a-47a8-8007-e93abbb95b87">
               <parameter name="codes" value="10001,10002"/>
               <parameter name="retries" value="2"/>
               <parameter name="factor" value="1.0"/>
            </endpoint>
         </call>
         <respond/>
      </inSequence>
   </resource>
   <resource methods="GET" uri-template="/bar">
      <inSequence>
         <call>
            <endpoint template="ep_template"
                      uri="http://run.mocky.io/v3/c72a5cfd-871b-43fc-8202-54fa18097341">
               <parameter name="codes" value="10001,10003"/>
               <parameter name="retries" value="3"/>
               <parameter name="factor" value="2.0"/>
            </endpoint>
         </call>
         <respond/>
      </inSequence>
   </resource>
</api>
```

### Build and run

Create the artifacts:

1. [Set up WSO2 Integration Studio]({{base_path}}/integrate/develop/installing-wso2-integration-studio).
2. [Create an integration project]({{base_path}}/integrate/develop/create-integration-project) with an <b>ESB Configs</b> module and an <b>Composite Exporter</b>.
3. Create the [REST API]({{base_path}}/integrate/develop/creating-artifacts/creating-an-api) and [endpoint template]({{base_path}}/integrate/develop/creating-artifacts/creating-endpoint-templates) with the configurations given above.
4. [Deploy the artifacts]({{base_path}}/integrate/develop/deploy-artifacts) in your Micro Integrator.

### Invoke the API
1. Using REST client:
Invoke this REST API using the HTTP client in WSO2 Integration Studio.
See that the response from the backend is logged on the console.

2. Using CURL:

``` xml tab='Request'
curl -v http://localhost:8290/test/bar
```

``` xml tab='Response'
{
    "symbol": "foo"
}
```
